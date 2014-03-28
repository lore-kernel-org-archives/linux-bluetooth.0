Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianchlad@gmail.com>
Subject: [PATCH 1/2] android/pts: Add PTS test results for L2CAP
Date: Fri, 28 Mar 2014 11:18:33 +0100
Message-Id: <1396001914-22821-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sebastian Chlad <sebastianchlad@gmail.com>

Since new PTS has been published this patch updates PTS tests
results for L2CAP. It also changes some minor mistakes in notes
to some of the test cases.
---
 android/pts-l2cap.txt | 292 ++++++++++++++++++++++++++------------------------
 1 file changed, 153 insertions(+), 139 deletions(-)

diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index 905c688..b14614a 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -1,7 +1,7 @@
 PTS test results for L2CAP
 
-PTS version: 5.0
-Tested: 29-Jan-2014
+PTS version: 5.1
+Tested: 27-March-2014
 Android version: 4.4.2
 
 Results:
@@ -11,141 +11,155 @@ INC    test is inconclusive
 N/A    test is disabled due to PICS setup
 
 -------------------------------------------------------------------------------
-Test Name              Result  Notes
+Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_COS_CED_BV_01_C     PASS    l2test -n -P 33 <bdaddr>
-TC_COS_CED_BV_03_C     PASS
-TC_COS_CED_BV_04_C     N/A
-TC_COS_CED_BV_05_C     PASS
-TC_COS_CED_BV_07_C     PASS
-TC_COS_CED_BV_08_C     PASS
-TC_COS_CED_BV_09_C     PASS
-TC_COS_CED_BV_10_C     N/A
-TC_COS_CED_BV_11_C     PASS
-TC_COS_CED_BI_01_C     PASS
-TC_COS_CFD_BV_01_C     PASS
-TC_COS_CFD_BV_02_C     PASS
-TC_COS_CFD_BV_03_C     PASS
-TC_COS_CFD_BV_08_C     PASS
-TC_COS_CFD_BV_09_C     PASS
-TC_COS_CFD_BV_10_C     N/A
-TC_COS_CFD_BI_11_C     PASS
-TC_COS_CFD_BV_12_C     PASS
-TC_COS_CFD_BV_13_C     N/A
-TC_COS_IEX_BV_01_C     PASS
-TC_COS_IEX_BV_02_C     PASS
-TC_COS_ECH_BV_01_C     PASS
-TC_COS_ECH_BV_02_C     PASS
-TC_CLS_CLR_BV_01_C     N/A
-TC_CLS_UCD_BV_01_C     N/A
-TC_CLS_UCD_BV_02_C     N/A
-TC_CLS_UCD_BV_03_C     N/A
-TC_EXF_BV_01_C         PASS
-TC_EXF_BV_02_C         PASS
-TC_EXF_BV_03_C         PASS
-TC_EXF_BV_04_C         N/A
-TC_EXF_BV_05_C         PASS
-TC_EXF_BV_06_C         N/A
-TC_CMC_BV_01_C         PASS    l2test -X ertm -P 33 <bdaddr>
-TC_CMC_BV_02_C         PASS    l2test -X ertm -P 33 <bdaddr>
-TC_CMC_BV_03_C         PASS    l2test -X ertm -P 33 <bdaddr>
-TC_CMC_BV_04_C         PASS    l2test -X streaming -P 33 <bdaddr>
-TC_CMC_BV_05_C         PASS    l2test -X streaming -P 33 <bdaddr>
-TC_CMC_BV_06_C         PASS    l2test -X streaming -P 33 <bdaddr>
-TC_CMC_BV_07_C         PASS    l2test -X basic -P 33 <bdaddr>
-TC_CMC_BV_08_C         PASS    l2test -X basic -P 33 <bdaddr>
-TC_CMC_BV_09_C         PASS    l2test -X streaming -P 33 <bdaddr>
-TC_CMC_BV_10_C         PASS    l2test -n <bdaddr>
-TC_CMC_BV_11_C         PASS    l2test -n <bdaddr>
-TC_CMC_BV_12_C         PASS    l2test -n -X ertm -P 33 <bdaddr>
-TC_CMC_BV_13_C         PASS    l2test -s -X streaming -P 33 <bdaddr>
-TC_CMC_BV_14_C         PASS    l2test -X streaming -P 33 <bdaddr>
-TC_CMC_BV_15_C         PASS    l2test -X streaming -P 33 <bdaddr>
-TC_CMC_BI_01_C         PASS
-TC_CMC_BI_02_C         PASS
-TC_CMC_BI_03_C         PASS
-TC_CMC_BI_04_C         PASS
-TC_CMC_BI_05_C         PASS
-TC_CMC_BI_06_C         PASS
-TC_FOC_BV_01_C         PASS    l2test -X ertm -P 33 -F 0 &
-TC_FOC_BV_02_C         PASS    l2test -X ertm -P 33 -F 0 &
-TC_FOC_BV_03_C         PASS    l2test -X ertm -P 33 -F 0 &
-TC_FOC_BV_04_C         PASS    l2test -n -X ertm -P <bdaddr> &
-TC_OFS_BV_01_C         PASS
-TC_OFS_BV_02_C         PASS    l2test -X ertm -P 33 -F 0 &
-TC_OFS_BV_03_C         PASS
-TC_OFS_BV_04_C         PASS
-TC_OFS_BV_05_C         PASS    l2test -X ertm -P 33 -F 0 &
-TC_OFS_BV_06_C         PASS    l2test -X ertm -P 33 -F 0 &
-TC_OFS_BV_07_C         PASS
-TC_OFS_BV_08_C         PASS
-TC_ERM_BV_01_C         PASS    l2test -X ertm -P 33 -B -Y 3 &
-TC_ERM_BV_02_C         PASS    l2test -X ertm -P 33 &
-TC_ERM_BV_03_C         PASS    l2test -X ertm -P 33 &
-TC_ERM_BV_04_C         PASS    l2test -X ertm -P 33 -B &
-TC_ERM_BV_05_C         PASS
-TC_ERM_BV_06_C         PASS
-TC_ERM_BV_07_C         PASS    l2test -X ertm -P 33 &
-TC_ERM_BV_08_C         PASS
-TC_ERM_BV_09_C         PASS    l2test -X ertm -P 33 &
-TC_ERM_BV_10_C         PASS    l2test -x -X ertm -P 33 -D 35000 -Q 1 -R -N 1 &
-				btmgmt disconnect
-TC_ERM_BV_11_C         PASS    l2test -x -X ertm -P 33 -D 35000 -Q 1 -R -N 1 &
-				btmgmt disconnect
-TC_ERM_BV_12_C         PASS    l2test -x -X ertm -P 33 -R -N 1
-TC_ERM_BV_13_C         PASS
-TC_ERM_BV_14_C         PASS
-TC_ERM_BV_15_C         PASS
-TC_ERM_BV_16_C         PASS
-TC_ERM_BV_17_C         PASS
-TC_ERM_BV_18_C         PASS    l2test -x -X ertm -P 33 -R -N 1
-TC_ERM_BV_19_C         PASS    l2test -x -X ertm -P 33 -R -N 1
-TC_ERM_BV_20_C         PASS
-TC_ERM_BV_21_C         PASS
-TC_ERM_BV_22_C         PASS
-TC_ERM_BV_23_C         PASS
-TC_ERM_BI_01_C         PASS
-TC_ERM_BI_02_C         PASS
-TC_ERM_BI_03_C         PASS
-TC_ERM_BI_04_C         PASS
-TC_ERM_BI_05_C         PASS
-TC_STM_BV_01_C         PASS    l2test -x -X ertm -P 33 -R -N 1 -Y 3 &
-TC_STM_BV_02_C         PASS    l2test -x -X ertm -P 33 -R -N 1 -Y 3 &
-TC_STM_BV_03_C         PASS    l2test -x -X ertm -P 33 -R -N 1 -Y 3 &
-TC_STM_BV_11_C         N/A
-TC_STM_BV_12_C         N/A
-TC_STM_BV_13_C         N/A
-TC_FIX_BV_01_C         PASS    l2test -n -P 33 <bdaddr>
-TC_FIX_BV_02_C         N/A
-TC_EWC_BV_01_C         N/A
-TC_EWC_BV_02_C         N/A
-TC_EWC_BV_03_C         N/A
-TC_LSC_BV_01_C         N/A
-TC_LSC_BV_02_C         N/A
-TC_LSC_BV_03_C         N/A
-TC_LSC_BI_04_C         N/A
-TC_LSC_BI_05_C         N/A
-TC_LSC_BV_06_C         N/A
-TC_LSC_BV_07_C         N/A
-TC_LSC_BV_08_C         N/A
-TC_LSC_BV_09_C         N/A
-TC_LSC_BI_10_C         N/A
-TC_LSC_BI_11_C         N/A
-TC_LSC_BV_12_C         N/A
-TC_CCH_BV_01_C         N/A
-TC_CCH_BV_02_C         N/A
-TC_CCH_BV_03_C         N/A
-TC_CCH_BV_04_C         N/A
-TC_ECF_BV_01_C         N/A
-TC_ECF_BV_02_C         N/A
-TC_ECF_BV_03_C         N/A
-TC_ECF_BV_04_C         N/A
-TC_ECF_BV_05_C         N/A
-TC_ECF_BV_06_C         N/A
-TC_ECF_BV_07_C         N/A
-TC_ECF_BV_08_C         N/A
-TC_LE_CPU_BV_01_C      N/A
-TC_LE_CPU_BV_02_C      N/A
-TC_LE_CPU_BI_01_C      N/A
-TC_LE_CPU_BI_02_C      N/A
-TC_LE_REJ_BV_01_C      N/A
+TC_COS_CED_BV_01_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+				i.e. l2test -n -P 4097 <bdaddr>
+TC_COS_CED_BV_03_C	PASS	l2test -y -N <frames to be sent>
+				-P <PSM - not reserved> <bdaddr>
+TC_COS_CED_BV_04_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CED_BV_05_C	PASS	l2test -P <PSM - not reserved>
+TC_COS_CED_BV_07_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CED_BV_08_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CED_BV_09_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CED_BV_10_C	N/A
+TC_COS_CED_BV_11_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CED_BI_01_C	PASS
+
+TC_COS_CFD_BV_01_C	PASS	l2test -P <PSM - not reserved>
+TC_COS_CFD_BV_02_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CFD_BV_03_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CFD_BV_08_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CFD_BV_09_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CFD_BV_10_C	N/A
+TC_COS_CFD_BI_11_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CFD_BV_12_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CFD_BV_13_C	N/A
+TC_COS_IEX_BV_01_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_IEX_BV_02_C	PASS
+
+TC_COS_ECH_BV_01_C	PASS
+TC_COS_ECH_BV_02_C	PASS	l2ping <bdaddr>
+TC_CLS_CLR_BV_01_C	N/A
+TC_CLS_UCD_BV_01_C	N/A
+TC_CLS_UCD_BV_02_C	N/A
+TC_CLS_UCD_BV_03_C	N/A
+TC_EXF_BV_01_C		PASS
+TC_EXF_BV_02_C		PASS
+TC_EXF_BV_03_C		PASS
+TC_EXF_BV_04_C		N/A
+TC_EXF_BV_05_C		PASS
+TC_EXF_BV_06_C		N/A
+
+TC_CMC_BV_01_C		PASS    l2test -X ertm -P <PSM - not reserved>
+TC_CMC_BV_02_C		PASS    l2test -X ertm -P <PSM - not reserved>
+TC_CMC_BV_03_C		PASS    l2test -X ertm -P <PSM - not reserved>
+TC_CMC_BV_04_C		PASS	l2test -X streaming <PSM - not reserved>
+TC_CMC_BV_05_C		PASS	l2test -X streaming <PSM - not reserved>
+TC_CMC_BV_06_C		PASS	l2test -X streaming <PSM - not reserved>
+TC_CMC_BV_07_C		PASS	l2test -X ertm <PSM - not reserved>
+TC_CMC_BV_08_C		PASS	l2test -X streaming -P <PSM - not reserved>
+TC_CMC_BV_09_C		PASS	l2test -X basic -P <PSM - not reserved>
+TC_CMC_BV_10_C		PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_CMC_BV_11_C		PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_CMC_BV_12_C		PASS	l2test -s -X ertm  -P <PSM - not reserved>
+				-U <bdaddr>
+TC_CMC_BV_13_C		PASS	l2test -s -X ertm  -P <PSM - not reserved>
+				-U <bdaddr>
+TC_CMC_BV_14_C		PASS	l2test -X streaming -P <PSM - not reserved>
+TC_CMC_BV_15_C		PASS	l2test -X streaming -P <PSM - not reserved>
+TC_CMC_BI_01_C		PASS	l2test -X ertm  -P <PSM - not reserved>
+TC_CMC_BI_02_C		PASS	l2test -X ertm  -P <PSM - not reserved>
+TC_CMC_BI_03_C		PASS	l2test -X streaming -P <PSM - not reserved>
+TC_CMC_BI_04_C		PASS	l2test -X streaming -P <PSM - not reserved>
+TC_CMC_BI_05_C		PASS	l2test -P <PSM - not reserved>
+TC_CMC_BI_06_C		PASS	l2test -P <PSM - not reserved>
+TC_FOC_BV_01_C		PASS	l2test -X ertm -P <PSM - not reserved> -F 0
+TC_FOC_BV_02_C		PASS	l2test -X ertm -P <PSM - not reserved> -F 0
+TC_FOC_BV_03_C		PASS	l2test -X ertm -P <PSM - not reserved> -F 0
+TC_FOC_BV_04_C		PASS	l2test -X ertm -P <PSM - not reserved> -F 0
+
+TC_OFS_BV_01_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -F 0
+				-N 1
+TC_OFS_BV_02_C		PASS	l2test -X ertm -P <PSM - not reserved> -F 0
+TC_OFS_BV_03_C		PASS	l2test -X streaming -P <PSM - not reserved> -F 0
+TC_OFS_BV_04_C		PASS	l2test -X streaming -P <PSM - not reserved> -F 0
+TC_OFS_BV_05_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
+TC_OFS_BV_06_C		PASS	l2test -X ertm -P <PSM - not reserved>
+TC_OFS_BV_07_C		PASS	l2test -x -X streaming -P <PSM - not reserved>
+				-F 0 -N 1
+TC_OFS_BV_08_C		PASS	l2test -X streaming -P <PSM - not reserved>
+TC_ERM_BV_01_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 3
+				-Y 3
+TC_ERM_BV_02_C		PASS	l2test -X ertm -P <PSM - not reserved>
+TC_ERM_BV_03_C		PASS	l2test -X ertm -P <PSM - not reserved>
+TC_ERM_BV_05_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 2
+				-Y 2
+TC_ERM_BV_06_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 2
+				-Y 2
+TC_ERM_BV_07_C		PASS	l2test -X ertm -P <PSM - not reserved>
+TC_ERM_BV_08_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
+TC_ERM_BV_09_C		PASS	l2test -X ertm -P <PSM - not reserved>
+TC_ERM_BV_10_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
+TC_ERM_BV_11_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
+				-Q 1
+TC_ERM_BV_12_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -R
+				-N 1 -Q 1
+TC_ERM_BV_13_C		PASS
+TC_ERM_BV_14_C		PASS
+TC_ERM_BV_15_C		PASS	l2test -X ertm -P <PSM - not reserved> -N 4
+				-Y 4
+TC_ERM_BV_16_C		N/A
+TC_ERM_BV_17_C		PASS	l2test -X ertm -P <PSM - not reserved>
+TC_ERM_BV_18_C		PASS
+TC_ERM_BV_19_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
+TC_ERM_BV_20_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
+TC_ERM_BV_21_C		PASS	l2test -w -X ertm -P 4097 -N 3
+TC_ERM_BV_22_C		PASS
+TC_ERM_BV_23_C		PASS
+TC_ERM_BI_01_C		N/A
+TC_ERM_BI_02_C		PASS	l2test -X ertm -P <PSM - not reserved>
+TC_ERM_BI_03_C		PASS
+TC_ERM_BI_04_C		PASS
+TC_ERM_BI_05_C		PASS
+TC_STM_BV_01_C		PASS	l2test -x -X streaming -P <PSM - not reserved>
+				-N 3 -Y 3
+TC_STM_BV_02_C		PASS	l2test -X streaming -P <PSM - not reserved>
+TC_STM_BV_03_C		PASS
+TC_STM_BV_11_C		N/A
+TC_STM_BV_12_C		N/A
+TC_STM_BV_13_C		N/A
+TC_FIX_BV_01_C		N/A
+TC_FIX_BV_02_C		N/A
+TC_EWC_BV_01_C		N/A
+TC_EWC_BV_02_C		N/A
+TC_EWC_BV_03_C		N/A
+TC_LSC_BV_01_C		N/A
+TC_LSC_BV_02_C		N/A
+TC_LSC_BV_03_C		N/A
+TC_LSC_BI_04_C		N/A
+TC_LSC_BI_05_C		N/A
+TC_LSC_BV_06_C		N/A
+TC_LSC_BV_07_C		N/A
+TC_LSC_BV_08_C		N/A
+TC_LSC_BV_09_C		N/A
+TC_LSC_BI_10_C		N/A
+TC_LSC_BI_11_C		N/A
+TC_LSC_BV_12_C		N/A
+TC_CCH_BV_01_C		N/A
+TC_CCH_BV_02_C		N/A
+TC_CCH_BV_03_C		N/A
+TC_CCH_BV_04_C		N/A
+TC_ECF_BV_01_C		N/A
+TC_ECF_BV_02_C		N/A
+TC_ECF_BV_03_C		N/A
+TC_ECF_BV_04_C		N/A
+TC_ECF_BV_05_C		N/A
+TC_ECF_BV_06_C		N/A
+TC_ECF_BV_07_C		N/A
+TC_ECF_BV_08_C		N/A
+TC_LE_CPU_BV_01_C	N/A
+TC_LE_CPU_BV_02_C	N/A
+TC_LE_CPU_BI_01_C	N/A
+TC_LE_CPU_BI_02_C	N/A
+TC_LE_REJ_BV_01_C	N/A
-- 
1.8.5.3

