Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2cap question
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Torens <c.torens@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opsdd839qmeocfdv@debian>
References: <opsda220m9eocfdv@debian> <1093469385.537.17.camel@pegasus>
	 <opsdbdbhfdeocfdv@debian> <1093516424.2581.1.camel@pegasus>
	 <opsdd839qmeocfdv@debian>
Content-Type: text/plain
Message-Id: <1093616025.2581.159.camel@pegasus>
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
Date: Fri, 27 Aug 2004 16:13:45 +0200

Hi Christoph,

> > show me the "hciconfig -a" and "/proc/bus/usb/devices" for these dongles
> > and I will mark them with broken SCO support.
> 
> ok, here it follows. But I dond't understand, I thought my hostcontroller  
> has
> isoc problems? But Why does this dongle have problems with the command and  
> the
> Acer BT510 Zeevo chip not?

the Zeevo Chip has no ISOC endpoints and is already broken in some way.

> The device with problems is a EPoX BT-DG02A

I can't blacklist this device and it should also work prefect. Maybe
this is a problem of your USB host controller.

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
