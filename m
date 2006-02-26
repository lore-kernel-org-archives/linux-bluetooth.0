Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Russell King <rmk@arm.linux.org.uk>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20060226224738.GF31256@flint.arm.linux.org.uk>
References: <20060226145934.GA18327@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060226145934.GA18327@hell.org.pl>
Subject: [Bluez-devel] Re: bug in hci_uart_tx_wakeup() causes panic when UART removed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 26 Feb 2006 22:47:38 +0000

On Sun, Feb 26, 2006 at 03:59:35PM +0100, Karol Kozimor wrote:
> Hi,
> Under specific circumstances, hci_uart_tx_wakeup() seems to call
> tty->driver->write() without checking if the tty is alive, which
> effectively causes a nasty panic in uart_write(). From what I've read so
> far it seems that hci_ldisc.c is to blame, so I'm reporting it here.
> 
> This is related to:
> http://sourceforge.net/mailarchive/message.php?msg_id=14724441
> 
> See also:
> http://bugme.osdl.org/show_bug.cgi?id=6131
> http://bugzilla.kernel.org/show_bug.cgi?id=5958

As a priority, I especially recommend bluetooth developers read:

http://bugzilla.kernel.org/show_bug.cgi?id=5958#c2

where bug 6131 was predicted.

-- 
Russell King


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
