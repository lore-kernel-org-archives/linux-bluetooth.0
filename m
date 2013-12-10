Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [PATCH v3 6/7] android/tester: Add basic enable test
Date: Tue, 10 Dec 2013 15:00:50 +0100
Message-Id: <1386684051-31748-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1386684051-31748-1-git-send-email-marcin.kraglak@tieto.com>
References: <1386684051-31748-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

---
 android/android-tester.c | 227 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 225 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index ace7427..1cba50a 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -37,7 +37,32 @@
 #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
 
+#define adapter_props adapter_prop_bdaddr, adapter_prop_bdname, \
+			adapter_prop_uuids, adapter_prop_cod, \
+			adapter_prop_scan_mode, adapter_prop_disc_timeout
+
+/*
+ * those are assigned to HAL methods and callbacks, we use ID later
+ * on mapped in switch-case due to different functions prototypes.
+ */
+
+enum hal_bluetooth_callbacks_id {
+	adapter_test_end,
+	adapter_state_changed_on,
+	adapter_state_changed_off,
+	adapter_prop_bdaddr,
+	adapter_prop_bdname,
+	adapter_prop_uuids,
+	adapter_prop_cod,
+	adapter_prop_scan_mode,
+	adapter_prop_disc_timeout,
+	adapter_prop_service_record,
+	adapter_prop_bonded_devices
+};
+
 struct generic_data {
+	uint32_t expect_settings_set;
+	uint8_t expected_hal_callbacks[];
 };
 
 #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
@@ -46,13 +71,98 @@ struct generic_data {
 struct test_data {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
+	unsigned int mgmt_settings_id;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	const struct generic_data *test_data;
 	pid_t bluetoothd_pid;
 	const bt_interface_t *if_bluetooth;
+
+	bool mgmt_settings_set;
+	bool hal_cb_called;
+
+	GSList *expected_callbacks;
 };
 
+static void test_update_state(void)
+{
+	struct test_data *data = tester_get_data();
+
+	if (data->mgmt_settings_set && data->hal_cb_called)
+		tester_test_passed();
+}
+
+static void test_mgmt_settings_set(struct test_data *data)
+{
+	data->mgmt_settings_set = true;
+
+	test_update_state();
+}
+
+static void command_generic_new_settings(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	uint32_t settings;
+
+	if (length != 4) {
+		tester_warn("Invalid parameter size for new settings event");
+		tester_test_failed();
+		return;
+	}
+
+	settings = bt_get_le32(param);
+
+	if ((settings & data->test_data->expect_settings_set) !=
+					data->test_data->expect_settings_set)
+		return;
+
+	test_mgmt_settings_set(data);
+	mgmt_unregister(data->mgmt, data->mgmt_settings_id);
+}
+
+static void hal_cb_init(struct test_data *data)
+{
+	unsigned int i = 0;
+
+	while (data->test_data->expected_hal_callbacks[i]) {
+						data->expected_callbacks =
+				g_slist_append(data->expected_callbacks,
+		GINT_TO_POINTER(data->test_data->expected_hal_callbacks[i]));
+		i++;
+	}
+}
+
+static void mgmt_cb_init(struct test_data *data)
+{
+	if (!data->test_data->expect_settings_set)
+		test_mgmt_settings_set(data);
+	else
+		data->mgmt_settings_id = mgmt_register(data->mgmt,
+					MGMT_EV_NEW_SETTINGS, data->mgmt_index,
+				command_generic_new_settings, NULL, NULL);
+}
+
+static int get_expected_hal_cb(void)
+{
+	struct test_data *data = tester_get_data();
+
+	return GPOINTER_TO_INT(data->expected_callbacks->data);
+}
+
+static void remove_expected_hal_cb(void)
+{
+	struct test_data *data = tester_get_data();
+
+	data->expected_callbacks = g_slist_remove(data->expected_callbacks,
+						data->expected_callbacks->data);
+
+	if (!data->expected_callbacks)
+		data->hal_cb_called = true;
+
+	test_update_state();
+}
+
 static void read_info_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -247,10 +357,107 @@ failed:
 	close(fd);
 }
 
+static void adapter_state_changed_cb(bt_state_t state)
+{
+	switch (get_expected_hal_cb()) {
+	case adapter_state_changed_on:
+		if (state == BT_STATE_ON)
+			remove_expected_hal_cb();
+		else
+			tester_test_failed();
+		break;
+	default:
+		break;
+	}
+}
+
+static void adapter_properties_cb(bt_status_t status, int num_properties,
+						bt_property_t *properties)
+{
+	enum hal_bluetooth_callbacks_id hal_cb;
+	int i;
+
+	for (i = 0; i < num_properties; i++) {
+		hal_cb = get_expected_hal_cb();
+		switch (properties[i].type) {
+		case BT_PROPERTY_BDADDR:
+			if (hal_cb != adapter_prop_bdaddr) {
+				tester_test_failed();
+				return;
+			}
+			remove_expected_hal_cb();
+			break;
+		case BT_PROPERTY_BDNAME:
+			if (hal_cb != adapter_prop_bdname) {
+				tester_test_failed();
+				return;
+			}
+			remove_expected_hal_cb();
+			break;
+		case BT_PROPERTY_UUIDS:
+			if (hal_cb != adapter_prop_uuids) {
+				tester_test_failed();
+				return;
+			}
+			remove_expected_hal_cb();
+			break;
+		case BT_PROPERTY_CLASS_OF_DEVICE:
+			if (hal_cb != adapter_prop_cod) {
+				tester_test_failed();
+				return;
+			}
+			remove_expected_hal_cb();
+			break;
+		case BT_PROPERTY_TYPE_OF_DEVICE:
+			if (hal_cb != adapter_prop_bdaddr) {
+				tester_test_failed();
+				return;
+			}
+			remove_expected_hal_cb();
+			break;
+		case BT_PROPERTY_SERVICE_RECORD:
+			if (hal_cb != adapter_prop_service_record) {
+				tester_test_failed();
+				return;
+			}
+			remove_expected_hal_cb();
+			break;
+		case BT_PROPERTY_ADAPTER_SCAN_MODE:
+			if (hal_cb != adapter_prop_scan_mode) {
+				tester_test_failed();
+				return;
+			}
+			remove_expected_hal_cb();
+			break;
+		case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
+			if (hal_cb != adapter_prop_bonded_devices) {
+				tester_test_failed();
+				return;
+			}
+			remove_expected_hal_cb();
+			break;
+		case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
+			if (hal_cb != adapter_prop_disc_timeout) {
+				tester_test_failed();
+				return;
+			}
+			remove_expected_hal_cb();
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static const struct generic_data bluetooth_enable_success_test = {
+	.expected_hal_callbacks = {adapter_props, adapter_state_changed_on,
+							adapter_test_end}
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
-	.adapter_state_changed_cb = NULL,
-	.adapter_properties_cb = NULL,
+	.adapter_state_changed_cb = adapter_state_changed_cb,
+	.adapter_properties_cb = adapter_properties_cb,
 	.remote_device_properties_cb = NULL,
 	.device_found_cb = NULL,
 	.discovery_state_changed_cb = NULL,
@@ -356,9 +563,22 @@ static void teardown(const void *test_data)
 	if (data->bluetoothd_pid)
 		waitpid(data->bluetoothd_pid, NULL, 0);
 
+	if (data->expected_callbacks)
+		g_slist_free(data->expected_callbacks);
+
 	tester_teardown_complete();
 }
 
+static void test_enable(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	hal_cb_init(data);
+	mgmt_cb_init(data);
+
+	data->if_bluetooth->enable();
+}
+
 static void controller_setup(const void *test_data)
 {
 	tester_test_passed();
@@ -383,5 +603,8 @@ int main(int argc, char *argv[])
 
 	test_bredrle("Test Init", NULL, setup_base, controller_setup, teardown);
 
+	test_bredrle("Test Enable - Success", &bluetooth_enable_success_test,
+					setup_base, test_enable, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.1

