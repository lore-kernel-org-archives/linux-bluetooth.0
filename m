Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 2/2] android/pts: Add HFP PTS tests results
Date: Wed, 12 Mar 2014 14:12:29 +0100
Message-Id: <1394629949-13166-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1394629949-13166-1-git-send-email-sebastian.chlad@tieto.com>
References: <1394629949-13166-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adding PTS test results for HFP 1.6
---
 android/Makefile.am |   3 +-
 android/pts-hfp.txt | 225 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 android/pts-hfp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index bbd3d2f..330529f 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -218,4 +218,5 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-a2dp.txt \
 				android/pts-avrcp.txt \
 				android/pts-avctp.txt \
-				android/pts-pbap.txt
+				android/pts-pbap.txt \
+				android/pts-hfp.txt
diff --git a/android/pts-hfp.txt b/android/pts-hfp.txt
new file mode 100644
index 0000000..719039a
--- /dev/null
+++ b/android/pts-hfp.txt
@@ -0,0 +1,225 @@
+PTS test results for HFP
+
+PTS version: 5.0
+Tested: 11-Mar-2014
+Android version: 4.4.2
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_AG_OOR_BV_01_I	PASS
+TC_AG_OOR_BV_02_I	PASS
+TC_AG_TRS_BV_01_I	PASS
+TC_AG_PSI_BV_01_I	PASS
+TC_AG_PSI_BV_02_I	N/A
+TC_AG_PSI_BV_03_I	PASS
+TC_AG_PSI_BV_04_I	PASS
+TC_AG_PSI_BV_05_I	PASS
+TC_AG_ACS_BV_02_I	N/A
+TC_AG_ACS_BV_04_I	PASS
+TC_AG_ACS_BV_06_I	N/A
+TC_AG_ACS_BV_08_I	PASS
+TC_AG_ACS_BV_10_I	N/A
+TC_AG_ACS_BV_11_I	PASS
+TC_AG_ACS_BI_14_I	PASS
+TC_AG_ACR_BV_01_I	PASS
+TC_AG_ACR_BV_02_I	PASS
+TC_AG_CLI_BV_01_I	PASS
+TC_AG_ICA_BV_01_I	N/A
+TC_AG_ICA_BV_02_I	N/A
+TC_AG_ICA_BV_04_I	PASS
+TC_AG_ICA_BV_05_I	N/A
+TC_AG_ICA_BV_06_I	PASS
+TC_AG_ICR_BV_01_I	PASS
+TC_AG_ICR_BV_02_I	PASS
+TC_AG_TCA_BV_01_I	PASS
+TC_AG_TCA_BV_02_I	PASS
+TC_AG_TCA_BV_03_I	PASS
+TC_AG_TCA_BV_04_I	PASS
+TC_AG_TCA_BV_05_I	PASS
+TC_AG_ATH_BV_03_I	PASS
+TC_AG_ATH_BV_04_I	PASS
+TC_AG_ATH_BV_05_I	PASS
+TC_AG_ATH_BV_06_I	PASS
+TC_AG_ATA_BV_01_I	PASS
+TC_AG_ATA_BV_02_I	PASS
+TC_AG_OCN_BV_01_I	PASS
+TC_AG_OCM_BV_01_I	PASS
+TC_AG_OCM_BV_02_I	PASS
+TC_AG_OCL_BV_01_I	PASS
+TC_AG_OCL_BV_02_I	PASS
+TC_AG_TWC_BV_01_I	INC	Not yet implemented
+TC_AG_TWC_BV_02_I	INC	Not yet implemented
+TC_AG_TWC_BV_03_I	INC	Not yet implemented
+TC_AG_TWC_BV_04_I	INC	Not yet implemented
+TC_AG_TWC_BV_05_I	INC	Not yet implemented
+TC_AG_TWC_BV_06_I	N/A
+TC_AG_CIT_BV_01_I	PASS
+TC_AG_ENO_BV_01_I	PASS
+TC_AG_ENO_BV_02_I	N/A
+TC_AG_VRA_BV_01_I	PASS
+TC_AG_VRA_BV_02_I	N/A
+TC_AG_VRA_BI_01_I	N/A
+TC_AG_VRD_BV_01_I	PASS
+TC_AG_VTG_BV_01_I	N/A
+TC_AG_TDC_BV_01_I	PASS
+TC_AG_RSV_BV_01_I	PASS
+TC_AG_RSV_BV_02_I	PASS
+TC_AG_RSV_BV_03_I	PASS
+TC_AG_RMV_BV_01_I	N/A
+TC_AG_RMV_BV_02_I	N/A
+TC_AG_RMV_BV_03_I	N/A
+TC_AG_ECS_BV_01_I	PASS
+TC_AG_ECS_BV_02_I	PASS
+TC_AG_ECS_BV_03_I	PASS
+TC_AG_ECC_BV_01_I	N/A
+TC_AG_ECC_BV_02_I	N/A
+TC_AG_ECC_BI_03_I	PASS
+TC_AG_ECC_BI_04_I	PASS
+TC_AG_RHH_BV_01_I	N/A
+TC_AG_RHH_BV_02_I	N/A
+TC_AG_RHH_BV_03_I	N/A
+TC_AG_RHH_BV_04_I	N/A
+TC_AG_RHH_BV_05_I	N/A
+TC_AG_RHH_BV_06_I	N/A
+TC_AG_RHH_BV_07_I	N/A
+TC_AG_RHH_BV_08_I	N/A
+TC_AG_NUM_BV_01_I	PASS
+TC_AG_SLC_BV_01_C	PASS
+TC_AG_SLC_BV_02_C	PASS
+TC_AG_SLC_BV_03_C	PASS
+TC_AG_SLC_BV_04_C	PASS
+TC_AG_SLC_BV_05_I	N/A
+TC_AG_SLC_BV_06_I	N/A
+TC_AG_SLC_BV_07_I	N/A
+TC_AG_ACC_BV_08_I	N/A
+TC_AG_ACC_BV_09_I	N/A
+TC_AG_ACC_BV_10_I	N/A
+TC_AG_ACC_BV_11_I	N/A
+TC_AG_ACC_BI_12_I	N/A
+TC_AG_ACC_BI_13_I	N/A
+TC_AG_ACC_BI_14_I	N/A
+TC_AG_ACC_BV_15_I	N/A
+TC_AG_WBS_BV_01_I	N/A
+TC_AG_DIS_BV_01_I	PASS
+TC_AG_SDP_BV_01_I	PASS
+TC_AG_IIA_BV_01_I	PASS
+TC_AG_IIA_BV_02_I	PASS
+TC_AG_IIA_BV_03_I	N/A
+TC_AG_IIA_BV_05_I	PASS
+TC_AG_IID_BV_01_I	PASS
+TC_AG_IID_BV_02_I	N/A
+TC_AG_IID_BV_03_I	PASS
+TC_AG_IID_BV_04_I	PASS
+TC_AG_IIC_BV_01_I	PASS
+TC_AG_IIC_BV_02_I	PASS
+TC_AG_IIC_BV_03_I	PASS
+
+TC_HF_OOR_BV_01_I	N/A
+TC_HF_OOR_BV_02_I	N/A
+TC_HF_TRS_BV_01_I	N/A
+TC_HF_PSI_BV_01_I	N/A
+TC_HF_PSI_BV_02_I	N/A
+TC_HF_PSI_BV_03_I	N/A
+TC_HF_PSI_BV_04_I	N/A
+TC_HF_ACS_BV_01_I	N/A
+TC_HF_ACS_BV_03_I	N/A
+TC_HF_ACS_BV_05_I	N/A
+TC_HF_ACS_BV_07_I	N/A
+TC_HF_ACS_BV_09_I	N/A
+TC_HF_ACS_BV_12_I	N/A
+TC_HF_ACS_BI_13_I	N/A
+TC_HF_ACR_BV_01_I	N/A
+TC_HF_ACR_BV_02_I	N/A
+TC_HF_CLI_BV_01_I	N/A
+TC_HF_ICA_BV_01_I	N/A
+TC_HF_ICA_BV_02_I	N/A
+TC_HF_ICA_BV_03_I	N/A
+TC_HF_ICA_BV_04_I	N/A
+TC_HF_ICA_BV_05_I	N/A
+TC_HF_ICA_BV_06_I	N/A
+TC_HF_ICA_BV_07_I	N/A
+TC_HF_ICR_BV_01_I	N/A
+TC_HF_ICR_BV_02_I	N/A
+TC_HF_TCA_BV_01_I	N/A
+TC_HF_TCA_BV_02_I	N/A
+TC_HF_TCA_BV_03_I	N/A
+TC_HF_TCA_BV_04_I	N/A
+TC_HF_ATH_BV_03_I	N/A
+TC_HF_ATH_BV_04_I	N/A
+TC_HF_ATH_BV_05_I	N/A
+TC_HF_ATH_BV_06_I	N/A
+TC_HF_ATH_BV_09_I	N/A
+TC_HF_ATA_BV_01_I	N/A
+TC_HF_ATA_BV_02_I	N/A
+TC_HF_ATA_BV_03_I	N/A
+TC_HF_OCN_BV_01_I	N/A
+TC_HF_OCM_BV_01_I	N/A
+TC_HF_OCM_BV_02_I	N/A
+TC_HF_OCL_BV_01_I	N/A
+TC_HF_OCL_BV_02_I	N/A
+TC_HF_TWC_BV_01_I	N/A
+TC_HF_TWC_BV_02_I	N/A
+TC_HF_TWC_BV_03_I	N/A
+TC_HF_TWC_BV_04_I	N/A
+TC_HF_TWC_BV_05_I	N/A
+TC_HF_TWC_BV_06_I	N/A
+TC_HF_CIT_BV_01_I	N/A
+TC_HF_ENO_BV_01_I	N/A
+TC_HF_VRA_BV_01_I	N/A
+TC_HF_VRA_BV_02_I	N/A
+TC_HF_VRA_BV_03_I	N/A
+TC_HF_VRD_BV_01_I	N/A
+TC_HF_VTG_BV_01_I	N/A
+TC_HF_TDC_BV_01_I	N/A
+TC_HF_RSV_BV_01_I	N/A
+TC_HF_RSV_BV_02_I	N/A
+TC_HF_RSV_BV_03_I	N/A
+TC_HF_RMV_BV_01_I	N/A
+TC_HF_RMV_BV_02_I	N/A
+TC_HF_RMV_BV_03_I	N/A
+TC_HF_ECS_BV_01_I	N/A
+TC_HF_ECS_BV_02_I	N/A
+TC_HF_ECS_BV_03_I	N/A
+TC_HF_ECC_BV_01_I	N/A
+TC_HF_ECC_BV_02_I	N/A
+TC_HF_RHH_BV_01_I	N/A
+TC_HF_RHH_BV_02_I	N/A
+TC_HF_RHH_BV_03_I	N/A
+TC_HF_RHH_BV_04_I	N/A
+TC_HF_RHH_BV_05_I	N/A
+TC_HF_RHH_BV_06_I	N/A
+TC_HF_RHH_BV_07_I	N/A
+TC_HF_RHH_BV_08_I	N/A
+TC_HF_NUM_BV_01_I	N/A
+TC_HF_NUM_BI_01_I	N/A
+TC_HF_SLC_BV_01_C	N/A
+TC_HF_SLC_BV_02_C	N/A
+TC_HF_SLC_BV_03_C	N/A
+TC_HF_SLC_BV_04_C	N/A
+TC_HF_SLC_BV_05_I	N/A
+TC_HF_SLC_BV_06_I	N/A
+TC_HF_SLC_BV_08_I	N/A
+TC_HF_ACC_BV_01_I	N/A
+TC_HF_ACC_BV_02_I	N/A
+TC_HF_ACC_BV_03_I	N/A
+TC_HF_ACC_BV_04_I	N/A
+TC_HF_ACC_BV_05_I	N/A
+TC_HF_ACC_BV_06_I	N/A
+TC_HF_ACC_BV_07_I	N/A
+TC_HF_WBS_BV_02_I	N/A
+TC_HF_WBS_BV_03_I	N/A
+TC_HF_DIS_BV_01_I	N/A
+TC_HF_DIS_BV_02_I	N/A
+TC_HF_SDP_BV_01_I	N/A
+TC_HF_SDP_BV_02_C	N/A
+TC_HF_SDP_BV_03_C	N/A
+TC_HF_ATAH_BV_01_I	N/A
+TC_HF_OCA_BV_01_I	N/A
+TC_HF_IIA_BV_04_I	N/A
-- 
1.8.5.3

