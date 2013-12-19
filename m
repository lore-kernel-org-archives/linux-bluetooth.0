Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/6] tools/l2cap_tester: Add read server test case
Date: Thu, 19 Dec 2013 15:29:03 +0100
Message-Id: <1387463345-26406-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1387463345-26406-1-git-send-email-marcin.kraglak@tieto.com>
References: <1387463345-26406-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test checks data transfer from remote client to server.
---
 tools/l2cap-tester.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 15b441b..a756a81 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -72,6 +72,9 @@ struct l2cap_server_data {
 	uint8_t expect_rsp_code;
 	const void *expect_rsp;
 	uint16_t expect_rsp_len;
+	uint16_t data_len;
+	const void *read_data;
+	const void *write_data;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -284,6 +287,16 @@ static const struct l2cap_server_data l2cap_server_success_test = {
 	.expect_rsp_code = BT_L2CAP_PDU_CONN_RSP,
 };
 
+static const struct l2cap_server_data l2cap_server_read_success_test = {
+	.server_psm = 0x1001,
+	.send_req_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_req = l2cap_connect_req,
+	.send_req_len = sizeof(l2cap_connect_req),
+	.expect_rsp_code = BT_L2CAP_PDU_CONN_RSP,
+	.read_data = l2_data,
+	.data_len = sizeof(l2_data),
+};
+
 static const uint8_t l2cap_nval_psm_rsp[] = {	0x00, 0x00,	/* dcid */
 						0x41, 0x00,	/* scid */
 						0x02, 0x00,	/* nval PSM */
@@ -496,6 +509,27 @@ static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
+static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_server_data *l2data = data->test_data;
+	char buf[1024];
+	int sk;
+
+	sk = g_io_channel_unix_get_fd(io);
+	read(sk, buf, l2data->data_len);
+
+	if (memcmp(buf, l2data->read_data, l2data->data_len))
+		tester_test_failed();
+	else
+		tester_test_passed();
+
+	close(sk);
+
+	return FALSE;
+}
+
 static void bthost_received_data(const void *buf, uint16_t len,
 							void *user_data)
 {
@@ -691,6 +725,7 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct l2cap_server_data *l2data = data->test_data;
 	int sk, new_sk;
 
 	data->io_id = 0;
@@ -704,6 +739,20 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
+	if (l2data->read_data) {
+		struct bthost *bthost;
+		GIOChannel *new_io;
+
+		new_io = g_io_channel_unix_new(new_sk);
+
+		bthost = hciemu_client_get_host(data->hciemu);
+		g_io_add_watch(new_io, G_IO_IN, server_received_data, NULL);
+		bthost_send_cid(bthost, data->handle, data->dcid,
+					l2data->read_data, l2data->data_len);
+
+		return FALSE;
+	}
+
 	tester_print("Successfully connected");
 
 	close(new_sk);
@@ -727,6 +776,19 @@ static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
 		goto failed;
 	}
 
+	if (code == BT_L2CAP_PDU_CONN_RSP) {
+
+		const struct bt_l2cap_pdu_conn_rsp *rsp = data;
+		if (len == sizeof(rsp) && !rsp->result && !rsp->status)
+			return;
+
+		test_data->dcid = rsp->dcid;
+		test_data->scid = rsp->scid;
+
+		if (l2data->data_len)
+			return;
+	}
+
 	if (!l2data->expect_rsp) {
 		tester_test_passed();
 		return;
@@ -758,6 +820,8 @@ static void client_new_conn(uint16_t handle, void *user_data)
 
 	tester_print("New client connection with handle 0x%04x", handle);
 
+	data->handle = handle;
+
 	if (l2data->send_req) {
 		bthost_l2cap_rsp_cb cb;
 
@@ -854,6 +918,11 @@ int main(int argc, char *argv[])
 	test_l2cap_bredr("L2CAP BR/EDR Server - Success",
 					&l2cap_server_success_test,
 					setup_powered_server, test_server);
+
+	test_l2cap_bredr("L2CAP BR/EDR Server - Read Success",
+					&l2cap_server_read_success_test,
+					setup_powered_server, test_server);
+
 	test_l2cap_bredr("L2CAP BR/EDR Server - Invalid PSM",
 					&l2cap_server_nval_psm_test,
 					setup_powered_server, test_server);
-- 
1.8.3.1

