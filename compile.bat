@echo off 
set project_name=CH552USB
set xram_size=0x0800
set xram_loc=0x0600
set code_size=0xEFFF
set dfreq_sys=48000000

if not exist "config.h" echo //add your personal defines here > config.h


Rem SDCC\bin\sdcc -c -V -mmcs51 --model-large --xram-size %xram_size% --xram-loc %xram_loc% --code-size %code_size% -I/ -DFREQ_SYS=%dfreq_sys%  ftdi.c
Rem SDCC\bin\sdcc -c -V -mmcs51 --model-large --xram-size %xram_size% --xram-loc %xram_loc% --code-size %code_size% -I/ -DFREQ_SYS=%dfreq_sys%  Debug.c

SDCC\bin\sdcc -c -V -mmcs51 --model-small --xram-size 0x0400 --xram-loc 0x0000 --code-size 0x37FF ftdi.c
SDCC\bin\sdcc -c -V -mmcs51 --model-small --xram-size 0x0400 --xram-loc 0x0000 --code-size 0x37FF Debug.c


Rem sdcc -c -V -mmcs51 --model-small --xram-size 0x0400 --xram-loc 0x0000 --code-size 0x37FF -I../../include -DFREQ_SYS=12000000 main.c
Rem + /usr/bin/sdcpp -nostdinc -Wall -I../../include -DFREQ_SYS=12000000 -obj-ext=.rel -D__SDCC_MODEL_SMALL -D__SDCC_FLOAT_REENT -D__SDCC=3_5_0 -DSDCC=350 -D__SDCC_REVISION=9253 -D__SDCC_mcs51 -D__STDC_NO_COMPLEX__ -D__STDC_NO_THREADS__ -D__STDC_NO_ATOMICS__ -D__STDC_NO_VLA__ -isystem /usr/bin/../share/sdcc/include/mcs51 -isystem /usr/share/sdcc/include/mcs51 -isystem /usr/bin/../share/sdcc/include -isystem /usr/share/sdcc/include  main.c 
Rem + /usr/bin/sdas8051 -plosgffw main.rel main.asm
Rem sdcc main.rel -V -mmcs51 --model-small --xram-size 0x0400 --xram-loc 0x0000 --code-size 0x37FF -I../../include -DFREQ_SYS=12000000 -o blink.ihx
Rem + /usr/bin/sdld -nf blink.lk



goto exit
SDCC\bin\sdcc ftdi.rel Debug.rel -V -mmcs51 --model-large --xram-size %xram_size% --xram-loc %xram_loc% --code-size %code_size% -I/ -DFREQ_SYS=%dfreq_sys%  -o %project_name%.ihx

SDCC\bin\packihx %project_name%.ihx > %project_name%.hex

SDCC\bin\hex2bin -c %project_name%.hex

del %project_name%.lk
del %project_name%.map
del %project_name%.mem
del %project_name%.ihx

del *.asm
del *.lst
del *.rel
del *.rst
del *.sym

:exit
