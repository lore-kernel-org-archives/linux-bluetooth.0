Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't initialize bluetooth dongle with CBT100U
	chipset!
From: Tamer Higazi <tamer23@myrealbox.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1110645441.8572.0.camel@pegasus>
References: <1110643712.7592.7.camel@tux>  <1110645441.8572.0.camel@pegasus>
Content-Type: text/plain
Message-Id: <1110648758.7798.4.camel@tux>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 12 Mar 2005 18:32:38 +0100

As requested I send you the content of "/proc/bus/usb/devices". In my
Computer are 2 USB controllers. One PCI USB 2.0 card and USB 2.0 on
Board. 

Here is the output: 

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.11.1 ehci_hcd
S:  Product=VIA Technologies, Inc. USB 2.0 (#2)
S:  SerialNumber=0000:00:10.3
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 4
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.11.1 ehci_hcd
S:  Product=VIA Technologies, Inc. USB 2.0
S:  SerialNumber=0000:00:0f.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub

and the whole dmesg output is here:
 
Linux version 2.6.11.1 (root@tux) (gcc version 3.3.5 (Gentoo Linux
3.3.5-r1, ssp-3.3.2-3, pie-8.7.7.1)) #1 Thu Mar 10 20:00:18 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5f50
ACPI: RSDT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @
0x1fffc000
ACPI: FADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @
0x1fffc0b2
ACPI: BOOT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @
0x1fffc030
ACPI: MADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @
0x1fffc058
ACPI: DSDT (v001   ASUS A7V8X-X  0x00001000 MSFT 0x0100000b) @
0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: root=/dev/ram0 init=/linuxrc ramdisk=8192
real_root=/dev/hdb3 vga=792@60
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1916.546 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 512552k/524272k available (3167k kernel code, 11092k reserved,
1069k data, 208k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 3776.51 BogoMIPS (lpj=1888256)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 2600+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0a20)
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 1510k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1990, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0,
disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0,
disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12) *0,
disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
pnp: 00:01: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:01: ioport range 0xe800-0xe81f has been reserved
pnp: 00:0d: ioport range 0x290-0x297 has been reserved
pnp: 00:0d: ioport range 0x370-0x375 has been reserved
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.22 [Flags: R/O].
SGI XFS with large block numbers, no debug enabled
Initializing Cryptographic API
vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 6144k,
total 131072k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected mode interface info at c000:e780
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SP0812N, ATA DISK drive
hdb: ST340015A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ATAPI DVD DD 2X16X4X16, ATAPI CD/DVD-ROM drive
hdd: ATAPI DVD-ROM 16XMax, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 156368016 sectors (80060 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 > p3
hdb: max request size: 128KiB
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
hdb: cache flushes supported
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
st: Version 20041025, fixed bufsize 32768, s/g segs 256
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
Bluetooth: VHCI driver ver 1.1
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.4
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
powernow-k8: Processor cpuid 6a0 not supported
ACPI wakeup devices:
PCI0 PCI1 USB0 USB1 USB2 SU20 SLAN
ACPI: (supports S0 S1 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Enabling device 0000:00:0f.2 (0014 -> 0016)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:0f.2[C] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:0f.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:0f.2: irq 11, pci mem 0xdd000000
ehci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0f.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec
2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0 (#2)
ehci_hcd 0000:00:10.3: irq 5, pci mem 0xdc800000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec
2004
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
usbcore: registered new driver hiddev
hub 2-0:1.0: over-current change on port 5
hub 2-0:1.0: over-current change on port 6
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
ReiserFS: hdb3: warning: sh-2021: reiserfs_fill_super: can not find
reiserfs on hdb3
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 500464k swap on /dev/hdb2.  Priority:-1 extents:1
EXT3 FS on hdb3, internal journal
CAPI Subsystem Rev 1.1.2.8
fcpci: module license 'Proprietary' taints kernel.
fcpci: AVM FRITZ!Card PCI driver, revision 0.6.2
fcpci: (fcpci built on Mar 10 2005 at 20:27:28)
PCI: Enabling device 0000:00:0a.0 (0100 -> 0103)
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
fcpci: AVM FRITZ!Card PCI found: port 0xd800, irq 11
fcpci: Loading...
fcpci: Driver 'fcpci' attached to stack. (152)
fcpci: Stack version 3.11-02
kcapi: Controller 1: fcpci-d800-11 attached
kcapi: card 1 "fcpci-d800-11" ready.
fcpci: Loaded.
Bluetooth: HCI USB driver ver 2.8
usbcore: registered new driver hci_usb
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport0: Printer, HEWLETT-PACKARD DESKJET 3820
lp0: using parport0 (interrupt-driven).
capifs: Rev 1.1.2.3
capi20: Rev 1.1.2.7: started up with major 68 (middleware+capifs)
PPP generic driver version 2.4.2
capilib_new_ncci: kcapi: appl 1 ncci 0x10101 up
PPP BSD Compression module registered
PPP Deflate Compression module registered
kcapi: appl 1 ncci 0x10101 down
capilib_new_ncci: kcapi: appl 1 ncci 0x10101 up
kcapi: appl 1 ncci 0x10101 down



For any help 

Thank you 

Tamer 

Am Samstag, den 12.03.2005, 17:37 +0100 schrieb Marcel Holtmann:
> Hi Tamer,
> 
> > I bought a conceptronic bluetooth stick with the CBT100U chipset.
> > 
> > I compiled inside the kernel 2.6.11.1 the bluetooth option (not as
> > module) and loaded the module: hci_usb and the applications (deamons):
> > 
> > hcid
> > sdpd
> > 
> > After then, I run hciconfig and the output is still empty. How could it
> > come? 
> 
> what does the content of /proc/bus/usb/devices say and do you see and
> errors when calling dmesg?
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
