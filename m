Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1c464970511062228p1bafdf87mcef1cf3a77deb47c@mail.gmail.com>
From: Trevor Joynson <trevorjoynson@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: Logitech diNovo Media Desktop Laser patch
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 7 Nov 2005 01:28:47 -0500

> Marcel Holtmann
> Is this patch really needed?

Well, I just upgraded to 2.6.14 with 2.6.14-mh2, and it doesn't work,
with and without the hci_usb.c patch I used. hciconfig just shows the
mac address of 00's.

Anyways, I went back to 2.6.13, with the hci_usb.c patch. Works fine.
I'll try it without it, I just have to recompile my kernel with a new
version of gcc. ( reinstalled gentoo using gcc4 ). I'd do it now, but
I want to get this email out before I head to work.

I also found out that the patch I sent you earlier for hid2hci.c did
not work. Apparently, 0x046d:0x0b02 was not the correct device from
the usb controller to do the switching to. Adding all three:
{ HCI, 0x046d, 0xc70c, switch_logitech },
{ HCI, 0x046d, 0xc70b, switch_logitech },
{ HCI, 0x046d, 0x0b02, switch_logitech },
worked though. Perhaps it's 0xc70c?

=3D=3D=3D=3D=3D Before hid2hci:
# cat /proc/bus/usb/devices
T:  Bus=3D04 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.13-angel1 uhci_hcd
S:  Product=3DIntel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB
UHCI Controller #3
S:  SerialNumber=3D0000:00:1d.2
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D03 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D 45/900 us ( 5%), #Int=3D  3, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.13-angel1 uhci_hcd
S:  Product=3DIntel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB
UHCI Controller #2
S:  SerialNumber=3D0000:00:1d.1
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  5 Spd=3D12  MxC=
h=3D 3
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D046d ProdID=3D0b02 Rev=3D40.00
S:  Manufacturer=3DLogitech
S:  Product=3DLogitech BT Mini-Receiver
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D255ms

T:  Bus=3D03 Lev=3D02 Prnt=3D05 Port=3D01 Cnt=3D01 Dev#=3D  6 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D046d ProdID=3Dc70b Rev=3D40.00
S:  Manufacturer=3DLogitech
S:  Product=3DLogitech BT Mini-Receiver
S:  SerialNumber=3D000761412D91
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 98mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D01 Driver=
=3Dusbhid
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms

T:  Bus=3D03 Lev=3D02 Prnt=3D05 Port=3D02 Cnt=3D02 Dev#=3D  7 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D046d ProdID=3Dc70c Rev=3D40.00
S:  Manufacturer=3DLogitech
S:  Product=3DLogitech BT Mini-Receiver
S:  SerialNumber=3D000761412D91
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 98mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D02 Driver=
=3Dusbhid
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D5ms

T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.13-angel1 uhci_hcd
S:  Product=3DIntel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB
UHCI Controller #1
S:  SerialNumber=3D0000:00:1d.0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D480 MxC=
h=3D 6
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.13-angel1 ehci_hcd
S:  Product=3DIntel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Control=
ler
S:  SerialNumber=3D0000:00:1d.7
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D256ms

=3D=3D=3D=3D=3D After hid2hci using all three devices:
--- devices_before     2005-11-07 00:46:33.000000000 -0500
+++ devices_after       2005-11-07 01:18:10.000000000 -0500
@@ -11,7 +11,7 @@
 E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

 T:  Bus=3D03 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  Mx=
Ch=3D 2
-B:  Alloc=3D 45/900 us ( 5%), #Int=3D  3, #Iso=3D  0
+B:  Alloc=3D 72/900 us ( 8%), #Int=3D  4, #Iso=3D  2
 D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
 P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
 S:  Manufacturer=3DLinux 2.6.13-angel1 uhci_hcd
@@ -30,7 +30,41 @@
 I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
 E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D255ms

-T:  Bus=3D03 Lev=3D02 Prnt=3D05 Port=3D01 Cnt=3D01 Dev#=3D  6 Spd=3D12  Mx=
Ch=3D 0
+T:  Bus=3D03 Lev=3D02 Prnt=3D05 Port=3D00 Cnt=3D01 Dev#=3D  8 Spd=3D12  Mx=
Ch=3D 0
+D:  Ver=3D 2.00 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
+P:  Vendor=3D046d ProdID=3Dc709 Rev=3D40.00
+S:  Manufacturer=3DLogitech
+S:  Product=3DLogitech BT Mini-Receiver
+S:  SerialNumber=3D000761412D91
+C:* #Ifs=3D 4 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 98mA
+I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
+E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
+E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
+E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
+I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
+E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
+E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
+I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
+E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
+E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
+I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
+E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
+E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
+I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
+E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  32 Ivl=3D1ms
+E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  32 Ivl=3D1ms
+I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
+E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  64 Ivl=3D1ms
+E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  64 Ivl=3D1ms
+I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
+E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  64 Ivl=3D1ms
+E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  64 Ivl=3D1ms
+I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3D(none)
+E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
+E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
+I:  If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D00 Driver=
=3D(none)
+
+T:  Bus=3D03 Lev=3D02 Prnt=3D05 Port=3D01 Cnt=3D02 Dev#=3D  6 Spd=3D12  Mx=
Ch=3D 0
 D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
 P:  Vendor=3D046d ProdID=3Dc70b Rev=3D40.00
 S:  Manufacturer=3DLogitech
@@ -40,7 +74,7 @@
 I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D01 Driver=
=3Dusbhid
 E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms

-T:  Bus=3D03 Lev=3D02 Prnt=3D05 Port=3D02 Cnt=3D02 Dev#=3D  7 Spd=3D12  Mx=
Ch=3D 0
+T:  Bus=3D03 Lev=3D02 Prnt=3D05 Port=3D02 Cnt=3D03 Dev#=3D  7 Spd=3D12  Mx=
Ch=3D 0
 D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
 P:  Vendor=3D046d ProdID=3Dc70c Rev=3D40.00
 S:  Manufacturer=3DLogitech

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:07:61:41:2D:91 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:109755 acl:6123 sco:0 events:262 errors:0
        TX bytes:2589 acl:63 sco:0 commands:87 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'frylock'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP Subver: 0=
x413a
        Manufacturer: Broadcom Corporation (15)

Thanks
--
// Trevor Joynson
\\ http://intheskywithdiamonds.net
// trevorjoynson@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
