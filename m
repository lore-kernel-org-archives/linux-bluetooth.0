Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Steven Singer <steven.singer@csr.com>
In-Reply-To: <20040813235333.GA5860@bougret.hpl.hp.com>
References: <20040813002514.GA21388@bougret.hpl.hp.com>
	 <1092385877.28711.185.camel@pegasus>
	 <20040813163736.GC22763@bougret.hpl.hp.com>
	 <1092416234.28711.256.camel@pegasus>
	 <20040813223412.GA3158@bougret.hpl.hp.com>
	 <1092440127.4501.73.camel@pegasus>
	 <20040813235333.GA5860@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1092441559.4501.92.camel@pegasus>
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
Date: Sat, 14 Aug 2004 01:59:19 +0200

Hi Jean,

> > your firmware update must be successful, because this looks like a
> > dongle with HCI 18.1 firmware in HID mode. Use hid2hci. It must work.
> 
> 	Found the reason. Under 2.6.X, hid2hci doesn't work. On the
> other hand, works fine in 2.4.X. And of course need to be done every
> time I plug the dongle.

I just checked it and it works under 2.6. I don't know what's wrong with
your kernel or system?

There exists a PS key for the boot mode that you can change to always
boot up the dongle in HCI mode.

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
