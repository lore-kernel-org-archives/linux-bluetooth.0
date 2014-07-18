Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/9] android/tester-ng: Add get remote properties case
Date: Fri, 18 Jul 2014 11:50:15 +0200
Message-Id: <1405677021-18877-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-bluetooth.c | 29 +++++++++++++++++++++++++++++
 android/tester-main.c      | 37 ++++++++++++++++++++++++++++++++++++-
 android/tester-main.h      |  7 +++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 6bc67da..65fd93c 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -88,6 +88,8 @@ static int32_t emu_remote_rssi_val = 127;
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
+static const char emu_remote_bdname_val[] = "00:AA:01:01:00:00";
+static uint32_t emu_remote_cod_val = 0;
 
 static bt_property_t prop_emu_default_set[] = {
 	{ BT_PROPERTY_BDADDR, sizeof(emu_bdaddr_val), NULL },
@@ -111,6 +113,19 @@ static bt_property_t prop_emu_ble_remotes_default_set[] = {
 							&emu_remote_rssi_val },
 };
 
+static bt_property_t prop_emu_ble_remotes_query_set[] = {
+	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_remote_type_val),
+							&emu_remote_type_val },
+	{ BT_PROPERTY_CLASS_OF_DEVICE, sizeof(emu_remote_cod_val),
+							&emu_remote_cod_val },
+	{ BT_PROPERTY_REMOTE_RSSI, sizeof(emu_remote_rssi_val),
+							&emu_remote_rssi_val },
+	{ BT_PROPERTY_BDNAME, sizeof(emu_remote_bdname_val) - 1,
+						&emu_remote_bdname_val },
+	{ BT_PROPERTY_UUIDS, 0, NULL },
+	{ BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP, 4, NULL },
+};
+
 static char test_bdname[] = "test_bdname";
 static bt_property_t prop_test_bdname = {
 	.type = BT_PROPERTY_BDNAME,
@@ -392,6 +407,20 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 	),
+	TEST_CASE("Bluetooth Device Get Props - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_SUCCESS(bt_get_device_props_action,
+							&emu_remote_bdaddr_val),
+		CALLBACK_DEVICE_PROPS(prop_emu_ble_remotes_query_set, 6),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 5849c0c..f5ac281 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -601,11 +601,26 @@ static void device_found_cb(int num_properties, bt_property_t *properties)
 	schedule_callback_call(step);
 }
 
+static void remote_device_properties_cb(bt_status_t status,
+				bt_bdaddr_t *bd_addr, int num_properties,
+				bt_property_t *properties)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback_result.num_properties = num_properties;
+	step->callback_result.properties = copy_properties(num_properties,
+								properties);
+
+	step->callback = CB_BT_REMOTE_DEVICE_PROPERTIES;
+
+	schedule_callback_call(step);
+}
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
 	.adapter_properties_cb = adapter_properties_cb,
-	.remote_device_properties_cb = NULL,
+	.remote_device_properties_cb = remote_device_properties_cb,
 	.device_found_cb = device_found_cb,
 	.discovery_state_changed_cb = discovery_state_changed_cb,
 	.pin_request_cb = NULL,
@@ -1022,6 +1037,26 @@ void bt_cancel_discovery_action(void)
 	verify_step(&step, NULL);
 }
 
+void bt_get_device_props_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct step step;
+
+	if (!current_data_step->set_data) {
+		tester_debug("bdaddr not defined");
+		tester_test_failed();
+		return;
+	}
+
+	memset(&step, 0, sizeof(step));
+	step.action_result.status =
+		data->if_bluetooth->get_remote_device_properties(
+						current_data_step->set_data);
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index 3919713..b81487d 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -79,6 +79,12 @@
 		.callback_result.num_properties = prop_cnt, \
 	}
 
+#define CALLBACK_DEVICE_PROPS(props, prop_cnt) { \
+		.callback = CB_BT_REMOTE_DEVICE_PROPERTIES, \
+		.callback_result.properties = props, \
+		.callback_result.num_properties = prop_cnt, \
+	}
+
 #define CALLBACK_DEVICE_FOUND(props, prop_cnt) { \
 		.callback = CB_BT_DEVICE_FOUND, \
 		.callback_result.properties = props, \
@@ -228,3 +234,4 @@ void bt_set_property_action(void);
 void bt_get_property_action(void);
 void bt_start_discovery_action(void);
 void bt_cancel_discovery_action(void);
+void bt_get_device_props_action(void);
-- 
1.9.1

