Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] android/tester: Fix bluetooth disable success test case
Date: Thu, 19 Dec 2013 13:42:22 +0100
Message-Id: <1387456946-9743-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes not checking for proper status on bluetooth disable.

---
 android/android-tester.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 5549dcb..68614a2 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -596,7 +596,8 @@ static const struct generic_data bluetooth_enable_done_test = {
 
 static const struct generic_data bluetooth_disable_success_test = {
 	.expected_hal_callbacks = { ADAPTER_STATE_CHANGED_OFF,
-							ADAPTER_TEST_END }
+							ADAPTER_TEST_END },
+	.expected_adapter_status = BT_STATUS_SUCCESS
 };
 
 static const struct generic_data bluetooth_setprop_bdname_success_test = {
@@ -858,10 +859,12 @@ static void test_enable_done(const void *test_data)
 static void test_disable(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	bt_status_t adapter_status;
 
 	init_test_conditions(data);
 
-	data->if_bluetooth->disable();
+	adapter_status = data->if_bluetooth->disable();
+	check_expected_status(adapter_status);
 }
 
 static void test_setprop_bdname_success(const void *test_data)
-- 
1.8.5

