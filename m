Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android/tester: Update expected adapter properties
Date: Fri, 13 Dec 2013 09:05:05 +0100
Message-ID: <1386921905-28047-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1386921905-28047-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1386921905-28047-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth daemon supports now BT_PROPERTY_ADAPTER_BONDED_DEVICES and
BT_PROPERTY_TYPE_OF_DEVICE. Android tester needs to be updated with this
expected properties. Test result with this patch:

Test Summary
------------
Test Init                                     Passed       0.026 seconds
Test Enable - Success                         Passed       0.027 seconds
Test Enable - Done                            Passed       0.030 seconds
Test Disable - Success                        Passed       0.036 seconds
Test Socket Init                              Passed       0.020 seconds
Test Socket Listen - Invalid sock type        Passed       0.088 seconds
Test Socket Listen - Invalid: L2CAP           Passed       0.025 seconds

Total: 7, Passed: 7 (100.0%), Failed: 0, Not Run: 0
---
 android/android-tester.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 16ddcc4..fbcbb27 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -38,7 +38,8 @@
 
 #define adapter_props adapter_prop_bdaddr, adapter_prop_bdname, \
 			adapter_prop_uuids, adapter_prop_cod, \
-			adapter_prop_scan_mode, adapter_prop_disc_timeout
+			adapter_prop_tod, adapter_prop_scan_mode, \
+			adapter_prop_bonded_devices, adapter_prop_disc_timeout
 
 /*
  * those are assigned to HAL methods and callbacks, we use ID later
-- 
1.8.4

