Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sigrid Kronenberger <skronenberger@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] AVM BlueFritz with Linux Kernel 2.6.3-15mdk
Message-Id: <20040812203428.0bd25290@localhost>
In-Reply-To: <1092334021.28711.169.camel@pegasus>
References: <20040811231204.18574a27@localhost>
	<1092262417.4564.259.camel@pegasus>
	<20040812194818.7d3d1ce6@localhost>
	<1092334021.28711.169.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Thu, 12 Aug 2004 20:34:28 +0200

On Thu, 12 Aug 2004 20:07:01 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Sigrid,
> 
> > > and show us the content of /proc/bus/usb/devices after you plugged
> > > in the dongle.
> > 
> > T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> > B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> > D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> > P:  Vendor=0000 ProdID=0000 Rev= 2.06
> > S:  Manufacturer=Linux 2.6.3-15mdk uhci_hcd
> > S:  Product=UHCI Host Controller
> > S:  SerialNumber=0000:00:07.3
> > C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> > I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> > E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> > 
> > T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> > B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> > D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> > P:  Vendor=0000 ProdID=0000 Rev= 2.06
> > S:  Manufacturer=Linux 2.6.3-15mdk uhci_hcd
> > S:  Product=UHCI Host Controller
> > S:  SerialNumber=0000:00:07.2
> > C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> > I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> > E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> > 
> > T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> > D:  Ver= 1.10 Cls=ff(vend.) Sub=ff Prot=ff MxPS=64 #Cfgs=  2
> > P:  Vendor=057c ProdID=2200 Rev= 1.00
> > S:  Manufacturer=AVM Berlin
> > S:  Product=Bluetooth Device
> > S:  SerialNumber=00127762
> > C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
> > I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=bfusb
> > E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > C:  #Ifs= 1 Cfg#= 2 Atr=80 MxPwr=500mA
> > I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> > E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> 
> are you sure that hciconfig is showing nothing? Check dmesg for
> Bluetooth related messages.
> 

Yes, I'm sure, unfortunately. 

/var/log/dmesg shows: 

Real Time Clock Driver v1.12
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:07.3
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 11, io base 00009400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:07.3
PCI: Sharing IRQ 11 with 0000:00:07.2
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: irq 11, io base 00009800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using address 2
usb 1-2: configuration #1 chosen from 2 choices
Bluetooth: Core ver 2.3
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: BlueFRITZ! USB driver ver 1.1
bfusb_probe: Firmware request failed
bfusb: probe of 1-2:1.0 failed with error -5
drivers/usb/core/usb.c: registered new driver bfusb
Unable to handle kernel NULL pointer dereference at virtual address
00000028
 printing eip:
c016b532
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c016b532>]    Not tainted VLI
EFLAGS: 00010246
EIP is at dnotify_flush+0x12/0x70
eax: c16c3c80   ebx: df36b4a0   ecx: 00000001   edx: 00000000
esi: df240d80   edi: df36b4a0   ebp: df1cff8c   esp: df1cff80
ds: 007b   es: 007b   ss: 0068
Process firmware.agent (pid: 451, threadinfo=df1ce000 task=df1d1980)
Stack: df36b4a0 00000000 df240d80 df1cffa8 c01536a6 df36b4a0 df240d80
df36b4a0 
       00000000 00000009 df1cffbc c0153727 df36b4a0 df240d80 00000001
df1ce000 
       c010afb9 00000001 00000000 00000000 00000000 00000009 bffffa98
00000006 
Call Trace:
 [<c01536a6>] filp_close+0x36/0x70
 [<c0153727>] sys_close+0x47/0x60
 [<c010afb9>] sysenter_past_esp+0x52/0x79

Code: 12 25 ff ff ff 7f 09 c1 85 d2 75 f0 89 8b 28 01 00 00 5b 5d c3 8d
74 26 00 55 89 e5 57 56 53 8b 7d 08 8b 75 0c 8b 47 08 8b 50 08 <66> 8b
42 28 25 00 f0 00 00 3d 00 40 00 00 74 0e 8d 65 f4 5b 5e 
 <6>Adding 506008k swap on /dev/hda5.  Priority:-1 extents:1
Adding 511520k swap on /dev/hde1.  Priority:-2 extents:1
Adding 818960k swap on /dev/hdg7.  Priority:-3 extents:1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 32M @ 0xd8000000
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Supermount version 2.0.4 for kernel 2.6
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdg5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdg1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
