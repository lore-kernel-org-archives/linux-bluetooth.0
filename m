Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2] android/pts: Update MPS test results
Date: Fri, 22 May 2015 08:39:39 +0200
Message-Id: <1432276779-15632-1-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1432135835-9270-1-git-send-email-mariusz.skamra@tieto.com>
References: <1432135835-9270-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-mps.txt  | 82 +++++++++++++++++++++++++--------------------------
 android/pixit-mps.txt |  2 +-
 android/pts-mps.txt   | 10 +++----
 3 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/android/pics-mps.txt b/android/pics-mps.txt
index 29b82a9..5aad7c1 100644
--- a/android/pics-mps.txt
+++ b/android/pics-mps.txt
@@ -1,6 +1,6 @@
 MPS PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -219,36 +219,34 @@ TSPC_MPS_6_37	True (*)	A2DP-SRC_PBAP-Server Implementation Phonebook
 TSPC_MPS_6_38	False		A2DP-SNK and PBAP-Client Implementation
 				Phonebook Download during Audio Streaming (C.12)
 TSPC_MPS_6_39	True (*)	HFP-AG and PBAP-Server Implementation PBAP and
-				HFP Connection Behavior (C.13)
--------------------------------------------------------------------------------
-C.1: Mandatory if 2/1 (A2DP Source role), 2/4 (AVRCP Target role) and 2/7
-	(HFP Audio Gateway role) are supported, otherwise Excluded.
-C.2: Mandatory if 2/2 (A2DP Sink role), 2/3 (AVRCP Controller role) and 2/8
-	(HFP Hands-Free role) are supported, otherwise Excluded.
-C.3: Mandatory if 2/5 (DUN Gateway role) and 2/7 (HFP Audio Gateway role)
-	are supported and 3/9 ( Ability to support parallel data and call
-	operation), otherwise Excluded.
-C.4: Mandatory if 2/6 (DUN Data Terminal role) and 2/8 (HFP Hands-Free role)
-	are supported, otherwise Excluded.
-C.5: Mandatory if 2/1 (A2DP Source role) and 2/5 (DUN Gateway role) are
-	supported, otherwise Excluded.
-C.6: Mandatory if 2/2 (A2DP Sink role) and 2/6 (DUN Data Terminal role) are
-	supported, otherwise Excluded.
-C.7: Mandatory if 2/7 (HFP Audio Gateway role) and 2/9 (PAN Network Access Point
-	role) and 3/11 (Ability to support parallel data and call operation) are
-	supported, otherwise Excluded.
-C.8: Mandatory if 2/8 (HFP Hands-Free role) and 2/11 (PAN User role) are
-	supported and 3/11, otherwise Excluded.
-C.9: Mandatory if 2/1 (A2DP Source role) and 2/9 (PAN Network Access Point role)
-	are supported, otherwise Excluded.
-C.10: Mandatory if 2/2 (A2DP Sink role) and 2/11 (PAN User role) are supported,
+				HFP Connection Behaviour (C.13)
+-------------------------------------------------------------------------------
+C.1: Mandatory if TSPC_MPS_2_1, TSPC_MPS_2_4 and TSPC_MPS_2_7 are supported,
 	otherwise Excluded.
-C.11: Mandatory if 2/1 (A2DP Source role) and 2/13 (PBAP PSE role) are
-	supported, otherwise Excluded.
-C.12: Mandatory if 2/2 (A2DP Sink role) and 2/12 (PBAP PCE role) are supported,
+C.2: Mandatory if TSPC_MPS_2_2, TSPC_MPS_2_3 and TSPC_MPS_2_8 are supported,
+	otherwise Excluded.
+C.3: Mandatory if TSPC_MPS_2_5 and TSPC_MPS_2_7 are supported and TSPC_MPS_3_9,
 	otherwise Excluded.
-C.13: Mandatory if 2/7 (HFP Audio Gateway role) and 2/13 (PBAP PSE role) are
+C.4: Mandatory if TSPC_MPS_2_6 and TSPC_MPS_2_8 are supported, otherwise
+	Excluded.
+C.5: Mandatory if TSPC_MPS_2_1 and TSPC_MPS_2_5 are supported, otherwise
+	Excluded.
+C.6: Mandatory if TSPC_MPS_2_2 and TSPC_MPS_2_6 are supported, otherwise
+	Excluded.
+C.7: Mandatory if TSPC_MPS_2_7 and TSPC_MPS_2_9 and TSPC_MPS_3_11 are
 	supported, otherwise Excluded.
+C.8: Mandatory if TSPC_MPS_2_8 and TSPC_MPS_2_11 are supported and
+	TSPC_MPS_3_11, otherwise Excluded.
+C.9: Mandatory if TSPC_MPS_2_1 and TSPC_MPS_2_9 are supported, otherwise
+	Excluded.
+C.10: Mandatory if TSPC_MPS_2_2 and TSPC_MPS_2_11 are supported, otherwise
+	Excluded.
+C.11: Mandatory if TSPC_MPS_2_1 and TSPC_MPS_2_13 are supported, otherwise
+	Excluded.
+C.12: Mandatory if TSPC_MPS_2_2 and TSPC_MPS_2_12 are supported, otherwise
+	Excluded.
+C.13: Mandatory if TSPC_MPS_2_7 and TSPC_MPS_2_13 are supported, otherwise
+	Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -293,12 +291,12 @@ TSPC_MPS_7_14	False		A2DP-SNK and AVRCP-CT and DUN-DT Implementation
 				Start Packet Data Communication during Audio
 				Streaming (C.3)
 -------------------------------------------------------------------------------
-C.1: Mandatory if 2/2 (A2DP Sink role), 2/3 (AVRCP Controller role) and 2/8
-	(HFP Hands-Free role) are supported, otherwise Excluded.
-C.2: Mandatory if 2/1 (A2DP Source role) and 2/4 (AVRCP Target role) are
-	supported, otherwise Excluded.
-C.3: Mandatory if 2/2 (A2DP Sink role), 2/3 (AVRCP Controller role) and 2/6
-	(DUN Data Terminal role) supported, otherwise Excluded.
+C.1: Mandatory if TSPC_MPS_2_2, TSPC_MPS_2_3 and TSPC_MPS_2_8 are supported,
+	otherwise Excluded.
+C.2: Mandatory if TSPC_MPS_2_1 and TSPC_MPS_2_4 are supported, otherwise
+	Excluded.
+C.3: Mandatory if TSPC_MPS_2_2, TSPC_MPS_2_3 and 2/6TSPC_MPS_2_6 supported,
+	otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -307,12 +305,12 @@ C.3: Mandatory if 2/2 (A2DP Sink role), 2/3 (AVRCP Controller role) and 2/6
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_MPS_8_1	True (*)	AVP Suspension (C.1)
-TSPC_MPS_8_2	True (*)	Profile (Dis-)Connection behavior (C.2)
+TSPC_MPS_8_2	True (*)	Profile (Dis-)Connection behaviour (C.2)
 -------------------------------------------------------------------------------
-C.1: Mandatory if 1/1 (A2DP 1.2 or later) and 1/2 (AVRCP 1.3 or later) are
-	supported, otherwise Excluded.
-C.2: Mandatory if 1/1 (A2DP 1.2 or later), 1/2 (AVRCP 1.3 or later) and 1/4 (HFP
-	1.5 or later) are supported, otherwise Excluded.
+C.1: Mandatory if TSPC_MPS_1_1 and TSPC_MPS_1_2 are supported, otherwise
+	Excluded.
+C.2: Mandatory if TSPC_MPS_1_1, TSPC_MPS_1_2 and TSPC_MPS_1_4 are supported,
+	otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -333,7 +331,7 @@ TSPC_MPS_10_1	True		SDP Record (M)
 TSPC_MPS_10_2	True (*)	Media Stream Suspension (C.1)
 TSPC_MPS_10_3	True (*)	Sniff Mode during Streaming (C.2)
 -------------------------------------------------------------------------------
-C.1: Mandatory if 1/1 (A2DP1.2 or later) and 1/4 (HFP 1.5 or later) are
-	supported, otherwise Excluded.
-C.2: Mandatory if 1/1 (A2DP 1.2 or later) is supported, otherwise Excluded.
+C.1: Mandatory if TSPC_MPS_1_1 and TSPC_MPS_1_4 are supported, otherwise
+	Excluded.
+C.2: Mandatory if TSPC_MPS_1_1 is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
diff --git a/android/pixit-mps.txt b/android/pixit-mps.txt
index 86511bd..116a8c0 100644
--- a/android/pixit-mps.txt
+++ b/android/pixit-mps.txt
@@ -1,6 +1,6 @@
 MPS PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-mps.txt b/android/pts-mps.txt
index b1096e6..87a0e45 100644
--- a/android/pts-mps.txt
+++ b/android/pts-mps.txt
@@ -1,8 +1,8 @@
 PTS test results for MPS
 
-PTS version: 6.0
-Tested: 11-December-2014
-Android version: 5.0
+PTS version: 6.1
+Tested: 20-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
@@ -19,7 +19,7 @@ For full tests conformance, "Touch sounds" on IUT should be disabled
 Test Name				Result	Notes
 -------------------------------------------------------------------------------
 TC_AG_PSE_HFPB_CTH_SD_BV_01_I		PASS
-TC_AG_SRC_HFAV_ACT_SD_BV_01_I		PASS	PTS issue #13138
+TC_AG_SRC_HFAV_ACT_SD_BV_01_I		PASS
 TC_AG_SRC_HFAV_ACT_SD_BV_02_I		PASS
 TC_AG_SRC_HFAV_ACT_SD_BV_03_I		PASS
 TC_AG_SRC_HFAV_CLH_SD_BV_01_I		PASS
@@ -27,7 +27,7 @@ TC_AG_SRC_HFAV_CLH_SD_BV_02_I		N/A
 TC_AG_SRC_HFAV_CLH_SD_BV_03_I		PASS
 TC_AG_SRC_HFAV_CLH_SD_BV_04_I		PASS
 TC_AG_SRC_HFAV_CLH_SD_BV_05_I		PASS
-TC_AG_SRC_HFAV_CLH_SD_BV_06_I		PASS	PTS issue #13138
+TC_AG_SRC_HFAV_CLH_SD_BV_06_I		PASS	PTS issue #13466
 TC_AVP_CTH_SD_BI_01_I			PASS
 TC_AVP_CTH_SD_BI_02_I			PASS
 TC_HF_SNK_HFAV_ACT_SD_BV_01_I		N/A
-- 
1.9.1

