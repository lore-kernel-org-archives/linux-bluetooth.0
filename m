Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianchlad@gmail.com>
Subject: [PATCH] android/pts: Add PTS test results for A2DP
Date: Fri, 24 Jan 2014 15:24:49 -0500
Message-Id: <1390595089-5314-1-git-send-email-sebastianchlad@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-a2dp.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
index a269ec1..c6eee62 100644
--- a/android/pts-a2dp.txt
+++ b/android/pts-a2dp.txt
@@ -1,7 +1,7 @@
 PTS test results for A2DP
 
 PTS version: 5.0
-Tested: --not yet tested--
+Tested: 24.01.2014
 
 Results:
 PASS	test passed
@@ -15,17 +15,17 @@ Test Name		Result	Notes
 -------------------------------------------------------------------------------
 TC_SRC_CC_BV_09_I	INC
 TC_SRC_CC_BV_10_I	N/A
-TC_SRC_REL_BV_01_I	INC
-TC_SRC_REL_BV_02_I	INC
-TC_SRC_SET_BV_01_I	INC
-TC_SRC_SET_BV_02_I	INC
-TC_SRC_SET_BV_03_I	INC
+TC_SRC_REL_BV_01_I	PASS
+TC_SRC_REL_BV_02_I	PASS
+TC_SRC_SET_BV_01_I	PASS
+TC_SRC_SET_BV_02_I	PASS
+TC_SRC_SET_BV_03_I	PASS
 TC_SRC_SET_BV_04_I	INC
 TC_SRC_SET_BV_05_I	INC
 TC_SRC_SET_BV_06_I	INC
 TC_SRC_SUS_BV_01_I	INC
 TC_SRC_SUS_BV_02_I	INC
-TC_SRC_SDP_BV_01_I	INC
+TC_SRC_SDP_BV_01_I	PASS
 TC_SRC_AS_BV_01_I	INC
 -------------------------------------------------------------------------------
 
-- 
1.8.5.3

