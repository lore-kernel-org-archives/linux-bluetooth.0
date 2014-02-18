Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/6] tools/rfcomm-tester: Add RFCOMM server write test case
Date: Tue, 18 Feb 2014 08:50:52 +0100
Message-Id: <1392709855-32600-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392709855-32600-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392709855-32600-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will check data write from server to client.
---
 tools/rfcomm-tester.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 42355cf..765de88 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -66,6 +66,9 @@ struct rfcomm_server_data {
 	uint8_t server_channel;
 	uint8_t client_channel;
 	bool expected_status;
+	const uint8_t *send_data;
+	const uint8_t *read_data;
+	uint16_t data_len;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -318,6 +321,14 @@ const struct rfcomm_server_data listen_success = {
 	.expected_status = true
 };
 
+const struct rfcomm_server_data listen_send_success = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.expected_status = true,
+	.data_len = sizeof(data),
+	.send_data = data
+};
+
 const struct rfcomm_server_data listen_nval = {
 	.server_channel = 0x0c,
 	.client_channel = 0x0e,
@@ -438,6 +449,25 @@ static void client_hook_func(const void *data, uint16_t len,
 		tester_test_passed();
 }
 
+static void server_hook_func(const void *data, uint16_t len,
+							void *user_data)
+{
+	struct test_data *test_data = tester_get_data();
+	const struct rfcomm_server_data *server_data = test_data->test_data;
+	ssize_t ret;
+
+	if (server_data->data_len != len) {
+		tester_test_failed();
+		return;
+	}
+
+	ret = memcmp(server_data->send_data, data, len);
+	if (ret)
+		tester_test_failed();
+	else
+		tester_test_passed();
+}
+
 static void rfcomm_connect_cb(uint16_t handle, uint16_t cid,
 						void *user_data, bool status)
 {
@@ -490,7 +520,9 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct rfcomm_server_data *server_data = data->test_data;
 	int sk, new_sk;
+	ssize_t ret;
 
 	data->io_id = 0;
 
@@ -502,6 +534,16 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 		return false;
 	}
 
+	if (server_data->send_data) {
+		ret = write(new_sk, server_data->send_data,
+							server_data->data_len);
+		if (ret != server_data->data_len)
+			tester_test_failed();
+
+		close(new_sk);
+		return false;
+	}
+
 	close(new_sk);
 
 	tester_test_passed();
@@ -515,6 +557,9 @@ static void connection_cb(uint16_t handle, uint16_t cid, void *user_data,
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_server_data *server_data = data->test_data;
 
+	if (server_data->data_len)
+		return;
+
 	if (server_data->expected_status == status)
 		tester_test_passed();
 	else
@@ -528,6 +573,9 @@ static void client_new_conn(uint16_t handle, void *user_data)
 	struct bthost *bthost;
 
 	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_add_rfcomm_channel_hook(bthost, handle,
+						server_data->client_channel,
+						server_hook_func, NULL);
 	bthost_connect_rfcomm(bthost, handle, server_data->client_channel,
 						connection_cb, NULL);
 }
@@ -601,6 +649,9 @@ int main(int argc, char *argv[])
 			&connect_nval, setup_powered_client, test_connect);
 	test_rfcomm("Basic RFCOMM Socket Server - Success", &listen_success,
 					setup_powered_server, test_server);
+	test_rfcomm("Basic RFCOMM Socket Server - Write Success",
+				&listen_send_success, setup_powered_server,
+				test_server);
 	test_rfcomm("Basic RFCOMM Socket Server - Conn Refused", &listen_nval,
 					setup_powered_server, test_server);
 
-- 
1.8.3.1

