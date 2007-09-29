Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 28 Sep 2007 22:58:06 -0300
MIME-Version: 1.0
Message-Id: <200709282258.06375.herton@mandriva.com.br>
Cc: benjamin_britten@yahoo.co.uk
Subject: [Bluez-devel] [PATCH] Disable ISOC transfers for ISSC KY-BT100
	Bluetooth Adapter
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Benjamin Britten reports that his Integrated System Solution Corp.
KY-BT100 Bluetooth Adapter (ID 1131:1001) floods syslog with
"hci_scodata_packet: hci0 SCO packet for unknown connection handle"
messages. So add a quirk for it to disable ISOC transfers. Reported at
http://qa.mandriva.com/show_bug.cgi?id=30638

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>
Cc: Benjamin Britten <benjamin_britten@yahoo.co.uk>

--- linux-2.6.22/drivers/bluetooth/hci_usb.c.orig	2007-09-26 02:50:38.000000000 -0300
+++ linux-2.6.22/drivers/bluetooth/hci_usb.c	2007-09-26 02:56:15.000000000 -0300
@@ -141,7 +141,7 @@ static struct usb_device_id blacklist_id
 	{ USB_DEVICE(0x047d, 0x105e), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
 
 	/* ISSC Bluetooth Adapter v3.1 */
-	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },
+	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
 
 	/* RTX Telecom based adapters with buggy SCO support */
 	{ USB_DEVICE(0x0400, 0x0807), .driver_info = HCI_BROKEN_ISOC },

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
