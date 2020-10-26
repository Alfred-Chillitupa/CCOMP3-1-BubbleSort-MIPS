# ################
.text 								# aqui comienzan a definirse las instrucciones
	
	.globl __start
		__start : # aqui comienzan sus instrucciones
		
		
		lw $s0, size		
		mul $s0, $s0, 4		
		
		la $t0, lista # i
		la $s3, lista #j
		add $s1, $t0, $s0 # puntero central para i
		add $s2, $t0, $s0 #puntero para j
		addi $t1, $t0 , 0
		
		la $a0, str1
		li $v0, 4
		syscall
		
		jal printArray
		
		la $a0, endl
		li $v0, 4
		syscall
		
		la $a0, str2
		li $v0, 4
		syscall
		
		
		
		for_i:
			beq $t0,$s1,endfor_i
			
			addi $t1, $s3 , 0 # j = 0
			addi $s2,$s2,-4
			for_j:
				beq $t1,$s2,endfor_j
				
				lw $t2,0($t1) # lista[ j ]
				lw $t3,4($t1) # lista[ j+ ] 
				
				slt $t4, $t2, $t3
				beqz $t4,else
				
				#swap
				sw $t2,4($t1)
				sw $t3,0($t1)
						
				else:
				addi $t1,$t1,4
				j for_j
			endfor_j:
			
			addi $t0,$t0,4
			
			j for_i
		endfor_i:
		
		la $a0, endl
		li $v0, 4
		syscall
		
		la $a0, str3
		li $v0, 4
		syscall
		
		
		jal printArray
		
		# aqui finalizan sus instrucciones
 li $v0 ,10
 syscall # servicio de finalizar programa
 		
 		printArray:
 		addi $t2, $zero, 0
		
			loop:
				beq $t2, $s0, end
				lw $t3, lista($t2)
				addi $t2, $t2, 4
		
				li $v0, 1
				move $a0, $t3
				syscall
		
				la $a0,space
				li $v0,4
				syscall
		
				j loop
			end:
 		jr $ra
 		
.data # aqui comienzan a definirse las variables

	lista: .word 2 , 0 , 3 , 6, 12 , 5 # que define lista de valores a ordenar.
	size: .word 6 # cantidad de valores en la lista
	
	str1: .asciiz "Lista desordenada: "
	str2: .asciiz "Ordenando lista ...."
	str3: .asciiz "Lista ordenada de mayor a menor: "
	space: .asciiz "  "
	endl: .asciiz "\n" 

# ################
