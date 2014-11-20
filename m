Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: PTS tests for AVRCP on Android 5.0
Date: Thu, 20 Nov 2014 15:19:09 +0100
Message-Id: <1416493149-28242-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-avrcp.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
index c8aeeca..e6711ed 100644
--- a/android/pts-avrcp.txt
+++ b/android/pts-avrcp.txt
@@ -1,8 +1,8 @@
 PTS test results for AVRCP
 
 PTS version: 5.3
-Tested: 08-October-2014
-Android version: 4.4.4
+Tested: 20-November-2014
+Android version: 5.0
 
 Results:
 PASS	test passed
@@ -188,7 +188,7 @@ TC_TG_PTT_BV_02_I	PASS
 TC_TG_PTT_BV_03_I	N/A
 TC_TG_PTT_BV_04_I	N/A
 TC_TG_PTT_BV_05_I	N/A
-TC_TG_RCR_BV_02_C	PASS
+TC_TG_RCR_BV_02_C	PASS	One can use: lame --ta/tl for creating metadata
 TC_TG_RCR_BV_04_C	PASS
 TC_TG_VLH_BI_01_C	N/A
 TC_TG_VLH_BI_02_C	N/A
-- 
1.8.5.3

