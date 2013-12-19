Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/3] android/tester: Test that connect call returns channel number
Date: Thu, 19 Dec 2013 10:49:20 +0200
Message-Id: <1387442960-4584-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387442960-4584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387376336-17092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1387442960-4584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The test connects to emulated bthost and read channel number
---
 android/android-tester.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 55fa702..8a2861e 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1080,6 +1080,27 @@ static void setup_socket_interface(const void *test_data)
 	tester_setup_complete();
 }
 
+static void setup_socket_interface_enabled(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const void *sock;
+	bt_status_t status;
+
+	setup(data);
+
+	sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
+	if (!sock) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->if_sock = sock;
+
+	status = data->if_bluetooth->enable();
+	if (status != BT_STATUS_SUCCESS)
+		tester_setup_failed();
+}
+
 static void test_generic_listen(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1148,6 +1169,97 @@ clean:
 		close(sock_fd);
 }
 
+static gboolean socket_chan_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	int sock_fd = g_io_channel_unix_get_fd(io);
+	struct test_data *data = tester_get_data();
+	const struct socket_data *test = data->test_data;
+	int channel, len;
+
+	tester_print("%s", __func__);
+
+	if (cond & G_IO_HUP) {
+		tester_warn("Socket %d hang up", sock_fd);
+		goto failed;
+	}
+
+	if (cond & (G_IO_ERR | G_IO_NVAL)) {
+		tester_warn("Socket error: sock %d cond %d", sock_fd, cond);
+		goto failed;
+	}
+
+	if (test->test_channel) {
+		len = read(sock_fd, &channel, sizeof(channel));
+		if (len != sizeof(channel) || channel != test->channel)
+			goto failed;
+
+		tester_print("read correct channel: %d", channel);
+		tester_test_passed();
+		return FALSE;
+	}
+
+failed:
+	tester_test_failed();
+	return FALSE;
+}
+
+static void test_socket_real_connect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct socket_data *test = data->test_data;
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	const uint8_t *client_bdaddr;
+	bt_bdaddr_t emu_bdaddr;
+	bt_status_t status;
+	int sock_fd = -1;
+
+	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
+	if (!client_bdaddr) {
+		tester_warn("No client bdaddr");
+		tester_test_failed();
+		return;
+	}
+
+	bdaddr2android((bdaddr_t *) client_bdaddr, &emu_bdaddr);
+
+	bthost_set_server_psm(bthost, 0x0003);
+
+	status = data->if_sock->connect(&emu_bdaddr, test->sock_type,
+					test->service_uuid, test->channel,
+					&sock_fd, test->flags);
+	if (status != test->expected_status) {
+		tester_test_failed();
+		goto clean;
+	}
+
+	/* Check that file descriptor is valid */
+	if (status == BT_STATUS_SUCCESS && fcntl(sock_fd, F_GETFD) == -1) {
+		tester_test_failed();
+		return;
+	}
+
+	tester_print("status %d sock_fd %d", status, sock_fd);
+
+	if (status == BT_STATUS_SUCCESS) {
+		GIOChannel *io;
+
+		io = g_io_channel_unix_new(sock_fd);
+		g_io_channel_set_close_on_unref(io, TRUE);
+
+		g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				socket_chan_cb, NULL);
+
+		g_io_channel_unref(io);
+	}
+
+	return;
+
+clean:
+	if (sock_fd >= 0)
+		close(sock_fd);
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -1267,5 +1379,10 @@ int main(int argc, char *argv[])
 			&btsock_inv_param_bdaddr,
 			setup_socket_interface, test_generic_connect, teardown);
 
+	test_bredrle("Socket Connect - Check returned chan",
+			&btsock_success_check_chan,
+			setup_socket_interface_enabled,
+			test_socket_real_connect, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

