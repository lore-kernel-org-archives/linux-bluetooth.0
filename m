Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/pts: Add PTS test results for L2CAP
Date: Tue,  7 Jan 2014 23:06:10 +0100
Message-Id: <1389132370-4928-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-l2cap.txt | 72 +++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index d293046..0cfda2c 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -1,7 +1,7 @@
 PTS test results for L2CAP
 
 PTS version: 5.0
-Tested: 18.12.2013
+Tested: 07.01.2014
 
 Results:
 PASS   test passed
@@ -18,15 +18,15 @@ TC_COS_CED_BV_04_C     N/A
 TC_COS_CED_BV_05_C     PASS
 TC_COS_CED_BV_07_C     PASS
 TC_COS_CED_BV_08_C     PASS
-TC_COS_CED_BV_09_C     INC
+TC_COS_CED_BV_09_C     PASS
 TC_COS_CED_BV_10_C     N/A
 TC_COS_CED_BV_11_C     PASS
 TC_COS_CED_BI_01_C     PASS
 TC_COS_CFD_BV_01_C     PASS
 TC_COS_CFD_BV_02_C     PASS
 TC_COS_CFD_BV_03_C     PASS
-TC_COS_CFD_BV_08_C     INC
-TC_COS_CFD_BV_09_C     INC
+TC_COS_CFD_BV_08_C     PASS
+TC_COS_CFD_BV_09_C     PASS
 TC_COS_CFD_BV_10_C     N/A
 TC_COS_CFD_BI_11_C     PASS
 TC_COS_CFD_BV_12_C     PASS
@@ -34,7 +34,7 @@ TC_COS_CFD_BV_13_C     N/A
 TC_COS_IEX_BV_01_C     PASS
 TC_COS_IEX_BV_02_C     PASS
 TC_COS_ECH_BV_01_C     PASS
-TC_COS_ECH_BV_02_C     INC
+TC_COS_ECH_BV_02_C     PASS
 TC_CLS_CLR_BV_01_C     N/A
 TC_CLS_UCD_BV_01_C     N/A
 TC_CLS_UCD_BV_02_C     N/A
@@ -45,31 +45,31 @@ TC_EXF_BV_03_C         PASS
 TC_EXF_BV_04_C         N/A
 TC_EXF_BV_05_C         PASS
 TC_EXF_BV_06_C         N/A
-TC_CMC_BV_01_C         INC
-TC_CMC_BV_02_C         INC
-TC_CMC_BV_03_C         INC
-TC_CMC_BV_04_C         INC
-TC_CMC_BV_05_C         INC
-TC_CMC_BV_06_C         INC
-TC_CMC_BV_07_C         INC
-TC_CMC_BV_08_C         INC
-TC_CMC_BV_09_C         INC
-TC_CMC_BV_10_C         INC
-TC_CMC_BV_11_C         INC
-TC_CMC_BV_12_C         INC
-TC_CMC_BV_13_C         INC
-TC_CMC_BV_14_C         INC
-TC_CMC_BV_15_C         INC
-TC_CMC_BI_01_C         INC
-TC_CMC_BI_02_C         INC
-TC_CMC_BI_03_C         INC
-TC_CMC_BI_04_C         INC
-TC_CMC_BI_05_C         INC
-TC_CMC_BI_06_C         INC
-TC_FOC_BV_01_C         INC
-TC_FOC_BV_02_C         INC
-TC_FOC_BV_03_C         INC
-TC_FOC_BV_04_C         INC
+TC_CMC_BV_01_C         PASS
+TC_CMC_BV_02_C         PASS
+TC_CMC_BV_03_C         PASS
+TC_CMC_BV_04_C         PASS
+TC_CMC_BV_05_C         PASS
+TC_CMC_BV_06_C         PASS
+TC_CMC_BV_07_C         PASS
+TC_CMC_BV_08_C         PASS
+TC_CMC_BV_09_C         PASS
+TC_CMC_BV_10_C         PASS
+TC_CMC_BV_11_C         PASS
+TC_CMC_BV_12_C         PASS
+TC_CMC_BV_13_C         PASS
+TC_CMC_BV_14_C         PASS
+TC_CMC_BV_15_C         PASS
+TC_CMC_BI_01_C         PASS
+TC_CMC_BI_02_C         PASS
+TC_CMC_BI_03_C         PASS
+TC_CMC_BI_04_C         PASS
+TC_CMC_BI_05_C         PASS
+TC_CMC_BI_06_C         PASS
+TC_FOC_BV_01_C         PASS
+TC_FOC_BV_02_C         PASS
+TC_FOC_BV_03_C         PASS
+TC_FOC_BV_04_C         PASS
 TC_OFS_BV_01_C         INC
 TC_OFS_BV_02_C         INC
 TC_OFS_BV_03_C         INC
@@ -78,11 +78,11 @@ TC_OFS_BV_05_C         INC
 TC_OFS_BV_06_C         INC
 TC_OFS_BV_07_C         INC
 TC_OFS_BV_08_C         INC
-TC_ERM_BV_01_C         INC
-TC_ERM_BV_02_C         INC
-TC_ERM_BV_03_C         INC
-TC_ERM_BV_04_C         INC
-TC_ERM_BV_05_C         INC
+TC_ERM_BV_01_C         PASS
+TC_ERM_BV_02_C         PASS
+TC_ERM_BV_03_C         PASS
+TC_ERM_BV_04_C         PASS
+TC_ERM_BV_05_C         PASS
 TC_ERM_BV_06_C         INC
 TC_ERM_BV_07_C         INC
 TC_ERM_BV_08_C         INC
@@ -113,7 +113,7 @@ TC_STM_BV_11_C         N/A
 TC_STM_BV_12_C         N/A
 TC_STM_BV_13_C         N/A
 TC_FIX_BV_01_C         PASS
-TC_FIX_BV_02_C         PASS
+TC_FIX_BV_02_C         N/A
 TC_EWC_BV_01_C         N/A
 TC_EWC_BV_02_C         N/A
 TC_EWC_BV_03_C         N/A
-- 
1.8.1.2

