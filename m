Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth security in bluez ?
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403290053.32295.cijoml@volny.cz>
References: <20040328223546.2206.qmail@web60303.mail.yahoo.com>
	 <200403290053.32295.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1080514902.2281.183.camel@pegasus>
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
Date: Mon, 29 Mar 2004 01:01:42 +0200

Hi Thomas,

first if you start asking on a mailing list you should keep posting also
your answers to it.

> > ok but i'm intersted in how the security is
> > implemented (E0, E1, E21, E22, E3 algorithms) ... i'm
> > looking for the source code that does the
> > authentification and encryption. You mean that it's
> > done inside the dongle ?

The Bluetooth host stack only handles everything at the HCI level and
its upper layers. Everything down like link manager, baseband and radio
is part of the Bluetooth chip. And this also means that every security
mechanism is implemented in the chip. From the host side you can only
trigger them.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
