Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Adjust PICS for l2cap
Date: Thu, 12 Jun 2014 08:28:29 +0200
Message-Id: <1402554509-31021-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-l2cap.txt | 12 ++++++------
 android/pts-l2cap.txt  | 48 ++++++++++++++++++++++++------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/android/pics-l2cap.txt b/android/pics-l2cap.txt
index 096fbf4..5cc9d06 100644
--- a/android/pics-l2cap.txt
+++ b/android/pics-l2cap.txt
@@ -70,21 +70,21 @@ TSPC_L2CAP_2_31	False		AMP Manager Support (C.12)
 TSPC_L2CAP_2_32	False		ERTM over AMP (C.12)
 TSPC_L2CAP_2_33	False		Streaming Mode Source over AMP Support (C.15)
 TSPC_L2CAP_2_34	False		Streaming Mode Sink over AMP Support (C.15)
-TSPC_L2CAP_2_35	False		Unicast Connectionless Data, Reception (C.1, C.16)
-TSPC_L2CAP_2_36	False		Ability to transmit an unencrypted packet over
+TSPC_L2CAP_2_35	True (*)	Unicast Connectionless Data, Reception (C.1, C.16)
+TSPC_L2CAP_2_36	True (*)	Ability to transmit an unencrypted packet over
 					a Unicast connectionless L2CAP
 					channel (C.16)
-TSPC_L2CAP_2_37	False		Ability to transmit an encrypted packet over
+TSPC_L2CAP_2_37	True (*)	Ability to transmit an encrypted packet over
 					a Unicast connectionless L2CAP
 					channel (C.16)
-TSPC_L2CAP_2_38	False		Extended Flow Specification for BR/EDR (C.8)
-TSPC_L2CAP_2_39	False		Extended Window Size (C.8)
+TSPC_L2CAP_2_38	True (*)	Extended Flow Specification for BR/EDR (C.8)
+TSPC_L2CAP_2_39	True (*)	Extended Window Size (C.8)
 TSPC_L2CAP_2_40	True (*)	Support of Low Energy signaling channel (C.17)
 TSPC_L2CAP_2_41	True (*)	Support of command reject (C.17)
 TSPC_L2CAP_2_42	True (*)	Send Connection Parameter Update Request (C.18)
 TSPC_L2CAP_2_43	True (*)	Send Connection Parameter Update Response (C.19)
 TSPC_L2CAP_2_44	False		Extended Flow Specification for AMP (C.22)
-TSPC_L2CAP_2_45	False		Send disconnect request command (O)
+TSPC_L2CAP_2_45	True (*)	Send disconnect request command (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support at least one of TSPC_L2CAP_2_12 OR TSPC_L2CAP_2_13 OR
 	TSPC_L2CAP_2_35 IF BR/EDR BR/EDR/LE AND SUM_ICS 31/7 (CSA1) OR
diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index b14614a..6e012c1 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -41,15 +41,15 @@ TC_COS_IEX_BV_02_C	PASS
 TC_COS_ECH_BV_01_C	PASS
 TC_COS_ECH_BV_02_C	PASS	l2ping <bdaddr>
 TC_CLS_CLR_BV_01_C	N/A
-TC_CLS_UCD_BV_01_C	N/A
-TC_CLS_UCD_BV_02_C	N/A
-TC_CLS_UCD_BV_03_C	N/A
+TC_CLS_UCD_BV_01_C	INC	not tested yet
+TC_CLS_UCD_BV_02_C	INC	not tested yet
+TC_CLS_UCD_BV_03_C	INC	not tested yet
 TC_EXF_BV_01_C		PASS
 TC_EXF_BV_02_C		PASS
 TC_EXF_BV_03_C		PASS
-TC_EXF_BV_04_C		N/A
+TC_EXF_BV_04_C		INC	not tested yet
 TC_EXF_BV_05_C		PASS
-TC_EXF_BV_06_C		N/A
+TC_EXF_BV_06_C		INC	not tested yet
 
 TC_CMC_BV_01_C		PASS    l2test -X ertm -P <PSM - not reserved>
 TC_CMC_BV_02_C		PASS    l2test -X ertm -P <PSM - not reserved>
@@ -109,7 +109,7 @@ TC_ERM_BV_13_C		PASS
 TC_ERM_BV_14_C		PASS
 TC_ERM_BV_15_C		PASS	l2test -X ertm -P <PSM - not reserved> -N 4
 				-Y 4
-TC_ERM_BV_16_C		N/A
+TC_ERM_BV_16_C		INC	not tested yet
 TC_ERM_BV_17_C		PASS	l2test -X ertm -P <PSM - not reserved>
 TC_ERM_BV_18_C		PASS
 TC_ERM_BV_19_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
@@ -117,7 +117,7 @@ TC_ERM_BV_20_C		PASS	l2test -x -X ertm -P <PSM - not reserved> -N 1
 TC_ERM_BV_21_C		PASS	l2test -w -X ertm -P 4097 -N 3
 TC_ERM_BV_22_C		PASS
 TC_ERM_BV_23_C		PASS
-TC_ERM_BI_01_C		N/A
+TC_ERM_BI_01_C		INC	not tested yet
 TC_ERM_BI_02_C		PASS	l2test -X ertm -P <PSM - not reserved>
 TC_ERM_BI_03_C		PASS
 TC_ERM_BI_04_C		PASS
@@ -129,11 +129,11 @@ TC_STM_BV_03_C		PASS
 TC_STM_BV_11_C		N/A
 TC_STM_BV_12_C		N/A
 TC_STM_BV_13_C		N/A
-TC_FIX_BV_01_C		N/A
+TC_FIX_BV_01_C		INC	not tested yet
 TC_FIX_BV_02_C		N/A
-TC_EWC_BV_01_C		N/A
-TC_EWC_BV_02_C		N/A
-TC_EWC_BV_03_C		N/A
+TC_EWC_BV_01_C		INC	not tested yet
+TC_EWC_BV_02_C		INC	not tested yet
+TC_EWC_BV_03_C		INC	not tested yet
 TC_LSC_BV_01_C		N/A
 TC_LSC_BV_02_C		N/A
 TC_LSC_BV_03_C		N/A
@@ -150,16 +150,16 @@ TC_CCH_BV_01_C		N/A
 TC_CCH_BV_02_C		N/A
 TC_CCH_BV_03_C		N/A
 TC_CCH_BV_04_C		N/A
-TC_ECF_BV_01_C		N/A
-TC_ECF_BV_02_C		N/A
-TC_ECF_BV_03_C		N/A
-TC_ECF_BV_04_C		N/A
-TC_ECF_BV_05_C		N/A
-TC_ECF_BV_06_C		N/A
-TC_ECF_BV_07_C		N/A
-TC_ECF_BV_08_C		N/A
-TC_LE_CPU_BV_01_C	N/A
-TC_LE_CPU_BV_02_C	N/A
-TC_LE_CPU_BI_01_C	N/A
-TC_LE_CPU_BI_02_C	N/A
-TC_LE_REJ_BV_01_C	N/A
+TC_ECF_BV_01_C		INC	not tested yet
+TC_ECF_BV_02_C		INC	not tested yet
+TC_ECF_BV_03_C		INC	not tested yet
+TC_ECF_BV_04_C		INC	not tested yet
+TC_ECF_BV_05_C		INC	not tested yet
+TC_ECF_BV_06_C		INC	not tested yet
+TC_ECF_BV_07_C		INC	not tested yet
+TC_ECF_BV_08_C		INC	not tested yet
+TC_LE_CPU_BV_01_C	INC	not tested yet
+TC_LE_CPU_BV_02_C	INC	not tested yet
+TC_LE_CPU_BI_01_C	INC	not tested yet
+TC_LE_CPU_BI_02_C	INC	not tested yet
+TC_LE_REJ_BV_01_C	INC	not tested yet
-- 
1.8.5.3

