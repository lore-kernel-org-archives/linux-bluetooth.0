Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Sep 2008 12:25:38 -0700 (PDT)
From: Chris Rankin <rankincj@yahoo.com>
Reply-To: rankincj@yahoo.com
Subject: Bluetooth 2.1 USB adapter!
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <294606.8239.qm@web52903.mail.re2.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have just bought a Belkin USB adapter 0x050d:0x016a, and according to hciconfig this is a Bluetooth 2.1 device:

# hciconfig hci0 version revision
hci0:	Type: USB
	BD Address: 00:0A:3A:83:76:DA ACL MTU: 1021:8 SCO MTU: 64:1
	HCI Ver: 2.1 (0x4) HCI Rev: 0x5184 LMP Ver: 2.1 (0x4) LMP Subver: 0x420e
	Manufacturer: Broadcom Corporation (15)
	Firmware 132.66 / 14

Does this mean that the adapter cannot possibly work correctly in anything less than a 2.6.27 kernel? Because it clearly *isn't* working correctly at the moment:

# hciconfig hci0 name
Can't read local name on hci0: Input/output error (5)

# hciconfig hci0 class
Can't read class of device on hci0: Input/output error (5)

# hciconfig hci0 voice
Can't read voice setting on hci0: Input/output error (5)

# hciconfig hci0 iac
Failed to read IAC from hci0: Input/output error

etc.

According to lsusb, this device is actually a USB hub with several other devices attached to it:

$ /sbin/lsusb
...
Bus 004 Device 018: ID 050d:016a Belkin Components 
Bus 004 Device 017: ID 0a5c:4503 Broadcom Corp. 
Bus 004 Device 016: ID 0a5c:4502 Broadcom Corp. 
Bus 004 Device 015: ID 0a5c:4500 Broadcom Corp.
...

usb 4-1: new full speed USB device using uhci_hcd and address 15
usb 4-1: configuration #1 chosen from 1 choice
hub 4-1:1.0: USB hub found
hub 4-1:1.0: 3 ports detected
usb 4-1.1: new full speed USB device using uhci_hcd and address 16
usb 4-1.1: configuration #1 chosen from 1 choice
input: HID 0a5c:4502 as /class/input/input12
input,hidraw0: USB HID v1.11 Keyboard [HID 0a5c:4502] on usb-0000:00:1d.2-1.1
usb 4-1.2: new full speed USB device using uhci_hcd and address 17
usb 4-1.2: configuration #1 chosen from 1 choice
input: HID 0a5c:4503 as /class/input/input13
input,hidraw1: USB HID v1.11 Mouse [HID 0a5c:4503] on usb-0000:00:1d.2-1.2
usb 4-1.3: new full speed USB device using uhci_hcd and address 18
usb 4-1.3: configuration #1 chosen from 1 choice
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb

Here are the device descriptors:

T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 15 Spd=12  MxCh= 3
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4500 Rev= 1.00
S:  Manufacturer=Broadcom
S:  Product=BCM2046B1
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 94mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=04 Lev=02 Prnt=15 Port=00 Cnt=01 Dev#= 16 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4502 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=04 Lev=02 Prnt=15 Port=01 Cnt=02 Dev#= 17 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4503 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=04 Lev=02 Prnt=15 Port=02 Cnt=03 Dev#= 18 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=050d ProdID=016a Rev= 3.88
S:  Manufacturer=Broadcom Corp
S:  Product=BLUETOOTH USB +EDR ADAPTER v2.1 UHE
S:  SerialNumber=000A3A8376DA
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:* If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

Obviously I would like to get this adapter working properly, so please let me know if there is anything that I can do to help. (Apart from fry my e1000/e1000e network adapters, that is ;-).)

Cheers,
Chris



      
