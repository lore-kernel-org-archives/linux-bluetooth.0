Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] android/tester: Correct bdname set test case struc conditions
Date: Mon, 23 Dec 2013 12:50:28 +0100
Message-Id: <1387799429-6674-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387799429-6674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387799429-6674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch correct struct elements initialization. Now test name is
declared as variable before test case struct and its size is calculated
using sizeof(), not by hard coded number.
---
 android/android-tester.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 547488e..77dfa89 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -712,12 +712,14 @@ static const struct generic_data bluetooth_disable_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS
 };
 
+static char test_set_bdname[] = "test_bdname_set";
+
 static const struct generic_data bluetooth_setprop_bdname_success_test = {
 	.expected_hal_callbacks = { ADAPTER_PROP_BDNAME, ADAPTER_TEST_END },
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_BDNAME,
-	.expected_property.val = "test_bdname",
-	.expected_property.len = 11
+	.expected_property.val = test_set_bdname,
+	.expected_property.len = sizeof(test_set_bdname) - 1
 };
 
 static bt_scan_mode_t test_setprop_scanmode_val =
-- 
1.8.4.2

