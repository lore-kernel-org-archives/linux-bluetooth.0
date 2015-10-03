Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Send HCI Reset before sending Apple specific commands
Date: Sat,  3 Oct 2015 12:01:08 +0200
Message-Id: <1443866468-82453-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The commit 7bee8b08c428 allows the Read Verbose Config Info to fail
gracefully and not cause the controller setup to abort. It seems the
reason that command failed in the first place was the missing HCI Reset
to bring the controller in full Bluetooth mode.

Apple Bluetooth controllers start out in HID mode and when in that mode
the Read Verbose Config Info command is not allowed. Sending HCI Reset
switches the controller into full HCI mode.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btbcm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 02ed816a18f9..ad7371da5aaa 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -475,12 +475,18 @@ EXPORT_SYMBOL_GPL(btbcm_setup_patchram);
 int btbcm_setup_apple(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
+	int err;
+
+	/* Reset */
+	err = btbcm_reset(hdev);
+	if (err)
+		return err;
 
 	/* Read Verbose Config Version Info */
 	skb = btbcm_read_verbose_config(hdev);
 	if (!IS_ERR(skb)) {
-		BT_INFO("%s: BCM: chip id %u build %4.4u", hdev->name, skb->data[1],
-			get_unaligned_le16(skb->data + 5));
+		BT_INFO("%s: BCM: chip id %u build %4.4u", hdev->name,
+			skb->data[1], get_unaligned_le16(skb->data + 5));
 		kfree_skb(skb);
 	}
 
-- 
2.4.3

