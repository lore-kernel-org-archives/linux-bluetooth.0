Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Newbie2
From: Marcel Holtmann <marcel@holtmann.org>
To: Ricky Soh <rickysoh@gmail.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <db972f430408202022423be30a@mail.gmail.com>
References: <db972f4304081918374eb047c6@mail.gmail.com>
	 <1092989927.18082.56.camel@pegasus>
	 <db972f430408202022423be30a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1093072891.3544.6.camel@notepaq>
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
Date: Sat, 21 Aug 2004 09:21:32 +0200

Hi Ricky,

> I do not understand what you mean my loopback connection. I just
> trying to ping my bluetooth phone or pda using a laptop with bluetooth
> dongle. When i did a hcitool info (PDA's add), i got "can't create
> connection: Input/output error."
> 
> Sorry, i know this is a simple question but i really need some assistance here.

so don't use "hcitool cc ...", because this is for testing purpose only.
Use the rfcomm tool. Read the manpage for it and follow the examples
from the various howtos on the internet.

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
