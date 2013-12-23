Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] android/tester: Change test data variables placement
Date: Mon, 23 Dec 2013 15:15:51 +0100
Message-Id: <1387808154-21661-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387808154-21661-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387808154-21661-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves two test variables to proper place in code - before
test case init structs.
---
 android/android-tester.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 2078a40..57f3fc9 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -47,10 +47,6 @@
 			ADAPTER_PROP_TYPE, ADAPTER_PROP_SCAN_MODE, \
 			ADAPTER_PROP_BONDED_DEVICES, ADAPTER_PROP_DISC_TIMEOUT
 
-static bt_scan_mode_t test_setprop_scanmode_val =
-					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
-static uint32_t test_setprop_disctimeout_val = 120;
-
 /*
  * those are assigned to HAL methods and callbacks, we use ID later
  * on mapped in switch-case due to different functions prototypes.
@@ -727,6 +723,9 @@ static const struct generic_data bluetooth_setprop_bdname_success_test = {
 	.expected_property.len = 11
 };
 
+static bt_scan_mode_t test_setprop_scanmode_val =
+					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
+
 static const struct generic_data bluetooth_setprop_scanmode_success_test = {
 	.expected_hal_callbacks = { ADAPTER_PROP_SCAN_MODE,
 						ADAPTER_PROP_SCAN_MODE,
@@ -737,6 +736,8 @@ static const struct generic_data bluetooth_setprop_scanmode_success_test = {
 	.expected_property.len = sizeof(bt_scan_mode_t)
 };
 
+static uint32_t test_setprop_disctimeout_val = 120;
+
 static const struct generic_data bluetooth_setprop_disctimeout_success_test = {
 	.expected_hal_callbacks = { ADAPTER_PROP_DISC_TIMEOUT, ADAPTER_TEST_END },
 	.expected_adapter_status = BT_STATUS_SUCCESS,
-- 
1.8.4.2

