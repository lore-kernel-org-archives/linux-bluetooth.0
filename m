Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/pts: Add PTS test results for L2CAP
Date: Fri, 10 Jan 2014 13:47:40 +0200
Message-Id: <1389354460-7297-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-l2cap.txt | 128 +++++++++++++++++++++++++-------------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index d293046..51eedf5 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -1,7 +1,7 @@
 PTS test results for L2CAP
 
 PTS version: 5.0
-Tested: 18.12.2013
+Tested: 10.01.2014
 
 Results:
 PASS   test passed
@@ -12,21 +12,21 @@ N/A    test is disabled due to PICS setup
 -------------------------------------------------------------------------------
 Test Name              Result  Notes
 -------------------------------------------------------------------------------
-TC_COS_CED_BV_01_C     PASS
+TC_COS_CED_BV_01_C     PASS    l2test -n -P 33 <bdaddr>
 TC_COS_CED_BV_03_C     PASS
 TC_COS_CED_BV_04_C     N/A
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
@@ -45,75 +45,75 @@ TC_EXF_BV_03_C         PASS
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
-TC_OFS_BV_01_C         INC
-TC_OFS_BV_02_C         INC
-TC_OFS_BV_03_C         INC
-TC_OFS_BV_04_C         INC
-TC_OFS_BV_05_C         INC
-TC_OFS_BV_06_C         INC
-TC_OFS_BV_07_C         INC
-TC_OFS_BV_08_C         INC
-TC_ERM_BV_01_C         INC
-TC_ERM_BV_02_C         INC
-TC_ERM_BV_03_C         INC
-TC_ERM_BV_04_C         INC
-TC_ERM_BV_05_C         INC
-TC_ERM_BV_06_C         INC
-TC_ERM_BV_07_C         INC
-TC_ERM_BV_08_C         INC
-TC_ERM_BV_09_C         INC
+TC_CMC_BV_01_C         PASS    l2test -X ertm -P 33 <bdaddr>
+TC_CMC_BV_02_C         PASS    l2test -X ertm -P 33 <bdaddr>
+TC_CMC_BV_03_C         PASS    l2test -X ertm -P 33 <bdaddr>
+TC_CMC_BV_04_C         PASS    l2test -X streaming -P 33 <bdaddr>
+TC_CMC_BV_05_C         PASS    l2test -X streaming -P 33 <bdaddr>
+TC_CMC_BV_06_C         PASS    l2test -X streaming -P 33 <bdaddr>
+TC_CMC_BV_07_C         PASS    l2test -X basic -P 33 <bdaddr>
+TC_CMC_BV_08_C         PASS    l2test -X basic -P 33 <bdaddr>
+TC_CMC_BV_09_C         PASS    l2test -X streaming -P 33 <bdaddr>
+TC_CMC_BV_10_C         PASS    l2test -n <bdaddr>
+TC_CMC_BV_11_C         PASS    l2test -n <bdaddr>
+TC_CMC_BV_12_C         PASS    l2test -n -X ertm -P 33 <bdaddr>
+TC_CMC_BV_13_C         PASS    l2test -s -X streaming -P 33 <bdaddr>
+TC_CMC_BV_14_C         PASS    l2test -X streaming -P 33 <bdaddr>
+TC_CMC_BV_15_C         PASS    l2test -X streaming -P 33 <bdaddr>
+TC_CMC_BI_01_C         PASS
+TC_CMC_BI_02_C         PASS
+TC_CMC_BI_03_C         PASS
+TC_CMC_BI_04_C         PASS
+TC_CMC_BI_05_C         PASS
+TC_CMC_BI_06_C         PASS
+TC_FOC_BV_01_C         PASS    l2test -X ertm -P 33 -F 0 &
+TC_FOC_BV_02_C         PASS    l2test -X ertm -P 33 -F 0 &
+TC_FOC_BV_03_C         PASS    l2test -X ertm -P 33 -F 0 &
+TC_FOC_BV_04_C         PASS    l2test -n -X ertm -P <bdaddr> &
+TC_OFS_BV_01_C         PASS
+TC_OFS_BV_02_C         PASS    l2test -X ertm -P 33 -F 0 &
+TC_OFS_BV_03_C         PASS
+TC_OFS_BV_04_C         PASS
+TC_OFS_BV_05_C         PASS    l2test -X ertm -P 33 -F 0 &
+TC_OFS_BV_06_C         PASS    l2test -X ertm -P 33 -F 0 &
+TC_OFS_BV_07_C         PASS
+TC_OFS_BV_08_C         PASS
+TC_ERM_BV_01_C         PASS    l2test -X ertm -P 33 -B -Y 3 &
+TC_ERM_BV_02_C         PASS    l2test -X ertm -P 33 &
+TC_ERM_BV_03_C         PASS    l2test -X ertm -P 33 &
+TC_ERM_BV_04_C         PASS    l2test -X ertm -P 33 -B &
+TC_ERM_BV_05_C         PASS
+TC_ERM_BV_06_C         PASS
+TC_ERM_BV_07_C         PASS    l2test -X ertm -P 33 &
+TC_ERM_BV_08_C         PASS
+TC_ERM_BV_09_C         PASS    l2test -X ertm -P 33 &
 TC_ERM_BV_10_C         INC
 TC_ERM_BV_11_C         INC
 TC_ERM_BV_12_C         INC
-TC_ERM_BV_13_C         INC
-TC_ERM_BV_14_C         INC
-TC_ERM_BV_15_C         INC
-TC_ERM_BV_16_C         INC
-TC_ERM_BV_17_C         INC
+TC_ERM_BV_13_C         PASS
+TC_ERM_BV_14_C         PASS
+TC_ERM_BV_15_C         PASS
+TC_ERM_BV_16_C         PASS
+TC_ERM_BV_17_C         PASS
 TC_ERM_BV_18_C         INC
 TC_ERM_BV_19_C         INC
-TC_ERM_BV_20_C         INC
-TC_ERM_BV_21_C         INC
-TC_ERM_BV_22_C         INC
-TC_ERM_BV_23_C         INC
-TC_ERM_BI_01_C         INC
-TC_ERM_BI_02_C         INC
-TC_ERM_BI_03_C         INC
-TC_ERM_BI_04_C         INC
-TC_ERM_BI_05_C         INC
+TC_ERM_BV_20_C         PASS
+TC_ERM_BV_21_C         PASS
+TC_ERM_BV_22_C         PASS
+TC_ERM_BV_23_C         PASS
+TC_ERM_BI_01_C         PASS
+TC_ERM_BI_02_C         PASS
+TC_ERM_BI_03_C         PASS
+TC_ERM_BI_04_C         PASS
+TC_ERM_BI_05_C         PASS
 TC_STM_BV_01_C         INC
 TC_STM_BV_02_C         INC
 TC_STM_BV_03_C         INC
 TC_STM_BV_11_C         N/A
 TC_STM_BV_12_C         N/A
 TC_STM_BV_13_C         N/A
-TC_FIX_BV_01_C         PASS
-TC_FIX_BV_02_C         PASS
+TC_FIX_BV_01_C         PASS    l2test -n -P 33 <bdaddr>
+TC_FIX_BV_02_C         N/A
 TC_EWC_BV_01_C         N/A
 TC_EWC_BV_02_C         N/A
 TC_EWC_BV_03_C         N/A
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

