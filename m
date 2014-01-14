Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/15] android/tester: Fix for asynchronous test case condition check
Date: Tue, 14 Jan 2014 14:54:32 +0100
Message-Id: <1389707686-30766-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes checking the state of test case. Due to asynchronous of
callbacks during state check of every single condition, state can be
checked double time by callback condition check with pass status already
set in meantime. Now state is kept as one decremented int.
To pass it must be equal zero and cannot be checked set again.

Change-Id: I595c9f9606f1da41218a85c62c07881bd7bd8ee8
---
 android/android-tester.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 6f18e5c..a9dab69 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -88,14 +88,13 @@ struct test_data {
 	const btsock_interface_t *if_sock;
 	const bthh_interface_t *if_hid;
 
-	bool mgmt_settings_set;
-	bool cb_count_checked;
-	bool status_checked;
-	bool property_checked;
+	int conditions_left;
 
 	/* Set to true if test conditions are initialized */
 	bool test_init_done;
 
+	bool test_result_set;
+
 	int cb_count;
 	GSList *expected_properties_list;
 };
@@ -106,20 +105,15 @@ static void test_update_state(void)
 {
 	struct test_data *data = tester_get_data();
 
-	if (!(data->cb_count_checked))
-		return;
-	if (!(data->mgmt_settings_set))
-		return;
-	if (!(data->status_checked))
-		return;
-	if (!(data->property_checked))
-		return;
-	tester_test_passed();
+	if (data->conditions_left == 0 && !data->test_result_set) {
+		data->test_result_set = true;
+		tester_test_passed();
+	}
 }
 
 static void test_mgmt_settings_set(struct test_data *data)
 {
-	data->mgmt_settings_set = true;
+	data->conditions_left--;
 
 	test_update_state();
 }
@@ -155,7 +149,7 @@ static void check_cb_count(void)
 		return;
 
 	if (data->cb_count == 0) {
-		data->cb_count_checked = true;
+		data->conditions_left--;
 		test_update_state();
 	}
 }
@@ -186,7 +180,7 @@ static void expected_status_init(struct test_data *data)
 	const struct generic_data *test_data = data->test_data;
 
 	if (test_data->expected_adapter_status == BT_STATUS_NOT_EXPECTED)
-		data->status_checked = true;
+		data->conditions_left--;
 }
 
 static void test_property_init(struct test_data *data)
@@ -195,8 +189,8 @@ static void test_property_init(struct test_data *data)
 	GSList *l = data->expected_properties_list;
 	int i;
 
-	if (!test_data->expected_hal_cb.adapter_properties_cb) {
-		data->property_checked = true;
+	if (!test_data->expected_properties_num) {
+		data->conditions_left--;
 		return;
 	}
 
@@ -210,6 +204,8 @@ static void init_test_conditions(struct test_data *data)
 {
 	data->test_init_done = true;
 
+	data->conditions_left = 4;
+
 	expected_cb_count_init(data);
 	mgmt_cb_init(data);
 	expected_status_init(data);
@@ -222,7 +218,7 @@ static void check_expected_status(uint8_t status)
 	const struct generic_data *test_data = data->test_data;
 
 	if (test_data->expected_adapter_status == status) {
-		data->status_checked = true;
+		data->conditions_left--;
 		test_update_state();
 	} else
 		tester_test_failed();
@@ -278,6 +274,9 @@ static void check_expected_property(bt_property_t received_prop)
 	GSList *l = data->expected_properties_list;
 	GSList *found_exp_prop;
 
+	if (!g_slist_length(l))
+		return;
+
 	found_exp_prop = g_slist_find_custom(l, &received_prop,
 							&locate_property);
 
@@ -293,15 +292,13 @@ static void check_expected_property(bt_property_t received_prop)
 	if (g_slist_length(l))
 		return;
 
-	data->property_checked = true;
+	data->conditions_left--;
 	test_update_state();
 }
 
 static bool check_test_property(bt_property_t received_prop,
 						bt_property_t expected_prop)
 {
-	struct test_data *data = tester_get_data();
-
 	if (expected_prop.type && (expected_prop.type != received_prop.type))
 		return false;
 	if (expected_prop.len && (expected_prop.len != received_prop.len))
@@ -310,7 +307,7 @@ static bool check_test_property(bt_property_t received_prop,
 							expected_prop.len))
 		return false;
 
-	return data->property_checked = true;
+	return true;
 }
 
 static void read_info_callback(uint8_t status, uint16_t length,
@@ -1444,7 +1441,6 @@ static void test_getprop_bdname_success(const void *test_data)
 	init_test_conditions(data);
 
 	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
 
 	adapter_status = data->if_bluetooth->get_adapter_property((*prop).type);
 	check_expected_status(adapter_status);
-- 
1.8.5.2

