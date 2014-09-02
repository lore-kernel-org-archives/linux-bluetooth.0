Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 5/5] android/tester: Add test verifying correct bond state notification
Date: Tue,  2 Sep 2014 15:55:03 +0200
Message-Id: <1409666103-14663-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409666103-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409666103-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added test which verify that remote device which is paired and not
bonded has correct state in Android framework after ACL disconnection.
---
 android/tester-bluetooth.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 7ea0684..a97e28e 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -448,6 +448,8 @@ static  struct bt_action_data no_input_no_output_io_cap = {
 	.io_cap = 0x03,
 };
 
+static uint16_t test_conn_handle = 0;
+
 static void conn_cb(uint16_t handle, void *user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -455,6 +457,8 @@ static void conn_cb(uint16_t handle, void *user_data)
 
 	tester_print("New connection with handle 0x%04x", handle);
 
+	test_conn_handle = handle;
+
 	bthost_request_auth(bthost, handle);
 }
 
@@ -1178,6 +1182,30 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDR("Bluetooth Accept Bond - No Bond - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_set_property_action,
+					&prop_test_scanmode_conn_discov),
+		CALLBACK_ADAPTER_PROPS(&prop_test_scanmode_conn_discov, 1),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_io_cap, &no_input_no_output_io_cap),
+		ACTION_SUCCESS(emu_set_connect_cb_action, conn_cb),
+		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDED,
+						&prop_emu_remote_bdadr, 1),
+		ACTION_SUCCESS(emu_remote_disconnect_hci_action,
+							&test_conn_handle),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_NONE,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
-- 
1.8.4

