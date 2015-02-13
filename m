Return-Path: <cyrus@holtmann.org>
From: Daniel Drake <drake@endlessm.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Add helper for READ_LOCAL_VERSION command
Date: Thu, 12 Feb 2015 18:01:45 -0600
Message-Id: <1423785705-7141-1-git-send-email-drake@endlessm.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Multiple codepaths duplicate some simple code to read and
sanity-check local version information. Before I add a couple more
such codepaths, add a helper to reduce duplication.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/bluetooth/btusb.c | 55 ++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

v2:
 - drop log message (let callers do that)
 - avoid long assignment in variable declaration

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b876888..10062b9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1262,6 +1262,28 @@ static void btusb_waker(struct work_struct *work)
 	usb_autopm_put_interface(data->intf);
 }
 
+static struct sk_buff *btusb_read_local_version(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return skb;
+	}
+
+	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
+		       hdev->name);
+		kfree_skb(skb);
+		return ERR_PTR(-EIO);
+	}
+
+	return skb;
+}
+
 static int btusb_setup_bcm92035(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -1286,12 +1308,9 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("Reading local version failed (%ld)", -PTR_ERR(skb));
+	skb = btusb_read_local_version(hdev);
+	if (IS_ERR(skb))
 		return -PTR_ERR(skb);
-	}
 
 	rp = (struct hci_rp_read_local_version *)skb->data;
 
@@ -2393,20 +2412,9 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 	kfree_skb(skb);
 
 	/* Read Local Version Info */
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
-			     HCI_INIT_TIMEOUT);
+	skb = btusb_read_local_version(hdev);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
-		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
-		       hdev->name, ret);
-		goto done;
-	}
-
-	if (skb->len != sizeof(*ver)) {
-		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
-		       hdev->name);
-		kfree_skb(skb);
-		ret = -EIO;
 		goto done;
 	}
 
@@ -2475,20 +2483,9 @@ reset_fw:
 	kfree_skb(skb);
 
 	/* Read Local Version Info */
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
-			     HCI_INIT_TIMEOUT);
+	skb = btusb_read_local_version(hdev);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
-		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
-		       hdev->name, ret);
-		goto done;
-	}
-
-	if (skb->len != sizeof(*ver)) {
-		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
-		       hdev->name);
-		kfree_skb(skb);
-		ret = -EIO;
 		goto done;
 	}
 
-- 
2.1.0
