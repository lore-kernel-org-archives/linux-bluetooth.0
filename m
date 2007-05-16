Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oneukum@suse.de>
In-Reply-To: <200705161413.08514.oneukum@suse.de>
References: <200705161345.58587.oneukum@suse.de>
	<200705161355.22934.oneukum@suse.de> <1179317339.10069.73.camel@violet>
	<200705161413.08514.oneukum@suse.de>
Content-Type: multipart/mixed; boundary="=-Z+2BGKgtMSI/gxBs5a+j"
Date: Wed, 16 May 2007 14:22:37 +0200
Message-Id: <1179318157.10069.79.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net, linux-usb-devel@lists.sourceforge.net,
        maxk@qualcomm.com
Subject: Re: [Bluez-devel] [patch]quirky dongle for hci_usb
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-Z+2BGKgtMSI/gxBs5a+j
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Oliver,

> > > A user reported that his dongle needs a reset to work. A manual reset, the
> > > module option and that patch solved the issue.
> > 
> > an manual reset is not possible. The HCI_RESET quirk only end up sending
> > HCI Reset as the first command. This actually only resets the Bluetooth
> > chip and nothing on the USB bus. Only in cases of Broadcom HID proxy it
> > triggers the HID to HCI switch.
> > 
> > I am simply not convinced that this is a HID proxy adapter and thus this
> > patch is not needed at all.
> 
> Well,
> 
> have a look yourself:
> https://bugzilla.novell.com/show_bug.cgi?id=257303

I think that it is a userspace bug which we were dealing with for quite
some time, but it is safe to send HCI Reset. So lets do that for all
Broadcom based dongles.

Regards

Marcel


--=-Z+2BGKgtMSI/gxBs5a+j
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
index 406af57..caf9a3b 100644
--- a/drivers/bluetooth/hci_usb.c
+++ b/drivers/bluetooth/hci_usb.c
@@ -115,24 +115,24 @@ static struct usb_device_id blacklist_ids[] = {
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = HCI_BCM92035 },
 
 	/* IBM/Lenovo ThinkPad with Broadcom chip */
-	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = HCI_WRONG_SCO_MTU },
-	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
 
 	/* ANYCOM Bluetooth USB-200 and USB-250 */
 	{ USB_DEVICE(0x0a5c, 0x2111), .driver_info = HCI_RESET },
 
 	/* HP laptop with Broadcom chip */
-	{ USB_DEVICE(0x03f0, 0x171d), .driver_info = HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x03f0, 0x171d), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
 
 	/* Dell laptop with Broadcom chip */
-	{ USB_DEVICE(0x413c, 0x8126), .driver_info = HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x413c, 0x8126), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
 
 	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
 	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET },
 
 	/* Kensington Bluetooth USB adapter */
 	{ USB_DEVICE(0x047d, 0x105d), .driver_info = HCI_RESET },
-	{ USB_DEVICE(0x047d, 0x105e), .driver_info = HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x047d, 0x105e), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
 
 	/* ISSC Bluetooth Adapter v3.1 */
 	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },
@@ -142,8 +142,8 @@ static struct usb_device_id blacklist_ids[] = {
 	{ USB_DEVICE(0x0400, 0x080a), .driver_info = HCI_BROKEN_ISOC },
 
 	/* Belkin F8T012 and F8T013 devices */
-	{ USB_DEVICE(0x050d, 0x0012), .driver_info = HCI_WRONG_SCO_MTU },
-	{ USB_DEVICE(0x050d, 0x0013), .driver_info = HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x050d, 0x0012), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x050d, 0x0013), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
 
 	/* Digianswer devices */
 	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = HCI_DIGIANSWER },

--=-Z+2BGKgtMSI/gxBs5a+j
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-Z+2BGKgtMSI/gxBs5a+j
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-Z+2BGKgtMSI/gxBs5a+j--
