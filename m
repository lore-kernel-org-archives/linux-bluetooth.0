Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/5] Bluetooth: Process result of HCI Delete Stored Link Key command
Date: Mon, 12 Jan 2015 09:21:28 -0800
Message-Id: <1421083288-22345-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the HCI Delete Stored Link Key command completes, then update the
value of current stored keys in hci_dev structure.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b1580daede13..a58845e98921 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -232,6 +232,22 @@ static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
 	}
 }
 
+static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
+					  struct sk_buff *skb)
+{
+	struct hci_rp_delete_stored_link_key *rp = (void *)skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	if (rp->num_keys <= hdev->stored_num_keys)
+		hdev->stored_num_keys -= rp->num_keys;
+	else
+		hdev->stored_num_keys = 0;
+}
+
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2736,6 +2752,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_read_stored_link_key(hdev, skb);
 		break;
 
+	case HCI_OP_DELETE_STORED_LINK_KEY:
+		hci_cc_delete_stored_link_key(hdev, skb);
+		break;
+
 	case HCI_OP_WRITE_LOCAL_NAME:
 		hci_cc_write_local_name(hdev, skb);
 		break;
-- 
2.1.0

