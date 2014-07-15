Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 05/10] android/tester-bluetooth: Add get bdaddr and bdname success cases
Date: Tue, 15 Jul 2014 10:24:54 +0200
Message-Id: <1405412699-6358-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-bluetooth.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c      | 22 ++++++++++++++
 android/tester-main.h      |  1 +
 3 files changed, 97 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index fc04c9d..6c05620 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -237,6 +237,78 @@ static struct test_case bluetooth_setprop_disctimeout_success_tc = {
 				bluetooth_setprop_disctimeout_success_steps),
 };
 
+static bt_bdaddr_t test_getprop_bdaddr_val = {
+	{0x00, 0xaa, 0x01, 0x00, 0x00, 0x00},
+};
+
+static bt_property_t getprop_bdaddr_prop = {
+	.type = BT_PROPERTY_BDADDR,
+	.val = &test_getprop_bdaddr_val,
+	.len = sizeof(test_getprop_bdaddr_val),
+};
+
+static struct step bluetooth_getprop_bdaddr_success_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.set_data = &getprop_bdaddr_prop,
+		.action = bt_get_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = &getprop_bdaddr_prop,
+		.callback_result.num_properties = 1,
+	},
+};
+static struct test_case bluetooth_getprop_bdaddr_success_tc = {
+	.step = bluetooth_getprop_bdaddr_success_steps,
+	.title = "Bluetooth Get BDADDR - Success",
+	.step_num = get_test_case_step_num(
+					bluetooth_getprop_bdaddr_success_steps),
+};
+
+static const char test_getprop_bdname_val[] = "BlueZ for Android";
+
+static bt_property_t getprop_bdname_prop = {
+	.type = BT_PROPERTY_BDNAME,
+	.val = &test_getprop_bdname_val,
+	.len = sizeof(test_getprop_bdname_val) - 1,
+};
+
+static struct step bluetooth_getprop_bdname_success_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.set_data = &getprop_bdname_prop,
+		.action = bt_get_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = &getprop_bdname_prop,
+		.callback_result.num_properties = 1,
+	},
+};
+static struct test_case bluetooth_getprop_bdname_success_tc = {
+	.step = bluetooth_getprop_bdname_success_steps,
+	.title = "Bluetooth Get BDNAME - Success",
+	.step_num = get_test_case_step_num(
+					bluetooth_getprop_bdname_success_steps),
+};
+
 static struct test_case *test_cases[] = {
 	&bluetooth_init,
 	&bluetooth_enable_success_tc,
@@ -245,6 +317,8 @@ static struct test_case *test_cases[] = {
 	&bluetooth_setprop_bdname_success_tc,
 	&bluetooth_setprop_scanmode_success_tc,
 	&bluetooth_setprop_disctimeout_success_tc,
+	&bluetooth_getprop_bdaddr_success_tc,
+	&bluetooth_getprop_bdname_success_tc,
 };
 
 struct queue *get_bluetooth_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 5bafc0e..e8cd4f2 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -911,6 +911,28 @@ void bt_set_property_action(void)
 	verify_step(&step, NULL);
 }
 
+void bt_get_property_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step step;
+	struct step *current_data_step = queue_peek_head(data->steps);
+	bt_property_t *prop;
+
+	if (!current_data_step->set_data) {
+		tester_debug("BT property to get not defined");
+		tester_test_failed();
+		return;
+	}
+
+	prop = (bt_property_t *)current_data_step->set_data;
+
+	memset(&step, 0, sizeof(step));
+	step.action_result.status = data->if_bluetooth->get_adapter_property(
+								prop->type);
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index a740f6b..c10513e 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -189,3 +189,4 @@ void dummy_action(void);
 void bluetooth_enable_action(void);
 void bluetooth_disable_action(void);
 void bt_set_property_action(void);
+void bt_get_property_action(void);
-- 
1.9.1

