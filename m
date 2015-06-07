Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: btusb: Remove unneeded btusb_read_local_version function
Date: Sun,  7 Jun 2015 10:01:02 +0200
Message-Id: <1433664062-37464-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The btusb_read_local_version function has only a single user and with
that just move its functionality in place where it belongs.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f71050d36fd9..8acda277ace1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1302,28 +1302,6 @@ static void btusb_waker(struct work_struct *work)
 	usb_autopm_put_interface(data->intf);
 }
 
-static struct sk_buff *btusb_read_local_version(struct hci_dev *hdev)
-{
-	struct sk_buff *skb;
-
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return skb;
-	}
-
-	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
-		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
-		       hdev->name);
-		kfree_skb(skb);
-		return ERR_PTR(-EIO);
-	}
-
-	return skb;
-}
-
 static int btusb_setup_bcm92035(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -1347,9 +1325,19 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	skb = btusb_read_local_version(hdev);
-	if (IS_ERR(skb))
-		return -PTR_ERR(skb);
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
+		BT_ERR("%s: CSR: Local version failed (%d)", hdev->name, err);
+		return err;
+	}
+
+	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
+		BT_ERR("%s: CSR: Local version length mismatch", hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
 
 	rp = (struct hci_rp_read_local_version *)skb->data;
 
-- 
2.4.2

