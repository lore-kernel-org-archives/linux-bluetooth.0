Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/pts: Add PTS test results document for AVRCP
Date: Thu, 16 Jan 2014 11:01:01 +0100
Message-Id: <1389866462-7993-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389866462-7993-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389866462-7993-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow for better tracking of current state of implementation.
---
 android/Makefile.am   |   2 +-
 android/pts-avrcp.txt | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 android/pts-avrcp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 0ce0188..95ed7a7 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -148,6 +148,6 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pics-avrcp.txt android/pixit-avrcp.txt \
 		android/pics-a2dp.txt android/pixit-a2dp.txt \
 		android/pics-avctp.txt android/pixit-avctp.txt \
-		android/pts-a2dp.txt \
+		android/pts-a2dp.txt android/pts-avrcp.txt \
 
 		android/pts-l2cap.txt
diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
new file mode 100644
index 0000000..f2533b4
--- /dev/null
+++ b/android/pts-avrcp.txt
@@ -0,0 +1,194 @@
+PTS test results for AVRCP
+
+PTS version: 5.0
+Tested: --not yet tested--
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+
+		Controller (CT)
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_CT_BGN_BV_01_I	N/A
+TC_CT_BGN_BV_02_I	N/A
+TC_CT_CEC_BV_01_I	N/A
+TC_CT_CEC_BV_02_I	N/A
+TC_CT_CFG_BV_01_C	N/A
+TC_CT_CON_BV_01_C	N/A
+TC_CT_CON_BV_03_C	N/A
+TC_CT_CRC_BV_01_I	N/A
+TC_CT_CRC_BV_02_I	N/A
+TC_CT_ICC_BV_01_I	N/A
+TC_CT_ICC_BV_02_I	N/A
+TC_CT_MCN_CB_BV_01_C	N/A
+TC_CT_MCN_CB_BV_01_I	N/A
+TC_CT_MCN_CB_BV_02_I	N/A
+TC_CT_MCN_CB_BV_03_I	N/A
+TC_CT_MCN_CB_BV_04_C	N/A
+TC_CT_MCN_CB_BV_04_I	N/A
+TC_CT_MCN_CB_BV_05_I	N/A
+TC_CT_MCN_CB_BV_06_I	N/A
+TC_CT_MCN_CB_BV_07_C	N/A
+TC_CT_MCN_CB_BV_07_I	N/A
+TC_CT_MCN_NP_BV_01_C	N/A
+TC_CT_MCN_NP_BV_01_I	N/A
+TC_CT_MCN_NP_BV_02_I	N/A
+TC_CT_MCN_NP_BV_03_C	N/A
+TC_CT_MCN_NP_BV_03_I	N/A
+TC_CT_MCN_NP_BV_04_I	N/A
+TC_CT_MCN_NP_BV_05_C	N/A
+TC_CT_MCN_NP_BV_05_I	N/A
+TC_CT_MCN_NP_BV_06_I	N/A
+TC_CT_MCN_NP_BV_07_I	N/A
+TC_CT_MCN_NP_BV_08_C	N/A
+TC_CT_MCN_SRC_BV_01_C	N/A
+TC_CT_MCN_SRC_BV_01_I	N/A
+TC_CT_MCN_SRC_BV_02_I	N/A
+TC_CT_MCN_SRC_BV_03_C	N/A
+TC_CT_MCN_SRC_BV_03_I	N/A
+TC_CT_MCN_SRC_BV_04_I	N/A
+TC_CT_MCN_SRC_BV_05_C	N/A
+TC_CT_MDI_BV_01_C	N/A
+TC_CT_MDI_BV_03_C	N/A
+TC_CT_MPS_BV_01_C	N/A
+TC_CT_MPS_BV_01_I	N/A
+TC_CT_MPS_BV_02_I	N/A
+TC_CT_MPS_BV_03_C	N/A
+TC_CT_MPS_BV_03_I	N/A
+TC_CT_MPS_BV_08_C	N/A
+TC_CT_NFY_BV_01_C	N/A
+TC_CT_PAS_BV_01_C	N/A
+TC_CT_PAS_BV_03_C	N/A
+TC_CT_PAS_BV_05_C	N/A
+TC_CT_PAS_BV_07_C	N/A
+TC_CT_PAS_BV_09_C	N/A
+TC_CT_PAS_BV_11_C	N/A
+TC_CT_PTH_BV_01_C	N/A
+TC_CT_PTH_BV_02_C	N/A
+TC_CT_PTT_BV_01_I	N/A
+TC_CT_PTT_BV_02_I	N/A
+TC_CT_PTT_BV_03_I	N/A
+TC_CT_PTT_BV_04_I	N/A
+TC_CT_PTT_BV_05_I	N/A
+TC_CT_RCR_BV_01_C	N/A
+TC_CT_RCR_BV_03_C	N/A
+TC_CT_VLH_BI_03_C	N/A
+TC_CT_VLH_BI_04_C	N/A
+TC_CT_VLH_BV_01_C	N/A
+TC_CT_VLH_BV_01_I	N/A
+TC_CT_VLH_BV_02_I	N/A
+TC_CT_VLH_BV_03_C	N/A
+-------------------------------------------------------------------------------
+
+
+		Target (TG)
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_TG_BGN_BV_01_I	N/A
+TC_TG_BGN_BV_02_I	N/A
+TC_TG_CEC_BV_01_I	INC
+TC_TG_CEC_BV_02_I	INC
+TC_TG_CFG_BI_01_C	INC
+TC_TG_CFG_BV_02_C	INC
+TC_TG_CON_BV_02_C	N/A
+TC_TG_CON_BV_04_C	N/A
+TC_TG_CON_BV_05_C	N/A
+TC_TG_CRC_BV_01_I	INC
+TC_TG_CRC_BV_02_I	INC
+TC_TG_ICC_BV_01_I	INC
+TC_TG_ICC_BV_02_I	INC
+TC_TG_INV_BI_01_C	INC
+TC_TG_INV_BI_02_C	N/A
+TC_TG_MCN_CB_BI_01_C	N/A
+TC_TG_MCN_CB_BI_02_C	N/A
+TC_TG_MCN_CB_BI_03_C	N/A
+TC_TG_MCN_CB_BI_04_C	N/A
+TC_TG_MCN_CB_BI_05_C	N/A
+TC_TG_MCN_CB_BV_01_I	N/A
+TC_TG_MCN_CB_BV_02_C	N/A
+TC_TG_MCN_CB_BV_02_I	N/A
+TC_TG_MCN_CB_BV_03_C	N/A
+TC_TG_MCN_CB_BV_03_I	N/A
+TC_TG_MCN_CB_BV_04_I	N/A
+TC_TG_MCN_CB_BV_05_C	N/A
+TC_TG_MCN_CB_BV_05_I	N/A
+TC_TG_MCN_CB_BV_06_C	N/A
+TC_TG_MCN_CB_BV_06_I	N/A
+TC_TG_MCN_CB_BV_07_I	N/A
+TC_TG_MCN_CB_BV_08_C	N/A
+TC_TG_MCN_CB_BV_09_C	N/A
+TC_TG_MCN_CB_BV_10_C	N/A
+TC_TG_MCN_CB_BV_11_C	N/A
+TC_TG_MCN_NP_BI_01_C	N/A
+TC_TG_MCN_NP_BI_02_C	N/A
+TC_TG_MCN_NP_BV_01_I	N/A
+TC_TG_MCN_NP_BV_02_C	N/A
+TC_TG_MCN_NP_BV_02_I	N/A
+TC_TG_MCN_NP_BV_03_I	N/A
+TC_TG_MCN_NP_BV_04_C	N/A
+TC_TG_MCN_NP_BV_04_I	N/A
+TC_TG_MCN_NP_BV_05_I	N/A
+TC_TG_MCN_NP_BV_06_C	N/A
+TC_TG_MCN_NP_BV_06_I	N/A
+TC_TG_MCN_NP_BV_07_C	N/A
+TC_TG_MCN_NP_BV_07_I	N/A
+TC_TG_MCN_NP_BV_09_C	N/A
+TC_TG_MCN_SRC_BV_01_I	N/A
+TC_TG_MCN_SRC_BV_02_C	N/A
+TC_TG_MCN_SRC_BV_02_I	N/A
+TC_TG_MCN_SRC_BV_03_I	N/A
+TC_TG_MCN_SRC_BV_04_C	N/A
+TC_TG_MCN_SRC_BV_04_I	N/A
+TC_TG_MCN_SRC_BV_06_C	N/A
+TC_TG_MDI_BV_02_C	INC
+TC_TG_MDI_BV_04_C	INC
+TC_TG_MDI_BV_05_C	INC
+TC_TG_MPS_BI_01_C	N/A
+TC_TG_MPS_BI_02_C	N/A
+TC_TG_MPS_BV_01_I	N/A
+TC_TG_MPS_BV_02_C	N/A
+TC_TG_MPS_BV_02_I	N/A
+TC_TG_MPS_BV_03_I	N/A
+TC_TG_MPS_BV_04_C	N/A
+TC_TG_MPS_BV_05_C	N/A
+TC_TG_MPS_BV_06_C	N/A
+TC_TG_MPS_BV_07_C	N/A
+TC_TG_MPS_BV_09_C	N/A
+TC_TG_MPS_BV_10_C	N/A
+TC_TG_NFY_BI_01_C	INC
+TC_TG_NFY_BV_02_C	INC
+TC_TG_NFY_BV_03_C	N/A
+TC_TG_NFY_BV_04_C	INC
+TC_TG_NFY_BV_05_C	INC
+TC_TG_NFY_BV_06_C	N/A
+TC_TG_NFY_BV_07_C	N/A
+TC_TG_NFY_BV_08_C	INC
+TC_TG_PAS_BI_01_C	N/A
+TC_TG_PAS_BI_02_C	N/A
+TC_TG_PAS_BI_03_C	N/A
+TC_TG_PAS_BI_04_C	N/A
+TC_TG_PAS_BI_05_C	N/A
+TC_TG_PAS_BV_02_C	N/A
+TC_TG_PAS_BV_04_C	N/A
+TC_TG_PAS_BV_06_C	N/A
+TC_TG_PAS_BV_08_C	N/A
+TC_TG_PAS_BV_10_C	N/A
+TC_TG_PTT_BV_01_I	INC
+TC_TG_PTT_BV_02_I	N/A
+TC_TG_PTT_BV_03_I	N/A
+TC_TG_PTT_BV_04_I	N/A
+TC_TG_PTT_BV_05_I	N/A
+TC_TG_RCR_BV_02_C	INC
+TC_TG_RCR_BV_04_C	INC
+TC_TG_VLH_BI_01_C	N/A
+TC_TG_VLH_BI_02_C	N/A
+TC_TG_VLH_BV_01_I	N/A
+TC_TG_VLH_BV_02_C	N/A
+TC_TG_VLH_BV_02_I	N/A
+TC_TG_VLH_BV_04_C	N/A
+-------------------------------------------------------------------------------
-- 
1.8.5.2

