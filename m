Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH v4 BlueZ 2/4] Bluetooth: L2CAP: Add handler for Connection Parameter Update Response
Date: Tue, 14 Mar 2017 18:30:56 +0000
Message-Id: <20170314183058.25555-3-eu@felipetonello.com>
In-Reply-To: <20170314183058.25555-1-eu@felipetonello.com>
References: <20170314183058.25555-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of connected hosts that doesn't support the Connection
Parameters Request Link Layer Control Procedure, we should support this
event response from a slave device.

The slave device will answer based on a previous request done by the
master (BlueZ in this case) and update current connection parameters
accordingly. If the request was rejected, we don't do anything.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 include/net/bluetooth/l2cap.h |  2 ++
 net/bluetooth/l2cap_core.c    | 45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0073a01c61e9..eb58d811596f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -654,6 +654,8 @@ struct l2cap_conn {
 	struct mutex		chan_lock;
 	struct kref		ref;
 	struct list_head	users;
+
+	struct l2cap_conn_param_update_req conn_param_req;
 };
 
 struct l2cap_user {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 27a38b4543e1..b7c34eb4e912 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1489,6 +1489,13 @@ void l2cap_le_conn_update_req(struct l2cap_conn *conn, u8 min_interval,
 {
 	struct l2cap_conn_param_update_req req;
 
+	/* set temporary parameters in case of a successful
+	 * response from the peer device */
+	conn->conn_param_req.min = min_interval;
+	conn->conn_param_req.max = max_interval;
+	conn->conn_param_req.latency = latency;
+	conn->conn_param_req.to_multiplier = supv_timeout;
+
 	req.min = cpu_to_le16(min_interval);
 	req.max = cpu_to_le16(max_interval);
 	req.latency = cpu_to_le16(latency);
@@ -5251,6 +5258,43 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 	return 0;
 }
 
+static inline int l2cap_conn_param_update_rsp(struct l2cap_conn *conn,
+					      struct l2cap_cmd_hdr *cmd,
+					      u16 cmd_len, u8 *data)
+{
+	struct hci_conn *hcon = conn->hcon;
+	struct l2cap_conn_param_update_rsp *rsp;
+	u8 result;
+
+	if (hcon->role != HCI_ROLE_SLAVE)
+		return -EINVAL;
+
+	if (cmd_len != sizeof(struct l2cap_conn_param_update_rsp))
+		return -EPROTO;
+
+	rsp = (struct l2cap_conn_param_update_rsp *) data;
+	result = le16_to_cpu(rsp->result);
+
+	BT_DBG("result 0x%4.4x", result);
+
+	if (result == 0) {
+		u8 store_hint;
+
+		store_hint = hci_le_conn_update(hcon,
+			conn->conn_param_req.min,
+			conn->conn_param_req.max,
+			conn->conn_param_req.latency,
+			conn->conn_param_req.to_multiplier);
+		mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_type,
+			store_hint, conn->conn_param_req.min,
+			conn->conn_param_req.max,
+			conn->conn_param_req.latency,
+			conn->conn_param_req.to_multiplier);
+	}
+
+	return 0;
+}
+
 static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 				struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				u8 *data)
@@ -5633,6 +5677,7 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_CONN_PARAM_UPDATE_RSP:
+		err = l2cap_conn_param_update_rsp(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_LE_CONN_RSP:
-- 
2.12.0

