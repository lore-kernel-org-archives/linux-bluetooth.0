Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/pics: Update GAP PICS settings
Date: Thu, 29 May 2014 10:01:06 +0200
Message-Id: <1401350467-8805-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enable peripheral mode and tweak some other settings.
---
 android/pics-gap.txt | 142 ++++++++++++++++++++++++++-------------------------
 1 file changed, 73 insertions(+), 69 deletions(-)

diff --git a/android/pics-gap.txt b/android/pics-gap.txt
index cd48332..5b36d4a 100644
--- a/android/pics-gap.txt
+++ b/android/pics-gap.txt
@@ -61,7 +61,7 @@ TSPC_GAP_1_2	True (*)	Limited-discoverable Mode (O)
 TSPC_GAP_1_3	True (*)	General-discoverable mode (O)
 TSPC_GAP_1_4	True (*)	Non-connectable mode (O)
 TSPC_GAP_1_5	True		Connectable mode (M)
-TSPC_GAP_1_6	False		Non-bondable mode (O)
+TSPC_GAP_1_6	True (*)	Non-bondable mode (O)
 TSPC_GAP_1_7	True (*)	Bondable mode (C.2)
 TSPC_GAP_1_8	False		Non-Synchronizable Mode (O)
 TSPC_GAP_1_9	False		Synchronizable Mode (O)
@@ -149,7 +149,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_5_1	False (*)	Broadcaster (C.1)
 TSPC_GAP_5_2	False		Observer (C.1)
-TSPC_GAP_5_3	False (*)	Peripheral (C.1)
+TSPC_GAP_5_3	True		Peripheral (C.1)
 TSPC_GAP_5_4	True (*)	Central (C.1)
 -------------------------------------------------------------------------------
 C.1: It is mandatory to support at least one of the defined roles.
@@ -306,8 +306,8 @@ C.3: Mandatory if CSA3 or later and TSPC_GAP_17_1 and TSPC_GAP_14_2
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_18_1	False		Peripheral: Transmitter
-TSPC_GAP_18_2	False		Peripheral: Receiver
+TSPC_GAP_18_1	True (*)	Peripheral: Transmitter
+TSPC_GAP_18_2	True (*)	Peripheral: Receiver
 -------------------------------------------------------------------------------
 
 
@@ -315,9 +315,9 @@ TSPC_GAP_18_2	False		Peripheral: Receiver
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_19_1	False		Peripheral: Standby
-TSPC_GAP_19_2	False		Peripheral: Advertising
-TSPC_GAP_19_3	False		Peripheral: Connection, Slave Role
+TSPC_GAP_19_1	True (*)	Peripheral: Standby
+TSPC_GAP_19_2	True (*)	Peripheral: Advertising
+TSPC_GAP_19_3	True (*)	Peripheral: Connection, Slave Role
 -------------------------------------------------------------------------------
 
 
@@ -325,11 +325,11 @@ TSPC_GAP_19_3	False		Peripheral: Connection, Slave Role
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_20_1	False		Peripheral: Connectable Undirected Event (C.1)
-TSPC_GAP_20_2	False		Peripheral: Connectable Directed Event (C.2)
-TSPC_GAP_20_2A	False		Peripheral: Low Duty Directed Advertising (C.3)
-TSPC_GAP_20_3	False		Peripheral: Non-Connectable Undirected Event
-TSPC_GAP_20_4	False		Peripheral: Scannable Undirected Event
+TSPC_GAP_20_1	True (*)	Peripheral: Connectable Undirected Event (C.1)
+TSPC_GAP_20_2	True (*)	Peripheral: Connectable Directed Event (C.2)
+TSPC_GAP_20_2A	True (*)	Peripheral: Low Duty Directed Advertising (C.3)
+TSPC_GAP_20_3	True (*)	Peripheral: Non-Connectable Undirected Event
+TSPC_GAP_20_4	True (*)	Peripheral: Scannable Undirected Event
 -------------------------------------------------------------------------------
 
 
@@ -338,10 +338,10 @@ TSPC_GAP_20_4	False		Peripheral: Scannable Undirected Event
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_20A_1	False		AD Type-Service UUID (C.1)
-TSPC_GAP_20A_2	False		AD Type-Local Name (C.1)
-TSPC_GAP_20A_3	False		AD Type-Flags (C.2)
+TSPC_GAP_20A_2	True (*)	AD Type-Local Name (C.1)
+TSPC_GAP_20A_3	True (*)	AD Type-Flags (C.2)
 TSPC_GAP_20A_4	False		AD Type-Manufacturer Specific Data (C.1)
-TSPC_GAP_20A_5	False		AD Type-TX Power Level (C.1)
+TSPC_GAP_20A_5	True (*)	AD Type-TX Power Level (C.1)
 TSPC_GAP_20A_6	False		AD Type-Security Manager Out of Band (OOB) (C.3)
 TSPC_GAP_20A_7	False		AD Type-Security manager TK Value (C.1)
 TSPC_GAP_20A_8	False		AD Type-Slave Connection Interval Range (C.1)
@@ -369,16 +369,16 @@ C.3: Optional if (TSPC_GAP_20_1 (Connectable Undirected Event) or TSPC_GAP_20_3
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_21_1	False (*)	Peripheral: Connection Update Procedure (M)
-TSPC_GAP_21_2	False (*)	Peripheral: Channel Map Update Procedure (M)
-TSPC_GAP_21_3	False		Peripheral: Encryption Procedure (O)
-TSPC_GAP_21_4	False (*)	Peripheral: Feature Exchange Procedure (M)
-TSPC_GAP_21_5	False (*)	Peripheral: Version Exchange Procedure (M)
-TSPC_GAP_21_6	False (*)	Peripheral: Termination Procedure (M)
-TSPC_GAP_21_7	False (*)	Peripheral: LE Ping Procedure (C.3)
-TSPC_GAP_21_8	False (*)	Peripheral: Slave Initiated Feature Exchange
+TSPC_GAP_21_1	True		Peripheral: Connection Update Procedure (M)
+TSPC_GAP_21_2	True		Peripheral: Channel Map Update Procedure (M)
+TSPC_GAP_21_3	True (*)	Peripheral: Encryption Procedure (O)
+TSPC_GAP_21_4	True		Peripheral: Feature Exchange Procedure (M)
+TSPC_GAP_21_5	True		Peripheral: Version Exchange Procedure (M)
+TSPC_GAP_21_6	True		Peripheral: Termination Procedure (M)
+TSPC_GAP_21_7	True		Peripheral: LE Ping Procedure (C.3)
+TSPC_GAP_21_8	True		Peripheral: Slave Initiated Feature Exchange
 					Procedure (C.4)
-TSPC_GAP_21_9	False (*)	Peripheral: Connection Parameter Request
+TSPC_GAP_21_9	True		Peripheral: Connection Parameter Request
 					Procedure (C.5)
 -------------------------------------------------------------------------------
 
@@ -387,10 +387,10 @@ TSPC_GAP_21_9	False (*)	Peripheral: Connection Parameter Request
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_22_1	False		Peripheral: Non-Discoverable Mode (C.2)
-TSPC_GAP_22_2	False		Peripheral: Limited Discoverable Mode (C.1)
-TSPC_GAP_22_3	False		Peripheral: General Discoverable Mode (C.1)
-TSPC_GAP_22_4	False		Peripheral: Name Discovery Procedure (C.3)
+TSPC_GAP_22_1	True (*)	Peripheral: Non-Discoverable Mode (C.2)
+TSPC_GAP_22_2	True (*)	Peripheral: Limited Discoverable Mode (C.1)
+TSPC_GAP_22_3	True (*)	Peripheral: General Discoverable Mode (C.1)
+TSPC_GAP_22_4	True (*)	Peripheral: Name Discovery Procedure (C.3)
 -------------------------------------------------------------------------------
 C.1: Optional if (TSPC_GAP_5_3 OR TSPC_GAP_42_2), otherwise Excluded.
 C.2: Mandatory if (TSPC_GAP_5_3 or TSPC_GAP_42_1) is supported,
@@ -403,12 +403,12 @@ C.3: Optional if TSPC_GAP_5_3 is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_23_1	False		Peripheral: Non-Connectable Mode (C.1)
-TSPC_GAP_23_2	False		Peripheral: Directed Connectable Mode (O)
-TSPC_GAP_23_3	False		Peripheral: Undirected Connectable Mode (M)
-TSPC_GAP_23_4	False		Peripheral: Connection Parameter Update
+TSPC_GAP_23_1	False (*)	Peripheral: Non-Connectable Mode (C.1)
+TSPC_GAP_23_2	True (*)	Peripheral: Directed Connectable Mode (O)
+TSPC_GAP_23_3	True (*)	Peripheral: Undirected Connectable Mode (M)
+TSPC_GAP_23_4	True (*)	Peripheral: Connection Parameter Update
 					Procedure (O)
-TSPC_GAP_23_5	False		Peripheral: Terminate Connection Procedure (M)
+TSPC_GAP_23_5	True (*)	Peripheral: Terminate Connection Procedure (M)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_5_3 (LE Only – Peripheral role) OR TSPC_GAP_42_3
 	(BR/EDR/LE – Non-Connectable Mode) OR TSPC_GAP_42_4
@@ -420,10 +420,10 @@ C.1: Mandatory if TSPC_GAP_5_3 (LE Only – Peripheral role) OR TSPC_GAP_42_3
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_24_1	False		Peripheral: Non-Bondable Mode (M)
-TSPC_GAP_24_2	False		Peripheral: Bondable Mode (C.1)
-TSPC_GAP_24_3	False		Peripheral: Bonding Procedure  (C.2)
-TSPC_GAP_24_4	False		Peripheral: Multiple Bonds (C.3)
+TSPC_GAP_24_1	True (*)	Peripheral: Non-Bondable Mode (M)
+TSPC_GAP_24_2	True (*)	Peripheral: Bondable Mode (C.1)
+TSPC_GAP_24_3	True (*)	Peripheral: Bonding Procedure  (C.2)
+TSPC_GAP_24_4	True (*)	Peripheral: Multiple Bonds (C.3)
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_GAP_5_3 (LE Only – Peripheral role) OR (TSPC_GAP_38_3
 	(BR/EDR/LE – Peripheral role) AND NOT TSPC_GAP_42_6 (BR.EDR/LE -
@@ -437,18 +437,18 @@ C.2: Optional if TSPC_GAP_24_2 (Bondable Mode) is supported, otherwise Excluded
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_25_1	False		Peripheral: Security Mode (O)
-TSPC_GAP_25_2	False		Peripheral: Security Mode 2 (O)
-TSPC_GAP_25_3	False		Peripheral: Authentication Procedure (C.2)
-TSPC_GAP_25_4	False		Peripheral: Authorization Procedure (O)
-TSPC_GAP_25_5	False		Peripheral: Connection Data Signing Procedure
-					(O)
-TSPC_GAP_25_6	False		Peripheral: Authenticate Signed Data Procedure
-					(O)
-TSPC_GAP_25_7	False		Peripheral: Authenticated Pairing
-					(LE security mode 1 level 3) (C.1)
-TSPC_GAP_25_8	False		Peripheral: Unauthenticated Pairing
-					(LE security mode 1 level 2) (C.1)
+TSPC_GAP_25_1	True (*)	Peripheral: Security Mode (O)
+TSPC_GAP_25_2	True (*)	Peripheral: Security Mode 2 (O)
+TSPC_GAP_25_3	True (*)	Peripheral: Authentication Procedure (C.2)
+TSPC_GAP_25_4	True (*)	Peripheral: Authorization Procedure (O)
+TSPC_GAP_25_5	True (*)	Peripheral: Connection Data Signing Procedure
+				(O)
+TSPC_GAP_25_6	True (*)	Peripheral: Authenticate Signed Data Procedure
+				(O)
+TSPC_GAP_25_7	True (*)	Peripheral: Authenticated Pairing
+				(LE security mode 1 level 3) (C.1)
+TSPC_GAP_25_8	True (*)	Peripheral: Unauthenticated Pairing
+				(LE security mode 1 level 2) (C.1)
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_GAP_25_1 is supported, otherwise Excluded.
 C.2: Mandatory if TSPC_GAP_0A_1 and TSPC_GAP_27_4 are supported,
@@ -478,8 +478,8 @@ C.2: Mandatory if TSPC_GAP_26_1 is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_27_1	False (*)	Peripheral: Device Name (M)
-TSPC_GAP_27_2	False (*)	Peripheral: Appearance (M)
+TSPC_GAP_27_1	True		Peripheral: Device Name (M)
+TSPC_GAP_27_2	True		Peripheral: Appearance (M)
 TSPC_GAP_27_3	False		Peripheral: Peripheral Privacy Flag (C.1)
 TSPC_GAP_27_4	False		Peripheral: Reconnection Address (C.2)
 TSPC_GAP_27_5	False		Peripheral: Peripheral Preferred Connection
@@ -532,12 +532,12 @@ C.1: Mandatory if (TSPC_GAP_5_4 or TSPC_GAP_38_4) is supported.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_31_1	True ()	Central: Connection Update Procedure (M)
-TSPC_GAP_31_2	True ()	Central: Channel Map Update Procedure (M)
+TSPC_GAP_31_1	True (*)	Central: Connection Update Procedure (M)
+TSPC_GAP_31_2	True (*)	Central: Channel Map Update Procedure (M)
 TSPC_GAP_31_3	True (*)	Central: Encryption Procedure (O)
-TSPC_GAP_31_4	True ()	Central: Feature Exchange Procedure (M)
-TSPC_GAP_31_5	True ()	Central: Version Exchange Procedure (M)
-TSPC_GAP_31_6	True ()	Central: Termination Procedure (M)
+TSPC_GAP_31_4	True (*)	Central: Feature Exchange Procedure (M)
+TSPC_GAP_31_5	True (*)	Central: Version Exchange Procedure (M)
+TSPC_GAP_31_6	True (*)	Central: Termination Procedure (M)
 TSPC_GAP_31_7	True (*)	Central: LE Ping Procedure (C.1)
 TSPC_GAP_31_8	True (*)	Central: Slave Initiated Feature Exchange
 					Procedure (C.2)
@@ -572,7 +572,7 @@ TSPC_GAP_33_2	True (*)	Central: General Connection Establishment
 					Procedure (C.1)
 TSPC_GAP_33_3	True (*)	Central: Selective Connection Establishment
 					Procedure (C.3)
-TSPC_GAP_33_4	True (*)	Central: Direct Connectin Establishment
+TSPC_GAP_33_4	True (*)	Central: Direct Connection Establishment
 					Procedure (C.2)
 TSPC_GAP_33_5	True (*)	Central: Connection Parameter Update Procedure
 					(C.2)
@@ -656,7 +656,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_38_1	False		BR/EDR/LE: Broadcaster (C.1)
 TSPC_GAP_38_2	False		BR/EDR/LE: Observer (C.1)
-TSPC_GAP_38_3	False		BR/EDR/LE: Peripheral (C.1)
+TSPC_GAP_38_3	True (*)	BR/EDR/LE: Peripheral (C.1)
 TSPC_GAP_38_4	True (*)	BR/EDR/LE: Central (C.1)
 -------------------------------------------------------------------------------
 C.1: It is mandatory to support at least one of the defined roles.
@@ -672,8 +672,8 @@ Parameter Name	Selected	Description
 TSPC_GAP_39_1	True (*)	Central BR/EDR/LE: Non-Discoverable Mode (C.1)
 TSPC_GAP_39_2	True (*)	Central BR/EDR/LE: Discoverable Mode (C.2)
 TSPC_GAP_39_3	True (*)	Central BR/EDR/LE: Non-Connectable Mode (C.3)
-TSPC_GAP_39_4	True ()	Central BR/EDR/LE: Connectable Mode (M)
-TSPC_GAP_39_5	False		Central BR/EDR/LE: Non-Bondable Mode (C.4)
+TSPC_GAP_39_4	True (*)	Central BR/EDR/LE: Connectable Mode (M)
+TSPC_GAP_39_5	True (*)	Central BR/EDR/LE: Non-Bondable Mode (C.4)
 TSPC_GAP_39_6	True (*)	Central BR/EDR/LE: Bondable Mode (C.5)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_1_1 is supported over BR/EDR, otherwise Excluded.
@@ -717,12 +717,16 @@ TSPC_GAP_41_1	True ()	Central BR/EDR/LE: Security Aspects (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_42_1	False		Peripheral BR/EDR/LE: Non-Discoverable Mode (See Spec)
-TSPC_GAP_42_2	False		Peripheral BR/EDR/LE: Discoverable Mode (See Spec)
-TSPC_GAP_42_3	False		Peripheral BR/EDR/LE: Non-Connectable Mode (See Spec)
-TSPC_GAP_42_4	False (*)	Peripheral BR/EDR/LE: Connectable Mode (M)
-TSPC_GAP_42_5	False		Peripheral BR/EDR/LE: Non-Bondable Mode (See Spec)
-TSPC_GAP_42_6	False		Peripheral BR/EDR/LE: Bondable Mode (See Spec)
+TSPC_GAP_42_1	True (*)	Peripheral BR/EDR/LE: Non-Discoverable Mode
+				(See Spec)
+TSPC_GAP_42_2	True (*)	Peripheral BR/EDR/LE: Discoverable Mode
+				(See Spec)
+TSPC_GAP_42_3	False		Peripheral BR/EDR/LE: Non-Connectable Mode
+				(See Spec)
+TSPC_GAP_42_4	True		Peripheral BR/EDR/LE: Connectable Mode (M)
+TSPC_GAP_42_5	True (*)	Peripheral BR/EDR/LE: Non-Bondable Mode
+				(See Spec)
+TSPC_GAP_42_6	True (*)	Peripheral BR/EDR/LE: Bondable Mode (See Spec)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_1_1 is supported over BR/EDR, otherwise Excluded.
 C.2: Mandatory if (TSPC_GAP_1_2 or TSPC_GAP_1_3) is supported over BR/EDR,
@@ -737,7 +741,7 @@ C.5: Mandatory if TSPC_GAP_1_7 is supported over BR/EDR, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_43_1	False (*)	Peripheral BR/EDR/LE: Non-Discoverable Mode
+TSPC_GAP_43_1	True		Peripheral BR/EDR/LE: Non-Discoverable Mode
 -------------------------------------------------------------------------------
 
 
@@ -758,9 +762,9 @@ TSPC_GAP_44_2	True (*)	Central BR/EDR/LE: Simultaneous BR/EDR and LE
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_45_1	False		Simultaneous BR/EDR and LE Transports – BR/EDR
+TSPC_GAP_45_1	True (*)	Simultaneous BR/EDR and LE Transports – BR/EDR
 					Slave to the same device (C.1)
-TSPC_GAP_45_2	False		Simultaneous BR/EDR and LE Transports – BR/EDR
+TSPC_GAP_45_2	True (*)	Simultaneous BR/EDR and LE Transports – BR/EDR
 					Master to the same device (C.1)
 -------------------------------------------------------------------------------
 C.1: Optional if ((SUM ICS 31/14 (Core Spec Version 4.1) or SUM ICS 31/15
-- 
1.9.3

