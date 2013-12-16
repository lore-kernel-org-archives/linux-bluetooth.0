Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/tester: Add Socket test invalid bdaddr
Date: Mon, 16 Dec 2013 10:38:57 +0200
Message-Id: <1387183137-19439-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387183137-19439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387183137-19439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test for zero bluetooth address in connect().
---
 android/android-tester.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 9acc79d..eb938d0 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -832,6 +832,16 @@ static const struct socket_data btsock_success_check_chan = {
 	.test_channel = true,
 };
 
+static const struct socket_data btsock_inv_param_bdaddr = {
+	.bdaddr = NULL,
+	.sock_type = BTSOCK_RFCOMM,
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
@@ -1075,5 +1085,9 @@ int main(int argc, char *argv[])
 			&btsock_inv_params_chan_uuid,
 			setup_socket_interface, test_generic_connect, teardown);
 
+	test_bredrle("Socket Connect - Invalid: bdaddr",
+			&btsock_inv_param_bdaddr,
+			setup_socket_interface, test_generic_connect, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

