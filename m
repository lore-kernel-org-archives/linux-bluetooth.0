Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: btusb: Add support for BCM2045 HCI with vend:prod ids set to 0000:0000
Date: Thu,  6 Jul 2017 16:08:45 +0200
Message-Id: <20170706140845.11508-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The GPD Pocket is shipping with a BCM2045 USB HCI with its vend:prod
ids set to 0000:0000 and also has its interface class set to 255 (Vendor
Specific Class).

Which, well sucks. Luckily it does advertise usable manufacturer and
product strings, so this commit adds 0000:0000 to the usb_device_id
table, with a special flag of BTUSB_BCM2045_0000_0000, if this flag
is set btusb_probe will check the strings and if they don't match
return -ENODEV.

This is not pretty, but it fixes bluetooth not working under Linux.

Reported-and-tested-by: Christopher Williamson <home@chrisaw.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btusb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7fa373b428f8..9c3201c0525d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -66,6 +66,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BCM2045		0x40000
 #define BTUSB_IFNUM_2		0x80000
 #define BTUSB_CW6622		0x100000
+#define BTUSB_BCM2045_0000_0000	0x200000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -124,6 +125,10 @@ static const struct usb_device_id btusb_table[] = {
 	/* Canyon CN-BTU1 with HID interfaces */
 	{ USB_DEVICE(0x0c10, 0x0000) },
 
+	/* Broadcom BCM2045 with the prod:vend ids not filled GRRR */
+	{ USB_DEVICE(0x0000, 0x0000),
+	  .driver_info = BTUSB_BCM2045 | BTUSB_BCM2045_0000_0000 },
+
 	/* Broadcom BCM20702A0 */
 	{ USB_DEVICE(0x413c, 0x8197) },
 
@@ -2887,6 +2892,16 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info == BTUSB_IGNORE)
 		return -ENODEV;
 
+	if (id->driver_info & BTUSB_BCM2045_0000_0000) {
+		struct usb_device *udev = interface_to_usbdev(intf);
+
+		/* Device with prod:vend id set to 0000:0000, check strings */
+		if (!udev->manufacturer || !udev->product ||
+		    strcmp(udev->manufacturer, "Broadcom Corp") != 0 ||
+		    strcmp(udev->product, "BCM2045A0") != 0)
+			return -ENODEV;
+	}
+
 	if (id->driver_info & BTUSB_ATH3012) {
 		struct usb_device *udev = interface_to_usbdev(intf);
 
-- 
2.13.0
