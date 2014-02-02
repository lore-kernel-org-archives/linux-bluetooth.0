Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 11/11] android/tester: Make bt_callbacks thread-safe
Date: Sun, 2 Feb 2014 12:16:41 +0100
Message-ID: <1391339801-587-12-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds wrappers for BT HAL callback which execute them in main
thread instead of notification_handler() thread. Otherwise test
execution is prone to race conditions since we do not provide any
locking mechanism for tester.
---
 android/android-tester.c | 298 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 259 insertions(+), 39 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 417fd22..e4b5531 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -117,6 +117,52 @@ struct test_data {
 	uint16_t intr_cid;
 };
 
+struct adapter_state_changed_cb_param {
+	bt_state_t state;
+};
+
+struct discovery_state_changed_cb_param {
+	bt_discovery_state_t state;
+};
+
+struct device_found_cb_param {
+	int num_properties;
+	bt_property_t *properties;
+};
+
+struct adapter_properties_cb_param {
+	bt_status_t status;
+	int num_properties;
+	bt_property_t *properties;
+};
+
+struct remote_device_properties_cb_param {
+	bt_status_t status;
+	bt_bdaddr_t *bd_addr;
+	int num_properties;
+	bt_property_t *properties;
+};
+
+struct pin_request_cb_param {
+	bt_bdaddr_t *remote_bd_addr;
+	bt_bdname_t *bd_name;
+	uint32_t cod;
+};
+
+struct ssp_request_cb_param {
+	bt_bdaddr_t *remote_bd_addr;
+	bt_bdname_t *bd_name;
+	uint32_t cod;
+	bt_ssp_variant_t pairing_variant;
+	uint32_t pass_key;
+};
+
+struct bond_state_changed_cb_param {
+	bt_status_t status;
+	bt_bdaddr_t *remote_bd_addr;
+	bt_bond_state_t state;
+};
+
 static char exec_dir[PATH_MAX + 1];
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -249,6 +295,31 @@ static void check_expected_status(uint8_t status)
 		tester_test_failed();
 }
 
+static bt_property_t * copy_properties(int num_properties,
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
+static void free_properties(int num_properties, bt_property_t *properties)
+{
+	int i;
+
+	for (i = 0; i < num_properties; i++)
+		g_free(properties[i].val);
+
+	g_free(properties);
+}
+
 static int locate_property(gconstpointer expected_data,
 						gconstpointer received_prop)
 {
@@ -589,19 +660,26 @@ static void disable_success_cb(bt_state_t state)
 	}
 }
 
-static void adapter_state_changed_cb(bt_state_t state)
+static gboolean adapter_state_changed_cb(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct adapter_state_changed_cb_param *param =
+			(struct adapter_state_changed_cb_param *) user_data;
 
 	if (data->test_init_done &&
 			test->expected_hal_cb.adapter_state_changed_cb) {
-		test->expected_hal_cb.adapter_state_changed_cb(state);
-		return;
+		test->expected_hal_cb.adapter_state_changed_cb(param->state);
+		goto cleanup;
 	}
 
-	if (!data->test_init_done && state == BT_STATE_ON)
+	if (!data->test_init_done && param->state == BT_STATE_ON)
 		setup_powered_emulated_remote();
+
+cleanup:
+	g_free(user_data);
+
+	return FALSE;
 }
 
 static void discovery_start_success_cb(bt_discovery_state_t state)
@@ -685,13 +763,17 @@ static void remote_setprop_disc_state_changed_cb(bt_discovery_state_t state)
 	}
 }
 
-static void discovery_state_changed_cb(bt_discovery_state_t state)
+static gboolean discovery_state_changed_cb(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct discovery_state_changed_cb_param *param = (struct discovery_state_changed_cb_param *) user_data;
 
 	if (test && test->expected_hal_cb.discovery_state_changed_cb)
-		test->expected_hal_cb.discovery_state_changed_cb(state);
+		test->expected_hal_cb.discovery_state_changed_cb(param->state);
+
+	g_free(user_data);
+	return FALSE;
 }
 
 static void discovery_device_found_cb(int num_properties,
@@ -862,14 +944,19 @@ static void bond_nostatus_device_found_cb(int num_properties,
 	}
 }
 
-static void device_found_cb(int num_properties, bt_property_t *properties)
+static gboolean device_found_cb(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct device_found_cb_param *params = (struct device_found_cb_param *) user_data;
 
 	if (data->test_init_done && test->expected_hal_cb.device_found_cb)
-		test->expected_hal_cb.device_found_cb(num_properties,
-								properties);
+		test->expected_hal_cb.device_found_cb(params->num_properties,
+							params->properties);
+
+	free_properties(params->num_properties, params->properties);
+	g_free(params);
+	return FALSE;
 }
 
 static void check_count_properties_cb(bt_status_t status, int num_properties,
@@ -881,16 +968,21 @@ static void check_count_properties_cb(bt_status_t status, int num_properties,
 		check_expected_property(properties[i]);
 }
 
-static void adapter_properties_cb(bt_status_t status, int num_properties,
-						bt_property_t *properties)
+static gboolean adapter_properties_cb(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct adapter_properties_cb_param *params = (struct adapter_properties_cb_param *) user_data;
 
 	if (data->test_init_done &&
 				test->expected_hal_cb.adapter_properties_cb)
-		test->expected_hal_cb.adapter_properties_cb(status,
-						num_properties, properties);
+		test->expected_hal_cb.adapter_properties_cb(params->status,
+				params->num_properties, params->properties);
+
+	free_properties(params->num_properties, params->properties);
+	g_free(user_data);
+
+	return FALSE;
 }
 
 static void remote_test_device_properties_cb(bt_status_t status,
@@ -926,17 +1018,21 @@ static void remote_setprop_device_properties_cb(bt_status_t status,
 	}
 }
 
-static void remote_device_properties_cb(bt_status_t status,
-				bt_bdaddr_t *bd_addr, int num_properties,
-				bt_property_t *properties)
+static gboolean remote_device_properties_cb(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct remote_device_properties_cb_param *params = (struct remote_device_properties_cb_param *) user_data;
 
 	if (data->test_init_done &&
 			test->expected_hal_cb.remote_device_properties_cb)
-		test->expected_hal_cb.remote_device_properties_cb(status,
-					bd_addr, num_properties, properties);
+		test->expected_hal_cb.remote_device_properties_cb(params->status,
+					params->bd_addr, params->num_properties, params->properties);
+
+	g_free(params->bd_addr);
+	free_properties(params->num_properties, params->properties);
+	g_free(params);
+	return FALSE;
 }
 
 static void bond_test_state_changed_cb(bt_status_t status,
@@ -993,15 +1089,22 @@ static void bond_remove_bad_addr_state_changed_cb(bt_status_t status,
 		data->cb_count--;
 }
 
-static void bond_state_changed_cb(bt_status_t status,
-			bt_bdaddr_t *remote_bd_addr, bt_bond_state_t state)
+static gboolean bond_state_changed_cb(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct bond_state_changed_cb_param *param =
+			(struct bond_state_changed_cb_param *) user_data;
 
 	if (data->test_init_done && test->expected_hal_cb.bond_state_changed_cb)
-			test->expected_hal_cb.bond_state_changed_cb(status,
-							remote_bd_addr, state);
+		test->expected_hal_cb.bond_state_changed_cb(param->status,
+							param->remote_bd_addr,
+							param->state);
+
+	g_free(param->remote_bd_addr);
+	g_free(param);
+
+	return FALSE;
 }
 
 static void bond_create_pin_success_request_cb(bt_bdaddr_t *remote_bd_addr,
@@ -1054,15 +1157,23 @@ static void bond_create_pin_fail_request_cb(bt_bdaddr_t *remote_bd_addr,
 					sizeof(rp), &rp, NULL, NULL, NULL);
 }
 
-static void pin_request_cb(bt_bdaddr_t *remote_bd_addr,
-					bt_bdname_t *bd_name, uint32_t cod)
+static gboolean pin_request_cb(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct pin_request_cb_param *param =
+				(struct pin_request_cb_param *) user_data;
 
 	if (data->test_init_done && test->expected_hal_cb.pin_request_cb)
-		test->expected_hal_cb.pin_request_cb(remote_bd_addr, bd_name,
-									cod);
+		test->expected_hal_cb.pin_request_cb(param->remote_bd_addr,
+							param->bd_name,
+							param->cod);
+
+	g_free(param->remote_bd_addr);
+	g_free(param->bd_name);
+	g_free(param);
+
+	return FALSE;
 }
 
 static void bond_create_ssp_request_cb(const bt_bdaddr_t *remote_bd_addr,
@@ -1131,17 +1242,26 @@ static void bond_cancel_success_ssp_request_cb(bt_bdaddr_t *remote_bd_addr,
 	check_expected_status(status);
 }
 
-static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
-				uint32_t cod, bt_ssp_variant_t pairing_variant,
-				uint32_t pass_key)
+static gboolean ssp_request_cb(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct ssp_request_cb_param *param =
+				(struct ssp_request_cb_param *) user_data;
 
 	if (data->test_init_done &&
 				test->expected_hal_cb.ssp_request_cb)
-		test->expected_hal_cb.ssp_request_cb(remote_bd_addr, bd_name,
-					cod, pairing_variant, pass_key);
+		test->expected_hal_cb.ssp_request_cb(param->remote_bd_addr,
+							param->bd_name,
+							param->cod,
+							param->pairing_variant,
+							param->pass_key);
+
+	g_free(param->remote_bd_addr);
+	g_free(param->bd_name);
+	g_free(param);
+
+	return FALSE;
 }
 
 static bt_bdaddr_t enable_done_bdaddr_val = { {0x00} };
@@ -2233,16 +2353,116 @@ static const struct generic_data bt_bond_remove_bad_addr_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
+static void adapter_state_changed_cb_wrap(bt_state_t state)
+{
+	struct adapter_state_changed_cb_param *param =
+						g_malloc(sizeof(*param));
+
+	param->state = state;
+
+	g_idle_add(adapter_state_changed_cb, param);
+}
+
+static void discovery_state_changed_cb_wrap(bt_discovery_state_t state)
+{
+	struct discovery_state_changed_cb_param *param =
+						g_malloc(sizeof(*param));
+
+	param->state = state;
+
+	g_idle_add(discovery_state_changed_cb, param);
+}
+
+static void device_found_cb_wrap(int num_properties, bt_property_t *properties)
+{
+	struct device_found_cb_param *param = g_malloc(sizeof(*param));
+
+	param->num_properties = num_properties;
+	param->properties = copy_properties(num_properties, properties);
+
+	g_idle_add(device_found_cb, param);
+}
+
+static void adapter_properties_cb_wrap(bt_status_t status, int num_properties,
+						bt_property_t *properties)
+{
+	struct adapter_properties_cb_param *param = g_malloc(sizeof(*param));
+
+	param->status = status;
+	param->num_properties = num_properties;
+	param->properties = copy_properties(num_properties, properties);
+
+	g_idle_add(adapter_properties_cb, param);
+}
+
+static void remote_device_properties_cb_wrap(bt_status_t status,
+				bt_bdaddr_t *bd_addr, int num_properties,
+				bt_property_t *properties)
+{
+	struct remote_device_properties_cb_param *param =
+						g_malloc(sizeof(*param));
+
+	param->status = status;
+	param->bd_addr = g_memdup(bd_addr, sizeof(*bd_addr));
+	param->num_properties = num_properties;
+	param->properties = copy_properties(num_properties, properties);
+
+	g_idle_add(remote_device_properties_cb, param);
+}
+
+static void pin_request_cb_wrap(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod)
+{
+	struct pin_request_cb_param *param = g_malloc(sizeof(*param));
+
+	param->remote_bd_addr = g_memdup(remote_bd_addr,
+						sizeof(*remote_bd_addr));
+	param->bd_name = g_memdup(bd_name, sizeof(*bd_name));
+
+	g_idle_add(pin_request_cb, param);
+}
+
+static void ssp_request_cb_wrap(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod,
+					bt_ssp_variant_t pairing_variant,
+					uint32_t pass_key)
+{
+	struct ssp_request_cb_param *param = g_malloc(sizeof(*param));
+
+	param->remote_bd_addr = g_memdup(remote_bd_addr,
+						sizeof(*remote_bd_addr));
+	param->bd_name = g_memdup(bd_name, sizeof(*bd_name));
+	param->cod = cod;
+	param->pairing_variant = pairing_variant;
+	param->pass_key = pass_key;
+
+	g_idle_add(ssp_request_cb, param);
+}
+
+static void bond_state_changed_cb_wrap(bt_status_t status,
+					bt_bdaddr_t *remote_bd_addr,
+					bt_bond_state_t state)
+{
+	struct bond_state_changed_cb_param *param = g_malloc(sizeof(*param));
+
+	param->status = status;
+	param->remote_bd_addr = g_memdup(remote_bd_addr,
+						sizeof(*remote_bd_addr));
+	param->state = state;
+
+	g_idle_add(bond_state_changed_cb, param);
+}
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
-	.adapter_state_changed_cb = adapter_state_changed_cb,
-	.adapter_properties_cb = adapter_properties_cb,
-	.remote_device_properties_cb = remote_device_properties_cb,
-	.device_found_cb = device_found_cb,
-	.discovery_state_changed_cb = discovery_state_changed_cb,
-	.pin_request_cb = pin_request_cb,
-	.ssp_request_cb = ssp_request_cb,
-	.bond_state_changed_cb = bond_state_changed_cb,
+	.adapter_state_changed_cb = adapter_state_changed_cb_wrap,
+	.adapter_properties_cb = adapter_properties_cb_wrap,
+	.remote_device_properties_cb = remote_device_properties_cb_wrap,
+	.device_found_cb = device_found_cb_wrap,
+	.discovery_state_changed_cb = discovery_state_changed_cb_wrap,
+	.pin_request_cb = pin_request_cb_wrap,
+	.ssp_request_cb = ssp_request_cb_wrap,
+	.bond_state_changed_cb = bond_state_changed_cb_wrap,
 	.acl_state_changed_cb = NULL,
 	.thread_evt_cb = NULL,
 	.dut_mode_recv_cb = NULL,
-- 
1.8.5.2

