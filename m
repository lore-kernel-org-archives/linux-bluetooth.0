Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pts: Add PTS test results for MAP
Date: Tue, 17 Dec 2013 11:53:53 +0100
Message-Id: <1387277633-6008-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1387277633-6008-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1387277633-6008-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Stock Bluedroid PTS results.
---
 android/Makefile.am |  2 +-
 android/pts-map.txt | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 android/pts-map.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index abeda84..909846e 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -123,4 +123,4 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pixit-pbap.txt android/pts-gap.txt android/pts-hid.txt \
 		android/pts-opp.txt android/pts-pbap.txt \
 		android/audio-ipc-api.txt android/pics-map.txt \
-		android/pixit-map.txt
+		android/pixit-map.txt android/pts-map.txt
diff --git a/android/pts-map.txt b/android/pts-map.txt
new file mode 100644
index 0000000..26702af
--- /dev/null
+++ b/android/pts-map.txt
@@ -0,0 +1,93 @@
+PTS test results for MAP
+
+PTS version: 5.0
+Tested: 17.12.2013
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
+TC_MCE_MSM_BV_01_I	N/A
+TC_MCE_MSM_BV_02_I	N/A
+TC_MCE_MSM_BV_03_I	N/A
+TC_MCE_MSM_BV_04_I	N/A
+TC_MCE_MSM_BV_13_I	N/A
+TC_MCE_MSM_BV_14_I	N/A
+TC_MCE_MNR_BV_01_I	N/A
+TC_MCE_MNR_BV_02_I	N/A
+TC_MCE_MMB_BV_01_I	N/A
+TC_MCE_MMB_BV_02_I	N/A
+TC_MCE_MMB_BV_03_I	N/A
+TC_MCE_MMB_BV_19_I	N/A
+TC_MCE_MMB_BV_04_I	N/A
+TC_MCE_MMB_BV_17_I	N/A
+TC_MCE_MMB_BV_06_I	N/A
+TC_MCE_MMB_BV_07_I	N/A
+TC_MCE_MMB_BV_08_I	N/A
+TC_MCE_MMD_BV_01_I	N/A
+TC_MCE_MMU_BV_01_I	N/A
+TC_MCE_MMN_BV_01_I	N/A
+TC_MCE_MMN_BV_03_I	N/A
+TC_MCE_MMI_BV_01_I	N/A
+TC_MCE_MFB_BV_01_I	N/A
+TC_MCE_MFB_BV_03_I	N/A
+TC_MCE_MFB_BV_04_I	N/A
+TC_MCE_BC_BV_02_I	N/A
+TC_MCE_BC_BV_04_I	N/A
+TC_MCE_CON_BV_01_I	N/A
+TC_MCE_CON_BV_02_I	N/A
+TC_MCE_ROB_BV_01_I	N/A
+TC_MCE_SRM_BV_03_I	N/A
+TC_MCE_SRM_BV_07_I	N/A
+TC_MCE_SRMP_BI_01_I	N/A
+TC_MCE_SRMP_BV_01_I	N/A
+TC_MCE_SRMP_BV_04_I	N/A
+TC_MCE_SRMP_BV_05_I	N/A
+TC_MCE_SRMP_BV_06_I	N/A
+TC_MSE_MSM_BV_05_I	PASS
+TC_MSE_MSM_BV_06_I	PASS
+TC_MSE_MSM_BV_07_I	PASS
+TC_MSE_MSM_BV_08_I	PASS
+TC_MSE_MSM_BV_09_I	N/A
+TC_MSE_MSM_BV_10_I	N/A
+TC_MSE_MSM_BV_11_I	N/A
+TC_MSE_MSM_BV_12_I	N/A
+TC_MSE_MNR_BV_03_I	PASS
+TC_MSE_MNR_BV_04_I	PASS
+TC_MSE_MMB_BV_09_I	PASS
+TC_MSE_MMB_BV_10_I	PASS
+TC_MSE_MMB_BV_11_I	PASS
+TC_MSE_MMB_BV_20_I	PASS
+TC_MSE_MMB_BV_12_I	N/A
+TC_MSE_MMB_BV_18_I	N/A
+TC_MSE_MMB_BV_13_I	PASS
+TC_MSE_MMB_BV_14_I	PASS
+TC_MSE_MMB_BV_15_I	PASS
+TC_MSE_MMB_BV_16_I	INC	Mailbox MAS instance not available on IUT.
+TC_MSE_MMD_BV_02_I	PASS
+TC_MSE_MMU_BV_02_I	PASS
+TC_MSE_MMU_BV_03_I	PASS
+TC_MSE_MMN_BV_02_I	PASS
+TC_MSE_MMN_BV_04_I	N/A
+TC_MSE_MMI_BV_02_I	N/A
+TC_MSE_MFB_BV_02_I	N/A
+TC_MSE_MFB_BV_05_I	N/A
+TC_MSE_BC_BV_01_I	N/A
+TC_MSE_BC_BV_03_I	N/A
+TC_MSE_CON_BV_01_I	N/A
+TC_MSE_CON_BV_02_I	N/A
+TC_MSE_ROB_BV_01_I	N/A
+TC_MSE_SRM_BI_02_I	N/A
+TC_MSE_SRM_BI_03_I	N/A
+TC_MSE_SRM_BI_05_I	N/A
+TC_MSE_SRM_BV_04_I	N/A
+TC_MSE_SRM_BV_08_I	N/A
+TC_MSE_SRMP_BI_02_I	N/A
+TC_MSE_SRMP_BV_02_I	N/A
+TC_MSE_SRMP_BV_03_I	N/A
+-------------------------------------------------------------------------------
-- 
1.8.5

