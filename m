Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH v2] Bluetooth: Fix missing hci_dev_lock/unlock in hci_event
Date: Thu, 11 Dec 2014 18:58:15 +0530
Message-id: <1418304495-15334-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

mgmt_pending_remove() should be called with hci_dev_lock protection and
all hci_event.c functions which calls mgmt_complete() (which eventually
calls mgmt_pending_remove()) should hold the lock.
So this patch fixes the same

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 net/bluetooth/hci_event.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 322abbb..39a5c8a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -257,6 +257,8 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!sent)
 		return;
 
+	hci_dev_lock(hdev);
+
 	if (!status) {
 		__u8 param = *((__u8 *) sent);
 
@@ -268,6 +270,8 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_auth_enable_complete(hdev, status);
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
@@ -443,6 +447,8 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!sent)
 		return;
 
+	hci_dev_lock(hdev);
+
 	if (!status) {
 		if (sent->mode)
 			hdev->features[1][0] |= LMP_HOST_SSP;
@@ -458,6 +464,8 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
 	}
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
@@ -471,6 +479,8 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!sent)
 		return;
 
+	hci_dev_lock(hdev);
+
 	if (!status) {
 		if (sent->support)
 			hdev->features[1][0] |= LMP_HOST_SC;
@@ -486,6 +496,8 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			clear_bit(HCI_SC_ENABLED, &hdev->dev_flags);
 	}
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1135,6 +1147,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	if (!cp)
 		return;
 
+	hci_dev_lock(hdev);
+
 	switch (cp->enable) {
 	case LE_SCAN_ENABLE:
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
@@ -1184,6 +1198,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		BT_ERR("Used reserved LE_Scan_Enable param %d", cp->enable);
 		break;
 	}
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
@@ -1278,6 +1294,8 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 	if (!sent)
 		return;
 
+	hci_dev_lock(hdev);
+
 	if (sent->le) {
 		hdev->features[1][0] |= LMP_HOST_LE;
 		set_bit(HCI_LE_ENABLED, &hdev->dev_flags);
@@ -1291,6 +1309,8 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 		hdev->features[1][0] |= LMP_HOST_LE_BREDR;
 	else
 		hdev->features[1][0] &= ~LMP_HOST_LE_BREDR;
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.9.5

