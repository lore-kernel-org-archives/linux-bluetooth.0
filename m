Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btusb: Remove double error check from local version command
Date: Sun,  7 Jun 2015 10:01:01 +0200
Message-Id: <1433664062-37464-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The __hci_cmd_sync function already handles the command status and
command complete errors. No need to check the status field again.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c956250176b3..f71050d36fd9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1344,7 +1344,6 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_local_version *rp;
 	struct sk_buff *skb;
-	int ret;
 
 	BT_DBG("%s", hdev->name);
 
@@ -1354,26 +1353,21 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 
 	rp = (struct hci_rp_read_local_version *)skb->data;
 
-	if (!rp->status) {
-		if (le16_to_cpu(rp->manufacturer) != 10) {
-			/* Clear the reset quirk since this is not an actual
-			 * early Bluetooth 1.1 device from CSR.
-			 */
-			clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
+	if (le16_to_cpu(rp->manufacturer) != 10) {
+		/* Clear the reset quirk since this is not an actual
+		 * early Bluetooth 1.1 device from CSR.
+		 */
+		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
-			/* These fake CSR controllers have all a broken
-			 * stored link key handling and so just disable it.
-			 */
-			set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY,
-				&hdev->quirks);
-		}
+		/* These fake CSR controllers have all a broken
+		 * stored link key handling and so just disable it.
+		 */
+		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
 	}
 
-	ret = -bt_to_errno(rp->status);
-
 	kfree_skb(skb);
 
-	return ret;
+	return 0;
 }
 
 static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
-- 
2.4.2

