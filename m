Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Digianswer USB driver
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: "Jan J. Jessen" <jjjessen@control.auc.dk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: 
	<Pine.GSO.4.40.0308261317320.19084-100000@prosit.control.auc.dk>
References: <Pine.GSO.4.40.0308261317320.19084-100000@prosit.control.auc.dk>
Message-Id: <1062202301.11258.19.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 30 Aug 2003 02:11:35 +0200
Content-Type: multipart/mixed; boundary="=-LBtt+MFjhe7jqZEkS6IZ"


--=-LBtt+MFjhe7jqZEkS6IZ
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hi Jan,

> > Changing the bRequestType is such an ugly hack, but on the other side it
> > is a very simple change to get these devices supported by hci_usb. I
> > will write a patch for supporting Digianswer devices and H:2 Bluetooth
> > devices at the same time, but I need some more information about the
> > your device. Please send me the output of "cat /proc/bus/usb/devices"
> > and "hciconfig -a".
> 
> At the moment my Linux dist is having a vacation! Can you do with vendor
> and product IDs? From my own driver:
> 
> /* Digianswer specific values */
> #define USB_DIGI_VENDOR_ID    0x08fd
> #define USB_DIGI_PRODUCT_ID   0x1
> #define BLUETOOTH_REQ_TYPE    0x40
> 
> I hope this will do.

attached is a patch which modifies the hci_usb.o driver to deal with
normal H:2 and the Digianswer devices. Please test it and send me a
report with "hciconfig -a" and "cat /proc/bus/usb/devices".

Regards

Marcel


--=-LBtt+MFjhe7jqZEkS6IZ
Content-Disposition: attachment; filename=patch-hci-usb-digianswer
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; NAME=patch-hci-usb-digianswer; CHARSET=ISO-8859-15

diff -urN linux-2.4.22/drivers/bluetooth/hci_usb.c linux-2.4.22-digianswer/=
drivers/bluetooth/hci_usb.c
--- linux-2.4.22/drivers/bluetooth/hci_usb.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.22-digianswer/drivers/bluetooth/hci_usb.c	Sat Aug 30 01:59:59=
 2003
@@ -79,6 +79,9 @@
 	/* Bluetooth Ultraport Module from IBM */
 	{ USB_DEVICE(0x04bf, 0x030a) },
=20
+	/* Digianswer device */
+	{ USB_DEVICE(0x08fd, 0x0001), driver_info: HCI_DIGIANSWER },
+
 	{ }	/* Terminating entry */
 };
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
+++ linux-2.4.22-digianswer/drivers/bluetooth/hci_usb.h	Sat Aug 30 02:02:46=
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

--=-LBtt+MFjhe7jqZEkS6IZ--
