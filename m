Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/15] android/tester-ng: Add property check handling
Date: Fri,  9 May 2014 16:42:44 +0200
Message-Id: <1399646568-20742-11-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds property check handling. Existing test cases (enable, enable
done) are updated with property check.
---
 android/android-tester-ng.c | 161 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 1 deletion(-)

diff --git a/android/android-tester-ng.c b/android/android-tester-ng.c
index b76a43c..7c59ee1 100644
--- a/android/android-tester-ng.c
+++ b/android/android-tester-ng.c
@@ -107,6 +107,8 @@ typedef enum {
 struct bt_callback_data {
 	bt_state_t state;
 	bt_status_t status;
+	int num_properties;
+	bt_property_t *properties;
 
 	bt_uuid_t gatt_app_uuid;
 	int32_t gatt_client_id;
@@ -476,6 +478,45 @@ static void test_pre_setup(const void *test_data)
 				NULL, read_index_list_callback, NULL, NULL);
 }
 
+static bool match_property(bt_property_t *exp_prop, bt_property_t *rec_prop,
+								int prop_num)
+{
+	if (exp_prop->type && (exp_prop->type != rec_prop->type))
+		return 0;
+
+	if (exp_prop->len && (exp_prop->len != rec_prop->len)) {
+		tester_debug("Property [%d] len don't match!", prop_num + 1);
+		return 0;
+	}
+
+	if (exp_prop->val && memcmp(exp_prop->val, rec_prop->val,
+							exp_prop->len)) {
+		tester_debug("Property [%d] value don't match!", prop_num + 1);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int verify_property(bt_property_t *exp_props, int exp_num_props,
+				bt_property_t *rec_props, int rec_num_props)
+{
+	int i, j;
+	int exp_prop_to_find = exp_num_props;
+
+	/* Get first exp prop to match and search for it */
+	for (i = 0; i < exp_num_props; i++) {
+		for (j = 0; j < rec_num_props; j++) {
+			if (match_property(&exp_props[i], &rec_props[j], i)) {
+				exp_prop_to_find--;
+				break;
+			}
+		}
+	}
+
+	return exp_prop_to_find;
+}
+
 /*
  * Check each test case step if test case expected
  * data is set and match it with expected result.
@@ -530,6 +571,15 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
+	if (exp->callback_result.properties &&
+				verify_property(exp->callback_result.properties,
+				exp->callback_result.num_properties,
+				step->callback_result.properties,
+				step->callback_result.num_properties)) {
+		tester_debug("Gatt properties don't match");
+		return false;
+	}
+
 	return true;
 }
 
@@ -593,10 +643,25 @@ static void verify_step(struct step *step, queue_destroy_func_t cleanup_cb)
  * step verification could pass and move to next test step
  */
 
+static void free_properties(struct step *step)
+{
+	bt_property_t *properties = step->callback_result.properties;
+	int num_properties = step->callback_result.num_properties;
+	int i;
+
+	for (i = 0; i < num_properties; i++)
+		g_free(properties[i].val);
+
+	g_free(properties);
+}
+
 static void destroy_callback_step(void *data)
 {
 	struct step *step = data;
 
+	if (step->callback_result.properties)
+		free_properties(step);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -630,10 +695,39 @@ static void adapter_state_changed_cb(bt_state_t state)
 	schedule_callback_call(step);
 }
 
+static bt_property_t *copy_properties(int num_properties,
+						bt_property_t *properties)
+{
+	int i;
+	bt_property_t *props = g_new0(bt_property_t, num_properties);
+
+	for (i = 0; i < num_properties; i++) {
+		props[i].type = properties[i].type;
+		props[i].len = properties[i].len;
+		props[i].val = g_memdup(properties[i].val, properties[i].len);
+	}
+
+	return props;
+}
+
+static void adapter_properties_cb(bt_status_t status, int num_properties,
+						bt_property_t *properties)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback_result.status = status;
+	step->callback_result.num_properties = num_properties;
+	step->callback_result.properties = copy_properties(num_properties,
+								properties);
+	step->callback = CB_BT_ADAPTER_PROPERTIES;
+
+	schedule_callback_call(step);
+}
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
-	.adapter_properties_cb = NULL,
+	.adapter_properties_cb = adapter_properties_cb,
 	.remote_device_properties_cb = NULL,
 	.device_found_cb = NULL,
 	.discovery_state_changed_cb = NULL,
@@ -1000,12 +1094,72 @@ static struct step dummy_steps[] = {
 	},
 };
 
+static bt_bdaddr_t enable_bdaddr_val = {
+	.address = { 0x00, 0xaa, 0x01, 0x00, 0x00, 0x00 },
+};
+static const char enable_bdname_val[] = "BlueZ for Android";
+static bt_uuid_t enable_uuids_val = {
+	.uu = { 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
+					0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
+};
+static bt_device_type_t enable_tod_val = BT_DEVICE_DEVTYPE_DUAL;
+static bt_scan_mode_t enable_scanmode_val = BT_SCAN_MODE_NONE;
+static uint32_t enable_disctimeout_val = 120;
+
+static bt_property_t enable_props[] = {
+	{
+	.type = BT_PROPERTY_BDADDR,
+	.len = sizeof(enable_bdaddr_val),
+	.val = NULL,
+	},
+	{
+	.type = BT_PROPERTY_BDNAME,
+	.len = sizeof(enable_bdname_val) - 1,
+	.val = &enable_bdname_val,
+	},
+	{
+	.type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.len = sizeof(uint32_t),
+	.val = NULL,
+	},
+	{
+	.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.len = sizeof(enable_tod_val),
+	.val = &enable_tod_val,
+	},
+	{
+	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.len = sizeof(enable_scanmode_val),
+	.val = &enable_scanmode_val,
+	},
+	{
+	.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+	.len = sizeof(enable_disctimeout_val),
+	.val = &enable_disctimeout_val,
+	},
+	{
+	.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+	.len = 0,
+	.val = NULL,
+	},
+	{
+	.type = BT_PROPERTY_UUIDS,
+	.len = sizeof(enable_uuids_val),
+	.val = &enable_uuids_val,
+	},
+};
+
 static struct step bluetooth_enable_steps[] = {
 	{
 	.action_result.status = BT_STATUS_SUCCESS,
 	.action = bluetooth_enable_action,
 	},
 	{
+	.callback = CB_BT_ADAPTER_PROPERTIES,
+	.callback_result.properties = enable_props,
+	.callback_result.num_properties = 8,
+	},
+	{
 	.callback = CB_BT_ADAPTER_STATE_CHANGED,
 	.callback_result.state = BT_STATE_ON,
 	},
@@ -1017,6 +1171,11 @@ static struct step bluetooth_enable_success2_steps[] = {
 	.action = bluetooth_enable_action,
 	},
 	{
+	.callback = CB_BT_ADAPTER_PROPERTIES,
+	.callback_result.properties = enable_props,
+	.callback_result.num_properties = 8,
+	},
+	{
 	.callback = CB_BT_ADAPTER_STATE_CHANGED,
 	.callback_result.state = BT_STATE_ON,
 	},
-- 
1.9.2

