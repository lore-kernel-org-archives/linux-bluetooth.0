Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can't get BT working on an iBook G4
References: <200408140030.10263.tcpdevil@linuxlover.org> <200408140048.14641.cijoml@volny.cz> <200408140140.08096.tcpdevil@linuxlover.org>
In-Reply-To: <200408140140.08096.tcpdevil@linuxlover.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408140155.29743.cijoml@volny.cz>
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
Date: Sat, 14 Aug 2004 01:55:29 +0200

Dne so 14. srpna 2004 01:40 Alberto Garcia Hierro napsal(a):
> El S=E1bado, 14 de Agosto de 2004 00:48, Bc. Michal Semler escribi=F3:
> > Possibly you need activate device with hid2hci tool
> >
> > Michal
>
> Thanks a lot, it's working fine now:

You are welcome. You should search mailing list back.=20

>
>
> americana ~ $ hid2hci -0
> Switching device 05ac:1000 to HCI mode was successful
> americana ~ $ hciconfig
> hci0:   Type: USB
>         BD Address: 00:0D:93:03:63:8E ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:107 acl:0 sco:0 events:14 errors:0
>         TX bytes:300 acl:0 sco:0 commands:13 errors:0
>
>
> 	By the way, is this mentioned in the docs at www.bluez.org?=20

I hope so...

> 	I couldn't =20
> find any reference to hid2hci. Anyway, I would like to know something more
> about hid2hci. Coul you point to somewhere with docs about it?

You should search mailing list back. Marcel posted a very good info few wee=
ks=20
ago. But long story short: It instruct device to switch from hid mode (usb=
=20
hid device) to hci mode (bt standart dongle)

Michal


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
