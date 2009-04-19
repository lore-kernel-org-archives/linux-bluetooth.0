Return-Path: <cyrus@holtmann.org>
Message-ID: <49EB7950.4000802@pook.es>
Date: Sun, 19 Apr 2009 21:19:44 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: bluez git + Linksys USBBT100 + 2.6.30-rc2 -> Segmentation fault
References: <49D89DCD.7090808@pook.es> <49D8E48A.2060807@pook.es> <20090405172212.GB6612@jh-x301>
In-Reply-To: <20090405172212.GB6612@jh-x301>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/04/09 19:22, Johan Hedberg wrote:

> I don't know about the kernel, but there's a known bug with 4.34 that can make
> bluetoothd crash when unpluging/repluging adapters. This was fixed in git
> already several days ago with commit 457056310229911e820357470ee8fb30c82516da
> ("Fix org.bluez.Audio unregistration") so you might want to try if it helps.

I just did a git pull to get the latest bluez and bluetoothd still gets a
Segmentation fault when I use my Linksys USBBT100 bluetooth adapter.
I used to use my USBBT100 with bluez 3. I was already using bluez 4 when
I bought my Belkin F8T017 bluetooth adapter.

I start bluetoothd without the USBBT100. When I plug it in the interface is down.
When I do hciconfig hci0 up the CPU usage goes up to 100% for 8 seconds and then
bluetoothd gets a segmentation fault.

If the USBBT100 is already plugged in when I start bluetoothd then bluetoothd crashes
6.3 seconds later having used 5.9 seconds of CPU time.

Neither valgrind nor gdb show anything of any interest.

I have installed bluez-4.36 and it has the same problem.  I have a 2.6.30-rc2 kernel.
My Belkin F8T017 bluetooth adapter works fine.

strace -f on bluetoothd shows that it is looping as shown below.

:; cat /var/lib/bluetooth/00:0C:41:E1:FF:30/config
mode off
class 0x080104
onmode off
discovto 60

open("/var/lib/bluetooth/00:0C:41:E1:FF:30/config", O_RDONLY) = 18
flock(18, LOCK_SH)                      = 0
fstat64(18, {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
mmap2(NULL, 47, PROT_READ, MAP_SHARED, 18, 0) = 0xb7f76000
munmap(0xb7f76000, 47)                  = 0
flock(18, LOCK_UN)                      = 0
close(18)                               = 0
umask(022)                              = 022
stat64("/var/lib/bluetooth/00:0C:41:E1:FF:30/config", {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
open("/var/lib/bluetooth/00:0C:41:E1:FF:30/config", O_RDWR|O_CREAT, 0644) = 18
close(18)                               = 0
open("/var/lib/bluetooth/00:0C:41:E1:FF:30/config", O_RDONLY) = 18
flock(18, LOCK_SH)                      = 0
fstat64(18, {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
mmap2(NULL, 47, PROT_READ, MAP_SHARED, 18, 0) = 0xb7f76000
munmap(0xb7f76000, 47)                  = 0
flock(18, LOCK_UN)                      = 0
close(18)                               = 0
open("/var/lib/bluetooth/00:0C:41:E1:FF:30/config", O_RDONLY) = 18
flock(18, LOCK_SH)                      = 0
fstat64(18, {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
mmap2(NULL, 47, PROT_READ, MAP_SHARED, 18, 0) = 0xb7f76000
munmap(0xb7f76000, 47)                  = 0
flock(18, LOCK_UN)                      = 0
close(18)                               = 0
open("/var/lib/bluetooth/00:0C:41:E1:FF:30/config", O_RDONLY) = 18
flock(18, LOCK_SH)                      = 0
fstat64(18, {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
mmap2(NULL, 47, PROT_READ, MAP_SHARED, 18, 0) = 0xb7f76000
munmap(0xb7f76000, 47)                  = 0
flock(18, LOCK_UN)                      = 0
close(18)                               = 0
umask(022)                              = 022
stat64("/var/lib/bluetooth/00:0C:41:E1:FF:30/config", {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
open("/var/lib/bluetooth/00:0C:41:E1:FF:30/config", O_RDWR|O_CREAT, 0644) = 18
close(18)                               = 0
open("/var/lib/bluetooth/00:0C:41:E1:FF:30/config", O_RDWR) = 18
flock(18, LOCK_EX)                      = 0
fstat64(18, {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
mmap2(NULL, 47, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_LOCKED, 18, 0) = 0xb7f76000
munmap(0xb7f76000, 47)                  = 0
flock(18, LOCK_UN)                      = 0
fdatasync(18)                           = 0
close(18)                               = 0
open("/var/lib/bluetooth/00:0C:41:E1:FF:30/config", O_RDONLY) = 18
flock(18, LOCK_SH)                      = 0
fstat64(18, {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
mmap2(NULL, 47, PROT_READ, MAP_SHARED, 18, 0) = 0xb7f76000
munmap(0xb7f76000, 47)                  = 0
flock(18, LOCK_UN)                      = 0
close(18)                               = 0
open("/var/lib/bluetooth/00:0C:41:E1:FF:30/config", O_RDONLY) = 18
flock(18, LOCK_SH)                      = 0
fstat64(18, {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
mmap2(NULL, 47, PROT_READ, MAP_SHARED, 18, 0) = 0xb7f76000
munmap(0xb7f76000, 47)                  = 0
flock(18, LOCK_UN)                      = 0
close(18)                               = 0
umask(022)                              = 022
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++


: root; time src/bluetoothd -dn
bluetoothd[20646]: Bluetooth daemon 4.36
bluetoothd[20646]: Enabling debug information
bluetoothd[20646]: parsing main.conf
bluetoothd[20646]: discovto=0
bluetoothd[20646]: Key file does not have key 'PairableTimeout'
bluetoothd[20646]: pageto=8192
bluetoothd[20646]: name=%h-%d
bluetoothd[20646]: class=0x000100
bluetoothd[20646]: inqmode=0
bluetoothd[20646]: Key file does not have key 'InitiallyPowered'
bluetoothd[20646]: Key file does not have key 'RememberPowered'
bluetoothd[20646]: Key file does not have key 'DeviceID'
bluetoothd[20646]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[20646]: Starting SDP server
bluetoothd[20646]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[20646]: register_interface: path /org/bluez/20646/any
bluetoothd[20646]: Registered interface org.bluez.Service on path /org/bluez/20646/any
bluetoothd[20646]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[20646]: Unix socket created: 11
bluetoothd[20646]: Telephony plugin initialized
bluetoothd[20646]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[20646]: HCI dev 0 registered
bluetoothd[20646]: child 20661 forked
bluetoothd[20646]: HCI dev 0 already up
bluetoothd[20646]: Starting security manager 0
bluetoothd[20646]: periodic_inquiry_exit at adapter startup
bluetoothd[20646]: register_interface: path /org/bluez/20646/hci0
bluetoothd[20646]: Registered interface org.bluez.Service on path /org/bluez/20646/hci0
bluetoothd[20646]: headset_server_probe: path /org/bluez/20646/hci0
bluetoothd[20646]: Adding record with handle 0x10000
bluetoothd[20646]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[20646]: Adding record with handle 0x10001
bluetoothd[20646]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[20646]: a2dp_server_probe: path /org/bluez/20646/hci0
bluetoothd[20646]: SEP 0xb85bb140 registered: type:0 codec:0 seid:1
bluetoothd[20646]: Adding record with handle 0x10002
bluetoothd[20646]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[20646]: avrcp_server_probe: path /org/bluez/20646/hci0
bluetoothd[20646]: Adding record with handle 0x10003
bluetoothd[20646]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[20646]: Adding record with handle 0x10004
bluetoothd[20646]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20646]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[20646]: Creating device /org/bluez/20646/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20646]: Probe drivers for /org/bluez/20646/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20646]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[20646]: Registered interface org.bluez.Audio on path /org/bluez/20646/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20646]: Found Headset record
bluetoothd[20646]: Registered interface org.bluez.Headset on path /org/bluez/20646/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20646]: Found Handsfree record
bluetoothd[20646]: Creating device /org/bluez/20646/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[20646]: Creating device /org/bluez/20646/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[20646]: Creating device /org/bluez/20646/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[20646]: Creating device /org/bluez/20646/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[20646]: Creating device /org/bluez/20646/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[20646]: Creating device /org/bluez/20646/hci0/dev_00_03_89_FE_E6_19
bluetoothd[20646]: Creating device /org/bluez/20646/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[20646]: Creating device /org/bluez/20646/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[20646]: Creating device /org/bluez/20646/hci0/dev_00_17_E5_16_88_6C
bluetoothd[20646]: Creating device /org/bluez/20646/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[20646]: Changing service classes to 0x480104
bluetoothd[20661]: Can't set link policy on hci0: No such device (19)
bluetoothd[20646]: Adapter /org/bluez/20646/hci0 has been enabled
bluetoothd[20646]: Stopping security manager 0
bluetoothd[20646]: Changing service classes to 0x480104
bluetoothd[20646]: Entering main loop
bluetoothd[20646]: child 20661 exited
bluetoothd[20646]: HCI dev 0 down
bluetoothd[20646]: Adapter /org/bluez/20646/hci0 has been disabled
bluetoothd[20646]: HCI dev 0 up
bluetoothd[20646]: Starting security manager 0
Segmentation fault

real	0m6.383s
user	0m1.608s
sys	0m4.316s

: root; time valgrind src/.libs/bluetoothd -dn
==20666== Memcheck, a memory error detector.
==20666== Copyright (C) 2002-2008, and GNU GPL'd, by Julian Seward et al.
==20666== Using LibVEX rev 1884, a library for dynamic binary translation.
==20666== Copyright (C) 2004-2008, and GNU GPL'd, by OpenWorks LLP.
==20666== Using valgrind-3.4.1-Debian, a dynamic binary instrumentation framework.
==20666== Copyright (C) 2000-2008, and GNU GPL'd, by Julian Seward et al.
==20666== For more details, rerun with: -v
==20666== 
bluetoothd[20666]: Bluetooth daemon 4.36
bluetoothd[20666]: Enabling debug information
bluetoothd[20666]: parsing main.conf
bluetoothd[20666]: discovto=0
bluetoothd[20666]: Key file does not have key 'PairableTimeout'
bluetoothd[20666]: pageto=8192
bluetoothd[20666]: name=%h-%d
bluetoothd[20666]: class=0x000100
bluetoothd[20666]: inqmode=0
bluetoothd[20666]: Key file does not have key 'InitiallyPowered'
bluetoothd[20666]: Key file does not have key 'RememberPowered'
bluetoothd[20666]: Key file does not have key 'DeviceID'
bluetoothd[20666]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[20666]: Starting SDP server
bluetoothd[20666]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[20666]: register_interface: path /org/bluez/20666/any
bluetoothd[20666]: Registered interface org.bluez.Service on path /org/bluez/20666/any
bluetoothd[20666]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[20666]: Unix socket created: 11
bluetoothd[20666]: Telephony plugin initialized
bluetoothd[20666]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[20666]: HCI dev 0 registered
bluetoothd[20666]: child 20669 forked
bluetoothd[20666]: HCI dev 0 already up
bluetoothd[20666]: Starting security manager 0
bluetoothd[20666]: periodic_inquiry_exit at adapter startup
bluetoothd[20666]: register_interface: path /org/bluez/20666/hci0
bluetoothd[20666]: Registered interface org.bluez.Service on path /org/bluez/20666/hci0
bluetoothd[20666]: headset_server_probe: path /org/bluez/20666/hci0
bluetoothd[20666]: Adding record with handle 0x10000
bluetoothd[20666]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[20666]: Adding record with handle 0x10001
bluetoothd[20666]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[20666]: a2dp_server_probe: path /org/bluez/20666/hci0
bluetoothd[20666]: SEP 0x4b532c8 registered: type:0 codec:0 seid:1
bluetoothd[20666]: Adding record with handle 0x10002
bluetoothd[20666]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[20666]: avrcp_server_probe: path /org/bluez/20666/hci0
bluetoothd[20666]: Adding record with handle 0x10003
bluetoothd[20666]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[20666]: Adding record with handle 0x10004
bluetoothd[20666]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20666]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[20666]: Creating device /org/bluez/20666/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20666]: Probe drivers for /org/bluez/20666/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20666]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[20666]: Registered interface org.bluez.Audio on path /org/bluez/20666/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20666]: Found Headset record
bluetoothd[20666]: Registered interface org.bluez.Headset on path /org/bluez/20666/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20666]: Found Handsfree record
bluetoothd[20666]: Creating device /org/bluez/20666/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[20666]: Creating device /org/bluez/20666/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[20666]: Creating device /org/bluez/20666/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[20666]: Creating device /org/bluez/20666/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[20666]: Creating device /org/bluez/20666/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[20666]: Creating device /org/bluez/20666/hci0/dev_00_03_89_FE_E6_19
bluetoothd[20666]: Creating device /org/bluez/20666/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[20666]: Creating device /org/bluez/20666/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[20666]: Creating device /org/bluez/20666/hci0/dev_00_17_E5_16_88_6C
bluetoothd[20666]: Creating device /org/bluez/20666/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[20666]: Changing service classes to 0x480104
==20666== Syscall param ioctl(generic) points to unaddressable byte(s)
==20666==    at 0x40007F2: (within /lib/ld-2.9.so)
==20666==    by 0x123D77: adapter_start (adapter.c:2201)
==20666==    by 0x11F0A1: manager_start_adapter (manager.c:474)
==20666==    by 0x112642: device_devup_setup (main.c:502)
==20666==    by 0x1127A9: init_all_devices (main.c:537)
==20666==    by 0x113073: main (main.c:779)
==20666==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
bluetoothd[20669]: Can't set link policy on hci0: No such device (19)
==20669== Syscall param ioctl(generic) points to unaddressable byte(s)
==20669==    at 0x40007F2: (within /lib/ld-2.9.so)
==20669==    by 0x1125AC: device_devreg_setup (main.c:484)
==20669==    by 0x112777: init_all_devices (main.c:534)
==20669==    by 0x113073: main (main.c:779)
==20669==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
bluetoothd[20666]: Adapter /org/bluez/20666/hci0 has been enabled
bluetoothd[20666]: Stopping security manager 0
bluetoothd[20666]: Changing service classes to 0x480104
bluetoothd[20666]: Entering main loop
==20669== 
==20669== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 63 from 3)
==20669== malloc/free: in use at exit: 29,243 bytes in 329 blocks.
==20669== malloc/free: 641 allocs, 312 frees, 250,226 bytes allocated.
==20669== For counts of detected errors, rerun with: -v
==20669== searching for pointers to 329 not-freed blocks.
==20669== checked 114,888 bytes.
==20669== 
==20669== LEAK SUMMARY:
==20669==    definitely lost: 0 bytes in 0 blocks.
==20669==      possibly lost: 744 bytes in 3 blocks.
==20669==    still reachable: 28,499 bytes in 326 blocks.
==20669==         suppressed: 0 bytes in 0 blocks.
==20669== Rerun with --leak-check=full to see details of leaked memory.
bluetoothd[20666]: child 20669 exited
bluetoothd[20666]: HCI dev 0 down
bluetoothd[20666]: Adapter /org/bluez/20666/hci0 has been disabled
bluetoothd[20666]: HCI dev 0 up
bluetoothd[20666]: Starting security manager 0
==20666== Stack overflow in thread 1: can't grow stack to 0xbe3c2fdc
==20666== 
==20666== Process terminating with default action of signal 11 (SIGSEGV)
==20666==  Access not within mapped region at address 0xBE3C2FDC
==20666==    at 0x4A1C3BA: __xstat (in /lib/i686/cmov/libc-2.9.so)
==20666==  If you believe this happened as a result of a stack overflow in your
==20666==  program's main thread (unlikely but possible), you can try to increase
==20666==  the size of the main thread stack using the --main-stacksize= flag.
==20666==  The main thread stack size used in this run was 8388608.
==20666== Stack overflow in thread 1: can't grow stack to 0xbe3c2fd8
==20666== 
==20666== Process terminating with default action of signal 11 (SIGSEGV)
==20666==  Access not within mapped region at address 0xBE3C2FD8
==20666==    at 0x48203EC: _vgnU_freeres (vg_preloaded.c:56)
==20666==  If you believe this happened as a result of a stack overflow in your
==20666==  program's main thread (unlikely but possible), you can try to increase
==20666==  the size of the main thread stack using the --main-stacksize= flag.
==20666==  The main thread stack size used in this run was 8388608.
==20666== 
==20666== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 63 from 3)
==20666== malloc/free: in use at exit: 44,508 bytes in 682 blocks.
==20666== malloc/free: 263,612 allocs, 262,930 frees, 1,828,692 bytes allocated.
==20666== For counts of detected errors, rerun with: -v
==20666== searching for pointers to 682 not-freed blocks.
==20666== checked 5,711,256 bytes.
==20666== 
==20666== LEAK SUMMARY:
==20666==    definitely lost: 0 bytes in 0 blocks.
==20666==      possibly lost: 744 bytes in 3 blocks.
==20666==    still reachable: 43,764 bytes in 679 blocks.
==20666==         suppressed: 0 bytes in 0 blocks.
==20666== Rerun with --leak-check=full to see details of leaked memory.
Segmentation fault

real	1m5.017s
user	0m48.763s
sys	0m15.225s

: root; gdb --args  src/.libs/bluetoothd -dn
GNU gdb 6.8-debian
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i486-linux-gnu"...
(gdb) run
Starting program: /disks/cleartext/stuart/install/bluez/git/bluez/src/.libs/bluetoothd -dn
bluetoothd[20695]: Bluetooth daemon 4.36
bluetoothd[20695]: Enabling debug information
bluetoothd[20695]: parsing main.conf
bluetoothd[20695]: discovto=0
bluetoothd[20695]: Key file does not have key 'PairableTimeout'
bluetoothd[20695]: pageto=8192
bluetoothd[20695]: name=%h-%d
bluetoothd[20695]: class=0x000100
bluetoothd[20695]: inqmode=0
bluetoothd[20695]: Key file does not have key 'InitiallyPowered'
bluetoothd[20695]: Key file does not have key 'RememberPowered'
bluetoothd[20695]: Key file does not have key 'DeviceID'
bluetoothd[20695]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[20695]: Starting SDP server
bluetoothd[20695]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[20695]: register_interface: path /org/bluez/20695/any
bluetoothd[20695]: Registered interface org.bluez.Service on path /org/bluez/20695/any
bluetoothd[20695]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[20695]: Unix socket created: 13
bluetoothd[20695]: Telephony plugin initialized
bluetoothd[20695]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[20695]: HCI dev 0 registered
bluetoothd[20695]: child 20698 forked
bluetoothd[20695]: HCI dev 0 already up
bluetoothd[20695]: Starting security manager 0
bluetoothd[20695]: periodic_inquiry_exit at adapter startup
bluetoothd[20695]: register_interface: path /org/bluez/20695/hci0
bluetoothd[20695]: Registered interface org.bluez.Service on path /org/bluez/20695/hci0
bluetoothd[20695]: headset_server_probe: path /org/bluez/20695/hci0
bluetoothd[20695]: Adding record with handle 0x10000
bluetoothd[20695]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[20695]: Adding record with handle 0x10001
bluetoothd[20695]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[20695]: a2dp_server_probe: path /org/bluez/20695/hci0
bluetoothd[20695]: SEP 0xb8e9b120 registered: type:0 codec:0 seid:1
bluetoothd[20695]: Adding record with handle 0x10002
bluetoothd[20695]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[20695]: avrcp_server_probe: path /org/bluez/20695/hci0
bluetoothd[20695]: Adding record with handle 0x10003
bluetoothd[20695]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[20695]: Adding record with handle 0x10004
bluetoothd[20695]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[20695]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[20695]: Creating device /org/bluez/20695/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20695]: Probe drivers for /org/bluez/20695/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20695]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[20695]: Registered interface org.bluez.Audio on path /org/bluez/20695/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20695]: Found Headset record
bluetoothd[20695]: Registered interface org.bluez.Headset on path /org/bluez/20695/hci0/dev_00_1A_45_2F_49_98
bluetoothd[20695]: Found Handsfree record
bluetoothd[20695]: Creating device /org/bluez/20695/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[20695]: Creating device /org/bluez/20695/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[20695]: Creating device /org/bluez/20695/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[20695]: Creating device /org/bluez/20695/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[20695]: Creating device /org/bluez/20695/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[20695]: Creating device /org/bluez/20695/hci0/dev_00_03_89_FE_E6_19
bluetoothd[20695]: Creating device /org/bluez/20695/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[20695]: Creating device /org/bluez/20695/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[20695]: Creating device /org/bluez/20695/hci0/dev_00_17_E5_16_88_6C
bluetoothd[20695]: Creating device /org/bluez/20695/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[20695]: Changing service classes to 0x480104
bluetoothd[20698]: Can't set link policy on hci0: No such device (19)
bluetoothd[20695]: Adapter /org/bluez/20695/hci0 has been enabled
bluetoothd[20695]: Stopping security manager 0
bluetoothd[20695]: Changing service classes to 0x480104
bluetoothd[20695]: Entering main loop
bluetoothd[20695]: child 20698 exited
bluetoothd[20695]: HCI dev 0 down
bluetoothd[20695]: Adapter /org/bluez/20695/hci0 has been disabled
bluetoothd[20695]: HCI dev 0 up
bluetoothd[20695]: Starting security manager 0

Program received signal SIGSEGV, Segmentation fault.
0xb7db03ba in ?? ()
(gdb) bt
#0  0xb7db03ba in ?? ()
Cannot access memory at address 0xbf4b1ff0
(gdb) bt full
#0  0xb7db03ba in ?? ()
No symbol table info available.
Cannot access memory at address 0xbf4b1ff0
(gdb) info registers
eax            0xbf4b315f	-1085591201
ecx            0x0	0
edx            0xbf4b315f	-1085591201
ebx            0xb7fb2144	-1208278716
esp            0xbf4b1ff0	0xbf4b1ff0
ebp            0xbf4b2060	0xbf4b2060
esi            0xb8e991d0	-1192652336
edi            0xb7f8989a	-1208444774
eip            0xb7db03ba	0xb7db03ba
eflags         0x10286	[ PF SF IF RF ]
cs             0x73	115
ss             0x7b	123
ds             0x7b	123
es             0x7b	123
fs             0x0	0
gs             0x33	51
(gdb) thread apply all backtrace
(gdb) quit
The program is running.  Exit anyway? (y or n) y

I guess that if you have read this far then you have found the solution as I did
mv /var/lib/bluetooth/00:0C:41:E1:FF:30/config /var/lib/bluetooth/00:0C:41:E1:FF:30/config.old

/var/lib/bluetooth/00:0C:41:E1:FF:30/config was recreated containing

: root; cat /var/lib/bluetooth/00:0C:41:E1:FF:30/config
class 0x480104

I guess that this is why my USBBT100 never (?) worked with bluez.
-- 
If the From address bounces, please see http://www.pook.it/.
