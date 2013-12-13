Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] android/tester: Add property check and bdname set success test case
Date: Fri, 13 Dec 2013 13:44:21 +0100
Message-Id: <1386938665-7179-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds handling of property check, bdname set property success.
---
 android/android-tester.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index f34b4ac..0a31b53 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -65,6 +65,7 @@ enum hal_bluetooth_callbacks_id {
 struct generic_data {
 	uint8_t expected_adapter_status;
 	uint32_t expect_settings_set;
+	bt_property_t expected_property;
 	uint8_t expected_hal_callbacks[];
 };
 
@@ -95,7 +96,9 @@ struct test_data {
 	bool mgmt_settings_set;
 	bool hal_cb_called;
 	bool status_checked;
+	bool property_checked;
 
+	bt_property_t test_property;
 	GSList *expected_callbacks;
 };
 
@@ -111,6 +114,8 @@ static void test_update_state(void)
 		return;
 	if (!(data->status_checked))
 		return;
+	if (!(data->property_checked))
+		return;
 	tester_test_passed();
 }
 
@@ -177,11 +182,20 @@ static void expected_status_init(struct test_data *data)
 		data->status_checked = true;
 }
 
+static void test_property_init(struct test_data *data)
+{
+	const struct generic_data *test_data = data->test_data;
+
+	if (!(test_data->expected_property.type))
+		data->property_checked = true;
+}
+
 static void init_test_conditions(struct test_data *data)
 {
 	hal_cb_init(data);
 	mgmt_cb_init(data);
 	expected_status_init(data);
+	test_property_init(data);
 }
 
 static void check_expected_status(uint8_t status)
@@ -197,6 +211,33 @@ static void check_expected_status(uint8_t status)
 	test_update_state();
 }
 
+static void check_test_property(void)
+{
+	struct test_data *data = tester_get_data();
+	bt_property_t expected_prop = data->test_property;
+	const struct generic_data *test_data = data->test_data;
+	bt_property_t test_prop = test_data->expected_property;
+
+	if (test_prop.type && (expected_prop.type != test_prop.type)) {
+		tester_test_failed();
+		return;
+	}
+
+	if (test_prop.len && (expected_prop.len != test_prop.len)) {
+		tester_test_failed();
+		return;
+	}
+
+	if (test_prop.val && memcmp(expected_prop.val, test_prop.val,
+							expected_prop.len)) {
+		tester_test_failed();
+		return;
+	}
+
+	data->property_checked = true;
+	test_update_state();
+}
+
 static int get_expected_hal_cb(void)
 {
 	struct test_data *data = tester_get_data();
@@ -448,6 +489,7 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
 						bt_property_t *properties)
 {
 	enum hal_bluetooth_callbacks_id hal_cb;
+	struct test_data *data = tester_get_data();
 	int i;
 
 	for (i = 0; i < num_properties; i++) {
@@ -456,6 +498,12 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
 		if (hal_cb == adapter_test_setup_mode)
 			break;
 
+		data->test_property = *properties;
+
+		if (g_slist_next(data->expected_callbacks) ==
+							adapter_test_end)
+			check_test_property();
+
 		switch (properties[i].type) {
 		case BT_PROPERTY_BDADDR:
 			if (hal_cb != adapter_prop_bdaddr)
@@ -521,6 +569,14 @@ static const struct generic_data bluetooth_disable_success_test = {
 	.expected_hal_callbacks = {adapter_state_changed_off, adapter_test_end}
 };
 
+static const struct generic_data bluetooth_setprop_bdname_success_test = {
+	.expected_hal_callbacks = {adapter_prop_bdname, adapter_test_end},
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_property.type = BT_PROPERTY_BDNAME,
+	.expected_property.val = "test_bdname",
+	.expected_property.len = 11
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -737,6 +793,20 @@ clean:
 		close(sock_fd);
 }
 
+static void test_setprop_bdname_success(const void *test_data)
+{
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
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -767,6 +837,11 @@ int main(int argc, char *argv[])
 	test_bredrle("Test Disable - Success", &bluetooth_disable_success_test,
 			setup_enabled_adapter, test_disable, teardown);
 
+	test_bredrle("Test Set BDNAME - Success",
+					&bluetooth_setprop_bdname_success_test,
+					setup_enabled_adapter,
+					test_setprop_bdname_success, teardown);
+
 	test_bredrle("Test Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.4.2

