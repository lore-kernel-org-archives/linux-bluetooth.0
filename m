Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gabor Halaszvari <fire@3hacker.hu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] siemens lifebook 6120
References: <200309132053.40178.fire@3hacker.hu> <1063546262.28890.467.camel@pegasus>
In-Reply-To: <1063546262.28890.467.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200309142035.30749.fire@3hacker.hu>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 14 Sep 2003 20:35:30 +0200

Hi Marcel,

> what about sending us more information. Logfiles, dmesg, lsmod,
> /proc/bus/usb/devices etc.

I'm included /etc/bluetooth/hcid.conf, /var/log/messages (while starting 
bluez), dmesg, lsmod and /proc/bus/usb/devices.

-------------------------------------------------------------------------------------------------------------

lifebook:/etc/bluetooth # cat hcid.conf
#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.3 2002/07/18 18:12:46 maxk Exp $
#

# HCId options
options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        security auto;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # PIN helper
        pin_helper /bin/bluepin;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "BlueZ (%d)";

        # Local device class
        class 0x100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy
        #   accept - always accept incoming connections
        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections
        #
        #lm accept,master;
        #
        lm accept;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        #
        #lp hold,sniff;
        #
        lp hold,sniff,park;

        # Authentication and Encryption
        #auth enable;
        #encrypt enable;
}

-------------------------------------------------------------------------------------------------------------

lifebook:/home/fire # tail -f /var/log/messages
Sep 14 20:21:22 lifebook hcid[2080]: HCI daemon ver 2.2 started
Sep 14 20:21:22 lifebook sdpd[2083]: SDPd ver 1.0 started
Sep 14 20:21:32 lifebook kernel: BlueZ HCI USB driver ver 2.1 Copyright (C) 
2000,2001 Qualcomm Inc
Sep 14 20:21:32 lifebook kernel: Written 2000,2001 by Maxim Krasnyansky 
<maxk@qualcomm.com>
Sep 14 20:21:32 lifebook kernel: usb.c: registered new driver hci_usb

-------------------------------------------------------------------------------------------------------------

lifebook:/home/fire # dmesg
Linux version 2.4.20-4GB (root@Pentium.suse.de) (gcc version 3.3 20030226 
(prerelease) (SuSE Linux)) #1 Fri Mar 28 13:29:55 UTC 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
 BIOS-e820: 000000000f6f0000 - 000000000f6f8000 (ACPI data)
 BIOS-e820: 000000000f6f8000 - 000000000f700000 (ACPI NVS)
 BIOS-e820: 000000000f700000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Scanning bios EBDA for MXT signature
0MB HIGHMEM available.
246MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 63216
zone(0): 4096 pages.
zone(1): 59120 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 FUJ                        ) @ 0x000f59d0
ACPI: RSDT (v001 FUJ    FJNB16C  00259.00000) @ 0x0f6f1e14
ACPI: FADT (v001 FUJ    FJNB16C  00259.00000) @ 0x0f6f78e0
ACPI: SSDT (v001 FUJ    FJNB16C  00259.00000) @ 0x0f6f7954
ACPI: SSDT (v001 FUJ    FJNB16C  00259.00000) @ 0x0f6f7d68
ACPI: BOOT (v001 FUJ    FJNB16C  00259.00000) @ 0x0f6f7fd8
ACPI: DSDT (v001 FUJ    FJNB16C  00259.00000) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: root=/dev/hda3 vga=0x317  hdc=ide-scsi hdclun=0 
splash=silent splash=silent
ide_setup: hdc=ide-scsi
ide_setup: hdclun=0
bootsplash: silent mode.
bootsplash: silent mode.
Initializing CPU#0
Detected 599.989 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1196.03 BogoMIPS
Memory: 246152k/252864k available (1569k kernel code, 6324k reserved, 574k 
data, 160k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: a7e9f9bf 00000000 00000000 00000000
CPU:             Common caps: a7e9f9bf 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030228
PCI: PCI BIOS revision 2.10 entry at 0xfd9b2, last bus=3
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
mxt_scan_bios: enter
Starting kswapd
bigpage subsystem: allocated 0 bigpages (=0MB).
kinoded started
VFS: Disk quotas vdquot_6.5.1
aio_setup: num_physpages = 15804
aio_setup: sizeof(struct page) = 48
vesafb: framebuffer at 0xd8000000, mapped to 0xd001f000, size 8000k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at a5f3:1f5f
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Looking for splash picture.... silenjpeg size 30311 bytes, found (1024x768, 
23130 bytes, v3).
Got silent jpeg.
Got silent jpeg.
Console: switching to colour frame buffer device 118x38
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 16 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: TOSHIBA MK4018GAS, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-R2212, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78140160 sectors (40008 MB), CHS=4864/255/63
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 475k freed
VFS: Mounted root (ext2 filesystem).
reiserfs: found format "3.6" with standard journal
reiserfs: enabling write barrier flush mode
reiserfs: using ordered data mode
reiserfs: checking transaction log (ide0(3,3)) for (ide0(3,3))
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 160k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Adding Swap: 498004k swap-space (priority 42)
NTFS driver 2.1.1a [Flags: R/O MODULE].
NTFS volume version 3.1.
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2212  Rev: 1F15
  Type:   CD-ROM                             ANSI SCSI revision: 02
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 48000
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xd0923000, 00:0b:5d:01:5a:9b, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
ohci1394: $Rev: 758 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[d0204800-d0204fff]  Max 
Packet=[2048]
ieee1394: SelfID completion called outside of bus reset!
ieee1394: Host added: Node[00:1023]  GUID[00000e1001600fb1]  [Linux OHCI-1394]
raw1394: /dev/raw1394 device initialized
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci-hcd 00:1d.7: Intel Corp. 82801DB USB EHCI Controller
ehci-hcd 00:1d.7: irq 11, pci mem d0927000
usb.c: new USB bus registered, assigned bus number 1
ehci-hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 32.
ehci-hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 14:17:12 Mar 28 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1840, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0x1860, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
uhci.c: USB Universal Host Controller Interface driver v1.1
hub.c: new USB device 00:1d.2-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x44e/0x3001) is not claimed by any active 
driver.
mice: PS/2 mouse device common for all mice
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
usb-uhci.c: ENXIO 80000280, flags 0, urb c28423e0, burb c28422e0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb c28423e0, burb c28422e0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb c28423e0, burb c28422e0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb c28423e0, burb c28422e0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb c28423e0, burb c28422e0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb c28422e0, burb c28423e0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb c28422e0, burb c28423e0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb c28422e0, burb c28423e0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb c28422e0, burb c28423e0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb c28423e0, burb c28422e0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -6
ACPI: AC Adapter [AC] (off-line)
ACPI: Processor [CPU0] (supports C1 C2 C3, 6 performance states)
ACPI: Battery Slot [CMB1] (battery present)
ACPI: Battery Slot [CMB2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
BlueZ Core ver 2.2 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 00b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 00b8, PCI irq11
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0820-0x08ff: clean.
cs: IO port probe 0x0800-0x080f: clean.
cs: IO port probe 0x03e0-0x04ff: excluding 0x400-0x407 0x4d0-0x4d7
cs: IO port probe 0x0100-0x03af: excluding 0x378-0x37f
cs: IO port probe 0x0a00-0x0aff: clean.
Got silent jpeg.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 195M
agpgart: Detected an Intel(R) 855GM Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xd8000000
[drm] AGP 0.99 aperture @ 0xd8000000 128MB
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x400000
[drm] Initialized i830 1.3.2 20021108 on minor 0
mtrr: base(0xd8020000) is not aligned on a size(0x180000) boundary
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x400000
Linux video capture interface: v1.00
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
BlueZ HCI USB driver ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb

-------------------------------------------------------------------------------------------------------------

lifebook:/home/fire # cat /proc/bus/usb/devices
T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=044e ProdID=3001 Rev= 3.36
S:  Manufacturer=ALPS
S:  Product=USB BT
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=250mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.04
S:  Manufacturer=Linux 2.4.20-4GB ehci-hcd
S:  Product=Intel Corp. 82801DB USB EHCI Controller
S:  SerialNumber=00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

-------------------------------------------------------------------------------------------------------------

lifebook:/home/fire # lsmod
Module                  Size  Used by    Not tainted
hci_usb                 6744   0  (unused)
ipv6                  134388  -1  (autoclean)
videodev                5600   0  (autoclean)
i830                   64500   2
agpgart                35520  10  (autoclean)
isa-pnp                29672   0  (unused)
ds                      6604   2
yenta_socket            9760   2
pcmcia_core            41824   0  [ds yenta_socket]
l2cap                  14768   1  (autoclean)
bluez                  27108   1  (autoclean) [hci_usb l2cap]
button                  2380   0  (unused)
thermal                 6020   0  (unused)
battery                 5600   0  (unused)
processor               8184   0  [thermal]
fan                     1472   0  (unused)
ac                      1664   0  (unused)
st                     27956   0  (autoclean) (unused)
sr_mod                 12600   0  (autoclean)
sg                     25852   0  (autoclean)
mousedev                4148   0  (unused)
joydev                  5632   0  (unused)
evdev                   4032   0  (unused)
input                   3104   0  [mousedev joydev evdev]
usb-uhci               22096   0  (unused)
ehci-hcd               16012   0  (unused)
usbcore                57836   1  [hci_usb usb-uhci ehci-hcd]
raw1394                14516   0  (unused)
ohci1394               16180   0  (unused)
ieee1394               32880   0  [raw1394 ohci1394]
8139too                14696   1
mii                     2304   0  [8139too]
snd-intel8x0           19204   0
snd-pcm                62912   0  [snd-intel8x0]
snd-timer              11904   0  [snd-pcm]
snd-ac97-codec         31152   0  [snd-intel8x0]
snd-mpu401-uart         3360   0  [snd-intel8x0]
snd-rawmidi            13824   0  [snd-mpu401-uart]
snd-seq-device          4000   0  [snd-rawmidi]
snd                    35940   0  [snd-intel8x0 snd-pcm snd-timer 
snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3396   0  [snd]
ide-scsi                9296   0
ide-cd                 29404   0
cdrom                  28192   0  [sr_mod ide-cd]
nls_iso8859-2           3324   1  (autoclean)
ntfs                   75244   1  (autoclean)
reiserfs              200532   1

-------------------------------------------------------------------------------------------------------------

Best regards,
Gabor




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
