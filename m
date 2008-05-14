Return-Path: <cyrus@holtmann.org>
Message-ID: <482AB4AD.50803@earthlink.net>
Date: Wed, 14 May 2008 04:45:17 -0500
From: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Anycom USB-250 unseen by hcitool
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hello. I recently bought an Anycom USB-250 Bluetooth
adapter, and I'm trying to get it to work with my Palm
Tungsten E2 so that I can get online on the E2.

However, I can't get it to work. When I run "hcitool scan",
I get this error message: "Device is not available: No such
device."

This confuses me because I seem to have plenty of devices in
/dev:

crw-rw---- 1 root dialout  10, 250 2008-05-12 17:53 vhci
crw-rw---- 1 root dialout 216,   3 2008-05-12 17:53 ttyUB3
crw-rw---- 1 root dialout 216,   2 2008-05-12 17:53 ttyUB2
crw-rw---- 1 root dialout 216,   1 2008-05-12 17:53 ttyUB1
crw-rw---- 1 root dialout 216,   0 2008-05-12 17:53 ttyUB0
crw-rw---- 1 root dialout 216,   9 2008-05-12 17:53 rfcomm9
crw-rw---- 1 root dialout 216,   8 2008-05-12 17:53 rfcomm8
crw-rw---- 1 root dialout 216,   7 2008-05-12 17:53 rfcomm7
crw-rw---- 1 root dialout 216,   6 2008-05-12 17:53 rfcomm6
crw-rw---- 1 root dialout 216,   5 2008-05-12 17:53 rfcomm5
crw-rw---- 1 root dialout 216,   4 2008-05-12 17:53 rfcomm4
crw-rw---- 1 root dialout 216,  31 2008-05-12 17:53 rfcomm31
crw-rw---- 1 root dialout 216,  30 2008-05-12 17:53 rfcomm30
crw-rw---- 1 root dialout 216,   3 2008-05-12 17:53 rfcomm3
crw-rw---- 1 root dialout 216,  29 2008-05-12 17:53 rfcomm29
crw-rw---- 1 root dialout 216,  28 2008-05-12 17:53 rfcomm28
crw-rw---- 1 root dialout 216,  27 2008-05-12 17:53 rfcomm27
crw-rw---- 1 root dialout 216,  26 2008-05-12 17:53 rfcomm26
crw-rw---- 1 root dialout 216,  25 2008-05-12 17:53 rfcomm25
crw-rw---- 1 root dialout 216,  24 2008-05-12 17:53 rfcomm24
crw-rw---- 1 root dialout 216,  23 2008-05-12 17:53 rfcomm23
crw-rw---- 1 root dialout 216,  22 2008-05-12 17:53 rfcomm22
crw-rw---- 1 root dialout 216,  21 2008-05-12 17:53 rfcomm21
crw-rw---- 1 root dialout 216,  20 2008-05-12 17:53 rfcomm20
crw-rw---- 1 root dialout 216,   2 2008-05-12 17:53 rfcomm2
crw-rw---- 1 root dialout 216,  19 2008-05-12 17:53 rfcomm19
crw-rw---- 1 root dialout 216,  18 2008-05-12 17:53 rfcomm18
crw-rw---- 1 root dialout 216,  17 2008-05-12 17:53 rfcomm17
crw-rw---- 1 root dialout 216,  16 2008-05-12 17:53 rfcomm16
crw-rw---- 1 root dialout 216,  15 2008-05-12 17:53 rfcomm15
crw-rw---- 1 root dialout 216,  14 2008-05-12 17:53 rfcomm14
crw-rw---- 1 root dialout 216,  13 2008-05-12 17:53 rfcomm13
crw-rw---- 1 root dialout 216,  12 2008-05-12 17:53 rfcomm12
crw-rw---- 1 root dialout 216,  11 2008-05-12 17:53 rfcomm11
crw-rw---- 1 root dialout 216,  10 2008-05-12 17:53 rfcomm10
crw-rw---- 1 root dialout 216,   1 2008-05-12 17:53 rfcomm1
crw-rw---- 1 root dialout 216,   0 2008-05-12 17:53 rfcomm0
crw-rw---- 1 root dialout 217,   3 2008-05-12 17:53 ccub3
crw-rw---- 1 root dialout 217,   2 2008-05-12 17:53 ccub2
crw-rw---- 1 root dialout 217,   1 2008-05-12 17:53 ccub1
crw-rw---- 1 root dialout 217,   0 2008-05-12 17:53 ccub0

This is what I get when I do an strace on "hcitool scan":


execve("/usr/bin/hcitool", ["hcitool", "scan"], [/* 40 vars */]) = 0
uname({sys="Linux", node="xxxxx", ...})  = 0
brk(0)                                  = 0x8052000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7fb3000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=79173, ...}) = 0
mmap2(NULL, 79173, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f9f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/usr/lib/libbluetooth.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360=\0"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=70360, ...}) = 0
mmap2(NULL, 69280, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) 
= 0xb7f8e000
mmap2(0xb7f9e000, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10) = 0xb7f9e000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240O\1"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1245488, ...}) = 0
mmap2(NULL, 1251484, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0xb7e5c000
mmap2(0xb7f84000, 28672, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x128) = 0xb7f84000
mmap2(0xb7f8b000, 10396, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f8b000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7e5b000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7e5a000
mprotect(0xb7f84000, 20480, PROT_READ)  = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7e5a6c0, 
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7f9f000, 79173)               = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 3
brk(0)                                  = 0x8052000
brk(0x8073000)                          = 0x8073000
ioctl(3, 0x800448d2, 0x8052008)         = 0
close(3)                                = 0
dup(2)                                  = 3
fcntl64(3, F_GETFL)                     = 0x8001 (flags 
O_WRONLY|O_LARGEFILE)
close(3)                                = 0
write(2, "Device is not available: No such"..., 40Device is not 
available: No such device
) = 40
exit_group(1)                           = ?
Process 2626 detached
------------------end----------------

With the bluetooth dongle plugged in, I see this in the
output of dmesg:

Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.9
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
------------------end----------------

And here is the output of lsusb:

Bus 005 Device 001: ID 0000:0000
Bus 004 Device 009: ID 0a5c:4503 Broadcom Corp.
Bus 004 Device 008: ID 0a5c:4502 Broadcom Corp.
Bus 004 Device 007: ID 0a5c:2111 Broadcom Corp.
Bus 004 Device 006: ID 0a5c:4500 Broadcom Corp.
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000


Also, "hciconfig dev" returns "Can't get device info: No such device"

I know I'm close; please help me get bluetooth working on my
system. I'll be so grateful.

This is my system:

Debian 4.0 (Etch)
Linux kernel 2.6.24.6 (i686)
bluez-firmware 1.2-1
bluez-gnome 0.6-1
bluez-hcidump 1.32-1
bluez-utils 3.7-1

I've disabled udev on my system; however, enabling it
doesn't seem to make any difference. I don't know what, if
anything, I should do with bluez-firmware.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
