Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Update PTS files for HFP
Date: Fri, 17 Oct 2014 13:51:36 +0200
Message-Id: <1413546696-25699-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PICS and PIXITs updated to PTS 5.3. Regression done for Android
4.4.4.
---
 android/pics-hfp.txt  | 22 ++++++++++++++++++++--
 android/pixit-hfp.txt |  5 ++++-
 android/pts-hfp.txt   | 14 ++++++++------
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/android/pics-hfp.txt b/android/pics-hfp.txt
index acbd25c..65f5112 100644
--- a/android/pics-hfp.txt
+++ b/android/pics-hfp.txt
@@ -1,6 +1,6 @@
 HFP PICS for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -14,6 +14,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HFP_0_1	False		Version: Hands-Free Profile v1.5 (O.1)
 TSPC_HFP_0_2	True (*)	Version: Hands-Free Profile v1.6 (O.1)
+TSPC_HFP_0_3	False		Version: Hands-Free Profile v1.7 (O.1)
 -------------------------------------------------------------------------------
 O.1: It is mandatory to support only one of the adopted versions.
 -------------------------------------------------------------------------------
@@ -83,8 +84,10 @@ TSPC_HFP_2_21c	True (*)	Enhanced Call Status with limited network
 					notification (C.4)
 TSPC_HFP_2_22	False		Support for automatic link loss recovery (O)
 TSPC_HFP_2_23	True (*)	Individual Indicator Activation (C.9)
-TSPC_HFP_2_24	True (*)s	Wide Band Speech service (C.8)
+TSPC_HFP_2_24	True (*)	Wide Band Speech service (C.8)
 TSPC_HFP_2_25	False		Support roaming function (O)
+TSPC_HFP_2_26	False		HF Indicators (C.11)
+TSPC_HFP_2_27	False		Support CVSD eSCO s4 setting (C.12)
 -------------------------------------------------------------------------------
 C.1:  The AG must support one of item TSPC_HFP_2_4a or TSPC_HFP_2_4b
 C.2:  Mandatory if TSPC_HFP_2_12is TRUE; otherwise excluded
@@ -96,6 +99,10 @@ C.7:  Mandatory if TSPC_HFP_2_24 otherwise excluded
 C.8:  Excluded if TSPC_HFP_0_1 otherwise optional
 C.9:  Excluded if TSPC_HFP_0_1 otherwise mandatory
 C.10: Mandatory if TSPC_HFP_2_24 otherwise optional
+C.11: Optional IF HFP v1.5 (TSPC_HFP_0_1) OR HFP v1.6 (TSPC_HFP_0_2) is NOT
+	supported, otherwise Excluded.
+C.12: Excluded IF HFP v1.5 (TSPC_HFP_0_1) OR HFP v1.6 (TSPC_HFP_0_2) is
+	supported, otherwise Mandatory.
 -------------------------------------------------------------------------------
 
 
@@ -161,6 +168,8 @@ TSPC_HFP_3_21b	False		Enhanced Call Control (C.2)
 TSPC_HFP_3_22	False		Support for automatic link loss recovery (O)
 TSPC_HFP_3_23	False		Individual Indicator Activation (C.6)
 TSPC_HFP_3_24	False		Wide Band Speech service (C.6)
+TSPC_HFP_3_25	False		HF Indicators (C.8)
+TSPC_HFP_3_36	False		Support CVSD eSCO S4 setting (C.9)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_HFP_3_12; otherwise excluded
 C.2: Optional if TSPC_HFP_3_12; otherwise excluded
@@ -169,6 +178,10 @@ C.4: Mandatory if TSPC_HFP_3_18a, otherwise optional
 C.5: Mandatory if TSPC_HFP_3_24 otherwise excluded
 C.6: Excluded if TSPC_HFP_0_1 otherwise optional
 C.7: Mandatory if TSPC_HFP_3_24 otherwise optional
+C.8: Optional IF HFP v1.5 (TSPC_HFP_0_1) OR HFP v1.6 (TSPC_HFP_0_2) is NOT
+	supported, otherwise Excluded.
+C.9: Excluded IF HFP v1.5 (TSPC_HFP_0_1) OR HFP v1.6 (TSPC_HFP_0_2) is
+	supported, otherwise Mandatory.
 -------------------------------------------------------------------------------
 
 
@@ -178,9 +191,14 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HFP_4_1	True		CVSD audio coding over SCO (M)
 TSPC_HFP_4_2	True (*)	mSBC audio coding over eSCO (C.1)
+TSPC_HFP_4_3	True (*)	CVSD audio coding over eSCO (Initiating) (C.2)
+TSPC_HFP_4_2	True (*)	CVSD audio coding over eSCO (Accepting) (C.2)
 -------------------------------------------------------------------------------
 C.1: Mandatory if Wide band speech service is supported TSPC_HFP_2_24 or
 	TSPC_HFP_3_24, otherwise excluded
+C.2: Mandatory IF TPSC_HFP_2_3b (eSCO support in Audio Connection - AG) OR
+	TSPC_HFP_3_3b (eSCO support in Audio Connection - HF); otherwise
+	Excluded.
 -------------------------------------------------------------------------------
 
 
diff --git a/android/pixit-hfp.txt b/android/pixit-hfp.txt
index eaccc75..bf1b7e5 100644
--- a/android/pixit-hfp.txt
+++ b/android/pixit-hfp.txt
@@ -1,6 +1,6 @@
 HFP PIXIT for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -35,4 +35,7 @@ TSPX_no_fail_verdict					FALSE
 TSPX_network_supports_correct_call_and_callstatus	TRUE
 TSPX_secure_simple_pairing_pass_key_confirmation	FALSE
 TSPX_AG_match_tester_BRSF_codec_negotiation_bit		FALSE
+TSPX_HFP_Unsupported_HF_Indicator_1			99
+TSPX_HFP_Supported_HF_Indiccator_1			1
+TSPX_Automation						FALSE
 -------------------------------------------------------------------------------
diff --git a/android/pts-hfp.txt b/android/pts-hfp.txt
index a281d6b..8d75766 100644
--- a/android/pts-hfp.txt
+++ b/android/pts-hfp.txt
@@ -1,7 +1,7 @@
 PTS test results for HFP
 
-PTS version: 5.2
-Tested: 14-Jul-2014
+PTS version: 5.3
+Tested: 16-October-2014
 Android version: 4.4.4
 
 Results:
@@ -28,6 +28,7 @@ TC_AG_ACS_BV_08_I	PASS
 TC_AG_ACS_BV_10_I	N/A
 TC_AG_ACS_BV_11_I	PASS
 TC_AG_ACS_BI_14_I	PASS
+TC_AG_ACS_BI_16_I	N/A
 TC_AG_ACR_BV_01_I	PASS
 TC_AG_ACR_BV_02_I	PASS
 TC_AG_CLI_BV_01_I	PASS
@@ -66,7 +67,7 @@ TC_AG_ENO_BV_02_I	N/A
 TC_AG_VRA_BV_01_I	PASS
 TC_AG_VRA_BV_02_I	PASS
 TC_AG_VRA_BI_01_I	PASS
-TC_AG_VRD_BV_01_I	PASS
+TC_AG_VRD_BV_01_I	N/A
 TC_AG_VTG_BV_01_I	N/A
 TC_AG_TDC_BV_01_I	PASS
 TC_AG_RSV_BV_01_I	PASS
@@ -98,6 +99,8 @@ TC_AG_SLC_BV_04_C	PASS
 TC_AG_SLC_BV_05_I	PASS
 TC_AG_SLC_BV_06_I	PASS
 TC_AG_SLC_BV_07_I	PASS
+TC_AG_SLC_BV_09_I	N/A
+TC_AG_SLC_BV_10_I	N/A
 TC_AG_ACC_BV_08_I	INC	Possible PTS issue #12039
 TC_AG_ACC_BV_09_I	PASS
 TC_AG_ACC_BV_10_I	INC	Possible PTS issue #12039
@@ -120,7 +123,8 @@ TC_AG_IID_BV_04_I	PASS
 TC_AG_IIC_BV_01_I	PASS
 TC_AG_IIC_BV_02_I	PASS
 TC_AG_IIC_BV_03_I	PASS
-
+TC_AG_HFI_BV_02_I	N/A
+TC_AG_HFI_BV_03_I	N/A
 TC_HF_OOR_BV_01_I	N/A
 TC_HF_OOR_BV_02_I	N/A
 TC_HF_TRS_BV_01_I	N/A
@@ -223,7 +227,6 @@ TC_HF_SDP_BV_03_C	N/A
 TC_HF_ATAH_BV_01_I	N/A
 TC_HF_OCA_BV_01_I	N/A
 TC_HF_IIA_BV_04_I	N/A
-
 TC_AG_COD_BV_02_I	PASS
 TC_AG_ATAH_BV_03_I	PASS
 TC_AG_ATA_BV_03_I	PASS
@@ -236,7 +239,6 @@ TC_AG_ICA_BV_09_I	PASS
 TC_AG_VRA_BV_03_I	PASS
 TC_AG_OCA_BV_01_I	PASS
 TC_AG_TCA_BV_06_I	PASS
-
 TC_HF_ATAH_BV_03_I	N/A
 TC_HF_ATA_BV_03_I	N/A
 TC_HF_ATH_BV_09_I	N/A
-- 
1.8.5.3

