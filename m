Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-id: <7234973362.7336272349@estudiants.urv.es>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Bluez-users] usb dongle problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 25 Mar 2004 17:41:36 +0100

Hi

I'm still working on the problem I have with my usb
dongle.
In a red hat 7.3 with kernel 2.4.18 (i know it's
deprecated) I install bluez-kernel 2.3, bluez-libs,
bluez-utils, bluez-sdp and bluez-pan, but when I do
hciconfig, there is no output. Here are my outputs of
 lspci:
00:00.0 Host bridge: Silicon Integrated Systems
[SiS]: Unknown device 0645 (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS]
5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS]
85C503/5513
00:02.2 USB Controller: Silicon Integrated Systems
[SiS] 7001 (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems
[SiS] 7001 (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems
[SiS] 5513 [IDE] (rev d0)
00:05.0 Multimedia audio controller: C-Media
Electronics Inc CM8738 (rev 10)
00:0a.0 Ethernet controller: Realtek Semiconductor
Co., Ltd. RTL-8139/8139C (rev 10)
00:0d.0 Ethernet controller: National Semiconductor
Corporation DP83820 10/100/1000 Ethernet Controller
01:00.0 VGA compatible controller: nVidia
Corporation NV17 [GeForce4 MX440] (rev a3)


lsusb:
Bus 002 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            0.00
  iManufacturer           0 
  iProduct                2 USB OHCI Root Hub
  iSerial                 1 d0891000
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            0.00
  iManufacturer           0 
  iProduct                2 USB OHCI Root Hub
  iSerial                 1 d088f000
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))

Bus 001 Device 002: ID 050d:0081 Belkin Components 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 
  bDeviceSubClass         1 
  bDeviceProtocol         1 
  bMaxPacketSize0        64
  idVendor           0x050d Belkin Components
  idProduct          0x0081 
  bcdDevice            5.25
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          193
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         16
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          0
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          0
        bInterval               1
 Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          9
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          9
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         17
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         17
        bInterval               1
 Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         25
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         25
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         33
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         33
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         49
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         49
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 
      bInterfaceSubClass      1 
      bInterfaceProtocol      0 
      iInterface              0 
  unknown descriptor type: 07 21 07 88 13 ff 03
  Language IDs: (length=4)
     0409 English(US)




lsmod:

Module                  Size  Used by    Not tainted
l2cap                  19328   0  (unused)
hci                    25024   0  [l2cap]
hci_usb                 6560   0 
bluez                  36008   0  [hci_usb]
cmpci                  32660   0  (autoclean)
binfmt_misc             7428   1 
autofs                 11812   0  (autoclean) (unused)
ns83820                10528   1 
8139too                16288   1 
mii                     2280   0  [8139too]
audio                  41056   0  (unused)
soundcore               6532   4  [cmpci audio]
ide-cd                 30176   0  (autoclean)
cdrom                  32096   0  (autoclean) [ide-cd]
usb-ohci               20704   0  (unused)
usbcore                72736   1  [hci_usb audio
usb-ohci]
ext3                   67136   1 
jbd                    49400   1  [ext3]


dmesg:

Linux version 2.4.18-3
(bhcompile@daffy.perf.redhat.com) (gcc version 2.96
20000731 (Red Hat Linux 7.3 2.96-110)) #1 Thu Apr 18
07:37:53 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 000000000fffc000 (usable)
 BIOS-e820: 000000000fffc000 - 000000000ffff000
(ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000
(ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000
(reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000
(reserved)
On node 0 totalpages: 65532
zone(0): 4096 pages.
zone(1): 61436 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro
root=302 BOOT_FILE=/boot/vmlinuz-2.4.18-3
Initializing CPU#0
Detected 1816.178 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3617.58 BogoMIPS
Memory: 255488k/262128k available (1119k kernel
code, 6252k reserved, 775k data, 280k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6,
262144 bytes)
Inode cache hash table entries: 16384 (order: 5,
131072 bytes)
Mount-cache hash table entries: 4096 (order: 3,
32768 bytes)
Buffer cache hash table entries: 16384 (order: 4,
65536 bytes)
Page-cache hash table entries: 65536 (order: 6,
262144 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000
00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 3febfbff 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000
00000000 00000000
CPU:             Common caps: 3febfbff 00000000
00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf15a0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with
MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 496 slots per queue, batch=124
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 15
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS645
ide0: BM-DMA at 0xd800-0xd807, BIOS settings:
hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings:
hdc:pio, hdd:DMA
hda: ST340810A, ATA DISK drive
hdd: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/2048KiB Cache,
CHS=4865/255/63, UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K
size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind
16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 122k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 280k freed
Adding Swap: 578332k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 9 for device 00:02.2
PCI: Sharing IRQ 9 with 00:02.3
usb-ohci.c: USB OHCI at membase 0xd088f000, IRQ 9
usb-ohci.c: usb-00:02.2, Silicon Integrated Systems
[SiS] 7001
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Found IRQ 9 for device 00:02.3
PCI: Sharing IRQ 9 with 00:02.2
usb-ohci.c: USB OHCI at membase 0xd0891000, IRQ 9
usb-ohci.c: usb-00:02.3, Silicon Integrated Systems
[SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2),
internal journal
ide-floppy driver 0.99.newide
hdd: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdd: DMA disabled
usb.c: registered new driver audio
audio.c: v1.0.0:USB Audio Class driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
8139too Fast Ethernet driver 0.9.24
PCI: Found IRQ 5 for device 00:0a.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd08cc000,
00:e0:4c:e1:d6:63, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting half-duplex based on auto-negotiated
partner ability 0000.
ns83820.c: National Semiconductor DP83820
10/100/1000 driver.
PCI: Found IRQ 10 for device 00:0d.0
PCI: Sharing IRQ 10 with 00:05.0
eth1: ns83820 v0.15: DP83820 v1.3: 00:05:1c:98:20:73
io=0xe4800000 irq=10 f=sg
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
cmpci: version $Revision: 5.64 $ time 11:04:21 Mar
11 2004
PCI: Found IRQ 10 for device 00:05.0
PCI: Sharing IRQ 10 with 00:0d.0
cmpci: found CM8738 adapter at io 0xa800 irq 10
cmpci: chip version = 055
cmpci: Enable SPDIF loop
cdrom: This disc doesn't have any tracks I recognize!
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
cdrom: This disc doesn't have any tracks I recognize!
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
hub.c: USB new device connect on bus1/2, assigned
device number 2
usb.c: USB device 2 (vend/prod 0x50d/0x81) is not
claimed by any active driver.
eth1: link now 1000 mbps, full duplex and up.
BlueZ Core ver 2.2 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky
<maxk@qualcomm.com>
BlueZ HCI USB driver ver 1.0 Copyright (C) 2000,2001
Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky
<maxk@qualcomm.com>
usb.c: registered new driver hci_usb
hci_usb_probe: Can't register HCI device 
BlueZ HCI Core ver 1.1 Copyright (C) 2000,2001
Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky
<maxk@qualcomm.com>
BlueZ L2CAP ver 1.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky
<maxk@qualcomm.com>
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth1: link now 1000 mbps, full duplex and up.


(sorry for this long e-mail)

Thank you in advance!!!

Regards

Albert




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
