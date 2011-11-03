Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Clean up logic in hci_cc_write_scan_enable
Date: Fri,  4 Nov 2011 00:17:45 +0200
Message-Id: <1320358667-21086-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a new label to hci_cc_write_scan_enable to avoid
unnecessary indentation. This will be convenient especially when new
code for the discoverable timeout gets added.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |   46 +++++++++++++++++++++++---------------------
 1 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d8fa657..8c81a75 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -274,7 +274,8 @@ static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	__u8 param, status = *((__u8 *) skb->data);
+	int old_pscan, old_iscan;
 	void *sent;
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -283,28 +284,29 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!sent)
 		return;
 
-	if (!status) {
-		__u8 param = *((__u8 *) sent);
-		int old_pscan, old_iscan;
+	if (status != 0)
+		goto done;
 
-		old_pscan = test_and_clear_bit(HCI_PSCAN, &hdev->flags);
-		old_iscan = test_and_clear_bit(HCI_ISCAN, &hdev->flags);
+	param = *((__u8 *) sent);
 
-		if (param & SCAN_INQUIRY) {
-			set_bit(HCI_ISCAN, &hdev->flags);
-			if (!old_iscan)
-				mgmt_discoverable(hdev->id, 1);
-		} else if (old_iscan)
-			mgmt_discoverable(hdev->id, 0);
+	old_pscan = test_and_clear_bit(HCI_PSCAN, &hdev->flags);
+	old_iscan = test_and_clear_bit(HCI_ISCAN, &hdev->flags);
 
-		if (param & SCAN_PAGE) {
-			set_bit(HCI_PSCAN, &hdev->flags);
-			if (!old_pscan)
-				mgmt_connectable(hdev->id, 1);
-		} else if (old_pscan)
-			mgmt_connectable(hdev->id, 0);
-	}
+	if (param & SCAN_INQUIRY) {
+		set_bit(HCI_ISCAN, &hdev->flags);
+		if (!old_iscan)
+			mgmt_discoverable(hdev->id, 1);
+	} else if (old_iscan)
+		mgmt_discoverable(hdev->id, 0);
+
+	if (param & SCAN_PAGE) {
+		set_bit(HCI_PSCAN, &hdev->flags);
+		if (!old_pscan)
+			mgmt_connectable(hdev->id, 1);
+	} else if (old_pscan)
+		mgmt_connectable(hdev->id, 0);
 
+done:
 	hci_req_complete(hdev, HCI_OP_WRITE_SCAN_ENABLE, status);
 }
 
-- 
1.7.7.1

