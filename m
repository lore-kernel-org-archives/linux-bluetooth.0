Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Take advantage of connection abort helpers
Date: Thu, 22 Oct 2015 09:38:33 +0300
Message-Id: <1445495915-21059-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445495915-21059-1-git-send-email-johan.hedberg@gmail.com>
References: <1445495915-21059-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Convert the various places mapping connection state to
disconnect/cancel HCI command to use the new hci_abort_conn helper
API.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 79 +++++-------------------------------------------
 net/bluetooth/mgmt.c     | 36 ++--------------------
 2 files changed, 11 insertions(+), 104 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11316159a5a7..665a52fa6c60 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -59,11 +59,6 @@ static const struct sco_param esco_param_msbc[] = {
 	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,	0x02 }, /* T1 */
 };
 
-static void hci_le_create_connection_cancel(struct hci_conn *conn)
-{
-	hci_send_cmd(conn->hdev, HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
-}
-
 /* This function requires the caller holds hdev->lock */
 static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 {
@@ -229,29 +224,6 @@ static void hci_acl_create_connection(struct hci_conn *conn)
 	hci_send_cmd(hdev, HCI_OP_CREATE_CONN, sizeof(cp), &cp);
 }
 
-static void hci_acl_create_connection_cancel(struct hci_conn *conn)
-{
-	struct hci_cp_create_conn_cancel cp;
-
-	BT_DBG("hcon %p", conn);
-
-	if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
-		return;
-
-	bacpy(&cp.bdaddr, &conn->dst);
-	hci_send_cmd(conn->hdev, HCI_OP_CREATE_CONN_CANCEL, sizeof(cp), &cp);
-}
-
-static void hci_reject_sco(struct hci_conn *conn)
-{
-	struct hci_cp_reject_sync_conn_req cp;
-
-	cp.reason = HCI_ERROR_REJ_LIMITED_RESOURCES;
-	bacpy(&cp.bdaddr, &conn->dst);
-
-	hci_send_cmd(conn->hdev, HCI_OP_REJECT_SYNC_CONN_REQ, sizeof(cp), &cp);
-}
-
 int hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
 	struct hci_cp_disconnect cp;
@@ -279,20 +251,6 @@ int hci_disconnect(struct hci_conn *conn, __u8 reason)
 	return hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT, sizeof(cp), &cp);
 }
 
-static void hci_amp_disconn(struct hci_conn *conn)
-{
-	struct hci_cp_disconn_phy_link cp;
-
-	BT_DBG("hcon %p", conn);
-
-	conn->state = BT_DISCONN;
-
-	cp.phy_handle = HCI_PHY_HANDLE(conn->handle);
-	cp.reason = hci_proto_disconn_ind(conn);
-	hci_send_cmd(conn->hdev, HCI_OP_DISCONN_PHY_LINK,
-		     sizeof(cp), &cp);
-}
-
 static void hci_add_sco(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -456,35 +414,14 @@ static void hci_conn_timeout(struct work_struct *work)
 	if (refcnt > 0)
 		return;
 
-	switch (conn->state) {
-	case BT_CONNECT:
-	case BT_CONNECT2:
-		if (conn->out) {
-			if (conn->type == ACL_LINK)
-				hci_acl_create_connection_cancel(conn);
-			else if (conn->type == LE_LINK) {
-				if (test_bit(HCI_CONN_SCANNING, &conn->flags))
-					hci_connect_le_scan_remove(conn);
-				else
-					hci_le_create_connection_cancel(conn);
-			}
-		} else if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
-			hci_reject_sco(conn);
-		}
-		break;
-	case BT_CONFIG:
-	case BT_CONNECTED:
-		if (conn->type == AMP_LINK) {
-			hci_amp_disconn(conn);
-		} else {
-			__u8 reason = hci_proto_disconn_ind(conn);
-			hci_disconnect(conn, reason);
-		}
-		break;
-	default:
-		conn->state = BT_CLOSED;
-		break;
+	/* LE connections in scanning state need special handling */
+	if (conn->state == BT_CONNECT && conn->type == LE_LINK &&
+	    test_bit(HCI_CONN_SCANNING, &conn->flags)) {
+		hci_connect_le_scan_remove(conn);
+		return;
 	}
+
+	hci_abort_conn(conn, hci_proto_disconn_ind(conn));
 }
 
 /* Enter sniff mode */
@@ -552,7 +489,7 @@ static void le_conn_timeout(struct work_struct *work)
 		return;
 	}
 
-	hci_le_create_connection_cancel(conn);
+	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 }
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3fa4cafc2c03..e1083c928d5c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1639,35 +1639,8 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 	discov_stopped = hci_stop_discovery(&req);
 
 	list_for_each_entry(conn, &hdev->conn_hash.list, list) {
-		struct hci_cp_disconnect dc;
-		struct hci_cp_reject_conn_req rej;
-
-		switch (conn->state) {
-		case BT_CONNECTED:
-		case BT_CONFIG:
-			dc.handle = cpu_to_le16(conn->handle);
-			dc.reason = 0x15; /* Terminated due to Power Off */
-			hci_req_add(&req, HCI_OP_DISCONNECT, sizeof(dc), &dc);
-			break;
-		case BT_CONNECT:
-			if (conn->type == LE_LINK)
-				hci_req_add(&req, HCI_OP_LE_CREATE_CONN_CANCEL,
-					    0, NULL);
-			else if (conn->type == ACL_LINK)
-				hci_req_add(&req, HCI_OP_CREATE_CONN_CANCEL,
-					    6, &conn->dst);
-			break;
-		case BT_CONNECT2:
-			bacpy(&rej.bdaddr, &conn->dst);
-			rej.reason = 0x15; /* Terminated due to Power Off */
-			if (conn->type == ACL_LINK)
-				hci_req_add(&req, HCI_OP_REJECT_CONN_REQ,
-					    sizeof(rej), &rej);
-			else if (conn->type == SCO_LINK)
-				hci_req_add(&req, HCI_OP_REJECT_SYNC_CONN_REQ,
-					    sizeof(rej), &rej);
-			break;
-		}
+		/* 0x15 == Terminated due to Power Off */
+		__hci_abort_conn(&req, conn, 0x15);
 	}
 
 	err = hci_req_run(&req, clean_up_hci_complete);
@@ -3053,7 +3026,6 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_cp_unpair_device *cp = data;
 	struct mgmt_rp_unpair_device rp;
 	struct hci_conn_params *params;
-	struct hci_cp_disconnect dc;
 	struct mgmt_pending_cmd *cmd;
 	struct hci_conn *conn;
 	u8 addr_type;
@@ -3167,9 +3139,7 @@ done:
 
 	cmd->cmd_complete = addr_cmd_complete;
 
-	dc.handle = cpu_to_le16(conn->handle);
-	dc.reason = 0x13; /* Remote User Terminated Connection */
-	err = hci_send_cmd(hdev, HCI_OP_DISCONNECT, sizeof(dc), &dc);
+	err = hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
2.5.0

