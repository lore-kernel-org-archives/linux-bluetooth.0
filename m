Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Digianswer USB driver
From: Marcel Holtmann <marcel@holtmann.org>
To: "Jan J. Jessen" <jjjessen@control.auc.dk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: 
	<Pine.GSO.4.40.0309171153080.23244-100000@prosit.control.auc.dk>
References: <Pine.GSO.4.40.0309171153080.23244-100000@prosit.control.auc.dk>
Content-Type: multipart/mixed; boundary="=-mlLHVZL94gMTXiE7rXUg"
Message-Id: <1064253565.5641.126.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 22 Sep 2003 19:59:19 +0200


--=-mlLHVZL94gMTXiE7rXUg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jan,

> I've compiled a kernel with MODVERSION and now hci_usb loads without
> trouble. I've tried to do hciconfig hci0 up but this gives:
> Can't init device hci0. Connection timed out(110)

what about this patch?

Regards

Marcel



--=-mlLHVZL94gMTXiE7rXUg
Content-Disposition: attachment; filename=patch-hci-usb-digianswer2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch-hci-usb-digianswer2; charset=ISO-8859-15

diff -urN linux-2.4.22/drivers/bluetooth/hci_usb.c linux-2.4.22-digianswer/=
drivers/bluetooth/hci_usb.c
--- linux-2.4.22/drivers/bluetooth/hci_usb.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.22-digianswer/drivers/bluetooth/hci_usb.c	Mon Sep 22 19:57:15=
 2003
@@ -70,6 +70,9 @@
 static struct usb_driver hci_usb_driver;=20
=20
 static struct usb_device_id bluetooth_ids[] =3D {
+	/* Digianswer device */
+	{ USB_DEVICE(0x08fd, 0x0001), driver_info: HCI_DIGIANSWER },
+
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(HCI_DEV_CLASS, HCI_DEV_SUBCLASS, HCI_DEV_PROTOCOL) },
=20
@@ -427,7 +430,7 @@
 	} else
 		dr =3D (void *) _urb->urb.setup_packet;
=20
-	dr->bRequestType =3D HCI_CTRL_REQ;
+	dr->bRequestType =3D husb->ctrl_req;
 	dr->bRequest =3D 0;
 	dr->wIndex   =3D 0;
 	dr->wValue   =3D 0;
@@ -872,6 +875,11 @@
 	husb->bulk_out_ep =3D bulk_out_ep[0];
 	husb->bulk_in_ep  =3D bulk_in_ep[0];
 	husb->intr_in_ep  =3D intr_in_ep[0];
+
+	if (id->driver_info & HCI_DIGIANSWER)
+		husb->ctrl_req =3D HCI_DIGI_REQ;
+	else
+		husb->ctrl_req =3D HCI_CTRL_REQ;
=20
 #ifdef CONFIG_BLUEZ_USB_SCO
 	if (isoc_iface) {
diff -urN linux-2.4.22/drivers/bluetooth/hci_usb.h linux-2.4.22-digianswer/=
drivers/bluetooth/hci_usb.h
--- linux-2.4.22/drivers/bluetooth/hci_usb.h	Fri Jun 13 16:51:32 2003
+++ linux-2.4.22-digianswer/drivers/bluetooth/hci_usb.h	Mon Sep 22 19:56:44=
 2003
@@ -35,6 +35,9 @@
 #define HCI_DEV_PROTOCOL     0x01	/* Bluetooth programming protocol */
=20
 #define HCI_CTRL_REQ	     0x20
+#define HCI_DIGI_REQ	     0x40
+
+#define HCI_DIGIANSWER       0x01
=20
 #define HCI_MAX_IFACE_NUM	3=20
=20
@@ -118,6 +121,8 @@
 	struct usb_interface            *isoc_iface;
 	struct usb_endpoint_descriptor	*isoc_out_ep;
 	struct usb_endpoint_descriptor	*isoc_in_ep;
+
+	__u8			ctrl_req;
=20
 	struct sk_buff_head	transmit_q[4];
 	struct sk_buff		*reassembly[4]; // Reassembly buffers

--=-mlLHVZL94gMTXiE7rXUg--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
