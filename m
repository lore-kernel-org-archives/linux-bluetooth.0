Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Kernel 2.6.8 final and AVM BlueFritz
From: Marcel Holtmann <marcel@holtmann.org>
To: Sigrid Kronenberger <skronenberger@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040815222056.2160d599@localhost>
References: <20040815222056.2160d599@localhost>
Content-Type: text/plain
Message-Id: <1092645125.4375.83.camel@pegasus>
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
Date: Mon, 16 Aug 2004 10:32:05 +0200

Hi Sigrid,

> [root@localhost sigrid]# ciptool search
> Searching ...
>         Checking service for 00:04:0E:81:71:87
>         Connecting to device 00:04:0E:81:71:87
> Local device is not accepting role switch
> Can't connect L2CAP socket: Connection refused
> [root@localhost sigrid]#
> 
> How can I change the last point? My AP don't accept the role switch. 

Take a look at my Bluetooth ISDN howto:

	http://www.holtmann.org/linux/bluetooth/isdn.html

And of course make sure that hcid is running.

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
