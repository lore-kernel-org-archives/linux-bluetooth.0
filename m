Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Oops on removing bluetooth CF card while in use
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: bluez-devel@lists.sf.net
In-Reply-To: <20060204223527.GA1903@elf.ucw.cz>
References: <20060204223527.GA1903@elf.ucw.cz>
Content-Type: multipart/mixed; boundary="=-kjS8box5ccr5pw4IFvSt"
Message-Id: <1139310158.13048.4.camel@localhost>
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
Date: Tue, 07 Feb 2006 12:02:38 +0100


--=-kjS8box5ccr5pw4IFvSt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Pavel,

> I'm getting small saga with CF bluetooth card... can anyone help?
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=5958

do you have the full oops message for me? However it has been a while
since I worked with serial line disciplines and the serial subsystem is
changing too often, that I lost track. Does the attached patch helps or
is the problem another one. Do we need to keep track of the hangup in
the serial subsystem?

Regards

Marcel


--=-kjS8box5ccr5pw4IFvSt
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 613673b..3366bba 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -192,7 +192,7 @@ static int hci_uart_flush(struct hci_dev
 
 	/* Flush any pending characters in the driver and discipline. */
 	tty_ldisc_flush(tty);
-	if (tty->driver->flush_buffer)
+	if (tty->driver && tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
 
 	if (test_bit(HCI_UART_PROTO_SET, &hu->flags))

--=-kjS8box5ccr5pw4IFvSt--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
