Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Track LE white list modification via HCI commands
Date: Thu, 27 Feb 2014 20:37:31 -0800
Message-Id: <1393562251-7555-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the LE white list gets changed via HCI commands make sure that
the internal storage of the white list entries gets updated.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 40e5bfebb484..e3d7151e808e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1038,6 +1038,49 @@ static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 		hdev->le_white_list_size = rp->size;
 }
 
+static void hci_cc_le_clear_white_list(struct hci_dev *hdev,
+				       struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (!status)
+		hci_white_list_clear(hdev);
+}
+
+static void hci_cc_le_add_to_white_list(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_cp_le_add_to_white_list *sent;
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_ADD_TO_WHITE_LIST);
+	if (!sent)
+		return;
+
+	if (!status)
+		hci_white_list_add(hdev, &sent->bdaddr, sent->bdaddr_type);
+}
+
+static void hci_cc_le_del_from_white_list(struct hci_dev *hdev,
+					  struct sk_buff *skb)
+{
+	struct hci_cp_le_del_from_white_list *sent;
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_DEL_FROM_WHITE_LIST);
+	if (!sent)
+		return;
+
+	if (!status)
+		hci_white_list_del(hdev, &sent->bdaddr, sent->bdaddr_type);
+}
+
 static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
@@ -2378,6 +2421,18 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_read_white_list_size(hdev, skb);
 		break;
 
+	case HCI_OP_LE_CLEAR_WHITE_LIST:
+		hci_cc_le_clear_white_list(hdev, skb);
+		break;
+
+	case HCI_OP_LE_ADD_TO_WHITE_LIST:
+		hci_cc_le_add_to_white_list(hdev, skb);
+		break;
+
+	case HCI_OP_LE_DEL_FROM_WHITE_LIST:
+		hci_cc_le_del_from_white_list(hdev, skb);
+		break;
+
 	case HCI_OP_LE_READ_SUPPORTED_STATES:
 		hci_cc_le_read_supported_states(hdev, skb);
 		break;
-- 
1.8.5.3

