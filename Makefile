#Yostex OS file making rules
#Added @ Version 0.0.1
#Author Chirs Yost @2022.02.13

MAKEFLAGS = -sR
MKDIR = mkdir
RMDIR = rmdir
CP = cp
CD = cd
DD = dd
RM = rm

ASM		= nasm
CC		= gcc
LD		= ld
OBJCOPY	= objcopy

ASMBFLAGS	= -f elf -w-orphan-labels
CFLAGS		= -c -Os -std=c99 -m32 -Wall -Wshadow -W -Wconversion -Wno-sign-conversion  -fno-stack-protector -fomit-frame-pointer -fno-builtin -fno-common  -ffreestanding  -Wno-unused-parameter -Wunused-variable
LDFLAGS		= -s -static -T link.lds -n -Map Yostex.map 
OJCYFLAGS	= -S -O binary

Yostex_OBJS :=
Yostex_OBJS += entry.o main.o vgastr.o
Yostex_ELF = Yostex.elf
Yostex_BIN = Yostex.bin

.PHONY : build clean all link bin

all: clean build link bin

build: $(Yostex_OBJS)

link: $(Yostex_ELF)
$(Yostex_ELF): $(Yostex_OBJS)
	$(LD) $(LDFLAGS) -o $@ $(Yostex_OBJS)
bin: $(Yostex_BIN)
$(Yostex_BIN): $(Yostex_ELF)
	$(OBJCOPY) $(OJCYFLAGS) $< $@

%.o : %.asm
	$(ASM) $(ASMBFLAGS) -o $@ $<
%.o : %.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) -f *.o *.bin *.elf
