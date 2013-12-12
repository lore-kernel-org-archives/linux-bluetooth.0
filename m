Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] android/tester: Add Socket test connect() invalid sock_type
Date: Thu, 12 Dec 2013 17:17:52 +0200
Message-Id: <1386861474-29524-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/android-tester.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 4a96fb8..a6fbcb5 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -71,6 +71,7 @@ struct socket_data {
 	btsock_type_t sock_type;
 	const char *service_name;
 	const uint8_t *service_uuid;
+	const bt_bdaddr_t *bdaddr;
 	int channel;
 	int flags;
 	bt_status_t expected_status;
@@ -699,7 +700,12 @@ static void test_dummy(const void *test_data)
 
 /* Test Socket HAL */
 
+const bt_bdaddr_t bdaddr_dummy = {
+	.address = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55}
+};
+
 static const struct socket_data btsock_inv_param_socktype = {
+	.bdaddr = &bdaddr_dummy,
 	.sock_type = 0,
 	.channel = 1,
 	.service_uuid = NULL,
@@ -780,6 +786,34 @@ clean:
 		close(sock_fd);
 }
 
+static void test_generic_connect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct socket_data *test = data->test_data;
+	bt_status_t status;
+	int sock_fd = -1;
+
+	status = data->if_sock->connect(test->bdaddr, test->sock_type,
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
+	tester_test_passed();
+
+clean:
+	if (sock_fd >= 0)
+		close(sock_fd);
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -829,5 +863,9 @@ int main(int argc, char *argv[])
 			&btsock_sucess,
 			setup_socket_interface, test_generic_listen, teardown);
 
+	test_bredrle("Test Socket Connect - Invalid: sock_type 0",
+			&btsock_inv_param_socktype, setup_socket_interface,
+			test_generic_connect, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

