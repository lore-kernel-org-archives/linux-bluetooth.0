Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ISSC USB Dongle does not work with current bluez?
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Krause <Andreas.Krause@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407231303.45860.Andreas.Krause@web.de>
References: <200407222124.44032.Andreas.Krause@web.de>
	 <200407231251.27478.Andreas.Krause@web.de>
	 <1090579838.4791.20.camel@pegasus>
	 <200407231303.45860.Andreas.Krause@web.de>
Content-Type: multipart/mixed; boundary="=-VXTxO08evq3evIxaj1ZN"
Message-Id: <1091269903.7891.121.camel@pegasus>
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
Date: Sat, 31 Jul 2004 12:31:44 +0200


--=-VXTxO08evq3evIxaj1ZN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andreas,

> > Another buggy Bluetooth chip with a stupid link manager. Is it really so
> > hard to get a correct HCI implementation before manufacturing end-user
> > products?
> 
> That means? Wait until you got one yourself and write a little hack for this 
> buggy chip? ;-)

it looks like that this device needs the HCI_Reset before it can run an
inquiry. Funny is that every other HCI command work without it. Try the
attached patch.

Regards

Marcel


--=-VXTxO08evq3evIxaj1ZN
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/bluetooth/hci_usb.c 1.53 vs edited =====
--- 1.53/drivers/bluetooth/hci_usb.c	2004-07-16 12:55:02 +02:00
+++ edited/drivers/bluetooth/hci_usb.c	2004-07-31 12:13:10 +02:00
@@ -98,6 +98,9 @@
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET },
 
+	/* ISSC Bluetooth Adapter v3.1 */
+	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },
+
 	/* Digianswer device */
 	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = HCI_DIGIANSWER },
 

--=-VXTxO08evq3evIxaj1ZN--



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
