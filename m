Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/tester: Check return status for enable()
Date: Wed, 18 Dec 2013 10:55:12 +0200
Message-Id: <1387356913-32666-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387356913-32666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387356913-32666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use check_expected_status helper for test for returned status in
enable() HAL call.
---
 android/android-tester.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 4a75704..423dd6a 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -542,7 +542,8 @@ fail:
 
 static const struct generic_data bluetooth_enable_success_test = {
 	.expected_hal_callbacks = {ADAPTER_PROPS, ADAPTER_STATE_CHANGED_ON,
-							ADAPTER_TEST_END}
+							ADAPTER_TEST_END},
+	.expected_adapter_status = BT_STATUS_SUCCESS
 };
 
 static const struct generic_data bluetooth_enable_done_test = {
@@ -726,10 +727,12 @@ static void teardown(const void *test_data)
 static void test_enable(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	bt_status_t adapter_status;
 
 	init_test_conditions(data);
 
-	data->if_bluetooth->enable();
+	adapter_status = data->if_bluetooth->enable();
+	check_expected_status(adapter_status);
 }
 
 static void test_enable_done(const void *test_data)
-- 
1.8.3.2

