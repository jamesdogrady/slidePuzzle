*** Settings ***
Documentation     slidePuzzle.
Library           Process

*** Test Cases ***
Puzzle can be solved in 6 moves
	Run Process   ./slidePuzzle  -x  2  -y  2  B  3  2  1  alias=myproc
	${result}=  Get Process Result   myproc
	Should Be Equal  ${result.rc}  ${0}
	Should Contain  ${result.stdout}  Solution Found
	Should Contain  ${result.stdout}  6

Puzzle cannot be solved 
	Run Process   ./slidePuzzle  -x  2  -y  2  B  3  1  2  alias=myproc
	${result}=  Get Process Result   myproc
	Should Be Equal  ${result.rc}  ${0}
	Should Contain  ${result.stdout}  No Solution Found

too many parameters
	Run Process   ./slidePuzzle  -x  2  -y  2  1  2  B  3  4  alias=myproc
	${result}=  Get Process Result   myproc
	Should Be Equal  ${result.rc}  ${1}
	Should Contain  ${result.stderr}  Too many values for puzzle

too few parameters
	Run Process   ./slidePuzzle  -x  2  -y  2  1    B    alias=myproc
	${result}=  Get Process Result   myproc
	Should Be Equal  ${result.rc}  ${1}
	Should Contain  ${result.stderr}  2 not specified

Duplicate parameters
	Run Process   ./slidePuzzle  -x  2  -y  2  1   1  3  B    alias=myproc
	${result}=  Get Process Result   myproc
	Should Be Equal  ${result.rc}  ${1}
	Should Contain  ${result.stderr}  1 specified twice

No blank
	Run Process   ./slidePuzzle  -x  2  -y  2  1   3  2  4    alias=myproc
	${result}=  Get Process Result   myproc
	Should Be Equal  ${result.rc}  ${1}
	Should Contain  ${result.stderr}  Value too Large

No blank 2
	Run Process   ./slidePuzzle  -x  2  -y  2  1   3  2  5    alias=myproc
	${result}=  Get Process Result   myproc
	Should Be Equal  ${result.rc}  ${1}
	Should Contain  ${result.stderr}  Value too Large

Duplicate blank
	Run Process   ./slidePuzzle  -x  2  -y  2  B  1  B  2  3    alias=myproc
	${result}=  Get Process Result   myproc
	Should Be Equal  ${result.rc}  ${1}
	Should Contain  ${result.stderr}  Blank specified twice
