Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/9] android/tester-ng: Add remote device found case
Date: Fri, 18 Jul 2014 11:50:14 +0200
Message-Id: <1405677021-18877-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds first test case that requires remote emulated device to be
discovered. New action step was added to activate this device on demand.
---
 android/tester-bluetooth.c | 27 +++++++++++++++++++++
 android/tester-main.c      | 60 +++++++++++++++++++++++++++++++++++++++++++++-
 android/tester-main.h      |  9 +++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index fd5837d..6bc67da 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -83,6 +83,12 @@ static bt_property_t prop_emu_bonded_devs = {
 	.len = 0,
 };
 
+static uint32_t emu_remote_type_val = BT_DEVICE_DEVTYPE_BLE;
+static int32_t emu_remote_rssi_val = 127;
+static bt_bdaddr_t emu_remote_bdaddr_val = {
+	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
+};
+
 static bt_property_t prop_emu_default_set[] = {
 	{ BT_PROPERTY_BDADDR, sizeof(emu_bdaddr_val), NULL },
 	{ BT_PROPERTY_BDNAME, sizeof(emu_bdname_val) - 1, &emu_bdname_val },
@@ -96,6 +102,15 @@ static bt_property_t prop_emu_default_set[] = {
 	{ BT_PROPERTY_UUIDS, sizeof(emu_uuids_val), &emu_uuids_val },
 };
 
+static bt_property_t prop_emu_ble_remotes_default_set[] = {
+	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
+						&emu_remote_bdaddr_val },
+	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_remote_type_val),
+							&emu_remote_type_val },
+	{ BT_PROPERTY_REMOTE_RSSI, sizeof(emu_remote_rssi_val),
+							&emu_remote_rssi_val },
+};
+
 static char test_bdname[] = "test_bdname";
 static bt_property_t prop_test_bdname = {
 	.type = BT_PROPERTY_BDNAME,
@@ -365,6 +380,18 @@ static struct test_case test_cases[] = {
 							BT_DISCOVERY_STOPPED),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
 	),
+	TEST_CASE("Bluetooth BR/EDR Discovery Device Found",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		CALLBACK_DEVICE_FOUND(prop_emu_ble_remotes_default_set, 3),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 7e2cc09..5849c0c 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -17,6 +17,9 @@
 
 #include "tester-main.h"
 
+#include "emulator/bthost.h"
+#include "monitor/bt.h"
+
 static char exec_dir[PATH_MAX + 1];
 
 static gint scheduled_cbacks_num;
@@ -585,12 +588,25 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
 	schedule_callback_call(step);
 }
 
+static void device_found_cb(int num_properties, bt_property_t *properties)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback_result.num_properties = num_properties;
+	step->callback_result.properties = copy_properties(num_properties,
+								properties);
+
+	step->callback = CB_BT_DEVICE_FOUND;
+
+	schedule_callback_call(step);
+}
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
 	.adapter_properties_cb = adapter_properties_cb,
 	.remote_device_properties_cb = NULL,
-	.device_found_cb = NULL,
+	.device_found_cb = device_found_cb,
 	.discovery_state_changed_cb = discovery_state_changed_cb,
 	.pin_request_cb = NULL,
 	.ssp_request_cb = NULL,
@@ -867,6 +883,48 @@ static void teardown(const void *test_data)
 		tester_teardown_complete();
 }
 
+static void emu_connectable_complete(uint16_t opcode, uint8_t status,
+					const void *param, uint8_t len,
+					void *user_data)
+{
+	struct step step;
+
+	switch (opcode) {
+	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
+	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
+		break;
+	default:
+		return;
+	}
+
+	memset(&step, 0, sizeof(step));
+
+	if (status) {
+		tester_warn("Emulated remote setup failed.");
+		step.action_result.status = BT_STATUS_FAIL;
+	} else {
+		tester_warn("Emulated remote setup done.");
+		step.action_result.status = BT_STATUS_SUCCESS;
+	}
+
+	verify_step(&step, NULL);
+}
+
+void emu_setup_powered_remote_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost;
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_set_cmd_complete_cb(bthost, emu_connectable_complete, data);
+
+	if ((data->hciemu_type == HCIEMU_TYPE_LE) ||
+				(data->hciemu_type == HCIEMU_TYPE_BREDRLE))
+		bthost_set_adv_enable(bthost, 0x01, 0x02);
+	else
+		bthost_write_scan_enable(bthost, 0x03);
+}
+
 void dummy_action(void)
 {
 	struct step step;
diff --git a/android/tester-main.h b/android/tester-main.h
index 1e1dd51..3919713 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -79,6 +79,12 @@
 		.callback_result.num_properties = prop_cnt, \
 	}
 
+#define CALLBACK_DEVICE_FOUND(props, prop_cnt) { \
+		.callback = CB_BT_DEVICE_FOUND, \
+		.callback_result.properties = props, \
+		.callback_result.num_properties = prop_cnt, \
+	}
+
 /*
  * NOTICE:
  * Callback enum sections should be
@@ -211,6 +217,9 @@ void remove_hidhost_tests(void);
 struct queue *get_gatt_tests(void);
 void remove_gatt_tests(void);
 
+/* Emulator actions */
+void emu_setup_powered_remote_action(void);
+
 /* Actions */
 void dummy_action(void);
 void bluetooth_enable_action(void);
-- 
1.9.1

