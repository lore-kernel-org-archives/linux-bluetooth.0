Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Steven Singer <steven.singer@csr.com>
In-Reply-To: <20040813002514.GA21388@bougret.hpl.hp.com>
References: <20040813002514.GA21388@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1092385877.28711.185.camel@pegasus>
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
Date: Fri, 13 Aug 2004 10:31:17 +0200

Hi Jean,

> 	A few questions regarding CSR firmware : what's a commonly
> available BT USB dongle with a recent CSR firmware.

as I know there are only dongles with HCI 16.14 firmware available.

> 	I'm hitting various bugs with the CSR firmware in my D-Link
> USB dongles (0x1bb), where I can easilly deadlock the dongle. My 3Com
> dongle, which has a more recent firmware (0x20e), behave much better,
> but not perfect.
> 	D-Link doesn't provide a firmware updater, but, beeing
> fearless, I tried to firmware upgrade a D-Link dongle and ended up
> with a dead dongle (can't even put back the original firmware on it).
> 	From the release notes, the latest CSR firmwares have zillions
> of bug fixes. I really wonder how I can enjoy the bug fixes.

The D-Link dongle DBT-120 (Rev B3) can be updated using the Apple
firmware update file. After that it will be HCI 18.1 with default boot
mode set to HID. Maybe other revisions of the D-Link dongle don't work
and I already put some of dongles to death while playing with firmware
upgrade.

> P.S. : Marcel, do you have a version of btdfu that can write the
> firmware image to the dongle ? Or some documentation ?

I never announced the new version of the btdfu, but now as you asked for
it, here it is:

	http://www.holtmann.org/linux/bluetooth/btdfu-0.3.tar.gz

Use it at your own risk, because you can kill your dongle !!!

Read what the CSR guys had written about signed firmware and that it is
not possible to move firmware from one manufacturer to another !!!

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
