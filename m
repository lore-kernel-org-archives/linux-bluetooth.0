Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] android/tester: Fix for not checking for BT_STATUS_SUCCESS
Date: Thu, 19 Dec 2013 13:42:21 +0100
Message-Id: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For BT_STATUS_SUCCESS no checks were done as it is 0 in bt_status_t
enum. Valid status for no status expected should be STATUS_NOT_EXPECTED.

---
 android/android-tester.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index c24f5a6..5549dcb 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -72,7 +72,7 @@ enum hal_bluetooth_callbacks_id {
 };
 
 struct generic_data {
-	uint8_t expected_adapter_status;
+	int expected_adapter_status;
 	uint32_t expect_settings_set;
 	bt_property_t expected_property;
 	uint8_t expected_hal_callbacks[];
@@ -92,6 +92,8 @@ struct socket_data {
 #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
 
+#define BT_STATUS_NOT_EXPECTED	-1
+
 struct test_data {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
@@ -199,7 +201,7 @@ static void expected_status_init(struct test_data *data)
 {
 	const struct generic_data *test_data = data->test_data;
 
-	if (!(test_data->expected_adapter_status))
+	if (test_data->expected_adapter_status == BT_STATUS_NOT_EXPECTED)
 		data->status_checked = true;
 }
 
-- 
1.8.5

