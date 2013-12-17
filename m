Return-Path: <cyrus@holtmann.org>
From: Marcin <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 4/4] tools/l2cap-tester: Add server write test case
Date: Tue, 17 Dec 2013 15:49:39 +0100
Message-Id: <1387291779-14960-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1387291779-14960-1-git-send-email-marcin.kraglak@tieto.com>
References: <1387291779-14960-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

This test case checks if data was received on client side.
---
 tools/l2cap-tester.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index cbea26e..35d4634 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -68,6 +68,8 @@ struct l2cap_server_data {
 	uint8_t expect_rsp_code;
 	const void *expect_rsp;
 	uint16_t expect_rsp_len;
+	const void *write_data;
+	uint16_t write_data_len;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -273,6 +275,16 @@ static const struct l2cap_server_data l2cap_server_success_test = {
 	.expect_rsp_code = BT_L2CAP_PDU_CONN_RSP,
 };
 
+static const struct l2cap_server_data l2cap_server_success_write_test = {
+	.server_psm = 0x1001,
+	.send_req_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_req = l2cap_connect_req,
+	.send_req_len = sizeof(l2cap_connect_req),
+	.expect_rsp_code = BT_L2CAP_PDU_CONN_RSP,
+	.write_data = l2cap_write_data,
+	.write_data_len = sizeof(l2cap_write_data),
+};
+
 static const uint8_t l2cap_nval_psm_rsp[] = {	0x00, 0x00,	/* dcid */
 						0x41, 0x00,	/* scid */
 						0x02, 0x00,	/* nval PSM */
@@ -482,6 +494,22 @@ static void l2cap_client_data(const void *data, uint16_t len)
 		tester_test_passed();
 }
 
+static void l2cap_server_data(const void *data, uint16_t len)
+{
+	struct test_data *test_data = tester_get_data();
+	const struct l2cap_server_data *l2data = test_data->test_data;
+
+	if (len != l2data->write_data_len) {
+		tester_test_failed();
+		return;
+	}
+
+	if (memcmp(data, l2data->write_data, len))
+		tester_test_failed();
+	else
+		tester_test_passed();
+}
+
 static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -637,6 +665,7 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct l2cap_server_data *l2data = data->test_data;
 	int sk, new_sk;
 
 	data->io_id = 0;
@@ -652,6 +681,22 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 
 	tester_print("Successfully connected");
 
+	if (l2data->write_data) {
+		struct bthost *temp;
+		int len;
+
+		temp = hciemu_client_get_host(data->hciemu);
+		bthost_l2cap_set_data_handler(temp, l2cap_server_data,
+						l2data->server_psm);
+
+		len = write(new_sk, l2data->write_data,
+						l2data->write_data_len);
+		if (len != l2data->write_data_len)
+			tester_test_failed();
+
+		return FALSE;
+	}
+
 	close(new_sk);
 
 	tester_test_passed();
@@ -794,6 +839,9 @@ int main(int argc, char *argv[])
 	test_l2cap_bredr("L2CAP BR/EDR Server - Success",
 					&l2cap_server_success_test,
 					setup_powered_server, test_server);
+	test_l2cap_bredr("L2CAP BR/EDR Server - Write Success",
+					&l2cap_server_success_write_test,
+					setup_powered_server, test_server);
 	test_l2cap_bredr("L2CAP BR/EDR Server - Invalid PSM",
 					&l2cap_server_nval_psm_test,
 					setup_powered_server, test_server);
-- 
1.8.3.1

