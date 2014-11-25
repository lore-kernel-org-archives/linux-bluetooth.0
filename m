Return-Path: <cyrus@holtmann.org>
From: Ruslan Mstoi <ruslan.mstoi@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ruslan Mstoi <ruslan.mstoi@linux.intel.com>
Subject: [PATCH] android/pts: PTS tests for ScPP on Android 5.0
Date: Tue, 25 Nov 2014 16:11:19 +0200
Message-Id: <1416924679-10396-1-git-send-email-ruslan.mstoi@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-scpp.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/pts-scpp.txt b/android/pts-scpp.txt
index 30485ef..a7c65a2 100644
--- a/android/pts-scpp.txt
+++ b/android/pts-scpp.txt
@@ -1,8 +1,8 @@
 PTS test results for ScPP
 
 PTS version: 5.3
-Tested: 21-October-2014
-Android version: 4.4.4
+Tested: 25-November-2014
+Android version: 5.0
 
 Results:
 PASS	test passed
@@ -18,7 +18,7 @@ TC_SPDS_SC_BV_01_I	PASS	PTS issue #12119
 TC_SPDC_SC_BV_01_I	PASS	PTS issue #12119
 TC_SPDC_SC_BV_02_I	PASS	PTS issue #12119
 TC_SPDC_SC_BV_03_I	PASS	PTS issue #12119
-TC_SPWF_SC_BV_03_I	PASS	PTS issue #12119
-TC_SPCF_SC_BV_03_I	PASS	PTS issue #12119
-TC_SPNF_SC_BV_03_I	PASS	PTS issue #12119
+TC_SPWF_SC_BV_01_I	PASS	PTS issue #12119
+TC_SPCF_SC_BV_01_I	PASS	PTS issue #12119
+TC_SPNF_SC_BV_01_I	PASS	PTS issue #12119
 -------------------------------------------------------------------------------
-- 
1.9.1

