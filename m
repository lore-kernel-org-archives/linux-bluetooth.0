Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 18/19] tools/rfcomm-tester: Add RFCOMM server test case
Date: Fri, 10 Jan 2014 10:18:28 +0100
Message-Id: <1389345509-27206-19-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test case create RFCOMM server and accept incoming connection from
client bthost.
---
 tools/rfcomm-tester.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index f471c3b..72e765f 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -59,6 +59,12 @@ struct rfcomm_client_data {
 	int expected_connect_err;
 };
 
+struct rfcomm_server_data {
+	uint8_t server_channel;
+	uint8_t client_channel;
+	bool expected_status;
+};
+
 static void mgmt_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
@@ -257,6 +263,37 @@ static void setup_powered_client(const void *test_data)
 			NULL, NULL);
 }
 
+static void setup_powered_server_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Controller powered on");
+
+	tester_setup_complete();
+}
+
+static void setup_powered_server(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Powering on controller");
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
+				sizeof(param), param,
+				NULL, NULL, NULL);
+	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+			sizeof(param), param, setup_powered_server_callback,
+			NULL, NULL);
+}
+
 const struct rfcomm_client_data connect_success = {
 	.server_channel = 0x0c,
 	.client_channel = 0x0c
@@ -268,6 +305,12 @@ const struct rfcomm_client_data connect_nval = {
 	.expected_connect_err = -ECONNREFUSED
 };
 
+const struct rfcomm_server_data listen_success = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.expected_status = true
+};
+
 static void test_basic(const void *test_data)
 {
 	int sk;
@@ -383,6 +426,105 @@ static void test_connect(const void *test_data)
 	tester_print("Connect in progress %d", sk);
 }
 
+static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	int sk, new_sk;
+
+	data->io_id = 0;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	new_sk = accept(sk, NULL, NULL);
+	if (new_sk < 0) {
+		tester_test_failed();
+		return false;
+	}
+
+	close(new_sk);
+
+	tester_test_passed();
+
+	return false;
+}
+
+static void connection_cb(uint16_t handle, uint16_t cid,
+					uint8_t channel, void *user_data,
+					bool status)
+{
+	struct test_data *data = tester_get_data();
+	const struct rfcomm_server_data *server_data = data->test_data;
+
+	if (server_data->expected_status == status)
+		tester_test_passed();
+	else
+		tester_test_failed();
+}
+
+static void client_new_conn(uint16_t handle, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct rfcomm_server_data *server_data = data->test_data;
+	struct bthost *bthost;
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_connect_rfcomm(bthost, handle, server_data->client_channel,
+						connection_cb, NULL);
+}
+
+static void test_server(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct rfcomm_server_data *server_data = data->test_data;
+	const uint8_t *master_bdaddr;
+	uint8_t addr_type;
+	struct bthost *bthost;
+	GIOChannel *io;
+	int sk;
+
+	sk = create_rfcomm_sock((bdaddr_t *)
+				hciemu_get_master_bdaddr(data->hciemu),
+				server_data->server_channel);
+	if (sk < 0) {
+		tester_test_failed();
+		return;
+	}
+
+	if (listen(sk, 5) < 0) {
+		tester_warn("listening on socket failed: %s (%u)",
+				strerror(errno), errno);
+		tester_test_failed();
+		close(sk);
+		return;
+	}
+
+	io = g_io_channel_unix_new(sk);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	data->io_id = g_io_add_watch(io, G_IO_IN, rfcomm_listen_cb, NULL);
+	g_io_channel_unref(io);
+
+	tester_print("Listening for connections");
+
+	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
+	if (!master_bdaddr) {
+		tester_warn("No master bdaddr");
+		tester_test_failed();
+		return;
+	}
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_set_connect_cb(bthost, client_new_conn, data);
+
+	if (data->hciemu_type == HCIEMU_TYPE_BREDR)
+		addr_type = BDADDR_BREDR;
+	else
+		addr_type = BDADDR_LE_PUBLIC;
+
+	bthost_hci_connect(bthost, master_bdaddr, addr_type);
+}
+
 #define test_rfcomm(name, data, setup, func) \
 	do { \
 		struct test_data *user; \
@@ -407,6 +549,8 @@ int main(int argc, char *argv[])
 					setup_powered_client, test_connect);
 	test_rfcomm("Basic RFCOMM Socket Client - Conn Refused",
 			&connect_nval, setup_powered_client, test_connect);
+	test_rfcomm("Basic RFCOMM Socket Server - Success", &listen_success,
+					setup_powered_server, test_server);
 
 	return tester_run();
 }
-- 
1.8.3.1

