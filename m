Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Read USB product information for Apple devices
Date: Sun, 18 Oct 2015 22:48:28 +0200
Message-Id: <1445201308-127022-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For the Apple Bluetooth devices, read the USB product information and
print them. This allows for easy mapping of chip and USB details.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btbcm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 40ad0e1ccf75..0b697946e9bc 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -527,6 +527,15 @@ int btbcm_setup_apple(struct hci_dev *hdev)
 		kfree_skb(skb);
 	}
 
+	/* Read USB Product Info */
+	skb = btbcm_read_usb_product(hdev);
+	if (!IS_ERR(skb)) {
+		BT_INFO("%s: BCM: product %4.4x:%4.4x", hdev->name,
+			get_unaligned_le16(skb->data + 1),
+			get_unaligned_le16(skb->data + 3));
+		kfree_skb(skb);
+	}
+
 	/* Read Local Name */
 	skb = btbcm_read_local_name(hdev);
 	if (!IS_ERR(skb)) {
-- 
2.4.3

