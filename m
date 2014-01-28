Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/pts: PTS test results for A2DP
Date: Tue, 28 Jan 2014 14:11:23 +0200
Message-Id: <1390911083-6188-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-a2dp.txt | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
index c6eee62..67f9183 100644
--- a/android/pts-a2dp.txt
+++ b/android/pts-a2dp.txt
@@ -1,7 +1,7 @@
 PTS test results for A2DP
 
 PTS version: 5.0
-Tested: 24.01.2014
+Tested: 28.01.2014
 
 Results:
 PASS	test passed
@@ -15,18 +15,20 @@ Test Name		Result	Notes
 -------------------------------------------------------------------------------
 TC_SRC_CC_BV_09_I	INC
 TC_SRC_CC_BV_10_I	N/A
-TC_SRC_REL_BV_01_I	PASS
+TC_SRC_REL_BV_01_I	PASS	Connect to PTS from IUT. When requested
+					disconnect from IUT
 TC_SRC_REL_BV_02_I	PASS
-TC_SRC_SET_BV_01_I	PASS
+TC_SRC_SET_BV_01_I	PASS	Connect to PTS (open a2dp)
 TC_SRC_SET_BV_02_I	PASS
-TC_SRC_SET_BV_03_I	PASS
-TC_SRC_SET_BV_04_I	INC
-TC_SRC_SET_BV_05_I	INC
-TC_SRC_SET_BV_06_I	INC
-TC_SRC_SUS_BV_01_I	INC
+TC_SRC_SET_BV_03_I	PASS	Start streaming
+TC_SRC_SET_BV_04_I	INC	Start streaming
+TC_SRC_SET_BV_05_I	INC	IUT must be moved out of range
+TC_SRC_SET_BV_06_I	INC	IUT must be moved out of range
+TC_SRC_SUS_BV_01_I	PASS	Stop streaming
 TC_SRC_SUS_BV_02_I	INC
 TC_SRC_SDP_BV_01_I	PASS
-TC_SRC_AS_BV_01_I	INC
+TC_SRC_AS_BV_01_I	PASS	Requires checking if the output on the IUT is
+					correct
 -------------------------------------------------------------------------------
 
 
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

