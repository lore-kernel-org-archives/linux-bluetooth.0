Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040407172325.GC9593@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] No more bluez.o in 2.6?
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
Date: Wed, 7 Apr 2004 19:23:25 +0200

Hello,

I have an MSI-Max2-BLR with onboard bluetooth, lsmod shows that:
rfcomm                 22680  0=20
l2cap                  20228  5 rfcomm
ohci_hcd               16260  0=20
hci_usb                 9600  0=20
bluetooth              41060  5 rfcomm,l2cap,hci_usb

But hciconfig don't show anything... I am using kernel 2.6.5.
cat /proc/bus/usb/devices=20

T:  Bus=3D04 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.5 uhci_hcd
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
S:  Manufacturer=3DLinux 2.6.5 uhci_hcd
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
S:  Manufacturer=3DLinux 2.6.5 uhci_hcd
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
S:  Manufacturer=3DLinux 2.6.5 ehci_hcd
S:  Product=3DIntel Corp. 82801DB USB2
S:  SerialNumber=3D0000:00:1d.7
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D256ms

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D02 Cnt=3D01 Dev#=3D  3 Spd=3D480 M=
xCh=3D 0
D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D1005 ProdID=3Db113 Rev=3D 1.00
S:  Product=3DUSB Flash Drive
S:  SerialNumber=3D070B00090F811B0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D500mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50
Driver=3Dusb-storage
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D03 Cnt=3D02 Dev#=3D  2 Spd=3D480 M=
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

I use the bluez included in Mandrake 10:
bluez-hcidump-1.5-2mdk
libbluez1-2.5-1mdk
bluez-bluefw-0.9-2mdk
libbluez1-devel-2.5-1mdk
bluez-sdp-1.5-1mdk
bluez-pan-1.1-2mdk
libbluez-sdp2-1.5-1mdk
libbluez-sdp2-devel-1.5-1mdk
bluez-utils-2.4-4mdk
bluez-hciemu-1.0-2mdk

Is my bluetooth dongle not recognized or should I do something else?

Thank you very much,

	Gr=E9goire
_________________________________________________________________________=
_
http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.c=
h


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
