Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/pts: Update PICS, PIXIT and tests for GAP
Date: Fri, 11 Apr 2014 11:20:46 +0200
Message-Id: <1397208046-30077-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This updates settings to PTS 5.1 and adjust PICS to enable some
supported features.
---
 android/pics-gap.txt  | 237 +++++++++++++++++++++++++++++---------------------
 android/pixit-gap.txt |   2 +-
 android/pts-gap.txt   | 158 +++++++++++++++++++--------------
 3 files changed, 230 insertions(+), 167 deletions(-)

diff --git a/android/pics-gap.txt b/android/pics-gap.txt
index 56a33d5..cd48332 100644
--- a/android/pics-gap.txt
+++ b/android/pics-gap.txt
@@ -1,9 +1,8 @@
 GAP PICS for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
-# - not yet implemented/supported
 
 M - mandatory
 O - optional
@@ -36,12 +35,18 @@ Note - Only one transport shall be supported.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_0A_1	False		Core Specification Addendum 3 (CSA3),
-					GAP Connection Parameters Changes,
+TSPC_GAP_0A_1	True (*)	Core Specification Addendum 3 (CSA3), GAP
+					Connection Parameters Changes,
 					Authentication and Lost Bond Changes,
-					Private Addressing Changes,
-					Dual Mode Addressing Changes,
+					Private Addressing Changes, Dual Mode
+					Addressing Changes,
 					Adopted 24 July 2012 (C.1)
+TSPC_GAP_0A_2	True (*)	Core Specification Addendum 4 (CSA4)
+TSPC_GAP_0A_3	True (*)	Core Spec version 4.1 (Core v4.1) GAP Connection
+					Parameters Changes, Authentication and
+					Lost Bond Changes, Private Addressing
+					Changes, Dual Mode Addressing Changes,
+					Adopted 03 December 2013
 -------------------------------------------------------------------------------
 C.1: Mandatory if 'CSA3 Adopted 24 July 2012' is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
@@ -52,12 +57,14 @@ C.1: Mandatory if 'CSA3 Adopted 24 July 2012' is supported, otherwise Excluded.
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_1_1	True (*)	Non-discoverable mode (C.1)
-TSPC_GAP_1_2	False		Limited-discoverable Mode (O)
+TSPC_GAP_1_2	True (*)	Limited-discoverable Mode (O)
 TSPC_GAP_1_3	True (*)	General-discoverable mode (O)
 TSPC_GAP_1_4	True (*)	Non-connectable mode (O)
 TSPC_GAP_1_5	True		Connectable mode (M)
 TSPC_GAP_1_6	False		Non-bondable mode (O)
 TSPC_GAP_1_7	True (*)	Bondable mode (C.2)
+TSPC_GAP_1_8	False		Non-Synchronizable Mode (O)
+TSPC_GAP_1_9	False		Synchronizable Mode (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_0_2 is supported, otherwise Optional.
 C.2: Mandatory if TSPC_GAP_3_5 is supported, otherwise Optional.
@@ -77,7 +84,8 @@ TSPC_GAP_2_6	False		Security mode 3 (C.7)
 TSPC_GAP_2_7	True (*)	Security mode 4 (C.4)
 TSPC_GAP_2_8	True (*)	Support of Authenticated link key (C.6)
 TSPC_GAP_2_9	True (*)	Support of Unauthenticated link key (C.6)
-TSPC_GAP_2_10	False		No security (C.6)
+TSPC_GAP_2_10	True (*)	No security (C.6)
+TSPC_GAP_2_11	False		Secure Connections Only Mode (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory If (TSPC_GAP_2_5 or TSPC_GAP_2_6) is supported, otherwise
 	Optional.
@@ -107,7 +115,7 @@ C.7: Excluded if TSPC_GAP_2_7 is supported, otherwise Optional.
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_3_1	True (*)	Initiation of general inquiry (C.1)
-TSPC_GAP_3_2	False		Initiation of limited inquiry (C.1)
+TSPC_GAP_3_2	True (*)	Initiation of limited inquiry (C.1)
 TSPC_GAP_3_3	True (*)	Initiation of name discover (O)
 TSPC_GAP_3_4	True (*)	Initiation of device discovery (O)
 TSPC_GAP_3_5	True (*)	Initiation of general bonding (O)
@@ -130,6 +138,8 @@ TSPC_GAP_4_5	True (*)	Support connection establishment as initiator
 					(O)
 TSPC_GAP_4_6	True (*)	Support connection establishment as acceptor
 					(O)
+TSPC_GAP_4_7	True (*)	Support synchronization establishment
+					as receiver (O)
 -------------------------------------------------------------------------------
 
 
@@ -140,7 +150,7 @@ Parameter Name	Selected	Description
 TSPC_GAP_5_1	False (*)	Broadcaster (C.1)
 TSPC_GAP_5_2	False		Observer (C.1)
 TSPC_GAP_5_3	False (*)	Peripheral (C.1)
-TSPC_GAP_5_4	True (*#)	Central (C.1)
+TSPC_GAP_5_4	True (*)	Central (C.1)
 -------------------------------------------------------------------------------
 C.1: It is mandatory to support at least one of the defined roles.
 Note: 'LE Roles' is applicable for LE-only configurations, but it appears that
@@ -182,7 +192,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_8A_1	False		AD Type-Service UUID (O)
 TSPC_GAP_8A_2	False		AD Type-Local Name (O)
-TSPC_GAP_8A_3	False (*)	AD Type-Flags (M)
+TSPC_GAP_8A_3	False (*)	AD Type-Flags (O)
 TSPC_GAP_8A_4	False		AD Type-Manufacturer Specific Data (O)
 TSPC_GAP_8A_5	False		AD Type-TX Power Level (O)
 TSPC_GAP_8A_6	False		AD Type-Security Manager Out of Band (OOB) (C.1)
@@ -190,6 +200,12 @@ TSPC_GAP_8A_7	False		AD Type-Security manager TK Value (O)
 TSPC_GAP_8A_8	False		AD Type-Slave Connection Interval Range (O)
 TSPC_GAP_8A_9	False		AD Type-Service Solicitation (O)
 TSPC_GAP_8A_10	False		AD Type-Service Data (O)
+TSPC_GAP_8A_11	False		AD Type-Appearance (O)
+TSPC_GAP_8A_12	False		AD Type-Public Target Address (O)
+TSPC_GAP_8A_13	False		AD Type-Random Target Address (O)
+TSPC_GAP_8A_14	False		AD Type-Advertising Interval (O)
+TSPC_GAP_8A_15	False		AD Type-LE Bluetooth Device Address (O)
+TSPC_GAP_8A_16	False		AD Type –LE Role (O)
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_SM_2_4 (OOB supported) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
@@ -209,8 +225,11 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_10_1	False (*)	Broadcaster: Broadcast Mode
 TSPC_GAP_11_1	False		Broadcaster: Privacy Feature
+TSPC_GAP_11_1A	False (*)	Broadcaster: Privacy Feature v1.1 (O)
 TSPC_GAP_11_2	False		Broadcaster: Resolvable Private Address
 					Generation Procedure
+TSPC_GAP_11_3	False (*)	Broadcaster: Non-Resolvable Private Address
+					Generation Procedure (O)
 -------------------------------------------------------------------------------
 
 
@@ -218,7 +237,7 @@ TSPC_GAP_11_2	False		Broadcaster: Resolvable Private Address
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_12_1	True (#)	Observer: Receiver
+TSPC_GAP_12_1	False (*)	Observer: Receiver
 TSPC_GAP_12_2	False		Observer: Transmitter
 -------------------------------------------------------------------------------
 
@@ -227,8 +246,8 @@ TSPC_GAP_12_2	False		Observer: Transmitter
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_13_1	True (#)	Observer: Standby
-TSPC_GAP_13_2	True (#)	Observer: Scanning
+TSPC_GAP_13_1	False (*)	Observer: Standby
+TSPC_GAP_13_2	False (*)	Observer: Scanning
 -------------------------------------------------------------------------------
 
 
@@ -236,7 +255,7 @@ TSPC_GAP_13_2	True (#)	Observer: Scanning
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_14_1	True (#)	Observer: Passive Scanning
+TSPC_GAP_14_1	False (*)	Observer: Passive Scanning
 TSPC_GAP_14_2	False		Observer: Active Scanning
 -------------------------------------------------------------------------------
 
@@ -245,7 +264,7 @@ TSPC_GAP_14_2	False		Observer: Active Scanning
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_15_1	True (#)	Observer: Non-Connectable Mode
+TSPC_GAP_15_1	False (*)	Observer: Non-Connectable Mode
 -------------------------------------------------------------------------------
 
 
@@ -253,7 +272,7 @@ TSPC_GAP_15_1	True (#)	Observer: Non-Connectable Mode
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_16_1	True (#)	Observer: Observation Procedure
+TSPC_GAP_16_1	False (*)	Observer: Observation Procedure
 -------------------------------------------------------------------------------
 
 
@@ -262,6 +281,7 @@ TSPC_GAP_16_1	True (#)	Observer: Observation Procedure
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_17_1	False		Observer: Privacy Feature (O)
+TSPC_GAP_17_1A	False		Observer: Privacy Feature v1.1 (O)
 TSPC_GAP_17_2	False		Observer: Non-Resolvable Private Address
 					Generation Procedure (C.1)
 TSPC_GAP_17_3	False		Observer: Resolvable Private Address Resolution
@@ -305,8 +325,9 @@ TSPC_GAP_19_3	False		Peripheral: Connection, Slave Role
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_20_1	False		Peripheral: Connectable Undirected Event
-TSPC_GAP_20_2	False		Peripheral: Connectable Directed Event
+TSPC_GAP_20_1	False		Peripheral: Connectable Undirected Event (C.1)
+TSPC_GAP_20_2	False		Peripheral: Connectable Directed Event (C.2)
+TSPC_GAP_20_2A	False		Peripheral: Low Duty Directed Advertising (C.3)
 TSPC_GAP_20_3	False		Peripheral: Non-Connectable Undirected Event
 TSPC_GAP_20_4	False		Peripheral: Scannable Undirected Event
 -------------------------------------------------------------------------------
@@ -326,6 +347,12 @@ TSPC_GAP_20A_7	False		AD Type-Security manager TK Value (C.1)
 TSPC_GAP_20A_8	False		AD Type-Slave Connection Interval Range (C.1)
 TSPC_GAP_20A_9	False		AD Type-Service Solicitation (C.1)
 TSPC_GAP_20A_10	False		AD Type-Service Data (C.1)
+TSPC_GAP_20A_11	False		AD Type –Appearance (C.1)
+TSPC_GAP_20A_12	False		AD Type-Public Target Address (C.1)
+TSPC_GAP_20A_13	False		AD Type-Random Target Address (C.1)
+TSPC_GAP_20A_14	False		AD Type-Advertising Interval (C.1)
+TSPC_GAP_20A_15	False		AD Type-LE Bluetooth Device Address (C.1)
+TSPC_GAP_20A_16	False		AD Type – LE Role (C.1)
 -------------------------------------------------------------------------------
 C.1: Optional if (TSPC_GAP_20_1 or TSPC_GAP_20_3 or TSPC_GAP_20_4) is
 	supported, otherwise Excluded.
@@ -348,6 +375,11 @@ TSPC_GAP_21_3	False		Peripheral: Encryption Procedure (O)
 TSPC_GAP_21_4	False (*)	Peripheral: Feature Exchange Procedure (M)
 TSPC_GAP_21_5	False (*)	Peripheral: Version Exchange Procedure (M)
 TSPC_GAP_21_6	False (*)	Peripheral: Termination Procedure (M)
+TSPC_GAP_21_7	False (*)	Peripheral: LE Ping Procedure (C.3)
+TSPC_GAP_21_8	False (*)	Peripheral: Slave Initiated Feature Exchange
+					Procedure (C.4)
+TSPC_GAP_21_9	False (*)	Peripheral: Connection Parameter Request
+					Procedure (C.5)
 -------------------------------------------------------------------------------
 
 
@@ -429,10 +461,13 @@ C.2: Mandatory if TSPC_GAP_0A_1 and TSPC_GAP_27_4 are supported,
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_26_1	False		Peripheral: Privacy Feature (O)
+TSPC_GAP_26_1A	False		Peripheral: Privacy Feature v1.1 (O)
 TSPC_GAP_26_2	False		Peripheral: Non-Resolvable Private Address
 					Generation Procedure (C.1)
 TSPC_GAP_26_3	False		Peripheral: Resolvable Private Address
 					Generation Procedure (C.2)
+TSPC_GAP_26_4	False		Peripheral: Resolvable Private Address
+					Generation Procedure (C.4)
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_GAP_26_1 is supported, otherwise Excluded.
 C.2: Mandatory if TSPC_GAP_26_1 is supported, otherwise Excluded.
@@ -464,8 +499,8 @@ C.2: Optional if TSPC_GAP_26_1 and TSPC_GAP_27_3 are supported,
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_28_1	True (*#)	Central: Transmitter (M)
-TSPC_GAP_28_2	True (*#)	Central: Receiver (M)
+TSPC_GAP_28_1	True (*)	Central: Transmitter (M)
+TSPC_GAP_28_2	True (*)	Central: Receiver (M)
 -------------------------------------------------------------------------------
 
 
@@ -473,10 +508,10 @@ TSPC_GAP_28_2	True (*#)	Central: Receiver (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_29_1	True (*#)	Central: Standby (M)
-TSPC_GAP_29_2	True (*#)	Central: Scanning (M)
-TSPC_GAP_29_3	True (*#)	Central: Initiating (M)
-TSPC_GAP_29_4	True (*#)	Central: Connection, Master Role (M)
+TSPC_GAP_29_1	True (*)	Central: Standby (M)
+TSPC_GAP_29_2	True (*)	Central: Scanning (M)
+TSPC_GAP_29_3	True (*)	Central: Initiating (M)
+TSPC_GAP_29_4	True (*)	Central: Connection, Master Role (M)
 -------------------------------------------------------------------------------
 
 
@@ -484,8 +519,8 @@ TSPC_GAP_29_4	True (*#)	Central: Connection, Master Role (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_30_1	True (*#)	Central: Passive Scanning (O)
-TSPC_GAP_30_2	True (*#)	Central: Active Scanning (C.1)
+TSPC_GAP_30_1	True (*)	Central: Passive Scanning (O)
+TSPC_GAP_30_2	True (*)	Central: Active Scanning (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory if (TSPC_GAP_5_4 or TSPC_GAP_38_4) is supported.
 	Optional if TSPC_GAP_30_1 and (TSPC_GAP_5_4 OR TSPC_GAP_38_4)
@@ -497,12 +532,17 @@ C.1: Mandatory if (TSPC_GAP_5_4 or TSPC_GAP_38_4) is supported.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_31_1	True (*#)	Central: Connection Update Procedure (M)
-TSPC_GAP_31_2	True (*#)	Central: Channel Map Update Procedure (M)
-TSPC_GAP_31_3	True (*#)	Central: Encryption Procedure (O)
-TSPC_GAP_31_4	True (*#)	Central: Feature Exchange Procedure (M)
-TSPC_GAP_31_5	True (*#)	Central: Version Exchange Procedure (M)
-TSPC_GAP_31_6	True (*#)	Central: Termination Procedure (M)
+TSPC_GAP_31_1	True ()	Central: Connection Update Procedure (M)
+TSPC_GAP_31_2	True ()	Central: Channel Map Update Procedure (M)
+TSPC_GAP_31_3	True (*)	Central: Encryption Procedure (O)
+TSPC_GAP_31_4	True ()	Central: Feature Exchange Procedure (M)
+TSPC_GAP_31_5	True ()	Central: Version Exchange Procedure (M)
+TSPC_GAP_31_6	True ()	Central: Termination Procedure (M)
+TSPC_GAP_31_7	True (*)	Central: LE Ping Procedure (C.1)
+TSPC_GAP_31_8	True (*)	Central: Slave Initiated Feature Exchange
+					Procedure (C.2)
+TSPC_GAP_31_9	True (*)	Central: Connection Parameter Request Procedure
+					(C.3)
 -------------------------------------------------------------------------------
 
 
@@ -510,9 +550,9 @@ TSPC_GAP_31_6	True (*#)	Central: Termination Procedure (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_32_1	False		Central: Limited Discovery Procedure (C.2)
-TSPC_GAP_32_2	True (*#)	Central: General Discovery Procedure (C.1)
-TSPC_GAP_32_3	True (*#)	Central: Name Discovery Procedure (C.3)
+TSPC_GAP_32_1	True (*)	Central: Limited Discovery Procedure (C.2)
+TSPC_GAP_32_2	True (*)	Central: General Discovery Procedure (C.1)
+TSPC_GAP_32_3	True (*)	Central: Name Discovery Procedure (C.3)
 -------------------------------------------------------------------------------
 C.1: Mandatory if (TSPC_GAP_5_4 or TSPC_GAP_40_1) is supported, else Excluded.
 C.2: Optional if (TSPC_GAP_5_4 or TSPC_GAP_40_2) is supported,
@@ -526,17 +566,17 @@ C.3: Optional if (TSPC_GAP_5_4 or TSPC_GAP_40_4) is supported,
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_33_1	True (*#)	Central: Auto Connection Establishment
+TSPC_GAP_33_1	True (*)	Central: Auto Connection Establishment
 					Procedure (C.3)
-TSPC_GAP_33_2	True (*#)	Central: General Connection Establishment
+TSPC_GAP_33_2	True (*)	Central: General Connection Establishment
 					Procedure (C.1)
-TSPC_GAP_33_3	True (*#)	Central: Selective Connection Establishment
+TSPC_GAP_33_3	True (*)	Central: Selective Connection Establishment
 					Procedure (C.3)
-TSPC_GAP_33_4	True (*#)	Central: Direct Connectin Establishment
+TSPC_GAP_33_4	True (*)	Central: Direct Connectin Establishment
 					Procedure (C.2)
-TSPC_GAP_33_5	True (*#)	Central: Connection Parameter Update Procedure
+TSPC_GAP_33_5	True (*)	Central: Connection Parameter Update Procedure
 					(C.2)
-TSPC_GAP_33_6	True (*#)	Central: Terminate Connection Procedure
+TSPC_GAP_33_6	True (*)	Central: Terminate Connection Procedure
 					(C.2)
 -------------------------------------------------------------------------------
 C.1: Mandatory if (TSPC_GAP_5_4 or TSPC_GAP_40_5) and TSPC_GAP_36_1 is
@@ -552,9 +592,9 @@ C.3: Optional if (TSPC_GAP_5_4 or TSPC_GAP_40_5) is supported,
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_34_1	False		Central: Non-Bondable Mode (C.1)
-TSPC_GAP_34_2	True (*#)	Central: Bondable Mode (C.2)
-TSPC_GAP_34_3	True (*#)	Central: Bonding Procedure (O)
+TSPC_GAP_34_1	True (*)	Central: Non-Bondable Mode (C.1)
+TSPC_GAP_34_2	True (*)	Central: Bondable Mode (C.2)
+TSPC_GAP_34_3	True (*)	Central: Bonding Procedure (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory if (TSPC_GAP_5_4 or 39/5) is supported, otherwise Excluded.
 C.2: Optional if (TSPC_GAP_5_4 or 39/6) is supported, otherwise Excluded.
@@ -565,15 +605,15 @@ C.2: Optional if (TSPC_GAP_5_4 or 39/6) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_35_1	True (*#)	Central: Security Mode 1 (O)
-TSPC_GAP_35_2	True (*#)	Central: Security Mode 2 (O)
-TSPC_GAP_35_3	True (*#)	Central: Authentication Procedure (O)
-TSPC_GAP_35_4	True (*#)	Central: Authorization Procedure (O)
-TSPC_GAP_35_5	True (*#)	Central: Connection Data Signing Procedure (O)
-TSPC_GAP_35_6	True (*#)	Central: Authenticate Signed Data Procedure (O)
-TSPC_GAP_35_7	False		Central: Authenticated Pairing
+TSPC_GAP_35_1	True (*)	Central: Security Mode 1 (O)
+TSPC_GAP_35_2	True (*)	Central: Security Mode 2 (O)
+TSPC_GAP_35_3	True (*)	Central: Authentication Procedure (O)
+TSPC_GAP_35_4	True (*)	Central: Authorization Procedure (O)
+TSPC_GAP_35_5	True (*)	Central: Connection Data Signing Procedure (O)
+TSPC_GAP_35_6	True (*)	Central: Authenticate Signed Data Procedure (O)
+TSPC_GAP_35_7	True (*)	Central: Authenticated Pairing
 					(LE security mode 1 level 3) (C.1)
-TSPC_GAP_35_8	False		Central: Unauthenticated Pairing
+TSPC_GAP_35_8	True (*)	Central: Unauthenticated Pairing
 					(LE security mode 1 level 2) (C.1)
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_GAP_35_1 is supported, otherwise Excluded.
@@ -584,13 +624,16 @@ C.1: Optional if TSPC_GAP_35_1 is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_36_1	False		Central: Privacy Feature (C.3)
-TSPC_GAP_36_2	False		Central: Non-Resolvable Private Address
+TSPC_GAP_36_1	True (*)	Central: Privacy Feature (C.3)
+TSPC_GAP_36_1A	True (*)	Central: Privacy Feature v1.1 (C.4)
+TSPC_GAP_36_2	True (*)	Central: Non-Resolvable Private Address
 					Generation Procedure (C.1)
-TSPC_GAP_36_3	False		Central: Resolvable Private Address Resolution
+TSPC_GAP_36_3	True (*)	Central: Resolvable Private Address Resolution
 					Procedure (C.2)
-TSPC_GAP_36_4	False		Central: Write to Privacy Characteristic
+TSPC_GAP_36_4	True (*)	Central: Write to Privacy Characteristic
 					(Enable/Disable Privacy) (O)
+TSPC_GAP_36_5	True (*)	Central: Resolvable Private Address Generation
+					Procedure (C.6)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_36_1 and TSPC_GAP_30_2 are supported,
 	otherwise Excluded.
@@ -602,8 +645,8 @@ C.2: Mandatory if TSPC_GAP_36_1 is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_37_1	True (*#)	Central: Device Name (M)
-TSPC_GAP_37_2	True (*#)	Central: Appearance (M)
+TSPC_GAP_37_1	True (*)	Central: Device Name (M)
+TSPC_GAP_37_2	True (*)	Central: Appearance (M)
 -------------------------------------------------------------------------------
 
 
@@ -612,9 +655,9 @@ TSPC_GAP_37_2	True (*#)	Central: Appearance (M)
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_38_1	False		BR/EDR/LE: Broadcaster (C.1)
-TSPC_GAP_38_2	True (*#)	BR/EDR/LE: Observer (C.1)
+TSPC_GAP_38_2	False		BR/EDR/LE: Observer (C.1)
 TSPC_GAP_38_3	False		BR/EDR/LE: Peripheral (C.1)
-TSPC_GAP_38_4	True (*#)	BR/EDR/LE: Central (C.1)
+TSPC_GAP_38_4	True (*)	BR/EDR/LE: Central (C.1)
 -------------------------------------------------------------------------------
 C.1: It is mandatory to support at least one of the defined roles.
 This table is applicable for BR/EDR/LE configurations. For LE-only
@@ -626,12 +669,12 @@ configurations, see 'LE Roles' table for role declarations.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_39_1	True (*#)	Central BR/EDR/LE: Non-Discoverable Mode (C.1)
-TSPC_GAP_39_2	True (*#)	Central BR/EDR/LE: Discoverable Mode (C.2)
-TSPC_GAP_39_3	True (*#)	Central BR/EDR/LE: Non-Connectable Mode (C.3)
-TSPC_GAP_39_4	True (#)	Central BR/EDR/LE: Connectable Mode (M)
+TSPC_GAP_39_1	True (*)	Central BR/EDR/LE: Non-Discoverable Mode (C.1)
+TSPC_GAP_39_2	True (*)	Central BR/EDR/LE: Discoverable Mode (C.2)
+TSPC_GAP_39_3	True (*)	Central BR/EDR/LE: Non-Connectable Mode (C.3)
+TSPC_GAP_39_4	True ()	Central BR/EDR/LE: Connectable Mode (M)
 TSPC_GAP_39_5	False		Central BR/EDR/LE: Non-Bondable Mode (C.4)
-TSPC_GAP_39_6	True (*#)	Central BR/EDR/LE: Bondable Mode (C.5)
+TSPC_GAP_39_6	True (*)	Central BR/EDR/LE: Bondable Mode (C.5)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_1_1 is supported over BR/EDR, otherwise Excluded.
 C.2: Mandatory if (TSPC_GAP_1_2 or TSPC_GAP_1_3) is supported over BR/EDR,
@@ -646,11 +689,11 @@ C.5: Mandatory if TSPC_GAP_1_7 is supported over BR/EDR, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_40_1	True (*#)	Central BR/EDR/LE: General Discovery (C.1)
-TSPC_GAP_40_2	False		Central BR/EDR/LE: Limited Discovery (C.2)
-TSPC_GAP_40_3	True (*#)	Central BR/EDR/LE: Device Type Discovery (C.3)
-TSPC_GAP_40_4	True (*#)	Central BR/EDR/LE: Name Discovery (C.4)
-TSPC_GAP_40_5	True (*#)	Central BR/EDR/LE: Link Establishment (C.5)
+TSPC_GAP_40_1	True (*)	Central BR/EDR/LE: General Discovery (C.1)
+TSPC_GAP_40_2	True (*)	Central BR/EDR/LE: Limited Discovery (C.2)
+TSPC_GAP_40_3	True (*)	Central BR/EDR/LE: Device Type Discovery (C.3)
+TSPC_GAP_40_4	True (*)	Central BR/EDR/LE: Name Discovery (C.4)
+TSPC_GAP_40_5	True (*)	Central BR/EDR/LE: Link Establishment (C.5)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_3_1 is supported over BR/EDR, otherwise Excluded.
 C.2: Mandatory if TSPC_GAP_3_2 is supported over BR/EDR, otherwise Excluded.
@@ -666,21 +709,7 @@ C.5: Mandatory if (TSPC_GAP_4_1 or TSPC_GAP_4_2) is supported over BR/EDR,
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_41_1	True (#)	Central BR/EDR/LE: Security Aspects (M)
--------------------------------------------------------------------------------
-
-
-		Central Simultaneous BR/EDR and LE Transports
--------------------------------------------------------------------------------
-Parameter Name	Selected	Description
--------------------------------------------------------------------------------
-TSPC_GAP_42_1	False		Simultaneous BR/EDR and LE Transports –	BR/EDR
-					Slave to the same device (C.1)
-TSPC_GAP_42_2	False		Simultaneous BR/EDR and LE Transports – BR/EDR
-					Master to the same device (C.1)
--------------------------------------------------------------------------------
-C.1: Optional if ((SUM ICS 31/14 (Core Spec Version 4.1) or SUM ICS 31/15
-	(Core Spec Version 4.1+HS)) is supported, otherwise Excluded.
+TSPC_GAP_41_1	True ()	Central BR/EDR/LE: Security Aspects (M)
 -------------------------------------------------------------------------------
 
 
@@ -688,15 +717,12 @@ C.1: Optional if ((SUM ICS 31/14 (Core Spec Version 4.1) or SUM ICS 31/15
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_43_1	False		Peripheral BR/EDR/LE: Non-Discoverable Mode
-				(C.1)
-TSPC_GAP_43_2	False		Peripheral BR/EDR/LE: Discoverable Mode
-				(C.2)
-TSPC_GAP_43_3	False		Peripheral BR/EDR/LE: Non-Connectable Mode
-				(C.3)
-TSPC_GAP_43_4	False (*)	Peripheral BR/EDR/LE: Connectable Mode  (M)
-TSPC_GAP_43_5	False		Peripheral BR/EDR/LE: Non-Bondable Mode (C.4)
-TSPC_GAP_43_6	False		Peripheral BR/EDR/LE: Bondable Mode (C.5)
+TSPC_GAP_42_1	False		Peripheral BR/EDR/LE: Non-Discoverable Mode (See Spec)
+TSPC_GAP_42_2	False		Peripheral BR/EDR/LE: Discoverable Mode (See Spec)
+TSPC_GAP_42_3	False		Peripheral BR/EDR/LE: Non-Connectable Mode (See Spec)
+TSPC_GAP_42_4	False (*)	Peripheral BR/EDR/LE: Connectable Mode (M)
+TSPC_GAP_42_5	False		Peripheral BR/EDR/LE: Non-Bondable Mode (See Spec)
+TSPC_GAP_42_6	False		Peripheral BR/EDR/LE: Bondable Mode (See Spec)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_1_1 is supported over BR/EDR, otherwise Excluded.
 C.2: Mandatory if (TSPC_GAP_1_2 or TSPC_GAP_1_3) is supported over BR/EDR,
@@ -711,7 +737,20 @@ C.5: Mandatory if TSPC_GAP_1_7 is supported over BR/EDR, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_44_1	False (*)	Peripheral BR/EDR/LE: Security Aspects (M)
+TSPC_GAP_43_1	False (*)	Peripheral BR/EDR/LE: Non-Discoverable Mode
+-------------------------------------------------------------------------------
+
+
+		Central Simultaneous BR/EDR and LE Transports
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_GAP_44_1	True (*)	Central BR/EDR/LE: Simultaneous BR/EDR and LE
+					Transports – BR/EDR Slave to the same
+					device (O)
+TSPC_GAP_44_2	True (*)	Central BR/EDR/LE: Simultaneous BR/EDR and LE
+					Transports – BR/EDR Master to the same
+					device (O)
 -------------------------------------------------------------------------------
 
 
@@ -732,8 +771,8 @@ C.1: Optional if ((SUM ICS 31/14 (Core Spec Version 4.1) or SUM ICS 31/15
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_SM_1_1	False		Master Role (Initiator)
-TSPC_SM_1_2	False		Slave Role (Responder)
-TSPC_SM_2_4	False		OOB supported (O)
+TSPC_SM_1_1	True (*)	Master Role (Initiator)
+TSPC_SM_1_2	True (*)	Slave Role (Responder)
+TSPC_SM_2_4	True (*)	OOB supported (O)
 TSPC_ALL	False		Turns on all
 -------------------------------------------------------------------------------
diff --git a/android/pixit-gap.txt b/android/pixit-gap.txt
index f3c7726..494e24d 100644
--- a/android/pixit-gap.txt
+++ b/android/pixit-gap.txt
@@ -1,6 +1,6 @@
 GAP PIXIT for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index 9526038..8be9a5a 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -1,7 +1,7 @@
 PTS test results for GAP
 
-PTS version: 5.0
-Tested: 28-Jan-2014
+PTS version: 5.1
+Tested: 11-April-2014
 Android version: 4.4.2
 
 Results:
@@ -13,10 +13,10 @@ N/A	test is disabled due to PICS setup
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_MOD_NDIS_BV_01_C	PASS	IUT must be in non-discoverable mode
-TC_MOD_LDIS_BV_01_C	N/A
-TC_MOD_LDIS_BV_02_C	N/A
-TC_MOD_LDIS_BV_03_C	N/A
+TC_MOD_NDIS_BV_01_C	PASS	IUT must be non-discoverable
+TC_MOD_LDIS_BV_01_C	PASS	btmgmt discov limited 30
+TC_MOD_LDIS_BV_02_C	PASS	btmgmt discov limited 30
+TC_MOD_LDIS_BV_03_C	PASS	btmgmt discov limited 30
 TC_MOD_GDIS_BV_01_C	PASS	IUT must be discoverable
 TC_MOD_GDIS_BV_02_C	PASS	IUT must be discoverable
 TC_MOD_NCON_BV_01_C	PASS	btmgmt connectable off
@@ -39,20 +39,30 @@ TC_DISC_GENM_BV_01_C	N/A
 TC_DISC_GENM_BV_02_C	N/A
 TC_DISC_GENM_BV_03_C	N/A
 TC_DISC_GENM_BV_04_C	N/A
-TC_DISC_LIMP_BV_01_C	N/A
-TC_DISC_LIMP_BV_02_C	N/A
-TC_DISC_LIMP_BV_03_C	N/A
-TC_DISC_LIMP_BV_04_C	N/A
-TC_DISC_LIMP_BV_05_C	N/A
-TC_DISC_GENP_BV_01_C	INC	LE not supported yet
-TC_DISC_GENP_BV_02_C	INC	LE not supported yet
-TC_DISC_GENP_BV_03_C	INC	LE not supported yet
-TC_DISC_GENP_BV_04_C	INC	LE not supported yet
-TC_DISC_GENP_BV_05_C	INC	LE not supported yet
-TC_IDLE_GIN_BV_01_C	PASS	Start inquiry from IUT
-TC_IDLE_LIN_BV_01_C	N/A
-TC_IDLE_NAMP_BV_01_C	INC	LE not supported yet
-TC_IDLE_NAMP_BV_02_C	INC	LE not supported yet
+TC_DISC_LIMP_BV_01_C	PASS	btmgmt find -l
+				PTS AD flags must have bit 1 unset and bit 0 set
+TC_DISC_LIMP_BV_02_C	PASS	btmgmt find -l
+				PTS AD flags must have bit 1 set and bit 0 unset
+TC_DISC_LIMP_BV_03_C	PASS	btmgmt find -l
+				PTS AD flags must have bit 1 and bit 0 unset
+TC_DISC_LIMP_BV_04_C	PASS	btmgmt find -l
+				PTS AD flags must have bit 1 and bit 0 unset
+TC_DISC_LIMP_BV_05_C	PASS	btmgmt find -l
+				PTS AD flags must have bit 1 and bit 0 unset
+TC_DISC_GENP_BV_01_C	PASS	btmgmt find -l
+				PTS AD flags must have bit 1 set and bit 0 unset
+TC_DISC_GENP_BV_02_C	PASS	btmgmt find -l
+				PTS AD flags must have bit 1 unset and bit 0 set
+TC_DISC_GENP_BV_03_C	PASS	btmgmt find -l
+				PTS AD flags must have bit 1 and bit 0 unset
+TC_DISC_GENP_BV_04_C	PASS	btmgmt find -l
+				PTS AD flags must have bit 1 and bit 0 unset
+TC_DISC_GENP_BV_05_C	PASS	btmgmt find -l
+				PTS AD flags must have bit 1 and bit 0 unset
+TC_IDLE_GIN_BV_01_C	PASS	Start discovery from IUT
+TC_IDLE_LIN_BV_01_C	PASS	hcitool scan --iac=liac
+TC_IDLE_NAMP_BV_01_C	PASS
+TC_IDLE_NAMP_BV_02_C	INC
 TC_CONN_NCON_BV_01_C	N/A
 TC_CONN_NCON_BV_02_C	N/A
 TC_CONN_NCON_BV_03_C	N/A
@@ -64,63 +74,65 @@ TC_CONN_UCON_BV_02_C	N/A
 TC_CONN_UCON_BV_03_C	N/A
 TC_CONN_UCON_BV_04_C	N/A
 TC_CONN_UCON_BV_05_C	N/A
-TC_CONN_ACEP_BV_01_C	INC	LE not supported yet
-TC_CONN_ACEP_BV_02_C	N/A
-TC_CONN_GCEP_BV_01_C	INC	LE not supported yet
-TC_CONN_GCEP_BV_02_C	INC	LE not supported yet
-TC_CONN_GCEP_BV_03_C	N/A
-TC_CONN_GCEP_BV_04_C	N/A
-TC_CONN_SCEP_BV_01_C	INC	LE not supported yet
-TC_CONN_SCEP_BV_02_C	N/A
-TC_CONN_DCEP_BV_01_C	INC	LE not supported yet
-TC_CONN_DCEP_BV_02_C	N/A
-TC_CONN_DCEP_BV_03_C	INC	LE not supported yet
-TC_CONN_DCEP_BV_04_C	N/A
+TC_CONN_ACEP_BV_01_C	INC
+TC_CONN_ACEP_BV_02_C	INC
+TC_CONN_GCEP_BV_01_C	INC
+TC_CONN_GCEP_BV_02_C	INC
+TC_CONN_GCEP_BV_03_C	INC
+TC_CONN_GCEP_BV_04_C	INC
+TC_CONN_SCEP_BV_01_C	INC
+TC_CONN_SCEP_BV_02_C	INC
+TC_CONN_DCEP_BV_01_C	INC
+TC_CONN_DCEP_BV_02_C	INC
+TC_CONN_DCEP_BV_03_C	PASS
+TC_CONN_DCEP_BV_04_C	INC
 TC_CONN_CPUP_BV_01_C	N/A
 TC_CONN_CPUP_BV_02_C	N/A
 TC_CONN_CPUP_BV_03_C	N/A
-TC_CONN_CPUP_BV_04_C	INC	LE not supported yet
-TC_CONN_CPUP_BV_05_C	INC	LE not supported yet
-TC_CONN_CPUP_BV_06_C	INC	LE not supported yet
-TC_CONN_TERM_BV_01_C	INC	LE not supported yet
+TC_CONN_CPUP_BV_04_C	PASS
+TC_CONN_CPUP_BV_05_C	PASS
+TC_CONN_CPUP_BV_06_C	INC
+TC_CONN_TERM_BV_01_C	PASS
 TC_CONN_PRDA_BV_01_C	N/A
-TC_CONN_PRDA_BV_02_C	INC	LE not supported yet
-TC_BOND_NBON_BV_01_C	N/A
-TC_BOND_NBON_BV_02_C	N/A
+TC_CONN_PRDA_BV_02_C	INC
+TC_BOND_NBON_BV_01_C	PASS
+TC_BOND_NBON_BV_02_C	INC
 TC_BOND_NBON_BV_03_C	N/A
 TC_BOND_BON_BV_01_C	N/A
-TC_BOND_BON_BV_02_C	INC	LE not supported yet
+TC_BOND_BON_BV_02_C	INC
 TC_BOND_BON_BV_03_C	N/A
-TC_BOND_BON_BV_04_C	INC	LE not supported yet
+TC_BOND_BON_BV_04_C	INC
 TC_SEC_AUT_BV_11_C	N/A
-TC_SEC_AUT_BV_12_C	INC	LE not supported yet
-TC_SEC_AUT_BV_13_C	N/A
+TC_SEC_AUT_BV_12_C	INC
+TC_SEC_AUT_BV_13_C	INC
 TC_SEC_AUT_BV_14_C	N/A
 TC_SEC_AUT_BV_15_C	N/A
-TC_SEC_AUT_BV_16_C	INC	LE not supported yet
-TC_SEC_AUT_BV_17_C	N/A
+TC_SEC_AUT_BV_16_C	INC
+TC_SEC_AUT_BV_17_C	INC
 TC_SEC_AUT_BV_18_C	N/A
-TC_SEC_AUT_BV_19_C	N/A
+TC_SEC_AUT_BV_19_C	INC
 TC_SEC_AUT_BV_20_C	N/A
-TC_SEC_AUT_BV_21_C	N/A
+TC_SEC_AUT_BV_21_C	INC
 TC_SEC_AUT_BV_22_C	N/A
 TC_SEC_AUT_BV_23_C	N/A
-TC_SEC_AUT_BV_24_C	N/A
-TC_SEC_CSIGN_BV_01_C	INC	LE not supported yet
-TC_SEC_CSIGN_BV_02_C	INC	LE not supported yet
-TC_SEC_CSIGN_BI_01_C	INC	LE not supported yet
-TC_SEC_CSIGN_BI_02_C	INC	LE not supported yet
-TC_SEC_CSIGN_BI_03_C	INC	LE not supported yet
-TC_SEC_CSIGN_BI_04_C	INC	LE not supported yet
-TC_PRIV_CONN_BV_01_C	N/A
-TC_PRIV_CONN_BV_02_C	N/A
-TC_PRIV_CONN_BV_03_C	N/A
-TC_PRIV_CONN_BV_04_C	N/A
+TC_SEC_AUT_BV_24_C	INC
+TC_SEC_CSIGN_BV_01_C	INC
+TC_SEC_CSIGN_BV_02_C	INC
+TC_SEC_CSIGN_BI_01_C	INC
+TC_SEC_CSIGN_BI_02_C	INC
+TC_SEC_CSIGN_BI_03_C	INC
+TC_SEC_CSIGN_BI_04_C	INC
+TC_PRIV_CONN_BV_01_C	INC
+TC_PRIV_CONN_BV_02_C	INC
+TC_PRIV_CONN_BV_03_C	INC
+TC_PRIV_CONN_BV_04_C	INC
 TC_PRIV_CONN_BV_05_C	N/A
 TC_PRIV_CONN_BV_06_C	N/A
 TC_PRIV_CONN_BV_07_C	N/A
 TC_PRIV_CONN_BV_08_C	N/A
 TC_PRIV_CONN_BV_09_C	N/A
+TC_PRIV_CONN_BV_10_C	N/A
+TC_PRIV_CONN_BV_11_C	INC
 TC_ADV_BV_01_C		N/A
 TC_ADV_BV_02_C		N/A
 TC_ADV_BV_03_C		N/A
@@ -131,7 +143,13 @@ TC_ADV_BV_07_C		N/A
 TC_ADV_BV_08_C		N/A
 TC_ADV_BV_09_C		N/A
 TC_ADV_BV_10_C		N/A
-TC_GAT_BV_01_C		INC	LE not supported yet
+TC_ADV_BV_11_C		N/A
+TC_ADV_BV_12_C		N/A
+TC_ADV_BV_13_C		N/A
+TC_ADV_BV_14_C		N/A
+TC_ADV_BV_15_C		N/A
+TC_ADV_BV_16_C		N/A
+TC_GAT_BV_01_C		INC
 TC_GAT_BV_02_C		N/A
 TC_GAT_BV_03_C		N/A
 TC_GAT_BV_04_C		N/A
@@ -142,15 +160,21 @@ TC_GAT_BV_08_C		N/A
 TC_DM_NCON_BV_01_C	N/A
 TC_DM_CON_BV_01_C	N/A
 TC_DM_NBON_BV_01_C	N/A
-TC_DM_BON_BV_01_C	INC	LE not supported yet
-TC_DM_GIN_BV_01_C	INC	LE not supported yet
-TC_DM_LIN_BV_01_C	N/A
-TC_DM_NAD_BV_01_C	PASS	Start inquiry from IUT
-TC_DM_NAD_BV_02_C	INC	LE not supported yet
+TC_DM_BON_BV_01_C	INC
+TC_DM_GIN_BV_01_C	INC
+TC_DM_LIN_BV_01_C	INC
+TC_DM_NAD_BV_01_C	PASS	Start discovery from IUT
+TC_DM_NAD_BV_02_C	PASS
 TC_DM_LEP_BV_01_C	N/A
 TC_DM_LEP_BV_02_C	N/A
 TC_DM_LEP_BV_03_C	N/A
-TC_DM_LEP_BV_04_C	N/A
-TC_DM_LEP_BV_05_C	N/A
-TC_DM_LEP_BV_06_C	INC	LE not supported yet
+TC_DM_LEP_BV_04_C	PASS	l2test -n <PTS bdaddr>
+TC_DM_LEP_BV_05_C	PASS	btmgmt find -b
+				l2test -n 00:1B:DC:06:06:22
+TC_DM_LEP_BV_06_C	PASS
+TC_DM_LEP_BV_07_C	N/A
+TC_DM_LEP_BV_08_C	N/A
+TC_DM_LEP_BV_09_C	N/A
+TC_DM_LEP_BV_10_C	N/A
+TC_DM_LEP_BV_11_C	N/A
 -------------------------------------------------------------------------------
-- 
1.9.1

