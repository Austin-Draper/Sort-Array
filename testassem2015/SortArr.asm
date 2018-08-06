TITLE Sort Array              (SortArr.asm)
;Austin Draper
;4/5/16
;VISUAL STUDIO 2015	
;This program will use a loop and indexed addressing 
;to sort the elements of an array from lowest to highest. 
INCLUDE Irvine32.inc

.data
Array          BYTE 20, 10, 60, 5, 120, 90, 100, 7, 25, 12
.code
main PROC
    ;Sort Array
    mov esi, offset Array
    mov ecx, 10
    call FindMin

    mov edi, offset Array
    mov ecx, 10
    call SelectionSort

	mov esi, OFFSET Array
	mov ecx, LENGTHOF Array
	mov ebx, TYPE Array
	call DumpMem					                       ;See the results in Array
	call WaitMsg

	exit
main ENDP


;Loop until value in edi smaller than value in esi
FindMin PROC
	mov edi, esi
	add edi, 1                                             ;edi one space further than esi in Array

MinIndex:
    mov bl, [esi]
    cmp bl, [edi]
    ja Skip                                                ;jump to Skip if value in edi is above bl
    mov edi, esi                                           ;otherwise, move esi into edi and go to Skip

Skip: 
    inc edi                                                ;make edi one value above esi again
    loop MinIndex                                          ;loop back to MinIndex again
    ret

FindMin ENDP


;Sort the array from lowest to highest value
SelectionSort PROC
	dec ecx
    mov ebx, edi
    mov edx, ecx                                           ;store ecx in edx for later use

OuterLoop:
    mov edi, ebx
    mov esi, ebx
    inc esi
    push ecx                                               ;put ecx on stack for later use
    mov ecx, edx                                           ;regain old ecx stored in edx

InnerLoop:
    mov al, [esi]
    cmp al, [edi]
    inc esi
    inc edi
    ja NoSwap
    call Swap

NoSwap:
    loop InnerLoop
    pop ecx                                                ;pop ecx on stack to use in OuterLoop
    loop OuterLoop
    ret

SelectionSort ENDP


;Swap the values in esi and edi
Swap PROC
	;dec esi         using dec esi and edi works for all but one value.
	;dec edi         0C goes into the wrong space.
    mov al, [esi -1] ;al represents low-order 8 bits of the register
    mov ah, [edi -1] ;ah represents high-order 8 bits of the register
    mov [esi -1], ah
    mov [edi -1], al
    ret
Swap ENDP


END main