Return-Path: <gregoire.favre@freesurf.ch>
Date: Sat, 10 Apr 2004 18:19:09 +0200
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Which is needed to have usb bluetooth? (kernels modules)
Message-ID: <20040410161909.GC26618@magma.epfl.ch>
References: <20040410155935.GA26618@magma.epfl.ch> <1081613259.5398.5.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1081613259.5398.5.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

On Sat, Apr 10, 2004 at 06:07:39PM +0200, Marcel Holtmann wrote:

Hello Marcel :-)

> I personally prefer having the USB and Bluetooth subsystem as modules,
> but it should work in both ways. May you wanna try a modular system.

I have also tried with everything in module (I have no preference...).

> Show us the content of /proc/bus/usb/devices and what do lspci and lsus=
b
> say? What kind of Bluetooth dongle do you have?

T:  Bus=3D04 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.5-mm3 uhci_hcd
S:  Product=3DIntel Corp. 82801DB USB (Hub #3)
S:  SerialNumber=3D0000:00:1d.2
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D03 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.5-mm3 uhci_hcd
S:  Product=3DIntel Corp. 82801DB USB (Hub #2)
S:  SerialNumber=3D0000:00:1d.1
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.5-mm3 uhci_hcd
S:  Product=3DIntel Corp. 82801DB USB (Hub #1)
S:  SerialNumber=3D0000:00:1d.0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D480 M=
xCh=3D 6
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.5-mm3 ehci_hcd
S:  Product=3DIntel Corp. 82801DB USB2
S:  SerialNumber=3D0000:00:1d.7
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D256ms

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D03 Cnt=3D01 Dev#=3D  3 Spd=3D480 M=
xCh=3D 0
D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0424 ProdID=3D20fc Rev=3D 1.97
S:  Manufacturer=3DSMSC
S:  Product=3DUSB 2 Flash Media Device
S:  SerialNumber=3D7777777777A6
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D 96mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50
Driver=3Dusb-storage
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D125us
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms


http://www.computerbase.de/bild/article/91/63/ has a good picture of the
Bluetooth for my motherboard (MSI Max2-BLR).

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridg=
e (rev 11)
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=3D64M]
        Capabilities: [e4] #09 [a104]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge =
(rev 11) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 32
        Bus: primary=3D00, secondary=3D01, subordinate=3D02, sec-latency=3D=
32
        Memory behind bridge: dec00000-dfdfffff
        Prefetchable memory behind bridge: da800000-de9fffff

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-i=
f 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 398=
2
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at d400 [size=3D32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-i=
f 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 398=
2
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at d800 [size=3D32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-i=
f 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 398=
2
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at dc00 [size=3D32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01) (prog-if 20 [EH=
CI])
        Subsystem: Micro-Star International Co., Ltd. 845PE Max (MS-6580)=
 Onboard USB EHCI Controller
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at dfffbc00 (32-bit, non-prefetchable) [size=3D1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 81) (pro=
g-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D=
32
        I/O behind bridge: 0000a000-0000cfff
        Memory behind bridge: dfe00000-dfefffff
        Prefetchable memory behind bridge: dea00000-deafffff

00:1f.0 ISA bridge: Intel Corp. 82801DB LPC Interface Controller (rev 01)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DB Ultra ATA Storage Controller (=
rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 398=
2
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at fc00 [size=3D16]
        Memory at 40000000 (32-bit, non-prefetchable) [size=3D1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 01)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 398=
2
        Flags: medium devsel, IRQ 18
        I/O ports at 0c00 [size=3D32]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (re=
v 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32=
Mb
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at dc000000 (32-bit, prefetchable) [size=3D32M]
        Memory at dfafc000 (32-bit, non-prefetchable) [size=3D16K]
        Memory at df000000 (32-bit, non-prefetchable) [size=3D8M]
        Expansion ROM at dfac0000 [disabled] [size=3D128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0

03:00.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev =
06)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Flags: bus master, medium devsel, latency 32, IRQ 16
        I/O ports at b400 [size=3D32]
        Capabilities: [dc] Power Management version 1

03:00.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (r=
ev 06)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at cc00 [size=3D8]
        Capabilities: [dc] Power Management version 1

03:01.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
        Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at dfefbe00 (32-bit, non-prefetchable) [size=3D512]

03:02.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160LP Low Profile Ultra160 SCSI Controller
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
        BIST result: 00
        I/O ports at b000 [disabled] [size=3D256]
        Memory at dfefa000 (64-bit, non-prefetchable) [size=3D4K]
        Expansion ROM at dfec0000 [disabled] [size=3D128K]
        Capabilities: [dc] Power Management version 2

03:03.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at ac00 [disabled] [size=3D256]
        Memory at dfef9000 (32-bit, non-prefetchable) [size=3D4K]
        Expansion ROM at dfee0000 [disabled] [size=3D64K]

03:04.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
        Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at dfefbc00 (32-bit, non-prefetchable) [size=3D512]

03:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (CNR) Etherne=
t Controller (rev 81)
        Subsystem: Intel Corp.: Unknown device 1039
        Flags: bus master, medium devsel, latency 32, IRQ 20
        Memory at dfef8000 (32-bit, non-prefetchable) [size=3D4K]
        I/O ports at a800 [size=3D64]
        Capabilities: [dc] Power Management version 2

03:0e.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 0=
1) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 1275
        Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 22
        I/O ports at c800 [size=3D8]
        I/O ports at c400 [size=3D4]
        I/O ports at c000 [size=3D8]
        I/O ports at bc00 [size=3D4]
        I/O ports at b800 [size=3D16]
        Memory at dfefc000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: [60] Power Management version 1

And lsudb:
Bus 004 Device 001: ID 0000:0000 =20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         8
  idVendor           0x0000=20
  idProduct          0x0000=20
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.5-mm3 uhci_hcd
  iProduct                2 Intel Corp. 82801DB USB (Hub #3)
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
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=3D4)
     0409 English(US)

Bus 003 Device 001: ID 0000:0000 =20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         8
  idVendor           0x0000=20
  idProduct          0x0000=20
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.5-mm3 uhci_hcd
  iProduct                2 Intel Corp. 82801DB USB (Hub #2)
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
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=3D4)
     0409 English(US)

Bus 002 Device 001: ID 0000:0000 =20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         8
  idVendor           0x0000=20
  idProduct          0x0000=20
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.5-mm3 uhci_hcd
  iProduct                2 Intel Corp. 82801DB USB (Hub #1)
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
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=3D4)
     0409 English(US)

Bus 001 Device 003: ID 0424:20fc Standard Microsystems Corp.=20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0        64
  idVendor           0x0424 Standard Microsystems Corp.
  idProduct          0x20fc=20
  bcdDevice            1.97
  iManufacturer           1 SMSC
  iProduct                2 USB 2 Flash Media Device
  iSerial                 3 7777777777A6
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower               96mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize        512
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize        512
        bInterval               0
  unknown descriptor type: 07 21 07 e8 03 fe ff
  Language IDs: (length=3D4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000 =20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0=20
  bDeviceProtocol         1=20
  bMaxPacketSize0         8
  idVendor           0x0000=20
  idProduct          0x0000=20
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.5-mm3 ehci_hcd
  iProduct                2 Intel Corp. 82801DB USB2
  iSerial                 1 0000:00:1d.7
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
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval              12
  Language IDs: (length=3D4)
     0409 English(US)

I recompil with every USB/BT as module...

Thank you very much,

	Gr=E9goire
_________________________________________________________________________=
_
http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.c=
h
