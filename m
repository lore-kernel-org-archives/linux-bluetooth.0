Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 7/9] android/tester-ng: Add set remote friendly name success case
Date: Fri, 18 Jul 2014 11:50:19 +0200
Message-Id: <1405677021-18877-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-bluetooth.c | 23 +++++++++++++++++++++++
 android/tester-main.c      | 21 +++++++++++++++++++++
 android/tester-main.h      |  2 ++
 3 files changed, 46 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 91c5a1a..480c92e 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -175,9 +175,16 @@ static struct bt_action_data prop_emu_ble_remote_verinfo_req = {
 	.prop_type = BT_PROPERTY_REMOTE_VERSION_INFO,
 };
 
+static const char prop_test_fname_val[] = "FriendlyTestName";
+static bt_property_t prop_emu_ble_remote_fname_prop = {
+	.type = BT_PROPERTY_REMOTE_FRIENDLY_NAME,
+	.val = &prop_test_fname_val,
+	.len = sizeof(prop_test_fname_val) - 1,
+};
 static struct bt_action_data prop_emu_ble_remote_fname_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_REMOTE_FRIENDLY_NAME,
+	.prop = &prop_emu_ble_remote_fname_prop,
 };
 
 static bt_property_t prop_emu_default_set[] = {
@@ -672,6 +679,22 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_get_device_prop_action,
 						&prop_emu_ble_remote_fname_req),
 	),
+	TEST_CASE("Bluetooth Device Set FRIENDLY_NAME - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_SUCCESS(bt_set_device_prop_action,
+						&prop_emu_ble_remote_fname_req),
+		ACTION_SUCCESS(bt_get_device_prop_action,
+						&prop_emu_ble_remote_fname_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_fname_prop, 1),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 59762bb..4c7a5e7 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1078,6 +1078,27 @@ void bt_get_device_prop_action(void)
 	verify_step(&step, NULL);
 }
 
+void bt_set_device_prop_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	struct step step;
+
+	if (!action_data) {
+		tester_warn("No arguments for 'set remote device prop' req.");
+		tester_test_failed();
+		return;
+	}
+
+	memset(&step, 0, sizeof(step));
+	step.action_status = data->if_bluetooth->set_remote_device_property(
+							action_data->addr,
+							action_data->prop);
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index ef8c3d5..2f6252d 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -181,6 +181,7 @@ struct bt_action_data {
 
 	/* Remote props action arguments */
 	int prop_type;
+	bt_property_t *prop;
 };
 
 /*
@@ -239,3 +240,4 @@ void bt_start_discovery_action(void);
 void bt_cancel_discovery_action(void);
 void bt_get_device_props_action(void);
 void bt_get_device_prop_action(void);
+void bt_set_device_prop_action(void);
-- 
1.9.1

