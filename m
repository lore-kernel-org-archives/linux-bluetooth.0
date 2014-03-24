Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Add missing cmd_status handler for LE_Start_Encryption
Date: Mon, 24 Mar 2014 14:39:04 +0200
Message-Id: <1395664748-13494-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395664748-13494-1-git-send-email-johan.hedberg@gmail.com>
References: <1395664748-13494-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It is possible that the HCI_LE_Start_Encryption command fails in an
early stage and triggers a command status event with the failure code.
In such a case we need to properly notify the hci_conn object and
cleanly bring the connection down. This patch adds the missing command
status handler for this HCI command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index addc44f28c87..4ac8ee07bec3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1743,6 +1743,36 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_le_start_enc *cp;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (!status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_START_ENC);
+	if (!cp)
+		goto unlock;
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
+	if (!conn)
+		goto unlock;
+
+	if (conn->state != BT_CONNECTED)
+		goto unlock;
+
+	hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+	hci_conn_drop(conn);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2654,6 +2684,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_le_create_conn(hdev, ev->status);
 		break;
 
+	case HCI_OP_LE_START_ENC:
+		hci_cs_le_start_enc(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
-- 
1.8.5.3

