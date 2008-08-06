Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [patch]quirk implementation for btusb
Date: Wed, 6 Aug 2008 10:47:37 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808061047.38127.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This implements hci_usb's quirk handling to the btusb driver.

Signed-off-by: Oliver Neukum <oneukum@suse.de>

Done at last I hope.

	Regards
		Oliver

---

--- linux-2.6.26-vanilla/drivers/bluetooth/btusb.c	2008-08-01 10:53:38.000000000 +0200
+++ linux-2.6.26/drivers/bluetooth/btusb.c	2008-08-06 10:33:53.000000000 +0200
@@ -41,21 +41,108 @@
 #define BT_DBG(D...)
 #endif
 
-#define VERSION "0.1"
+#define VERSION "0.2"
+
+#define HCI_IGNORE		0x01
+#define HCI_RESET		0x02
+#define HCI_DIGIANSWER		0x04
+#define HCI_CSR			0x08
+#define HCI_SNIFFER		0x10
+#define HCI_BCM92035		0x20
+#define HCI_BROKEN_ISOC		0x40
+#define HCI_WRONG_SCO_MTU	0x80
 
 static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
 
+	/* AVM BlueFRITZ! USB v2.0 */
+	{ USB_DEVICE(0x057c, 0x3800) },
+
+	/* Bluetooth Ultraport Module from IBM */
+	{ USB_DEVICE(0x04bf, 0x030a) },
+
+	/* ALPS Modules with non-standard id */
+	{ USB_DEVICE(0x044e, 0x3001) },
+	{ USB_DEVICE(0x044e, 0x3002) },
+
+	/* Ericsson with non-standard id */
+	{ USB_DEVICE(0x0bdb, 0x1002) },
+
+	/* Canyon CN-BTU1 with HID interfaces */
+	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = HCI_RESET },
+
 	{ }	/* Terminating entry */
 };
 
 MODULE_DEVICE_TABLE(usb, btusb_table);
 
 static struct usb_device_id blacklist_table[] = {
+	/* CSR BlueCore devices */
+	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = HCI_CSR },
+
+	/* Broadcom BCM2033 without firmware */
+	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = HCI_IGNORE },
+
+	/* Broadcom BCM2035 */
+	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* Broadcom BCM2045 */
+	{ USB_DEVICE(0x0a5c, 0x2039), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x2101), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* IBM/Lenovo ThinkPad with Broadcom chip */
+	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* Targus ACB10US */
+	{ USB_DEVICE(0x0a5c, 0x2100), .driver_info = HCI_RESET },
+
+	/* ANYCOM Bluetooth USB-200 and USB-250 */
+	{ USB_DEVICE(0x0a5c, 0x2111), .driver_info = HCI_RESET },
+
+	/* HP laptop with Broadcom chip */
+	{ USB_DEVICE(0x03f0, 0x171d), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* Dell laptop with Broadcom chip */
+	{ USB_DEVICE(0x413c, 0x8126), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
+	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET },
+
+	/* Kensington Bluetooth USB adapter */
+	{ USB_DEVICE(0x047d, 0x105d), .driver_info = HCI_RESET },
+	{ USB_DEVICE(0x047d, 0x105e), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* ISSC Bluetooth Adapter v3.1 */
+	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },
+
+	/* RTX Telecom based adapters with buggy SCO support */
+	{ USB_DEVICE(0x0400, 0x0807), .driver_info = HCI_BROKEN_ISOC },
+	{ USB_DEVICE(0x0400, 0x080a), .driver_info = HCI_BROKEN_ISOC },
+
+	/* CONWISE Technology based adapters with buggy SCO support */
+	{ USB_DEVICE(0x0e5e, 0x6622), .driver_info = HCI_BROKEN_ISOC },
+
+	/* Belkin F8T012 and F8T013 devices */
+	{ USB_DEVICE(0x050d, 0x0012), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x050d, 0x0013), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* Digianswer devices */
+	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = HCI_DIGIANSWER },
+	{ USB_DEVICE(0x08fd, 0x0002), .driver_info = HCI_IGNORE },
+
+	/* CSR BlueCore Bluetooth Sniffer */
+	{ USB_DEVICE(0x0a12, 0x0002), .driver_info = HCI_SNIFFER },
+
+	/* Frontline ComProbe Bluetooth Sniffer */
+	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = HCI_SNIFFER },
 	{ }	/* Terminating entry */
 };
 
+static struct usb_driver btusb_driver;
+
 #define BTUSB_INTR_RUNNING	0
 #define BTUSB_BULK_RUNNING	1
 
@@ -78,6 +165,15 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *bulk_rx_ep;
 };
 
+static int ignore_dga;
+static int ignore_csr;
+static int ignore_sniffer;
+static int disable_scofix;
+#ifdef CONFIG_BT_HCIUSB_SCO
+static int force_scofix;
+#endif
+static int reset;
+
 static void btusb_intr_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
@@ -433,6 +529,7 @@ static int btusb_probe(struct usb_interf
 
 	BT_DBG("intf %p id %p", intf, id);
 
+	/* interface numbers are hardcoded in the spec */
 	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
 		return -ENODEV;
 
@@ -443,6 +540,15 @@ static int btusb_probe(struct usb_interf
 			id = match;
 	}
 
+	if (id->driver_info == HCI_IGNORE)
+		return -ENODEV;
+	if (ignore_sniffer && id->driver_info & HCI_SNIFFER)
+		return -ENODEV;
+	if (ignore_csr && id->driver_info & HCI_CSR)
+		return -ENODEV;
+	if (ignore_dga && id->driver_info & HCI_DIGIANSWER)
+		return -ENODEV;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -503,7 +609,15 @@ static int btusb_probe(struct usb_interf
 
 	hdev->owner = THIS_MODULE;
 
-	set_bit(HCI_QUIRK_RESET_ON_INIT, &hdev->quirks);
+	if (reset || id->driver_info & HCI_RESET)
+		set_bit(HCI_QUIRK_RESET_ON_INIT, &hdev->quirks);
+
+#ifdef CONFIG_BT_HCIUSB_SCO
+	if (force_scofix || id->driver_info & HCI_WRONG_SCO_MTU) {
+		if (!disable_scofix)
+			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
+	}
+#endif
 
 	err = hci_register_dev(hdev);
 	if (err < 0) {
@@ -558,6 +672,26 @@ static void __exit btusb_exit(void)
 module_init(btusb_init);
 module_exit(btusb_exit);
 
+module_param(reset, bool, 0644);
+MODULE_PARM_DESC(reset, "Skip HCI reset command on initialization");
+
+#ifdef CONFIG_BT_HCIUSB_SCO
+module_param(force_scofix, bool, 0644);
+MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
+#endif
+
+module_param(disable_scofix, bool, 0644);
+MODULE_PARM_DESC(disable_scofix, "Disable fixup of wrong SCO buffer size");
+
+module_param(ignore_csr, bool, 0644);
+MODULE_PARM_DESC(ignore_csr, "Ignore devices with id 0a12:0001");
+
+module_param(ignore_sniffer, bool, 0644);
+MODULE_PARM_DESC(ignore_sniffer, "Ignore devices with id 0a12:0002");
+
+module_param(ignore_dga, bool, 0644);
+MODULE_PARM_DESC(ignore_dga, "Ignore devices with id 08fd:0001");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Generic Bluetooth USB driver ver " VERSION);
 MODULE_VERSION(VERSION);
