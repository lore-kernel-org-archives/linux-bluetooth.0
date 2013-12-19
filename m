Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/6] emulator: Add new method for adding l2cap server
Date: Thu, 19 Dec 2013 15:29:00 +0100
Message-Id: <1387463345-26406-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This method allow user to add l2cap server and register
connect callback. If no callback is specified, it will behave
like bthost_set_server_psm() method.
---
 emulator/bthost.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 emulator/bthost.h |  5 +++++
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 654338d..7ccef9c 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -90,6 +90,13 @@ struct l2cap_pending_req {
 	struct l2cap_pending_req *next;
 };
 
+struct l2cap_conn_cb_data {
+	uint16_t psm;
+	bthost_l2cap_connect_cb func;
+	void *user_data;
+	struct l2cap_conn_cb_data *next;
+};
+
 struct bthost {
 	uint8_t bdaddr[6];
 	bthost_send_func send_handler;
@@ -101,7 +108,7 @@ struct bthost {
 	void *cmd_complete_data;
 	bthost_new_conn_cb new_conn_cb;
 	void *new_conn_data;
-	uint16_t server_psm;
+	struct l2cap_conn_cb_data *new_l2cap_conn_data;
 	struct l2cap_pending_req *l2reqs;
 };
 
@@ -187,6 +194,19 @@ static struct l2conn *btconn_find_l2cap_conn_by_scid(struct btconn *conn,
 	return NULL;
 }
 
+static struct l2cap_conn_cb_data *bthost_find_l2cap_cb_by_psm(
+					struct bthost *bthost, uint16_t psm)
+{
+	struct l2cap_conn_cb_data *cb;
+
+	for (cb = bthost->new_l2cap_conn_data; cb != NULL; cb = cb->next) {
+		if (cb->psm == psm)
+			return cb;
+	}
+
+	return NULL;
+}
+
 void bthost_destroy(struct bthost *bthost)
 {
 	if (!bthost)
@@ -214,6 +234,13 @@ void bthost_destroy(struct bthost *bthost)
 		free(req);
 	}
 
+	while (bthost->new_l2cap_conn_data) {
+		struct l2cap_conn_cb_data *cb = bthost->new_l2cap_conn_data;
+
+		bthost->new_l2cap_conn_data = cb->next;
+		free(cb);
+	}
+
 	free(bthost);
 }
 
@@ -737,7 +764,7 @@ static bool l2cap_conn_req(struct bthost *bthost, struct btconn *conn,
 	memset(&rsp, 0, sizeof(rsp));
 	rsp.scid = req->scid;
 
-	if (bthost->server_psm && bthost->server_psm == psm)
+	if (bthost_find_l2cap_cb_by_psm(bthost, psm))
 		rsp.dcid = cpu_to_le16(conn->next_cid++);
 	else
 		rsp.result = cpu_to_le16(0x0002); /* PSM Not Supported */
@@ -747,6 +774,8 @@ static bool l2cap_conn_req(struct bthost *bthost, struct btconn *conn,
 
 	if (!rsp.result) {
 		struct bt_l2cap_pdu_config_req conf_req;
+		struct l2cap_conn_cb_data *cb_data;
+		struct l2conn *l2conn;
 
 		bthost_add_l2cap_conn(bthost, conn, le16_to_cpu(rsp.dcid),
 							le16_to_cpu(rsp.scid),
@@ -757,6 +786,14 @@ static bool l2cap_conn_req(struct bthost *bthost, struct btconn *conn,
 
 		l2cap_sig_send(bthost, conn, BT_L2CAP_PDU_CONFIG_REQ, 0,
 						&conf_req, sizeof(conf_req));
+
+		cb_data = bthost_find_l2cap_cb_by_psm(bthost, psm);
+		l2conn  = btconn_find_l2cap_conn_by_scid(conn,
+							le16_to_cpu(rsp.scid));
+
+		if (cb_data && l2conn->psm == cb_data->psm && cb_data->func)
+			cb_data->func(conn->handle, l2conn->dcid,
+							cb_data->user_data);
 	}
 
 	return true;
@@ -1012,7 +1049,7 @@ static bool l2cap_le_conn_req(struct bthost *bthost, struct btconn *conn,
 	rsp.mps = 23;
 	rsp.credits = 1;
 
-	if (bthost->server_psm && bthost->server_psm == psm)
+	if (bthost_find_l2cap_cb_by_psm(bthost, psm))
 		rsp.dcid = cpu_to_le16(conn->next_cid++);
 	else
 		rsp.result = cpu_to_le16(0x0002); /* PSM Not Supported */
@@ -1249,9 +1286,26 @@ void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 	send_command(bthost, BT_HCI_CMD_LE_START_ENCRYPT, &cmd, sizeof(cmd));
 }
 
+void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
+				bthost_l2cap_connect_cb func, void *user_data)
+{
+	struct l2cap_conn_cb_data *data;
+
+	data = malloc(sizeof(struct l2cap_conn_cb_data));
+	if (!data)
+		return;
+
+	data->psm = psm;
+	data->user_data = user_data;
+	data->func = func;
+	data->next = bthost->new_l2cap_conn_data;
+
+	bthost->new_l2cap_conn_data = data;
+}
+
 void bthost_set_server_psm(struct bthost *bthost, uint16_t psm)
 {
-	bthost->server_psm = psm;
+	bthost_add_l2cap_server(bthost, psm, NULL, NULL);
 }
 
 void bthost_start(struct bthost *bthost)
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 474ada9..2b8f212 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -74,8 +74,13 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable);
 
 void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 							const uint8_t ltk[16]);
+typedef void (*bthost_l2cap_connect_cb) (uint16_t handle, uint16_t cid,
+							void *user_data);
 
 void bthost_set_server_psm(struct bthost *bthost, uint16_t psm);
 
+void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
+				bthost_l2cap_connect_cb func, void *user_data);
+
 void bthost_start(struct bthost *bthost);
 void bthost_stop(struct bthost *bthost);
-- 
1.8.3.1

