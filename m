Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH v2] android/pts: PTS tests for MAP on Android 5
Date: Tue, 18 Nov 2014 18:19:47 +0100
Message-Id: <1416331187-12084-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-map.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/android/pts-map.txt b/android/pts-map.txt
index 57cb317..e8092e2 100644
--- a/android/pts-map.txt
+++ b/android/pts-map.txt
@@ -1,8 +1,8 @@
 PTS test results for MAP
 
 PTS version: 5.3
-Tested: 15-October-2014
-Android version: 4.4.4
+Tested: 18-November-2014
+Android version: 5.0
 
 Results:
 PASS	test passed
@@ -69,8 +69,7 @@ TC_MSE_MMB_BV_18_I	N/A
 TC_MSE_MMB_BV_13_I	PASS
 TC_MSE_MMB_BV_14_I	PASS
 TC_MSE_MMB_BV_15_I	PASS
-TC_MSE_MMB_BV_16_I	PASS	Android MAP server bug, fix provided at
-				android-review.googlesource.com/#/c/82757
+TC_MSE_MMB_BV_16_I	PASS
 TC_MSE_MMD_BV_02_I	PASS
 TC_MSE_MMU_BV_02_I	PASS	At least one SMS must be present in inbox
 TC_MSE_MMU_BV_03_I	PASS
-- 
1.8.5.3

