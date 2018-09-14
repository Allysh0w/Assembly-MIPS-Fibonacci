.data
msg1:.asciiz "Informe um numero: "
.text
.globl main
main:

li $v0,4
la $a0,msg1
syscall 		           #Chamada de sistema que imprime a msg1
li $v0,5
syscall 		           #ler o inteiro do teclado
add $a0,$v0,$zero        #adiciona para o a0

jal fib                               #chama a label fib

add $a0,$v0,$zero
li $v0,1
syscall

li $v0,10
syscall

fib:
#a0=y
#se (y==0) retorna 0;
#if (y==1) retorna 1;
#return( fib(y-1)+fib(y-2) );                    #equação de implementação do fibonacci recursivo

addi $sp,$sp,-12 #salva na pilha
sw $ra,0($sp)
sw $s0,4($sp)
sw $s1,8($sp)

add $s0,$a0,$zero

addi $t1,$zero,1
beq $s0,$zero,retorna0     #se y for igual a 0, pula para a label retorna0
beq $s0,$t1,retorna1	#se o y for igual a 1, pula para a label retorna 1

addi $a0,$s0,-1

jal fib

add $s1,$zero,$v0     #s1=fib(y-1)

addi $a0,$s0,-2

jal fib                            #v0=fib(n-2)

add $v0,$v0,$s1       #v0=fib(n-2)+$s1
fimfib:

lw $ra,0($sp)           #ler os registradores da pilha
lw $s0,4($sp)
lw $s1,8($sp)
addi $sp,$sp,12       #traz de volta o ponteiro da pilha
jr $ra

retorna1:
 li $v0,1
 j fimfib
retorna0 :     li $v0,0
 j fimfib
