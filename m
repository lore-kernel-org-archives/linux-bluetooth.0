Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] zeevo acer dongle
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Maximilian Michel <michel@docomolab-euro.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>, max@3max.de
In-Reply-To: <3F28D21C.7000907@docomolab-euro.com>
References: <3F27DED9.3090706@docomolab-euro.com>
	<1059603475.1831.21.camel@pegasus>  <3F28D21C.7000907@docomolab-euro.com>
Content-Type: text/plain
Message-Id: <1059640831.1832.84.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 31 Jul 2003 10:40:24 +0200

Hi Maximilian,

> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS= 8 #Cfgs=  1
> P:  Vendor=0b7a ProdID=07d0 Rev= 1.34
> S:  SerialNumber=3EC08003i
> C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

and this is what I mean. They don't read the H:2 spec. and push out an
invalid product, because at least it must have this entry:

I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms

You can use one of my patches with this changelog entry

	- Quirk for devices with no ISOC endpoints

or you disable SCO support for the hci_usb driver at compile time.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
