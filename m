Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] tools/l2cap_tester: Add write client test case
Date: Thu, 19 Dec 2013 10:30:04 +0100
Message-Id: <1387445406-20324-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1387445406-20324-1-git-send-email-marcin.kraglak@tieto.com>
References: <1387445406-20324-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test case write data from client to remote server.
---
 tools/l2cap-tester.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 1d00c93..7f37de3 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -262,6 +262,13 @@ static const struct  l2cap_client_data client_connect_read_success_test = {
 	.data_len = sizeof(l2_data),
 };
 
+static const struct  l2cap_client_data client_connect_write_success_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.write_data = l2_data,
+	.data_len = sizeof(l2_data),
+};
+
 static const struct l2cap_client_data client_connect_nval_psm_test = {
 	.client_psm = 0x1001,
 	.expect_err = ECONNREFUSED,
@@ -489,6 +496,23 @@ static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
+static void bthost_received_data(const void *buf, uint16_t len,
+							void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_client_data *l2data = data->test_data;
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
@@ -521,6 +545,16 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 					l2data->read_data, l2data->data_len);
 
 		return FALSE;
+	} else if (l2data->write_data) {
+		struct bthost *bthost;
+
+		bthost = hciemu_client_get_host(data->hciemu);
+		bthost_add_cid_hook(bthost, data->handle, data->dcid,
+					bthost_received_data, NULL);
+
+		write(sk, l2data->write_data, l2data->data_len);
+
+		return FALSE;
 	}
 
 	if (-err != l2data->expect_err)
@@ -811,6 +845,10 @@ int main(int argc, char *argv[])
 					&client_connect_read_success_test,
 					setup_powered_client, test_connect);
 
+	test_l2cap_bredr("L2CAP BR/EDR Client - Write Success",
+					&client_connect_write_success_test,
+					setup_powered_client, test_connect);
+
 	test_l2cap_bredr("L2CAP BR/EDR Client - Invalid PSM",
 					&client_connect_nval_psm_test,
 					setup_powered_client, test_connect);
-- 
1.8.3.1

