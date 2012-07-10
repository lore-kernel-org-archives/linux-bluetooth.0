Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB
	SUBSYSTEM), linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] USB: add USB_VENDOR_AND_INTERFACE_INFO() macro
Date: Tue, 10 Jul 2012 18:51:03 -0300
Message-Id: <1341957063-11989-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

A lot of Broadcom Bluetooth devices provides vendor specific interface
class and we are getting flooded by patches adding new device support.
This change will help us enable support for any other Broadcom with vendor
specific device that arrives in the future.

Only the product id changes for those devices, so this macro would be
perfect for us:

{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01) }

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/linux/usb.h |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index dea39dc..dad156b 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -829,6 +829,27 @@ static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
 	.bInterfaceSubClass = (sc), \
 	.bInterfaceProtocol = (pr)
 
+/**
+ * USB_VENDOR_AND_INTERFACE_INFO - describe a specific usb vendor with a class of usb interfaces
+ * @vend: the 16 bit USB Vendor ID
+ * @cl: bInterfaceClass value
+ * @sc: bInterfaceSubClass value
+ * @pr: bInterfaceProtocol value
+ *
+ * This macro is used to create a struct usb_device_id that matches a
+ * specific vendor with a specific class of interfaces.
+ *
+ * This is especially useful when explicitly matching devices that have
+ * vendor specific bDeviceClass values, but standards-compliant interfaces.
+ */
+#define USB_VENDOR_AND_INTERFACE_INFO(vend, cl, sc, pr) \
+	.match_flags = USB_DEVICE_ID_MATCH_INT_INFO \
+		| USB_DEVICE_ID_MATCH_DEVICE, \
+	.idVendor = (vend), \
+	.bInterfaceClass = (cl), \
+	.bInterfaceSubClass = (sc), \
+	.bInterfaceProtocol = (pr)
+
 /* ----------------------------------------------------------------------- */
 
 /* Stuff for dynamic usb ids */
-- 
1.7.10.2

