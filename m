Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth USB dongle from Roper -- supported?
References: <a8f65f4b05041503367f9a46a7@mail.gmail.com>
In-Reply-To: <a8f65f4b05041503367f9a46a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504151253.27327.cijoml@volny.cz>
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
Date: Fri, 15 Apr 2005 12:53:25 +0200

call: hciconfig hci0 up

and try again

Michal


Dne p=E1 15. dubna 2005 12:36 Perry Ismangil napsal(a):
> I am using the bluez stack in kernel 2.6.10-1.770_FC3.
>
> When I plugin the usb class 1 dongle, hciconfig -a came up with:
>
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DH1 HV1
>         Link policy:
>         Link mode: SLAVE ACCEPT
>
> And cat /proc/bus/usb/devices
>
> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  8 Spd=3D12  M=
xCh=3D 0
> D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D1310 ProdID=3D0001 Rev=3D15.00
> S:  Manufacturer=3DSiW
> S:  Product=3DSiW
> S:  SerialNumber=3DF5CF040D0B00
> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 50mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
>
> Since most how-tos assume that hciconfig came up with something
> useful, I am now stuck. Any ideas?
>
> Thanks.

=2D-=20
S pozdravem

Michal Semler


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
