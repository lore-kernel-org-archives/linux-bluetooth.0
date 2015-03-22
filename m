Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Read Broadcom chip info for Apple Bluetooth devices
Date: Sun, 22 Mar 2015 15:52:38 +0100
Message-Id: <1427035958-20117-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For the Apple Bluetooth devices that are Broadcom based, it makes sense
to read the chip information. It is a single HCI command and might help
gathering more information about these devices.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1521dad3d460..9bf4d6ae6c6b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/usb.h>
 #include <linux/firmware.h>
+#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -53,6 +54,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NEW		0x2000
 #define BTUSB_AMP		0x4000
 #define BTUSB_QCA_ROME		0x8000
+#define BTUSB_BCM_APPLE		0x10000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -62,7 +64,8 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x04), .driver_info = BTUSB_AMP },
 
 	/* Apple-specific (Broadcom) devices */
-	{ USB_VENDOR_AND_INTERFACE_INFO(0x05ac, 0xff, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x05ac, 0xff, 0x01, 0x01),
+	  .driver_info = BTUSB_BCM_APPLE },
 
 	/* MediaTek MT76x0E */
 	{ USB_DEVICE(0x0e8d, 0x763f) },
@@ -2634,6 +2637,34 @@ static int btusb_set_bdaddr_bcm(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int btusb_setup_bcm_apple(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	int err;
+
+	/* Read Verbose Config Version Info */
+	skb = __hci_cmd_sync(hdev, 0xfc79, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: BCM: Read Verbose Version failed (%d)",
+		       hdev->name, err);
+		return err;
+	}
+
+	if (skb->len != 7) {
+		BT_ERR("%s: BCM: Read Verbose Version event length mismatch",
+		       hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	BT_INFO("%s: BCM: chip id %u build %4.4u", hdev->name, skb->data[1],
+		get_unaligned_le16(skb->data + 5));
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static int btusb_set_bdaddr_ath3012(struct hci_dev *hdev,
 				    const bdaddr_t *bdaddr)
 {
@@ -3033,6 +3064,11 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
+	if (id->driver_info & BTUSB_BCM_APPLE) {
+		hdev->setup = btusb_setup_bcm_apple;
+		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+	}
+
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
 		hdev->shutdown = btusb_shutdown_intel;
-- 
2.1.0

