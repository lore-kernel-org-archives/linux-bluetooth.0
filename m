Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [PATCH v4 7/7] android/tester: Add status check and adapter enable, disable test cases
Date: Wed, 11 Dec 2013 11:46:37 +0100
Message-Id: <1386758797-1809-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1386758797-1809-1-git-send-email-marcin.kraglak@tieto.com>
References: <1386758797-1809-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

This adds handling of status check, enabled adapter setup method,
disable and enable fail test case.

---
 android/android-tester.c | 108 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 5 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 0dc1edf..09c76c9 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -46,6 +46,7 @@
 
 enum hal_bluetooth_callbacks_id {
 	adapter_test_end,
+	adapter_test_setup_mode,
 	adapter_state_changed_on,
 	adapter_state_changed_off,
 	adapter_prop_bdaddr,
@@ -59,6 +60,7 @@ enum hal_bluetooth_callbacks_id {
 };
 
 struct generic_data {
+	uint8_t expected_adapter_status;
 	uint32_t expect_settings_set;
 	uint8_t expected_hal_callbacks[];
 };
@@ -78,6 +80,7 @@ struct test_data {
 
 	bool mgmt_settings_set;
 	bool hal_cb_called;
+	bool status_checked;
 
 	GSList *expected_callbacks;
 };
@@ -88,8 +91,13 @@ static void test_update_state(void)
 {
 	struct test_data *data = tester_get_data();
 
-	if (data->mgmt_settings_set && data->hal_cb_called)
-		tester_test_passed();
+	if (!(data->mgmt_settings_set))
+		return;
+	if (!(data->hal_cb_called))
+		return;
+	if (!(data->status_checked))
+		return;
+	tester_test_passed();
 }
 
 static void test_mgmt_settings_set(struct test_data *data)
@@ -143,10 +151,38 @@ static void mgmt_cb_init(struct test_data *data)
 				command_generic_new_settings, NULL, NULL);
 }
 
+static void expected_status_init(struct test_data *data)
+{
+	if (!(data->test_data->expected_adapter_status))
+		data->status_checked = true;
+}
+
+static void init_test_conditions(struct test_data *data)
+{
+	hal_cb_init(data);
+	mgmt_cb_init(data);
+	expected_status_init(data);
+}
+
+static void check_expected_status(uint8_t status)
+{
+	struct test_data *data = tester_get_data();
+
+	if (data->test_data->expected_adapter_status == status)
+		data->status_checked = true;
+	else
+		tester_test_failed();
+
+	test_update_state();
+}
+
 static int get_expected_hal_cb(void)
 {
 	struct test_data *data = tester_get_data();
 
+	if (!(g_slist_length(data->expected_callbacks)))
+		return adapter_test_setup_mode;
+
 	return GPOINTER_TO_INT(data->expected_callbacks->data);
 }
 
@@ -359,13 +395,28 @@ failed:
 
 static void adapter_state_changed_cb(bt_state_t state)
 {
-	switch (get_expected_hal_cb()) {
+	enum hal_bluetooth_callbacks_id hal_cb;
+
+	hal_cb = get_expected_hal_cb();
+
+	switch (hal_cb) {
 	case adapter_state_changed_on:
 		if (state == BT_STATE_ON)
 			remove_expected_hal_cb();
 		else
 			tester_test_failed();
 		break;
+	case adapter_state_changed_off:
+		if (state == BT_STATE_OFF)
+			remove_expected_hal_cb();
+		else
+			tester_test_failed();
+		break;
+	case adapter_test_setup_mode:
+		if (state == BT_STATE_ON)
+			tester_setup_complete();
+		else
+			tester_setup_failed();
 	default:
 		break;
 	}
@@ -379,6 +430,10 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
 
 	for (i = 0; i < num_properties; i++) {
 		hal_cb = get_expected_hal_cb();
+
+		if (hal_cb == adapter_test_setup_mode)
+			break;
+
 		switch (properties[i].type) {
 		case BT_PROPERTY_BDADDR:
 			if (hal_cb != adapter_prop_bdaddr) {
@@ -454,6 +509,15 @@ static const struct generic_data bluetooth_enable_success_test = {
 							adapter_test_end}
 };
 
+static const struct generic_data bluetooth_enable_done_test = {
+	.expected_hal_callbacks = {adapter_props, adapter_test_end},
+	.expected_adapter_status = BT_STATUS_DONE
+};
+
+static const struct generic_data bluetooth_disable_success_test = {
+	.expected_hal_callbacks = {adapter_state_changed_off, adapter_test_end}
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -551,6 +615,15 @@ static void setup_base(const void *test_data)
 	tester_setup_complete();
 }
 
+static void setup_enabled_adapter(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	setup(data);
+
+	data->if_bluetooth->enable();
+}
+
 static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -573,12 +646,31 @@ static void test_enable(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	hal_cb_init(data);
-	mgmt_cb_init(data);
+	init_test_conditions(data);
 
 	data->if_bluetooth->enable();
 }
 
+static void test_enable_done(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->enable();
+	check_expected_status(adapter_status);
+}
+
+static void test_disable(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	init_test_conditions(data);
+
+	data->if_bluetooth->disable();
+}
+
 static void controller_setup(const void *test_data)
 {
 	tester_test_passed();
@@ -608,5 +700,11 @@ int main(int argc, char *argv[])
 	test_bredrle("Test Enable - Success", &bluetooth_enable_success_test,
 					setup_base, test_enable, teardown);
 
+	test_bredrle("Test Enable - Done", &bluetooth_enable_done_test,
+			setup_enabled_adapter, test_enable_done, teardown);
+
+	test_bredrle("Test Disable - Success", &bluetooth_disable_success_test,
+			setup_enabled_adapter, test_disable, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.1

