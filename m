Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 09/11] android/tester-ng: Add ssp confirmation cases
Date: Mon, 21 Jul 2014 09:40:27 +0200
Message-Id: <1405928429-11491-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Needed actions were added to properly execute spp procedure. Also
callback data was extended to verify incomming ssp variant, and
action data was extended to pass ssp accept parameters.
---
 android/tester-bluetooth.c | 59 ++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c      | 67 +++++++++++++++++++++++++++++++++++++++++++++-
 android/tester-main.h      | 13 +++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index dbcd782..830d939 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -425,6 +425,18 @@ static struct bt_action_data prop_test_remote_ble_timestamp_req = {
 	.prop = &prop_test_remote_ble_timestamp_prop,
 };
 
+static struct bt_action_data ssp_confirm_accept_reply = {
+	.addr = &emu_remote_bdaddr_val,
+	.ssp_variant = BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+	.accept = TRUE,
+};
+
+static struct bt_action_data ssp_confirm_reject_reply = {
+	.addr = &emu_remote_bdaddr_val,
+	.ssp_variant = BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+	.accept = FALSE,
+};
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Bt. Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -992,6 +1004,53 @@ static struct test_case test_cases[] = {
 						&prop_emu_remote_bdadr, 1,
 						BT_STATUS_AUTH_FAILURE),
 	),
+	TEST_CASE_BREDR("Bt. Create Bond SSP -Success",
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
+	),
+	TEST_CASE_BREDR("Bt. Create Bond SSP - Negative reply",
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
+						&ssp_confirm_reject_reply),
+		CALLBACK_BOND_STATE_FAILED(BT_BOND_STATE_NONE,
+						&prop_emu_remote_bdadr, 1,
+						BT_STATUS_AUTH_FAILURE),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 9a06ffe..4effc2d 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -430,6 +430,12 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
+		if (exp->callback_result.pairing_variant !=
+					step->callback_result.pairing_variant) {
+			tester_debug("Callback pairing result don't match");
+			return false;
+		}
+
 		if (exp->callback_result.properties &&
 				verify_property(exp->callback_result.properties,
 				exp->callback_result.num_properties,
@@ -695,6 +701,34 @@ static void pin_request_cb(bt_bdaddr_t *remote_bd_addr,
 	schedule_callback_call(step);
 }
 
+static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod,
+					bt_ssp_variant_t pairing_variant,
+					uint32_t pass_key)
+{
+	struct step *step = g_new0(struct step, 1);
+	bt_property_t *props[3];
+
+	step->callback = CB_BT_SSP_REQUEST;
+
+	/* Utilize property verification mechanism for those */
+	props[0] = create_property(BT_PROPERTY_BDADDR, remote_bd_addr,
+						sizeof(*remote_bd_addr));
+	props[1] = create_property(BT_PROPERTY_BDNAME, bd_name->name,
+						strlen((char *) bd_name->name));
+	props[2] = create_property(BT_PROPERTY_CLASS_OF_DEVICE, &cod,
+								sizeof(cod));
+
+	step->callback_result.num_properties = 3;
+	step->callback_result.properties = repack_properties(3, props);
+
+	g_free(props[0]);
+	g_free(props[1]);
+	g_free(props[2]);
+
+	schedule_callback_call(step);
+}
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -703,7 +737,7 @@ static bt_callbacks_t bt_callbacks = {
 	.device_found_cb = device_found_cb,
 	.discovery_state_changed_cb = discovery_state_changed_cb,
 	.pin_request_cb = pin_request_cb,
-	.ssp_request_cb = NULL,
+	.ssp_request_cb = ssp_request_cb,
 	.bond_state_changed_cb = bond_state_changed_cb,
 	.acl_state_changed_cb = NULL,
 	.thread_evt_cb = NULL,
@@ -1040,6 +1074,22 @@ void emu_set_pin_code_action(void)
 	verify_step(&step, NULL);
 }
 
+void emu_set_ssp_mode_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost;
+	struct step step;
+
+	bthost = hciemu_client_get_host(data->hciemu);
+
+	bthost_write_ssp_mode(bthost, 0x01);
+
+	memset(&step, 0, sizeof(step));
+	step.action_status = BT_STATUS_SUCCESS;
+
+	verify_step(&step, NULL);
+}
+
 void dummy_action(void)
 {
 	struct step step;
@@ -1240,6 +1290,21 @@ void bt_pin_reply_accept_action(void)
 	verify_step(&step, NULL);
 }
 
+void bt_ssp_reply_accept_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action_status = data->if_bluetooth->ssp_reply(action_data->addr,
+						action_data->ssp_variant,
+						action_data->accept, 0);
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index d49344e..ee05cce 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -114,6 +114,13 @@
 		.callback_result.num_properties = prop_cnt, \
 	}
 
+#define CALLBACK_SSP_REQ(pair_var, props, prop_cnt) { \
+		.callback = CB_BT_SSP_REQUEST, \
+		.callback_result.pairing_variant = pair_var, \
+		.callback_result.properties = props, \
+		.callback_result.num_properties = prop_cnt, \
+	}
+
 /*
  * NOTICE:
  * Callback enum sections should be
@@ -209,6 +216,8 @@ struct bt_action_data {
 	/* Bonding requests parameters */
 	bt_pin_code_t *pin;
 	uint8_t pin_len;
+	uint8_t ssp_variant;
+	bool accept;
 };
 
 /*
@@ -221,6 +230,8 @@ struct bt_callback_data {
 	bt_status_t status;
 	int num_properties;
 	bt_property_t *properties;
+
+	bt_ssp_variant_t pairing_variant;
 };
 
 /*
@@ -258,6 +269,7 @@ void remove_gatt_tests(void);
 /* Emulator actions */
 void emu_setup_powered_remote_action(void);
 void emu_set_pin_code_action(void);
+void emu_set_ssp_mode_action(void);
 
 /* Actions */
 void dummy_action(void);
@@ -272,3 +284,4 @@ void bt_get_device_prop_action(void);
 void bt_set_device_prop_action(void);
 void bt_create_bond_action(void);
 void bt_pin_reply_accept_action(void);
+void bt_ssp_reply_accept_action(void);
-- 
1.9.1

