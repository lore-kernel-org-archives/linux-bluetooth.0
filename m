Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Steven Singer <steven.singer@csr.com>
In-Reply-To: <20040813223412.GA3158@bougret.hpl.hp.com>
References: <20040813002514.GA21388@bougret.hpl.hp.com>
	 <1092385877.28711.185.camel@pegasus>
	 <20040813163736.GC22763@bougret.hpl.hp.com>
	 <1092416234.28711.256.camel@pegasus>
	 <20040813223412.GA3158@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1092440127.4501.73.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: CSR firmware question...
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 14 Aug 2004 01:35:27 +0200

Hi Jean,

> > try running hid2hci :)
> 
> 	Try, and it won't work, the device doesn't even have a control
> pipe anymore. Dead.

as far as I know, every USB device has a control endpoint.

> > If this does not work, show us /proc/bus/usb/devices.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  5 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0a12 ProdID=1000 Rev=12.41
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=(none)
> E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> 
> 	(That's with 2.4.X. Under 2.6.X, I can't make sense of the usb stuff).

your firmware update must be successful, because this looks like a
dongle with HCI 18.1 firmware in HID mode. Use hid2hci. It must work.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
