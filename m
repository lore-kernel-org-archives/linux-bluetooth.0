Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Karol Kozimor <sziwan@hell.org.pl>
To: bluez-devel@lists.sourceforge.net
Cc: rmk@arm.linux.org.uk
Message-ID: <20060226145934.GA18327@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Subject: [Bluez-devel] bug in hci_uart_tx_wakeup() causes panic when UART removed
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
Date: Sun, 26 Feb 2006 15:59:35 +0100

Hi,
Under specific circumstances, hci_uart_tx_wakeup() seems to call
tty->driver->write() without checking if the tty is alive, which
effectively causes a nasty panic in uart_write(). From what I've read so
far it seems that hci_ldisc.c is to blame, so I'm reporting it here.

This is related to:
http://sourceforge.net/mailarchive/message.php?msg_id=14724441

See also:
http://bugme.osdl.org/show_bug.cgi?id=6131
http://bugzilla.kernel.org/show_bug.cgi?id=5958

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
