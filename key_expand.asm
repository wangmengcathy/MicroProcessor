-- $1 for s[i], $2 for L[j] --
-- $3 for a, $4 for b --
-- $11 for i, $12 for j --
ADDI $30, $0, 32
ADDI $29, $0, 78
ADDI $28, $0, 26

-- Loop Start --
LW $1, 0($11)
ADD $1, $1, $3
ADD $1, $1, $4
ADD $5, $0, $1
ADDI $6, $0, 3
SHL $5, $5, 1 
SUBI $6, $6, 1
BNE $6, $0, -3 // shift s[i]+a+b left by 3 bits
ADDI $6, $0, 3
SHR $1, $1, 1 
ADDI $6, $6, 1
BNE $6, $30, -3 // shift s[i]+a+b right by 29 bits
OR $1, $1, $5 // left rotate s[i]+a+b by 3 bits
SW $1, 0($11) // store s[i]
ADD $3, $0, $1 // set a

LW $2, 0($12)
ADD $2, $2, $3
ADD $2, $2, $4
ADD $5, $0, $2
ADD $6, $3, $4
SHL $5, $5, 1 
SUBI $6, $6, 1
BNE $6, $0, -3 // shift l[i]+a+b left by a+b bits
ADD $6, $3, $4
SHR $1, $1, 1 
ADDI $6, $6, 1
BNE $6, $30, -3 // shift l[i]+a+b right by 32-a-b bits
OR $2, $2, $5 // left rotate l[i]+a+b by a+b bits
SW $2, 0($12) // store l[j]
ADD $4, $0, $2 // set b

-- (i+1) mod 26 --
ADDI $11, $11, 1
BLT $11, $28, 1
SUB $11, $11, $28
-- (j+1) mod 4 --
ADDI $12, $12, 1
ANDI $12, $12, 3

ADD $27, $0, 1
BNE $27, $29, -37
-- Loop End --