Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc: albert.o.ho@intel.com, johan.hedberg@intel.com, tedd.hj.an@gmail.com
Subject: [RFCv3 1/3] Bluetooth: Add support BT mini-driver
Date: Fri, 02 Nov 2012 13:54:26 -0700
Message-ID: <1385742.8V9Ax1uMxF@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch add mini-driver support in BTUSB

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c |   68 +++++++++++++++++++++++++++++++++++++++++----
 drivers/bluetooth/btusb.h |   44 +++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 6 deletions(-)
 create mode 100644 drivers/bluetooth/btusb.h

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f637c25..39a1e6c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -27,6 +27,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "btusb.h"
+
 #define VERSION "0.6"
 
 static bool ignore_dga;
@@ -47,6 +49,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BROKEN_ISOC	0x20
 #define BTUSB_WRONG_SCO_MTU	0x40
 #define BTUSB_ATH3012		0x80
+#define BTUSB_VENDOR		0x100
 
 static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -206,6 +209,7 @@ struct btusb_data {
 	struct usb_device    *udev;
 	struct usb_interface *intf;
 	struct usb_interface *isoc;
+	struct btusb_driver_info *driver_info;
 
 	spinlock_t lock;
 
@@ -952,9 +956,15 @@ static int btusb_probe(struct usb_interface *intf,
 			return -ENODEV;
 	}
 
-	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+/* CHECKME: if mini-driver invokes btusb_probe, btusb_data already has been
+ * allocated. If btusb_probe is directly invoked by usb core, then allocate
+ * here. */
+	data = usb_get_intfdata(intf);
+	if (!data) {
+		data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+	}
 
 	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
 		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
@@ -1012,6 +1022,17 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->send     = btusb_send_frame;
 	hdev->notify   = btusb_notify;
 
+	/* bind the vendor specific mini-driver */
+	if ((id->driver_info & BTUSB_VENDOR) && data->driver_info) {
+		if (data->driver_info->bind) {
+			err = data->driver_info->bind(hdev);
+			if (err < 0) {
+				hci_free_dev(hdev);
+				return err;
+			}
+		}
+	}
+
 	/* Interface numbers are hardcoded in the specification */
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
 
@@ -1080,7 +1101,35 @@ static int btusb_probe(struct usb_interface *intf,
 	return 0;
 }
 
-static void btusb_disconnect(struct usb_interface *intf)
+/*
+ * CHECKME: vendor's mini-driver should call this function to setup
+ * the vendor specific btusb_driver_info struct
+ */
+int btusb_probe_one(struct usb_interface *intf,
+			const struct usb_device_id *id)
+{
+	struct usb_device_id *vendor_id = (struct usb_device_id *)id;
+	struct btusb_data *data;
+
+	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (vendor_id->driver_info) {
+/* CHECKME: store the driver_info (btusb_driver_info struct) from mini-driver
+ * to btusb_data for later use and change it to BTUSB_VENDOR flag. */
+		data->driver_info =
+			(struct btusb_driver_info *)vendor_id->driver_info;
+		vendor_id->driver_info = BTUSB_VENDOR;
+	}
+
+	usb_set_intfdata(intf, data);
+
+	return btusb_probe(intf, vendor_id);
+}
+EXPORT_SYMBOL(btusb_probe_one);
+
+void btusb_disconnect(struct usb_interface *intf)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
 	struct hci_dev *hdev;
@@ -1103,11 +1152,16 @@ static void btusb_disconnect(struct usb_interface *intf)
 	else if (data->isoc)
 		usb_driver_release_interface(&btusb_driver, data->isoc);
 
+	/* unbind the vendor specific mini-driver */
+	if (data->driver_info && data->driver_info->unbind)
+		data->driver_info->unbind(hdev);
+
 	hci_free_dev(hdev);
 }
+EXPORT_SYMBOL(btusb_disconnect);
 
 #ifdef CONFIG_PM
-static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
+int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
 
@@ -1133,6 +1187,7 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	return 0;
 }
+EXPORT_SYMBOL(btusb_suspend);
 
 static void play_deferred(struct btusb_data *data)
 {
@@ -1149,7 +1204,7 @@ static void play_deferred(struct btusb_data *data)
 	usb_scuttle_anchored_urbs(&data->deferred);
 }
 
-static int btusb_resume(struct usb_interface *intf)
+int btusb_resume(struct usb_interface *intf)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
 	struct hci_dev *hdev = data->hdev;
@@ -1205,6 +1260,7 @@ done:
 
 	return err;
 }
+EXPORT_SYMBOL(btusb_resume);
 #endif
 
 static struct usb_driver btusb_driver = {
diff --git a/drivers/bluetooth/btusb.h b/drivers/bluetooth/btusb.h
new file mode 100644
index 0000000..35bcfa9
--- /dev/null
+++ b/drivers/bluetooth/btusb.h
@@ -0,0 +1,44 @@
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
+
+	/* initialize the vendor setup routines */
+	int	(*bind)(struct hci_dev *);
+
+	/* clean up */
+	void	(*unbind)(struct hci_dev *);
+};
+
+extern int btusb_probe_one(struct usb_interface *,
+				const struct usb_device_id *);
+extern void btusb_disconnect(struct usb_interface *);
+#ifdef CONFIG_PM
+extern int btusb_suspend(struct usb_interface *, pm_message_t);
+extern int btusb_resume(struct usb_interface *);
+#endif
+
+#endif /* _BTUSB_H */
-- 
1.7.9.5
