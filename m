Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Fri, 1 Aug 2008 13:57:16 +0200
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <94E72E02-9C26-4FB4-8E0E-414B08E43F6A@holtmann.org>
In-Reply-To: <94E72E02-9C26-4FB4-8E0E-414B08E43F6A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808011357.16868.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag 31 Juli 2008 16:03:13 schrieb Marcel Holtmann:
> Both table updates should be a separate patch and we can even submit =A0
> that for 2.6.27 inclusion. I was just to lazy to do that, but I have =A0
> it on my todo list, but the Simple Pairing support had higher priority.

This patch implements the quirks from hci_usb in btusb, too.

Signed-off-by: Oliver Neukum <oneukum@suse.de>

	Regards
		Oliver

=2D--

=2D-- linux-2.6.22/drivers/bluetooth/btusb.c	2008-08-01 10:53:38.000000000 =
+0200
+++ linux-2.6.26/drivers/bluetooth/btusb.c	2008-08-01 13:47:54.000000000 +0=
200
@@ -41,21 +41,108 @@
 #define BT_DBG(D...)
 #endif
=20
=2D#define VERSION "0.1"
+#define VERSION "0.3"
+
+#define HCI_IGNORE		0x01
+#define HCI_RESET		0x02
+#define HCI_DIGIANSWER		0x04
+#define HCI_CSR			0x08
+#define HCI_SNIFFER		0x10
+#define HCI_BCM92035		0x20
+#define HCI_BROKEN_ISOC		0x40
+#define HCI_WRONG_SCO_MTU	0x80
=20
 static struct usb_device_id btusb_table[] =3D {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
=20
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
+	{ USB_DEVICE(0x0c10, 0x0000), .driver_info =3D HCI_RESET },
+
 	{ }	/* Terminating entry */
 };
=20
 MODULE_DEVICE_TABLE(usb, btusb_table);
=20
 static struct usb_device_id blacklist_table[] =3D {
+	/* CSR BlueCore devices */
+	{ USB_DEVICE(0x0a12, 0x0001), .driver_info =3D HCI_CSR },
+
+	/* Broadcom BCM2033 without firmware */
+	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info =3D HCI_IGNORE },
+
+	/* Broadcom BCM2035 */
+	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info =3D HCI_RESET | HCI_WRONG_SCO_=
MTU },
+	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info =3D HCI_RESET | HCI_WRONG_SCO_=
MTU },
+
+	/* Broadcom BCM2045 */
+	{ USB_DEVICE(0x0a5c, 0x2039), .driver_info =3D HCI_RESET | HCI_WRONG_SCO_=
MTU },
+	{ USB_DEVICE(0x0a5c, 0x2101), .driver_info =3D HCI_RESET | HCI_WRONG_SCO_=
MTU },
+
+	/* IBM/Lenovo ThinkPad with Broadcom chip */
+	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info =3D HCI_RESET | HCI_WRONG_SCO_=
MTU },
+	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info =3D HCI_RESET | HCI_WRONG_SCO_=
MTU },
+
+	/* Targus ACB10US */
+	{ USB_DEVICE(0x0a5c, 0x2100), .driver_info =3D HCI_RESET },
+
+	/* ANYCOM Bluetooth USB-200 and USB-250 */
+	{ USB_DEVICE(0x0a5c, 0x2111), .driver_info =3D HCI_RESET },
+
+	/* HP laptop with Broadcom chip */
+	{ USB_DEVICE(0x03f0, 0x171d), .driver_info =3D HCI_RESET | HCI_WRONG_SCO_=
MTU },
+
+	/* Dell laptop with Broadcom chip */
+	{ USB_DEVICE(0x413c, 0x8126), .driver_info =3D HCI_RESET | HCI_WRONG_SCO_=
MTU },
+
+	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
+	{ USB_DEVICE(0x045e, 0x009c), .driver_info =3D HCI_RESET },
+
+	/* Kensington Bluetooth USB adapter */
+	{ USB_DEVICE(0x047d, 0x105d), .driver_info =3D HCI_RESET },
+	{ USB_DEVICE(0x047d, 0x105e), .driver_info =3D HCI_RESET | HCI_WRONG_SCO_=
MTU },
+
+	/* ISSC Bluetooth Adapter v3.1 */
+	{ USB_DEVICE(0x1131, 0x1001), .driver_info =3D HCI_RESET },
+
+	/* RTX Telecom based adapters with buggy SCO support */
+	{ USB_DEVICE(0x0400, 0x0807), .driver_info =3D HCI_BROKEN_ISOC },
+	{ USB_DEVICE(0x0400, 0x080a), .driver_info =3D HCI_BROKEN_ISOC },
+
+	/* CONWISE Technology based adapters with buggy SCO support */
+	{ USB_DEVICE(0x0e5e, 0x6622), .driver_info =3D HCI_BROKEN_ISOC },
+
+	/* Belkin F8T012 and F8T013 devices */
+	{ USB_DEVICE(0x050d, 0x0012), .driver_info =3D HCI_RESET | HCI_WRONG_SCO_=
MTU },
+	{ USB_DEVICE(0x050d, 0x0013), .driver_info =3D HCI_RESET | HCI_WRONG_SCO_=
MTU },
+
+	/* Digianswer devices */
+	{ USB_DEVICE(0x08fd, 0x0001), .driver_info =3D HCI_DIGIANSWER },
+	{ USB_DEVICE(0x08fd, 0x0002), .driver_info =3D HCI_IGNORE },
+
+	/* CSR BlueCore Bluetooth Sniffer */
+	{ USB_DEVICE(0x0a12, 0x0002), .driver_info =3D HCI_SNIFFER },
+
+	/* Frontline ComProbe Bluetooth Sniffer */
+	{ USB_DEVICE(0x16d3, 0x0002), .driver_info =3D HCI_SNIFFER },
 	{ }	/* Terminating entry */
 };
=20
+static struct usb_driver btusb_driver;
+
 #define BTUSB_INTR_RUNNING	0
 #define BTUSB_BULK_RUNNING	1
=20
@@ -78,6 +165,16 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *bulk_rx_ep;
 };
=20
+static int ignore_dga;
+static int ignore_csr;
+static int ignore_sniffer;
+static int disable_scofix;
+#ifdef CONFIG_BT_HCIUSB_SCO
+static int force_scofix;
+#endif
+static int reset;
+static int override_ignore;
+
 static void btusb_intr_complete(struct urb *urb)
 {
 	struct hci_dev *hdev =3D urb->context;
@@ -433,6 +530,7 @@ static int btusb_probe(struct usb_interf
=20
 	BT_DBG("intf %p id %p", intf, id);
=20
+	/* interface numbers are hardcoded in the spec */
 	if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0)
 		return -ENODEV;
=20
@@ -443,6 +541,15 @@ static int btusb_probe(struct usb_interf
 			id =3D match;
 	}
=20
+	if (id->driver_info =3D=3D HCI_IGNORE && !override_ignore)
+		return -ENODEV;
+	if (ignore_sniffer && id->driver_info & HCI_SNIFFER)
+		return -ENODEV;
+	if (ignore_csr && id->driver_info & HCI_CSR)
+		return -ENODEV;
+	if (ignore_dga && id->driver_info & HCI_DIGIANSWER)
+		return -ENODEV;
+
 	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -503,7 +610,15 @@ static int btusb_probe(struct usb_interf
=20
 	hdev->owner =3D THIS_MODULE;
=20
=2D	set_bit(HCI_QUIRK_RESET_ON_INIT, &hdev->quirks);
+	if (reset || id->driver_info & HCI_RESET)
+		set_bit(HCI_QUIRK_RESET_ON_INIT, &hdev->quirks);
+
+#ifdef CONFIG_BT_HCIUSB_SCO
+	if (force_scofix || id->driver_info & HCI_WRONG_SCO_MTU) {
+		if (!disable_scofix)
+			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
+	}
+#endif
=20
 	err =3D hci_register_dev(hdev);
 	if (err < 0) {
@@ -558,6 +673,29 @@ static void __exit btusb_exit(void)
 module_init(btusb_init);
 module_exit(btusb_exit);
=20
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
+module_param(override_ignore, bool, 0644);
+MODULE_PARM_DESC(override_ignore, "Drive blacklisted devices");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Generic Bluetooth USB driver ver " VERSION);
 MODULE_VERSION(VERSION);
