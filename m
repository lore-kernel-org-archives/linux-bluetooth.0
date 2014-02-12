Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] tools/rfcomm-tester: Add RFCOMM client write test case
Date: Wed, 12 Feb 2014 12:41:37 +0100
Message-Id: <1392205301-4204-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will test sending data through RFCOMM socket from client to server.
---
 tools/rfcomm-tester.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 44df7e7..80448cb 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -57,6 +57,9 @@ struct rfcomm_client_data {
 	uint8_t server_channel;
 	uint8_t client_channel;
 	int expected_connect_err;
+	const uint8_t *send_data;
+	const uint8_t *read_data;
+	uint16_t data_len;
 };
 
 struct rfcomm_server_data {
@@ -294,6 +297,15 @@ const struct rfcomm_client_data connect_success = {
 	.client_channel = 0x0c
 };
 
+const uint8_t data[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
+
+const struct rfcomm_client_data connect_send_success = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.data_len = sizeof(data),
+	.send_data = data
+};
+
 const struct rfcomm_client_data connect_nval = {
 	.server_channel = 0x0c,
 	.client_channel = 0x0e,
@@ -389,6 +401,13 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 		return false;
 	}
 
+	if (client_data->send_data) {
+		if (client_data->data_len != write(sk, client_data->send_data,
+							client_data->data_len))
+			tester_test_failed();
+		return false;
+	}
+
 	if (err < 0)
 		tester_test_failed();
 	else
@@ -397,6 +416,30 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 	return false;
 }
 
+static void client_hook_func(const void *data, uint16_t len,
+							void *user_data)
+{
+	struct test_data *test_data = tester_get_data();
+	const struct rfcomm_client_data *client_data = test_data->test_data;
+
+	if (memcmp(client_data->send_data, data, len))
+		tester_test_failed();
+	else
+		tester_test_passed();
+}
+
+static void rfcomm_connect_cb(uint16_t handle, uint16_t cid,
+						void *user_data, bool status)
+{
+	struct test_data *data = tester_get_data();
+	const struct rfcomm_client_data *client_data = data->test_data;
+
+	if (client_data->send_data)
+		bthost_add_channel_hook(hciemu_client_get_host(data->hciemu),
+					handle,	client_data->client_channel,
+					client_hook_func, NULL);
+}
+
 static void test_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -408,7 +451,7 @@ static void test_connect(const void *test_data)
 
 	bthost_add_l2cap_server(bthost, 0x0003, NULL, NULL);
 	bthost_add_rfcomm_server(bthost, client_data->server_channel,
-								NULL, NULL);
+						rfcomm_connect_cb, NULL);
 
 	master_addr = hciemu_get_master_bdaddr(data->hciemu);
 	client_addr = hciemu_get_client_bdaddr(data->hciemu);
@@ -540,6 +583,9 @@ int main(int argc, char *argv[])
 					setup_powered_client, test_basic);
 	test_rfcomm("Basic RFCOMM Socket Client - Success", &connect_success,
 					setup_powered_client, test_connect);
+	test_rfcomm("Basic RFCOMM Socket Client - Write Success",
+			&connect_send_success, setup_powered_client,
+			test_connect);
 	test_rfcomm("Basic RFCOMM Socket Client - Conn Refused",
 			&connect_nval, setup_powered_client, test_connect);
 	test_rfcomm("Basic RFCOMM Socket Server - Success", &listen_success,
-- 
1.8.3.1

