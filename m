Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?iso-8859-2?Q?de_Laurent?= <de_laurent@o2.pl>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-2";
Message-Id: <20040515163903.CB06543F94@rekin8.go2.pl>
Subject: [Bluez-users] =?iso-8859-2?Q?Bluez+2.6+Logitech_bluetooth?=
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
Date: Sat, 15 May 2004 18:39:03 +0200

Hi!
I'll try to describe my problem. Please forgive me if the answer is
simple, but I have been searching for a week for the solution...

So, I bought Logitech Desktop MX for Bluetooth (mouse, keyboard and
bluetooth hub as you probably know).=20
My distro is Slackware 9.1.
Kernel 2.6.6 (patched from 2.6.4 to 2.6.5 and to 2.6.6).

I patched the kernel first(as above). Then I downloaded the patch
from BlueZ site: patch-2.6.6-mh1 (all without errors). I added
aliases to modules.conf:
alias net-pf-31 bluez
alias bt-proto-0 l2cap
(and others for rfcomm, bnep and sco)
This is how my /proc/.../devices looks like:

T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.6-mh1 uhci_hcd
S:  Product=3DVIA Technologies, Inc. USB (#2)
S:  SerialNumber=3D0000:00:11.3
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
B:  Alloc=3D247/900 us (27%), #Int=3D  3, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.6-mh1 uhci_hcd
S:  Product=3DVIA Technologies, Inc. USB
S:  SerialNumber=3D0000:00:11.2
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D02 Dev#=3D  3 Spd=3D12  M=
xCh=3D 2
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0451 ProdID=3D2036 Rev=3D 1.01
S:  Product=3DGeneral Purpose USB Hub
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D255ms

T:  Bus=3D01 Lev=3D02 Prnt=3D03 Port=3D00 Cnt=3D01 Dev#=3D  4 Spd=3D1.5 M=
xCh=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D046d ProdID=3Dc703 Rev=3D24.04
S:  Manufacturer=3DLogitech
S:  Product=3DUSB Receiver
S:  SerialNumber=3D0C58B6
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 98mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D01 Driver=
=3Dhid
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D02 Driver=
=3Dhid
E:  Ad=3D82(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms

my lsmod give:
Module                  Size  Used by
l2cap                  21120  0=20
bluetooth              41956  1 l2cap
usbhid                 30336  0=20
usblp                  10944  0=20
uhci_hcd               29064  0=20
usbcore               104084  5 usbhid,usblp,uhci_hcd
and
hci_usb
sound modules, and so on.
If I tried to modprobe bluez (before modprobe bluetooth and l2cap) I=20
received "no bluez find"...
I did of course first compiled newest bluez-libs, utils and hciemu.
When I tried to hciconfig hci0 up it shows:
Can't get device info: No such device
When I tried to hid2hci, it hangs and I can't use the keyboard and
mouse.
I can use them normaly even without bluetooth, via usb.
This is my messages:
May 15 15:23:09 smith kernel: usbcore: registered new driver usbfs
May 15 15:23:09 smith kernel: usbcore: registered new driver hub
May 15 15:23:09 smith kernel: USB Universal Host Controller
Interface driver v2.2
May 15 15:23:09 smith kernel: uhci_hcd 0000:00:11.2: VIA
Technologies, Inc. USB
May 15 15:23:09 smith kernel: uhci_hcd 0000:00:11.2: irq 5, io base
0000d800
May 15 15:23:09 smith kernel: uhci_hcd 0000:00:11.2: new USB bus
registered, assigned bus number 1
May 15 15:23:09 smith kernel: uhci_hcd 0000:00:11.2: detected 2 ports
May 15 15:23:09 smith kernel: usb usb1: Product: VIA Technologies,
Inc. USB
May 15 15:23:09 smith kernel: usb usb1: Manufacturer: Linux
2.6.6-mh1 uhci_hcd
May 15 15:23:09 smith kernel: usb usb1: SerialNumber: 0000:00:11.2
May 15 15:23:09 smith kernel: hub 1-0:1.0: USB hub found
May 15 15:23:09 smith kernel: hub 1-0:1.0: 2 ports detected
May 15 15:23:09 smith kernel: uhci_hcd 0000:00:11.3: VIA
Technologies, Inc. USB (#2)
May 15 15:23:09 smith kernel: uhci_hcd 0000:00:11.3: irq 5, io base
0000dc00
May 15 15:23:09 smith kernel: uhci_hcd 0000:00:11.3: new USB bus
registered, assigned bus number 2
May 15 15:23:09 smith kernel: uhci_hcd 0000:00:11.3: detected 2 ports
May 15 15:23:09 smith kernel: usb usb2: Product: VIA Technologies,
Inc. USB (#2)
May 15 15:23:09 smith kernel: usb usb2: Manufacturer: Linux
2.6.6-mh1 uhci_hcd
May 15 15:23:09 smith kernel: usb usb2: SerialNumber: 0000:00:11.3
May 15 15:23:09 smith kernel: hub 2-0:1.0: USB hub found
May 15 15:23:09 smith kernel: hub 2-0:1.0: 2 ports detected
May 15 15:23:09 smith kernel: usb 1-1: new full speed USB device
using address 2
May 15 15:23:09 smith kernel: usb 1-1: Product: DeskJet 930C
May 15 15:23:09 smith kernel: usb 1-1: Manufacturer: Hewlett-Packard
May 15 15:23:09 smith kernel: usb 1-1: SerialNumber: ES05F1804RJJ
May 15 15:23:09 smith kernel: drivers/usb/class/usblp.c: usblp0: USB
Bidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x1204
May 15 15:23:09 smith kernel: usbcore: registered new driver usblp
May 15 15:23:09 smith kernel: drivers/usb/class/usblp.c: v0.13: USB
Printer Device Class driver
May 15 15:23:09 smith kernel: usb 1-2: new full speed USB device
using address 3
May 15 15:23:09 smith kernel: usb 1-2: Product: General Purpose USB Hub
May 15 15:23:09 smith kernel: hub 1-2:1.0: USB hub found
May 15 15:23:09 smith kernel: hub 1-2:1.0: 2 ports detected
May 15 15:23:09 smith kernel: usb 1-2.1: new low speed USB device
using address 4
May 15 15:23:09 smith kernel: usb 1-2.1: Product: USB Receiver
May 15 15:23:09 smith kernel: usb 1-2.1: Manufacturer: Logitech
May 15 15:23:09 smith kernel: usb 1-2.1: SerialNumber: 0C58B6
May 15 15:23:09 smith modprobe: FATAL: Module usbhid already in kernel.=20
May 15 15:23:09 smith usb.agent[861]: ... can't load module usbhid
May 15 15:23:09 smith usb.agent[861]: missing kernel or user mode
driver usbhid=20
May 15 15:23:09 smith modprobe: FATAL: Module mousedev not found.=20
May 15 15:23:09 smith kernel: usbcore: registered new driver hiddev
May 15 15:23:09 smith kernel: input: USB HID v1.10 Keyboard
[Logitech USB Receiver] on usb-0000:00:11.2-2.1
May 15 15:23:09 smith modprobe: FATAL: Module keybdev not found.=20
May 15 15:23:09 smith kernel: input,hiddev96: USB HID v1.10 Mouse
[Logitech USB Receiver] on usb-0000:00:11.2-2.1
May 15 15:23:09 smith kernel: usbcore: registered new driver hid
May 15 15:23:09 smith kernel: drivers/usb/input/hid-core.c: v2.0:USB
HID core driver

And my question is:
What do I wrong? Why doesn=B4t it work?=20

Waldemar




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
