Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v5 2/5] Bluetooth: Add support to get connection information
Date: Wed, 14 May 2014 13:43:03 +0200
Message-ID: <1400067786-10677-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400067786-10677-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400067786-10677-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for Get Connection Information mgmt command
which can be used to query for information about connection, i.e. RSSI
and local TX power level.

In general values cached in hci_conn are returned as long as they are
considered valid, i.e. do not exceed age limit set in hdev. This limit
is calculated as random value between min/max values to avoid client
trying to guess when to poll for updated information.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/hci_core.h |   2 +
 include/net/bluetooth/mgmt.h     |  12 +++
 net/bluetooth/mgmt.c             | 196 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4623f45..cbbab63 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -384,6 +384,8 @@ struct hci_conn {
 	__s8		tx_power;
 	unsigned long	flags;
 
+	unsigned long	conn_info_timestamp;
+
 	__u8		remote_cap;
 	__u8		remote_auth;
 	__u8		remote_id;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d4b571c..226ae03 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -409,6 +409,18 @@ struct mgmt_cp_load_irks {
 } __packed;
 #define MGMT_LOAD_IRKS_SIZE		2
 
+#define MGMT_OP_GET_CONN_INFO		0x0031
+struct mgmt_cp_get_conn_info {
+	struct mgmt_addr_info addr;
+} __packed;
+#define MGMT_GET_CONN_INFO_SIZE		MGMT_ADDR_INFO_SIZE
+struct mgmt_rp_get_conn_info {
+	struct mgmt_addr_info addr;
+	__s8	rssi;
+	__s8	tx_power;
+	__s8	max_tx_power;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f2a9422..0e5a316 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -83,6 +83,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_DEBUG_KEYS,
 	MGMT_OP_SET_PRIVACY,
 	MGMT_OP_LOAD_IRKS,
+	MGMT_OP_GET_CONN_INFO,
 };
 
 static const u16 mgmt_events[] = {
@@ -4557,6 +4558,200 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+struct cmd_conn_lookup {
+	struct hci_conn *conn;
+	bool valid_tx_power;
+	u8 mgmt_status;
+};
+
+static void get_conn_info_complete(struct pending_cmd *cmd, void *data)
+{
+	struct cmd_conn_lookup *match = data;
+	struct mgmt_cp_get_conn_info *cp;
+	struct mgmt_rp_get_conn_info rp;
+	struct hci_conn *conn = cmd->user_data;
+
+	if (conn != match->conn)
+		return;
+
+	cp = (struct mgmt_cp_get_conn_info *) cmd->param;
+
+	memset(&rp, 0, sizeof(rp));
+	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
+	rp.addr.type = cp->addr.type;
+
+	if (!match->mgmt_status) {
+		rp.rssi = conn->rssi;
+
+		if (match->valid_tx_power)
+			rp.tx_power = conn->tx_power;
+		else
+			rp.tx_power = HCI_TX_POWER_INVALID;
+
+		rp.max_tx_power = HCI_TX_POWER_INVALID;
+	}
+
+	cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO,
+		     match->mgmt_status, &rp, sizeof(rp));
+
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
+	/* TX power data is valid in case request completed successfully,
+	 * otherwise we assume it's not valid.
+	 */
+	match.valid_tx_power = !status;
+
+	/* Commands sent in request are either Read RSSI or Read Transmit Power
+	 * Level so we check which one was last sent to retrieve connection
+	 * handle.  Both commands have handle as first parameter so it's safe to
+	 * cast data on the same command struct.
+	 *
+	 * First command sent is always Read RSSI and we fail only if it fails.
+	 * In other case we simply override error to indicate success as we
+	 * already remembered if TX power value is actually valid.
+	 */
+	cp = hci_sent_cmd_data(hdev, HCI_OP_READ_RSSI);
+	if (!cp) {
+		cp = hci_sent_cmd_data(hdev, HCI_OP_READ_TX_POWER);
+		status = 0;
+	}
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
+	match.conn = conn;
+	match.mgmt_status = mgmt_status(status);
+
+	/* Cache refresh is complete, now reply for mgmt request for given
+	 * connection only.
+	 */
+	mgmt_pending_foreach(MGMT_OP_GET_CONN_INFO, hdev,
+			     get_conn_info_complete, &match);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
+			 u16 len)
+{
+	struct mgmt_cp_get_conn_info *cp = data;
+	struct mgmt_rp_get_conn_info rp;
+	struct hci_conn *conn;
+	unsigned long conn_info_age;
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
+	/* To avoid client trying to guess when to poll again for information we
+	 * calculate conn info age as random value between min/max set in hdev.
+	 */
+	conn_info_age = hdev->conn_info_min_age +
+			prandom_u32_max(hdev->conn_info_max_age -
+					hdev->conn_info_min_age);
+
+	/* Query controller to refresh cached values if they are too old or were
+	 * never read.
+	 */
+	if (time_after(jiffies, conn->conn_info_timestamp + conn_info_age) ||
+	    !conn->conn_info_timestamp) {
+		struct hci_request req;
+		struct hci_cp_read_tx_power req_txp_cp;
+		struct hci_cp_read_rssi req_rssi_cp;
+		struct pending_cmd *cmd;
+
+		hci_req_init(&req, hdev);
+		req_rssi_cp.handle = cpu_to_le16(conn->handle);
+		hci_req_add(&req, HCI_OP_READ_RSSI, sizeof(req_rssi_cp),
+			    &req_rssi_cp);
+
+		req_txp_cp.handle = cpu_to_le16(conn->handle);
+		req_txp_cp.type = 0x00;
+		hci_req_add(&req, HCI_OP_READ_TX_POWER,
+			    sizeof(req_txp_cp), &req_txp_cp);
+
+		err = hci_req_run(&req, conn_info_refresh_complete);
+		if (err < 0)
+			goto unlock;
+
+		cmd = mgmt_pending_add(sk, MGMT_OP_GET_CONN_INFO, hdev,
+				       data, len);
+		if (!cmd) {
+			err = -ENOMEM;
+			goto unlock;
+		}
+
+		hci_conn_hold(conn);
+		cmd->user_data = conn;
+
+		conn->conn_info_timestamp = jiffies;
+	} else {
+		/* Cache is valid, just reply with values cached in hci_conn */
+		rp.rssi = conn->rssi;
+		rp.tx_power = conn->tx_power;
+		rp.max_tx_power = HCI_TX_POWER_INVALID;
+
+		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
+				   MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
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
@@ -4612,6 +4807,7 @@ static const struct mgmt_handler {
 	{ set_debug_keys,         false, MGMT_SETTING_SIZE },
 	{ set_privacy,            false, MGMT_SET_PRIVACY_SIZE },
 	{ load_irks,              true,  MGMT_LOAD_IRKS_SIZE },
+	{ get_conn_info,          false, MGMT_GET_CONN_INFO_SIZE },
 };
 
 
-- 
1.9.3
