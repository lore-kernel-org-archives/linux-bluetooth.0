Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 9/9] android/tester: Remove old test cases
Date: Thu, 17 Jul 2014 10:29:56 +0200
Message-Id: <1405585796-12301-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes old device discovery test cases that were porrted to newer
testing framework.
---
 android/android-tester.c | 74 ------------------------------------------------
 1 file changed, 74 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index ff14fc8..e17f3ea 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -2163,55 +2163,6 @@ static void test_dummy(const void *test_data)
 	tester_test_passed();
 }
 
-static void test_discovery_start_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	bt_status_t status;
-
-	init_test_conditions(data);
-
-	status = data->if_bluetooth->start_discovery();
-	check_expected_status(status);
-}
-
-static void test_discovery_stop_done(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	bt_status_t status;
-
-	init_test_conditions(data);
-
-	status = data->if_bluetooth->cancel_discovery();
-	check_expected_status(status);
-}
-
-static void test_discovery_stop_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-
-	init_test_conditions(data);
-
-	data->if_bluetooth->start_discovery();
-}
-
-static void test_discovery_start_done(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-
-	init_test_conditions(data);
-
-	data->if_bluetooth->start_discovery();
-}
-
-static void test_discovery_device_found(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-
-	init_test_conditions(data);
-
-	data->if_bluetooth->start_discovery();
-}
-
 static void test_dev_getprops_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3659,31 +3610,6 @@ int main(int argc, char *argv[])
 
 	tester_init(&argc, &argv);
 
-	test_bredrle("Bluetooth BR/EDR Discovery Start - Success",
-				&bluetooth_discovery_start_success_test,
-				setup_enabled_adapter,
-				test_discovery_start_success, teardown);
-
-	test_bredrle("Bluetooth BR/EDR Discovery Start - Success 2",
-				&bluetooth_discovery_start_success2_test,
-				setup_enabled_adapter,
-				test_discovery_start_done, teardown);
-
-	test_bredrle("Bluetooth BR/EDR Discovery Stop - Success",
-				&bluetooth_discovery_stop_success_test,
-				setup_enabled_adapter,
-				test_discovery_stop_success, teardown);
-
-	test_bredrle("Bluetooth BR/EDR Discovery Stop - Success 2",
-				&bluetooth_discovery_stop_success2_test,
-				setup_enabled_adapter,
-				test_discovery_stop_done, teardown);
-
-	test_bredr("Bluetooth BR/EDR Discovery Device Found",
-				&bluetooth_discovery_device_found_test,
-				setup_enabled_adapter,
-				test_discovery_device_found, teardown);
-
 	test_bredr("Bluetooth Device Get Props - Success",
 					&bt_dev_getprops_success_test,
 					setup_enabled_adapter,
-- 
1.9.1

