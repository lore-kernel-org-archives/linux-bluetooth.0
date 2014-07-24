Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 02/14] android/tester-ng: Make action calls non recurent
Date: Thu, 24 Jul 2014 10:37:55 +0200
Message-Id: <1406191087-5831-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All action steps steps were called recurently if not interleaved with
callbacks steps in test case definition. This could block any potential
callback that was not expected to come, as mainloop was stuck. This could
raise potential stability issues and timeouts when working with file
descriptors and io channels handled in the main loop.
---
 android/tester-main.c | 143 ++++++++++++++++++++++++--------------------------
 1 file changed, 70 insertions(+), 73 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 5496d2e..e7b1e1b 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -532,6 +532,15 @@ static void destroy_callback_step(void *data)
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
 
+static gboolean verify_action(gpointer user_data)
+{
+	struct step *step = user_data;
+
+	verify_step(step, g_free);
+
+	return FALSE;
+}
+
 static gboolean verify_callback(gpointer user_data)
 {
 	struct step *step = user_data;
@@ -551,6 +560,11 @@ static void schedule_callback_call(struct step *step)
 	g_idle_add(verify_callback, step);
 }
 
+static void schedule_action_verification(struct step *step)
+{
+	g_idle_add_full(G_PRIORITY_HIGH_IDLE, verify_action, step, NULL);
+}
+
 static void adapter_state_changed_cb(bt_state_t state)
 {
 	struct step *step = g_new0(struct step, 1);
@@ -1015,7 +1029,7 @@ static void emu_connectable_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
 {
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
 	switch (opcode) {
 	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
@@ -1025,17 +1039,15 @@ static void emu_connectable_complete(uint16_t opcode, uint8_t status,
 		return;
 	}
 
-	memset(&step, 0, sizeof(step));
-
 	if (status) {
 		tester_warn("Emulated remote setup failed.");
-		step.action_status = BT_STATUS_FAIL;
+		step->action_status = BT_STATUS_FAIL;
 	} else {
 		tester_warn("Emulated remote setup done.");
-		step.action_status = BT_STATUS_SUCCESS;
+		step->action_status = BT_STATUS_SUCCESS;
 	}
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void emu_setup_powered_remote_action(void)
@@ -1059,73 +1071,68 @@ void emu_set_pin_code_action(void)
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct bt_action_data *action_data = current_data_step->set_data;
 	struct bthost *bthost;
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
 	bthost = hciemu_client_get_host(data->hciemu);
 
 	bthost_set_pin_code(bthost, action_data->pin->pin,
 							action_data->pin_len);
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = BT_STATUS_SUCCESS;
+	step->action_status = BT_STATUS_SUCCESS;
 
 	tester_print("Setting emu pin done.");
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void emu_set_ssp_mode_action(void)
 {
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost;
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
 	bthost = hciemu_client_get_host(data->hciemu);
 
 	bthost_write_ssp_mode(bthost, 0x01);
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = BT_STATUS_SUCCESS;
+	step->action_status = BT_STATUS_SUCCESS;
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void dummy_action(void)
 {
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
-	memset(&step, 0, sizeof(step));
-	step.action = dummy_action;
+	step->action = dummy_action;
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bluetooth_enable_action(void)
 {
 	struct test_data *data = tester_get_data();
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->enable();
+	step->action_status = data->if_bluetooth->enable();
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bluetooth_disable_action(void)
 {
 	struct test_data *data = tester_get_data();
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->disable();
+	step->action_status = data->if_bluetooth->disable();
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_set_property_action(void)
 {
 	struct test_data *data = tester_get_data();
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 	struct step *current_data_step = queue_peek_head(data->steps);
 	bt_property_t *prop;
 
@@ -1137,17 +1144,16 @@ void bt_set_property_action(void)
 
 	prop = (bt_property_t *)current_data_step->set_data;
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->set_adapter_property(
+	step->action_status = data->if_bluetooth->set_adapter_property(
 									prop);
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_get_property_action(void)
 {
 	struct test_data *data = tester_get_data();
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 	struct step *current_data_step = queue_peek_head(data->steps);
 	bt_property_t *prop;
 
@@ -1159,39 +1165,37 @@ void bt_get_property_action(void)
 
 	prop = (bt_property_t *)current_data_step->set_data;
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->get_adapter_property(
+	step->action_status = data->if_bluetooth->get_adapter_property(
 								prop->type);
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_start_discovery_action(void)
 {
 	struct test_data *data = tester_get_data();
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
-	step.action_status = data->if_bluetooth->start_discovery();
+	step->action_status = data->if_bluetooth->start_discovery();
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_cancel_discovery_action(void)
 {
 	struct test_data *data = tester_get_data();
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->cancel_discovery();
+	step->action_status = data->if_bluetooth->cancel_discovery();
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_get_device_props_action(void)
 {
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
 	if (!current_data_step->set_data) {
 		tester_debug("bdaddr not defined");
@@ -1199,12 +1203,11 @@ void bt_get_device_props_action(void)
 		return;
 	}
 
-	memset(&step, 0, sizeof(step));
-	step.action_status =
+	step->action_status =
 		data->if_bluetooth->get_remote_device_properties(
 						current_data_step->set_data);
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_get_device_prop_action(void)
@@ -1212,7 +1215,7 @@ void bt_get_device_prop_action(void)
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct bt_action_data *action_data = current_data_step->set_data;
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
 	if (!action_data) {
 		tester_warn("No arguments for 'get remote device prop' req.");
@@ -1220,12 +1223,11 @@ void bt_get_device_prop_action(void)
 		return;
 	}
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->get_remote_device_property(
+	step->action_status = data->if_bluetooth->get_remote_device_property(
 							action_data->addr,
 							action_data->prop_type);
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_set_device_prop_action(void)
@@ -1233,7 +1235,7 @@ void bt_set_device_prop_action(void)
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct bt_action_data *action_data = current_data_step->set_data;
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
 	if (!action_data) {
 		tester_warn("No arguments for 'set remote device prop' req.");
@@ -1241,12 +1243,11 @@ void bt_set_device_prop_action(void)
 		return;
 	}
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->set_remote_device_property(
+	step->action_status = data->if_bluetooth->set_remote_device_property(
 							action_data->addr,
 							action_data->prop);
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_create_bond_action(void)
@@ -1254,7 +1255,7 @@ void bt_create_bond_action(void)
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct bt_action_data *action_data = current_data_step->set_data;
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
 	if (!action_data || !action_data->addr) {
 		tester_warn("Bad arguments for 'create bond' req.");
@@ -1262,10 +1263,10 @@ void bt_create_bond_action(void)
 		return;
 	}
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->create_bond(action_data->addr);
+	step->action_status =
+			data->if_bluetooth->create_bond(action_data->addr);
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_pin_reply_accept_action(void)
@@ -1273,7 +1274,7 @@ void bt_pin_reply_accept_action(void)
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct bt_action_data *action_data = current_data_step->set_data;
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
 	if (!action_data || !action_data->addr || !action_data->pin) {
 		tester_warn("Bad arguments for 'pin reply' req.");
@@ -1281,13 +1282,12 @@ void bt_pin_reply_accept_action(void)
 		return;
 	}
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->pin_reply(action_data->addr,
+	step->action_status = data->if_bluetooth->pin_reply(action_data->addr,
 							TRUE,
 							action_data->pin_len,
 							action_data->pin);
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_ssp_reply_accept_action(void)
@@ -1295,14 +1295,13 @@ void bt_ssp_reply_accept_action(void)
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct bt_action_data *action_data = current_data_step->set_data;
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->ssp_reply(action_data->addr,
+	step->action_status = data->if_bluetooth->ssp_reply(action_data->addr,
 						action_data->ssp_variant,
 						action_data->accept, 0);
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_cancel_bond_action(void)
@@ -1310,12 +1309,11 @@ void bt_cancel_bond_action(void)
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
 	bt_bdaddr_t *addr = current_data_step->set_data;
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->cancel_bond(addr);
+	step->action_status = data->if_bluetooth->cancel_bond(addr);
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 void bt_remove_bond_action(void)
@@ -1323,12 +1321,11 @@ void bt_remove_bond_action(void)
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
 	bt_bdaddr_t *addr = current_data_step->set_data;
-	struct step step;
+	struct step *step = g_new0(struct step, 1);
 
-	memset(&step, 0, sizeof(step));
-	step.action_status = data->if_bluetooth->remove_bond(addr);
+	step->action_status = data->if_bluetooth->remove_bond(addr);
 
-	verify_step(&step, NULL);
+	schedule_action_verification(step);
 }
 
 static void generic_test_function(const void *test_data)
-- 
1.9.1

