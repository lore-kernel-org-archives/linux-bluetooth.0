Return-Path: <cyrus@holtmann.org>
From: Daniel Drake <drake@endlessm.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add helper for READ_LOCAL_VERSION command
Date: Mon,  9 Feb 2015 16:49:07 -0600
Message-Id: <1423522147-18818-1-git-send-email-drake@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Multiple codepaths duplicate some simple code to read and
sanity-check local version information. Before I add a couple more
such codepaths, add a helper to reduce duplication.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/bluetooth/btusb.c | 68 ++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b876888..3096308 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1262,6 +1262,33 @@ static void btusb_waker(struct work_struct *work)
 	usb_autopm_put_interface(data->intf);
 }
 
+static struct sk_buff *btusb_read_local_version(struct hci_dev *hdev)
+{
+	struct hci_rp_read_local_version *ver;
+	struct sk_buff *skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION,
+					     0, NULL, HCI_INIT_TIMEOUT);
+
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return skb;
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
+		       hdev->name);
+		kfree_skb(skb);
+		return ERR_PTR(-EIO);
+	}
+
+	ver = (struct hci_rp_read_local_version *) skb->data;
+	BT_INFO("%s: hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
+		hdev->name, ver->hci_ver, ver->hci_rev, ver->lmp_ver,
+		ver->lmp_subver);
+
+	return skb;
+}
+
 static int btusb_setup_bcm92035(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -1286,12 +1313,9 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 
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
 
@@ -2393,27 +2417,14 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
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
 
 	ver = (struct hci_rp_read_local_version *)skb->data;
-	BT_INFO("%s: BCM: patching hci_ver=%02x hci_rev=%04x lmp_ver=%02x "
-		"lmp_subver=%04x", hdev->name, ver->hci_ver, ver->hci_rev,
-		ver->lmp_ver, ver->lmp_subver);
+	BT_INFO("%s: BCM: apply patch", hdev->name);
 	kfree_skb(skb);
 
 	/* Start Download */
@@ -2475,27 +2486,12 @@ reset_fw:
 	kfree_skb(skb);
 
 	/* Read Local Version Info */
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
-			     HCI_INIT_TIMEOUT);
+	skb = btusb_read_local_version(hdev);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
-		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
-		       hdev->name, ret);
 		goto done;
 	}
 
-	if (skb->len != sizeof(*ver)) {
-		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
-		       hdev->name);
-		kfree_skb(skb);
-		ret = -EIO;
-		goto done;
-	}
-
-	ver = (struct hci_rp_read_local_version *)skb->data;
-	BT_INFO("%s: BCM: firmware hci_ver=%02x hci_rev=%04x lmp_ver=%02x "
-		"lmp_subver=%04x", hdev->name, ver->hci_ver, ver->hci_rev,
-		ver->lmp_ver, ver->lmp_subver);
 	kfree_skb(skb);
 
 	/* Read BD Address */
-- 
2.1.0

