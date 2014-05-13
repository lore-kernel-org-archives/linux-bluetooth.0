Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 2/3] android/pts: Add test listing for MCAP
Date: Tue, 13 May 2014 12:25:50 +0200
Message-Id: <1399976751-4206-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1399976751-4206-1-git-send-email-sebastian.chlad@tieto.com>
References: <1399976751-4206-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am  |  3 +-
 android/pts-mcap.txt | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 android/pts-mcap.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 3d1595f..fb3dcbb 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -263,4 +263,5 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-gatt.txt \
 				android/pts-hsp.txt \
 				android/pts-iopt.txt \
-				android/pts-hdp.txt
+				android/pts-hdp.txt \
+				android/pts-mcap.txt
diff --git a/android/pts-mcap.txt b/android/pts-mcap.txt
new file mode 100644
index 0000000..9a77839
--- /dev/null
+++ b/android/pts-mcap.txt
@@ -0,0 +1,77 @@
+PTS test results for MCAP
+
+PTS version: 5.1
+Tested: not tested
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
+TC_MCAP_CE_BV_01_C	INC
+TC_MCAP_CE_BV_02_C	INC
+TC_MCAP_CE_BV_03_C	INC
+TC_MCAP_CE_BV_04_C	INC
+TC_MCAP_CM_ABT_BV_01_C	N/A
+TC_MCAP_CM_ABT_BV_02_C	INC
+TC_MCAP_CM_ABT_BV_03_C	N/A
+TC_MCAP_CM_DEL_BV_01_C	N/A
+TC_MCAP_CM_DEL_BV_02_C	INC
+TC_MCAP_CM_DEL_BV_02_C	N/A
+TC_MCAP_CM_DEL_BV_04_C	INC
+TC_MCAP_CM_DIS_BV_01_C	INC
+TC_MCAP_CM_DIS_BV_02_C	INC
+TC_MCAP_CM_DIS_BV_03_C	INC
+TC_MCAP_CM_DIS_BV_04_C	INC
+TC_MCAP_CM_DIS_BV_05_C	INC
+TC_MCAP_CM_REC_BV_01_C	N/A
+TC_MCAP_CM_REC_BV_02_C	INC
+TC_MCAP_CM_REC_BV_03_C	N/A
+TC_MCAP_CM_REC_BV_04_C	INC
+TC_MCAP_CM_REC_BV_05_C	N/A
+TC_MCAP_CM_REC_BV_06_C	INC
+TC_MCAP_CS_ERR_BI_01_C	N/A
+TC_MCAP_CS_ERR_BI_02_C	N/A
+TC_MCAP_CS_ERR_BI_03_C	N/A
+TC_MCAP_CS_ERR_BI_04_C	N/A
+TC_MCAP_CS_I_BV_01_I	N/A
+TC_MCAP_CS_I_BV_02_I	N/A
+TC_MCAP_CS_I_BV_03_C	N/A
+TC_MCAP_CS_I_BV_04_C	N/A
+TC_MCAP_CS_R_BV_01_I	N/A
+TC_MCAP_CS_R_BV_02_I	N/A
+TC_MCAP_CS_R_BV_03_C	N/A
+TC_MCAP_CS_T_BV_04_C	N/A
+TC_MCAP_ERR_BI_01_C	INC
+TC_MCAP_ERR_BI_02_C	INC
+TC_MCAP_ERR_BI_03_C	INC
+TC_MCAP_ERR_BI_04_C	INC
+TC_MCAP_ERR_BI_05_C	INC
+TC_MCAP_ERR_BI_06_C	INC
+TC_MCAP_ERR_BI_07_C	INC
+TC_MCAP_ERR_BI_08_C	INC
+TC_MCAP_ERR_BI_09_C	INC
+TC_MCAP_ERR_BI_10_C	INC
+TC_MCAP_ERR_BI_11_C	INC
+TC_MCAP_ERR_BI_12_C	INC
+TC_MCAP_ERR_BI_13_C	INC
+TC_MCAP_ERR_BI_14_C	INC
+TC_MCAP_ERR_BI_15_C	INC
+TC_MCAP_ERR_BI_16_C	INC
+TC_MCAP_ERR_BI_17_C	INC
+TC_MCAP_ERR_BI_18_C	INC
+TC_MCAP_ERR_BI_19_C	INC
+TC_MCAP_ERR_BI_20_C	INC
+TC_MCAP_INV_BI_01_C	INC
+TC_MCAP_INV_BI_02_C	INC
+TC_MCAP_INV_BI_03_C	INC
+TC_MCAP_INV_BI_04_C	INC
+TC_MCAP_INV_BI_05_C	INC
+TC_MCAP_INV_BI_06_C	INC
+TC_MCAP_INV_BI_07_C	INC
+-------------------------------------------------------------------------------
-- 
1.8.5.3

