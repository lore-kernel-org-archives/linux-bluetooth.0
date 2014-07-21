Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 08/11] android/tester-ng: Add wrong PIN reply test case
Date: Mon, 21 Jul 2014 09:40:26 +0200
Message-Id: <1405928429-11491-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-bluetooth.c | 32 ++++++++++++++++++++++++++++++++
 android/tester-main.h      |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 3a70f2b..dbcd782 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -199,11 +199,19 @@ static struct bt_action_data prop_emu_remote_ble_fname_req = {
 static bt_pin_code_t emu_pin_value = {
 	.pin = { 0x30, 0x30, 0x30, 0x30 },
 };
+static bt_pin_code_t emu_pin_invalid_value = {
+	.pin = { 0x30, 0x10, 0x30, 0x30 },
+};
 static struct bt_action_data emu_pin_set_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.pin = &emu_pin_value,
 	.pin_len = 4,
 };
+static struct bt_action_data emu_pin_set_invalid_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.pin = &emu_pin_invalid_value,
+	.pin_len = 4,
+};
 
 static bt_property_t prop_emu_default_set[] = {
 	{ BT_PROPERTY_BDADDR, sizeof(emu_bdaddr_val), NULL },
@@ -960,6 +968,30 @@ static struct test_case test_cases[] = {
 		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDED,
 						&prop_emu_remote_bdadr, 1),
 	),
+	TEST_CASE_BREDR("Bt. Create Bond PIN - Bad PIN",
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
+						&emu_pin_set_invalid_req),
+		CALLBACK_BOND_STATE_FAILED(BT_BOND_STATE_NONE,
+						&prop_emu_remote_bdadr, 1,
+						BT_STATUS_AUTH_FAILURE),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
diff --git a/android/tester-main.h b/android/tester-main.h
index a8cf4a2..d49344e 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -106,6 +106,14 @@
 		.callback_result.num_properties = prop_cnt, \
 	}
 
+#define CALLBACK_BOND_STATE_FAILED(cb_res, props, prop_cnt, reason) { \
+		.callback = CB_BT_BOND_STATE_CHANGED, \
+		.callback_result.state = cb_res, \
+		.callback_result.status = reason, \
+		.callback_result.properties = props, \
+		.callback_result.num_properties = prop_cnt, \
+	}
+
 /*
  * NOTICE:
  * Callback enum sections should be
-- 
1.9.1

