Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] What Bluetooth CF cards do developers use?
From: Marcel Holtmann <marcel@holtmann.org>
To: Kyler Laird <Kyler@Lairds.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040428135604.GD1862@snout>
References: <20040428135604.GD1862@snout>
Content-Type: text/plain
Message-Id: <1083161388.4000.40.camel@pegasus>
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
Date: Wed, 28 Apr 2004 16:09:48 +0200

Hi Kyler,

> So far I've bought three CF cards to use with BlueZ.  The first wasn't
> supported well at all.  The second set (Socket, without a protruding
> antenna) was slick but doesn't work with BlueZ under Linux 2.6.
> 
> I want to get something that will work under 2.6 and is likely to
> continue working for awhile (so that I don't have to convince my boss
> to keep buying new ones).  I suspect that the best way to do that is to
> get whatever the developers use.
> 
> So...what's a good choice?  I'd especially like to find something that
> will readily work with the Zaurus.  A product that is readily available
> at Best Buy/Circuit City/... is preferred.

someone just asked me the same question. Actually I don't know what's
the best CF card so far. The non working Socket 2.5 is very bad, but it
is not the fault of the Bluetooth developers, because I think the
problem is in the serial subsystem. Starting with 2.6.6-rc2 the Anycom
CF-300 is finally supported. Actually the card works in my development
machine.

And actually I don't use any CF card for development. I do everything
with Bluetooth development boards with USB and serial connectors.

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
