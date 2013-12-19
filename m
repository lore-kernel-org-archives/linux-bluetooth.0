Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/6] tools/l2cap_tester: Add write server test case
Date: Thu, 19 Dec 2013 15:29:04 +0100
Message-Id: <1387463345-26406-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1387463345-26406-1-git-send-email-marcin.kraglak@tieto.com>
References: <1387463345-26406-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These test case send data from local server to remote client.
---
 tools/l2cap-tester.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index a756a81..55e8ac9 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -297,6 +297,16 @@ static const struct l2cap_server_data l2cap_server_read_success_test = {
 	.data_len = sizeof(l2_data),
 };
 
+static const struct l2cap_server_data l2cap_server_write_success_test = {
+	.server_psm = 0x1001,
+	.send_req_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_req = l2cap_connect_req,
+	.send_req_len = sizeof(l2cap_connect_req),
+	.expect_rsp_code = BT_L2CAP_PDU_CONN_RSP,
+	.write_data = l2_data,
+	.data_len = sizeof(l2_data),
+};
+
 static const uint8_t l2cap_nval_psm_rsp[] = {	0x00, 0x00,	/* dcid */
 						0x41, 0x00,	/* scid */
 						0x02, 0x00,	/* nval PSM */
@@ -547,6 +557,23 @@ static void bthost_received_data(const void *buf, uint16_t len,
 		tester_test_passed();
 }
 
+static void server_bthost_received_data(const void *buf, uint16_t len,
+							void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_server_data *l2data = data->test_data;
+
+	if (len != l2data->data_len) {
+		tester_test_failed();
+		return;
+	}
+
+	if (memcmp(buf, l2data->write_data, l2data->data_len))
+		tester_test_failed();
+	else
+		tester_test_passed();
+}
+
 static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -751,6 +778,17 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 					l2data->read_data, l2data->data_len);
 
 		return FALSE;
+	} else if (l2data->write_data) {
+		struct bthost *bthost;
+
+		bthost = hciemu_client_get_host(data->hciemu);
+		bthost_add_cid_hook(bthost, data->handle, data->scid,
+					server_bthost_received_data, NULL);
+
+		write(new_sk, l2data->write_data, l2data->data_len);
+		close(new_sk);
+
+		return FALSE;
 	}
 
 	tester_print("Successfully connected");
@@ -923,6 +961,10 @@ int main(int argc, char *argv[])
 					&l2cap_server_read_success_test,
 					setup_powered_server, test_server);
 
+	test_l2cap_bredr("L2CAP BR/EDR Server - Write Success",
+					&l2cap_server_write_success_test,
+					setup_powered_server, test_server);
+
 	test_l2cap_bredr("L2CAP BR/EDR Server - Invalid PSM",
 					&l2cap_server_nval_psm_test,
 					setup_powered_server, test_server);
-- 
1.8.3.1

