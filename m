Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Steven Singer <steven.singer@csr.com>
In-Reply-To: <20040813163736.GC22763@bougret.hpl.hp.com>
References: <20040813002514.GA21388@bougret.hpl.hp.com>
	 <1092385877.28711.185.camel@pegasus>
	 <20040813163736.GC22763@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1092416234.28711.256.camel@pegasus>
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
Date: Fri, 13 Aug 2004 18:57:14 +0200

Hi Jean,

> > The D-Link dongle DBT-120 (Rev B3) can be updated using the Apple
> > firmware update file. After that it will be HCI 18.1 with default boot
> > mode set to HID.
> 
> 	This is exactly what I did. I have a rev B3, and I used Apple
> file.
> 	What do you mean default boot set to HID ? I look similar to
> what I'm seeing.

try running hid2hci :)

If this does not work, show us /proc/bus/usb/devices.

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
