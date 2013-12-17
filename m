Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] android/tester: Check adapter cb irrespective of receiving order
Date: Tue, 17 Dec 2013 13:37:49 +0100
Message-Id: <1387283874-29721-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch change checking of expected callbacks from static order to
dynamic. For example properties can be received in different order
than now.
---
 android/android-tester.c | 100 ++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 61 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 4eb265b..92e6080 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -53,7 +53,6 @@ static uint32_t test_setprop_disctimeout_val = 120;
 
 enum hal_bluetooth_callbacks_id {
 	ADAPTER_TEST_END,
-	ADAPTER_TEST_SETUP_MODE,
 	ADAPTER_STATE_CHANGED_ON,
 	ADAPTER_STATE_CHANGED_OFF,
 	ADAPTER_PROP_BDADDR,
@@ -156,6 +155,13 @@ static void command_generic_new_settings(uint16_t index, uint16_t length,
 	mgmt_unregister(data->mgmt, data->mgmt_settings_id);
 }
 
+static bool is_empty_halcb_list(void)
+{
+	struct test_data *data = tester_get_data();
+
+	return !(g_slist_length(data->expected_callbacks));
+}
+
 static void hal_cb_init(struct test_data *data)
 {
 	const struct generic_data *test_data = data->test_data;
@@ -167,6 +173,9 @@ static void hal_cb_init(struct test_data *data)
 		GINT_TO_POINTER(test_data->expected_hal_callbacks[i]));
 		i++;
 	}
+
+	if (is_empty_halcb_list())
+		data->hal_cb_called = true;
 }
 
 static void mgmt_cb_init(struct test_data *data)
@@ -193,7 +202,7 @@ static void test_property_init(struct test_data *data)
 {
 	const struct generic_data *test_data = data->test_data;
 
-	if (!(test_data->expected_property.type))
+	if (is_empty_halcb_list() || !(test_data->expected_property.type))
 		data->property_checked = true;
 }
 
@@ -245,22 +254,16 @@ static void check_test_property(void)
 	test_update_state();
 }
 
-static int get_expected_hal_cb(void)
+static void update_hal_cb_list(enum hal_bluetooth_callbacks_id
+							expected_callback)
 {
 	struct test_data *data = tester_get_data();
 
-	if (!(g_slist_length(data->expected_callbacks)))
-		return ADAPTER_TEST_SETUP_MODE;
-
-	return GPOINTER_TO_INT(data->expected_callbacks->data);
-}
-
-static void remove_expected_hal_cb(void)
-{
-	struct test_data *data = tester_get_data();
+	if (is_empty_halcb_list())
+		return;
 
 	data->expected_callbacks = g_slist_remove(data->expected_callbacks,
-						data->expected_callbacks->data);
+					GINT_TO_POINTER(expected_callback));
 
 	if (!data->expected_callbacks)
 		data->hal_cb_called = true;
@@ -465,28 +468,17 @@ failed:
 
 static void adapter_state_changed_cb(bt_state_t state)
 {
-	enum hal_bluetooth_callbacks_id hal_cb;
-
-	hal_cb = get_expected_hal_cb();
-
-	switch (hal_cb) {
-	case ADAPTER_STATE_CHANGED_ON:
-		if (state == BT_STATE_ON)
-			remove_expected_hal_cb();
-		else
-			tester_test_failed();
-		break;
-	case ADAPTER_STATE_CHANGED_OFF:
-		if (state == BT_STATE_OFF)
-			remove_expected_hal_cb();
-		else
-			tester_test_failed();
-		break;
-	case ADAPTER_TEST_SETUP_MODE:
-		if (state == BT_STATE_ON)
+	switch (state) {
+	case BT_STATE_ON:
+		if (is_empty_halcb_list())
 			tester_setup_complete();
-		else
+		update_hal_cb_list(ADAPTER_STATE_CHANGED_ON);
+		break;
+	case BT_STATE_OFF:
+		if (is_empty_halcb_list())
 			tester_setup_failed();
+		update_hal_cb_list(ADAPTER_STATE_CHANGED_OFF);
+		break;
 	default:
 		break;
 	}
@@ -495,65 +487,51 @@ static void adapter_state_changed_cb(bt_state_t state)
 static void adapter_properties_cb(bt_status_t status, int num_properties,
 						bt_property_t *properties)
 {
-	enum hal_bluetooth_callbacks_id hal_cb;
 	struct test_data *data = tester_get_data();
 	int i;
 
-	for (i = 0; i < num_properties; i++) {
-		hal_cb = get_expected_hal_cb();
+	if (is_empty_halcb_list())
+		return;
 
-		if (hal_cb == ADAPTER_TEST_SETUP_MODE)
-			break;
+	for (i = 0; i < num_properties; i++) {
 
-		data->test_property = *properties;
+		data->test_property = properties[i];
 
-		if (g_slist_next(data->expected_callbacks) ==
-							ADAPTER_TEST_END)
+		if (g_slist_length(data->expected_callbacks) == 1)
 			check_test_property();
 
 		switch (properties[i].type) {
 		case BT_PROPERTY_BDADDR:
-			if (hal_cb != ADAPTER_PROP_BDADDR)
-				goto fail;
+			update_hal_cb_list(ADAPTER_PROP_BDADDR);
 			break;
 		case BT_PROPERTY_BDNAME:
-			if (hal_cb != ADAPTER_PROP_BDNAME)
-				goto fail;
+			update_hal_cb_list(ADAPTER_PROP_BDNAME);
 			break;
 		case BT_PROPERTY_UUIDS:
-			if (hal_cb != ADAPTER_PROP_UUIDS)
-				goto fail;
+			update_hal_cb_list(ADAPTER_PROP_UUIDS);
 			break;
 		case BT_PROPERTY_CLASS_OF_DEVICE:
-			if (hal_cb != ADAPTER_PROP_COD)
-				goto fail;
+			update_hal_cb_list(ADAPTER_PROP_COD);
 			break;
 		case BT_PROPERTY_TYPE_OF_DEVICE:
-			if (hal_cb != ADAPTER_PROP_TYPE)
-				goto fail;
+			update_hal_cb_list(ADAPTER_PROP_TYPE);
 			break;
 		case BT_PROPERTY_SERVICE_RECORD:
-			if (hal_cb != ADAPTER_PROP_SERVICE_RECORD)
-				goto fail;
+			update_hal_cb_list(ADAPTER_PROP_SERVICE_RECORD);
 			break;
 		case BT_PROPERTY_ADAPTER_SCAN_MODE:
-			if (hal_cb != ADAPTER_PROP_SCAN_MODE)
-				goto fail;
+			update_hal_cb_list(ADAPTER_PROP_SCAN_MODE);
 			break;
 		case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
-			if (hal_cb != ADAPTER_PROP_BONDED_DEVICES)
-				goto fail;
+			update_hal_cb_list(ADAPTER_PROP_BONDED_DEVICES);
 			break;
 		case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
-			if (hal_cb != ADAPTER_PROP_DISC_TIMEOUT)
-				goto fail;
+			update_hal_cb_list(ADAPTER_PROP_DISC_TIMEOUT);
 			break;
 		default:
 			goto fail;
 		}
-		remove_expected_hal_cb();
 	}
-
 	return;
 
 fail:
-- 
1.8.4.2

