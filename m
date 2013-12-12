Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] android/tester: Add Socket test invalid params: chan and uuid
Date: Thu, 12 Dec 2013 17:17:47 +0200
Message-Id: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For the socket listen() call parameters channel and uuid cannot be both
zeroes.
---
 android/android-tester.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index a50ed7b..3f763d8 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -716,6 +716,16 @@ static const struct socket_data btsock_inv_param_socktype_l2cap = {
 	.expected_status = BT_STATUS_UNSUPPORTED,
 };
 
+/* Test invalid: channel & uuid are both zeroes */
+static const struct socket_data btsock_inv_params_chan_uuid = {
+	.sock_type = BTSOCK_RFCOMM,
+	.channel = 0,
+	.service_uuid = NULL,
+	.service_name = "Test service",
+	.flags = 0,
+	.expected_status = BT_STATUS_PARM_INVALID,
+};
+
 static void setup_socket_interface(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -795,5 +805,9 @@ int main(int argc, char *argv[])
 			&btsock_inv_param_socktype_l2cap,
 			setup_socket_interface, test_generic_listen, teardown);
 
+	test_bredrle("Test Socket Listen - Invalid: chan, uuid",
+			&btsock_inv_params_chan_uuid,
+			setup_socket_interface, test_generic_listen, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

