Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dtl1_cs suspend bug
From: Marcel Holtmann <marcel@holtmann.org>
To: Justin Karneges <justin-qt@affinix.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200309231648.12696.justin-qt@affinix.com>
References: <200309220408.04569.justin-qt@affinix.com>
	<200309231444.09863.justin-qt@affinix.com>
	<1064355476.1619.51.camel@pegasus>
	<200309231648.12696.justin-qt@affinix.com>
Content-Type: text/plain
Message-Id: <1064367347.1620.67.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 24 Sep 2003 03:35:42 +0200

Hi Justin,

> I hadn't considered looking at Affix until you mentioned it just now.  After 
> looking through the code, I notice they do have more elaborate handling of 
> the UART, for instance the init_uart() function found in 
> affix-kernel/drivers/uart/btuart.c.  What does the Bluez dtl1_cs use for the 
> UART code?  It does not appear as obvious.

I only looked at the first Affix release and never looked again. But
from what I know is that the core of the UART driver is based on
serial_cs and they put more hacks into to get them working with the
their own and other Bluetooth cards with serial interface. And the
serial_cs driver itself is one of the "bad drivers" out their.

The UART on the DTL-1 card is not a normal UART and it uses the ring
indicator for some unusual flow control. So I decided to drive the UART
by myself.

> Has anyone here used Affix, and can they claim that suspend/resume works for 
> the DTL1 card?  I noticed the driver does have some handling functions, like 
> affix_uart_suspend() and affix_uart_resume(), which appear to simply detach / 
> reattach the driver from the HCI subsystem.  Under Bluez, such an action 
> would do just about nothing (in my experience anyway), but I think under 
> Affix, the act of attaching to the hci subsystem causes the hardware to be 
> affected also.  My guess is that init_uart gets called somwhere down the 
> line.

The register/unregister should also work with BlueZ, but you must make
sure that the UART is in the correct state, as I said previous.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
