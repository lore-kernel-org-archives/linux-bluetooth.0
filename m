Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Consolidate the controller information commands
Date: Thu, 17 Aug 2017 11:02:40 +0200
Message-Id: <20170817090240.72914-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The commands that read the basic vendor information about the Broadcom
controller are duplicated for UART and USB devices. Combine them into a
single function to reduce the code complexity.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btbcm.c | 69 ++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 9ab6cfbb831d..cc4bdefa6648 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -287,6 +287,37 @@ static struct sk_buff *btbcm_read_usb_product(struct hci_dev *hdev)
 	return skb;
 }
 
+static int btbcm_read_info(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	/* Read Verbose Config Version Info */
+	skb = btbcm_read_verbose_config(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
+	kfree_skb(skb);
+
+	/* Read Controller Features */
+	skb = btbcm_read_controller_features(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	BT_INFO("%s: BCM: features 0x%2.2x", hdev->name, skb->data[1]);
+	kfree_skb(skb);
+
+	/* Read Local Name */
+	skb = btbcm_read_local_name(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	BT_INFO("%s: %s", hdev->name, (char *)(skb->data + 1));
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static const struct {
 	u16 subver;
 	const char *name;
@@ -322,13 +353,10 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
 	subver = le16_to_cpu(ver->lmp_subver);
 	kfree_skb(skb);
 
-	/* Read Verbose Config Version Info */
-	skb = btbcm_read_verbose_config(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
-	kfree_skb(skb);
+	/* Read controller information */
+	err = btbcm_read_info(hdev);
+	if (err)
+		return err;
 
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
@@ -431,29 +459,10 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	subver = le16_to_cpu(ver->lmp_subver);
 	kfree_skb(skb);
 
-	/* Read Verbose Config Version Info */
-	skb = btbcm_read_verbose_config(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
-	kfree_skb(skb);
-
-	/* Read Controller Features */
-	skb = btbcm_read_controller_features(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	BT_INFO("%s: BCM: features 0x%2.2x", hdev->name, skb->data[1]);
-	kfree_skb(skb);
-
-	/* Read Local Name */
-	skb = btbcm_read_local_name(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	BT_INFO("%s: %s", hdev->name, (char *)(skb->data + 1));
-	kfree_skb(skb);
+	/* Read controller information */
+	err = btbcm_read_info(hdev);
+	if (err)
+		return err;
 
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
-- 
2.13.5

