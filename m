Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS multimedia keys
From: Marcel Holtmann <marcel@holtmann.org>
To: Walt <idunno2468@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <411EF7C7.10900@hotmail.com>
References: <411EF7C7.10900@hotmail.com>
Content-Type: text/plain
Message-Id: <1092555251.4375.19.camel@pegasus>
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
Date: Sun, 15 Aug 2004 09:34:13 +0200

Hi Walt,

> I have the ms bluetooth wireless desktop.  I was using kernel 2.6.7 
> patched, hidd  and hidp, and everything was fine.  I upgraded to 2.6.8, 
> first rc2 and now final, and the multimedia stopped working.  I checked 
> hcidump, and those keys, as well as the alt. function f* keys, dont 
> produce output. 

Use kernel 2.6.8-mh1, because the report protocol mode is not yet ready
for mainline. If you use a plain 2.6.8 you only get boot protocol mode
support.

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
