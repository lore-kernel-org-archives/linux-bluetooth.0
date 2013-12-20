Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/tester: Add Socket test invalid double listen
Date: Fri, 20 Dec 2013 14:09:51 +0200
Message-Id: <1387541393-2669-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add Socket test making listen two times on the same RFCOMM channel.
---
 android/android-tester.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 5e60397..fb95dd2 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1129,6 +1129,16 @@ static const struct socket_data btsock_inv_param_bdaddr = {
 	.expected_status = BT_STATUS_PARM_INVALID,
 };
 
+static const struct socket_data btsock_inv_listen_listen = {
+	.sock_type = BTSOCK_RFCOMM,
+	.channel = 1,
+	.service_uuid = NULL,
+	.service_name = "Test service",
+	.flags = 0,
+	.expected_status = BT_STATUS_FAIL,
+	.test_channel = true,
+};
+
 static void setup_socket_interface(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1264,6 +1274,43 @@ clean:
 
 }
 
+static void test_listen_listen(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct socket_data *test = data->test_data;
+	bt_status_t status;
+	int sock_fd1 = -1, sock_fd2 = -1;
+
+	status = data->if_sock->listen(test->sock_type,
+					test->service_name, test->service_uuid,
+					test->channel, &sock_fd1, test->flags);
+	if (status != BT_STATUS_SUCCESS) {
+		tester_warn("sock->listen() failed");
+		tester_test_failed();
+		goto clean;
+	}
+
+	status = data->if_sock->listen(test->sock_type,
+					test->service_name, test->service_uuid,
+					test->channel, &sock_fd2, test->flags);
+	if (status != test->expected_status) {
+		tester_warn("sock->listen() failed, status %d", status);
+		tester_test_failed();
+		goto clean;
+	}
+
+	tester_print("status after second listen(): %d", status);
+
+	tester_test_passed();
+
+clean:
+	if (sock_fd1 >= 0)
+		close(sock_fd1);
+
+	if (sock_fd2 >= 0)
+		close(sock_fd2);
+}
+
 static void test_generic_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1568,6 +1615,10 @@ int main(int argc, char *argv[])
 			&btsock_success_check_chan,
 			setup_socket_interface, test_listen_close, teardown);
 
+	test_bredrle("Socket Listen - Invalid: double Listen",
+			&btsock_inv_listen_listen,
+			setup_socket_interface, test_listen_listen, teardown);
+
 	test_bredrle("Socket Connect - Invalid: sock_type 0",
 			&btsock_inv_param_socktype, setup_socket_interface,
 			test_generic_connect, teardown);
-- 
1.8.3.2

