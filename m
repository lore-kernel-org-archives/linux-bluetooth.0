Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/tester: Move Bluetooth HAL functions before socket HAL
Date: Wed, 18 Dec 2013 12:54:36 +0100
Message-Id: <1387367677-8099-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch move bluetooth HAL test functions before socket
HAL functions. This make it more readable for future test cases growth.
---
 android/android-tester.c | 272 +++++++++++++++++++++++------------------------
 1 file changed, 136 insertions(+), 136 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 0f0432d..e013e02 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -826,6 +826,11 @@ static void teardown(const void *test_data)
 	tester_teardown_complete();
 }
 
+static void test_dummy(const void *test_data)
+{
+	tester_test_passed();
+}
+
 static void test_enable(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -857,9 +862,138 @@ static void test_disable(const void *test_data)
 	data->if_bluetooth->disable();
 }
 
-static void test_dummy(const void *test_data)
+static void test_setprop_bdname_success(const void *test_data)
 {
-	tester_test_passed();
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+
+	check_expected_status(adapter_status);
+}
+
+static void test_setprop_scanmode_succes(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	check_expected_status(adapter_status);
+}
+
+static void test_setprop_disctimeout_succes(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	check_expected_status(adapter_status);
+}
+
+static void test_getprop_bdaddr_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t prop = test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->get_adapter_property(prop.type);
+	check_expected_status(adapter_status);
+}
+
+static void test_getprop_bdname_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	check_expected_status(adapter_status);
+
+	adapter_status = data->if_bluetooth->get_adapter_property((*prop).type);
+	check_expected_status(adapter_status);
+}
+
+static void test_setprop_uuid_invalid(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	check_expected_status(adapter_status);
+}
+
+static void test_setprop_cod_invalid(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	check_expected_status(adapter_status);
+}
+
+static void test_setprop_tod_invalid(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	check_expected_status(adapter_status);
+}
+
+static void test_setprop_rssi_invalid(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	check_expected_status(adapter_status);
+}
+
+static void test_setprop_service_record_invalid(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	check_expected_status(adapter_status);
 }
 
 /* Test Socket HAL */
@@ -1014,140 +1148,6 @@ clean:
 		close(sock_fd);
 }
 
-static void test_setprop_bdname_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-
-	check_expected_status(adapter_status);
-}
-
-static void test_setprop_scanmode_succes(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
-}
-
-static void test_setprop_disctimeout_succes(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
-}
-
-static void test_getprop_bdaddr_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t prop = test->expected_property;
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->get_adapter_property(prop.type);
-	check_expected_status(adapter_status);
-}
-
-static void test_getprop_bdname_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
-
-	adapter_status = data->if_bluetooth->get_adapter_property((*prop).type);
-	check_expected_status(adapter_status);
-}
-
-static void test_setprop_uuid_invalid(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
-}
-
-static void test_setprop_cod_invalid(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
-}
-
-static void test_setprop_tod_invalid(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
-}
-
-static void test_setprop_rssi_invalid(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
-}
-
-static void test_setprop_service_record_invalid(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
-}
-
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
-- 
1.8.4.2

