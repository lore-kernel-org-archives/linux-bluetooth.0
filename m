Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/tester: Don't verify test conditions if test is done
Date: Fri, 14 Mar 2014 13:54:44 +0100
Message-Id: <1394801684-12735-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This avoids callbacks still being called when test result is already
decided and teardown procedure has already been triggered.
---
 android/android-tester.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index f552584..bab92a1 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -102,8 +102,8 @@ struct test_data {
 
 	int conditions_left;
 
-	/* Set to true if test conditions are initialized */
-	bool test_init_done;
+	/* Set to true if test conditions should be verified */
+	bool test_checks_valid;
 
 	bool test_result_set;
 
@@ -295,7 +295,7 @@ static void check_cb_count(void)
 {
 	struct test_data *data = tester_get_data();
 
-	if (!data->test_init_done)
+	if (!data->test_checks_valid)
 		return;
 
 	if (data->cb_count == 0) {
@@ -352,7 +352,7 @@ static void test_property_init(struct test_data *data)
 
 static void init_test_conditions(struct test_data *data)
 {
-	data->test_init_done = true;
+	data->test_checks_valid = true;
 
 	data->conditions_left = 4;
 
@@ -731,13 +731,13 @@ static gboolean adapter_state_changed(gpointer user_data)
 	const struct generic_data *test = data->test_data;
 	struct bt_cb_data *cb_data = user_data;
 
-	if (data->test_init_done &&
+	if (data->test_checks_valid &&
 			test->expected_hal_cb.adapter_state_changed_cb) {
 		test->expected_hal_cb.adapter_state_changed_cb(cb_data->state);
 		goto cleanup;
 	}
 
-	if (!data->test_init_done && cb_data->state == BT_STATE_ON)
+	if (!data->test_checks_valid && cb_data->state == BT_STATE_ON)
 		setup_powered_emulated_remote();
 
 cleanup:
@@ -1062,7 +1062,7 @@ static gboolean device_found(gpointer user_data)
 	const struct generic_data *test = data->test_data;
 	struct bt_cb_data *cb_data = user_data;
 
-	if (data->test_init_done && test->expected_hal_cb.device_found_cb)
+	if (data->test_checks_valid && test->expected_hal_cb.device_found_cb)
 		test->expected_hal_cb.device_found_cb(cb_data->num,
 								cb_data->props);
 
@@ -1099,7 +1099,8 @@ static gboolean adapter_properties(gpointer user_data)
 	const struct generic_data *test = data->test_data;
 	struct bt_cb_data *cb_data = user_data;
 
-	if (data->test_init_done && test->expected_hal_cb.adapter_properties_cb)
+	if (data->test_checks_valid &&
+				test->expected_hal_cb.adapter_properties_cb)
 		test->expected_hal_cb.adapter_properties_cb(cb_data->status,
 						cb_data->num, cb_data->props);
 
@@ -1162,7 +1163,7 @@ static gboolean remote_device_properties(gpointer user_data)
 	const struct generic_data *test = data->test_data;
 	struct bt_cb_data *cb_data = user_data;
 
-	if (data->test_init_done &&
+	if (data->test_checks_valid &&
 			test->expected_hal_cb.remote_device_properties_cb)
 		test->expected_hal_cb.remote_device_properties_cb(
 					cb_data->status, &cb_data->bdaddr,
@@ -1257,7 +1258,8 @@ static gboolean bond_state_changed(gpointer user_data)
 	const struct generic_data *test = data->test_data;
 	struct bt_cb_data *cb_data = user_data;
 
-	if (data->test_init_done && test->expected_hal_cb.bond_state_changed_cb)
+	if (data->test_checks_valid &&
+				test->expected_hal_cb.bond_state_changed_cb)
 		test->expected_hal_cb.bond_state_changed_cb(cb_data->status,
 					&cb_data->bdaddr, cb_data->state);
 
@@ -1313,7 +1315,7 @@ static gboolean pin_request(gpointer user_data)
 	const struct generic_data *test = data->test_data;
 	struct bt_cb_data *cb_data = user_data;
 
-	if (data->test_init_done && test->expected_hal_cb.pin_request_cb)
+	if (data->test_checks_valid && test->expected_hal_cb.pin_request_cb)
 		test->expected_hal_cb.pin_request_cb(&cb_data->bdaddr,
 						&cb_data->bdname, cb_data->cod);
 
@@ -1392,8 +1394,7 @@ static gboolean ssp_request(gpointer user_data)
 	const struct generic_data *test = data->test_data;
 	struct bt_cb_data *cb_data = user_data;
 
-	if (data->test_init_done &&
-				test->expected_hal_cb.ssp_request_cb)
+	if (data->test_checks_valid && test->expected_hal_cb.ssp_request_cb)
 		test->expected_hal_cb.ssp_request_cb(&cb_data->bdaddr,
 					&cb_data->bdname, cb_data->cod,
 					cb_data->ssp_variant, cb_data->passkey);
@@ -2636,6 +2637,9 @@ static void teardown(const void *test_data)
 		data->if_bluetooth = NULL;
 	}
 
+	/* Test result already known, no need to check further */
+	data->test_checks_valid = false;
+
 	if (data->expected_properties_list)
 		g_slist_free(data->expected_properties_list);
 
-- 
1.9.0

