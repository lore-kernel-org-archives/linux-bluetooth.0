Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix syntax of test cases
Date: Mon, 16 Dec 2013 10:03:25 +0200
Message-Id: <1387181005-12044-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove "Test" from every test message print and correct typo.
---
 android/android-tester.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index f388d94..a58104d 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -811,7 +811,7 @@ static const struct socket_data btsock_inv_params_chan_uuid = {
 	.expected_status = BT_STATUS_PARM_INVALID,
 };
 
-static const struct socket_data btsock_sucess = {
+static const struct socket_data btsock_success = {
 	.sock_type = BTSOCK_RFCOMM,
 	.channel = 1,
 	.service_uuid = NULL,
@@ -980,66 +980,66 @@ int main(int argc, char *argv[])
 
 	tester_init(&argc, &argv);
 
-	test_bredrle("Test Init", NULL, setup_base, test_dummy, teardown);
+	test_bredrle("Init", NULL, setup_base, test_dummy, teardown);
 
-	test_bredrle("Test Enable - Success", &bluetooth_enable_success_test,
+	test_bredrle("Enable - Success", &bluetooth_enable_success_test,
 					setup_base, test_enable, teardown);
 
-	test_bredrle("Test Enable - Done", &bluetooth_enable_done_test,
+	test_bredrle("Enable - Done", &bluetooth_enable_done_test,
 			setup_enabled_adapter, test_enable_done, teardown);
 
-	test_bredrle("Test Disable - Success", &bluetooth_disable_success_test,
+	test_bredrle("Disable - Success", &bluetooth_disable_success_test,
 			setup_enabled_adapter, test_disable, teardown);
 
-	test_bredrle("Test Set BDNAME - Success",
+	test_bredrle("Set BDNAME - Success",
 					&bluetooth_setprop_bdname_success_test,
 					setup_enabled_adapter,
 					test_setprop_bdname_success, teardown);
 
-	test_bredrle("Test Set SCAN_MODE - Success",
+	test_bredrle("Set SCAN_MODE - Success",
 				&bluetooth_setprop_scanmode_success_test,
 				setup_enabled_adapter,
 				test_setprop_scanmode_succes, teardown);
 
-	test_bredrle("Test Set DISCOVERY_TIMEOUT - Success",
+	test_bredrle("Set DISCOVERY_TIMEOUT - Success",
 				&bluetooth_setprop_disctimeout_success_test,
 				setup_enabled_adapter,
 				test_setprop_disctimeout_succes, teardown);
 
-	test_bredrle("Test Get BDADDR - Success",
+	test_bredrle("Get BDADDR - Success",
 					&bluetooth_getprop_bdaddr_success_test,
 					setup_enabled_adapter,
 					test_getprop_bdaddr_success, teardown);
 
-	test_bredrle("Test Get BDNAME - Success",
+	test_bredrle("Get BDNAME - Success",
 					&bluetooth_getprop_bdname_success_test,
 					setup_enabled_adapter,
 					test_getprop_bdname_success, teardown);
 
-	test_bredrle("Test Socket Init", NULL, setup_socket_interface,
+	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-	test_bredrle("Test Socket Listen - Invalid: sock_type 0",
+	test_bredrle("Socket Listen - Invalid: sock_type 0",
 			&btsock_inv_param_socktype, setup_socket_interface,
 			test_generic_listen, teardown);
 
-	test_bredrle("Test Socket Listen - Invalid: sock_type L2CAP",
+	test_bredrle("Socket Listen - Invalid: sock_type L2CAP",
 			&btsock_inv_param_socktype_l2cap,
 			setup_socket_interface, test_generic_listen, teardown);
 
-	test_bredrle("Test Socket Listen - Invalid: chan, uuid",
+	test_bredrle("Socket Listen - Invalid: chan, uuid",
 			&btsock_inv_params_chan_uuid,
 			setup_socket_interface, test_generic_listen, teardown);
 
-	test_bredrle("Test Socket Listen - Check returned fd valid",
-			&btsock_sucess,
+	test_bredrle("Socket Listen - Check returned fd valid",
+			&btsock_success,
 			setup_socket_interface, test_generic_listen, teardown);
 
-	test_bredrle("Test Socket Connect - Invalid: sock_type 0",
+	test_bredrle("Socket Connect - Invalid: sock_type 0",
 			&btsock_inv_param_socktype, setup_socket_interface,
 			test_generic_connect, teardown);
 
-	test_bredrle("Test Socket Connect - Invalid: sock_type L2CAP",
+	test_bredrle("Socket Connect - Invalid: sock_type L2CAP",
 			&btsock_inv_param_socktype_l2cap,
 			setup_socket_interface, test_generic_connect, teardown);
 
-- 
1.8.3.2

