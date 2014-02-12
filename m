Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] tools/rfcomm-tester: Add RFCOMM server write test case
Date: Wed, 12 Feb 2014 12:41:38 +0100
Message-Id: <1392205301-4204-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will check data write from server to client.
---
 tools/rfcomm-tester.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 80448cb..1c2563d 100644
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
@@ -428,6 +439,18 @@ static void client_hook_func(const void *data, uint16_t len,
 		tester_test_passed();
 }
 
+static void server_hook_func(const void *data, uint16_t len,
+							void *user_data)
+{
+	struct test_data *test_data = tester_get_data();
+	const struct rfcomm_server_data *server_data = test_data->test_data;
+
+	if (memcmp(server_data->send_data, data, len))
+		tester_test_failed();
+	else
+		tester_test_passed();
+}
+
 static void rfcomm_connect_cb(uint16_t handle, uint16_t cid,
 						void *user_data, bool status)
 {
@@ -479,6 +502,7 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct rfcomm_server_data *server_data = data->test_data;
 	int sk, new_sk;
 
 	data->io_id = 0;
@@ -491,6 +515,15 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 		return false;
 	}
 
+	if (server_data->send_data) {
+		if (server_data->data_len != write(new_sk,
+							server_data->send_data,
+							server_data->data_len))
+			tester_test_failed();
+		close(new_sk);
+		return false;
+	}
+
 	close(new_sk);
 
 	tester_test_passed();
@@ -504,6 +537,9 @@ static void connection_cb(uint16_t handle, uint16_t cid, void *user_data,
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_server_data *server_data = data->test_data;
 
+	if (server_data->data_len)
+		return;
+
 	if (server_data->expected_status == status)
 		tester_test_passed();
 	else
@@ -517,6 +553,9 @@ static void client_new_conn(uint16_t handle, void *user_data)
 	struct bthost *bthost;
 
 	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_add_channel_hook(hciemu_client_get_host(data->hciemu),
+					handle,	server_data->client_channel,
+					server_hook_func, NULL);
 	bthost_connect_rfcomm(bthost, handle, server_data->client_channel,
 						connection_cb, NULL);
 }
@@ -590,6 +629,10 @@ int main(int argc, char *argv[])
 			&connect_nval, setup_powered_client, test_connect);
 	test_rfcomm("Basic RFCOMM Socket Server - Success", &listen_success,
 					setup_powered_server, test_server);
+	test_rfcomm("Basic RFCOMM Socket Server - Write Success",
+				&listen_send_success, setup_powered_server,
+				test_server);
+
 	test_rfcomm("Basic RFCOMM Socket Server - Conn Refused", &listen_nval,
 					setup_powered_server, test_server);
 
-- 
1.8.3.1

