Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: L2CAP test results update
Date: Mon, 22 Dec 2014 11:28:45 +0100
Message-Id: <1419244125-31015-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-l2cap.txt  | 61 ++++++++++++++++++++++++++-----------------------
 android/pixit-l2cap.txt |  2 +-
 android/pts-l2cap.txt   | 57 +++++++++++++++++++--------------------------
 3 files changed, 56 insertions(+), 64 deletions(-)

diff --git a/android/pics-l2cap.txt b/android/pics-l2cap.txt
index 56036a0..c69d558 100644
--- a/android/pics-l2cap.txt
+++ b/android/pics-l2cap.txt
@@ -1,6 +1,6 @@
 L2CAP PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -22,7 +22,7 @@ TSPC_L2CAP_1_6	True		LE Data Channel Acceptor (C.5)
 C.1: Mandatory IF BR/EDR or BR/EDR/LE is supported, otherwise Excluded.
 C.2: Mandatory to support (at least one of TSPC_L2CAP_1_3 or TSPC_L2CAP_1_4)
 	IF LE or BR/EDR/LE is supported, otherwise Excluded.
-C.3: Optional IF LE or BR/EDR/LE is supported, otherwise Excluded.
+C.3: Optional IF BR/EDR or BR/EDR/LE is supported, otherwise Excluded.
 C.4: Optional IF LE or BR/EDR/LE and Core Spec v4.1 or Core Spec v4.1+HS and
 	TSPC_L2CAP_2_46 is supported, otherwise Excluded.
 C.5: Mandatory IF LE or BR/EDR/LE and Core Spec v4.1 or Core Spec v4.1+HS and
@@ -36,8 +36,8 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_L2CAP_2_1	True		Support of L2CAP signaling channel (C.20)
 TSPC_L2CAP_2_2	True		Support of configuration process (C.20)
-TSPC_L2CAP_2_3  True            Support of connection oriented data
-                                        channel (C.20)
+TSPC_L2CAP_2_3  True        Support of connection oriented data
+                    channel (C.20)
 TSPC_L2CAP_2_4	True		Support of command echo request (C.21)
 TSPC_L2CAP_2_5	True		Support of command echo response (C.20)
 TSPC_L2CAP_2_6	True		Support of command information request (C.21)
@@ -64,7 +64,7 @@ TSPC_L2CAP_2_24	True		Actively request Basic Mode for a PSM that
 					Mode (C.8)
 TSPC_L2CAP_2_25	True		Supports performing L2CAP channel mode
 					configuration fallback from SM
-					 to ERTM (C.9)
+					to ERTM (C.9)
 TSPC_L2CAP_2_26	True		Supports sending more than one unacknowledged
 					I-Frame when operating in ERTM (C.10)
 TSPC_L2CAP_2_27	True		Supports sending more than three unacknowledged
@@ -78,7 +78,7 @@ TSPC_L2CAP_2_32	False (*)	ERTM over AMP (C.12)
 TSPC_L2CAP_2_33	False (*)	Streaming Mode Source over AMP Support (C.15)
 TSPC_L2CAP_2_34	False (*)	Streaming Mode Sink over AMP Support (C.15)
 TSPC_L2CAP_2_35	True		Unicast Connectionless Data, Reception
-				(C.1, C.16)
+				    (C.1, C.16)
 TSPC_L2CAP_2_36	True		Ability to transmit an unencrypted packet over
 					a Unicast connectionless L2CAP
 					channel (C.16)
@@ -92,15 +92,16 @@ TSPC_L2CAP_2_41	True		Support of command reject (C.17)
 TSPC_L2CAP_2_42	True		Send Connection Parameter Update Request (C.18)
 TSPC_L2CAP_2_43	True		Send Connection Parameter Update Response (C.19)
 TSPC_L2CAP_2_44	False (*)	Extended Flow Specification for AMP (C.22)
-TSPC_L2CAP_2_45	True		Send disconnect request command (O)
+TSPC_L2CAP_2_45	True		Send disconnect request command (C.21)
 TSCP_L2CAP_2_46	True		Support LE Credit Based Flow Control
-				Mode (C.23)
+				    Mode (C.23)
 TSCP_L2CAP_2_47	True		Support for LE Data Channel (C.24)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support at least one of TSPC_L2CAP_2_12 OR TSPC_L2CAP_2_13 OR
-	TSPC_L2CAP_2_35 IF BR/EDR BR/EDR/LE AND SUM_ICS 31/7 (CSA1) OR
-	SUM_ICS 31/8 (3.0) OR SUM_ICS 31/9 (3.0+HS) OR SUM_ICS 31/10 (4.0))
-	is supported, ELSE Excluded
+	TSPC_L2CAP_2_35 IF BR/EDR OR BR/EDR/LE AND SUM_ICS 31/7 (CSA1) OR
+	Core Spec v3.0 OR Core Spec v3.0+HS OR Core Spec v4.0 OR
+	Core Spec v4.0+HS OR Core Spec v4.1 OR Core Spec v4.1+HS OR
+	Core Spec v4.2 OR Core Spec v4.2+HS is supported, ELSE Excluded
 C.2: Optional IF TSPC_L2CAP_2_12 OR TSPC_L2CAP_2_13 is claimed, ELSE Excluded.
 C.3: Optional IF TSPC_L2CAP_2_12 AND TSPC_L2CAP_2_28 is claimed, ELSE Excluded.
 C.4: IF TSPC_L2CAP_2_12 is claimed THEN either TSPC_L2CAP_2_18
@@ -114,23 +115,26 @@ C.9: Mandatory IF TSPC_L2CAP_2_12 AND TSPC_L2CAP_2_13 AND TSPC_L2CAP_2_21
        is claimed, ELSE Excluded.
 C.10: Optional IF TSPC_L2CAP_2_12 is claimed, ELSE Excluded.
 C.11: Optional IF TSPC_L2CAP_2_12 is claimed, ELSE Excluded.
-C.12: Mandatory IF SUM_ICS 31/9 (3.0 + HS) is claimed, ELSE Optional.
-C.13: Mandatory IF SUM_ICS 31/9 (3.0 + HS) is claimed, ELSE Optional.
-C.14: Optional IF SUM_ICS 31/8 OR 31/9 OR 31/10 OR 31/11 is claimed,
-	ELSE Excluded.
+C.12: Mandatory IF Core Spec v3.0+HS OR Core Spec v4.0+HS OR
+    Core Spec v4.1+HS OR Core Spec v4.2+HS is claimed, ELSE Optional.
+C.13: Mandatory IF Core Spec v3.0+HS OR Core Spec v4.0+HS OR
+    Core Spec v4.1+HS OR Core Spec v4.2+HS is claimed, ELSE Optional.
+C.14: Optional IF Core Spec v3.0 OR Core Spec v3.0+HS OR Core Spec v4.0 OR
+    Core Spec v4.0+HS OR Core Spec v4.1 OR Core Spec v4.1+HS OR
+    Core Spec v4.2 OR Core Spec v4.2+HS is claimed, ELSE Excluded.
 C.15: Optional IF TSPC_L2CAP_2_29 is claimed, ELSE Excluded.
-C.16: Optional IF (SUM_ICS 31/8 OR SUM_ICS 31/9 OR 31/10 OR 31/11) is claimed,
-       ELSE Excluded.
+C.16: Optional IF Core Spec v3.0 OR Core Spec v3.0+HS OR Core Spec v4.0 OR
+    Core Spec v4.0+HS OR Core Spec v4.1 OR Core Spec v4.1+HS OR
+    Core Spec v4.2 OR Core Spec v4.2+HS is claimed, ELSE Excluded.
 C.17: Mandatory IF LE OR BR/EDR/LE is claimed, ELSE Excluded.
-C.18: Optional IF (SUM_ICS 31/10 AND 1/4) is claimed, ELSE Excluded.
-C.19: Mandatory IF (SUM_ICS 31/10 AND 1/3) is claimed, ELSE Excluded.
-C.20: Mandatory IF LE OR BR/EDR/LE, is claimed, ELSE Excluded
-C.21: Optional IF LE OR BR/EDR/LE, is claimed, ELSE Excluded.
+C.18: Optional IF TSPC_L2CAP_1_4 is claimed, ELSE Excluded.
+C.19: Mandatory IF TSPC_L2CAP_1_3 is claimed, ELSE Excluded.
+C.20: Mandatory IF BR/EDR OR BR/EDR/LE, is claimed, ELSE Excluded
+C.21: Optional IF BR/EDR OR BR/EDR/LE, is claimed, ELSE Excluded.
 C.22: Mandatory IF TSPC_L2CAP_2_29 is claimed, ELSE Excluded.
-C.23: Optional LE OR BR/EDR/LE AND Core Spec v4.1 OR Core Spec v4.1+HS
-	is supported, otherwise Excluded.
-C.24: Mandatory IF TSPC_L2CAP_2_46 (Support LE Credit Based Flow Control Mode)
-	is supported, otherwise Excluded.
+C.23: Optional LE OR BR/EDR/LE AND Core Spec v4.1 OR Core Spec v4.1+HS OR
+    Core Spec v4.2 OR Core Spec v4.2+HS is supported, otherwise Excluded.
+C.24: Mandatory IF TSPC_L2CAP_2_46 is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -138,7 +142,7 @@ C.24: Mandatory IF TSPC_L2CAP_2_46 (Support LE Credit Based Flow Control Mode)
 -------------------------------------------------------------------------------
 Parameter	Name Selected	Description
 -------------------------------------------------------------------------------
-TSPC_L2CAP_3_1	True		Support of RTX timer (C.4)
+TSPC_L2CAP_3_1	True		Support of RTX timer (M)
 TSPC_L2CAP_3_2	True		Support of ERTX timer (C.4)
 TSPC_L2CAP_3_3	True		Support minimum MTU size 48 octets (C.4)
 TSPC_L2CAP_3_4	True		Support MTU size larger than 48 octets (C.5)
@@ -163,7 +167,7 @@ TSPC_L2CAP_3_14	False (*)	Negotiate and support service type ‘Best Effort'
 TSPC_L2CAP_3_15	False (*)	Negotiate and support service type ‘Guaranteed’
 					for Extended Flow Specification (C.9)
 TSPC_L2CAP_3_16	True		Support Multiple Simultaneous LE Data
-				Channels (C.10)
+                    Channels (C.10)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_L2CAP_3_8 is supported, ELSE Optional.
 C.2: Optional if TSPC_L2CAP_3_8 is supported, ELSE Excluded.
@@ -175,6 +179,5 @@ C.7: Optional if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
 C.8: Mandatory if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported,
 	ELSE Excluded.
 C.9: Optional if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
-C.10: Optional IF TSPC_L2CAP_2_47 (Support LE Data Channel) is supported,
-	otherwise Excluded.
+C.10: Optional IF TSPC_L2CAP_2_47 is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
diff --git a/android/pixit-l2cap.txt b/android/pixit-l2cap.txt
index 08b9284..bdd676f 100644
--- a/android/pixit-l2cap.txt
+++ b/android/pixit-l2cap.txt
@@ -1,6 +1,6 @@
 L2CAP PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index 8ee9486..98cfe5c 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -1,7 +1,7 @@
 PTS test results for L2CAP
 
-PTS version: 5.3
-Tested: 25-November-2014
+PTS version: 6.0
+Tested: 18-December-2014
 Android version: 5.0
 Kernel version: 3.18
 
@@ -41,17 +41,12 @@ TC_COS_IEX_BV_01_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_IEX_BV_02_C	PASS
 TC_COS_ECH_BV_01_C	PASS
 TC_COS_ECH_BV_02_C	PASS	l2ping -c 1 <bdaddr>
-TC_COS_CFC_BV_01_C	PASS	PTS issue #12728
-				l2test -y -N 1 -b 40 -V le_public <braddr>
-				Note: use Common.dll and ETS for L2CAP
-				from #12712
-TC_COS_CFC_BV_02_C	PASS	PTS issue #12728
-				l2test -y -N 1 -b 1 -V le_public <bdaddr>
-				Note: use Common.dll and ETS for L2CAP
-				from #12712
-TC_COS_CFC_BV_03_C	PASS	l2test -u -V le_public <bdaddr>
-TC_COS_CFC_BV_04_C	PASS	l2test -u -V le_public <bdaddr>
-TC_COS_CFC_BV_05_C	PASS	l2test -m -V le_public <bdaddr>
+TC_COS_CFC_BV_01_C	PASS	l2test -y -N 1 -b 40 -V le_public -P 37 <braddr>
+TC_COS_CFC_BV_02_C	PASS	l2test -y -N 1 -b 1 -V le_public  -P 37 <bdaddr>
+TC_COS_CFC_BV_03_C	PASS	l2test -u -V le_public -P 37 <bdaddr>
+TC_COS_CFC_BV_04_C	PASS	l2test -u -V le_public -P 37 <bdaddr>
+TC_COS_CFC_BV_05_C	PASS	l2test -u -V le_public <bdaddr>
+                            l2test -u -V le_public <bdaddr>
 TC_CLS_CLR_BV_01_C	N/A
 TC_CLS_UCD_BV_01_C	PASS
 TC_CLS_UCD_BV_02_C	PASS	l2test -s -G -N 1 -P 4113 <bdaddr>
@@ -74,15 +69,15 @@ TC_CMC_BV_09_C		PASS	l2test -r -X basic -P 4113
 TC_CMC_BV_10_C		PASS	l2test -n -P 4113 <bdaddr>
 TC_CMC_BV_11_C		PASS	l2test -n -P 4113 <bdaddr>
 TC_CMC_BV_12_C		PASS	l2test -z -X ertm <bdaddr>
-TC_CMC_BV_13_C		PASS	l2test -z -X ertm <bdaddr>
+TC_CMC_BV_13_C		PASS	l2test -z -X streaming <bdaddr>
 TC_CMC_BV_14_C		PASS	l2test -r -X streaming -P 4113
 TC_CMC_BV_15_C		PASS	l2test -r -X streaming -P 4113
 TC_CMC_BI_01_C		PASS	l2test -r -X ertm -P 4113
 TC_CMC_BI_02_C		PASS	l2test -r -X ertm -P 4113
 TC_CMC_BI_03_C		PASS	l2test -r -X streaming -P 4113
 TC_CMC_BI_04_C		PASS	l2test -r -X streaming -P 4113
-TC_CMC_BI_05_C		PASS	l2test -r -P 4113
-TC_CMC_BI_06_C		PASS	l2test -r -P 4113
+TC_CMC_BI_05_C		PASS	l2test -r -X basic -P 4113
+TC_CMC_BI_06_C		PASS	l2test -r -X basic -P 4113
 TC_FOC_BV_01_C		PASS	l2test -r -X ertm -P 4113 -F 0
 TC_FOC_BV_02_C		PASS	l2test -r -X ertm -P 4113 -F 0
 TC_FOC_BV_03_C		PASS	l2test -r -X ertm -P 4113 -F 0
@@ -114,7 +109,7 @@ TC_ERM_BV_18_C		PASS	l2test -x -X ertm -P 4113 -N 1
 TC_ERM_BV_19_C		PASS	l2test -x -X ertm -P 4113 -N 1
 TC_ERM_BV_20_C		PASS	l2test -x -X ertm -P 4113 -N 1
 TC_ERM_BV_21_C		PASS	l2test -x -X ertm -P 4113 -D 2000 -N 2
-TC_ERM_BV_22_C		PASS	l2test -r -H 1000 -K 5000 -X ertm -P 4113
+TC_ERM_BV_22_C		PASS	l2test -r -H 1000 -K 10000 -X ertm -P 4113
 TC_ERM_BV_23_C		PASS	l2test -x -X ertm -P 4113 -N 2
 TC_ERM_BI_01_C		N/A
 TC_ERM_BI_02_C		PASS	l2test -X ertm -P 4113
@@ -159,30 +154,24 @@ TC_ECF_BV_08_C		N/A
 				NOTE: for LE tests daemon should be stopped
 				then:
 				setprop ctl.start hciattach
-TC_LE_CPU_BV_01_C	PASS	l2test -r -V le_public -J 4
+TC_LE_CPU_BV_01_C	PASS	l2test -n -V le_public -J 4
 TC_LE_CPU_BV_02_C	PASS	l2test -n -V le_public -J 4 <braddr>
 TC_LE_CPU_BI_01_C	PASS	l2test -n -V le_public -J 4 <braddr>
-TC_LE_CPU_BI_02_C	PASS	PTS issue #12339
-				Note: use Common.dll and ETS for L2CAP
-				from #12339
-				l2test -r -V le_public -J 4
+TC_LE_CPU_BI_02_C	PASS	l2test -r -V le_public -J 4
 TC_LE_REJ_BI_01_C	PASS	l2test -n -V le_public -J 4 <braddr>
 TC_LE_REJ_BI_02_C	PASS	l2test -n -V le_public -J 4 <braddr>
 TC_LE_CFC_BV_01_C	PASS	l2test -n -V le_public -P 37 <braddr>
 TC_LE_CFC_BV_02_C	PASS	l2test -n -V le_public -P 37 <braddr>
-TC_LE_CFC_BV_03_C	INC	PTS issue #12665
+TC_LE_CFC_BV_03_C	PASS	l2test -x -N 1 -V le_public <braddr>
+			Note: PIXIT TSPX_iut_role_initiator=FALSE
 TC_LE_CFC_BV_04_C	PASS	l2test -n -V le_public -P 241  <braddr>
-TC_LE_CFC_BV_05_C	INC	PTS issue #12665
-TC_LE_CFC_BV_06_C	INC	PTS issue #12711 #12729
-				l2test -s -V le_public <braddr>
-TC_LE_CFC_BV_07_C	PASS	PTS issue #12728
-				l2test -u -V le_public <braddr>
-				Note: use Common.dll and ETS for L2CAP
-				from #12712
-TC_LE_CFC_BI_01_C	PASS	PTS issue #12728 #12712
-				l2test -u -V le_public <bdaddr>
-				Note: use Common.dll and ETS for L2CAP
-				from #12712
+TC_LE_CFC_BV_05_C	PASS	l2test -r -V le_public -J 4
+			Note: PIXIT TSPX_iut_role_initiator=FALSE
+TC_LE_CFC_BV_06_C	PASS	PTS issue #12853
+			Note: PIXIT TSPX_iut_role_initiator=FALSE
+			l2test -x -b 1 -V le_public <braddr>
+TC_LE_CFC_BV_07_C	PASS	l2test -u -V le_public <braddr>
+TC_LE_CFC_BI_01_C	PASS	l2test -u -V le_public <bdaddr>
 TC_LE_CFC_BV_08_C	PASS	l2test -n -V le_public -P 37 <braddr>
 TC_LE_CFC_BV_09_C	PASS	l2test -n -V le_public -P 37 <braddr>
 TC_LE_CFC_BV_16_C	PASS	l2test -n -V le_public -P 37 <braddr>
-- 
1.9.1

