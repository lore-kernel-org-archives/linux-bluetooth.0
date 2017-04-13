Return-Path: <eu@felipetonello.com>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v5 BlueZ 2/4] Bluetooth: L2CAP: Add handler for Connection Parameter Update Response
Date: Thu, 13 Apr 2017 13:22:01 +0100
Message-Id: <20170413122203.4247-3-eu@felipetonello.com>
In-Reply-To: <20170413122203.4247-1-eu@felipetonello.com>
References: <20170413122203.4247-1-eu@felipetonello.com>
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
 net/bluetooth/l2cap_core.c    | 47 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 803a7f4d93a7..eb7ecd5df9a3 100644
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
index 585d15ce0a33..1e8539c59cfd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1489,6 +1489,14 @@ void l2cap_le_conn_update_req(struct l2cap_conn *conn, u8 min_interval,
 {
 	struct l2cap_conn_param_update_req req;
 
+	/* set temporary parameters in case of a successful
+	 * response from the peer device
+	 */
+	conn->conn_param_req.min = min_interval;
+	conn->conn_param_req.max = max_interval;
+	conn->conn_param_req.latency = latency;
+	conn->conn_param_req.to_multiplier = supv_timeout;
+
 	req.min = cpu_to_le16(min_interval);
 	req.max = cpu_to_le16(max_interval);
 	req.latency = cpu_to_le16(latency);
@@ -5261,6 +5269,44 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
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
+	rsp = (struct l2cap_conn_param_update_rsp *)data;
+	result = le16_to_cpu(rsp->result);
+
+	BT_DBG("result 0x%4.4x", result);
+
+	if (result == 0) {
+		u8 store_hint;
+
+		store_hint =
+			hci_le_conn_update(hcon,
+					   conn->conn_param_req.min,
+					   conn->conn_param_req.max,
+					   conn->conn_param_req.latency,
+					   conn->conn_param_req.to_multiplier);
+		mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_type,
+				    store_hint, conn->conn_param_req.min,
+				    conn->conn_param_req.max,
+				    conn->conn_param_req.latency,
+				    conn->conn_param_req.to_multiplier);
+	}
+
+	return 0;
+}
+
 static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 				struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				u8 *data)
@@ -5641,6 +5687,7 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_CONN_PARAM_UPDATE_RSP:
+		err = l2cap_conn_param_update_rsp(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_LE_CONN_RSP:
-- 
2.12.2
