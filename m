Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] android/tester: Add Socket test close and listen
Date: Thu, 19 Dec 2013 10:51:39 +0200
Message-Id: <1387443100-4768-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387379717-1457-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387379717-1457-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This test the situation when Android close file descriptor we passed to
it and try to listen() again.
---
 android/android-tester.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 8a2861e..c24f5a6 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1141,6 +1141,62 @@ clean:
 		close(sock_fd);
 }
 
+static void test_listen_close(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct socket_data *test = data->test_data;
+	bt_status_t status;
+	int sock_fd = -1;
+
+	status = data->if_sock->listen(test->sock_type,
+					test->service_name, test->service_uuid,
+					test->channel, &sock_fd, test->flags);
+	if (status != test->expected_status) {
+		tester_warn("sock->listen() failed");
+		tester_test_failed();
+		goto clean;
+	}
+
+	/* Check that file descriptor is valid */
+	if (status == BT_STATUS_SUCCESS && fcntl(sock_fd, F_GETFD) < 0) {
+		tester_warn("sock_fd %d is not valid", sock_fd);
+		tester_test_failed();
+		return;
+	}
+
+	tester_print("Got valid sock_fd: %d", sock_fd);
+
+	/* Now close sock_fd */
+	close(sock_fd);
+	sock_fd = -1;
+
+	/* Try to listen again */
+	status = data->if_sock->listen(test->sock_type,
+					test->service_name, test->service_uuid,
+					test->channel, &sock_fd, test->flags);
+	if (status != test->expected_status) {
+		tester_warn("sock->listen() failed");
+		tester_test_failed();
+		goto clean;
+	}
+
+	/* Check that file descriptor is valid */
+	if (status == BT_STATUS_SUCCESS && fcntl(sock_fd, F_GETFD) < 0) {
+		tester_warn("sock_fd %d is not valid", sock_fd);
+		tester_test_failed();
+		return;
+	}
+
+	tester_print("Got valid sock_fd: %d", sock_fd);
+
+	tester_test_passed();
+
+clean:
+	if (sock_fd >= 0)
+		close(sock_fd);
+
+}
+
 static void test_generic_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1363,6 +1419,10 @@ int main(int argc, char *argv[])
 			&btsock_success_check_chan,
 			setup_socket_interface, test_generic_listen, teardown);
 
+	test_bredrle("Socket Listen - Close and Listen again",
+			&btsock_success_check_chan,
+			setup_socket_interface, test_listen_close, teardown);
+
 	test_bredrle("Socket Connect - Invalid: sock_type 0",
 			&btsock_inv_param_socktype, setup_socket_interface,
 			test_generic_connect, teardown);
-- 
1.8.3.2

