Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40AE464B.1070300@mail.ru>
From: Alexander Kulakov <a.kulakov@mail.ru>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Fujitsu-Siemens Celsius
References: <40AD87B3.6020805@mail.ru> <1085154942.22191.6.camel@pegasus>
In-Reply-To: <1085154942.22191.6.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 21 May 2004 12:11:23 -0600

Hi Marcel

Thanks for your reply

>we need more information. What is the content of /proc/bus/usb/devices,
>the output of lspci, lsusb, lsmod, dmesg etc.
>  
>
$ uname -a

Linux hurricane 2.6.6 #7 Thu May 20 01:31:19 CST 2004 i686 Mobile Intel(R) Pentium(R) 4 - M CPU 2.50GHz GenuineIntel GNU/Linux

Vanilla kernel without any patches applied
$ cat /proc/bus/usb/devices

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.6 uhci_hcd
S:  Product=Intel Corp. 82801CA/CAM USB (Hub #3)
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.6 uhci_hcd
S:  Product=Intel Corp. 82801CA/CAM USB (Hub #2)
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.6 uhci_hcd
S:  Product=Intel Corp. 82801CA/CAM USB (Hub #1)
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

$ lspci

0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio Controller (rev 02)
0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV17GL [Quadro4 550 GoGL] (rev a3)
0000:02:04.0 CardBus bridge: O2 Micro, Inc. OZ711E2 SmartCardBus Controller (rev 20)
0000:02:04.1 CardBus bridge: O2 Micro, Inc. OZ711E2 SmartCardBus Controller (rev 20)
0000:02:04.2 CardBus bridge: O2 Micro, Inc. OZ711E2 SmartCardBus Controller (rev 20)
0000:02:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
0000:02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

$ lsusb -v

Bus 003 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6 uhci_hcd
  iProduct                2 Intel Corp. 82801CA/CAM USB (Hub #3)
  iSerial                 1 0000:00:1d.2
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
     0409 English(US)

Bus 002 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6 uhci_hcd
  iProduct                2 Intel Corp. 82801CA/CAM USB (Hub #2)
  iSerial                 1 0000:00:1d.1
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
     0409 English(US)

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6 uhci_hcd
  iProduct                2 Intel Corp. 82801CA/CAM USB (Hub #1)
  iSerial                 1 0000:00:1d.0
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

     0409 English(US)

After starting hotplug and bluetooth (hci_usb loaded manually just 
before starting bluetooth)
$ dmesg

Linux version 2.6.6 (root@hurricane) (gcc version 3.3.3 20040412 (Gentoo Linux 3.3.3-r3, ssp-3.3-7, pie-8.5.3)) #7 Thu May 20 01:31:19 CST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003feff000 (ACPI data)
 BIOS-e820: 000000003feff000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 FSC___                                    ) @ 0x000f6150
ACPI: RSDT (v001 FSC___ WF2      0x06040000  LTP 0x00000000) @ 0x3fef7bec
ACPI: FADT (v001 FSC___ 845MP    0x06040000 PTL  0x00000050) @ 0x3fefef64
ACPI: BOOT (v001 FSC___ $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x3fefefd8
ACPI: DSDT (v001 FSC___ WF2      0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Kernel command line: root=/dev/hda3 rootfs=ext3 rootflags=data=journal ro
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2493.258 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 905536k/917504k available (2702k kernel code, 11216k reserved, 842k data, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4931.58 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.50GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9ca, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10)
ACPI: PCI Interrupt Link [LNKE] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 10) *0, disabled.
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: Power Resource [PFAN] (off)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
Simple Boot Flag at 0x37 set to 0x1
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
udf: registering filesystem
SGI XFS with ACLs, security attributes, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1, 8 throttling states)
ACPI: Thermal Zone [THRM] (36 C)
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0x4800, 00:90:96:6d:ec:62, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK6022GAX, ATA DISK drive
hdb: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB), CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49458 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801CA-ICH3 at 0x1c00, irq 10
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with journal data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 140k freed
EXT3 FS on hda3, internal journal
SCSI subsystem initialized
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
st: Version 20040318, fixed bufsize 32768, s/g segs 256
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with journal data mode.
found reiserfs format "3.6" with standard journal
reiserfs: using ordered data mode
Reiserfs journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-1) for (dm-1)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
reiserfs: using ordered data mode
Reiserfs journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-4) for (dm-4)
Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with journal data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with journal data mode.
Real Time Clock Driver v1.12
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
process `named' is using obsolete setsockopt SO_BSDCOMPAT
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M @ 0xd4000000
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 10, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hw_random hardware driver 1.0.0 loaded
usb 3-1: new full speed USB device using address 2
i8xx TCO timer: initialized (0x1060). heartbeat=30 sec (nowayout=0)
usb 3-1: device descriptor read/8, error -71
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:02:04.0 [1e2a:0071]
usb 3-1: new full speed USB device using address 3
Yenta: ISA IRQ mask 0x08b8, PCI irq 10
Socket status: 30000006
Yenta: CardBus bridge found at 0000:02:04.1 [1e2a:0071]
usb 3-1: device descriptor read/8, error -71
Yenta: ISA IRQ mask 0x08b8, PCI irq 10
Socket status: 30000006
Yenta: CardBus bridge found at 0000:02:04.2 [1e2a:0071]
yenta 0000:02:04.2: Preassigned resource 2 busy, reconfiguring...
yenta 0000:02:04.2: Preassigned resource 3 busy, reconfiguring...
Yenta: ISA IRQ mask 0x08b8, PCI irq 10
Socket status: 30000410
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1203 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e0007000-e00077ff]  Max Packet=[2048]
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0030053100020508]
ip1394: $Rev: 1198 $ Ben Collins <bcollins@debian.org>
ip1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.5
usbcore: registered new driver hci_usb


Cheers
Alexander


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
