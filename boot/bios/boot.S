	.code16
	.text
	.global start
start:
	ljmp $0x0, $start0
start0:
	movw $0, %ax
	movw %ax, %ds
	movw %ax, %ss

	movw $0x7c00, %sp
	addw $0x0400, %sp

	movw $0xb800, %ax
	movw %ax, %es
	movw $0, %di
	movw $data, %si
	movw size, %cx
	call memcpy

loop:	jmp loop

memcpy:
	testw %cx, %cx
	je out
	
memloop:
	movb (%si), %ah
	movb %ah, %es:(%di)
	incw %si
	incw %di
	decw %cx
	jne memloop
out:
	ret

data:
	.asciz "H\017e\014l\057l\017o\017!\017"
size:
	.short . -data

