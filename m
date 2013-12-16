Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/tester: Add Socket test read channel number after listen
Date: Mon, 16 Dec 2013 10:38:55 +0200
Message-Id: <1387183137-19439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After listen() call Bluedroid sends channel number as (int) through file
descriptor.
---
 android/android-tester.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index a58104d..9b56616 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -82,6 +82,7 @@ struct socket_data {
 	int channel;
 	int flags;
 	bt_status_t expected_status;
+	bool test_channel;
 };
 
 #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
@@ -820,6 +821,16 @@ static const struct socket_data btsock_success = {
 	.expected_status = BT_STATUS_SUCCESS,
 };
 
+static const struct socket_data btsock_success_check_chan = {
+	.sock_type = BTSOCK_RFCOMM,
+	.channel = 1,
+	.service_uuid = NULL,
+	.service_name = "Test service",
+	.flags = 0,
+	.expected_status = BT_STATUS_SUCCESS,
+	.test_channel = true,
+};
+
 static void setup_socket_interface(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -857,6 +868,18 @@ static void test_generic_listen(const void *test_data)
 		return;
 	}
 
+	if (status == BT_STATUS_SUCCESS && test->test_channel) {
+		int channel, len;
+
+		len = read(sock_fd, &channel, sizeof(channel));
+		if (len != sizeof(channel) || channel != test->channel) {
+			tester_test_failed();
+			goto clean;
+		}
+
+		tester_print("read correct channel: %d", channel);
+	}
+
 	tester_test_passed();
 
 clean:
@@ -1035,6 +1058,10 @@ int main(int argc, char *argv[])
 			&btsock_success,
 			setup_socket_interface, test_generic_listen, teardown);
 
+	test_bredrle("Socket Listen - Check returned channel",
+			&btsock_success_check_chan,
+			setup_socket_interface, test_generic_listen, teardown);
+
 	test_bredrle("Socket Connect - Invalid: sock_type 0",
 			&btsock_inv_param_socktype, setup_socket_interface,
 			test_generic_connect, teardown);
-- 
1.8.3.2

