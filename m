Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2cap question
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Torens <c.torens@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opsda220m9eocfdv@debian>
References: <opsda220m9eocfdv@debian>
Content-Type: text/plain
Message-Id: <1093469385.537.17.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 25 Aug 2004 23:29:45 +0200

Hi Christoph,

> I have two questions:
> First:
> Is it possible to do a program communication just over l2cap?
> Without rfcomm/pand/dund.

it might be possible, but L2CAP is SOCK_SEQPACKET and RFCOMM is
SOCK_STREAM. You should keep this in mind and also is written in the
profile specifications.

> (Because after a very long time of tests, l2ping is the only
> thing that works with my USB host-controller chip / driver)
> If yes: Is there some small Tool I could use to test this?
> Perhaps read and write a string over l2cap.

Take a look at l2test and rctest from bluez-utils.

> Second:
> Does a Bluetooth USB-Dongle use isochronus USB transfers?
> And if yes: when or where?

It uses it for SCO support.

> (Because the USB host driver seems to have problems with
> isoc. transfers and I'm not sure if this actaully is the
> error I am fighting with)

Disable SCO support for the USB driver and no ISOC transfers are used.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
