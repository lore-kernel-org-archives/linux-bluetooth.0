Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 1/7] android/tester: Add PAN init test case
Date: Thu, 27 Mar 2014 12:00:20 +0200
Message-Id: <1395914426-24249-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395914426-24249-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395914426-24249-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 358 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 358 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 6d2edc7..f4f5b28 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -42,6 +42,7 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
+#include <hardware/bt_pan.h>
 
 #include "utils.h"
 
@@ -81,6 +82,20 @@ struct hidhost_generic_data {
 	int expected_report_size;
 };
 
+struct pan_generic_data {
+	bt_status_t expected_status;
+	int expected_conn_state;
+	int expected_cb_count;
+	int expected_pan_role;
+	btpan_callbacks_t expected_pan_hal_cb;
+	bt_callbacks_t expected_hal_cb;
+	int expected_adapter_status;
+	uint32_t expect_settings_set;
+	bt_property_t set_property;
+	struct priority_property *expected_properties;
+	uint8_t expected_properties_num;
+};
+
 #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
 
@@ -100,6 +115,7 @@ struct test_data {
 	const bt_interface_t *if_bluetooth;
 	const btsock_interface_t *if_sock;
 	const bthh_interface_t *if_hid;
+	const btpan_interface_t *if_pan;
 
 	int conditions_left;
 
@@ -147,6 +163,16 @@ struct hh_cb_data {
 	int size;
 };
 
+struct pan_cb_data {
+	const bt_bdaddr_t *bdaddr;
+	bt_status_t status;
+	btpan_connection_state_t conn_state;
+	btpan_control_state_t ctrl_state;
+	int local_role;
+	int remote_role;
+	const char *ifname;
+};
+
 static char exec_dir[PATH_MAX + 1];
 
 static gint scheduled_cbacks_num = 0;
@@ -2640,6 +2666,11 @@ static void teardown(const void *test_data)
 		data->if_hid = NULL;
 	}
 
+	if (data->if_pan) {
+		data->if_pan->cleanup();
+		data->if_pan = NULL;
+	}
+
 	if (data->if_bluetooth) {
 		data->if_bluetooth->cleanup();
 		data->if_bluetooth = NULL;
@@ -4418,6 +4449,330 @@ static void test_hidhost_get_report(const void *test_data)
 		tester_test_failed();
 }
 
+static gboolean pan_connection_state(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+	struct pan_cb_data *cb_data = user_data;
+
+	if (test && test->expected_pan_hal_cb.connection_state_cb)
+		test->expected_pan_hal_cb.connection_state_cb(
+					cb_data->conn_state, cb_data->status,
+					cb_data->bdaddr, cb_data->local_role,
+					cb_data->remote_role);
+
+	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
+	return FALSE;
+}
+
+static void pan_connection_state_cb(btpan_connection_state_t state,
+					bt_status_t error,
+					const bt_bdaddr_t *bd_addr,
+					int local_role, int remote_role)
+{
+	struct pan_cb_data *cb_data = g_new0(struct pan_cb_data, 1);
+
+	cb_data->conn_state = state;
+	cb_data->status = error;
+	cb_data->local_role = local_role;
+	cb_data->remote_role = remote_role;
+	cb_data->bdaddr = bd_addr;
+
+	g_atomic_int_inc(&scheduled_cbacks_num);
+	g_idle_add(pan_connection_state, cb_data);
+}
+
+static gboolean pan_control_state(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+	struct pan_cb_data *cb_data = user_data;
+
+	if (test && test->expected_pan_hal_cb.control_state_cb)
+		test->expected_pan_hal_cb.control_state_cb(cb_data->ctrl_state,
+			cb_data->status, cb_data->local_role, cb_data->ifname);
+
+	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
+	return FALSE;
+}
+
+static void pan_control_state_cb(btpan_control_state_t state,
+					bt_status_t error,
+					int local_role, const char *ifname)
+{
+	struct pan_cb_data *cb_data = g_new0(struct pan_cb_data, 1);
+
+	cb_data->ctrl_state = error;
+	cb_data->status = local_role;
+	cb_data->local_role = state;
+	cb_data->ifname = ifname;
+
+	g_atomic_int_inc(&scheduled_cbacks_num);
+	g_idle_add(pan_control_state, cb_data);
+}
+
+static btpan_callbacks_t btpan_callbacks = {
+	.size = sizeof(btpan_callbacks),
+	.control_state_cb = pan_control_state_cb,
+	.connection_state_cb = pan_connection_state_cb,
+};
+
+static gboolean pan_adapter_state_changed(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
+
+	if (data->test_checks_valid &&
+				test->expected_hal_cb.adapter_state_changed_cb)
+		test->expected_hal_cb.adapter_state_changed_cb(cb_data->state);
+
+	if (!data->test_checks_valid && cb_data->state == BT_STATE_ON)
+		setup_powered_emulated_remote();
+
+	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
+	return FALSE;
+}
+
+static void pan_adapter_state_changed_cb(bt_state_t state)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->state = state;
+
+	g_atomic_int_inc(&scheduled_cbacks_num);
+	g_idle_add(pan_adapter_state_changed, cb_data);
+}
+
+static gboolean pan_discovery_state_changed(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
+
+	if (test && test->expected_hal_cb.discovery_state_changed_cb)
+		test->expected_hal_cb.discovery_state_changed_cb(
+								cb_data->state);
+
+	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
+	return FALSE;
+}
+
+static void pan_discovery_state_changed_cb(bt_discovery_state_t state)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->state = state;
+	g_atomic_int_inc(&scheduled_cbacks_num);
+	g_idle_add(pan_discovery_state_changed, cb_data);
+}
+
+static gboolean pan_device_found(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
+
+	if (data->test_checks_valid && test->expected_hal_cb.device_found_cb)
+		test->expected_hal_cb.device_found_cb(cb_data->num,
+								cb_data->props);
+
+	free_properties(cb_data->num, cb_data->props);
+	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
+	return FALSE;
+}
+
+static void pan_device_found_cb(int num_properties, bt_property_t *properties)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->num = num_properties;
+	cb_data->props = copy_properties(num_properties, properties);
+
+	g_atomic_int_inc(&scheduled_cbacks_num);
+	g_idle_add(pan_device_found, cb_data);
+}
+
+static gboolean pan_adapter_properties(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
+
+	if (data->test_checks_valid &&
+			test->expected_hal_cb.adapter_properties_cb)
+		test->expected_hal_cb.adapter_properties_cb(cb_data->status,
+						cb_data->num, cb_data->props);
+
+	free_properties(cb_data->num, cb_data->props);
+	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
+	return FALSE;
+}
+
+static void pan_adapter_properties_cb(bt_status_t status, int num_properties,
+						bt_property_t *properties)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->status = status;
+	cb_data->num = num_properties;
+	cb_data->props = copy_properties(num_properties, properties);
+
+	g_atomic_int_inc(&scheduled_cbacks_num);
+	g_idle_add(pan_adapter_properties, cb_data);
+}
+
+static gboolean pan_remote_device_properties(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
+
+	if (data->test_checks_valid &&
+			test->expected_hal_cb.remote_device_properties_cb)
+		test->expected_hal_cb.remote_device_properties_cb(
+					cb_data->status, &cb_data->bdaddr,
+					cb_data->num, cb_data->props);
+
+	free_properties(cb_data->num, cb_data->props);
+	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
+	return FALSE;
+}
+
+static void pan_remote_device_properties_cb(bt_status_t status,
+				bt_bdaddr_t *bd_addr, int num_properties,
+				bt_property_t *properties)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->status = status;
+	cb_data->bdaddr = *bd_addr;
+	cb_data->num = num_properties;
+	cb_data->props = copy_properties(num_properties, properties);
+
+	g_atomic_int_inc(&scheduled_cbacks_num);
+	g_idle_add(pan_remote_device_properties, cb_data);
+}
+
+static gboolean pan_pin_request(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
+
+	if (data->test_checks_valid && test->expected_hal_cb.pin_request_cb) {
+		test->expected_hal_cb.pin_request_cb(&cb_data->bdaddr,
+						&cb_data->bdname, cb_data->cod);
+	}
+
+	g_free(cb_data);
+	return FALSE;
+}
+
+static void pan_pin_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->bdaddr = *remote_bd_addr;
+	cb_data->bdname = *bd_name;
+	cb_data->cod = cod;
+
+	g_idle_add(pan_pin_request, cb_data);
+}
+
+static gboolean pan_bond_state_changed(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
+
+	if (data->test_checks_valid &&
+			test->expected_hal_cb.bond_state_changed_cb)
+		test->expected_hal_cb.bond_state_changed_cb(cb_data->status,
+					&cb_data->bdaddr, cb_data->state);
+
+	g_free(cb_data);
+	return FALSE;
+}
+
+static void pan_bond_state_changed_cb(bt_status_t status,
+			bt_bdaddr_t *remote_bd_addr, bt_bond_state_t state)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->status = status;
+	cb_data->bdaddr = *remote_bd_addr;
+	cb_data->state = state;
+
+	g_idle_add(pan_bond_state_changed, cb_data);
+}
+
+static bt_callbacks_t bt_pan_cbs = {
+	.size = sizeof(bt_pan_cbs),
+	.adapter_state_changed_cb = pan_adapter_state_changed_cb,
+	.adapter_properties_cb = pan_adapter_properties_cb,
+	.remote_device_properties_cb = pan_remote_device_properties_cb,
+	.device_found_cb = pan_device_found_cb,
+	.discovery_state_changed_cb = pan_discovery_state_changed_cb,
+	.pin_request_cb = pan_pin_request_cb,
+	.ssp_request_cb = NULL,
+	.bond_state_changed_cb = pan_bond_state_changed_cb,
+	.acl_state_changed_cb = NULL,
+	.thread_evt_cb = NULL,
+	.dut_mode_recv_cb = NULL,
+	.le_test_mode_cb = NULL
+};
+
+static void setup_pan(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+	const void *pan;
+
+	setup(data);
+
+	status = data->if_bluetooth->init(&bt_pan_cbs);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_bluetooth = NULL;
+		tester_setup_failed();
+		return;
+	}
+
+	pan = data->if_bluetooth->get_profile_interface(BT_PROFILE_PAN_ID);
+	if (!pan) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->if_pan = pan;
+
+	status = data->if_pan->init(&btpan_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_pan = NULL;
+		tester_setup_failed();
+		return;
+	}
+
+	status = data->if_bluetooth->enable();
+	if (status != BT_STATUS_SUCCESS)
+		tester_setup_failed();
+}
+
 #define test_bredr(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -4852,5 +5207,8 @@ int main(int argc, char *argv[])
 	test_bredrle("HIDHost SendData Success",
 				NULL, setup_hidhost_connect,
 				test_hidhost_send_data, teardown);
+
+	test_bredr("PAN Init", NULL, setup_pan,
+						test_dummy, teardown);
 	return tester_run();
 }
-- 
1.8.3.2

