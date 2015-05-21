Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update A2DP test results
Date: Thu, 21 May 2015 13:29:10 +0200
Message-Id: <1432207750-10157-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-a2dp.txt  | 10 +++++-----
 android/pixit-a2dp.txt |  2 +-
 android/pts-a2dp.txt   | 31 +++++++++++++++++++------------
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/android/pics-a2dp.txt b/android/pics-a2dp.txt
index 1328e7e..2e87104 100644
--- a/android/pics-a2dp.txt
+++ b/android/pics-a2dp.txt
@@ -1,6 +1,6 @@
 A2DP PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -76,8 +76,8 @@ TSPC_A2DP_3_6	False		SRC: MPEG-2,4 AAC encoder (C.1)
 TSPC_A2DP_3_7	False		SRC: ATRAC family decoder (C.1)
 TSPC_A2DP_3_8	False		SRC: ATRAC family encoder (C.1)
 -------------------------------------------------------------------------------
-C.1: At least one of the implementations shall be supported if 12/2 (Optional
-	codec) is supported, else excluded.
+C.1: At least one of the implementations shall be supported if 3/2
+	is supported, else excluded.
 -------------------------------------------------------------------------------
 
 
@@ -138,8 +138,8 @@ TSPC_A2DP_5_3	False		SNK: MPEG-1,2 Audio (C.1)
 TSPC_A2DP_5_4	False		SNK: MPEG-2,4 AAC (C.1)
 TSPC_A2DP_5_5	False		SNK: ATRAC family (C.1)
 -------------------------------------------------------------------------------
-C.1: At least one codec shall be supported if Table 13/2 (Optional codec
-	decoder) is supported, otherwise excluded.
+C.1: At least one codec shall be supported if Table 5/2 is supported, otherwise
+	excluded.
 -------------------------------------------------------------------------------
 
 
diff --git a/android/pixit-a2dp.txt b/android/pixit-a2dp.txt
index b6ef742..c7f9762 100644
--- a/android/pixit-a2dp.txt
+++ b/android/pixit-a2dp.txt
@@ -1,6 +1,6 @@
 A2DP PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
index 500c631..79bd348 100644
--- a/android/pts-a2dp.txt
+++ b/android/pts-a2dp.txt
@@ -1,8 +1,8 @@
 PTS test results for A2DP
 
-PTS version: 6.0
-Tested: 14-January-2015
-Android version: 5.0
+PTS version: 6.1
+Tested 21-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
@@ -15,24 +15,29 @@ N/A	test is disabled due to PICS setup
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
 TC_SRC_CC_BV_09_I	PASS	Start streaming
-TC_SRC_CC_BV_10_I	PASS
-TC_SRC_REL_BV_01_I	PASS	Connect to PTS from IUT. When requested
-				disconnect from IUT
-TC_SRC_REL_BV_02_I	PASS
-TC_SRC_SET_BV_01_I	PASS	Connect to PTS (open a2dp)
+TC_SRC_CC_BV_10_I	PASS	Start streaming
+TC_SRC_REL_BV_01_I	PASS	When requested disconnect from IUT
+TC_SRC_REL_BV_02_I	PASS	Start streaming
+TC_SRC_SET_BV_01_I	PASS
 TC_SRC_SET_BV_02_I	PASS
 TC_SRC_SET_BV_03_I	PASS	Start streaming
 TC_SRC_SET_BV_04_I	PASS	Start streaming
-TC_SRC_SET_BV_05_I	PASS	IUT must be moved out of range
-				JIRA issue BA-314
+TC_SRC_SET_BV_05_I	PASS	Start streaming
+				IUT must be moved out of range
+				Initiate connection
 TC_SRC_SET_BV_06_I	PASS	IUT must be moved out of range
-TC_SRC_SUS_BV_01_I	PASS	Stop streaming
-TC_SRC_SUS_BV_02_I	PASS
+				PTS issue#13469
+				To pass set TSPX_no_avrcp to TRUE
+TC_SRC_SUS_BV_01_I	PASS	Start streaming
+				Stop streaming
+				Start streaming
+TC_SRC_SUS_BV_02_I	PASS	Start streaming
 TC_SRC_SDP_BV_01_I	PASS
 TC_SRC_AS_BV_01_I	PASS	Requires checking if the output on the IUT is
 				correct
 TC_SRC_AS_BV_02_I	N/A
 TC_SRC_AS_BV_03_I	N/A
+TC_SRC_SYN_BV_02_I	N/A
 -------------------------------------------------------------------------------
 
 
@@ -60,4 +65,6 @@ TC_SNK_SUS_BV_01_I	N/A
 TC_SNK_SUS_BV_02_I	N/A
 TC_SNK_SDP_BV_02_I	N/A
 TC_SNK_AS_BV_01_I	N/A
+TC_SNK_AS_BV_02_I	N/A
+TC_SNK_SYN_BV_01_I	N/A
 -------------------------------------------------------------------------------
-- 
1.9.1

