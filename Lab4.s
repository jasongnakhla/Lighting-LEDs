				GLOBAL	Reset_Handler			;Labeling instruction
				AREA	mycode, CODE, Readonly	;Making the code a code and read only memory
Reset_Handler
												;PINSEL0 is a control register and is 32-bit long
PINSEL0			EQU		0xE002C000				;pin function selection for port 0 (#0=GPIO)
IO0DIR			EQU		0xE0028008				;Sets directions for port 0 (0=input, 1=output)
IO0PIN			EQU		0xE0028000				;GPIO Port pin to designate value for port (0=0, 1=1)
	
				MOV		R0,#0					;Setting the pin to function as GPIO
				LDR		R1,=PINSEL0
				STR		R0,[R1]					;Storing it at Pin Select Port 0's address

				MOV		R0,#0X0000FF00			;Setting P0.8-p0.15 to be the output pins from the microcontroller
				LDR		R1,=IO0DIR				;(P0.8-P0.15 are the LED pins
				STR		R0,[R1]					;Storing it in OI Direction's address

			
				;Task 1																							
				MOV		R0,#0X00000000			;Setting P0.8-P0.15 to be 0
				LDR		R1,=IO0PIN				;P0.8-P0.15 are the LED pins
				STR		R0,[R1]					;Storing it in IO Direction's address
				
				;Delay
				LDR 	R2,=389375				;;Move the decimal number 389375 (random) into Register R2. Needed a big number for longer delay
delay1			SUBS	R2,R2,#1				;Subtract the value in R2 by 1 and move it back to R2
				BNE		delay1					;This branch wil stop iff the value of the label 'delay1' is 0. 
												;If it is not 0 then it branches back to the the address of delay1 
												;and reruns the instruction until the value is 0
				
				;Task 2
				MOV		R0,#0X0000FF00			;Setting P0.8-P0.15 to be 1
				LDR		R1,=IO0PIN				;P0.8-P0.15 LEDs will be turned off
				STR		R0,[R1]					;Storing it in IO value of pin
				
				;Delay
				LDR 	R2,=389375				;Load in a mathematical value in Register 2
delay2			SUBS	R2,R2,#1				;Subtract the value in R2 by 1 and move it back to R2
				BNE		delay2					;This branch wil stop iff the value of the label 'delay1' is 0.
												;If it is not 0 then it branches back to the the address of delay1 
												;and reruns the instruction until the value is 0
				
				;Task 3
				MOV		R0,#0X00005500			;Setting P0.8, P0.10, P0.12, and P0.14 to be 0
				LDR		R1,=IO0PIN				;This will light every other LED starting from P0.0
				STR		R0,[R1]					;Storing it in IO Value of Pin

stop			B		stop
				END