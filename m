Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 13/17] android/tester: Remove not needed hook for inquiry complete
Date: Wed, 26 Feb 2014 02:57:24 +0100
Message-ID: <1393379848-4031-14-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Inquiry is scheduled with timeout so there is no need to hook
before inquiry complete. It influence those tests cases:
"Bluetooth BR/EDR Discovery Start - Success".
"Bluetooth BR/EDR Discovery Stop - Success".
---
 android/android-tester.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index c6484bf..65516c1 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -2475,17 +2475,6 @@ static void test_discovery_stop_done(const void *test_data)
 	check_expected_status(status);
 }
 
-static bool pre_inq_compl_hook(const void *dummy, uint16_t len, void *user_data)
-{
-	struct test_data *data = tester_get_data();
-
-	/* Make sure Inquiry Command Complete is not called */
-
-	hciemu_del_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY);
-
-	return false;
-}
-
 static bool post_inq_cancel_hook(const void *dummy, uint16_t len,
 							void *user_data)
 {
@@ -2504,9 +2493,6 @@ static void test_discovery_stop_success(const void *test_data)
 
 	init_test_conditions(data);
 
-	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY,
-					pre_inq_compl_hook, data);
-
 	data->if_bluetooth->start_discovery();
 }
 
@@ -2516,9 +2502,6 @@ static void test_discovery_start_done(const void *test_data)
 
 	init_test_conditions(data);
 
-	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY,
-					pre_inq_compl_hook, data);
-
 	data->if_bluetooth->start_discovery();
 }
 
-- 
1.8.4

