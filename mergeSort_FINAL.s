.global _start
	.equ MAXN, 200
	.text
_start:
	//R0-> Inicio
	//R1-> Fin
	//R4-> Medio
	MOV R0, #0
	LDR R1, =N
	LDR R1, [R1, #0]
	SUB R1, R1, #1
	MOV R4, #0
	MOV SP, #0
	BL mergeSort
Finish:
	b Finish
mergeSort:
	CMP R0, R1
	BGE ELSE
IF:
	SUB R4, R1, R0
	LSR R4, R4, #1
	ADD R4, R4, R0
	PUSH {R0, R1, R4, LR}
	MOV R1, R4
	BL mergeSort
	POP {R0, R1, R4, LR}
	PUSH {R0, R1, R4, LR}
	ADD R0, R4, #1
	BL mergeSort
	POP {R0, R1, R4, LR}
	B FUSE
CONTINUE:
	MOV PC, LR
	
ELSE:
	MOV PC, LR

FUSE:
	//int i,j,k;
    //int tam1 = mitad-inicio +1;
    //int tam2 = fin-mitad;
	//R5-> Tamaño 1
	//R6-> Tamaño 2
	//R8, R9, R10-> Temp
	MOV R8, #0
	MOV R9, #0
	MOV R10, #0
	SUB R5, R4, R0
	ADD R5, #1
	SUB R6, R1, R4
FOR1:
	//for(i=0;i<tam1;i++){
    //	L[i] = A[inicio+i];
    //}
	//R10->i
	LDR R8,=LISTA1
	LDR R9,=Data
	ADD R11, R0, R10
	MOV R12, #4
	MUL R11, R11, R12
	LDR R9, [R9, R11]
	MUL R11, R10, R12
	STR	R9, [R8, R11]
	ADD R10, R10, #1
	CMP R10, R5
	BLT FOR1
	MOV R8, #0
	MOV R9, #0
	MOV R10, #0
FOR2:
	//for(j=0;j<tam2;j++){
    //    R[j] = A[mitad+j+1];
    //}
	//R10->j
	LDR R8,=LISTA2
	LDR R9,=Data
	ADD R11, R4, R10
	ADD R11, R11, #1
	MOV R12, #4
	MUL R11, R11, R12
	LDR R9, [R9, R11]
	MUL R11, R10, R12
	STR	R9, [R8, R11]
	ADD R10, R10, #1
	CMP R10, R5
	BLT FOR2
	
	//i=0;
    //j=0;
    //k=inicio;
	MOV R8, #0 //R8->i
	MOV R9, #0 //R9->j
	MOV R10, R0 //R10->Inicio
	
	//while(i<tam1 && j<tam2){
    //    if(L[i]<=R[j]){
    //        A[k] = L[i];
    //        i++;
    //    }else{
    //        A[k] = R[j];
    //        j++;
    //    }
    //    k++;
    //}
	//R5-> Tamaño 1
	//R6-> Tamaño 2
	
WHILE1:
	CMP R8, R5
	BGE WHILE1END
	CMP R9, R6
	BGE WHILE1END
	LDR R11, =LISTA1
	MOV R12, #4
	MUL R12, R12, R8
	LDR R11, [R11, R12]
	MOV R12, #4
	MUL R12, R12, R9
	LDR R3, =LISTA2
	LDR R3, [R3, R12]
	CMP R11, R3
	BGT ELSE2
IF2:
	//A[k] = L[i];
    //      i++;
	LDR R11, =LISTA1
	MOV R12, #4
	MUL R12, R12, R8
	LDR R11, [R11, R12] //L[i]
	LDR R3, =Data
	MOV R12, #4
	MUL R12, R12, R10
	STR R11, [R3, R12]
	ADD R8, #1
	ADD R10, #1
	B WHILE1
ELSE2:
	//A[k] = R[j];
    //      j++;
	LDR R11, =LISTA2
	MOV R12, #4
	MUL R12, R12, R9
	LDR R11, [R11, R12] //R[j]
	LDR R3, =Data
	MOV R12, #4
	MUL R12, R12, R10
	STR R11, [R3, R12]
	ADD R9, #1
	ADD R10, #1
	B WHILE1

WHILE1END:

	//while(i<tam1){
	//  A[k] = L[i];
	//	i++;
	//	k++;
	//}
	//R8->i
	//R9->j
	//R5-> Tamaño 1
	//R6-> Tamaño 2
WHILE2:
	CMP R8, R5
	BGE WHILE2END
	LDR R11, =LISTA1
	MOV R12, #4
	MUL R12, R12, R8
	LDR R11, [R11, R12] //L[i]
	LDR R3, =Data
	MOV R12, #4
	MUL R12, R12, R10
	STR R11, [R3, R12]
	ADD R8, #1
	ADD R10, #1
	B WHILE2
WHILE2END:
	//while(j<tam2){
    //    A[k] = R[j];
    //    j++;
    //    k++;
    //}
WHILE3:
	CMP R9, R6
	BGE WHILE3END
	LDR R11, =LISTA2
	MOV R12, #4
	MUL R12, R12, R9
	LDR R11, [R11, R12] //R[j]
	LDR R3, =Data
	MOV R12, #4
	MUL R12, R12, R10
	STR R11, [R3, R12]
	ADD R9, #1
	ADD R10, #1
	B WHILE3
WHILE3END:
	b CONTINUE
	.data
N: .dc.l 11
Data: .dc.l -2, 43, 564, 12, 43, -13, 312, 54, -76, 132, 11
SortedData: .ds.l MAXN
LISTA1: .ds.l MAXN
LISTA2: .ds.l MAXN
	
	