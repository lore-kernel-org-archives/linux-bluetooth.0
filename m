Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] What Bluetooth CF cards do developers use?
From: Marcel Holtmann <marcel@holtmann.org>
To: kyler-dated-1083420652.dfd739@lairds.com
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040428141637.GE1862@snout>
References: <20040428135604.GD1862@snout> <1083161388.4000.40.camel@pegasus>
	 <20040428141637.GE1862@snout>
Content-Type: text/plain
Message-Id: <1083162180.4000.45.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 28 Apr 2004 16:23:00 +0200

Hi Kyler,

> > someone just asked me the same question. Actually I don't know what's
> > the best CF card so far. The non working Socket 2.5 is very bad, but it
> > is not the fault of the Bluetooth developers, because I think the
> > problem is in the serial subsystem.
> 
> Has that been noted anywhere useful?

it has been raised on the serial mailing list, but the problem is that
nobody really knows where the problem is, because some cards are still
working.

> > Starting with 2.6.6-rc2 the Anycom
> > CF-300 is finally supported. Actually the card works in my development
> > machine.
> 
> Sounds like a winner.  I'll look for it.

Don't blame me if it don't works in a Zaurus ;)

> > And actually I don't use any CF card for development. I do everything
> > with Bluetooth development boards with USB and serial connectors.
> 
> I thought USB might be the answer so last week I bought two USB Bluetooth
> adapters (Belkin and Kensington).  Only one (barely) fits in the USB slot
> of my Toughbook.  The other fits enough to make contact but if I happen
> to bump either one out of the socket the kernel crashes.  That's not
> what I need when I'm on the road.

The USB related kernel oopses should all be fixed with the upcoming
2.6.6, I hope.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
