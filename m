Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add status parameter to mgmt_disconnect response
Date: Thu, 10 Nov 2011 15:54:39 +0200
Message-Id: <1320933279-12558-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320933279-12558-1-git-send-email-johan.hedberg@gmail.com>
References: <1320933279-12558-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since disconnecting may fail the status needs to be communicated to user
space. This also updates the implementation to match the latest mgmt API
specification.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/mgmt.h     |    1 +
 net/bluetooth/hci_event.c        |   26 +++++++++++++-------------
 net/bluetooth/mgmt.c             |   15 +++++++++++++--
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5f401e7..a67ff88 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -919,7 +919,7 @@ int mgmt_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 								u8 addr_type);
 int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 								u8 addr_type);
-int mgmt_disconnect_failed(struct hci_dev *hdev);
+int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status);
 int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 						u8 addr_type, u8 status);
 int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index e5a866a..8b07a83 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -130,6 +130,7 @@ struct mgmt_cp_disconnect {
 } __packed;
 struct mgmt_rp_disconnect {
 	bdaddr_t bdaddr;
+	__u8 status;
 } __packed;
 
 #define MGMT_ADDR_BREDR			0x00
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bbfaaa8..0d55d00 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1605,27 +1605,27 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	BT_DBG("%s status %d", hdev->name, ev->status);
 
-	if (ev->status) {
-		hci_dev_lock(hdev);
-		mgmt_disconnect_failed(hdev);
-		hci_dev_unlock(hdev);
-		return;
-	}
-
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
 	if (!conn)
 		goto unlock;
 
-	conn->state = BT_CLOSED;
+	if (ev->status == 0)
+		conn->state = BT_CLOSED;
 
-	if (conn->type == ACL_LINK || conn->type == LE_LINK)
-		mgmt_disconnected(hdev, &conn->dst, conn->type,
+	if (conn->type == ACL_LINK || conn->type == LE_LINK) {
+		if (ev->status != 0)
+			mgmt_disconnect_failed(hdev, &conn->dst, ev->status);
+		else
+			mgmt_disconnected(hdev, &conn->dst, conn->type,
 							conn->dst_type);
+	}
 
-	hci_proto_disconn_cfm(conn, ev->reason);
-	hci_conn_del(conn);
+	if (ev->status == 0) {
+		hci_proto_disconn_cfm(conn, ev->reason);
+		hci_conn_del(conn);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -2098,7 +2098,7 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	case HCI_OP_DISCONNECT:
 		if (ev->status != 0)
-			mgmt_disconnect_failed(hdev);
+			mgmt_disconnect_failed(hdev, NULL, ev->status);
 		break;
 
 	case HCI_OP_LE_CREATE_CONN:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dddb190..5562c21 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2128,6 +2128,7 @@ static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 	struct mgmt_rp_disconnect rp;
 
 	bacpy(&rp.bdaddr, &cp->bdaddr);
+	rp.status = 0;
 
 	cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT, &rp, sizeof(rp));
 
@@ -2176,7 +2177,7 @@ int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	return err;
 }
 
-int mgmt_disconnect_failed(struct hci_dev *hdev)
+int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status)
 {
 	struct pending_cmd *cmd;
 	int err;
@@ -2185,7 +2186,17 @@ int mgmt_disconnect_failed(struct hci_dev *hdev)
 	if (!cmd)
 		return -ENOENT;
 
-	err = cmd_status(cmd->sk, hdev->id, MGMT_OP_DISCONNECT, EIO);
+	if (bdaddr) {
+		struct mgmt_rp_disconnect rp;
+
+		bacpy(&rp.bdaddr, bdaddr);
+		rp.status = status;
+
+		err = cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT,
+							&rp, sizeof(rp));
+	} else
+		err = cmd_status(cmd->sk, hdev->id, MGMT_OP_DISCONNECT,
+								status);
 
 	mgmt_pending_remove(cmd);
 
-- 
1.7.7.1

