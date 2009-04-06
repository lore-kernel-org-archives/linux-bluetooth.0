Return-Path: <cyrus@holtmann.org>
Message-ID: <49DA7205.3090005@pook.es>
Date: Mon, 06 Apr 2009 23:20:05 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: Stuart Pook <linux-bluetooth4@pook.es>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez 4.34 + Linksys USBBT100 + hcitool scan -> core dump
References: <49D89DCD.7090808@pook.es> <20090405171936.GA6612@jh-x301>
In-Reply-To: <20090405171936.GA6612@jh-x301>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Johan

On 05/04/09 19:19, Johan Hedberg wrote:
> On Sun, Apr 05, 2009, Stuart Pook wrote:
>> I have a Linksys (Cisco) USBBT100 Bluetooth 1.1 Adapter which has a 1.2 dBi
>> antenna. I used to use it with Bluez 3 and it had a better range than my
>> Belkin F8T017. It used to work (but not for audio) with older versions of
>> bluez 4. I tried it again with bluez 4.34 and now a simple "hcitool scan"
>> makes bluetoothd core dump.

> Could you try and see if
> this is reproducable with the latest git? You don't necessarily need to install
> it, just compile with "./bootstrap-configure && make" and run the compiled
> bluetoothd directly from the tree.

It appears that you need to run ./src/.libs/bluetoothd with valgrind. This is with the latest version from git.

It didn't crash with "hcitool scan" but rather when I tried to open an audio device or run obexftp. I have never managed to open an audio device or run obexftp using my USBBT100. bluetoothd always crashes. I have no problems when I use my F8T017.

: root; valgrind ./src/.libs/bluetoothd -dn
==15350== Memcheck, a memory error detector.
==15350== Copyright (C) 2002-2008, and GNU GPL'd, by Julian Seward et al.
==15350== Using LibVEX rev 1884, a library for dynamic binary translation.
==15350== Copyright (C) 2004-2008, and GNU GPL'd, by OpenWorks LLP.
==15350== Using valgrind-3.4.1-Debian, a dynamic binary instrumentation framework.
==15350== Copyright (C) 2000-2008, and GNU GPL'd, by Julian Seward et al.
==15350== For more details, rerun with: -v
==15350== 
bluetoothd[15350]: Bluetooth daemon 4.34
bluetoothd[15350]: Enabling debug information
bluetoothd[15350]: parsing main.conf
bluetoothd[15350]: discovto=0
bluetoothd[15350]: Key file does not have key 'PairableTimeout'
bluetoothd[15350]: pageto=8192
bluetoothd[15350]: name=%h-%d
bluetoothd[15350]: class=0x000100
bluetoothd[15350]: inqmode=0
bluetoothd[15350]: Key file does not have key 'InitiallyPowered'
bluetoothd[15350]: Key file does not have key 'RememberPowered'
bluetoothd[15350]: Key file does not have key 'DeviceID'
bluetoothd[15350]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[15350]: Starting SDP server
bluetoothd[15350]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[15350]: register_interface: path /org/bluez/15350/any
bluetoothd[15350]: Registered interface org.bluez.Service on path /org/bluez/15350/any
bluetoothd[15350]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[15350]: Unix socket created: 11
bluetoothd[15350]: Telephony plugin initialized
bluetoothd[15350]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[15350]: HCI dev 0 registered
bluetoothd[15350]: child 15352 forked
bluetoothd[15350]: HCI dev 0 already up
bluetoothd[15350]: Starting security manager 0
bluetoothd[15350]: periodic_inquiry_exit at adapter startup
bluetoothd[15350]: register_interface: path /org/bluez/15350/hci0
bluetoothd[15350]: Registered interface org.bluez.Service on path /org/bluez/15350/hci0
bluetoothd[15350]: headset_server_probe: path /org/bluez/15350/hci0
bluetoothd[15350]: Adding record with handle 0x10000
bluetoothd[15350]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[15350]: Adding record with handle 0x10001
bluetoothd[15350]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[15350]: a2dp_server_probe: path /org/bluez/15350/hci0
bluetoothd[15350]: SEP 0x4b527b8 registered: type:0 codec:0 seid:1
bluetoothd[15350]: Adding record with handle 0x10002
bluetoothd[15350]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[15350]: avrcp_server_probe: path /org/bluez/15350/hci0
bluetoothd[15350]: Adding record with handle 0x10003
bluetoothd[15350]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[15350]: Adding record with handle 0x10004
bluetoothd[15350]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15350]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[15350]: Creating device /org/bluez/15350/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15350]: Probe drivers for /org/bluez/15350/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15350]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[15350]: Registered interface org.bluez.Audio on path /org/bluez/15350/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15350]: Found Headset record
bluetoothd[15350]: Discovered Headset service on RFCOMM channel 2
bluetoothd[15350]: Registered interface org.bluez.Headset on path /org/bluez/15350/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15350]: Found Handsfree record
bluetoothd[15350]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[15350]: Creating device /org/bluez/15350/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[15350]: Creating device /org/bluez/15350/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[15350]: Creating device /org/bluez/15350/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[15350]: Creating device /org/bluez/15350/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[15350]: Creating device /org/bluez/15350/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[15350]: Creating device /org/bluez/15350/hci0/dev_00_03_89_FE_E6_19
bluetoothd[15350]: Creating device /org/bluez/15350/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[15350]: Creating device /org/bluez/15350/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[15350]: Creating device /org/bluez/15350/hci0/dev_00_17_E5_16_88_6C
bluetoothd[15350]: Creating device /org/bluez/15350/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[15350]: Changing service classes to 0x480104
==15350== Syscall param ioctl(generic) points to unaddressable byte(s)
==15350==    at 0x40007F2: (within /lib/ld-2.9.so)
==15350==    by 0x123C7E: adapter_start (adapter.c:2191)
==15350==    by 0x11F0BD: manager_start_adapter (manager.c:520)
==15350==    by 0x1124E2: device_devup_setup (main.c:502)
==15350==    by 0x112649: init_all_devices (main.c:537)
==15350==    by 0x112F13: main (main.c:779)
==15350==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
bluetoothd[15352]: Can't set link policy on hci0: No such device (19)
==15352== Syscall param ioctl(generic) points to unaddressable byte(s)
==15352==    at 0x40007F2: (within /lib/ld-2.9.so)
==15352==    by 0x11244C: device_devreg_setup (main.c:484)
==15352==    by 0x112617: init_all_devices (main.c:534)
==15352==    by 0x112F13: main (main.c:779)
==15352==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
bluetoothd[15350]: Adapter /org/bluez/15350/hci0 has been enabled
bluetoothd[15350]: Stopping security manager 0
bluetoothd[15350]: Changing service classes to 0x480104
==15352== 
==15352== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 63 from 3)
==15352== malloc/free: in use at exit: 29,244 bytes in 329 blocks.
==15352== malloc/free: 641 allocs, 312 frees, 250,227 bytes allocated.
==15352== For counts of detected errors, rerun with: -v
==15352== searching for pointers to 329 not-freed blocks.
==15352== checked 114,812 bytes.
==15352== 
==15352== LEAK SUMMARY:
==15352==    definitely lost: 0 bytes in 0 blocks.
==15352==      possibly lost: 744 bytes in 3 blocks.
==15352==    still reachable: 28,500 bytes in 326 blocks.
==15352==         suppressed: 0 bytes in 0 blocks.
==15352== Rerun with --leak-check=full to see details of leaked memory.
bluetoothd[15350]: Can't write class of device: Unknown error 4294967186 (-110)
bluetoothd[15350]: Entering main loop
bluetoothd[15350]: child 15352 exited
bluetoothd[15350]: HCI dev 0 down
bluetoothd[15350]: Adapter /org/bluez/15350/hci0 has been disabled
bluetoothd[15350]: HCI dev 0 up
bluetoothd[15350]: Starting security manager 0

==15350== Stack overflow in thread 1: can't grow stack to 0xbe447fcc
==15350== 
==15350== Process terminating with default action of signal 11 (SIGSEGV): dumping core
==15350==  Access not within mapped region at address 0xBE447FCC
==15350==    at 0x4A1B3BA: __xstat (in /lib/i686/cmov/libc-2.9.so)
==15350==  If you believe this happened as a result of a stack overflow in your
==15350==  program's main thread (unlikely but possible), you can try to increase
==15350==  the size of the main thread stack using the --main-stacksize= flag.
==15350==  The main thread stack size used in this run was 8388608.
==15350== Stack overflow in thread 1: can't grow stack to 0xbe447fc8
==15350== 
==15350== Process terminating with default action of signal 11 (SIGSEGV)
==15350==  Access not within mapped region at address 0xBE447FC8
==15350==    at 0x48203EC: _vgnU_freeres (vg_preloaded.c:56)
==15350==  If you believe this happened as a result of a stack overflow in your
==15350==  program's main thread (unlikely but possible), you can try to increase
==15350==  the size of the main thread stack using the --main-stacksize= flag.
==15350==  The main thread stack size used in this run was 8388608.
==15350== 
==15350== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 63 from 3)
==15350== malloc/free: in use at exit: 45,177 bytes in 680 blocks.
==15350== malloc/free: 263,627 allocs, 262,947 frees, 1,855,386 bytes allocated.
==15350== For counts of detected errors, rerun with: -v
==15350== searching for pointers to 680 not-freed blocks.
==15350== checked 5,710,988 bytes.
==15350== 
==15350== LEAK SUMMARY:
==15350==    definitely lost: 0 bytes in 0 blocks.
==15350==      possibly lost: 744 bytes in 3 blocks.
==15350==    still reachable: 44,433 bytes in 677 blocks.
==15350==         suppressed: 0 bytes in 0 blocks.
==15350== Rerun with --leak-check=full to see details of leaked memory.
Segmentation fault

This time "hcitool scan" did crash bluetoothd. It has been a long time since I last used gdb. Is there something I should do to get a better backtrace?

: root;  gdb ./src/.libs/bluetoothd
GNU gdb 6.8-debian
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i486-linux-gnu"...
(gdb) handle SIG33 pass nostop noprint
Signal        Stop	Print	Pass to program	Description
SIG33         No	No	Yes		Real-time event 33
(gdb) set pagination 0
(gdb) run -dn
Starting program: /disks/cleartext/stuart/install/bluez/git/bluez/src/.libs/bluetoothd -dn
bluetoothd[15533]: Bluetooth daemon 4.34
bluetoothd[15533]: Enabling debug information
bluetoothd[15533]: parsing main.conf
bluetoothd[15533]: discovto=0
bluetoothd[15533]: Key file does not have key 'PairableTimeout'
bluetoothd[15533]: pageto=8192
bluetoothd[15533]: name=%h-%d
bluetoothd[15533]: class=0x000100
bluetoothd[15533]: inqmode=0
bluetoothd[15533]: Key file does not have key 'InitiallyPowered'
bluetoothd[15533]: Key file does not have key 'RememberPowered'
bluetoothd[15533]: Key file does not have key 'DeviceID'
bluetoothd[15533]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[15533]: Starting SDP server
bluetoothd[15533]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[15533]: register_interface: path /org/bluez/15533/any
bluetoothd[15533]: Registered interface org.bluez.Service on path /org/bluez/15533/any
bluetoothd[15533]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[15533]: Unix socket created: 13
bluetoothd[15533]: Telephony plugin initialized
bluetoothd[15533]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[15533]: HCI dev 0 registered
bluetoothd[15533]: child 15536 forked
bluetoothd[15533]: HCI dev 0 already up
bluetoothd[15533]: Starting security manager 0
bluetoothd[15533]: periodic_inquiry_exit at adapter startup
bluetoothd[15533]: register_interface: path /org/bluez/15533/hci0
bluetoothd[15533]: Registered interface org.bluez.Service on path /org/bluez/15533/hci0
bluetoothd[15533]: headset_server_probe: path /org/bluez/15533/hci0
bluetoothd[15533]: Adding record with handle 0x10000
bluetoothd[15533]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[15533]: Adding record with handle 0x10001
bluetoothd[15533]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[15533]: a2dp_server_probe: path /org/bluez/15533/hci0
bluetoothd[15533]: SEP 0xb848d120 registered: type:0 codec:0 seid:1
bluetoothd[15533]: Adding record with handle 0x10002
bluetoothd[15533]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[15533]: avrcp_server_probe: path /org/bluez/15533/hci0
bluetoothd[15533]: Adding record with handle 0x10003
bluetoothd[15533]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[15533]: Adding record with handle 0x10004
bluetoothd[15533]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15533]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[15533]: Creating device /org/bluez/15533/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15533]: Probe drivers for /org/bluez/15533/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15533]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[15533]: Registered interface org.bluez.Audio on path /org/bluez/15533/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15533]: Found Headset record
bluetoothd[15533]: Discovered Headset service on RFCOMM channel 2
bluetoothd[15533]: Registered interface org.bluez.Headset on path /org/bluez/15533/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15533]: Found Handsfree record
bluetoothd[15533]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[15533]: Creating device /org/bluez/15533/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[15533]: Creating device /org/bluez/15533/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[15533]: Creating device /org/bluez/15533/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[15533]: Creating device /org/bluez/15533/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[15533]: Creating device /org/bluez/15533/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[15533]: Creating device /org/bluez/15533/hci0/dev_00_03_89_FE_E6_19
bluetoothd[15533]: Creating device /org/bluez/15533/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[15533]: Creating device /org/bluez/15533/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[15533]: Creating device /org/bluez/15533/hci0/dev_00_17_E5_16_88_6C
bluetoothd[15533]: Creating device /org/bluez/15533/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[15533]: Changing service classes to 0x480104
bluetoothd[15536]: Can't set link policy on hci0: No such device (19)
bluetoothd[15533]: Adapter /org/bluez/15533/hci0 has been enabled
bluetoothd[15533]: Stopping security manager 0
bluetoothd[15533]: Changing service classes to 0x480104
bluetoothd[15533]: Can't write class of device: Unknown error 4294967186 (-110)
bluetoothd[15533]: Entering main loop
bluetoothd[15533]: child 15536 exited
bluetoothd[15533]: HCI dev 0 down
bluetoothd[15533]: Adapter /org/bluez/15533/hci0 has been disabled
bluetoothd[15533]: HCI dev 0 up
bluetoothd[15533]: Starting security manager 0
bluetoothd[15533]: inquiry_cancel at adapter startup

Program received signal SIGSEGV, Segmentation fault.
0xb7dd73ba in ?? ()
(gdb) backtrace full
#0  0xb7dd73ba in ?? ()
No symbol table info available.
Cannot access memory at address 0xbf5d7fc0
(gdb) info registers
eax            0xbf5d912f	-1084387025
ecx            0x0	0
edx            0xbf5d912f	-1084387025
ebx            0xb7fd8144	-1208123068
esp            0xbf5d7fc0	0xbf5d7fc0
ebp            0xbf5d8030	0xbf5d8030
esi            0xb848b1d0	-1203195440
edi            0xb7faf73a	-1208289478
eip            0xb7dd73ba	0xb7dd73ba
eflags         0x210286	[ PF SF IF RF ID ]
cs             0x73	115
ss             0x7b	123
ds             0x7b	123
es             0x7b	123
fs             0x0	0
gs             0x33	51
(gdb) thread apply all backtrace
(gdb) quit

There are some interesting messages in /var/log/kern.log

Apr  6 22:48:23 kooka kernel: [1295911.574520] lt-bluetoothd[15189]: segfault at bf080fdc ip b7d7d3ba sp bf080fe0 error 6 in libc-2.9.so[b7cab000+15a000]
Apr  6 22:49:52 kooka kernel: [1296000.431677] lt-bluetoothd[15264]: segfault at bf228fec ip b7e253ba sp bf228ff0 error 6 in libc-2.9.so[b7d53000+15a000]
Apr  6 22:50:26 kooka kernel: [1296033.880910] lt-bluetoothd[15273]: segfault at bf309fcc ip b7d073ba sp bf309fd0 error 6 in libc-2.9.so[b7c35000+15a000]

-- 
If the From address bounces, please see http://www.pook.it/.
