Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] android/tester: Multi property check for test case
Date: Fri, 10 Jan 2014 10:22:54 +0100
Message-Id: <1389345774-3824-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows to check multiple properties for test case. Properties
can be prioritized to allow check if they'll come in right order. Now
properties aren't treated as a "single" callback. In future in one
callback multiple properties can come.
---
 android/android-tester.c | 530 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 386 insertions(+), 144 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index a29c982..a3c5f58 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -43,13 +43,19 @@
 
 #include "utils.h"
 
+struct priority_property {
+	bt_property_t prop;
+	int prio;
+};
+
 struct generic_data {
 	int expected_adapter_status;
 	uint32_t expect_settings_set;
 	int expected_cb_count;
 	bt_property_t set_property;
-	bt_property_t expected_property;
 	bt_callbacks_t expected_hal_cb;
+	struct priority_property *expected_properties;
+	uint8_t expected_properties_num;
 };
 
 struct socket_data {
@@ -91,6 +97,7 @@ struct test_data {
 	bool test_init_done;
 
 	int cb_count;
+	GSList *expected_properties_list;
 };
 
 static char exec_dir[PATH_MAX + 1];
@@ -185,9 +192,18 @@ static void expected_status_init(struct test_data *data)
 static void test_property_init(struct test_data *data)
 {
 	const struct generic_data *test_data = data->test_data;
+	GSList *l = data->expected_properties_list;
+	int i;
 
-	if (!test_data->expected_property.type)
+	if (!test_data->expected_hal_cb.adapter_properties_cb) {
 		data->property_checked = true;
+		return;
+	}
+
+	for (i = 0; i < test_data->expected_properties_num; i++)
+		l = g_slist_prepend(l, &(test_data->expected_properties[i]));
+
+	data->expected_properties_list = l;
 }
 
 static void init_test_conditions(struct test_data *data)
@@ -212,6 +228,75 @@ static void check_expected_status(uint8_t status)
 		tester_test_failed();
 }
 
+static int locate_property(gconstpointer expected_data,
+						gconstpointer received_prop)
+{
+	bt_property_t rec_prop = *((bt_property_t *)received_prop);
+	bt_property_t exp_prop =
+			((struct priority_property *)expected_data)->prop;
+
+	if (exp_prop.type && (exp_prop.type != rec_prop.type))
+		return 1;
+	if (exp_prop.len && (exp_prop.len != rec_prop.len))
+		return 1;
+	if (exp_prop.val && memcmp(exp_prop.val, rec_prop.val, exp_prop.len))
+		return 1;
+
+	return 0;
+}
+
+static int compare_priorities(gconstpointer prop_list, gconstpointer priority)
+{
+	int prio = GPOINTER_TO_INT(priority);
+	int comp_prio = ((struct priority_property *)prop_list)->prio;
+
+	if (prio > comp_prio)
+		return 0;
+
+	return 1;
+}
+
+static bool check_prop_priority(int rec_prop_prio)
+{
+	struct test_data *data = tester_get_data();
+	GSList *l = data->expected_properties_list;
+
+	if (!rec_prop_prio || !g_slist_length(l))
+		return true;
+
+	if (g_slist_find_custom(l, GINT_TO_POINTER(rec_prop_prio),
+							&compare_priorities))
+		return false;
+
+	return true;
+}
+
+static void check_expected_property(bt_property_t received_prop)
+{
+	struct test_data *data = tester_get_data();
+	int rec_prio;
+	GSList *l = data->expected_properties_list;
+	GSList *found_exp_prop;
+
+	found_exp_prop = g_slist_find_custom(l, &received_prop,
+							&locate_property);
+
+	if (found_exp_prop) {
+		rec_prio = ((struct priority_property *)
+						(found_exp_prop->data))->prio;
+		if (check_prop_priority(rec_prio))
+			l = g_slist_remove(l, found_exp_prop->data);
+	}
+
+	data->expected_properties_list = l;
+
+	if (g_slist_length(l))
+		return;
+
+	data->property_checked = true;
+	test_update_state();
+}
+
 static bool check_test_property(bt_property_t received_prop,
 						bt_property_t expected_prop)
 {
@@ -625,27 +710,18 @@ static void device_found_cb(int num_properties, bt_property_t *properties)
 	if (data->test_init_done && test->expected_hal_cb.device_found_cb) {
 		test->expected_hal_cb.device_found_cb(num_properties,
 								properties);
-		check_cb_count();
 	}
 }
 
 static void check_count_properties_cb(bt_status_t status, int num_properties,
 						bt_property_t *properties)
 {
-	struct test_data *data = tester_get_data();
+	int i;
 
-	data->cb_count--;
+	for (i = 0; i < num_properties; i++)
+		check_expected_property(properties[i]);
 }
 
-static void getprop_success_cb(bt_status_t status, int num_properties,
-						bt_property_t *properties)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-
-	if (check_test_property(properties[0], test->expected_property))
-		data->cb_count--;
-}
 
 static void adapter_properties_cb(bt_status_t status, int num_properties,
 						bt_property_t *properties)
@@ -658,21 +734,87 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
 		test->expected_hal_cb.adapter_properties_cb(
 							status, num_properties,
 							properties);
-		check_cb_count();
 	}
 }
 
+static bt_bdaddr_t enable_done_bdaddr_val = {
+	.address = { 0x00, 0xaa, 0x01, 0x00, 0x00, 0x00 },
+};
+static const char enable_done_bdname_val[] = "";
+static bt_uuid_t enable_done_uuids_val = {
+	.uu = { 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
+					0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
+};
+static uint32_t enable_done_cod_val = 0;
+static bt_device_type_t enable_done_tod_val = BT_DEVICE_DEVTYPE_BREDR;
+static bt_scan_mode_t enable_done_scanmode_val = BT_SCAN_MODE_NONE;
+static uint32_t enable_done_disctimeout_val = 120;
+
+static struct priority_property enable_done_props[] = {
+	{
+	.prop.type = BT_PROPERTY_BDADDR,
+	.prop.len = sizeof(enable_done_bdaddr_val),
+	.prop.val = &enable_done_bdaddr_val,
+	.prio = 1,
+	},
+	{
+	.prop.type = BT_PROPERTY_BDNAME,
+	.prop.len = sizeof(enable_done_bdname_val) - 1,
+	.prop.val = &enable_done_bdname_val,
+	.prio = 2,
+	},
+	{
+	.prop.type = BT_PROPERTY_UUIDS,
+	.prop.len = sizeof(enable_done_uuids_val),
+	.prop.val = &enable_done_uuids_val,
+	.prio = 3,
+	},
+	{
+	.prop.type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.prop.len = sizeof(enable_done_cod_val),
+	.prop.val = &enable_done_cod_val,
+	.prio = 4,
+	},
+	{
+	.prop.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.prop.len = sizeof(enable_done_tod_val),
+	.prop.val = &enable_done_tod_val,
+	.prio = 5,
+	},
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.prop.len = sizeof(enable_done_scanmode_val),
+	.prop.val = &enable_done_scanmode_val,
+	.prio = 6,
+	},
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+	.prop.len = 0,
+	.prop.val = NULL,
+	.prio = 7,
+	},
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+	.prop.len = sizeof(enable_done_disctimeout_val),
+	.prop.val = &enable_done_disctimeout_val,
+	.prio = 8,
+	},
+};
+
 static const struct generic_data bluetooth_enable_success_test = {
 	.expected_hal_cb.adapter_state_changed_cb = enable_success_cb,
 	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
-	.expected_cb_count = 9,
+	.expected_cb_count = 1,
+	.expected_properties_num = 8,
+	.expected_properties = enable_done_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
 static const struct generic_data bluetooth_enable_done_test = {
 	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
-	.expected_cb_count = 8,
 	.expected_adapter_status = BT_STATUS_DONE,
+	.expected_properties_num = 8,
+	.expected_properties = enable_done_props,
 };
 
 static const struct generic_data bluetooth_disable_success_test = {
@@ -683,94 +825,148 @@ static const struct generic_data bluetooth_disable_success_test = {
 
 static char test_set_bdname[] = "test_bdname_set";
 
+static struct priority_property setprop_bdname_props[] = {
+	{
+	.prop.type = BT_PROPERTY_BDNAME,
+	.prop.val = test_set_bdname,
+	.prop.len = sizeof(test_set_bdname) - 1,
+	.prio = 0,
+	},
+};
+
 static const struct generic_data bluetooth_setprop_bdname_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
-	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_BDNAME,
-	.expected_property.val = test_set_bdname,
-	.expected_property.len = sizeof(test_set_bdname) - 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = setprop_bdname_props,
 };
 
 static bt_scan_mode_t test_setprop_scanmode_val =
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
 
+static struct priority_property setprop_scanmode_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.prop.val = &test_setprop_scanmode_val,
+	.prop.len = sizeof(bt_scan_mode_t),
+	},
+};
+
 static const struct generic_data bluetooth_setprop_scanmode_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = setprop_scanmode_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
-	.expected_property.val = &test_setprop_scanmode_val,
-	.expected_property.len = sizeof(bt_scan_mode_t),
 };
 
 static uint32_t test_setprop_disctimeout_val = 120;
 
+static struct priority_property setprop_disctimeout_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+	.prop.val = &test_setprop_disctimeout_val,
+	.prop.len = sizeof(test_setprop_disctimeout_val),
+	},
+};
+
 static const struct generic_data bluetooth_setprop_disctimeout_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = setprop_disctimeout_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
-	.expected_property.val = &test_setprop_disctimeout_val,
-	.expected_property.len = sizeof(test_setprop_disctimeout_val),
+};
+
+static bt_bdaddr_t test_getprop_bdaddr_val = {
+	.address = { 0x00, 0xaa, 0x01, 0x00, 0x00, 0x00 }
+};
+
+static struct priority_property getprop_bdaddr_props[] = {
+	{
+	.prop.type = BT_PROPERTY_BDADDR,
+	.prop.val = &test_getprop_bdaddr_val,
+	.prop.len = sizeof(test_getprop_bdaddr_val),
+	},
 };
 
 static const struct generic_data bluetooth_getprop_bdaddr_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = getprop_bdaddr_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_BDADDR,
-	.expected_property.val = NULL,
-	.expected_property.len = sizeof(bt_bdaddr_t),
 };
 
 static char test_bdname[] = "test_bdname_setget";
 
+static struct priority_property getprop_bdname_props[] = {
+	{
+	.prop.type = BT_PROPERTY_BDNAME,
+	.prop.val = &test_bdname,
+	.prop.len = sizeof(test_bdname) - 1,
+	},
+};
+
 static const struct generic_data bluetooth_getprop_bdname_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = getprop_bdname_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_BDNAME,
-	.expected_property.val = test_bdname,
-	.expected_property.len = sizeof(test_bdname) - 1,
 };
 
 static unsigned char setprop_uuids[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
 			0x00, 0x80, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00 };
 
+static struct priority_property setprop_uuid_prop[] = {
+	{
+	.prop.type = BT_PROPERTY_UUIDS,
+	.prop.val = &setprop_uuids,
+	.prop.len = sizeof(setprop_uuids),
+	},
+};
+
 static const struct generic_data bluetooth_setprop_uuid_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.set_property.type = BT_PROPERTY_UUIDS,
-	.set_property.val = &setprop_uuids,
-	.set_property.len = sizeof(setprop_uuids),
 };
 
 static uint32_t setprop_class_of_device = 0;
 
+static struct priority_property setprop_cod_props[] = {
+	{
+	.prop.type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.prop.val = &setprop_class_of_device,
+	.prop.len = sizeof(setprop_class_of_device),
+	},
+};
+
 static const struct generic_data bluetooth_setprop_cod_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.set_property.type = BT_PROPERTY_CLASS_OF_DEVICE,
-	.set_property.val = &setprop_class_of_device,
-	.set_property.len = sizeof(setprop_class_of_device),
 };
 
 static bt_device_type_t setprop_type_of_device = BT_DEVICE_DEVTYPE_BREDR;
 
+static struct priority_property setprop_tod_props[] = {
+	{
+	.prop.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.prop.val = &setprop_type_of_device,
+	.prop.len = sizeof(setprop_type_of_device),
+	},
+};
+
 static const struct generic_data bluetooth_setprop_tod_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.set_property.type = BT_PROPERTY_TYPE_OF_DEVICE,
-	.set_property.val = &setprop_type_of_device,
-	.set_property.len = sizeof(setprop_type_of_device),
 };
 
 static int32_t setprop_remote_rssi = 0;
 
+static struct priority_property setprop_remote_rssi_props[] = {
+	{
+	.prop.type = BT_PROPERTY_REMOTE_RSSI,
+	.prop.val = &setprop_remote_rssi,
+	.prop.len = sizeof(setprop_remote_rssi),
+	},
+};
+
 static const struct generic_data bluetooth_setprop_remote_rssi_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.set_property.type = BT_PROPERTY_REMOTE_RSSI,
-	.set_property.val = &setprop_remote_rssi,
-	.set_property.len = sizeof(setprop_remote_rssi),
 };
 
 static bt_service_record_t setprop_remote_service = {
@@ -779,91 +975,136 @@ static bt_service_record_t setprop_remote_service = {
 	.name = "bt_name",
 };
 
+static struct priority_property setprop_service_record_props[] = {
+	{
+	.prop.type = BT_PROPERTY_SERVICE_RECORD,
+	.prop.val = &setprop_remote_service,
+	.prop.len = sizeof(setprop_remote_service),
+	},
+};
+
 static const struct generic_data
 			bluetooth_setprop_service_record_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.set_property.type = BT_PROPERTY_SERVICE_RECORD,
-	.set_property.val = &setprop_remote_service,
-	.set_property.len = sizeof(setprop_remote_service),
 };
 
 static bt_bdaddr_t setprop_bdaddr = {
 	.address = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
 };
 
+static struct priority_property setprop_bdaddr_props[] = {
+	{
+	.prop.type = BT_PROPERTY_BDADDR,
+	.prop.val = &setprop_bdaddr,
+	.prop.len = sizeof(setprop_bdaddr),
+	},
+};
+
 static const struct generic_data bluetooth_setprop_bdaddr_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.set_property.type = BT_PROPERTY_BDADDR,
-	.set_property.val = &setprop_bdaddr,
-	.set_property.len = sizeof(setprop_bdaddr),
 };
 
 static bt_scan_mode_t setprop_scanmode_connectable = BT_SCAN_MODE_CONNECTABLE;
 
+static struct priority_property setprop_scanmode_connectable_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.prop.val = &setprop_scanmode_connectable,
+	.prop.len = sizeof(setprop_scanmode_connectable),
+	},
+};
+
 static const struct generic_data
 			bluetooth_setprop_scanmode_connectable_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = setprop_scanmode_connectable_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
-	.expected_property.val = &setprop_scanmode_connectable,
-	.expected_property.len = sizeof(setprop_scanmode_connectable),
 };
 
 static bt_bdaddr_t setprop_bonded_devices = {
 	.address = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 },
 };
 
+static struct priority_property setprop_bonded_devices_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+	.prop.val = &setprop_bonded_devices,
+	.prop.len = sizeof(setprop_bonded_devices),
+	},
+};
+
 static const struct generic_data
 			bluetooth_setprop_bonded_devices_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
-	.set_property.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
-	.set_property.val = &setprop_bonded_devices,
-	.set_property.len = sizeof(setprop_bonded_devices),
 };
 
 static uint32_t getprop_cod = 0;
 
+static struct priority_property getprop_cod_props[] = {
+	{
+	.prop.type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.prop.val = &getprop_cod,
+	.prop.len = sizeof(getprop_cod),
+	},
+};
+
 static const struct generic_data bluetooth_getprop_cod_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = getprop_cod_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_CLASS_OF_DEVICE,
-	.expected_property.val = &getprop_cod,
-	.expected_property.len = sizeof(getprop_cod),
 };
 
 static bt_device_type_t getprop_tod = BT_DEVICE_DEVTYPE_BREDR;
 
+static struct priority_property getprop_tod_props[] = {
+	{
+	.prop.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.prop.val = &getprop_tod,
+	.prop.len = sizeof(getprop_tod),
+	},
+};
+
 static const struct generic_data bluetooth_getprop_tod_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = getprop_tod_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_TYPE_OF_DEVICE,
-	.expected_property.val = &getprop_tod,
-	.expected_property.len = sizeof(getprop_tod),
 };
 
 static bt_scan_mode_t getprop_scanmode = BT_SCAN_MODE_NONE;
 
+static struct priority_property getprop_scanmode_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.prop.val = &getprop_scanmode,
+	.prop.len = sizeof(getprop_scanmode),
+	},
+};
+
 static const struct generic_data bluetooth_getprop_scanmode_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = getprop_scanmode_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
-	.expected_property.val = &getprop_scanmode,
-	.expected_property.len = sizeof(getprop_scanmode),
 };
 
 static uint32_t getprop_disctimeout_val = 120;
 
+static struct priority_property getprop_disctimeout_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+	.prop.val = &getprop_disctimeout_val,
+	.prop.len = sizeof(getprop_disctimeout_val),
+	},
+};
+
 static const struct generic_data bluetooth_getprop_disctimeout_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = getprop_disctimeout_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
-	.expected_property.val = &getprop_disctimeout_val,
-	.expected_property.len = sizeof(getprop_disctimeout_val),
 };
 
 static bt_uuid_t getprop_uuids = {
@@ -871,33 +1112,51 @@ static bt_uuid_t getprop_uuids = {
 					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB },
 };
 
+static struct priority_property getprop_uuids_props[] = {
+	{
+	.prop.type = BT_PROPERTY_UUIDS,
+	.prop.val = &getprop_uuids,
+	.prop.len = sizeof(getprop_uuids),
+	},
+};
+
 static const struct generic_data bluetooth_getprop_uuids_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = getprop_uuids_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_UUIDS,
-	.expected_property.val = &getprop_uuids,
-	.expected_property.len = sizeof(getprop_uuids),
+};
+
+static struct priority_property getprop_bondeddev_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+	.prop.val = NULL,
+	.prop.len = 0,
+	},
 };
 
 static const struct generic_data bluetooth_getprop_bondeddev_success_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = getprop_bondeddev_props,
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_property.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
-	.expected_property.val = NULL,
-	.expected_property.len = 0,
 };
 
 static bt_scan_mode_t setprop_scanmode_none = BT_SCAN_MODE_NONE;
 
+static struct priority_property setprop_scanmode_none_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.prop.val = &setprop_scanmode_none,
+	.prop.len = sizeof(setprop_scanmode_none),
+	},
+};
+
 static const struct generic_data bluetooth_setprop_scanmode_none_done_test = {
-	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
-	.expected_cb_count = 1,
+	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
+	.expected_properties_num = 1,
+	.expected_properties = setprop_scanmode_none_props,
 	.expected_adapter_status = BT_STATUS_DONE,
-	.expected_property.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
-	.expected_property.val = &setprop_scanmode_none,
-	.expected_property.len = sizeof(setprop_scanmode_none),
 };
 
 static const struct generic_data bluetooth_discovery_start_success_test = {
@@ -1073,6 +1332,9 @@ static void teardown(const void *test_data)
 		data->if_bluetooth = NULL;
 	}
 
+	if (data->expected_properties_list)
+		g_slist_free(data->expected_properties_list);
+
 	data->device->close(data->device);
 
 	if (data->bluetoothd_pid)
@@ -1122,22 +1384,19 @@ static void test_disable(const void *test_data)
 static void test_setprop_bdname_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &(setprop_bdname_props[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
 
 	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-
 	check_expected_status(adapter_status);
 }
 
 static void test_setprop_scanmode_succes(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &(setprop_scanmode_props[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1149,8 +1408,7 @@ static void test_setprop_scanmode_succes(const void *test_data)
 static void test_setprop_disctimeout_succes(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &(setprop_disctimeout_props[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1162,8 +1420,7 @@ static void test_setprop_disctimeout_succes(const void *test_data)
 static void test_getprop_bdaddr_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t prop = test->expected_property;
+	const bt_property_t prop = setprop_bdaddr_props[0].prop;
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1175,8 +1432,7 @@ static void test_getprop_bdaddr_success(const void *test_data)
 static void test_getprop_bdname_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &(getprop_bdname_props[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1187,12 +1443,10 @@ static void test_getprop_bdname_success(const void *test_data)
 	adapter_status = data->if_bluetooth->get_adapter_property((*prop).type);
 	check_expected_status(adapter_status);
 }
-
 static void test_setprop_uuid_invalid(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &(setprop_uuid_prop[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1204,8 +1458,7 @@ static void test_setprop_uuid_invalid(const void *test_data)
 static void test_setprop_cod_invalid(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &(setprop_cod_props[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1230,8 +1483,7 @@ static void test_setprop_tod_invalid(const void *test_data)
 static void test_setprop_rssi_invalid(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &(setprop_remote_rssi_props[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1243,8 +1495,7 @@ static void test_setprop_rssi_invalid(const void *test_data)
 static void test_setprop_service_record_invalid(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &(setprop_service_record_props[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1256,8 +1507,7 @@ static void test_setprop_service_record_invalid(const void *test_data)
 static void test_setprop_bdaddr_invalid(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &(setprop_bdaddr_props[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1269,8 +1519,8 @@ static void test_setprop_bdaddr_invalid(const void *test_data)
 static void test_setprop_scanmode_connectable_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop =
+				&(setprop_scanmode_connectable_props[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1282,8 +1532,7 @@ static void test_setprop_scanmode_connectable_success(const void *test_data)
 static void test_setprop_bonded_devices_invalid(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &(setprop_bonded_devices_props[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1295,8 +1544,7 @@ static void test_setprop_bonded_devices_invalid(const void *test_data)
 static void test_getprop_cod_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t prop = test->expected_property;
+	const bt_property_t prop = setprop_cod_props[0].prop;
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1308,8 +1556,7 @@ static void test_getprop_cod_success(const void *test_data)
 static void test_getprop_tod_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t prop = test->expected_property;
+	const bt_property_t prop = setprop_tod_props[0].prop;
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1321,8 +1568,7 @@ static void test_getprop_tod_success(const void *test_data)
 static void test_getprop_scanmode_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t prop = test->expected_property;
+	const bt_property_t prop = setprop_scanmode_props[0].prop;
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1334,8 +1580,7 @@ static void test_getprop_scanmode_success(const void *test_data)
 static void test_getprop_disctimeout_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t prop = test->expected_property;
+	const bt_property_t prop = setprop_disctimeout_props[0].prop;
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1347,8 +1592,7 @@ static void test_getprop_disctimeout_success(const void *test_data)
 static void test_getprop_uuids_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t prop = test->expected_property;
+	const bt_property_t prop = getprop_uuids_props[0].prop;
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1360,8 +1604,7 @@ static void test_getprop_uuids_success(const void *test_data)
 static void test_getprop_bondeddev_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t prop = test->expected_property;
+	const bt_property_t prop = getprop_bondeddev_props[0].prop;
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
@@ -1373,8 +1616,7 @@ static void test_getprop_bondeddev_success(const void *test_data)
 static void test_setprop_scanmode_none_done(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const bt_property_t *prop = &test->expected_property;
+	const bt_property_t *prop = &(setprop_scanmode_none_props[0].prop);
 	bt_status_t adapter_status;
 
 	init_test_conditions(data);
-- 
1.8.5.2

