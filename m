Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Russell King <rmk+bt@arm.linux.org.uk>
To: bluez-devel@lists.sf.net
Message-ID: <20040828182216.A24467@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] UART-based bluetooth stuff
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
Date: Sat, 28 Aug 2004 18:22:16 +0100

Hi,

Note: before anyone asks, I want to make it clear I do not have any
Bluetooth hardware. 8)


I'm digging about in the 8250 serial driver in 2.6 trying to clean up
the way we handle all the different UART variants.  I'm aware that BT
can use UARTs for communication.

I also know that some BT CF cards have OX950 UARTs in them.  Currently
these do not use the on-board hardware flow control capabilities, but
I'd like to correct that.  Since I don't have OX950 hardware to hand,
it's that's difficult to check the effects of that.

Does bluetooth use hardware flow control?  I'm lead to believe by BT
test program here that some BT serial protocols do and others don't.
Can someone clarify this.

Has anyone seen any other 8250-compatible UART types used for bluetooth?

Lastly, would they be willing victims^wtesters for serial patches? 8)

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
