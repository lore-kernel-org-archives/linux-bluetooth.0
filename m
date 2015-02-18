Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 2/2] android/hfp: Update HFP test results for PTS 6.0
Date: Wed, 18 Feb 2015 18:45:47 +0100
Message-Id: <1424281547-4454-2-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1424281547-4454-1-git-send-email-mariusz.skamra@tieto.com>
References: <1424281547-4454-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-hfp.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/pts-hfp.txt b/android/pts-hfp.txt
index 3fcb645..ed17afe 100644
--- a/android/pts-hfp.txt
+++ b/android/pts-hfp.txt
@@ -1,7 +1,7 @@
 PTS test results for HFP
 
-PTS version: 5.3
-Tested: 02-December-2014
+PTS version: 6.0
+Tested: 16-February-2015
 Android version: 5.0
 
 Results:
@@ -55,7 +55,7 @@ TC_AG_OCM_BV_01_I	PASS
 TC_AG_OCM_BV_02_I	PASS
 TC_AG_OCL_BV_01_I	PASS
 TC_AG_OCL_BV_02_I	PASS
-TC_AG_TWC_BV_01_I	PASS	JIRA #BA-281
+TC_AG_TWC_BV_01_I	PASS
 TC_AG_TWC_BV_02_I	PASS
 TC_AG_TWC_BV_03_I	PASS
 TC_AG_TWC_BV_04_I	PASS
@@ -101,10 +101,10 @@ TC_AG_SLC_BV_06_I	PASS
 TC_AG_SLC_BV_07_I	PASS
 TC_AG_SLC_BV_09_I	N/A
 TC_AG_SLC_BV_10_I	N/A
-TC_AG_ACC_BV_08_I	PASS	PTS issue #12039
+TC_AG_ACC_BV_08_I	PASS
 TC_AG_ACC_BV_09_I	PASS
-TC_AG_ACC_BV_10_I	PASS	PTS issue #12039
-TC_AG_ACC_BV_11_I	PASS	PTS issue #12039
+TC_AG_ACC_BV_10_I	PASS
+TC_AG_ACC_BV_11_I	PASS
 TC_AG_ACC_BI_12_I	PASS
 TC_AG_ACC_BI_13_I	PASS
 TC_AG_ACC_BI_14_I	PASS
-- 
1.9.1

