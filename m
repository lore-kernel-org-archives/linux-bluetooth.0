Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/tester: Add bluetooth HAL test case - name prefix
Date: Wed, 18 Dec 2013 12:54:37 +0100
Message-Id: <1387367677-8099-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387367677-8099-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387367677-8099-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This add prefix for bluetooth HAL test case names. Bluetooth HAL test
cases now can be easily distinguished. Now Bluetooth HAL test cases
can be run separately.
---
 android/android-tester.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index e013e02..55fa702 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1167,63 +1167,63 @@ int main(int argc, char *argv[])
 
 	tester_init(&argc, &argv);
 
-	test_bredrle("Init", NULL, setup_base, test_dummy, teardown);
+	test_bredrle("Bluetooth Init", NULL, setup_base, test_dummy, teardown);
 
-	test_bredrle("Enable - Success", &bluetooth_enable_success_test,
+	test_bredrle("Bluetooth Enable - Success", &bluetooth_enable_success_test,
 					setup_base, test_enable, teardown);
 
-	test_bredrle("Enable - Done", &bluetooth_enable_done_test,
+	test_bredrle("Bluetooth Enable - Done", &bluetooth_enable_done_test,
 			setup_enabled_adapter, test_enable_done, teardown);
 
-	test_bredrle("Disable - Success", &bluetooth_disable_success_test,
+	test_bredrle("Bluetooth Disable - Success", &bluetooth_disable_success_test,
 			setup_enabled_adapter, test_disable, teardown);
 
-	test_bredrle("Set BDNAME - Success",
+	test_bredrle("Bluetooth Set BDNAME - Success",
 					&bluetooth_setprop_bdname_success_test,
 					setup_enabled_adapter,
 					test_setprop_bdname_success, teardown);
 
-	test_bredrle("Set SCAN_MODE - Success",
+	test_bredrle("Bluetooth Set SCAN_MODE - Success",
 				&bluetooth_setprop_scanmode_success_test,
 				setup_enabled_adapter,
 				test_setprop_scanmode_succes, teardown);
 
-	test_bredrle("Set DISCOVERY_TIMEOUT - Success",
+	test_bredrle("Bluetooth Set DISCOVERY_TIMEOUT - Success",
 				&bluetooth_setprop_disctimeout_success_test,
 				setup_enabled_adapter,
 				test_setprop_disctimeout_succes, teardown);
 
-	test_bredrle("Get BDADDR - Success",
+	test_bredrle("Bluetooth Get BDADDR - Success",
 					&bluetooth_getprop_bdaddr_success_test,
 					setup_enabled_adapter,
 					test_getprop_bdaddr_success, teardown);
 
-	test_bredrle("Get BDNAME - Success",
+	test_bredrle("Bluetooth Get BDNAME - Success",
 					&bluetooth_getprop_bdname_success_test,
 					setup_enabled_adapter,
 					test_getprop_bdname_success, teardown);
 
-	test_bredrle("Set UUID - Invalid",
+	test_bredrle("Bluetooth Set UUID - Invalid",
 					&bluetooth_setprop_uuid_invalid_test,
 					setup_enabled_adapter,
 					test_setprop_uuid_invalid, teardown);
 
-	test_bredrle("Set CLASS_OF_DEVICE - Invalid",
+	test_bredrle("Bluetooth Set CLASS_OF_DEVICE - Invalid",
 					&bluetooth_setprop_cod_invalid_test,
 					setup_enabled_adapter,
 					test_setprop_cod_invalid, teardown);
 
-	test_bredrle("Set TYPE_OF_DEVICE - Invalid",
+	test_bredrle("Bluetooth Set TYPE_OF_DEVICE - Invalid",
 					&bluetooth_setprop_tod_invalid_test,
 					setup_enabled_adapter,
 					test_setprop_tod_invalid, teardown);
 
-	test_bredrle("Set REMOTE_RSSI - Invalid",
+	test_bredrle("Bluetooth Set REMOTE_RSSI - Invalid",
 				&bluetooth_setprop_remote_rssi_invalid_test,
 				setup_enabled_adapter,
 				test_setprop_rssi_invalid, teardown);
 
-	test_bredrle("Set SERVICE_RECORD - Invalid",
+	test_bredrle("Bluetooth Set SERVICE_RECORD - Invalid",
 				&bluetooth_setprop_service_record_invalid_test,
 				setup_enabled_adapter,
 				test_setprop_service_record_invalid, teardown);
-- 
1.8.4.2

