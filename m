Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FBBC46.8020601@tootai.com>
From: daniel huhardeaux <daniel.huhardeaux@tootai.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Connection issue with headset
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org>
In-Reply-To: <ctdn6n$sqs$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Sat, 29 Jan 2005 17:39:34 +0100

Sebastian Roth a =E9crit :

> Hi Daniel,

Hi Sebastian

>
>> nomade:/home/dh# btsco 00:0b:2e:06:01:2e
>> Device is 1:0
>> Voice setting: 0x0060
>> RFCOMM channel 6 connected
>
> You have to press the headset button now!

Headset was already on ;-) The only other information I receive when=20
plying with alsamixer is "speaker volume: 10 mic volume: 10" I also=20
tried to switch on the headset after launching btsco, same result.

Do you know what's the meaning of this 2 errors in hcidump?

>
> If this does not help please post the outputs of
> hciconfig hci0 revision (as root)

hci0:   Type: USB
        BD Address: 00:0C:41:E2:4C:B0 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI
dh@nomade:~$

> and
> cat /proc/bus/usb/devices

dh@nomade:~/music$ cat /proc/bus/usb/devices

T:  Bus=3D04 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D480 M=
xCh=3D 6
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.10custom.2 ehci_hcd
S:  Product=3DSilicon Integrated Systems [SiS] USB 2.0 Controller
S:  SerialNumber=3D0000:00:03.3
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D256ms

T:  Bus=3D03 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.10custom.2 ohci_hcd
S:  Product=3DSilicon Integrated Systems [SiS] USB 1.0 Controller (#3)
S:  SerialNumber=3D0000:00:03.2
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
B:  Alloc=3D 43/900 us ( 5%), #Int=3D  1, #Iso=3D  2
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.10custom.2 ohci_hcd
S:  Product=3DSilicon Integrated Systems [SiS] USB 1.0 Controller (#2)
S:  SerialNumber=3D0000:00:03.1
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  3 Spd=3D12  M=
xCh=3D 0
D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0a12 ProdID=3D0001 Rev=3D 5.25
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 2 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D00 Driver=
=3D(none)

T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.10custom.2 ohci_hcd
S:  Product=3DSilicon Integrated Systems [SiS] USB 1.0 Controller
S:  SerialNumber=3D0000:00:03.0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
dh@nomade:~/music$=20

Thanks a lot for your help.

--=20
Daniel  Huhardeaux       ______ _____ _____ ______ ______ __
enum    +48 32 285 5276 /_   _// _  // _  //_   _// __  // /
IAX FWD  +1 7009 422493  / /  / // // // /  / /  / /_/ // /
sip:101 h323:121  @voip./_/  /____//____/  /_/  /_/ /_//_/.com



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
