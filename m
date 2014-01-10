Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 12/19] tools/rfcomm-tester: Implement client test case
Date: Fri, 10 Jan 2014 10:18:22 +0100
Message-Id: <1389345509-27206-13-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will test RFCOMM client connection.
---
 tools/rfcomm-tester.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index a4f1c8e..271f554 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -35,6 +35,7 @@
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
+#include "bluetooth/rfcomm.h"
 
 #include "monitor/bt.h"
 #include "emulator/bthost.h"
@@ -49,6 +50,13 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	const void *test_data;
+	unsigned int io_id;
+};
+
+struct rfcomm_client_data {
+	uint8_t server_channel;
+	uint8_t client_channel;
+	int expected_connect_err;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -181,6 +189,11 @@ static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
+	if (data->io_id > 0) {
+		g_source_remove(data->io_id);
+		data->io_id = 0;
+	}
+
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -244,6 +257,11 @@ static void setup_powered_client(const void *test_data)
 			NULL, NULL);
 }
 
+const struct rfcomm_client_data connect_success = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c
+};
+
 static void test_basic(const void *test_data)
 {
 	int sk;
@@ -261,6 +279,104 @@ static void test_basic(const void *test_data)
 	tester_test_passed();
 }
 
+static int create_rfcomm_sock(bdaddr_t *address, uint8_t channel)
+{
+	int sk;
+	struct sockaddr_rc addr;
+
+	sk = socket(PF_BLUETOOTH, SOCK_STREAM | SOCK_NONBLOCK, BTPROTO_RFCOMM);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.rc_family = AF_BLUETOOTH;
+	addr.rc_channel = channel;
+	bacpy(&addr.rc_bdaddr, address);
+
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		close(sk);
+		return -1;
+	}
+
+	return sk;
+}
+
+static int connect_rfcomm_sock(int sk, bdaddr_t *address, uint8_t channel)
+{
+	struct sockaddr_rc addr;
+	int err;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.rc_family = AF_BLUETOOTH;
+	bacpy(&addr.rc_bdaddr, address);
+	addr.rc_channel = htobs(channel);
+
+	err = connect(sk, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0 && !(errno == EAGAIN || errno == EINPROGRESS))
+		return err;
+
+	return 0;
+}
+
+static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
+		gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct rfcomm_client_data *client_data = data->test_data;
+	socklen_t len = sizeof(int);
+	int sk, err, sk_err;
+
+	data->io_id = 0;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+		err = -errno;
+	else
+		err = -sk_err;
+
+	if (client_data->expected_connect_err &&
+				err == client_data->expected_connect_err) {
+		tester_test_passed();
+		return false;
+	}
+
+	if (err < 0)
+		tester_test_failed();
+	else
+		tester_test_passed();
+
+	return false;
+}
+
+static void test_connect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	const struct rfcomm_client_data *client_data = data->test_data;
+	GIOChannel *io;
+	int sk;
+
+	bthost_add_l2cap_server(bthost, 0x0003, NULL, NULL);
+	bthost_add_rfcomm_server(bthost, client_data->server_channel,
+								NULL, NULL);
+
+	sk = create_rfcomm_sock((bdaddr_t *)hciemu_get_master_bdaddr
+							(data->hciemu), 0);
+
+	if (connect_rfcomm_sock(sk, (bdaddr_t *)hciemu_get_client_bdaddr
+			(data->hciemu), client_data->client_channel) < 0) {
+		tester_test_failed();
+	}
+
+	io = g_io_channel_unix_new(sk);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	data->io_id = g_io_add_watch(io, G_IO_OUT, rc_connect_cb, NULL);
+
+	g_io_channel_unref(io);
+
+	tester_print("Connect in progress %d", sk);
+}
+
 #define test_rfcomm(name, data, setup, func) \
 	do { \
 		struct test_data *user; \
@@ -269,6 +385,7 @@ static void test_basic(const void *test_data)
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDR; \
 		user->test_data = data; \
+		user->io_id = 0; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
 				test_post_teardown, 2, user, test_data_free); \
@@ -280,6 +397,8 @@ int main(int argc, char *argv[])
 
 	test_rfcomm("Basic RFCOMM Socket - Success", NULL,
 					setup_powered_client, test_basic);
+	test_rfcomm("Basic RFCOMM Socket Client - Success", &connect_success,
+					setup_powered_client, test_connect);
 
 	return tester_run();
 }
-- 
1.8.3.1

