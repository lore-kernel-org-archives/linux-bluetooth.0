Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 5/5] android/tester: Add test for incoming bonding
Date: Tue, 26 Aug 2014 22:41:52 +0200
Message-Id: <1409085712-12402-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409085712-12402-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409085712-12402-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add test for incoming just works bonding
---
 android/tester-bluetooth.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 018d712..7ea0684 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -444,6 +444,20 @@ static struct bt_action_data ssp_confirm_reject_reply = {
 	.accept = FALSE,
 };
 
+static  struct bt_action_data no_input_no_output_io_cap = {
+	.io_cap = 0x03,
+};
+
+static void conn_cb(uint16_t handle, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	tester_print("New connection with handle 0x%04x", handle);
+
+	bthost_request_auth(bthost, handle);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Bluetooth Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -1143,6 +1157,27 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDR("Bluetooth Accept Bond - Just Works - Success",
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
+		ACTION_SUCCESS(bt_remove_bond_action, &emu_remote_bdaddr_val),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_NONE,
+						&prop_emu_remote_bdadr, 1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
-- 
1.8.4

