Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/9] Bluetooth: LE Set Scan Parameter Command
Date: Fri, 25 Nov 2011 20:53:39 -0300
Message-Id: <1322265226-6404-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the parameter struct and the command complete event
handler to the LE Set Scan Parameter HCI command.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h |    9 +++++++++
 net/bluetooth/hci_event.c   |   11 +++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c949a67..b7c6452 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -776,6 +776,15 @@ struct hci_rp_le_read_buffer_size {
 	__u8     le_max_pkt;
 } __packed;
 
+#define HCI_OP_LE_SET_SCAN_PARAM	0x200b
+struct hci_cp_le_set_scan_param {
+	__u8    type;
+	__le16  interval;
+	__le16  window;
+	__u8    own_address_type;
+	__u8    filter_policy;
+} __packed;
+
 #define HCI_OP_LE_SET_SCAN_ENABLE	0x200c
 struct hci_cp_le_set_scan_enable {
 	__u8     enable;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9f74879..845b26b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -946,6 +946,13 @@ static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%x", hdev->name, status);
+}
+
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
@@ -2021,6 +2028,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_user_confirm_neg_reply(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_SCAN_PARAM:
+		hci_cc_le_set_scan_param(hdev, skb);
+		break;
+
 	case HCI_OP_LE_SET_SCAN_ENABLE:
 		hci_cc_le_set_scan_enable(hdev, skb);
 		break;
-- 
1.7.7.1

