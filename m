Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <a11267f30711280210k76cd02a4t7aa37f4d4f6b14e3@mail.gmail.com>
Date: Wed, 28 Nov 2007 18:10:53 +0800
From: shy <shyboysby@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] How to use bluez under virtual machine?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi, dear all,
I built up a virtual machine of fedora with kernal 2.6.5 under
VMWare5. And I want to use the system to run bluez with a dongle. But
it could not work.

I got df message log listed bellow:

Linux version 2.6.5-1.358 (bhcompile@bugs.build.redhat.com) (gcc
version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Sat May 8 09:04:50
EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000fefc000 (ACPI data)
 BIOS-e820: 000000000fefc000 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 000000000ff00000 - 0000000010000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
256MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 65536
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61440 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6c70
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0fef8062
ACPI: FADT (v001 INTEL  440BX    0x06040000 PTL  0x000f4240) @ 0x0fefbf14
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x0fefbf88
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0fefbfd8
ACPI: DSDT (v001 PTLTD  Custom   0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Kernel command line: ro root=LABEL=/ rhgb quiet
mapped 4G/4G trampoline to ffff3000.
Initializing CPU#0
CPU 0 irqstacks, hard=02345000 soft=02344000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 3190.158 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 256288k/262144k available (1540k kernel code, 5040k reserved,
599k data, 144k init, 0k highmem)
Calibrating delay loop... 6160.38 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0febfbff 00100000 00000000 00000000
CPU:     After vendor identify, caps: 0febfbff 00100000 00000000 00000000
CPU: Trace cache: 12K uops
CPU:     After all inits, caps: 0febf3ff 00100000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) D CPU 3.20GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9a0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
PCI: Cannot allocate resource region 4 of device 0000:00:07.1
Simple Boot Flag at 0x36 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1196218080.4294966534:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports C1, 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: AGP aperture is 64M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0x10f8-0x10ff, BIOS settings: hdc:DMA, hdd:pio
hdc: VMware Virtual IDE CDROM Drive, ATAPI CD/DVD-ROM drive
Using cfq io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 1X CD-ROM drive, 32kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S5)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 276k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
scsi: ***** BusLogic SCSI Driver Version 2.1.16 of 18 July 2002 *****
scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
scsi0: Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host Adapter
scsi0:   Firmware Version: 5.07B, I/O Address: 0x10C0, IRQ Channel: 11/Level
scsi0:   PCI Bus: 0, Device: 16, Address: 0xEC800000, Host Adapter SCSI ID: 7
scsi0:   Parity Checking: Enabled, Extended Translation: Enabled
scsi0:   Synchronous Negotiation: Ultra, Wide Negotiation: Enabled
scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
scsi0: *** BusLogic BT-958 Initialized Successfully ***
scsi0 : BusLogic BT-958
  Vendor: VMware,   Model: VMware Virtual S  Rev: 1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 41943040 512-byte hdwr sectors (21475 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 144k freed
scsi0: Tagged Queuing now active for Target 0
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
NET: Registered protocol family 10
Disabled Privacy Extensions on device 022db720(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
mtrr: your processor doesn't support write-combining
ACPI: Power Button (FF) [PWRF]
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 9, io base 00001060
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
EXT3 FS on sda2, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Adding 522104k swap on /dev/sda3.  Priority:-1 extents:1
usb 1-1: new full speed USB device using address 2
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.5
usbcore: registered new driver hci_usb
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
microcode: No suitable data for cpu 0
scsi0: Allocated 7 additional CCBs (total now 35)
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
inserting floppy driver for 2.6.5-1.358
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2048 buckets, 16384 max) - 296 bytes per conntrack
vmhgfs: module license 'unspecified' taints kernel.
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.2
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
lp0: console ready
mtrr: your processor doesn't support write-combining

And I got strace hcitool scan log listed bellow:

[root@localhost root]# strace hcitool scan |tee hcitool.txt
execve("/usr/bin/hcitool", ["hcitool", "scan"], [/* 37 vars */]) = 0
uname({sys="Linux", node="localhost.localdomain", ...}) = 0
brk(0)                                  = 0x89e0000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=123802, ...}) = 0
old_mmap(NULL, 123802, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7076000
close(3)                                = 0
open("/usr/lib/libbluetooth.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\305\221"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=20496, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xf7075000
old_mmap(0x91b000, 22084, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x91b000
old_mmap(0x920000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x4000) = 0x920000
close(3)                                = 0
open("/usr/lib/libdbus-1.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\216\232"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=188492, ...}) = 0
old_mmap(0x9a4000, 186128, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x9a4000
old_mmap(0x9d1000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x2d000) = 0x9d1000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\273"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1455084, ...}) = 0
old_mmap(0x5c7000, 1158124, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x5c7000
old_mmap(0x6dc000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x115000) = 0x6dc000
old_mmap(0x6e0000, 7148, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x6e0000
close(3)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\32\335"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=96248, ...}) = 0
old_mmap(0xdce000, 84192, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xdce000
old_mmap(0xddf000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x11000) = 0xddf000
old_mmap(0xde1000, 6368, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xde1000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xf7074000
mprotect(0xddf000, 4096, PROT_READ)     = 0
mprotect(0x6dc000, 8192, PROT_READ)     = 0
mprotect(0x5bf000, 4096, PROT_READ)     = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xf70742a0,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xf7076000, 123802)              = 0
socket(0x1f /* PF_??? */, SOCK_RAW, 1)  = 3
brk(0)                                  = 0x89e0000
brk(0x8a01000)                          = 0x8a01000
brk(0)                                  = 0x8a01000
ioctl(3, 0x800448d2, 0x89e0008)         = 0
close(3)                                = 0
dup(2)                                  = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(3, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 2), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xf7073000
_llseek(3, 0, 0xfef43a68, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(3, "Device is not available: Success"..., 33Device is not
available: Success
) = 33
close(3)                                = 0
munmap(0xf7073000, 4096)                = 0
exit_group(1)                           = ?
[root@localhost root]# cat hcitool.txt
[root@localhost root]# strace hcitool scan |touch hcitool.txt
execve("/usr/bin/hcitool", ["hcitool", "scan"], [/* 37 vars */]) = 0
uname({sys="Linux", node="localhost.localdomain", ...}) = 0
brk(0)                                  = 0x925a000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=123802, ...}) = 0
old_mmap(NULL, 123802, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7072000
close(3)                                = 0
open("/usr/lib/libbluetooth.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\305\221"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=20496, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xf7071000
old_mmap(0x91b000, 22084, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x91b000
old_mmap(0x920000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x4000) = 0x920000
close(3)                                = 0
open("/usr/lib/libdbus-1.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\216\232"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=188492, ...}) = 0
old_mmap(0x9a4000, 186128, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x9a4000
old_mmap(0x9d1000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x2d000) = 0x9d1000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\273"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1455084, ...}) = 0
old_mmap(0x5c7000, 1158124, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x111000
old_mmap(0x226000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x115000) = 0x226000
old_mmap(0x22a000, 7148, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x22a000
close(3)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\32\335"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=96248, ...}) = 0
old_mmap(0xdce000, 84192, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xdce000
old_mmap(0xddf000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x11000) = 0xddf000
old_mmap(0xde1000, 6368, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xde1000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xf7070000
mprotect(0xddf000, 4096, PROT_READ)     = 0
mprotect(0x226000, 8192, PROT_READ)     = 0
mprotect(0x5bf000, 4096, PROT_READ)     = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xf70702a0,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xf7072000, 123802)              = 0
socket(0x1f /* PF_??? */, SOCK_RAW, 1)  = 3
brk(0)                                  = 0x925a000
brk(0x927b000)                          = 0x927b000
brk(0)                                  = 0x927b000
ioctl(3, 0x800448d2, 0x925a008)         = 0
close(3)                                = 0
dup(2)                                  = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(3, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 2), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xf706f000
_llseek(3, 0, 0xfee610a8, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(3, "Device is not available: Success"..., 33Device is not
available: Success
) = 33
close(3)                                = 0
munmap(0xf706f000, 4096)                = 0
exit_group(1)                           = ?

Could you please tell me whether fedora/Ubuntu could not run bluez
under VMWare or may any other reasons?
Best regards
Shi Buyun

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
