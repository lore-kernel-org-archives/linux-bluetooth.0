Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/pts: Update L2CAP settings and tests results
Date: Sat, 28 Jun 2014 20:47:57 +0200
Message-Id: <1403981277-24165-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-l2cap.txt |   6 +-
 android/pts-l2cap.txt  | 206 +++++++++++++++++++++++--------------------------
 2 files changed, 98 insertions(+), 114 deletions(-)

diff --git a/android/pics-l2cap.txt b/android/pics-l2cap.txt
index 5cc9d06..53e6b9f 100644
--- a/android/pics-l2cap.txt
+++ b/android/pics-l2cap.txt
@@ -44,7 +44,7 @@ TSPC_L2CAP_2_12	True (*)	Enhanced Retransmission Mode (C.1, C.13)
 TSPC_L2CAP_2_13	True (*)	Streaming Mode (C.1, C.14)
 TSPC_L2CAP_2_14	True (*)	FCS Option (C.2)
 TSPC_L2CAP_2_15	True (*)	Generate Local Busy Condition (C.3)
-TSPC_L2CAP_2_16	True (*)	Send Reject (C.3)
+TSPC_L2CAP_2_16	False		Send Reject (C.3)
 TSPC_L2CAP_2_17	True (*)	Send Selective Reject (C.3)
 TSPC_L2CAP_2_18	True (*)	Mandatory use of ERTM (C.4)
 TSPC_L2CAP_2_19	True (*)	Mandatory use of Streaming Mode (C.5)
@@ -77,8 +77,8 @@ TSPC_L2CAP_2_36	True (*)	Ability to transmit an unencrypted packet over
 TSPC_L2CAP_2_37	True (*)	Ability to transmit an encrypted packet over
 					a Unicast connectionless L2CAP
 					channel (C.16)
-TSPC_L2CAP_2_38	True (*)	Extended Flow Specification for BR/EDR (C.8)
-TSPC_L2CAP_2_39	True (*)	Extended Window Size (C.8)
+TSPC_L2CAP_2_38	False		Extended Flow Specification for BR/EDR (C.8)
+TSPC_L2CAP_2_39	False		Extended Window Size (C.8)
 TSPC_L2CAP_2_40	True (*)	Support of Low Energy signaling channel (C.17)
 TSPC_L2CAP_2_41	True (*)	Support of command reject (C.17)
 TSPC_L2CAP_2_42	True (*)	Send Connection Parameter Update Request (C.18)
diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index 6e012c1..678ede4 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -1,8 +1,9 @@
 PTS test results for L2CAP
 
 PTS version: 5.1
-Tested: 27-March-2014
+Tested: 27-June-2014
 Android version: 4.4.2
+Kernel version: 3.17
 
 Results:
 PASS   test passed
@@ -13,127 +14,110 @@ N/A    test is disabled due to PICS setup
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_COS_CED_BV_01_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
-				i.e. l2test -n -P 4097 <bdaddr>
-TC_COS_CED_BV_03_C	PASS	l2test -y -N <frames to be sent>
-				-P <PSM - not reserved> <bdaddr>
-TC_COS_CED_BV_04_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
-TC_COS_CED_BV_05_C	PASS	l2test -P <PSM - not reserved>
-TC_COS_CED_BV_07_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
-TC_COS_CED_BV_08_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
-TC_COS_CED_BV_09_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CED_BV_01_C	PASS	l2test -n -P 4113 <bdaddr>
+TC_COS_CED_BV_03_C	PASS	l2test -w -N 1 -P 4113
+TC_COS_CED_BV_04_C	PASS	l2test -r -P 4113
+TC_COS_CED_BV_05_C	PASS	l2test -r -P 4113
+TC_COS_CED_BV_07_C	PASS	l2test -r -P 4113
+TC_COS_CED_BV_08_C	PASS	l2test -r -P 4113
+TC_COS_CED_BV_09_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_CED_BV_10_C	N/A
-TC_COS_CED_BV_11_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CED_BV_11_C	PASS	l2test -r -P 4113
 TC_COS_CED_BI_01_C	PASS
-
-TC_COS_CFD_BV_01_C	PASS	l2test -P <PSM - not reserved>
-TC_COS_CFD_BV_02_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
-TC_COS_CFD_BV_03_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
-TC_COS_CFD_BV_08_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
-TC_COS_CFD_BV_09_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CFD_BV_01_C	PASS	l2test -r -P 4113
+TC_COS_CFD_BV_02_C	PASS	l2test -r -P 4113
+TC_COS_CFD_BV_03_C	PASS	l2test -r -P 4113
+TC_COS_CFD_BV_08_C	PASS	l2test -n -P 4113 <bdaddr>
+TC_COS_CFD_BV_09_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_CFD_BV_10_C	N/A
-TC_COS_CFD_BI_11_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
-TC_COS_CFD_BV_12_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_CFD_BI_11_C	PASS	l2test -r -P 4113
+TC_COS_CFD_BV_12_C	PASS	l2test -r -P 4113
 TC_COS_CFD_BV_13_C	N/A
-TC_COS_IEX_BV_01_C	PASS	l2test -n -P <PSM - not reserved> <bdaddr>
+TC_COS_IEX_BV_01_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_IEX_BV_02_C	PASS
-
 TC_COS_ECH_BV_01_C	PASS
-TC_COS_ECH_BV_02_C	PASS	l2ping <bdaddr>
+TC_COS_ECH_BV_02_C	PASS	l2ping -c 1 <bdaddr>
 TC_CLS_CLR_BV_01_C	N/A
-TC_CLS_UCD_BV_01_C	INC	not tested yet
-TC_CLS_UCD_BV_02_C	INC	not tested yet
-TC_CLS_UCD_BV_03_C	INC	not tested yet
+TC_CLS_UCD_BV_01_C	PASS
+TC_CLS_UCD_BV_02_C	PASS	l2test -s -G -N 1 -P 4113 <bdaddr>
+TC_CLS_UCD_BV_03_C	PASS	l2test -s -E -G -N 1 -P 4113 <bdaddr>
 TC_EXF_BV_01_C		PASS
 TC_EXF_BV_02_C		PASS
 TC_EXF_BV_03_C		PASS
-TC_EXF_BV_04_C		INC	not tested yet
+TC_EXF_BV_04_C		N/A
 TC_EXF_BV_05_C		PASS
-TC_EXF_BV_06_C		INC	not tested yet
-
-TC_CMC_BV_01_C		PASS    l2test -X ertm -P <PSM - not reserved>
-TC_CMC_BV_02_C		PASS    l2test -X ertm -P <PSM - not reserved>
-TC_CMC_BV_03_C		PASS    l2test -X ertm -P <PSM - not reserved>
-TC_CMC_BV_04_C		PASS	l2test -X streaming <PSM - not reserved>
-TC_CMC_BV_05_C		PASS	l2test -X streaming <PSM - not reserved>
-TC_CMC_BV_06_C		PASS	l2test -X streaming <PSM - not reserved>
-TC_CMC_BV_07_C		PASS	l2test -X ertm <PSM - not reserved>
-TC_CMC_BV_08_C		PASS	l2test -X streaming -P <PSM - not reserved>
-TC_CMC_BV_09_C		PASS	l2test -X basic -P <PSM - not reserved>
-TC_CMC_BV_10_C		PASS	l2test -n -P <PSM - not reserved> <bdaddr>
-TC_CMC_BV_11_C		PASS	l2test -n -P <PSM - not reserved> <bdaddr>
-TC_CMC_BV_12_C		PASS	l2test -s -X ertm  -P <PSM - not reserved>
-				-U <bdaddr>
-TC_CMC_BV_13_C		PASS	l2test -s -X ertm  -P <PSM - not reserved>
-				-U <bdaddr>
-TC_CMC_BV_14_C		PASS	l2test -X streaming -P <PSM - not reserved>
-TC_CMC_BV_15_C		PASS	l2test -X streaming -P <PSM - not reserved>
-TC_CMC_BI_01_C		PASS	l2test -X ertm  -P <PSM - not reserved>
-TC_CMC_BI_02_C		PASS	l2test -X ertm  -P <PSM - not reserved>
-TC_CMC_BI_03_C		PASS	l2test -X streaming -P <PSM - not reserved>
-TC_CMC_BI_04_C		PASS	l2test -X streaming -P <PSM - not reserved>
-TC_CMC_BI_05_C		PASS	l2test -P <PSM - not reserved>
-TC_CMC_BI_06_C		PASS	l2test -P <PSM - not reserved>
-TC_FOC_BV_01_C		PASS	l2test -X ertm -P <PSM - not reserved> -F 0
-TC_FOC_BV_02_C		PASS	l2test -X ertm -P <PSM - not reserved> -F 0
-TC_FOC_BV_03_C		PASS	l2test -X ertm -P <PSM - not reserved> -F 0
-TC_FOC_BV_04_C		PASS	l2test -X ertm -P <PSM - not reserved> -F 0
-
-TC_OFS_BV_01_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -F 0
-				-N 1
-TC_OFS_BV_02_C		PASS	l2test -X ertm -P <PSM - not reserved> -F 0
-TC_OFS_BV_03_C		PASS	l2test -X streaming -P <PSM - not reserved> -F 0
-TC_OFS_BV_04_C		PASS	l2test -X streaming -P <PSM - not reserved> -F 0
-TC_OFS_BV_05_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
-TC_OFS_BV_06_C		PASS	l2test -X ertm -P <PSM - not reserved>
-TC_OFS_BV_07_C		PASS	l2test -x -X streaming -P <PSM - not reserved>
-				-F 0 -N 1
-TC_OFS_BV_08_C		PASS	l2test -X streaming -P <PSM - not reserved>
-TC_ERM_BV_01_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 3
-				-Y 3
-TC_ERM_BV_02_C		PASS	l2test -X ertm -P <PSM - not reserved>
-TC_ERM_BV_03_C		PASS	l2test -X ertm -P <PSM - not reserved>
-TC_ERM_BV_05_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 2
-				-Y 2
-TC_ERM_BV_06_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 2
-				-Y 2
-TC_ERM_BV_07_C		PASS	l2test -X ertm -P <PSM - not reserved>
-TC_ERM_BV_08_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
-TC_ERM_BV_09_C		PASS	l2test -X ertm -P <PSM - not reserved>
-TC_ERM_BV_10_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
-TC_ERM_BV_11_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
-				-Q 1
-TC_ERM_BV_12_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -R
-				-N 1 -Q 1
+TC_EXF_BV_06_C		N/A
+TC_CMC_BV_01_C		PASS	l2test -r -X ertm -P 4113
+TC_CMC_BV_02_C		PASS	l2test -r -X ertm -P 4113
+TC_CMC_BV_03_C		PASS	l2test -r -X ertm -P 4113
+TC_CMC_BV_04_C		PASS	l2test -r -X streaming -P 4113
+TC_CMC_BV_05_C		PASS	l2test -r -X streaming -P 4113
+TC_CMC_BV_06_C		PASS	l2test -r -X streaming -P 4113
+TC_CMC_BV_07_C		PASS	l2test -r -X ertm -P 4113
+TC_CMC_BV_08_C		PASS	l2test -r -X streaming -P 4113
+TC_CMC_BV_09_C		PASS	l2test -r -X basic -P 4113
+TC_CMC_BV_10_C		PASS	l2test -n -P 4113 <bdaddr>
+TC_CMC_BV_11_C		PASS	l2test -n -P 4113 <bdaddr>
+TC_CMC_BV_12_C		PASS	l2test -s -X ertm -P 4113 -U <bdaddr>
+TC_CMC_BV_13_C		PASS	l2test -s -X ertm -P 4113 -U <bdaddr>
+TC_CMC_BV_14_C		PASS	l2test -r -X streaming -P 4113
+TC_CMC_BV_15_C		PASS	l2test -r -X streaming -P 4113
+TC_CMC_BI_01_C		PASS	l2test -r -X ertm -P 4113
+TC_CMC_BI_02_C		PASS	l2test -r -X ertm -P 4113
+TC_CMC_BI_03_C		PASS	l2test -r -X streaming -P 4113
+TC_CMC_BI_04_C		PASS	l2test -r -X streaming -P 4113
+TC_CMC_BI_05_C		PASS	l2test -r -P 4113
+TC_CMC_BI_06_C		PASS	l2test -r -P 4113
+TC_FOC_BV_01_C		PASS	l2test -r -X ertm -P 4113 -F 0
+TC_FOC_BV_02_C		PASS	l2test -r -X ertm -P 4113 -F 0
+TC_FOC_BV_03_C		PASS	l2test -r -X ertm -P 4113 -F 0
+TC_FOC_BV_04_C		PASS	l2test -r -X ertm -P 4113 -F 0
+TC_OFS_BV_01_C		PASS	l2test -x -X ertm -P 4113 -F 0 N 1
+TC_OFS_BV_02_C		PASS	l2test -r -X ertm -P 4113 -F 0
+TC_OFS_BV_03_C		PASS	l2test -r -X streaming -P 4113 -F 0
+TC_OFS_BV_04_C		PASS	l2test -r -X streaming -P 4113 -F 0
+TC_OFS_BV_05_C		PASS	l2test -x -X ertm -P 4113 -N 1
+TC_OFS_BV_06_C		PASS	l2test -r -X ertm -P 4113
+TC_OFS_BV_07_C		PASS	l2test -x -X streaming -P 4113 -F 0 -N 1
+TC_OFS_BV_08_C		PASS	l2test -r -X streaming -P 4113
+TC_ERM_BV_01_C		PASS	l2test -x -X ertm -P 4113 -N 3 -Y 3
+TC_ERM_BV_02_C		PASS	l2test -r -X ertm -P 4113
+TC_ERM_BV_03_C		PASS	l2test -r -X ertm -P 4113
+TC_ERM_BV_05_C		PASS	l2test -x -X ertm -P 4113 -N 2 -Y 2
+TC_ERM_BV_06_C		PASS	l2test -x -X ertm -P 4113 -N 2 -Y 2
+TC_ERM_BV_07_C		PASS	l2test -X ertm -P 4113
+TC_ERM_BV_08_C		PASS	l2test -x -X ertm -P 4113 -N 1
+TC_ERM_BV_09_C		PASS	l2test -X ertm -P 4113
+TC_ERM_BV_10_C		PASS	l2test -x -X ertm -P 4113 -N 1
+TC_ERM_BV_11_C		PASS	l2test -x -X ertm -P 4113 -N 1 -Q 1
+TC_ERM_BV_12_C		PASS	l2test -x -X ertm -P 4113 -R -N 1 -Q 1
 TC_ERM_BV_13_C		PASS
 TC_ERM_BV_14_C		PASS
-TC_ERM_BV_15_C		PASS	l2test -X ertm -P <PSM - not reserved> -N 4
-				-Y 4
-TC_ERM_BV_16_C		INC	not tested yet
-TC_ERM_BV_17_C		PASS	l2test -X ertm -P <PSM - not reserved>
+TC_ERM_BV_15_C		PASS	l2test -X ertm -P 4113 -N 4 -Y 4
+TC_ERM_BV_16_C		N/A
+TC_ERM_BV_17_C		PASS	l2test -X ertm -P 4113
 TC_ERM_BV_18_C		PASS
-TC_ERM_BV_19_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
-TC_ERM_BV_20_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
-TC_ERM_BV_21_C		PASS	l2test -w -X ertm -P 4097 -N 3
+TC_ERM_BV_19_C		PASS	l2test -x -X ertm -P 4113 -N 1
+TC_ERM_BV_20_C		PASS	l2test -x -X ertm -P 4113 -N 1
+TC_ERM_BV_21_C		PASS	l2test -w -X ertm -P 4113 -N 3
 TC_ERM_BV_22_C		PASS
 TC_ERM_BV_23_C		PASS
-TC_ERM_BI_01_C		INC	not tested yet
-TC_ERM_BI_02_C		PASS	l2test -X ertm -P <PSM - not reserved>
+TC_ERM_BI_01_C		N/A
+TC_ERM_BI_02_C		PASS	l2test -X ertm -P 4113
 TC_ERM_BI_03_C		PASS
 TC_ERM_BI_04_C		PASS
 TC_ERM_BI_05_C		PASS
-TC_STM_BV_01_C		PASS	l2test -x -X streaming -P <PSM - not reserved>
-				-N 3 -Y 3
-TC_STM_BV_02_C		PASS	l2test -X streaming -P <PSM - not reserved>
+TC_STM_BV_01_C		PASS	l2test -x -X streaming -P 4113 -N 3 -Y 3
+TC_STM_BV_02_C		PASS	l2test -r -X streaming -P 4113
 TC_STM_BV_03_C		PASS
 TC_STM_BV_11_C		N/A
 TC_STM_BV_12_C		N/A
 TC_STM_BV_13_C		N/A
-TC_FIX_BV_01_C		INC	not tested yet
+TC_FIX_BV_01_C		PASS	l2test -z -P 4113 <bdaddr>
 TC_FIX_BV_02_C		N/A
-TC_EWC_BV_01_C		INC	not tested yet
-TC_EWC_BV_02_C		INC	not tested yet
-TC_EWC_BV_03_C		INC	not tested yet
+TC_EWC_BV_01_C		N/A
+TC_EWC_BV_02_C		N/A
+TC_EWC_BV_03_C		N/A
 TC_LSC_BV_01_C		N/A
 TC_LSC_BV_02_C		N/A
 TC_LSC_BV_03_C		N/A
@@ -150,16 +134,16 @@ TC_CCH_BV_01_C		N/A
 TC_CCH_BV_02_C		N/A
 TC_CCH_BV_03_C		N/A
 TC_CCH_BV_04_C		N/A
-TC_ECF_BV_01_C		INC	not tested yet
-TC_ECF_BV_02_C		INC	not tested yet
-TC_ECF_BV_03_C		INC	not tested yet
-TC_ECF_BV_04_C		INC	not tested yet
-TC_ECF_BV_05_C		INC	not tested yet
-TC_ECF_BV_06_C		INC	not tested yet
-TC_ECF_BV_07_C		INC	not tested yet
-TC_ECF_BV_08_C		INC	not tested yet
-TC_LE_CPU_BV_01_C	INC	not tested yet
-TC_LE_CPU_BV_02_C	INC	not tested yet
-TC_LE_CPU_BI_01_C	INC	not tested yet
-TC_LE_CPU_BI_02_C	INC	not tested yet
-TC_LE_REJ_BV_01_C	INC	not tested yet
+TC_ECF_BV_01_C		N/A
+TC_ECF_BV_02_C		N/A
+TC_ECF_BV_03_C		N/A
+TC_ECF_BV_04_C		N/A
+TC_ECF_BV_05_C		N/A
+TC_ECF_BV_06_C		N/A
+TC_ECF_BV_07_C		N/A
+TC_ECF_BV_08_C		N/A
+TC_LE_CPU_BV_01_C	INC
+TC_LE_CPU_BV_02_C	PASS	l2test -n -V le_public -J 4 <braddr>
+TC_LE_CPU_BI_01_C	PASS	l2test -n -V le_public -J 4 <braddr>
+TC_LE_CPU_BI_02_C	INC
+TC_LE_REJ_BV_01_C	PASS	l2test -n -V le_public -J 4 <braddr>
-- 
1.9.3

