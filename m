Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 14/19] emulator/bthost: Implement bthost_connect_rfcomm
Date: Fri, 10 Jan 2014 10:18:24 +0100
Message-Id: <1389345509-27206-15-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This method will start L2CAP connection on RFCOMM PSM and continue
connecting to rfcomm server. User can specify callback to be called
after connection.
---
 emulator/bthost.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h |  4 ++++
 2 files changed, 66 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 391d6cd..4006b71 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -168,6 +168,13 @@ struct rfcomm_conn_cb_data {
 	struct rfcomm_conn_cb_data *next;
 };
 
+struct rfcomm_connection_data {
+	uint8_t channel;
+	struct btconn *conn;
+	bthost_rfcomm_connect_cb cb;
+	void *user_data;
+};
+
 struct bthost {
 	uint8_t bdaddr[6];
 	bthost_send_func send_handler;
@@ -179,6 +186,7 @@ struct bthost {
 	void *cmd_complete_data;
 	bthost_new_conn_cb new_conn_cb;
 	void *new_conn_data;
+	struct rfcomm_connection_data *rfcomm_conn_data;
 	struct l2cap_conn_cb_data *new_l2cap_conn_data;
 	struct rfcomm_conn_cb_data *new_rfcomm_conn_data;
 	struct l2cap_pending_req *l2reqs;
@@ -338,6 +346,10 @@ void bthost_destroy(struct bthost *bthost)
 		free(cb);
 	}
 
+	if (bthost->rfcomm_conn_data)
+		free(bthost->rfcomm_conn_data);
+
+
 	free(bthost);
 }
 
@@ -977,6 +989,19 @@ static bool l2cap_conn_req(struct bthost *bthost, struct btconn *conn,
 	return true;
 }
 
+static void rfcomm_sabm_send(struct bthost *bthost, struct btconn *conn,
+			struct l2conn *l2conn, uint8_t cr, uint8_t dlci)
+{
+	struct rfcomm_cmd cmd;
+
+	cmd.address = RFCOMM_ADDR(cr, dlci);
+	cmd.control = RFCOMM_CTRL(RFCOMM_SABM, 1);
+	cmd.length = RFCOMM_LEN8(0);
+	cmd.fcs = rfcomm_fcs2((uint8_t *)&cmd);
+
+	send_acl(bthost, conn->handle, l2conn->dcid, &cmd, sizeof(cmd));
+}
+
 static bool l2cap_conn_rsp(struct bthost *bthost, struct btconn *conn,
 				uint8_t ident, const void *data, uint16_t len)
 {
@@ -1000,6 +1025,10 @@ static bool l2cap_conn_rsp(struct bthost *bthost, struct btconn *conn,
 
 		l2cap_sig_send(bthost, conn, BT_L2CAP_PDU_CONFIG_REQ, 0,
 							&req, sizeof(req));
+	} else if (l2conn->psm == 0x0003 && le16_to_cpu(rsp->result) == 0 &&
+					le16_to_cpu(rsp->status) == 0 &&
+						bthost->rfcomm_conn_data) {
+		rfcomm_sabm_send(bthost, conn, l2conn, 1, 0);
 	}
 
 	return true;
@@ -1721,6 +1750,39 @@ void bthost_start(struct bthost *bthost)
 	send_command(bthost, BT_HCI_CMD_READ_BD_ADDR, NULL, 0);
 }
 
+bool bthost_connect_rfcomm(struct bthost *bthost, uint16_t handle,
+				uint8_t channel, bthost_rfcomm_connect_cb func,
+				void *user_data)
+{
+	struct rfcomm_connection_data *data;
+	struct bt_l2cap_pdu_conn_req req;
+	struct btconn *conn;
+
+	if (bthost->rfcomm_conn_data)
+		return false;
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn)
+		return false;
+
+	data = malloc(sizeof(struct rfcomm_connection_data));
+	if (!data)
+		return false;
+
+	data->channel = channel;
+	data->conn = conn;
+	data->cb = func;
+	data->user_data = user_data;
+
+	bthost->rfcomm_conn_data = data;
+
+	req.psm = cpu_to_le16(0x0003);
+	req.scid = cpu_to_le16(conn->next_cid++);
+
+	return bthost_l2cap_req(bthost, handle, BT_L2CAP_PDU_CONN_REQ,
+					&req, sizeof(req), NULL, NULL);
+}
+
 void bthost_stop(struct bthost *bthost)
 {
 }
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 2fc21b5..2c9a125 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -90,5 +90,9 @@ typedef void (*bthost_rfcomm_connect_cb) (uint16_t handle, uint16_t cid,
 void bthost_add_rfcomm_server(struct bthost *bthost, uint8_t channel,
 			bthost_rfcomm_connect_cb func, void *user_data);
 
+bool bthost_connect_rfcomm(struct bthost *bthost, uint16_t handle,
+				uint8_t channel, bthost_rfcomm_connect_cb func,
+				void *user_data);
+
 void bthost_start(struct bthost *bthost);
 void bthost_stop(struct bthost *bthost);
-- 
1.8.3.1

