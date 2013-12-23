Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] android/tester: Refactor HAL callback check
Date: Mon, 23 Dec 2013 12:50:29 +0100
Message-Id: <1387799429-6674-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387799429-6674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387799429-6674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes ID enum in favour of test cases having their own as
implementation of callbacks checking test conditions.
Now each test case uses it own callback function and within it
test conditions are checked, e.g. with property get test case, property
and if it's properly cb is checked.
Count of expected callback is defined as a number and after calling
proper cb, value is decremented.
This also changes to generic - property check used within HAL cb.
---
 android/android-tester.c | 403 ++++++++++++++++++++++-------------------------
 1 file changed, 185 insertions(+), 218 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 77dfa89..8c12b70 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -42,39 +42,13 @@
 
 #include "utils.h"
 
-#define ADAPTER_PROPS ADAPTER_PROP_BDADDR, ADAPTER_PROP_BDNAME, \
-			ADAPTER_PROP_UUIDS, ADAPTER_PROP_COD, \
-			ADAPTER_PROP_TYPE, ADAPTER_PROP_SCAN_MODE, \
-			ADAPTER_PROP_BONDED_DEVICES, ADAPTER_PROP_DISC_TIMEOUT
-
-/*
- * those are assigned to HAL methods and callbacks, we use ID later
- * on mapped in switch-case due to different functions prototypes.
- */
-
-enum hal_bluetooth_callbacks_id {
-	ADAPTER_TEST_END,
-	ADAPTER_STATE_CHANGED_ON,
-	ADAPTER_STATE_CHANGED_OFF,
-	ADAPTER_PROP_BDADDR,
-	ADAPTER_PROP_BDNAME,
-	ADAPTER_PROP_UUIDS,
-	ADAPTER_PROP_COD,
-	ADAPTER_PROP_TYPE,
-	ADAPTER_PROP_SCAN_MODE,
-	ADAPTER_PROP_DISC_TIMEOUT,
-	ADAPTER_PROP_SERVICE_RECORD,
-	ADAPTER_PROP_BONDED_DEVICES,
-	ADAPTER_DISCOVERY_STATE_ON,
-	ADAPTER_DISCOVERY_STATE_OFF,
-	REMOTE_DEVICE_FOUND,
-};
-
 struct generic_data {
 	int expected_adapter_status;
 	uint32_t expect_settings_set;
+	int expected_cb_count;
+	bt_property_t set_property;
 	bt_property_t expected_property;
-	uint8_t expected_hal_callbacks[];
+	bt_callbacks_t expected_hal_cb;
 };
 
 struct socket_data {
@@ -93,10 +67,6 @@ struct socket_data {
 
 #define BT_STATUS_NOT_EXPECTED	-1
 
-/* User flags for Device Discovery */
-#define DEVICE_DISCOVERY_CANCEL_ON_START	0x01
-#define DEVICE_DISCOVERY_START_ON_START		0x02
-
 struct test_data {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
@@ -111,14 +81,14 @@ struct test_data {
 	const btsock_interface_t *if_sock;
 
 	bool mgmt_settings_set;
-	bool hal_cb_called;
+	bool cb_count_checked;
 	bool status_checked;
 	bool property_checked;
 
-	bt_property_t test_property;
-	GSList *expected_callbacks;
+	/* Set to true if test conditions are initialized */
+	bool test_init_done;
 
-	uint32_t userflag;
+	int cb_count;
 };
 
 static char exec_dir[PATH_MAX + 1];
@@ -127,9 +97,9 @@ static void test_update_state(void)
 {
 	struct test_data *data = tester_get_data();
 
-	if (!(data->mgmt_settings_set))
+	if (!(data->cb_count_checked))
 		return;
-	if (!(data->hal_cb_called))
+	if (!(data->mgmt_settings_set))
 		return;
 	if (!(data->status_checked))
 		return;
@@ -194,27 +164,27 @@ static void command_generic_new_settings(uint16_t index, uint16_t length,
 	mgmt_unregister(data->mgmt, data->mgmt_settings_id);
 }
 
-static bool is_empty_halcb_list(void)
+static void check_cb_count(void)
 {
 	struct test_data *data = tester_get_data();
 
-	return !(g_slist_length(data->expected_callbacks));
+	if (!data->test_init_done)
+		return;
+
+	if (data->cb_count == 0)
+		data->cb_count_checked = true;
+
+	test_update_state();
 }
 
-static void hal_cb_init(struct test_data *data)
+static void expected_cb_count_init(struct test_data *data)
 {
 	const struct generic_data *test_data = data->test_data;
-	unsigned int i = 0;
 
-	while (test_data->expected_hal_callbacks[i]) {
-		data->expected_callbacks =
-			g_slist_append(data->expected_callbacks,
-		GINT_TO_POINTER(test_data->expected_hal_callbacks[i]));
-		i++;
-	}
+	data->cb_count = test_data->expected_cb_count;
+
+	check_cb_count();
 
-	if (is_empty_halcb_list())
-		data->hal_cb_called = true;
 }
 
 static void mgmt_cb_init(struct test_data *data)
@@ -241,13 +211,15 @@ static void test_property_init(struct test_data *data)
 {
 	const struct generic_data *test_data = data->test_data;
 
-	if (is_empty_halcb_list() || !(test_data->expected_property.type))
+	if (!test_data->expected_property.type)
 		data->property_checked = true;
 }
 
 static void init_test_conditions(struct test_data *data)
 {
-	hal_cb_init(data);
+	data->test_init_done = true;
+
+	expected_cb_count_init(data);
 	mgmt_cb_init(data);
 	expected_status_init(data);
 	test_property_init(data);
@@ -266,48 +238,20 @@ static void check_expected_status(uint8_t status)
 	test_update_state();
 }
 
-static void check_test_property(void)
-{
-	struct test_data *data = tester_get_data();
-	bt_property_t expected_prop = data->test_property;
-	const struct generic_data *test_data = data->test_data;
-	bt_property_t test_prop = test_data->expected_property;
-
-	if (test_prop.type && (expected_prop.type != test_prop.type)) {
-		tester_test_failed();
-		return;
-	}
-
-	if (test_prop.len && (expected_prop.len != test_prop.len)) {
-		tester_test_failed();
-		return;
-	}
-
-	if (test_prop.val && memcmp(expected_prop.val, test_prop.val,
-							expected_prop.len)) {
-		tester_test_failed();
-		return;
-	}
-
-	data->property_checked = true;
-	test_update_state();
-}
-
-static void update_hal_cb_list(enum hal_bluetooth_callbacks_id
-							expected_callback)
+static bool check_test_property(bt_property_t received_prop,
+						bt_property_t expected_prop)
 {
 	struct test_data *data = tester_get_data();
 
-	if (is_empty_halcb_list())
-		return;
-
-	data->expected_callbacks = g_slist_remove(data->expected_callbacks,
-					GINT_TO_POINTER(expected_callback));
-
-	if (!data->expected_callbacks)
-		data->hal_cb_called = true;
+	if (expected_prop.type && (expected_prop.type != received_prop.type))
+		return false;
+	if (expected_prop.len && (expected_prop.len != received_prop.len))
+		return false;
+	if (expected_prop.val && memcmp(expected_prop.val, received_prop.val,
+							expected_prop.len))
+		return false;
 
-	test_update_state();
+	return data->property_checked = true;
 }
 
 static void read_info_callback(uint8_t status, uint16_t length,
@@ -541,56 +485,98 @@ static void setup_powered_emulated_remote(void)
 		bthost_write_scan_enable(bthost, 0x03);
 }
 
+static void enable_success_cb(bt_state_t state)
+{
+	struct test_data *data = tester_get_data();
+
+	if (state == BT_STATE_ON) {
+		setup_powered_emulated_remote();
+		data->cb_count--;
+	}
+}
+
+static void disable_success_cb(bt_state_t state)
+{
+	struct test_data *data = tester_get_data();
+
+	if (state == BT_STATE_OFF)
+		data->cb_count--;
+}
+
 static void adapter_state_changed_cb(bt_state_t state)
 {
-	switch (state) {
-	case BT_STATE_ON:
-		if (is_empty_halcb_list())
-			setup_powered_emulated_remote();
-		update_hal_cb_list(ADAPTER_STATE_CHANGED_ON);
-		break;
-	case BT_STATE_OFF:
-		if (is_empty_halcb_list())
-			tester_setup_failed();
-		update_hal_cb_list(ADAPTER_STATE_CHANGED_OFF);
-		break;
-	default:
-		break;
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (data->test_init_done &&
+			test->expected_hal_cb.adapter_state_changed_cb) {
+		test->expected_hal_cb.adapter_state_changed_cb(state);
+		check_cb_count();
+		return;
 	}
+
+	if (!data->test_init_done && state == BT_STATE_ON)
+		setup_powered_emulated_remote();
+}
+
+static void discovery_start_success_cb(bt_discovery_state_t state)
+{
+	struct test_data *data = tester_get_data();
+
+	if (state == BT_DISCOVERY_STARTED)
+		data->cb_count--;
 }
 
-static void post_discovery_started_cb(bt_discovery_state_t state)
+static void discovery_start_done_cb(bt_discovery_state_t state)
 {
 	struct test_data *data = tester_get_data();
 	bt_status_t status;
 
-	if (data->userflag & DEVICE_DISCOVERY_CANCEL_ON_START) {
+	status = data->if_bluetooth->start_discovery();
+	data->cb_count--;
+	check_expected_status(status);
+}
+
+static void discovery_stop_success_cb(bt_discovery_state_t state)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+
+	if (state == BT_DISCOVERY_STARTED && data->cb_count == 2) {
 		status = data->if_bluetooth->cancel_discovery();
 		check_expected_status(status);
+		data->cb_count--;
+		return;
 	}
+	if (state == BT_DISCOVERY_STOPPED && data->cb_count == 1)
+		data->cb_count--;
+}
 
-	if (data->userflag & DEVICE_DISCOVERY_START_ON_START) {
-		status = data->if_bluetooth->start_discovery();
-		check_expected_status(status);
+static void discovery_device_found_state_changed_cb(bt_discovery_state_t state)
+{
+	struct test_data *data = tester_get_data();
+
+	if (state == BT_DISCOVERY_STARTED && data->cb_count == 3) {
+		data->cb_count--;
+		return;
 	}
+	if (state == BT_DISCOVERY_STOPPED && data->cb_count == 1)
+		data->cb_count--;
 }
 
 static void discovery_state_changed_cb(bt_discovery_state_t state)
 {
-	switch (state) {
-	case BT_DISCOVERY_STARTED:
-		update_hal_cb_list(ADAPTER_DISCOVERY_STATE_ON);
-		post_discovery_started_cb(state);
-		break;
-	case BT_DISCOVERY_STOPPED:
-		update_hal_cb_list(ADAPTER_DISCOVERY_STATE_OFF);
-		break;
-	default:
-		break;
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (test && test->expected_hal_cb.discovery_state_changed_cb) {
+		test->expected_hal_cb.discovery_state_changed_cb(state);
+		check_cb_count();
 	}
 }
 
-static void device_found_cb(int num_properties, bt_property_t *properties)
+static void discovery_device_found_cb(int num_properties,
+						bt_property_t *properties)
 {
 	struct test_data *data = tester_get_data();
 	const uint8_t *remote_bdaddr =
@@ -600,7 +586,7 @@ static void device_found_cb(int num_properties, bt_property_t *properties)
 	bt_bdaddr_t emu_remote_bdaddr;
 	int i;
 
-	update_hal_cb_list(REMOTE_DEVICE_FOUND);
+	data->cb_count--;
 
 	if (num_properties < 1)
 		tester_test_failed();
@@ -639,83 +625,75 @@ static void device_found_cb(int num_properties, bt_property_t *properties)
 	}
 }
 
-static void adapter_properties_cb(bt_status_t status, int num_properties,
+static void device_found_cb(int num_properties, bt_property_t *properties)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (data->test_init_done && test->expected_hal_cb.device_found_cb) {
+		test->expected_hal_cb.device_found_cb(num_properties,
+								properties);
+		check_cb_count();
+	}
+}
+
+static void check_count_properties_cb(bt_status_t status, int num_properties,
 						bt_property_t *properties)
 {
 	struct test_data *data = tester_get_data();
-	int i;
 
-	if (is_empty_halcb_list())
-		return;
+	data->cb_count--;
+}
 
-	for (i = 0; i < num_properties; i++) {
+static void getprop_success_cb(bt_status_t status, int num_properties,
+						bt_property_t *properties)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
 
-		data->test_property = properties[i];
+	if (check_test_property(properties[0], test->expected_property))
+		data->cb_count--;
+}
 
-		if (g_slist_length(data->expected_callbacks) == 1)
-			check_test_property();
+static void adapter_properties_cb(bt_status_t status, int num_properties,
+						bt_property_t *properties)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
 
-		switch (properties[i].type) {
-		case BT_PROPERTY_BDADDR:
-			update_hal_cb_list(ADAPTER_PROP_BDADDR);
-			break;
-		case BT_PROPERTY_BDNAME:
-			update_hal_cb_list(ADAPTER_PROP_BDNAME);
-			break;
-		case BT_PROPERTY_UUIDS:
-			update_hal_cb_list(ADAPTER_PROP_UUIDS);
-			break;
-		case BT_PROPERTY_CLASS_OF_DEVICE:
-			update_hal_cb_list(ADAPTER_PROP_COD);
-			break;
-		case BT_PROPERTY_TYPE_OF_DEVICE:
-			update_hal_cb_list(ADAPTER_PROP_TYPE);
-			break;
-		case BT_PROPERTY_SERVICE_RECORD:
-			update_hal_cb_list(ADAPTER_PROP_SERVICE_RECORD);
-			break;
-		case BT_PROPERTY_ADAPTER_SCAN_MODE:
-			update_hal_cb_list(ADAPTER_PROP_SCAN_MODE);
-			break;
-		case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
-			update_hal_cb_list(ADAPTER_PROP_BONDED_DEVICES);
-			break;
-		case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
-			update_hal_cb_list(ADAPTER_PROP_DISC_TIMEOUT);
-			break;
-		default:
-			goto fail;
-		}
+	if (data->test_init_done &&
+				test->expected_hal_cb.adapter_properties_cb) {
+		test->expected_hal_cb.adapter_properties_cb(
+							status, num_properties,
+							properties);
+		check_cb_count();
 	}
-	return;
-
-fail:
-	tester_print("Unexpected property: %u", properties[i].type);
-	tester_test_failed();
-	return;
 }
 
 static const struct generic_data bluetooth_enable_success_test = {
-	.expected_hal_callbacks = { ADAPTER_PROPS, ADAPTER_STATE_CHANGED_ON,
-							ADAPTER_TEST_END },
+	.expected_hal_cb.adapter_state_changed_cb = enable_success_cb,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_cb_count = 9,
 	.expected_adapter_status = BT_STATUS_SUCCESS
 };
 
 static const struct generic_data bluetooth_enable_done_test = {
-	.expected_hal_callbacks = { ADAPTER_PROPS, ADAPTER_TEST_END },
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_cb_count = 8,
 	.expected_adapter_status = BT_STATUS_DONE
 };
 
 static const struct generic_data bluetooth_disable_success_test = {
-	.expected_hal_callbacks = { ADAPTER_STATE_CHANGED_OFF,
-							ADAPTER_TEST_END },
+	.expected_hal_cb.adapter_state_changed_cb = disable_success_cb,
+	.expected_cb_count = 1,
 	.expected_adapter_status = BT_STATUS_SUCCESS
 };
 
 static char test_set_bdname[] = "test_bdname_set";
 
 static const struct generic_data bluetooth_setprop_bdname_success_test = {
-	.expected_hal_callbacks = { ADAPTER_PROP_BDNAME, ADAPTER_TEST_END },
+	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
+	.expected_cb_count = 1,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_BDNAME,
 	.expected_property.val = test_set_bdname,
@@ -726,9 +704,8 @@ static bt_scan_mode_t test_setprop_scanmode_val =
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
 
 static const struct generic_data bluetooth_setprop_scanmode_success_test = {
-	.expected_hal_callbacks = { ADAPTER_PROP_SCAN_MODE,
-						ADAPTER_PROP_SCAN_MODE,
-						ADAPTER_TEST_END },
+	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
+	.expected_cb_count = 1,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
 	.expected_property.val = &test_setprop_scanmode_val,
@@ -738,7 +715,8 @@ static const struct generic_data bluetooth_setprop_scanmode_success_test = {
 static uint32_t test_setprop_disctimeout_val = 120;
 
 static const struct generic_data bluetooth_setprop_disctimeout_success_test = {
-	.expected_hal_callbacks = { ADAPTER_PROP_DISC_TIMEOUT, ADAPTER_TEST_END },
+	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
+	.expected_cb_count = 1,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
 	.expected_property.val = &test_setprop_disctimeout_val,
@@ -746,7 +724,8 @@ static const struct generic_data bluetooth_setprop_disctimeout_success_test = {
 };
 
 static const struct generic_data bluetooth_getprop_bdaddr_success_test = {
-	.expected_hal_callbacks = { ADAPTER_PROP_BDADDR, ADAPTER_TEST_END },
+	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
+	.expected_cb_count = 1,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_BDADDR,
 	.expected_property.val = NULL,
@@ -756,8 +735,8 @@ static const struct generic_data bluetooth_getprop_bdaddr_success_test = {
 static char test_bdname[] = "test_bdname_setget";
 
 static const struct generic_data bluetooth_getprop_bdname_success_test = {
-	.expected_hal_callbacks = { ADAPTER_PROP_BDNAME, ADAPTER_PROP_BDNAME,
-							ADAPTER_TEST_END },
+	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
+	.expected_cb_count = 1,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_BDNAME,
 	.expected_property.val = test_bdname,
@@ -769,41 +748,37 @@ static unsigned char setprop_uuids[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
 			0x00, 0x00 };
 
 static const struct generic_data bluetooth_setprop_uuid_invalid_test = {
-	.expected_hal_callbacks = { ADAPTER_TEST_END },
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.expected_property.type = BT_PROPERTY_UUIDS,
-	.expected_property.val = &setprop_uuids,
-	.expected_property.len = sizeof(setprop_uuids)
+	.set_property.type = BT_PROPERTY_UUIDS,
+	.set_property.val = &setprop_uuids,
+	.set_property.len = sizeof(setprop_uuids)
 };
 
 static uint32_t setprop_class_of_device = 0;
 
 static const struct generic_data bluetooth_setprop_cod_invalid_test = {
-	.expected_hal_callbacks = { ADAPTER_TEST_END },
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.expected_property.type = BT_PROPERTY_CLASS_OF_DEVICE,
-	.expected_property.val = &setprop_class_of_device,
-	.expected_property.len = sizeof(setprop_class_of_device)
+	.set_property.type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.set_property.val = &setprop_class_of_device,
+	.set_property.len = sizeof(setprop_class_of_device)
 };
 
 static bt_device_type_t setprop_type_of_device = BT_DEVICE_DEVTYPE_BREDR;
 
 static const struct generic_data bluetooth_setprop_tod_invalid_test = {
-	.expected_hal_callbacks = { ADAPTER_TEST_END },
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.expected_property.type = BT_PROPERTY_TYPE_OF_DEVICE,
-	.expected_property.val = &setprop_type_of_device,
-	.expected_property.len = sizeof(setprop_type_of_device)
+	.set_property.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.set_property.val = &setprop_type_of_device,
+	.set_property.len = sizeof(setprop_type_of_device)
 };
 
 static int32_t setprop_remote_rssi = 0;
 
 static const struct generic_data bluetooth_setprop_remote_rssi_invalid_test = {
-	.expected_hal_callbacks = { ADAPTER_TEST_END },
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.expected_property.type = BT_PROPERTY_REMOTE_RSSI,
-	.expected_property.val = &setprop_remote_rssi,
-	.expected_property.len = sizeof(setprop_remote_rssi)
+	.set_property.type = BT_PROPERTY_REMOTE_RSSI,
+	.set_property.val = &setprop_remote_rssi,
+	.set_property.len = sizeof(setprop_remote_rssi)
 };
 
 static bt_service_record_t setprop_remote_service = {
@@ -814,41 +789,40 @@ static bt_service_record_t setprop_remote_service = {
 
 static const struct generic_data
 			bluetooth_setprop_service_record_invalid_test = {
-	.expected_hal_callbacks = { ADAPTER_TEST_END },
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.expected_property.type = BT_PROPERTY_SERVICE_RECORD,
-	.expected_property.val = &setprop_remote_service,
-	.expected_property.len = sizeof(setprop_remote_service)
+	.set_property.type = BT_PROPERTY_SERVICE_RECORD,
+	.set_property.val = &setprop_remote_service,
+	.set_property.len = sizeof(setprop_remote_service)
 };
 
 static const struct generic_data bluetooth_discovery_start_success_test = {
-	.expected_hal_callbacks = { ADAPTER_DISCOVERY_STATE_ON,
-							ADAPTER_TEST_END },
+	.expected_hal_cb.discovery_state_changed_cb =
+						discovery_start_success_cb,
+	.expected_cb_count = 1,
 	.expected_adapter_status = BT_STATUS_SUCCESS
 };
 
 static const struct generic_data bluetooth_discovery_start_done_test = {
-	.expected_hal_callbacks = { ADAPTER_DISCOVERY_STATE_ON,
-							ADAPTER_TEST_END },
+	.expected_hal_cb.discovery_state_changed_cb = discovery_start_done_cb,
+	.expected_cb_count = 1,
 	.expected_adapter_status = BT_STATUS_DONE
 };
 
 static const struct generic_data bluetooth_discovery_stop_done_test = {
-	.expected_hal_callbacks = { ADAPTER_TEST_END },
 	.expected_adapter_status = BT_STATUS_DONE
 };
 
 static const struct generic_data bluetooth_discovery_stop_success_test = {
-	.expected_hal_callbacks = { ADAPTER_DISCOVERY_STATE_ON,
-				ADAPTER_DISCOVERY_STATE_OFF, ADAPTER_TEST_END },
+	.expected_hal_cb.discovery_state_changed_cb = discovery_stop_success_cb,
+	.expected_cb_count = 2,
 	.expected_adapter_status = BT_STATUS_SUCCESS
 };
 
 static const struct generic_data bluetooth_discovery_device_found_test = {
-	.expected_hal_callbacks = { ADAPTER_DISCOVERY_STATE_ON,
-						REMOTE_DEVICE_FOUND,
-						ADAPTER_DISCOVERY_STATE_OFF,
-						ADAPTER_TEST_END },
+	.expected_hal_cb.discovery_state_changed_cb =
+					discovery_device_found_state_changed_cb,
+	.expected_hal_cb.device_found_cb = discovery_device_found_cb,
+	.expected_cb_count = 3,
 	.expected_adapter_status = BT_STATUS_NOT_EXPECTED
 };
 
@@ -982,9 +956,6 @@ static void teardown(const void *test_data)
 	if (data->bluetoothd_pid)
 		waitpid(data->bluetoothd_pid, NULL, 0);
 
-	if (data->expected_callbacks)
-		g_slist_free(data->expected_callbacks);
-
 	tester_teardown_complete();
 }
 
@@ -1125,7 +1096,7 @@ static void test_setprop_tod_invalid(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &test->set_property;
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1198,8 +1169,6 @@ static void test_discovery_stop_success(const void *test_data)
 	struct test_data *data = tester_get_data();
 	bt_status_t status;
 
-	data->userflag = DEVICE_DISCOVERY_CANCEL_ON_START;
-
 	init_test_conditions(data);
 
 	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY,
@@ -1213,8 +1182,6 @@ static void test_discovery_start_done(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	data->userflag = DEVICE_DISCOVERY_START_ON_START;
-
 	init_test_conditions(data);
 
 	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY,
-- 
1.8.4.2

