Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Support HCI_QUIRK_RAW_DEVICE for hci_vhci driver
Date: Thu,  3 Jul 2014 01:35:10 +0200
Message-Id: <1404344110-4468-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for configuring the hci_vhci virtual controllers
as a raw-only device using HCI_QUIRK_RAW_DEVICE. This is useful for
testing the kernel internal infrastructure.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_vhci.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index add1c6a72063..aa446c7eb7e5 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -40,7 +40,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#define VERSION "1.4"
+#define VERSION "1.5"
 
 static bool amp;
 
@@ -95,10 +95,21 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
-static int vhci_create_device(struct vhci_data *data, __u8 dev_type)
+static int vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
 	struct sk_buff *skb;
+	__u8 dev_type;
+
+	/* bits 0-1 are dev_type (BR/EDR or AMP) */
+	dev_type = opcode & 0x03;
+
+	if (dev_type != HCI_BREDR && dev_type != HCI_AMP)
+		return -EINVAL;
+
+	/* bits 2-6 are reserved (must be zero) */
+	if (opcode & 0x7c)
+		return -EINVAL;
 
 	skb = bt_skb_alloc(4, GFP_KERNEL);
 	if (!skb)
@@ -121,6 +132,10 @@ static int vhci_create_device(struct vhci_data *data, __u8 dev_type)
 	hdev->flush = vhci_flush;
 	hdev->send  = vhci_send_frame;
 
+	/* bit 7 is for raw device */
+	if (opcode & 0x80)
+		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		hci_free_dev(hdev);
@@ -132,7 +147,7 @@ static int vhci_create_device(struct vhci_data *data, __u8 dev_type)
 	bt_cb(skb)->pkt_type = HCI_VENDOR_PKT;
 
 	*skb_put(skb, 1) = 0xff;
-	*skb_put(skb, 1) = dev_type;
+	*skb_put(skb, 1) = opcode;
 	put_unaligned_le16(hdev->id, skb_put(skb, 2));
 	skb_queue_tail(&data->readq, skb);
 
@@ -146,7 +161,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 {
 	size_t len = iov_length(iov, count);
 	struct sk_buff *skb;
-	__u8 pkt_type, dev_type;
+	__u8 pkt_type, opcode;
 	unsigned long i;
 	int ret;
 
@@ -190,7 +205,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 
 		cancel_delayed_work_sync(&data->open_timeout);
 
-		dev_type = *((__u8 *) skb->data);
+		opcode = *((__u8 *) skb->data);
 		skb_pull(skb, 1);
 
 		if (skb->len > 0) {
@@ -200,10 +215,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 
 		kfree_skb(skb);
 
-		if (dev_type != HCI_BREDR && dev_type != HCI_AMP)
-			return -EINVAL;
-
-		ret = vhci_create_device(data, dev_type);
+		ret = vhci_create_device(data, opcode);
 		break;
 
 	default:
-- 
1.9.3

