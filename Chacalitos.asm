.data 
	tablero: .word 1,1,1,1,1,1,1,1,1,1,1,1
	casilla: .asciiz "|x|"
	descubierto: .asciiz "|0|" 
	chacales: .word 4
	dinero : .word 0
	chacalesEncontrados: .word 0
	intentos: .word 3
	tesoros: .word 4
	playerHasWon: .word 0
	mensajeSeguir: .asciiz "Presione ENTER para continuar... \n"
	mensajeSeguirJugando: .asciiz "¿Quieres seguir jugando? Presione 1 (Si) o 0 (No) "
	mensajeError: .asciiz "Ingresaste un valor invalido. \n"
	posicionRevelada: .asciiz "La posicion revelada es: "
	mensajeChacales: .asciiz "¡Has encontrado un chacal!"
	mensajeTesoro: .asciiz "¡Has encontrado un tesoro!"
	mensajeRepetido: .asciiz "¡Ya has descubierto esa casilla!"
	mensajeDinero: .asciiz "Dinero: "
	mensajeNumeroChacales: .asciiz " Chacales Encontrados: "
	mensajeIntentos: .asciiz " Intento: "
	mensajeCongrats: .asciiz "¡Felicidades! has ganado: "
	perderChacales: .asciiz "¡Perdiste! Has encontrado todos los chacales."
	perderIntentos: .asciiz "¡Perdiste! Se te han acabado los intentos."
	ganarTesoros: .asciiz "¡Has encontrado todos los tesoros!"
	jl: .asciiz "\n"
	buffer: .space 4
.text 
.globl main
.globl randomNumber
.globl loadChacales
.globl printArray
.globl printTablero
.globl reveal

main:
	la $s0, tablero
	
	jal loadChacales
	
	move $a0, $s0
	li $a1, 12 
	
	jal printArray
	
	lw $s1, chacales
	lw $s2, dinero
	lw $s3, intentos
	lw $s4, tesoros
	lw $s5, playerHasWon
	lw $s6, chacalesEncontrados
	
	whileJuego:
	move $a0, $s0 
	li $a1, 12
	beq $s1, $zero, lostByChacales
	beq $s3, $zero, lostByIntentos	
	beq $s4, $zero, wonByTesoros
	
	jal printTablero
	
	jal randomNumber
	move $t0, $v0
	
	li $v0, 4
	la $a0, posicionRevelada
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall 
	
	li $v0, 4
	la $a0, jl
	syscall
	
	move $a2, $t0
	
	move $a0, $s0 
	
	jal reveal
	move $t0, $v0 
	
	li $t2, 1
	li $t3, 2
	
	beq $t0, $zero, chacal
	beq $t0, $t2, tesoro
	beq $t0, $t3, intento
	
		tesoro:
		li $s3, 3
		addi $s4, $s4, -1
		li $v0, 4
		la $a0, mensajeTesoro
		addi $s2, $s2, 100
		syscall
		bne $s5, $zero, seguirJugando
		j nextRound
		
		chacal:
		li $s3, 3
		addi $s1, $s1, -1
		li $v0, 4
		la $a0, mensajeChacales
		addi $s6, $s6, 1
		syscall
		j nextRound
		
		intento:
		addi $s3, $s3, -1
		li $v0, 4
		la $a0, mensajeRepetido
		syscall
		j nextRound
		
	lostByChacales:
	li $v0, 4
	la $a0, perderChacales
	syscall
	j exitGame
	
	lostByIntentos:
	li $v0, 4
	la $a0, perderIntentos
	syscall
	j exitGame
	
	wonByTesoros:
	li $v0, 4
	la $a0, ganarTesoros
	syscall

	bne $s5, $zero, congrats
	addi $s5, $s5, 1 #playerHasWon = 1
	
	addi $s4, $s4, 4
	
	seguirJugando:
	li $v0, 4
	la $a0, mensajeSeguirJugando
	syscall
	
	validacion:
   	#lee como  cadena
    	li $v0, 8           
    	la $a0, buffer
    	li $a1, 4           
    	syscall

   
    	la $t3, buffer      
    	lb $t2, 0($t3)     
    	
	#valida que no sea string
    	li $t1, 48          
    	li $t4, 57          
    	blt $t2, $t1, errorNoNumerico  
    	bgt $t2, $t4, errorNoNumerico  

    
    	sub $t0, $t2, $t1  

   	 # Validar el valor numérico
    	li $t1, 0
    	li $t4, 1
    	beq $t0, $t1, congrats
    	beq $t0, $t4, nextRound


	errorNoNumerico:
    	li $v0, 4
    	la $a0, mensajeError
    	syscall
    	j seguirJugando

	error:
    	li $v0, 4
    	la $a0, mensajeError
    	syscall
    	j seguirJugando
	
	congrats:
	
	li $v0, 4
	la $a0, mensajeCongrats
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	  
	j exitGame
		
	nextRound:
	li $v0, 4
	la $a0, jl
	syscall
	j whileJuego
	
	exitGame:
		
	li $v0, 10
	syscall
	
	randomNumber:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $a1, 4($sp)

	li $a1, 13 
	li $v0, 42
	syscall
	
	move $v0, $a0
	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	addi $sp, $sp, 8
	
	jr $ra
	
	loadChacales:

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 4 #numero de chacales
	
	whileChacales:
	beq $t0, $zero, exitWhileChacales
	jal randomNumber # $v0 = random.random(0,12)
	
	move $t1, $v0
	
	sll $t1, $t1, 2
	la $t3, tablero
	add $t1, $t1, $t3
	
	lw $t2, 0($t1)
	
	beq $t2, $zero, continueWhileChacales
	sw $zero, 0($t1)
	addi $t0, $t0, -1
	
	# while ($t0 > 0) {
	#	$t1 = randomNumber();
	#	if (array[$t1] == 1) {
	#		array[$t1] = 0;
	#		$t0 -= 1;
	#	}
	# }
	
	continueWhileChacales:
	j whileChacales
	
	exitWhileChacales:
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
printArray: #a0 -> array base, #a1 -> array size
	addi $sp, $sp, -4
	sw $a0, 0($sp)

	move $t2, $a0
	
	li $t0, 0 #index = 0
	printArrayFor: #for (int i = 0; i < n; i++) {print(array[i]) }
	slt $t1, $t0, $a1 # t0 < a1
	beq $t1, $zero, exitPrintArrayFor

	sll $t3, $t0, 2
	add $t3, $t3, $t2

	li $v0, 1
	lw $a0, 0($t3)
	syscall 
	
	li $v0, 4
	la $a0, jl
	syscall
	
	addi $t0, $t0, 1
	
	j printArrayFor
	
	exitPrintArrayFor:
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
	printTablero: #a0 -> array base, #a1 -> array size
	addi $sp, $sp, -4
	sw $a0, 0($sp)

	move $t2, $a0
	
	li $t0, 0 #index = 0
	li $t5, 1
	
	printTableroFor:	
	slt $t1, $t0, $a1 # i < n
	beq $t1, $zero, exitPrintTableroFor
	
	sll $t1, $t0, 2
	add $t1, $t1, $t2
	
	lw $t1, 0($t1)
	slti $t1, $t1, 2
	bne $t1, $zero, printCasilla 
	
	li $v0, 4
	la $a0, descubierto
	syscall
	
	j addOnePrintTablero
	
	printCasilla:
	li $v0, 4
	la $a0, casilla
	syscall
	
	addOnePrintTablero:
	
	addi $t0, $t0, 1
	
	j printTableroFor
	
	exitPrintTableroFor:
	
	li $v0, 4
	la $a0, jl
	syscall
	
	la $a0, mensajeDinero
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 4
	la $a0, mensajeIntentos
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 4
    	la $a0, mensajeNumeroChacales
    	syscall
    
   	li $v0, 1
    	move $a0, $s6
    	syscall
	
	li $v0, 4
	la $a0, jl
	syscall
	
	li $v0, 4
	la $a0, mensajeSeguir
	syscall
	
	li $v0, 8  # syscall para leer una cadena
    	la $a0, buffer
    	li $a1, 2  # Leer hasta 2 caracteres (incluyendo Enter)
    	syscall
	
	li $v0, 4
	la $a0, jl
	syscall
	
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
reveal: #$a0 -> array base, $a1 -> array size, $a2 -> revealed index
	
	sll $t0, $a2, 2
	add $t0, $a0, $t0
	
	lw $t1, 0($t0)
	li $t3, 2
	sw $t3, 0($t0)
		
	move $v0, $t1
	
	jr $ra 
	
	
	
	
