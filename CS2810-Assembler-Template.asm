TITLE CS2810 Assembler Template

; Student Name:
; Assignment Due Date:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester byte "Fall Semester 2023",0
	vTitle byte "Assembler Assignment #5",0
	vName byte "Jake Ildefonso",0

	vPrompt byte "Enter number between 1 and 100:",0
	vReplayPrompt byte "Would you like to play again? (1 for yes, 0 for no): ",0

	vValue byte "  ",0 ;actual value goes in here
	vCorrect byte " is correct!",0
	vTooLow byte " is too low",0
	vTooHigh byte " is too high",0

	vCarriageReturn byte 13,10,0 ;sets cursor on next line

.code
main PROC
	;--------- Enter Code Below Here

	;initialize random values
	call Randomize

	call displayHeader; display header before game
	call game; do game logic
	call replay; ask if they want to play again

	displayHeader:
		;semester part
		mov dh, 4
		mov dl, 0
		call gotoxy
		mov edx, offset vSemester
		call WriteString

		;assignment part
		mov dh, 5
		mov dl, 0
		call gotoxy
		mov edx, offset vTitle
		call WriteString

		;name part
		mov dh, 6
		mov dl, 0
		call gotoxy
		mov edx, offset vName
		call WriteString
		ret;

	ReplayGame:
		call Clrscr
	game:
		;first, set up random number
		mov eax, 100
		call RandomRange
		add eax, 1; shifts range from 0-99 to 1-100
		mov ebx, eax ;move the randomly generated number to EBX register, to store

		;writes decimal to terminal
		;call writeDec

		mov dh, 8
		mov dl, 0
		call gotoxy

	LoopThis:
		;input
		mov edx, offset vPrompt
		call WriteString
		call ReadDec
		;--------------------------------------------------------------
		;eax holds input numbers
		;ebx should hold game number

		;edx is the register for output
		;use JZ for correct answer, JL for too low, and JG for too high
		;--------------------------------------------------------------

		cmp eax, ebx
		jz Equal

		cmp eax, ebx
		jl tooLow

		cmp eax, ebx
		jg tooHigh

;---------------------

	tooHigh:
		call WriteDec

		mov edx, offset vTooHigh
		call WriteString
		mov edx, offset vCarriageReturn
		call WriteString
		jmp LoopThis
	tooLow:
		call WriteDec

		mov edx, offset vTooLow
		call WriteString
		mov edx, offset vCarriageReturn
		call WriteString
		jmp LoopThis

;---------------------
	Equal:
		call WriteDec
		mov edx, offset vCorrect
		call WriteString
		call Replay
	Replay:
		mov edx, offset vCarriageReturn
		call WriteString
		mov edx, offset vReplayPrompt
		call WriteString
		call ReadDec
		cmp eax, 1
		jz replayGame

		;if not 1, then zero. No comparison needed.
		exit
	exit
main ENDP

END main