Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Read Verbose Config Version Info for Broadcom devices
Date: Fri, 20 Mar 2015 17:16:36 -0700
Message-Id: <1426896996-26511-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Broadcom devices expose their chip id via Read Verbose Config
Version Info command. While this information is not used at the
moment, it might be useful for debugging purposes and so read it
before patching the firmware. This makes it show up in dmesg and
HCI traces taken for the system.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 708b6574d805..1521dad3d460 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2458,6 +2458,25 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 	subver = le16_to_cpu(ver->lmp_subver);
 	kfree_skb(skb);
 
+	/* Read Verbose Config Version Info */
+	skb = __hci_cmd_sync(hdev, 0xfc79, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: BCM: Read Verbose Version failed (%ld)",
+		       hdev->name, ret);
+		return ret;
+	}
+
+	if (skb->len != 7) {
+		BT_ERR("%s: BCM: Read Verbose Version event length mismatch",
+		       hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
+	kfree_skb(skb);
+
 	for (i = 0; bcm_subver_table[i].name; i++) {
 		if (subver == bcm_subver_table[i].subver) {
 			hw_name = bcm_subver_table[i].name;
-- 
2.1.0

