Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 10/11] android/tester-ng: Add more bonding cases
Date: Fri, 18 Jul 2014 13:51:19 +0200
Message-Id: <1405684280-1017-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405684280-1017-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405684280-1017-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds more cases for bond, bond canceling and bond removal.
---
 android/tester-bluetooth.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c      | 26 ++++++++++++++
 android/tester-main.h      |  2 ++
 3 files changed, 118 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 3f0f0c4..79e3246 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -378,6 +378,11 @@ static struct bt_action_data prop_test_remote_ble_bdaddr_req = {
 	.prop_type = BT_PROPERTY_BDADDR,
 	.prop = &prop_test_bdaddr,
 };
+static struct bt_action_data prop_test_bdaddr_req = {
+	.addr = &test_bdaddr_val,
+	.prop_type = BT_PROPERTY_BDADDR,
+	.prop = &prop_test_bdaddr,
+};
 
 static bt_scan_mode_t setprop_scan_mode_conn_val = BT_SCAN_MODE_CONNECTABLE;
 
@@ -1051,6 +1056,91 @@ static struct test_case test_cases[] = {
 						&prop_emu_remote_bdadr, 1,
 						BT_STATUS_AUTH_FAILURE),
 	),
+	TEST_CASE_BREDR("Bt. Create Bond - No Discovery",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(bt_create_bond_action,
+					&prop_test_remote_ble_bdaddr_req),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_SSP_REQ(BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+					prop_emu_remotes_pin_req_set, 2),
+		ACTION_SUCCESS(bt_ssp_reply_accept_action,
+						&ssp_confirm_accept_reply),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDED,
+						&prop_emu_remote_bdadr, 1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDR("Bt. Create Bond - Bad Address",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(bt_create_bond_action, &prop_test_bdaddr_req),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
+							&prop_test_bdaddr, 1),
+		CALLBACK_BOND_STATE_FAILED(BT_BOND_STATE_NONE,
+							&prop_test_bdaddr, 1,
+							BT_STATUS_FAIL),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDR("Bt. Cancel Bonding - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
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
+		CALLBACK_SSP_REQ(BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+					prop_emu_remotes_pin_req_set, 2),
+		ACTION_SUCCESS(bt_cancel_bond_action, &emu_remote_bdaddr_val),
+		CALLBACK_BOND_STATE_FAILED(BT_BOND_STATE_NONE,
+						&prop_emu_remote_bdadr, 1,
+						BT_STATUS_FAIL),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDR("Bt. Remove Bond - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
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
+		CALLBACK_SSP_REQ(BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+					prop_emu_remotes_pin_req_set, 2),
+		ACTION_SUCCESS(bt_ssp_reply_accept_action,
+						&ssp_confirm_accept_reply),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDED,
+						&prop_emu_remote_bdadr, 1),
+		ACTION_SUCCESS(bt_remove_bond_action, &emu_remote_bdaddr_val),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_NONE,
+						&prop_emu_remote_bdadr, 1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 4effc2d..5496d2e 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1305,6 +1305,32 @@ void bt_ssp_reply_accept_action(void)
 	verify_step(&step, NULL);
 }
 
+void bt_cancel_bond_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	bt_bdaddr_t *addr = current_data_step->set_data;
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action_status = data->if_bluetooth->cancel_bond(addr);
+
+	verify_step(&step, NULL);
+}
+
+void bt_remove_bond_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	bt_bdaddr_t *addr = current_data_step->set_data;
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action_status = data->if_bluetooth->remove_bond(addr);
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index ee05cce..a239ae1 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -285,3 +285,5 @@ void bt_set_device_prop_action(void);
 void bt_create_bond_action(void);
 void bt_pin_reply_accept_action(void);
 void bt_ssp_reply_accept_action(void);
+void bt_cancel_bond_action(void);
+void bt_remove_bond_action(void);
-- 
1.9.1

