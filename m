Return-Path: <cyrus@holtmann.org>
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-bluetooth@vger.kernel.org
Cc: tedd.an@intel.com, emmanuel.grumbach@intel.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] btusb: correct ERR_PTR usage
Date: Mon,  6 May 2013 12:43:18 +0200
Message-Id: <1367836998-8134-1-git-send-email-johannes@sipsolutions.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

PTR_ERR(ERR_PTR(-EXYZ)) == -EXYZ, so -ERR_PTR()
is wrong and should be ERR_PTR().

Cc: Tedd Ho-Jeong An <tedd.an@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/bluetooth/btusb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7a7e5f8..09f0c1d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -941,7 +941,7 @@ static int btusb_setup_bcm92035(struct hci_dev *hdev)
 
 	skb = __hci_cmd_sync(hdev, 0xfc3b, 1, &val, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb))
-		BT_ERR("BCM92035 command failed (%ld)", -PTR_ERR(skb));
+		BT_ERR("BCM92035 command failed (%ld)", PTR_ERR(skb));
 	else
 		kfree_skb(skb);
 
@@ -1092,7 +1092,7 @@ static int btusb_setup_intel_patching(struct hci_dev *hdev,
 	if (IS_ERR(skb)) {
 		BT_ERR("%s sending Intel patch command (0x%4.4x) failed (%ld)",
 		       hdev->name, cmd->opcode, PTR_ERR(skb));
-		return -PTR_ERR(skb);
+		return PTR_ERR(skb);
 	}
 
 	/* It ensures that the returned event matches the event data read from
@@ -1144,7 +1144,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	if (IS_ERR(skb)) {
 		BT_ERR("%s sending initial HCI reset command failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
-		return -PTR_ERR(skb);
+		return PTR_ERR(skb);
 	}
 	kfree_skb(skb);
 
@@ -1158,7 +1158,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	if (IS_ERR(skb)) {
 		BT_ERR("%s reading Intel fw version command failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
-		return -PTR_ERR(skb);
+		return PTR_ERR(skb);
 	}
 
 	if (skb->len != sizeof(*ver)) {
@@ -1216,7 +1216,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 		BT_ERR("%s entering Intel manufacturer mode failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
 		release_firmware(fw);
-		return -PTR_ERR(skb);
+		return PTR_ERR(skb);
 	}
 
 	if (skb->data[0]) {
@@ -1273,7 +1273,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	if (IS_ERR(skb)) {
 		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
-		return -PTR_ERR(skb);
+		return PTR_ERR(skb);
 	}
 	kfree_skb(skb);
 
@@ -1289,7 +1289,7 @@ exit_mfg_disable:
 	if (IS_ERR(skb)) {
 		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
-		return -PTR_ERR(skb);
+		return PTR_ERR(skb);
 	}
 	kfree_skb(skb);
 
@@ -1307,7 +1307,7 @@ exit_mfg_deactivate:
 	if (IS_ERR(skb)) {
 		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
-		return -PTR_ERR(skb);
+		return PTR_ERR(skb);
 	}
 	kfree_skb(skb);
 
-- 
1.8.0

