Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY124-W46E88B992073AAD609A3BDA8FC0@phx.gbl>
References: <COL102-W12443FB0254944C58D2F2FA8020@phx.gbl>
	<e343e5940812050154i52fb8eb3x46cf6e73e5a0c8f9@mail.gmail.com>
	<BAY127-W1206CF6F607105AA558C2DA8FE0@phx.gbl>
	<89b6ba3a0812050920q1dea080i148d9c4677b6ed04@mail.gmail.com>
	<COL102-W7079DBA98D2EA5B8835568A8FF0@phx.gbl>
	<e343e5940812061301w368d0614s85e4f82938e76c3a@mail.gmail.com>
	<1228598050.28839.47.camel@violet.holtmann.net>
	<BAY124-W46E88B992073AAD609A3BDA8FC0@phx.gbl>
Date: Sun, 07 Dec 2008 18:18:39 +0100
Message-Id: <1228670319.28839.64.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] MA-720 does not work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Evgenios,

> and after mounting /proc/bus/usb/devices using  "sudo mount -t usbfs
> usbfs /proc/bus/usb"
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=1.5 MxCh= 0
> D:  Ver= 1.00 Cls=ff(vend.) Sub=ff Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0df7 ProdID=0722 Rev= 0.00
> S:  Manufacturer=MobileAction Technology Inc.
> S:  Product=Bluetooth Dongle
> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> E:  Ad=02(O) Atr=03(Int.) MxPS=   8 Ivl=10ms

this is not a Bluetooth dongle. At least not an usual one. It should
look like this:

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a12 ProdID=0001 Rev=53.60
C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

That is the bare minimum that btusb/hci_usb need as endpoints to
actually work properly.

If this is really a Bluetooth dongle, then it needs a custom driver to
make it work.

Regards

Marcel



------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
