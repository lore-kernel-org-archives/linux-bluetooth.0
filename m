Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 2/2] android/pts: Add AVRCP 1.5 PTS tests
Date: Fri,  7 Mar 2014 19:42:47 +0100
Message-Id: <1394217767-12242-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1394217767-12242-1-git-send-email-sebastian.chlad@tieto.com>
References: <1394217767-12242-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adding PTS test results for AVRCP 1.5.
---
 android/pts-avrcp.txt | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
index 8bd0b4d..b2cecf3 100644
--- a/android/pts-avrcp.txt
+++ b/android/pts-avrcp.txt
@@ -1,7 +1,7 @@
 PTS test results for AVRCP
 
 PTS version: 5.0
-Tested: 28.01.2014
+Tested: 07.03.2014
 Android version: 4.4.2
 
 Results:
@@ -77,12 +77,12 @@ TC_CT_PTT_BV_04_I	N/A
 TC_CT_PTT_BV_05_I	N/A
 TC_CT_RCR_BV_01_C	N/A
 TC_CT_RCR_BV_03_C	N/A
-TC_CT_VLH_BI_03_C	N/A
-TC_CT_VLH_BI_04_C	N/A
-TC_CT_VLH_BV_01_C	N/A
-TC_CT_VLH_BV_01_I	N/A
-TC_CT_VLH_BV_02_I	N/A
-TC_CT_VLH_BV_03_C	N/A
+TC_CT_VLH_BI_03_C	INC
+TC_CT_VLH_BI_04_C	INC
+TC_CT_VLH_BV_01_C	INC
+TC_CT_VLH_BV_01_I	INC
+TC_CT_VLH_BV_02_I	INC
+TC_CT_VLH_BV_03_C	INC
 -------------------------------------------------------------------------------
 
 
@@ -93,9 +93,9 @@ Test Name		Result	Notes
 TC_TG_BGN_BV_01_I	N/A
 TC_TG_BGN_BV_02_I	N/A
 TC_TG_CEC_BV_01_I	PASS
-TC_TG_CEC_BV_02_I	INC	Initiate a control channel connection
-TC_TG_CFG_BI_01_C	INC
-TC_TG_CFG_BV_02_C	INC
+TC_TG_CEC_BV_02_I	PASS
+TC_TG_CFG_BI_01_C	PASS
+TC_TG_CFG_BV_02_C	PASS
 TC_TG_CON_BV_02_C	N/A
 TC_TG_CON_BV_04_C	N/A
 TC_TG_CON_BV_05_C	N/A
@@ -103,7 +103,7 @@ TC_TG_CRC_BV_01_I	PASS
 TC_TG_CRC_BV_02_I	PASS	Disconnect from PTS
 TC_TG_ICC_BV_01_I	PASS
 TC_TG_ICC_BV_02_I	PASS
-TC_TG_INV_BI_01_C	INC
+TC_TG_INV_BI_01_C	PASS
 TC_TG_INV_BI_02_C	N/A
 TC_TG_MCN_CB_BI_01_C	N/A
 TC_TG_MCN_CB_BI_02_C	N/A
@@ -146,9 +146,9 @@ TC_TG_MCN_SRC_BV_03_I	N/A
 TC_TG_MCN_SRC_BV_04_C	N/A
 TC_TG_MCN_SRC_BV_04_I	N/A
 TC_TG_MCN_SRC_BV_06_C	N/A
-TC_TG_MDI_BV_02_C	INC
-TC_TG_MDI_BV_04_C	INC
-TC_TG_MDI_BV_05_C	INC
+TC_TG_MDI_BV_02_C	PASS
+TC_TG_MDI_BV_04_C	FAIL
+TC_TG_MDI_BV_05_C	PASS
 TC_TG_MPS_BI_01_C	N/A
 TC_TG_MPS_BI_02_C	N/A
 TC_TG_MPS_BV_01_I	N/A
@@ -161,14 +161,14 @@ TC_TG_MPS_BV_06_C	N/A
 TC_TG_MPS_BV_07_C	N/A
 TC_TG_MPS_BV_09_C	N/A
 TC_TG_MPS_BV_10_C	N/A
-TC_TG_NFY_BI_01_C	INC
-TC_TG_NFY_BV_02_C	INC
+TC_TG_NFY_BI_01_C	PASS
+TC_TG_NFY_BV_02_C	PASS	Change track when requested
 TC_TG_NFY_BV_03_C	N/A
-TC_TG_NFY_BV_04_C	INC
-TC_TG_NFY_BV_05_C	INC
+TC_TG_NFY_BV_04_C	PASS
+TC_TG_NFY_BV_05_C	PASS
 TC_TG_NFY_BV_06_C	N/A
 TC_TG_NFY_BV_07_C	N/A
-TC_TG_NFY_BV_08_C	INC
+TC_TG_NFY_BV_08_C	PASS
 TC_TG_PAS_BI_01_C	N/A
 TC_TG_PAS_BI_02_C	N/A
 TC_TG_PAS_BI_03_C	N/A
@@ -179,8 +179,8 @@ TC_TG_PAS_BV_04_C	N/A
 TC_TG_PAS_BV_06_C	N/A
 TC_TG_PAS_BV_08_C	N/A
 TC_TG_PAS_BV_10_C	N/A
-TC_TG_PTT_BV_01_I	INC
-TC_TG_PTT_BV_02_I	N/A
+TC_TG_PTT_BV_01_I	PASS
+TC_TG_PTT_BV_02_I	PASS
 TC_TG_PTT_BV_03_I	N/A
 TC_TG_PTT_BV_04_I	N/A
 TC_TG_PTT_BV_05_I	N/A
-- 
1.8.5.3

