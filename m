Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Modifying Device Class....
From: Marcel Holtmann <marcel@holtmann.org>
To: David Stennett <praefectus@gmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1aef622504083013322eccbeb4@mail.gmail.com>
References: <1aef622504083013322eccbeb4@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1093899829.5620.105.camel@pegasus>
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
Date: Mon, 30 Aug 2004 23:03:50 +0200

Hi David,

> I know that the Bluetooth spec has different devices classes (0x100,
> etc...) ... my question is, can we create our own?  That way, if I
> created a client to find only (0x12345), my BlueZ box could have a
> device class of 0x12345 or something) .... or, is this not possible?

in general it is only a 3 byte value and you can use everything you like
as long as the other side knows about it. I think there are some free
values and extension bits that you should use for that and not using
some free choosen value.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
