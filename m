Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Read the local name in setup stage
Date: Mon,  5 Oct 2015 12:43:57 +0200
Message-Id: <1444041837-18497-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Broadcom Bluetooth controllers have the chip name included in the
ROM firmware or later in the patchram firmware. For debugging purposes
read the local name and print it out. This is only done during setup
stage and only once before loading the firmware and once after loading
the firmware.

For the Broadcom based controllers from Apple, the name is only read once
after determining the chip id.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btbcm.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index ad7371da5aaa..5e0967482d4b 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -181,6 +181,27 @@ static int btbcm_reset(struct hci_dev *hdev)
 	return 0;
 }
 
+static struct sk_buff *btbcm_read_local_name(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: BCM: Reading local name failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return skb;
+	}
+
+	if (skb->len != sizeof(struct hci_rp_read_local_name)) {
+		BT_ERR("%s: BCM: Local name length mismatch", hdev->name);
+		kfree_skb(skb);
+		return ERR_PTR(-EIO);
+	}
+
+	return skb;
+}
+
 static struct sk_buff *btbcm_read_local_version(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -393,6 +414,14 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
 	kfree_skb(skb);
 
+	/* Read Local Name */
+	skb = btbcm_read_local_name(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	BT_INFO("%s: %s", hdev->name, (char *)(skb->data + 1));
+	kfree_skb(skb);
+
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
 	case 3:
@@ -464,6 +493,14 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 		hw_name ? : "BCM", (subver & 0x7000) >> 13,
 		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
 
+	/* Read Local Name */
+	skb = btbcm_read_local_name(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	BT_INFO("%s: %s", hdev->name, (char *)(skb->data + 1));
+	kfree_skb(skb);
+
 	btbcm_check_bdaddr(hdev);
 
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
@@ -490,6 +527,13 @@ int btbcm_setup_apple(struct hci_dev *hdev)
 		kfree_skb(skb);
 	}
 
+	/* Read Local Name */
+	skb = btbcm_read_local_name(hdev);
+	if (IS_ERR(skb)) {
+		BT_INFO("%s: %s", hdev->name, (char *)(skb->data + 1));
+		kfree_skb(skb);
+	}
+
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 
 	return 0;
-- 
2.4.3

