Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] News about the Broadcom BCM92035DGL
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1107191003.7902.27.camel@pegasus>
References: <1107191003.7902.27.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-ebamRCIFKK8IwXYztIaf"
Message-Id: <1107433695.11944.48.camel@pegasus>
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
Date: Thu, 03 Feb 2005 13:28:15 +0100


--=-ebamRCIFKK8IwXYztIaf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

> the Broadcom dongles with the USB product id 0x2009 like the IOgear
> GBU311 need a special HCI vendor command to switch from HID into full
> HCI. Without this command the dongle is working, but only responses to
> commands in the OGF_INFO_PARAM class. This command is 3B FC 01 00 and
> the last byte toggles between HCI and HID mode.
> 
> < HCI Command: Vendor (0x3f|0x003b) plen 1
>   0000: 00                                                .
> > HCI Event: Command Complete (0x0e) plen 4
>   0000: 01 3b fc 00                                       .;..
> 
> Right now I have no solution how to integrate this so that it works
> nicely, because I don't wanna pollute the Bluetooth core with Broadcom
> specific hacks. However you can execute "hcitool cmd 3f 3b 00" by hand
> and after that the mouse and keyboard devices provided by this dongle
> should disconnect and you can fully use the Bluetooth part.

so everyone with the IOgear GBU311 or the Microsoft Wireless Transceiver
for Bluetooth 2.0 should test the attached kernel patch and report back.
The patch will apply cleanly against 2.6.10-mh3 and 2.6.11-rc3.

Regards

Marcel


--=-ebamRCIFKK8IwXYztIaf
Content-Disposition: attachment; filename=patch-bcm92035
Content-Type: text/plain; name=patch-bcm92035; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== include/net/bluetooth/hci_core.h 1.31 vs edited =====
--- 1.31/include/net/bluetooth/hci_core.h	2004-12-26 11:58:47 +01:00
+++ edited/include/net/bluetooth/hci_core.h	2005-02-02 05:05:57 +01:00
@@ -119,6 +119,8 @@
 
 	struct hci_dev_stats	stat;
 
+	struct sk_buff_head	driver_init;
+
 	void			*driver_data;
 	void			*core_data;
 
===== net/bluetooth/hci_core.c 1.35 vs edited =====
--- 1.35/net/bluetooth/hci_core.c	2005-01-29 03:27:20 +01:00
+++ edited/net/bluetooth/hci_core.c	2005-02-02 05:08:45 +01:00
@@ -183,10 +183,22 @@
 
 static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 {
+	struct sk_buff *skb;
 	__u16 param;
 
 	BT_DBG("%s %ld", hdev->name, opt);
 
+	/* Driver initialization */
+
+	/* Special commands */
+	while ((skb = skb_dequeue(&hdev->driver_init))) {
+		skb->pkt_type = HCI_COMMAND_PKT;
+		skb->dev = (void *) hdev;
+		skb_queue_tail(&hdev->cmd_q, skb);
+		hci_sched_cmd(hdev);
+	}
+	skb_queue_purge(&hdev->driver_init);
+
 	/* Mandatory initialization */
 
 	/* Reset */
@@ -792,6 +804,8 @@
 
 	memset(hdev, 0, sizeof(struct hci_dev));
 
+	skb_queue_head_init(&hdev->driver_init);
+
 	return hdev;
 }
 EXPORT_SYMBOL(hci_alloc_dev);
@@ -799,6 +813,8 @@
 /* Free HCI device */
 void hci_free_dev(struct hci_dev *hdev)
 {
+	skb_queue_purge(&hdev->driver_init);
+
 	/* will free via class release */
 	class_device_put(&hdev->class_dev);
 }
===== drivers/bluetooth/hci_usb.h 1.15 vs edited =====
--- 1.15/drivers/bluetooth/hci_usb.h	2005-01-29 03:32:12 +01:00
+++ edited/drivers/bluetooth/hci_usb.h	2005-02-01 01:54:30 +01:00
@@ -33,6 +33,7 @@
 #define HCI_DIGIANSWER		0x04
 #define HCI_SNIFFER		0x08
 #define HCI_BROKEN_ISOC		0x10
+#define HCI_BCM92035		0x20
 
 #define HCI_MAX_IFACE_NUM	3
 
===== drivers/bluetooth/hci_usb.c 1.65 vs edited =====
--- 1.65/drivers/bluetooth/hci_usb.c	2005-01-29 03:32:51 +01:00
+++ edited/drivers/bluetooth/hci_usb.c	2005-02-02 05:09:09 +01:00
@@ -73,7 +73,7 @@
 static int isoc = 2;
 #endif
 
-#define VERSION "2.7"
+#define VERSION "2.8"
 
 static struct usb_driver hci_usb_driver; 
 
@@ -104,11 +104,11 @@
 	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = HCI_IGNORE },
 
 	/* Broadcom BCM2035 */
-	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
+	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = HCI_BCM92035 },
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
 
 	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
-	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
+	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_BCM92035 },
 
 	/* ISSC Bluetooth Adapter v3.1 */
 	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },
@@ -975,6 +975,17 @@
 	if (id->driver_info & HCI_SNIFFER) {
 		if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x997)
 			set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
+	}
+
+	if (id->driver_info & HCI_BCM92035) {
+		unsigned char cmd[] = { 0x3b, 0xfc, 0x01, 0x00 };
+		struct sk_buff *skb;
+
+		skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
+		if (skb) {
+			memcpy(skb_put(skb, sizeof(cmd)), cmd, sizeof(cmd));
+			skb_queue_tail(&hdev->driver_init, skb);
+		}
 	}
 
 	if (hci_register_dev(hdev) < 0) {

--=-ebamRCIFKK8IwXYztIaf--



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
