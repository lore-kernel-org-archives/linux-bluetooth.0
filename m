Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: bug in hci_uart_tx_wakeup() causes panic
	when UART removed
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060226224738.GF31256@flint.arm.linux.org.uk>
References: <20060226145934.GA18327@hell.org.pl>
	 <20060226224738.GF31256@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1140998289.23559.18.camel@localhost>
Mime-Version: 1.0
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
Date: Mon, 27 Feb 2006 00:58:09 +0100

Hi Russell,

> > Under specific circumstances, hci_uart_tx_wakeup() seems to call
> > tty->driver->write() without checking if the tty is alive, which
> > effectively causes a nasty panic in uart_write(). From what I've read so
> > far it seems that hci_ldisc.c is to blame, so I'm reporting it here.
> > 
> > This is related to:
> > http://sourceforge.net/mailarchive/message.php?msg_id=14724441
> > 
> > See also:
> > http://bugme.osdl.org/show_bug.cgi?id=6131
> > http://bugzilla.kernel.org/show_bug.cgi?id=5958
> 
> As a priority, I especially recommend bluetooth developers read:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=5958#c2
> 
> where bug 6131 was predicted.

I saw that we didn't implement the hangup callback. Will it be
sufficient to use it to shutdown our HCI interface?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
