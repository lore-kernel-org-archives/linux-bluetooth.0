Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Add return parameter to cmd_complete callbacks
Date: Fri, 19 Dec 2014 22:26:03 +0200
Message-Id: <1419020763-9139-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1419020763-9139-1-git-send-email-johan.hedberg@gmail.com>
References: <1419020763-9139-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The cmd_complete callbacks for pending mgmt commands may fail e.g. in
the case of memory allocation. Previously this error would be caught and
returned to user space in the form of a failed write on the mgmt socket
(when the error happened in the mgmt command handler) but with the
introduction of the generic cmd_complete callback this information was
lost. This patch returns the feature by making cmd_complete callbacks
return int instead of void.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 85 +++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ec7c0ec3d8d3..3d2f7ad1e655 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -139,7 +139,7 @@ struct pending_cmd {
 	size_t param_len;
 	struct sock *sk;
 	void *user_data;
-	void (*cmd_complete)(struct pending_cmd *cmd, u8 status);
+	int (*cmd_complete)(struct pending_cmd *cmd, u8 status);
 };
 
 /* HCI to MGMT error code conversion table */
@@ -1487,16 +1487,16 @@ static void cmd_complete_rsp(struct pending_cmd *cmd, void *data)
 	cmd_status_rsp(cmd, data);
 }
 
-static void generic_cmd_complete(struct pending_cmd *cmd, u8 status)
+static int generic_cmd_complete(struct pending_cmd *cmd, u8 status)
 {
-	cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, cmd->param,
-		     cmd->param_len);
+	return cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
+			    cmd->param, cmd->param_len);
 }
 
-static void addr_cmd_complete(struct pending_cmd *cmd, u8 status)
+static int addr_cmd_complete(struct pending_cmd *cmd, u8 status)
 {
-	cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, cmd->param,
-		     sizeof(struct mgmt_addr_info));
+	return cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, cmd->param,
+			    sizeof(struct mgmt_addr_info));
 }
 
 static u8 mgmt_bredr_support(struct hci_dev *hdev)
@@ -3098,16 +3098,17 @@ static struct pending_cmd *find_pairing(struct hci_conn *conn)
 	return NULL;
 }
 
-static void pairing_complete(struct pending_cmd *cmd, u8 status)
+static int pairing_complete(struct pending_cmd *cmd, u8 status)
 {
 	struct mgmt_rp_pair_device rp;
 	struct hci_conn *conn = cmd->user_data;
+	int err;
 
 	bacpy(&rp.addr.bdaddr, &conn->dst);
 	rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
-	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, status,
-		     &rp, sizeof(rp));
+	err = cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, status,
+			   &rp, sizeof(rp));
 
 	/* So we don't get further callbacks for this connection */
 	conn->connect_cfm_cb = NULL;
@@ -3122,6 +3123,8 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	clear_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
 
 	hci_conn_put(conn);
+
+	return err;
 }
 
 void mgmt_smp_complete(struct hci_conn *conn, bool complete)
@@ -3947,9 +3950,10 @@ failed:
 	return err;
 }
 
-static void service_discovery_cmd_complete(struct pending_cmd *cmd, u8 status)
+static int service_discovery_cmd_complete(struct pending_cmd *cmd, u8 status)
 {
-	cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, cmd->param, 1);
+	return cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
+			    cmd->param, 1);
 }
 
 static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
@@ -5091,10 +5095,11 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static void conn_info_cmd_complete(struct pending_cmd *cmd, u8 status)
+static int conn_info_cmd_complete(struct pending_cmd *cmd, u8 status)
 {
 	struct hci_conn *conn = cmd->user_data;
 	struct mgmt_rp_get_conn_info rp;
+	int err;
 
 	memcpy(&rp.addr, cmd->param, sizeof(rp.addr));
 
@@ -5108,11 +5113,13 @@ static void conn_info_cmd_complete(struct pending_cmd *cmd, u8 status)
 		rp.max_tx_power = HCI_TX_POWER_INVALID;
 	}
 
-	cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO, status,
-		     &rp, sizeof(rp));
+	err = cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO, status,
+			   &rp, sizeof(rp));
 
 	hci_conn_drop(conn);
 	hci_conn_put(conn);
+
+	return err;
 }
 
 static void conn_info_refresh_complete(struct hci_dev *hdev, u8 hci_status)
@@ -5286,11 +5293,12 @@ unlock:
 	return err;
 }
 
-static void clock_info_cmd_complete(struct pending_cmd *cmd, u8 status)
+static int clock_info_cmd_complete(struct pending_cmd *cmd, u8 status)
 {
 	struct hci_conn *conn = cmd->user_data;
 	struct mgmt_rp_get_clock_info rp;
 	struct hci_dev *hdev;
+	int err;
 
 	memset(&rp, 0, sizeof(rp));
 	memcpy(&rp.addr, &cmd->param, sizeof(rp.addr));
@@ -5310,12 +5318,15 @@ static void clock_info_cmd_complete(struct pending_cmd *cmd, u8 status)
 	}
 
 complete:
-	cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, &rp, sizeof(rp));
+	err = cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, &rp,
+			   sizeof(rp));
 
 	if (conn) {
 		hci_conn_drop(conn);
 		hci_conn_put(conn);
 	}
+
+	return err;
 }
 
 static void get_clock_info_complete(struct hci_dev *hdev, u8 status)
@@ -5552,8 +5563,8 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	if (cp->addr.type == BDADDR_BREDR) {
 		/* Only incoming connections action is supported for now */
 		if (cp->action != 0x01) {
-			err = 0;
-			cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+			err = cmd->cmd_complete(cmd,
+						MGMT_STATUS_INVALID_PARAMS);
 			mgmt_pending_remove(cmd);
 			goto unlock;
 		}
@@ -5585,8 +5596,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	 */
 	if (hci_conn_params_set(&req, &cp->addr.bdaddr, addr_type,
 				auto_conn) < 0) {
-		err = 0;
-		cmd->cmd_complete(cmd, MGMT_STATUS_FAILED);
+		err = cmd->cmd_complete(cmd, MGMT_STATUS_FAILED);
 		mgmt_pending_remove(cmd);
 		goto unlock;
 	}
@@ -5599,10 +5609,8 @@ added:
 		/* ENODATA means no HCI commands were needed (e.g. if
 		 * the adapter is powered off).
 		 */
-		if (err == -ENODATA) {
-			cmd->cmd_complete(cmd, MGMT_STATUS_SUCCESS);
-			err = 0;
-		}
+		if (err == -ENODATA)
+			err = cmd->cmd_complete(cmd, MGMT_STATUS_SUCCESS);
 		mgmt_pending_remove(cmd);
 	}
 
@@ -5668,8 +5676,8 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		u8 addr_type;
 
 		if (!bdaddr_type_is_valid(cp->addr.type)) {
-			err = 0;
-			cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+			err = cmd->cmd_complete(cmd,
+						MGMT_STATUS_INVALID_PARAMS);
 			mgmt_pending_remove(cmd);
 			goto unlock;
 		}
@@ -5679,9 +5687,8 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 						  &cp->addr.bdaddr,
 						  cp->addr.type);
 			if (err) {
-				err = 0;
-				cmd->cmd_complete(cmd,
-						  MGMT_STATUS_INVALID_PARAMS);
+				err = cmd->cmd_complete(cmd,
+							MGMT_STATUS_INVALID_PARAMS);
 				mgmt_pending_remove(cmd);
 				goto unlock;
 			}
@@ -5701,15 +5708,15 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						addr_type);
 		if (!params) {
-			err = 0;
-			cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+			err = cmd->cmd_complete(cmd,
+						MGMT_STATUS_INVALID_PARAMS);
 			mgmt_pending_remove(cmd);
 			goto unlock;
 		}
 
 		if (params->auto_connect == HCI_AUTO_CONN_DISABLED) {
-			err = 0;
-			cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+			err = cmd->cmd_complete(cmd,
+						MGMT_STATUS_INVALID_PARAMS);
 			mgmt_pending_remove(cmd);
 			goto unlock;
 		}
@@ -5725,8 +5732,8 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		struct bdaddr_list *b, *btmp;
 
 		if (cp->addr.type) {
-			err = 0;
-			cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+			err = cmd->cmd_complete(cmd,
+						MGMT_STATUS_INVALID_PARAMS);
 			mgmt_pending_remove(cmd);
 			goto unlock;
 		}
@@ -5759,10 +5766,8 @@ complete:
 		/* ENODATA means no HCI commands were needed (e.g. if
 		 * the adapter is powered off).
 		 */
-		if (err == -ENODATA) {
-			cmd->cmd_complete(cmd, MGMT_STATUS_SUCCESS);
-			err = 0;
-		}
+		if (err == -ENODATA)
+			err = cmd->cmd_complete(cmd, MGMT_STATUS_SUCCESS);
 		mgmt_pending_remove(cmd);
 	}
 
-- 
2.1.0

