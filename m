Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001501c3457d$18b63a10$1a01010a@baked>
References: <001501c3457d$18b63a10$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1057913731.1027.11.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Qualification testing - rfcomm
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 11 Jul 2003 10:55:24 +0200

Hi Daryl,

> Finally got some results on those latest rfcomm changes for qualification.
> Looks like there are a few more problems. :(  But we're close. :)
> 
> TP/RFC/BV-09-C:
> "Verify that the IUT handles flow control correctly when the Tester, acting
> as a device conforming to Bluetooth version 1.0B, controls the data flow
> using the Modem Status Command. The IUT's device role is of no importance."
> 
> The command and console output:
> 
> root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> rctest[351]: Connected
> rctest[351]: Sending ...
> rctest[351]: Send failed. Resource temporarily unavailable(11)
> 
> The IUT sends data in 5 frames, then stops for aboue 20s, then sends 5 more,
> then stops, etc. Technically, this test passed because we did stop sending
> data after the tester send MSC stop to the IUT. But something's clearly not
> right.

this looks quite right, but the rctest program don't check the error
code. If it receives EAGAIN it should try again, but it aborts.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
