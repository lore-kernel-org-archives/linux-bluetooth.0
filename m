Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] emulator: Add connect callback when setting l2cap server
Date: Thu, 19 Dec 2013 10:30:02 +0100
Message-Id: <1387445406-20324-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1387445406-20324-1-git-send-email-marcin.kraglak@tieto.com>
References: <1387445406-20324-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add possibility to set connect callback when client will be
connected to bthost l2cap server.
---
 emulator/bthost.c    | 36 +++++++++++++++++++++++++++++++++++-
 emulator/bthost.h    |  5 ++++-
 tools/l2cap-tester.c |  2 +-
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 430108e..b5852f3 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -90,6 +90,12 @@ struct l2cap_pending_req {
 	struct l2cap_pending_req *next;
 };
 
+struct l2cap_conn_cb_data {
+	uint16_t psm;
+	bthost_l2cap_connect_cb func;
+	void *user_data;
+};
+
 struct bthost {
 	uint8_t bdaddr[6];
 	bthost_send_func send_handler;
@@ -101,6 +107,7 @@ struct bthost {
 	void *cmd_complete_data;
 	bthost_new_conn_cb new_conn_cb;
 	void *new_conn_data;
+	struct l2cap_conn_cb_data *new_l2cap_conn_data;
 	uint16_t server_psm;
 	struct l2cap_pending_req *l2reqs;
 };
@@ -214,6 +221,8 @@ void bthost_destroy(struct bthost *bthost)
 		free(req);
 	}
 
+	free(bthost->new_l2cap_conn_data);
+
 	free(bthost);
 }
 
@@ -747,6 +756,8 @@ static bool l2cap_conn_req(struct bthost *bthost, struct btconn *conn,
 
 	if (!rsp.result) {
 		struct bt_l2cap_pdu_config_req conf_req;
+		struct l2cap_conn_cb_data *cb_data;
+		struct l2conn *l2conn;
 
 		bthost_add_l2cap_conn(bthost, conn, le16_to_cpu(rsp.dcid),
 							le16_to_cpu(rsp.scid),
@@ -757,6 +768,14 @@ static bool l2cap_conn_req(struct bthost *bthost, struct btconn *conn,
 
 		l2cap_sig_send(bthost, conn, BT_L2CAP_PDU_CONFIG_REQ, 0,
 						&conf_req, sizeof(conf_req));
+
+		cb_data = bthost->new_l2cap_conn_data;
+		l2conn  = btconn_find_l2cap_conn_by_scid(conn,
+							le16_to_cpu(rsp.scid));
+
+		if (cb_data && l2conn->psm == cb_data->psm)
+			cb_data->func(conn->handle, l2conn->dcid,
+							cb_data->user_data);
 	}
 
 	return true;
@@ -1249,9 +1268,24 @@ void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 	send_command(bthost, BT_HCI_CMD_LE_START_ENCRYPT, &cmd, sizeof(cmd));
 }
 
-void bthost_set_server_psm(struct bthost *bthost, uint16_t psm)
+void bthost_set_server_psm(struct bthost *bthost, uint16_t psm,
+				bthost_l2cap_connect_cb func, void *user_data)
 {
 	bthost->server_psm = psm;
+
+	if (func) {
+		struct l2cap_conn_cb_data *data;
+
+		data = malloc(sizeof(struct l2cap_conn_cb_data));
+		if (!data)
+			return;
+
+		data->psm = psm;
+		data->user_data = user_data;
+		data->func = func;
+
+		bthost->new_l2cap_conn_data = data;
+	}
 }
 
 void bthost_start(struct bthost *bthost)
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 474ada9..1d4f7f2 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -74,8 +74,11 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable);
 
 void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 							const uint8_t ltk[16]);
+typedef void (*bthost_l2cap_connect_cb) (uint16_t handle, uint16_t cid,
+							void *user_data);
 
-void bthost_set_server_psm(struct bthost *bthost, uint16_t psm);
+void bthost_set_server_psm(struct bthost *bthost, uint16_t psm,
+				bthost_l2cap_connect_cb func, void *user_data);
 
 void bthost_start(struct bthost *bthost);
 void bthost_stop(struct bthost *bthost);
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index e4dade2..9161953 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -568,7 +568,7 @@ static void test_connect(const void *test_data)
 
 	if (l2data->server_psm) {
 		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-		bthost_set_server_psm(bthost, l2data->server_psm);
+		bthost_set_server_psm(bthost, l2data->server_psm, NULL, NULL);
 	}
 
 	sk = create_l2cap_sock(data, 0);
-- 
1.8.3.1

