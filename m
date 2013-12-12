Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/tester: Add Socket listen() invalid sock type
Date: Thu, 12 Dec 2013 12:49:10 +0200
Message-Id: <1386845350-13982-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386845350-13982-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386845350-13982-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test invalid socket type during listen()
---
 android/android-tester.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 15fd29e..e2554a3 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -690,6 +690,15 @@ static void test_dummy(const void *test_data)
 
 /* Test Socket HAL */
 
+static const struct generic_data btsock_inv_param_socktype = {
+	.sock_type = 0,
+	.channel = 1,
+	.service_uuid = NULL,
+	.service_name = "Test service",
+	.flags = 0,
+	.expected_status = BT_STATUS_PARM_INVALID,
+};
+
 static void setup_socket_interface(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -706,6 +715,28 @@ static void setup_socket_interface(const void *test_data)
 	tester_setup_complete();
 }
 
+static void test_generic_listen(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	bt_status_t status;
+	int sock_fd = -1;
+
+	status = data->if_sock->listen(test->sock_type,
+					test->service_name, test->service_uuid,
+					test->channel, &sock_fd, test->flags);
+	if (status != test->expected_status) {
+		tester_test_failed();
+		goto clean;
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
@@ -739,5 +770,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Test Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
+	test_bredrle("Test Socket Listen - Invalid sock type",
+			&btsock_inv_param_socktype, setup_socket_interface,
+			test_generic_listen, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

