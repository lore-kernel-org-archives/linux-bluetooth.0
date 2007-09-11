Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000001c7f41c$0436cb70$3701a8c0@YANNIS>
References: <000001c7f41c$0436cb70$3701a8c0@YANNIS>
Date: Tue, 11 Sep 2007 06:54:35 +0200
Message-Id: <1189486475.7893.36.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] USB Linux support for MA-720
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,
 
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  2 Spd=1.5 MxCh= 0
> D:  Ver= 1.00 Cls=ff(vend.) Sub=ff Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0df7 ProdID=0722 Rev= 0.00
> S:  Manufacturer=MobileAction Technology Inc.
> S:  Product=Bluetooth Dongle
> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> E:  Ad=02(O) Atr=03(Int.) MxPS=   8 Ivl=10ms

that actually is a non-default Bluetooth dongle. Seems they need its own
special driver. I would need a hardware sample to say more.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
