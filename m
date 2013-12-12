Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/7] android/tester: Make generic_data structure const void pointer
Date: Thu, 12 Dec 2013 14:48:29 +0200
Message-Id: <1386852514-17270-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386852514-17270-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386852514-17270-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This allows us to have different types of generic data, like socket
data, bluetooth data, etc.
---
 android/android-tester.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 7ecc80d..800c14d 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -74,7 +74,7 @@ struct test_data {
 	unsigned int mgmt_settings_id;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
-	const struct generic_data *test_data;
+	const void *test_data;
 	pid_t bluetoothd_pid;
 	const bt_interface_t *if_bluetooth;
 
@@ -111,6 +111,7 @@ static void command_generic_new_settings(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct generic_data *test_data = data->test_data;
 	uint32_t settings;
 
 	if (length != 4) {
@@ -121,8 +122,8 @@ static void command_generic_new_settings(uint16_t index, uint16_t length,
 
 	settings = bt_get_le32(param);
 
-	if ((settings & data->test_data->expect_settings_set) !=
-					data->test_data->expect_settings_set)
+	if ((settings & test_data->expect_settings_set) !=
+					test_data->expect_settings_set)
 		return;
 
 	test_mgmt_settings_set(data);
@@ -131,29 +132,34 @@ static void command_generic_new_settings(uint16_t index, uint16_t length,
 
 static void hal_cb_init(struct test_data *data)
 {
+	const struct generic_data *test_data = data->test_data;
 	unsigned int i = 0;
 
-	while (data->test_data->expected_hal_callbacks[i]) {
-						data->expected_callbacks =
-				g_slist_append(data->expected_callbacks,
-		GINT_TO_POINTER(data->test_data->expected_hal_callbacks[i]));
+	while (test_data->expected_hal_callbacks[i]) {
+		data->expected_callbacks =
+			g_slist_append(data->expected_callbacks,
+		GINT_TO_POINTER(test_data->expected_hal_callbacks[i]));
 		i++;
 	}
 }
 
 static void mgmt_cb_init(struct test_data *data)
 {
-	if (!data->test_data->expect_settings_set)
+	const struct generic_data *test_data = data->test_data;
+
+	if (!test_data->expect_settings_set)
 		test_mgmt_settings_set(data);
 	else
 		data->mgmt_settings_id = mgmt_register(data->mgmt,
-					MGMT_EV_NEW_SETTINGS, data->mgmt_index,
+				MGMT_EV_NEW_SETTINGS, data->mgmt_index,
 				command_generic_new_settings, NULL, NULL);
 }
 
 static void expected_status_init(struct test_data *data)
 {
-	if (!(data->test_data->expected_adapter_status))
+	const struct generic_data *test_data = data->test_data;
+
+	if (!(test_data->expected_adapter_status))
 		data->status_checked = true;
 }
 
@@ -167,8 +173,9 @@ static void init_test_conditions(struct test_data *data)
 static void check_expected_status(uint8_t status)
 {
 	struct test_data *data = tester_get_data();
+	const struct generic_data *test_data = data->test_data;
 
-	if (data->test_data->expected_adapter_status == status)
+	if (test_data->expected_adapter_status == status)
 		data->status_checked = true;
 	else
 		tester_test_failed();
-- 
1.8.3.2

