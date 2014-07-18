Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/9] android/tester-ng: Add get remote props cases
Date: Fri, 18 Jul 2014 11:50:17 +0200
Message-Id: <1405677021-18877-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch also introduces bt_action_data for passing arguments to HAL
api calls. So far one argument was enough but now there's need for more.
---
 android/tester-bluetooth.c | 148 ++++++++++++++++++++++++++++++++++++++++++++-
 android/tester-main.c      |  21 +++++++
 android/tester-main.h      |  11 ++++
 3 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 65fd93c..497691f 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -83,13 +83,73 @@ static bt_property_t prop_emu_bonded_devs = {
 	.len = 0,
 };
 
-static uint32_t emu_remote_type_val = BT_DEVICE_DEVTYPE_BLE;
-static int32_t emu_remote_rssi_val = 127;
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
+
+static uint32_t emu_remote_type_val = BT_DEVICE_DEVTYPE_BLE;
+static bt_property_t prop_emu_ble_remote_tod_prop = {
+	.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.val = &emu_remote_type_val,
+	.len = sizeof(emu_remote_type_val),
+};
+static struct bt_action_data prop_emu_ble_remote_tod_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_TYPE_OF_DEVICE,
+};
+
+static int32_t emu_remote_rssi_val = 127;
+static bt_property_t prop_emu_ble_remote_rssi_prop = {
+	.type = BT_PROPERTY_REMOTE_RSSI,
+	.val = &emu_remote_rssi_val,
+	.len = sizeof(emu_remote_rssi_val),
+};
+static struct bt_action_data prop_emu_ble_remote_rssi_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_REMOTE_RSSI,
+};
+
 static const char emu_remote_bdname_val[] = "00:AA:01:01:00:00";
+static bt_property_t prop_emu_ble_remote_bdname_prop = {
+	.type = BT_PROPERTY_BDNAME,
+	.val = &emu_remote_bdname_val,
+	.len = sizeof(emu_remote_bdname_val) - 1,
+};
+static struct bt_action_data prop_emu_ble_remote_bdname_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_BDNAME,
+};
+
 static uint32_t emu_remote_cod_val = 0;
+static bt_property_t prop_emu_ble_remote_cod_prop = {
+	.type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.val = &emu_remote_cod_val,
+	.len = sizeof(emu_remote_cod_val),
+};
+static struct bt_action_data prop_emu_ble_remote_cod_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_CLASS_OF_DEVICE,
+};
+
+static bt_property_t prop_emu_ble_remote_uuids_prop = {
+	.type = BT_PROPERTY_UUIDS,
+	.val = NULL,
+	.len = 0,
+};
+static struct bt_action_data prop_emu_ble_remote_uuids_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_UUIDS,
+};
+
+static bt_property_t prop_emu_ble_remote_timestamp_prop = {
+	.type = BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP,
+	.val = NULL,
+	.len = 4,
+};
+static struct bt_action_data prop_emu_ble_remote_timestamp_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP,
+};
 
 static bt_property_t prop_emu_default_set[] = {
 	{ BT_PROPERTY_BDADDR, sizeof(emu_bdaddr_val), NULL },
@@ -421,6 +481,90 @@ static struct test_case test_cases[] = {
 							&emu_remote_bdaddr_val),
 		CALLBACK_DEVICE_PROPS(prop_emu_ble_remotes_query_set, 6),
 	),
+	TEST_CASE("Bluetooth Device Get BDNAME - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_SUCCESS(bt_get_device_prop_action,
+					&prop_emu_ble_remote_bdname_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_bdname_prop, 1),
+	),
+	TEST_CASE("Bluetooth Device Get UUIDS - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_SUCCESS(bt_get_device_prop_action,
+						&prop_emu_ble_remote_uuids_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_uuids_prop, 1),
+	),
+	TEST_CASE("Bluetooth Device Get COD - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_SUCCESS(bt_get_device_prop_action,
+						&prop_emu_ble_remote_cod_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_cod_prop, 1),
+	),
+	TEST_CASE("Bluetooth Device Get TOD - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_SUCCESS(bt_get_device_prop_action,
+						&prop_emu_ble_remote_tod_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_tod_prop, 1),
+	),
+	TEST_CASE("Bluetooth Device Get RSSI - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_SUCCESS(bt_get_device_prop_action,
+						&prop_emu_ble_remote_rssi_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_rssi_prop, 1),
+	),
+	TEST_CASE("Bluetooth Device Get TIMESTAMP - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_SUCCESS(bt_get_device_prop_action,
+					&prop_emu_ble_remote_timestamp_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_timestamp_prop, 1),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index dde04b9..59762bb 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1057,6 +1057,27 @@ void bt_get_device_props_action(void)
 	verify_step(&step, NULL);
 }
 
+void bt_get_device_prop_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	struct step step;
+
+	if (!action_data) {
+		tester_warn("No arguments for 'get remote device prop' req.");
+		tester_test_failed();
+		return;
+	}
+
+	memset(&step, 0, sizeof(step));
+	step.action_status = data->if_bluetooth->get_remote_device_property(
+							action_data->addr,
+							action_data->prop_type);
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index 920f82c..ef8c3d5 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -174,6 +174,16 @@ struct test_data {
 };
 
 /*
+ * Struct holding bluetooth HAL action parameters
+ */
+struct bt_action_data {
+	bt_bdaddr_t *addr;
+
+	/* Remote props action arguments */
+	int prop_type;
+};
+
+/*
  * Callback data structure should be enhanced with data
  * returned by callbacks. It's used for test case step
  * matching with expected step data.
@@ -228,3 +238,4 @@ void bt_get_property_action(void);
 void bt_start_discovery_action(void);
 void bt_cancel_discovery_action(void);
 void bt_get_device_props_action(void);
+void bt_get_device_prop_action(void);
-- 
1.9.1

