Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 07/11] android/tester-ng: Add BREDR pairing with pin test case
Date: Fri, 18 Jul 2014 13:51:16 +0200
Message-Id: <1405684280-1017-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405684280-1017-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405684280-1017-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This also adds some actions for setting pin the emulated device and
for calling bonding api of bluetooth core.
---
 android/tester-bluetooth.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c      | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h      | 14 +++++++++++
 3 files changed, 135 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 020bbe2..ebb85be 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -86,11 +86,18 @@ static bt_property_t prop_emu_bonded_devs = {
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
+static bt_property_t prop_emu_remote_bdadr = {
+	.type = BT_PROPERTY_BDADDR,
+	.val = &emu_remote_bdaddr_val,
+	.len = sizeof(emu_remote_bdaddr_val),
+};
 static struct bt_action_data prop_emu_remote_ble_bdaddr_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_BDADDR,
 };
 
+static uint32_t emu_remote_type_val = BT_DEVICE_DEVTYPE_BREDR;
+
 static uint32_t emu_remote_tod_ble_val = BT_DEVICE_DEVTYPE_BLE;
 static bt_property_t prop_emu_remote_ble_tod_prop = {
 	.type = BT_PROPERTY_TYPE_OF_DEVICE,
@@ -102,6 +109,8 @@ static struct bt_action_data prop_emu_remote_ble_tod_req = {
 	.prop_type = BT_PROPERTY_TYPE_OF_DEVICE,
 };
 
+static int32_t emu_remote_rssi_val = -60;
+
 static int32_t emu_remote_ble_rssi_val = 127;
 static bt_property_t prop_emu_remote_ble_rssi_prop = {
 	.type = BT_PROPERTY_REMOTE_RSSI,
@@ -187,6 +196,15 @@ static struct bt_action_data prop_emu_remote_ble_fname_req = {
 	.prop = &prop_emu_remote_ble_fname_prop,
 };
 
+static bt_pin_code_t emu_pin_value = {
+	.pin = { 0x30, 0x30, 0x30, 0x30 },
+};
+static struct bt_action_data emu_pin_set_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.pin = &emu_pin_value,
+	.pin_len = 4,
+};
+
 static bt_property_t prop_emu_default_set[] = {
 	{ BT_PROPERTY_BDADDR, sizeof(emu_bdaddr_val), NULL },
 	{ BT_PROPERTY_BDNAME, sizeof(emu_bdname_val) - 1, &emu_bdname_val },
@@ -210,6 +228,15 @@ static bt_property_t prop_emu_remote_bles_default_set[] = {
 						&emu_remote_ble_rssi_val },
 };
 
+static bt_property_t prop_emu_remotes_default_set[] = {
+	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
+						&emu_remote_bdaddr_val },
+	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_remote_type_val),
+						&emu_remote_type_val },
+	{ BT_PROPERTY_REMOTE_RSSI, sizeof(emu_remote_rssi_val),
+						&emu_remote_rssi_val },
+};
+
 static bt_property_t prop_emu_remote_bles_query_set[] = {
 	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_remote_tod_ble_val),
 						&emu_remote_tod_ble_val },
@@ -223,6 +250,15 @@ static bt_property_t prop_emu_remote_bles_query_set[] = {
 	{ BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP, 4, NULL },
 };
 
+static bt_property_t prop_emu_remotes_pin_req_set[] = {
+	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
+						&emu_remote_bdaddr_val },
+	{ BT_PROPERTY_CLASS_OF_DEVICE, sizeof(emu_remote_cod_val),
+						&emu_remote_cod_val },
+	{ BT_PROPERTY_BDNAME, sizeof(emu_remote_bdname_val) - 1,
+						&emu_remote_bdname_val },
+};
+
 static char test_bdname[] = "test_bdname";
 static bt_property_t prop_test_bdname = {
 	.type = BT_PROPERTY_BDNAME,
@@ -901,6 +937,29 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 					&prop_test_remote_ble_disc_timeout_req),
 	),
+	TEST_CASE_BREDR("Bt. Create Bond PIN - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_pin_code_action, &emu_pin_set_req),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 3),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_SUCCESS(bt_create_bond_action,
+					&prop_test_remote_ble_bdaddr_req),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_PROPS(CB_BT_PIN_REQUEST, prop_emu_remotes_pin_req_set,
+									2),
+		ACTION_SUCCESS(bt_pin_reply_accept_action,
+							&emu_pin_set_req),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDED,
+						&prop_emu_remote_bdadr, 1),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 043c0b9..9a06ffe 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1019,6 +1019,27 @@ void emu_setup_powered_remote_action(void)
 		bthost_write_scan_enable(bthost, 0x03);
 }
 
+void emu_set_pin_code_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	struct bthost *bthost;
+	struct step step;
+
+	bthost = hciemu_client_get_host(data->hciemu);
+
+	bthost_set_pin_code(bthost, action_data->pin->pin,
+							action_data->pin_len);
+
+	memset(&step, 0, sizeof(step));
+	step.action_status = BT_STATUS_SUCCESS;
+
+	tester_print("Setting emu pin done.");
+
+	verify_step(&step, NULL);
+}
+
 void dummy_action(void)
 {
 	struct step step;
@@ -1178,6 +1199,47 @@ void bt_set_device_prop_action(void)
 	verify_step(&step, NULL);
 }
 
+void bt_create_bond_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	struct step step;
+
+	if (!action_data || !action_data->addr) {
+		tester_warn("Bad arguments for 'create bond' req.");
+		tester_test_failed();
+		return;
+	}
+
+	memset(&step, 0, sizeof(step));
+	step.action_status = data->if_bluetooth->create_bond(action_data->addr);
+
+	verify_step(&step, NULL);
+}
+
+void bt_pin_reply_accept_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	struct step step;
+
+	if (!action_data || !action_data->addr || !action_data->pin) {
+		tester_warn("Bad arguments for 'pin reply' req.");
+		tester_test_failed();
+		return;
+	}
+
+	memset(&step, 0, sizeof(step));
+	step.action_status = data->if_bluetooth->pin_reply(action_data->addr,
+							TRUE,
+							action_data->pin_len,
+							action_data->pin);
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index 883ec4d..a8cf4a2 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -99,6 +99,13 @@
 #define CALLBACK_DEVICE_FOUND(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_DEVICE_FOUND, props, prop_cnt)
 
+#define CALLBACK_BOND_STATE(cb_res, props, prop_cnt) { \
+		.callback = CB_BT_BOND_STATE_CHANGED, \
+		.callback_result.state = cb_res, \
+		.callback_result.properties = props, \
+		.callback_result.num_properties = prop_cnt, \
+	}
+
 /*
  * NOTICE:
  * Callback enum sections should be
@@ -190,6 +197,10 @@ struct bt_action_data {
 	/* Remote props action arguments */
 	int prop_type;
 	bt_property_t *prop;
+
+	/* Bonding requests parameters */
+	bt_pin_code_t *pin;
+	uint8_t pin_len;
 };
 
 /*
@@ -238,6 +249,7 @@ void remove_gatt_tests(void);
 
 /* Emulator actions */
 void emu_setup_powered_remote_action(void);
+void emu_set_pin_code_action(void);
 
 /* Actions */
 void dummy_action(void);
@@ -250,3 +262,5 @@ void bt_cancel_discovery_action(void);
 void bt_get_device_props_action(void);
 void bt_get_device_prop_action(void);
 void bt_set_device_prop_action(void);
+void bt_create_bond_action(void);
+void bt_pin_reply_accept_action(void);
-- 
1.9.1

