Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv3] android/pts: Update L2CAP test results
Date: Mon,  1 Jun 2015 12:12:02 +0200
Message-Id: <1433153522-4332-1-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1432886379-5978-1-git-send-email-mariusz.skamra@tieto.com>
References: <1432886379-5978-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-l2cap.txt  | 27 ++++++++++-------------
 android/pixit-l2cap.txt | 14 ++++++++++--
 android/pts-l2cap.txt   | 57 +++++++++++++++++++++++++++----------------------
 3 files changed, 55 insertions(+), 43 deletions(-)

diff --git a/android/pics-l2cap.txt b/android/pics-l2cap.txt
index 984116b..ef46770 100644
--- a/android/pics-l2cap.txt
+++ b/android/pics-l2cap.txt
@@ -1,6 +1,6 @@
 L2CAP PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -99,13 +99,11 @@ TSCP_L2CAP_2_47	True		Support for LE Data Channel (C.24)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support at least one of TSPC_L2CAP_2_12 OR TSPC_L2CAP_2_13 OR
 	TSPC_L2CAP_2_35 IF BR/EDR OR BR/EDR/LE AND SUM_ICS 31/7 (CSA1) OR
-	Core Spec v3.0 OR Core Spec v3.0+HS OR Core Spec v4.0 OR
-	Core Spec v4.0+HS OR Core Spec v4.1 OR Core Spec v4.1+HS OR
-	Core Spec v4.2 OR Core Spec v4.2+HS is supported, ELSE Excluded
+	Core Spec v3.0 or later is supported, ELSE Excluded
 C.2: Optional IF TSPC_L2CAP_2_12 OR TSPC_L2CAP_2_13 is claimed, ELSE Excluded.
 C.3: Optional IF TSPC_L2CAP_2_12 AND TSPC_L2CAP_2_28 is claimed, ELSE Excluded.
 C.4: IF TSPC_L2CAP_2_12 is claimed THEN either TSPC_L2CAP_2_18
-	OR TSPC_L2CAP_2_20 are Mandatory, ELSE Excluded.
+	OR TSPC_L2CAP_2_20 is Mandatory, ELSE Excluded.
 C.5: IF TSPC_L2CAP_2_13 is claimed THEN either TSPC_L2CAP_2_19
 	OR TSPC_L2CAP_2_21 are Mandatory, ELSE Excluded.
 C.6: Optional IF TSPC_L2CAP_2_12 is claimed, ELSE Excluded.
@@ -119,16 +117,12 @@ C.12: Mandatory IF Core Spec v3.0+HS OR Core Spec v4.0+HS OR
     Core Spec v4.1+HS OR Core Spec v4.2+HS is claimed, ELSE Optional.
 C.13: Mandatory IF Core Spec v3.0+HS OR Core Spec v4.0+HS OR
     Core Spec v4.1+HS OR Core Spec v4.2+HS is claimed, ELSE Optional.
-C.14: Optional IF Core Spec v3.0 OR Core Spec v3.0+HS OR Core Spec v4.0 OR
-    Core Spec v4.0+HS OR Core Spec v4.1 OR Core Spec v4.1+HS OR
-    Core Spec v4.2 OR Core Spec v4.2+HS is claimed, ELSE Excluded.
+C.14: Optional IF Core Spec v3.0 OR or later is claimed, ELSE Excluded.
 C.15: Optional IF TSPC_L2CAP_2_29 is claimed, ELSE Excluded.
-C.16: Optional IF Core Spec v3.0 OR Core Spec v3.0+HS OR Core Spec v4.0 OR
-    Core Spec v4.0+HS OR Core Spec v4.1 OR Core Spec v4.1+HS OR
-    Core Spec v4.2 OR Core Spec v4.2+HS is claimed, ELSE Excluded.
+C.16: Optional IF Core Spec v3.0 or later is claimed, ELSE Excluded.
 C.17: Mandatory IF LE OR BR/EDR/LE is claimed, ELSE Excluded.
-C.18: Optional IF TSPC_L2CAP_1_4 is claimed, ELSE Excluded.
-C.19: Mandatory IF TSPC_L2CAP_1_3 is claimed, ELSE Excluded.
+C.18: Optional IF Core Spec 4.0 OR TSPC_L2CAP_1_4 is claimed, ELSE Excluded.
+C.19: Mandatory IF Core Spec 4.0 AND TSPC_L2CAP_1_3 is claimed, ELSE Excluded.
 C.20: Mandatory IF BR/EDR OR BR/EDR/LE, is claimed, ELSE Excluded
 C.21: Optional IF BR/EDR OR BR/EDR/LE, is claimed, ELSE Excluded.
 C.22: Mandatory IF TSPC_L2CAP_2_29 is claimed, ELSE Excluded.
@@ -167,7 +161,7 @@ TSPC_L2CAP_3_14	False (*)	Negotiate and support service type ‘Best Effort'
 TSPC_L2CAP_3_15	False (*)	Negotiate and support service type ‘Guaranteed’
 					for Extended Flow Specification (C.9)
 TSPC_L2CAP_3_16	True		Support Multiple Simultaneous LE Data
-                    Channels (C.10)
+					Channels (C.10)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_L2CAP_3_8 is supported, ELSE Optional.
 C.2: Optional if TSPC_L2CAP_3_8 is supported, ELSE Excluded.
@@ -176,8 +170,9 @@ C.4: Mandatory IF BR/EDR OR BR/EDR/LE is claimed, ELSE Excluded.
 C.5: Optional IF BR/EDR OR BR/EDR/LE is claimed, ELSE Excluded.
 C.6: Mandatory IF LE OR BR/EDR/LE is claimed, ELSE Excluded.
 C.7: Optional if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
-C.8: Mandatory if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported,
+C.8: Mandatory if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, 
 	ELSE Excluded.
 C.9: Optional if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
-C.10: Optional IF TSPC_L2CAP_2_47 is supported, otherwise Excluded.
+C.10: Optional IF TSPC_L2CAP_2_47 AND Core Spec 4.1 is supported,
+	otherwise Excluded.
 -------------------------------------------------------------------------------
diff --git a/android/pixit-l2cap.txt b/android/pixit-l2cap.txt
index bdd676f..23fad19 100644
--- a/android/pixit-l2cap.txt
+++ b/android/pixit-l2cap.txt
@@ -1,6 +1,6 @@
 L2CAP PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -19,7 +19,7 @@ TSPX_flushto                                           FFFF
 TSPX_inmtu                                             02A0
 TSPX_no_fail_verditcs                                  FALSE
 TSPX_oumtu                                             02A0
-TSPX_tester_mps                                        0017 (*)
+TSPX_tester_mps                                        0017
 TSPX_tester_mtu                                        02A0
 TSPX_iut_role_initiator                                TRUE (*)
 TSPX_le_psm                                            0080 (*)
@@ -46,4 +46,14 @@ TSPX_use_dynamic_pin                                   FALSE
 TSPX_iut_SDU_size_in_bytes                             144
 TSPX_secure_simple_pairing_pass_key_confirmation       FALSE
 TSPX_iut_address_type_random                           FALSE
+TSPX_tester_adv_interval_min                           0030
+TSPX_tester_adv_interval_max                           0050
+TSPX_tester_le_scan_interval                           0C80
+TSPX_tester_le_scan_window                             0C80
+TSPX_tester_conn_interval_min                          0028
+TSPX_tester_conn_interval_max                          0050
+TSPX_tester_conn_latency                               0000
+TSPX_tester_supervision_timeout                        0C80
+TSPX_tester_min_CE_length                              0080
+TSPX_tester_max_CE_length                              0C80
 -------------------------------------------------------------------------------
diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index b625861..4faf65d 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -1,9 +1,9 @@
 PTS test results for L2CAP
 
-PTS version: 6.0
-Tested: 18-December-2014
-Android version: 5.0
-Kernel version: 3.18
+PTS version: 6.1
+Tested: 28-May-2015
+Android version: 5.1
+Kernel version: 4.1
 
 Results:
 PASS   test passed
@@ -19,18 +19,14 @@ Test Name		Result	Notes
 TC_COS_CED_BV_01_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_CED_BV_03_C	PASS	l2test -y -N 1 -P 4113 <bdaddr>
 TC_COS_CED_BV_04_C	PASS	l2test -n -P 4113 <bdaddr>
-TC_COS_CED_BV_05_C	PASS	PTS issue #12351
-				btmgmt ssp off
-				l2test -r -P 4113
+TC_COS_CED_BV_05_C	PASS	l2test -r -P 4113
 TC_COS_CED_BV_07_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_CED_BV_08_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_CED_BV_09_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_CED_BV_10_C	N/A
 TC_COS_CED_BV_11_C	PASS	l2test -u -P 4113 <bdaddr>
 TC_COS_CED_BI_01_C	PASS
-TC_COS_CFD_BV_01_C	PASS	PTS issue #12351
-				btmgmt ssp off
-				l2test -r -P 4113
+TC_COS_CFD_BV_01_C	PASS	l2test -r -P 4113
 TC_COS_CFD_BV_02_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_CFD_BV_03_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_CFD_BV_08_C	PASS	l2test -n -P 4113 <bdaddr>
@@ -153,32 +149,43 @@ TC_ECF_BV_05_C		N/A
 TC_ECF_BV_06_C		N/A
 TC_ECF_BV_07_C		N/A
 TC_ECF_BV_08_C		N/A
-TC_LE_CPU_BV_01_C	PASS	l2test -n -V le_public -J 4
+TC_LE_CPU_BV_01_C	PASS	btmgmt advertising on
+				l2test -r -V le_public -J 4
 TC_LE_CPU_BV_02_C	PASS	l2test -n -V le_public -J 4 <braddr>
 TC_LE_CPU_BI_01_C	PASS	l2test -n -V le_public -J 4 <braddr>
-TC_LE_CPU_BI_02_C	PASS	l2test -r -V le_public -J 4
+TC_LE_CPU_BI_02_C	PASS	btmgmt advertising on
+				l2test -r -V le_public -J 4
 TC_LE_REJ_BI_01_C	PASS	l2test -n -V le_public -J 4 <braddr>
 TC_LE_REJ_BI_02_C	PASS	l2test -n -V le_public -J 4 <braddr>
 TC_LE_CFC_BV_01_C	PASS	l2test -n -V le_public -P 37 <braddr>
 TC_LE_CFC_BV_02_C	PASS	l2test -n -V le_public -P 37 <braddr>
-TC_LE_CFC_BV_03_C	PASS	l2test -x -N 1 -V le_public <braddr>
-				Note: PIXIT TSPX_iut_role_initiator=FALSE
+TC_LE_CFC_BV_03_C	PASS	l2test -x -N 1 -V le_public
+				hcitool lecc <braddr>
+				hcitool ledc <handle>
 TC_LE_CFC_BV_04_C	PASS	l2test -n -V le_public -P 241 <braddr>
 TC_LE_CFC_BV_05_C	PASS	l2test -r -V le_public -J 4
-				Note: PIXIT TSPX_iut_role_initiator=FALSE
-TC_LE_CFC_BV_06_C	PASS	PTS issue #12853
-				Note: PIXIT TSPX_iut_role_initiator=FALSE
-				l2test -x -b 1 -V le_public <braddr>
+				hcitool lecc <braddr>
+				hcitool ledc <handle>
+TC_LE_CFC_BV_06_C	PASS	l2test -s -N 10 -V le_public <braddr>
 TC_LE_CFC_BV_07_C	PASS	l2test -u -V le_public <braddr>
 TC_LE_CFC_BI_01_C	PASS	l2test -u -V le_public <bdaddr>
 TC_LE_CFC_BV_08_C	PASS	l2test -n -V le_public -P 37 <braddr>
 TC_LE_CFC_BV_09_C	PASS	l2test -n -V le_public -P 37 <braddr>
 TC_LE_CFC_BV_16_C	PASS	l2test -n -V le_public -P 37 <braddr>
 TC_LE_CFC_BV_17_C	N/A
-TC_LE_CID_BV_01_C	INC	PTS issue #12730
-				l2test -s -N 1 <bdaddr>
-				l2test -s -N 1 -V le_public <bdaddr>
-TC_LE_CID_BV_02_I	INC	PTS issue #12730
-				Note: PIXIT TSPX_iut_role_initiator=FALSE
-				l2test -w -N 1
-				l2test -w -N 1 -V le_public
+TC_LE_CID_BV_01_C	PASS	PTS issue #12730
+				l2test -r -J 2
+				l2test -r -J 4 -V le_public
+				hcitool cc <braddr>
+				hcitool lecc --static <braddr>
+				l2test -s -N 1 -C 0 -e 5 -D 10000 <braddr>
+				l2test -s -N 1 -C 0 -D 10000 -g 10000 
+					-V le_public <braddr>
+TC_LE_CID_BV_02_I	PASS	PTS issue #12730
+				l2test -r -J 2
+				l2test -r -J 4 -V le_public
+				l2test -w -N 1 -C 0 -D 5000 -g 10000
+				l2test -w -N 1 -C 0 -D 5000 -e 5 -g 10000
+					-V le_public
+				hcitool cc <braddr>
+				hcitool lecc --static <braddr>
-- 
1.9.1

