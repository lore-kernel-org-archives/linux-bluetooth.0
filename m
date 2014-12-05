Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] Bluetooth: Fix Get Conn Info to use cmd_complete callback
Date: Fri,  5 Dec 2014 13:36:09 +0200
Message-Id: <1417779369-6428-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
References: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes the Get Connection Information mgmt command to take
advantage of the new cmd_complete callback. This allows for great
simplifications in the logic for constructing the cmd_complete event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 82 ++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 50 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8467d3552aa9..3bbc93ed4206 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5074,67 +5074,42 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-struct cmd_conn_lookup {
-	struct hci_conn *conn;
-	bool valid_tx_power;
-	u8 mgmt_status;
-};
-
-static void get_conn_info_complete(struct pending_cmd *cmd, void *data)
+static void conn_info_cmd_complete(struct pending_cmd *cmd, u8 status)
 {
-	struct cmd_conn_lookup *match = data;
-	struct mgmt_cp_get_conn_info *cp;
-	struct mgmt_rp_get_conn_info rp;
 	struct hci_conn *conn = cmd->user_data;
+	struct mgmt_rp_get_conn_info rp;
 
-	if (conn != match->conn)
-		return;
-
-	cp = (struct mgmt_cp_get_conn_info *) cmd->param;
-
-	memset(&rp, 0, sizeof(rp));
-	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
-	rp.addr.type = cp->addr.type;
+	memcpy(&rp.addr, cmd->param, sizeof(rp.addr));
 
-	if (!match->mgmt_status) {
+	if (status == MGMT_STATUS_SUCCESS) {
 		rp.rssi = conn->rssi;
-
-		if (match->valid_tx_power) {
-			rp.tx_power = conn->tx_power;
-			rp.max_tx_power = conn->max_tx_power;
-		} else {
-			rp.tx_power = HCI_TX_POWER_INVALID;
-			rp.max_tx_power = HCI_TX_POWER_INVALID;
-		}
+		rp.tx_power = conn->tx_power;
+		rp.max_tx_power = conn->max_tx_power;
+	} else {
+		rp.rssi = HCI_RSSI_INVALID;
+		rp.tx_power = HCI_TX_POWER_INVALID;
+		rp.max_tx_power = HCI_TX_POWER_INVALID;
 	}
 
-	cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO,
-		     match->mgmt_status, &rp, sizeof(rp));
+	cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO, status,
+		     &rp, sizeof(rp));
 
 	hci_conn_drop(conn);
 	hci_conn_put(conn);
-
-	mgmt_pending_remove(cmd);
 }
 
-static void conn_info_refresh_complete(struct hci_dev *hdev, u8 status)
+static void conn_info_refresh_complete(struct hci_dev *hdev, u8 hci_status)
 {
 	struct hci_cp_read_rssi *cp;
+	struct pending_cmd *cmd;
 	struct hci_conn *conn;
-	struct cmd_conn_lookup match;
 	u16 handle;
+	u8 status;
 
 	BT_DBG("status 0x%02x", status);
 
 	hci_dev_lock(hdev);
 
-	/* TX power data is valid in case request completed successfully,
-	 * otherwise we assume it's not valid. At the moment we assume that
-	 * either both or none of current and max values are valid to keep code
-	 * simple.
-	 */
-	match.valid_tx_power = !status;
-
 	/* Commands sent in request are either Read RSSI or Read Transmit Power
 	 * Level so we check which one was last sent to retrieve connection
 	 * handle.  Both commands have handle as first parameter so it's safe to
@@ -5147,29 +5122,29 @@ static void conn_info_refresh_complete(struct hci_dev *hdev, u8 status)
 	cp = hci_sent_cmd_data(hdev, HCI_OP_READ_RSSI);
 	if (!cp) {
 		cp = hci_sent_cmd_data(hdev, HCI_OP_READ_TX_POWER);
-		status = 0;
+		status = MGMT_STATUS_SUCCESS;
+	} else {
+		status = mgmt_status(hci_status);
 	}
 
 	if (!cp) {
-		BT_ERR("invalid sent_cmd in response");
+		BT_ERR("invalid sent_cmd in conn_info response");
 		goto unlock;
 	}
 
 	handle = __le16_to_cpu(cp->handle);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!conn) {
-		BT_ERR("unknown handle (%d) in response", handle);
+		BT_ERR("unknown handle (%d) in conn_info response", handle);
 		goto unlock;
 	}
 
-	match.conn = conn;
-	match.mgmt_status = mgmt_status(status);
+	cmd = mgmt_pending_find_data(MGMT_OP_GET_CONN_INFO, hdev, conn);
+	if (!cmd)
+		goto unlock;
 
-	/* Cache refresh is complete, now reply for mgmt request for given
-	 * connection only.
-	 */
-	mgmt_pending_foreach(MGMT_OP_GET_CONN_INFO, hdev,
-			     get_conn_info_complete, &match);
+	cmd->cmd_complete(cmd, status);
+	mgmt_pending_remove(cmd);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -5215,6 +5190,12 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	if (mgmt_pending_find_data(MGMT_OP_GET_CONN_INFO, hdev, conn)) {
+		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
+				   MGMT_STATUS_BUSY, &rp, sizeof(rp));
+		goto unlock;
+	}
+
 	/* To avoid client trying to guess when to poll again for information we
 	 * calculate conn info age as random value between min/max set in hdev.
 	 */
@@ -5270,6 +5251,7 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		hci_conn_hold(conn);
 		cmd->user_data = hci_conn_get(conn);
+		cmd->cmd_complete = conn_info_cmd_complete;
 
 		conn->conn_info_timestamp = jiffies;
 	} else {
-- 
2.1.0

