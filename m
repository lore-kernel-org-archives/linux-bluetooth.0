Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] UART-based bluetooth stuff
From: Marcel Holtmann <marcel@holtmann.org>
To: Russell King <rmk+bt@arm.linux.org.uk>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <20040828182216.A24467@flint.arm.linux.org.uk>
References: <20040828182216.A24467@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1093716721.8035.3.camel@pegasus>
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
Date: Sat, 28 Aug 2004 20:12:01 +0200

Hi Russel,

> I'm digging about in the 8250 serial driver in 2.6 trying to clean up
> the way we handle all the different UART variants.  I'm aware that BT
> can use UARTs for communication.
> 
> I also know that some BT CF cards have OX950 UARTs in them.  Currently
> these do not use the on-board hardware flow control capabilities, but
> I'd like to correct that.  Since I don't have OX950 hardware to hand,
> it's that's difficult to check the effects of that.
> 
> Does bluetooth use hardware flow control?  I'm lead to believe by BT
> test program here that some BT serial protocols do and others don't.
> Can someone clarify this.

at the moment some serial based PCMCIA or CF Bluetooth cards work and
some don't. I have no clue why this is so and I am no expert when it
comes to UART specific stuff. Some of these cards indeed work with a 2.4
kernel.

> Has anyone seen any other 8250-compatible UART types used for bluetooth?

Actually I think I have most of them at home. However there are a lot
more out there and it seems that any new PCMCIA of CF Bluetooth card is
a serial card with a Bluetooth chip attached to its UART.

> Lastly, would they be willing victims^wtesters for serial patches? 8)

I will do and I can also add them to my -mh patches.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
