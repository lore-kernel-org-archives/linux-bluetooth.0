Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] dual boot keyboard wont connect
From: Marcel Holtmann <marcel@holtmann.org>
To: Walt <idunno2468@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <412E677C.1040807@hotmail.com>
References: <412E57F2.6040303@hotmail.com>
	 <1093558926.2581.72.camel@pegasus>  <412E677C.1040807@hotmail.com>
Content-Type: text/plain
Message-Id: <1093563783.2581.78.camel@pegasus>
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
Date: Fri, 27 Aug 2004 01:43:03 +0200

Hi Walter,

> No, should I?

No.

>     # PIN helper
>     #pin_helper /usr/bin/bluepin;
>     /etc/bluetooth/pin;
>     # D-Bus PIN helper
>     #dbus_pin_helper;

But this part is wrong here. Use "pin_helper /usr/bin/mybluepin;" and
make mybluepin a script that echos "PIN:1234" where 1234 is your actual
PIN.

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
