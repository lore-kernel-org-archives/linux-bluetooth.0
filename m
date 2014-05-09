Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 3/6] Bluetooth: Add support to get connection information
Date: Fri,  9 May 2014 21:35:30 +0200
Message-Id: <1399664133-2892-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399664133-2892-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399664133-2892-1-git-send-email-andrzej.kaczmarek@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for Get Connection Information mgmt command
which can be used to query for information about connection, i.e. RSSI
or local TX power level.

RSSI is returned as response parameter while any other information is
returned in standard EIR format.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/hci_core.h |   2 +
 include/net/bluetooth/mgmt.h     |  16 +++
 net/bluetooth/mgmt.c             | 216 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 211bad6..9be523a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -378,6 +378,8 @@ struct hci_conn {
 	__s8		tx_power;
 	unsigned long	flags;
 
+	unsigned long	conn_info_timestamp;
+
 	__u8		remote_cap;
 	__u8		remote_auth;
 	__u8		remote_id;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d4b571c..34faa2e 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -409,6 +409,22 @@ struct mgmt_cp_load_irks {
 } __packed;
 #define MGMT_LOAD_IRKS_SIZE		2
 
+#define MGMT_CONN_INFO_DATA_TX_POWER	0x00000001
+
+#define MGMT_OP_GET_CONN_INFO		0x0031
+struct mgmt_cp_get_conn_info {
+	struct mgmt_addr_info addr;
+	__u32	data_type;
+} __packed;
+#define MGMT_GET_CONN_INFO_SIZE		(MGMT_ADDR_INFO_SIZE + 4)
+struct mgmt_rp_get_conn_info {
+	struct mgmt_addr_info addr;
+	__s8	rssi;
+	__u32	flags;
+	__le16	eir_len;
+	__u8	eir[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5e88ac9..2d86ce1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -83,6 +83,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_DEBUG_KEYS,
 	MGMT_OP_SET_PRIVACY,
 	MGMT_OP_LOAD_IRKS,
+	MGMT_OP_GET_CONN_INFO,
 };
 
 static const u16 mgmt_events[] = {
@@ -113,6 +114,8 @@ static const u16 mgmt_events[] = {
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
 
+#define CONN_INFO_MAX_AGE	msecs_to_jiffies(2 * 1000)
+
 #define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
 				!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 
@@ -4568,6 +4571,218 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+struct cmd_conn_lookup {
+	struct hci_conn *conn;
+	u8 mgmt_status;
+};
+
+static void get_conn_info_complete(struct pending_cmd *cmd, void *data)
+{
+	struct cmd_conn_lookup *match = data;
+	struct mgmt_cp_get_conn_info *cp;
+	struct mgmt_rp_get_conn_info *rp;
+	char buf[sizeof(*rp) + 3];
+	struct hci_conn *conn = cmd->user_data;
+	__u16 eir_len = 0;
+
+	if (conn != match->conn)
+		return;
+
+	cp = (struct mgmt_cp_get_conn_info *) cmd->param;
+	rp = (struct mgmt_rp_get_conn_info *) buf;
+
+	memset(buf, 0, sizeof(buf));
+	bacpy(&rp->addr.bdaddr, &cp->addr.bdaddr);
+	rp->addr.type = cp->addr.type;
+
+	if (match->mgmt_status) {
+		cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO,
+			     match->mgmt_status, rp, sizeof(*rp));
+		goto done;
+	}
+
+	rp->rssi = conn->rssi;
+
+	if (cp->data_type & MGMT_CONN_INFO_DATA_TX_POWER) {
+		eir_len = eir_append_data(rp->eir, 0, EIR_TX_POWER,
+					  &conn->tx_power,
+					  sizeof(conn->tx_power));
+
+		rp->eir_len = cpu_to_le16(eir_len);
+	}
+
+	cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO,
+			MGMT_STATUS_SUCCESS, rp, sizeof(*rp) + eir_len);
+
+done:
+	hci_conn_drop(conn);
+
+	mgmt_pending_remove(cmd);
+}
+
+static void conn_info_refresh_complete(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_read_rssi *cp;
+	struct hci_conn *conn;
+	struct cmd_conn_lookup match;
+	u16 handle;
+
+	BT_DBG("status 0x%02x", status);
+
+	hci_dev_lock(hdev);
+
+	/* Last command sent in request should be Read RSSI, but if it isn't
+	 * then we look for Read Transmit Power Level which is other command
+	 * sent in request and probably failed.
+	 *
+	 * Both commands have handle as first parameter so it's safe to cast
+	 * data on the same command struct.
+	 */
+	cp = hci_sent_cmd_data(hdev, HCI_OP_READ_RSSI);
+	if (!cp)
+		cp = hci_sent_cmd_data(hdev, HCI_OP_READ_TX_POWER_LEVEL);
+
+	if (!cp) {
+		BT_ERR("invalid sent_cmd in response");
+		goto unlock;
+	}
+
+	handle = __le16_to_cpu(cp->handle);
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn) {
+		BT_ERR("unknown handle (%d) in response", handle);
+		goto unlock;
+	}
+
+	if (!status)
+		conn->conn_info_timestamp = jiffies;
+
+	match.conn = conn;
+	match.mgmt_status = mgmt_status(status);
+
+	/* Cache refresh is complete, now reply for each pending request for
+	 * given connection.
+	 */
+	mgmt_pending_foreach(MGMT_OP_GET_CONN_INFO, hdev,
+			     get_conn_info_complete, &match);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static bool check_pending_conn_info(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	struct pending_cmd *cmd;
+
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		if (cmd->opcode == MGMT_OP_GET_CONN_INFO &&
+		    cmd->user_data == conn)
+			return true;
+	}
+
+	return false;
+}
+
+static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
+			 u16 len)
+{
+	struct mgmt_cp_get_conn_info *cp = data;
+	struct mgmt_rp_get_conn_info rp;
+	struct hci_conn *conn;
+	struct pending_cmd *cmd;
+	struct hci_request req;
+	bool is_pending;
+	int err = 0;
+
+	BT_DBG("%s", hdev->name);
+
+	memset(&rp, 0, sizeof(rp));
+	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
+	rp.addr.type = cp->addr.type;
+
+	if (!bdaddr_type_is_valid(cp->addr.type))
+		return cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &rp, sizeof(rp));
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
+				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
+		goto unlock;
+	}
+
+	if (cp->addr.type == BDADDR_BREDR)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					       &cp->addr.bdaddr);
+	else
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
+
+	if (!conn || conn->state != BT_CONNECTED) {
+		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
+				   MGMT_STATUS_NOT_CONNECTED, &rp, sizeof(rp));
+		goto unlock;
+	}
+
+	/* We need to check if there's another pending request for this conn
+	 * so we don't query controller again - just add another pending and
+	 * return.
+	 */
+	is_pending = check_pending_conn_info(hdev, conn);
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_GET_CONN_INFO, hdev,
+			       data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	hci_conn_hold(conn);
+	cmd->user_data = conn;
+
+	/* There was already pending request for this connection, no need to
+	 * start another request to controller.
+	 */
+	if (is_pending)
+		goto unlock;
+
+	/* Query controller to refresh cached values if they are too old or
+	 * unknown, otherwise just reply.
+	 */
+	if (time_after(jiffies, conn->conn_info_timestamp +
+		       CONN_INFO_MAX_AGE) ||
+	    conn->tx_power == HCI_TX_POWER_INVALID) {
+		struct hci_cp_read_tx_power_level req_txp_cp;
+		struct hci_cp_read_rssi req_rssi_cp;
+
+		hci_req_init(&req, hdev);
+
+		req_txp_cp.handle = cpu_to_le16(conn->handle);
+		req_txp_cp.type = 0x00;
+		hci_req_add(&req, HCI_OP_READ_TX_POWER_LEVEL,
+			    sizeof(req_txp_cp), &req_txp_cp);
+
+		req_rssi_cp.handle = cpu_to_le16(conn->handle);
+		hci_req_add(&req, HCI_OP_READ_RSSI, sizeof(req_rssi_cp),
+			    &req_rssi_cp);
+
+		err = hci_req_run(&req, conn_info_refresh_complete);
+		if (err < 0) {
+			hci_conn_drop(conn);
+			mgmt_pending_remove(cmd);
+		}
+	} else {
+		struct cmd_conn_lookup match = { conn, MGMT_STATUS_SUCCESS };
+
+		get_conn_info_complete(cmd, &match);
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -4623,6 +4838,7 @@ static const struct mgmt_handler {
 	{ set_debug_keys,         false, MGMT_SETTING_SIZE },
 	{ set_privacy,            false, MGMT_SET_PRIVACY_SIZE },
 	{ load_irks,              true,  MGMT_LOAD_IRKS_SIZE },
+	{ get_conn_info,          false, MGMT_GET_CONN_INFO_SIZE },
 };
 
 
-- 
1.9.2
