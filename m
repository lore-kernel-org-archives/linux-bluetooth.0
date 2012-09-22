Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel@holtmann.org
Cc: johan.hedberg@intel.com, albert.o.ho@intel.com, tedd.hj.an@gmail.com
Subject: [RFC 1/2] Bluetooth: Add driver extension for vendor specific init
Date: Fri, 21 Sep 2012 18:59:51 -0700
Message-ID: <39660287.XHkFNqYcyS@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch provides an extension of btusb to support device vendor
can implement their own module to execute the vendor specific
device initialization before the stack sends generic BT device
initialization.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c        |  191 +++++++++++++++++++++++++-------------
 drivers/bluetooth/btusb.h        |   53 +++++++++++
 include/net/bluetooth/hci_core.h |   10 ++
 net/bluetooth/hci_core.c         |   15 ++-
 4 files changed, 204 insertions(+), 65 deletions(-)
 create mode 100644 drivers/bluetooth/btusb.h

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f637c25..afa1558 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -26,6 +26,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include "btusb.h"
 
 #define VERSION "0.6"
 
@@ -39,14 +40,59 @@ static bool reset = 1;
 
 static struct usb_driver btusb_driver;
 
-#define BTUSB_IGNORE		0x01
-#define BTUSB_DIGIANSWER	0x02
-#define BTUSB_CSR		0x04
-#define BTUSB_SNIFFER		0x08
-#define BTUSB_BCM92035		0x10
-#define BTUSB_BROKEN_ISOC	0x20
-#define BTUSB_WRONG_SCO_MTU	0x40
-#define BTUSB_ATH3012		0x80
+/*
+ * Create btusb_driver_info struct for each driver_info flags used by
+ * blacklist since vendor's btusb driver will return btusb_driver_info struct.
+ */
+
+/*
+ * if the device is set to this, this menas that the device is generic and
+ * doesn't require any vendor specific handling
+ */
+static const struct btusb_driver_info generic = {
+	.description	= "BTUSB Generic",
+	.flags		= BTUSB_GENERIC,
+};
+
+static const struct btusb_driver_info ignore = {
+	.description	= "BTUSB Ignore",
+	.flags		= BTUSB_IGNORE,
+};
+
+static const struct btusb_driver_info digianswer = {
+	.description	= "BTUSB DIGIANSWER",
+	.flags		= BTUSB_DIGIANSWER,
+};
+
+static const struct btusb_driver_info csr = {
+	.description	= "BTUSB CSR",
+	.flags		= BTUSB_CSR,
+};
+
+static const struct btusb_driver_info sniffer = {
+	.description	= "BTUSB Sniffer",
+	.flags		= BTUSB_SNIFFER,
+};
+
+static const struct btusb_driver_info bcm92035 = {
+	.description	= "BTUSB BCM92035",
+	.flags		= BTUSB_BCM92035,
+};
+
+static const struct btusb_driver_info broken_isoc = {
+	.description	= "BTUSB Broken ISOC",
+	.flags		= BTUSB_BROKEN_ISOC,
+};
+
+static const struct btusb_driver_info wrong_sco_mtu = {
+	.description	= "BTUSB Wrong SCO MTU",
+	.flags		= BTUSB_WRONG_SCO_MTU,
+};
+
+static const struct btusb_driver_info ath3012 = {
+	.description	= "BTUSB Ath3012",
+	.flags		= BTUSB_ATH3012,
+};
 
 static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -105,90 +151,89 @@ static struct usb_device_id btusb_table[] = {
 
 	{ }	/* Terminating entry */
 };
-
 MODULE_DEVICE_TABLE(usb, btusb_table);
 
 static struct usb_device_id blacklist_table[] = {
 	/* CSR BlueCore devices */
-	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },
+	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = (unsigned long) &csr },
 
 	/* Broadcom BCM2033 without firmware */
-	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = (unsigned long) &ignore },
 
 	/* Atheros 3011 with sflash firmware */
-	{ USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
-	{ USB_DEVICE(0x0cf3, 0xe019), .driver_info = BTUSB_IGNORE },
-	{ USB_DEVICE(0x13d3, 0x3304), .driver_info = BTUSB_IGNORE },
-	{ USB_DEVICE(0x0930, 0x0215), .driver_info = BTUSB_IGNORE },
-	{ USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x0cf3, 0x3002), .driver_info = (unsigned long) &ignore },
+	{ USB_DEVICE(0x0cf3, 0xe019), .driver_info = (unsigned long) &ignore },
+	{ USB_DEVICE(0x13d3, 0x3304), .driver_info = (unsigned long) &ignore },
+	{ USB_DEVICE(0x0930, 0x0215), .driver_info = (unsigned long) &ignore },
+	{ USB_DEVICE(0x0489, 0xe03d), .driver_info = (unsigned long) &ignore },
 
 	/* Atheros AR9285 Malbec with sflash firmware */
-	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = (unsigned long) &ignore },
 
 	/* Atheros 3012 with sflash firmware */
-	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = (unsigned long) &ath3012 },
+	{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = (unsigned long) &ath3012 },
+	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = (unsigned long) &ath3012 },
+	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = (unsigned long) &ath3012 },
+	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = (unsigned long) &ath3012 },
+	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = (unsigned long) &ath3012 },
+	{ USB_DEVICE(0x0930, 0x0219), .driver_info = (unsigned long) &ath3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
-	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = (unsigned long) &ignore },
 
 	/* Atheros AR5BBU12 with sflash firmware */
-	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = (unsigned long) &ath3012 },
 
 	/* Broadcom BCM2035 */
-	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = BTUSB_WRONG_SCO_MTU },
-	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
-	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
+	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = (unsigned long) &wrong_sco_mtu },
+	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = (unsigned long) &wrong_sco_mtu },
+	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = (unsigned long) &bcm92035 },
 
 	/* Broadcom BCM2045 */
-	{ USB_DEVICE(0x0a5c, 0x2039), .driver_info = BTUSB_WRONG_SCO_MTU },
-	{ USB_DEVICE(0x0a5c, 0x2101), .driver_info = BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x2039), .driver_info = (unsigned long) &wrong_sco_mtu },
+	{ USB_DEVICE(0x0a5c, 0x2101), .driver_info = (unsigned long) &wrong_sco_mtu },
 
 	/* IBM/Lenovo ThinkPad with Broadcom chip */
-	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = BTUSB_WRONG_SCO_MTU },
-	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = (unsigned long) &wrong_sco_mtu },
+	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = (unsigned long) &wrong_sco_mtu },
 
 	/* HP laptop with Broadcom chip */
-	{ USB_DEVICE(0x03f0, 0x171d), .driver_info = BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x03f0, 0x171d), .driver_info = (unsigned long) &wrong_sco_mtu },
 
 	/* Dell laptop with Broadcom chip */
-	{ USB_DEVICE(0x413c, 0x8126), .driver_info = BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x413c, 0x8126), .driver_info = (unsigned long) &wrong_sco_mtu },
 
 	/* Dell Wireless 370 and 410 devices */
-	{ USB_DEVICE(0x413c, 0x8152), .driver_info = BTUSB_WRONG_SCO_MTU },
-	{ USB_DEVICE(0x413c, 0x8156), .driver_info = BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x413c, 0x8152), .driver_info = (unsigned long) &wrong_sco_mtu },
+	{ USB_DEVICE(0x413c, 0x8156), .driver_info = (unsigned long) &wrong_sco_mtu },
 
 	/* Belkin F8T012 and F8T013 devices */
-	{ USB_DEVICE(0x050d, 0x0012), .driver_info = BTUSB_WRONG_SCO_MTU },
-	{ USB_DEVICE(0x050d, 0x0013), .driver_info = BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x050d, 0x0012), .driver_info = (unsigned long) &wrong_sco_mtu },
+	{ USB_DEVICE(0x050d, 0x0013), .driver_info = (unsigned long) &wrong_sco_mtu },
 
 	/* Asus WL-BTD202 device */
-	{ USB_DEVICE(0x0b05, 0x1715), .driver_info = BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0b05, 0x1715), .driver_info = (unsigned long) &wrong_sco_mtu },
 
 	/* Kensington Bluetooth USB adapter */
-	{ USB_DEVICE(0x047d, 0x105e), .driver_info = BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x047d, 0x105e), .driver_info = (unsigned long) &wrong_sco_mtu },
 
 	/* RTX Telecom based adapters with buggy SCO support */
-	{ USB_DEVICE(0x0400, 0x0807), .driver_info = BTUSB_BROKEN_ISOC },
-	{ USB_DEVICE(0x0400, 0x080a), .driver_info = BTUSB_BROKEN_ISOC },
+	{ USB_DEVICE(0x0400, 0x0807), .driver_info = (unsigned long) &broken_isoc },
+	{ USB_DEVICE(0x0400, 0x080a), .driver_info = (unsigned long) &broken_isoc },
 
 	/* CONWISE Technology based adapters with buggy SCO support */
-	{ USB_DEVICE(0x0e5e, 0x6622), .driver_info = BTUSB_BROKEN_ISOC },
+	{ USB_DEVICE(0x0e5e, 0x6622), .driver_info = (unsigned long) &broken_isoc },
 
 	/* Digianswer devices */
-	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = BTUSB_DIGIANSWER },
-	{ USB_DEVICE(0x08fd, 0x0002), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = (unsigned long) &digianswer },
+	{ USB_DEVICE(0x08fd, 0x0002), .driver_info = (unsigned long) &ignore },
 
 	/* CSR BlueCore Bluetooth Sniffer */
-	{ USB_DEVICE(0x0a12, 0x0002), .driver_info = BTUSB_SNIFFER },
+	{ USB_DEVICE(0x0a12, 0x0002), .driver_info = (unsigned long) &sniffer },
 
 	/* Frontline ComProbe Bluetooth Sniffer */
-	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = BTUSB_SNIFFER },
+	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = (unsigned long) &sniffer },
 
 	{ }	/* Terminating entry */
 };
@@ -910,12 +955,12 @@ static void btusb_waker(struct work_struct *work)
 	usb_autopm_put_interface(data->intf);
 }
 
-static int btusb_probe(struct usb_interface *intf,
-				const struct usb_device_id *id)
+int btusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_endpoint_descriptor *ep_desc;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
+	struct btusb_driver_info *info;
 	int i, err;
 
 	BT_DBG("intf %p id %p", intf, id);
@@ -931,19 +976,28 @@ static int btusb_probe(struct usb_interface *intf,
 			id = match;
 	}
 
-	if (id->driver_info == BTUSB_IGNORE)
+	/*
+	 * Make sure the driver_info is not null or 0 because the code below
+	 * need to access the flags
+	 */
+	if (!id->driver_info)
+		info = (struct btusb_driver_info *) &generic;
+	else
+		info = (struct btusb_driver_info *) id->driver_info;
+
+	if (info->flags == BTUSB_IGNORE)
 		return -ENODEV;
 
-	if (ignore_dga && id->driver_info & BTUSB_DIGIANSWER)
+	if (ignore_dga && (info->flags & BTUSB_DIGIANSWER))
 		return -ENODEV;
 
-	if (ignore_csr && id->driver_info & BTUSB_CSR)
+	if (ignore_csr && (info->flags & BTUSB_CSR))
 		return -ENODEV;
 
-	if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
+	if (ignore_sniffer && (info->flags & BTUSB_SNIFFER))
 		return -ENODEV;
 
-	if (id->driver_info & BTUSB_ATH3012) {
+	if (info->flags & BTUSB_ATH3012) {
 		struct usb_device *udev = interface_to_usbdev(intf);
 
 		/* Old firmware would otherwise let ath3k driver load
@@ -1012,26 +1066,30 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->send     = btusb_send_frame;
 	hdev->notify   = btusb_notify;
 
+	/* vendor specific device initialization routines */
+	hdev->vsdev_init = info->vsdev_init;
+	hdev->vsdev_event = info->vsdev_event;
+
 	/* Interface numbers are hardcoded in the specification */
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
 
 	if (!reset)
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
-	if (force_scofix || id->driver_info & BTUSB_WRONG_SCO_MTU) {
+	if (force_scofix || (info->flags & BTUSB_WRONG_SCO_MTU)) {
 		if (!disable_scofix)
 			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_BROKEN_ISOC)
+	if (info->flags & BTUSB_BROKEN_ISOC)
 		data->isoc = NULL;
 
-	if (id->driver_info & BTUSB_DIGIANSWER) {
+	if (info->flags & BTUSB_DIGIANSWER) {
 		data->cmdreq_type = USB_TYPE_VENDOR;
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_CSR) {
+	if (info->flags & BTUSB_CSR) {
 		struct usb_device *udev = data->udev;
 
 		/* Old firmware would otherwise execute USB reset */
@@ -1039,7 +1097,7 @@ static int btusb_probe(struct usb_interface *intf,
 			set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_SNIFFER) {
+	if (info->flags & BTUSB_SNIFFER) {
 		struct usb_device *udev = data->udev;
 
 		/* New sniffer firmware has crippled HCI interface */
@@ -1049,7 +1107,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->isoc = NULL;
 	}
 
-	if (id->driver_info & BTUSB_BCM92035) {
+	if (info->flags & BTUSB_BCM92035) {
 		unsigned char cmd[] = { 0x3b, 0xfc, 0x01, 0x00 };
 		struct sk_buff *skb;
 
@@ -1079,8 +1137,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(btusb_probe);
 
-static void btusb_disconnect(struct usb_interface *intf)
+void btusb_disconnect(struct usb_interface *intf)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
 	struct hci_dev *hdev;
@@ -1105,9 +1164,10 @@ static void btusb_disconnect(struct usb_interface *intf)
 
 	hci_free_dev(hdev);
 }
+EXPORT_SYMBOL_GPL(btusb_disconnect);
 
 #ifdef CONFIG_PM
-static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
+int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
 
@@ -1133,6 +1193,7 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(btusb_suspend);
 
 static void play_deferred(struct btusb_data *data)
 {
@@ -1149,7 +1210,7 @@ static void play_deferred(struct btusb_data *data)
 	usb_scuttle_anchored_urbs(&data->deferred);
 }
 
-static int btusb_resume(struct usb_interface *intf)
+int btusb_resume(struct usb_interface *intf)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
 	struct hci_dev *hdev = data->hdev;
@@ -1205,8 +1266,10 @@ done:
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(btusb_resume);
 #endif
 
+
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
diff --git a/drivers/bluetooth/btusb.h b/drivers/bluetooth/btusb.h
new file mode 100644
index 0000000..c26a845
--- /dev/null
+++ b/drivers/bluetooth/btusb.h
@@ -0,0 +1,53 @@
+/*
+ *
+ *  Generic Bluetooth USB driver
+ *
+ *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+#ifndef _BTUSB_H
+#define _BTUSB_H
+
+struct btusb_driver_info {
+	char	*description;
+	int	flags;
+#define BTUSB_GENERIC		0x00
+#define BTUSB_IGNORE		0x01
+#define BTUSB_DIGIANSWER	0x02
+#define BTUSB_CSR		0x04
+#define BTUSB_SNIFFER		0x08
+#define BTUSB_BCM92035		0x10
+#define BTUSB_BROKEN_ISOC	0x20
+#define BTUSB_WRONG_SCO_MTU	0x40
+#define BTUSB_ATH3012		0x80
+
+	/* entry point for vendor specific device initialization */
+	int	(*vsdev_init)(struct hci_dev *hdev);
+
+	/* event handler during vendor specific device initiation phase */
+	void	(*vsdev_event)(struct hci_dev *hdev, struct sk_buff *skb);
+};
+
+extern int btusb_probe(struct usb_interface *, const struct usb_device_id *);
+extern void btusb_disconnect(struct usb_interface *);
+#ifdef CONFIG_PM
+extern int btusb_suspend(struct usb_interface *, pm_message_t);
+extern int btusb_resume(struct usb_interface *);
+#endif
+
+#endif /* _BTUSB_H */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6a3337e..4af601d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -275,6 +275,16 @@ struct hci_dev {
 	int (*send)(struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
+
+	/*
+	 * TODO: Added following members for vendor specific initialization to
+	 * make the bluetooth.ko transparent to the interface.
+	 * These members are set by the vendor provided driver
+	 */
+	int			vsdev_init_done;
+	void			*vsdev_priv_data;
+	int (*vsdev_init)(struct hci_dev *hdev);
+	void (*vsdev_event)(struct hci_dev *hdev, struct sk_buff *skb);
 };
 
 struct hci_conn {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e407051..80aa13f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -685,6 +685,15 @@ int hci_dev_open(__u16 dev)
 		set_bit(HCI_INIT, &hdev->flags);
 		hdev->init_last_cmd = 0;
 
+		/* vendor specific device initialization */
+		if (hdev->vsdev_init) {
+			ret = hdev->vsdev_init(hdev);
+			hdev->vsdev_init_done = 1;
+			hdev->vsdev_event = NULL;
+			if (ret < 0)
+				goto done;
+		}
+
 		ret = __hci_request(hdev, hci_init_req, 0, HCI_INIT_TIMEOUT);
 
 		if (lmp_host_le_capable(hdev))
@@ -2119,6 +2128,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 
 	return 0;
 }
+EXPORT_SYMBOL(hci_send_cmd);
 
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
@@ -2800,7 +2810,10 @@ static void hci_rx_work(struct work_struct *work)
 		switch (bt_cb(skb)->pkt_type) {
 		case HCI_EVENT_PKT:
 			BT_DBG("%s Event packet", hdev->name);
-			hci_event_packet(hdev, skb);
+			if (hdev->vsdev_event && !hdev->vsdev_init_done)
+				hdev->vsdev_event(hdev, skb);
+			else
+				hci_event_packet(hdev, skb);
 			break;
 
 		case HCI_ACLDATA_PKT:
-- 
1.7.9.5
