Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Track current configured LE scan type parameter
Date: Fri, 21 Mar 2014 12:18:10 -0700
Message-Id: <1395429490-10884-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LE scan type paramter defines if active scanning or passive scanning
is in use. Track the currently set value so it can be used for decision
making from other pieces in the core.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index afbea388eda1..5f8bc05694ac 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -189,6 +189,7 @@ struct hci_dev {
 	__u16		page_scan_window;
 	__u8		page_scan_type;
 	__u8		le_adv_channel_map;
+	__u8		le_scan_type;
 	__u16		le_scan_interval;
 	__u16		le_scan_window;
 	__u16		le_conn_min_interval;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1e386edc338f..9ee081b9c064 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -199,6 +199,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	memset(hdev->scan_rsp_data, 0, sizeof(hdev->scan_rsp_data));
 	hdev->scan_rsp_data_len = 0;
 
+	hdev->le_scan_type = LE_SCAN_PASSIVE;
+
 	hdev->ssp_debug_mode = 0;
 }
 
@@ -997,6 +999,25 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_cp_le_set_scan_param *cp;
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_PARAM);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (!status)
+		hdev->le_scan_type = cp->type;
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
@@ -2488,6 +2509,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_set_adv_enable(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_SCAN_PARAM:
+		hci_cc_le_set_scan_param(hdev, skb);
+		break;
+
 	case HCI_OP_LE_SET_SCAN_ENABLE:
 		hci_cc_le_set_scan_enable(hdev, skb);
 		break;
-- 
1.8.5.3

