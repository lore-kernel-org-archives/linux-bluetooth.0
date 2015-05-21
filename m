Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update AVRCP test results
Date: Thu, 21 May 2015 17:26:52 +0200
Message-Id: <1432222012-17792-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-avrcp.txt  |  4 +--
 android/pixit-avrcp.txt |  2 +-
 android/pts-avrcp.txt   | 68 +++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
index a25579e..7bd68fa 100644
--- a/android/pics-avrcp.txt
+++ b/android/pics-avrcp.txt
@@ -1,6 +1,6 @@
 AVRCP PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -12,7 +12,7 @@ O - optional
 -------------------------------------------------------------------------------
 Parameter Name    Selected	Description
 -------------------------------------------------------------------------------
-SPC_AVRCP_1_1     True (*)	Role: Controller (CT) (C.1)
+TSPC_AVRCP_1_1    True (*)	Role: Controller (CT) (C.1)
 TSPC_AVRCP_1_2    True (*)	Role: Target (TG) (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support at least one of the defined roles.
diff --git a/android/pixit-avrcp.txt b/android/pixit-avrcp.txt
index c429828..9d5b87e 100644
--- a/android/pixit-avrcp.txt
+++ b/android/pixit-avrcp.txt
@@ -1,6 +1,6 @@
 AVRCP PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
index 955b37e..b7e1386 100644
--- a/android/pts-avrcp.txt
+++ b/android/pts-avrcp.txt
@@ -1,8 +1,8 @@
 PTS test results for AVRCP
 
-PTS version: 6.0
-Tested: 21-January-2015
-Android version: 5.0
+PTS version: 6.1
+Tested: 21-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
@@ -16,6 +16,19 @@ Test Name		Result	Notes
 -------------------------------------------------------------------------------
 TC_CT_BGN_BV_01_I	N/A
 TC_CT_BGN_BV_02_I	N/A
+TC_CT_CA_BV_01_C	N/A
+TC_CT_CA_BV_03_C	N/A
+TC_CT_CA_BV_05_C	N/A
+TC_CT_CA_BV_07_C	N/A
+TC_CT_CA_BV_09_C	N/A
+TC_CT_CA_BV_11_C	N/A
+TC_CT_CA_BV_13_C	N/A
+TC_CT_CA_BV_15_C	N/A
+TC_CT_CA_BV_17_C	N/A
+TC_CT_CA_BV_18_C	N/A
+TC_CT_CA_BV_01_I	N/A
+TC_CT_CA_BV_02_I	N/A
+TC_CT_CA_BV_03_I	N/A
 TC_CT_CEC_BV_01_I	N/A
 TC_CT_CEC_BV_02_I	N/A
 TC_CT_CFG_BV_01_C	N/A
@@ -26,41 +39,44 @@ TC_CT_CRC_BV_02_I	N/A
 TC_CT_ICC_BV_01_I	N/A
 TC_CT_ICC_BV_02_I	N/A
 TC_CT_MCN_CB_BV_01_C	N/A
+TC_CT_MCN_CB_BV_04_C	N/A
+TC_CT_MCN_CB_BV_07_C	N/A
+TC_CT_MCN_CB_BV_12_C	N/A
 TC_CT_MCN_CB_BV_01_I	N/A
 TC_CT_MCN_CB_BV_02_I	N/A
 TC_CT_MCN_CB_BV_03_I	N/A
-TC_CT_MCN_CB_BV_04_C	N/A
 TC_CT_MCN_CB_BV_04_I	N/A
 TC_CT_MCN_CB_BV_05_I	N/A
 TC_CT_MCN_CB_BV_06_I	N/A
-TC_CT_MCN_CB_BV_07_C	N/A
-TC_CT_MCN_CB_BV_07_I	N/A
 TC_CT_MCN_NP_BV_01_C	N/A
+TC_CT_MCN_NP_BV_03_C	N/A
+TC_CT_MCN_NP_BV_05_C	N/A
+TC_CT_MCN_NP_BV_08_C	N/A
+TC_CT_MCN_NP_BV_10_C	N/A
 TC_CT_MCN_NP_BV_01_I	N/A
 TC_CT_MCN_NP_BV_02_I	N/A
-TC_CT_MCN_NP_BV_03_C	N/A
 TC_CT_MCN_NP_BV_03_I	N/A
 TC_CT_MCN_NP_BV_04_I	N/A
-TC_CT_MCN_NP_BV_05_C	N/A
 TC_CT_MCN_NP_BV_05_I	N/A
 TC_CT_MCN_NP_BV_06_I	N/A
 TC_CT_MCN_NP_BV_07_I	N/A
-TC_CT_MCN_NP_BV_08_C	N/A
 TC_CT_MCN_SRC_BV_01_C	N/A
+TC_CT_MCN_SRC_BV_03_C	N/A
+TC_CT_MCN_SRC_BV_05_C	N/A
+TC_CT_MCN_SRC_BV_07_C	N/A
 TC_CT_MCN_SRC_BV_01_I	N/A
 TC_CT_MCN_SRC_BV_02_I	N/A
-TC_CT_MCN_SRC_BV_03_C	N/A
 TC_CT_MCN_SRC_BV_03_I	N/A
 TC_CT_MCN_SRC_BV_04_I	N/A
-TC_CT_MCN_SRC_BV_05_C	N/A
 TC_CT_MDI_BV_01_C	N/A
 TC_CT_MDI_BV_03_C	N/A
 TC_CT_MPS_BV_01_C	N/A
+TC_CT_MPS_BV_03_C	N/A
+TC_CT_MPS_BV_08_C	N/A
+TC_CT_MPS_BV_11_C	N/A
 TC_CT_MPS_BV_01_I	N/A
 TC_CT_MPS_BV_02_I	N/A
-TC_CT_MPS_BV_03_C	N/A
 TC_CT_MPS_BV_03_I	N/A
-TC_CT_MPS_BV_08_C	N/A
 TC_CT_NFY_BV_01_C	N/A
 TC_CT_PAS_BV_01_C	N/A
 TC_CT_PAS_BV_03_C	N/A
@@ -97,6 +113,27 @@ Test Name		Result	Notes
 -------------------------------------------------------------------------------
 TC_TG_BGN_BV_01_I	N/A
 TC_TG_BGN_BV_02_I	N/A
+TC_TG_CA_BI_01_C	N/A
+TC_TG_CA_BI_02_C	N/A
+TC_TG_CA_BI_03_C	N/A
+TC_TG_CA_BI_04_C	N/A
+TC_TG_CA_BI_05_C	N/A
+TC_TG_CA_BI_06_C	N/A
+TC_TG_CA_BI_07_C	N/A
+TC_TG_CA_BI_08_C	N/A
+TC_TG_CA_BI_09_C	N/A
+TC_TG_CA_BI_10_C	N/A
+TC_TG_CA_BV_02_C	N/A
+TC_TG_CA_BV_04_C	N/A
+TC_TG_CA_BV_06_C	N/A
+TC_TG_CA_BV_08_C	N/A
+TC_TG_CA_BV_10_C	N/A
+TC_TG_CA_BV_12_C	N/A
+TC_TG_CA_BV_14_C	N/A
+TC_TG_CA_BV_16_C	N/A
+TC_TG_CA_BV_01_I	N/A
+TC_TG_CA_BV_02_I	N/A
+TC_TG_CA_BV_03_I	N/A
 TC_TG_CEC_BV_01_I	PASS
 TC_TG_CEC_BV_02_I	PASS
 TC_TG_CFG_BI_01_C	PASS
@@ -115,7 +152,6 @@ TC_TG_MCN_CB_BI_02_C	N/A
 TC_TG_MCN_CB_BI_03_C	N/A
 TC_TG_MCN_CB_BI_04_C	N/A
 TC_TG_MCN_CB_BI_05_C	N/A
-TC_TG_MCN_CB_BV_01_I	N/A
 TC_TG_MCN_CB_BV_02_C	N/A
 TC_TG_MCN_CB_BV_02_I	N/A
 TC_TG_MCN_CB_BV_03_C	N/A
@@ -130,6 +166,7 @@ TC_TG_MCN_CB_BV_08_C	N/A
 TC_TG_MCN_CB_BV_09_C	N/A
 TC_TG_MCN_CB_BV_10_C	N/A
 TC_TG_MCN_CB_BV_11_C	N/A
+TC_TG_MCN_CB_BV_13_C	N/A
 TC_TG_MCN_NP_BI_01_C	N/A
 TC_TG_MCN_NP_BI_02_C	N/A
 TC_TG_MCN_NP_BV_01_I	N/A
@@ -144,6 +181,7 @@ TC_TG_MCN_NP_BV_06_I	N/A
 TC_TG_MCN_NP_BV_07_C	N/A
 TC_TG_MCN_NP_BV_07_I	N/A
 TC_TG_MCN_NP_BV_09_C	N/A
+TC_TG_MCN_NP_BV_11_C	N/A
 TC_TG_MCN_SRC_BV_01_I	N/A
 TC_TG_MCN_SRC_BV_02_C	N/A
 TC_TG_MCN_SRC_BV_02_I	N/A
@@ -151,6 +189,7 @@ TC_TG_MCN_SRC_BV_03_I	N/A
 TC_TG_MCN_SRC_BV_04_C	N/A
 TC_TG_MCN_SRC_BV_04_I	N/A
 TC_TG_MCN_SRC_BV_06_C	N/A
+TC_TG_MCN_SRC_BV_08_C	N/A
 TC_TG_MDI_BV_02_C	PASS
 TC_TG_MDI_BV_04_C	PASS
 TC_TG_MDI_BV_05_C	PASS
@@ -166,6 +205,7 @@ TC_TG_MPS_BV_06_C	N/A
 TC_TG_MPS_BV_07_C	N/A
 TC_TG_MPS_BV_09_C	N/A
 TC_TG_MPS_BV_10_C	N/A
+TC_TG_MPS_BV_12_C	N/A
 TC_TG_NFY_BI_01_C	PASS
 TC_TG_NFY_BV_02_C	PASS	Change track when requested
 TC_TG_NFY_BV_03_C	N/A
-- 
1.9.1

