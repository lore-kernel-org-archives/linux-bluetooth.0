Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: correct PICS for GAP
Date: Tue,  2 Sep 2014 15:49:52 +0200
Message-Id: <1409665792-6229-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In PTS 5.2 the logic is reversed and all PICS by default are set
to TRUE.
---
 android/pics-gap.txt | 386 +++++++++++++++++++++++++--------------------------
 1 file changed, 193 insertions(+), 193 deletions(-)

diff --git a/android/pics-gap.txt b/android/pics-gap.txt
index cd63971..bea0329 100644
--- a/android/pics-gap.txt
+++ b/android/pics-gap.txt
@@ -11,9 +11,9 @@ O - optional
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_0_1	False		BR/EDR (C.1)
-TSPC_GAP_0_2	False		LE (C.2)
-TSPC_GAP_0_3	True (*)	BR/EDR/LE (C.3)
+TSPC_GAP_0_1	False (*)	BR/EDR (C.1)
+TSPC_GAP_0_2	False (*)	LE (C.2)
+TSPC_GAP_0_3	True		BR/EDR/LE (C.3)
 -------------------------------------------------------------------------------
 C.1: Mandatory if ('End Product' or 'Host Subsystem') and ('BR Host' or
 	'BR/HS Host') are Supported ('End Product' or 'Host Subsystem' with 'BR'
@@ -35,14 +35,14 @@ Note - Only one transport shall be supported.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_0A_1	True (*)	Core Specification Addendum 3 (CSA3), GAP
+TSPC_GAP_0A_1	True		Core Specification Addendum 3 (CSA3), GAP
 					Connection Parameters Changes,
 					Authentication and Lost Bond Changes,
 					Private Addressing Changes, Dual Mode
 					Addressing Changes,
 					Adopted 24 July 2012 (C.1)
-TSPC_GAP_0A_2	True (*)	Core Specification Addendum 4 (CSA4)
-TSPC_GAP_0A_3	True (*)	Core Spec version 4.1 (Core v4.1) GAP Connection
+TSPC_GAP_0A_2	True		Core Specification Addendum 4 (CSA4)
+TSPC_GAP_0A_3	True		Core Spec version 4.1 (Core v4.1) GAP Connection
 					Parameters Changes, Authentication and
 					Lost Bond Changes, Private Addressing
 					Changes, Dual Mode Addressing Changes,
@@ -56,15 +56,15 @@ C.1: Mandatory if 'CSA3 Adopted 24 July 2012' is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_1_1	True (*)	Non-discoverable mode (C.1)
-TSPC_GAP_1_2	True (*)	Limited-discoverable Mode (O)
-TSPC_GAP_1_3	True (*)	General-discoverable mode (O)
-TSPC_GAP_1_4	True (*)	Non-connectable mode (O)
+TSPC_GAP_1_1	True		Non-discoverable mode (C.1)
+TSPC_GAP_1_2	True		Limited-discoverable Mode (O)
+TSPC_GAP_1_3	True		General-discoverable mode (O)
+TSPC_GAP_1_4	True		Non-connectable mode (O)
 TSPC_GAP_1_5	True		Connectable mode (M)
-TSPC_GAP_1_6	True (*)	Non-bondable mode (O)
-TSPC_GAP_1_7	True (*)	Bondable mode (C.2)
-TSPC_GAP_1_8	False		Non-Synchronizable Mode (O)
-TSPC_GAP_1_9	False		Synchronizable Mode (O)
+TSPC_GAP_1_6	True		Non-bondable mode (O)
+TSPC_GAP_1_7	True		Bondable mode (C.2)
+TSPC_GAP_1_8	False (*)	Non-Synchronizable Mode (O)
+TSPC_GAP_1_9	False (*)	Synchronizable Mode (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_0_2 is supported, otherwise Optional.
 C.2: Mandatory if TSPC_GAP_3_5 is supported, otherwise Optional.
@@ -75,17 +75,17 @@ C.2: Mandatory if TSPC_GAP_3_5 is supported, otherwise Optional.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_2_1	True (*)	Authentication procedure (C.1)
-TSPC_GAP_2_2	True (*)	Support of LMP-Authentication (M)
-TSPC_GAP_2_3	True (*)	Initiate LMP-Authentication (C.5)
-TSPC_GAP_2_4	False		Security mode 1 (C.2)
-TSPC_GAP_2_5	True (*)	Security mode 2 (O)
-TSPC_GAP_2_6	False		Security mode 3 (C.7)
-TSPC_GAP_2_7	True (*)	Security mode 4 (C.4)
-TSPC_GAP_2_8	True (*)	Support of Authenticated link key (C.6)
-TSPC_GAP_2_9	True (*)	Support of Unauthenticated link key (C.6)
-TSPC_GAP_2_10	True (*)	No security (C.6)
-TSPC_GAP_2_11	False		Secure Connections Only Mode (O)
+TSPC_GAP_2_1	True		Authentication procedure (C.1)
+TSPC_GAP_2_2	True		Support of LMP-Authentication (M)
+TSPC_GAP_2_3	True		Initiate LMP-Authentication (C.5)
+TSPC_GAP_2_4	False (*)	Security mode 1 (C.2)
+TSPC_GAP_2_5	True		Security mode 2 (O)
+TSPC_GAP_2_6	False (*)	Security mode 3 (C.7)
+TSPC_GAP_2_7	True		Security mode 4 (C.4)
+TSPC_GAP_2_8	True		Support of Authenticated link key (C.6)
+TSPC_GAP_2_9	True		Support of Unauthenticated link key (C.6)
+TSPC_GAP_2_10	True		No security (C.6)
+TSPC_GAP_2_11	False (*)	Secure Connections Only Mode (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory If (TSPC_GAP_2_5 or TSPC_GAP_2_6) is supported, otherwise
 	Optional.
@@ -114,12 +114,12 @@ C.7: Excluded if TSPC_GAP_2_7 is supported, otherwise Optional.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_3_1	True (*)	Initiation of general inquiry (C.1)
-TSPC_GAP_3_2	True (*)	Initiation of limited inquiry (C.1)
-TSPC_GAP_3_3	True (*)	Initiation of name discover (O)
-TSPC_GAP_3_4	True (*)	Initiation of device discovery (O)
-TSPC_GAP_3_5	True (*)	Initiation of general bonding (O)
-TSPC_GAP_3_6	True (*)	Initiation of dedicated bonding (O)
+TSPC_GAP_3_1	True		Initiation of general inquiry (C.1)
+TSPC_GAP_3_2	True		Initiation of limited inquiry (C.1)
+TSPC_GAP_3_3	True		Initiation of name discover (O)
+TSPC_GAP_3_4	True		Initiation of device discovery (O)
+TSPC_GAP_3_5	True		Initiation of general bonding (O)
+TSPC_GAP_3_6	True		Initiation of dedicated bonding (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support at least one of TSPC_GAP_3_1 or TSPC_GAP_3_2 if
 	TSPC_GAP_3_5 is supported, otherwise Optional.
@@ -132,13 +132,13 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_4_1	True		Support link establishment as initiator (M)
 TSPC_GAP_4_2	True		Support link establishment as acceptor (M)
-TSPC_GAP_4_3	True (*)	Support channel establishment as initiator (O)
+TSPC_GAP_4_3	True		Support channel establishment as initiator (O)
 TSPC_GAP_4_4	True		Support channel establishment as acceptor (M)
-TSPC_GAP_4_5	True (*)	Support connection establishment as initiator
+TSPC_GAP_4_5	True		Support connection establishment as initiator
 					(O)
-TSPC_GAP_4_6	True (*)	Support connection establishment as acceptor
+TSPC_GAP_4_6	True		Support connection establishment as acceptor
 					(O)
-TSPC_GAP_4_7	True (*)	Support synchronization establishment
+TSPC_GAP_4_7	True		Support synchronization establishment
 					as receiver (O)
 -------------------------------------------------------------------------------
 
@@ -148,9 +148,9 @@ TSPC_GAP_4_7	True (*)	Support synchronization establishment
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_5_1	False (*)	Broadcaster (C.1)
-TSPC_GAP_5_2	False		Observer (C.1)
+TSPC_GAP_5_2	False (*)	Observer (C.1)
 TSPC_GAP_5_3	True		Peripheral (C.1)
-TSPC_GAP_5_4	True (*)	Central (C.1)
+TSPC_GAP_5_4	True		Central (C.1)
 -------------------------------------------------------------------------------
 C.1: It is mandatory to support at least one of the defined roles.
 Note: 'LE Roles' is applicable for LE-only configurations, but it appears that
@@ -163,7 +163,7 @@ Note: 'LE Roles' is applicable for LE-only configurations, but it appears that
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_6_1	False (*)	Broadcaster: Transmitter (M)
-TSPC_GAP_6_2	False		Broadcaster: Receiver (O)
+TSPC_GAP_6_2	False (*)	Broadcaster: Receiver (O)
 -------------------------------------------------------------------------------
 
 
@@ -182,7 +182,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_8_1	False (*)	Broadcaster: Non-Connectable Undirected Event
 					(M)
-TSPC_GAP_8_2	False		Broadcaster: Scannable Undirected Event (O)
+TSPC_GAP_8_2	False (*)	Broadcaster: Scannable Undirected Event (O)
 -------------------------------------------------------------------------------
 
 
@@ -190,22 +190,22 @@ TSPC_GAP_8_2	False		Broadcaster: Scannable Undirected Event (O)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_8A_1	False		AD Type-Service UUID (O)
-TSPC_GAP_8A_2	False		AD Type-Local Name (O)
+TSPC_GAP_8A_1	False (*)	AD Type-Service UUID (O)
+TSPC_GAP_8A_2	False (*)	AD Type-Local Name (O)
 TSPC_GAP_8A_3	False (*)	AD Type-Flags (O)
-TSPC_GAP_8A_4	False		AD Type-Manufacturer Specific Data (O)
-TSPC_GAP_8A_5	False		AD Type-TX Power Level (O)
-TSPC_GAP_8A_6	False		AD Type-Security Manager Out of Band (OOB) (C.1)
-TSPC_GAP_8A_7	False		AD Type-Security manager TK Value (O)
-TSPC_GAP_8A_8	False		AD Type-Slave Connection Interval Range (O)
-TSPC_GAP_8A_9	False		AD Type-Service Solicitation (O)
-TSPC_GAP_8A_10	False		AD Type-Service Data (O)
-TSPC_GAP_8A_11	False		AD Type-Appearance (O)
-TSPC_GAP_8A_12	False		AD Type-Public Target Address (O)
-TSPC_GAP_8A_13	False		AD Type-Random Target Address (O)
-TSPC_GAP_8A_14	False		AD Type-Advertising Interval (O)
-TSPC_GAP_8A_15	False		AD Type-LE Bluetooth Device Address (O)
-TSPC_GAP_8A_16	False		AD Type –LE Role (O)
+TSPC_GAP_8A_4	False (*)	AD Type-Manufacturer Specific Data (O)
+TSPC_GAP_8A_5	False (*)	AD Type-TX Power Level (O)
+TSPC_GAP_8A_6	False (*)	AD Type-Security Manager Out of Band (OOB) (C.1)
+TSPC_GAP_8A_7	False (*)	AD Type-Security manager TK Value (O)
+TSPC_GAP_8A_8	False (*)	AD Type-Slave Connection Interval Range (O)
+TSPC_GAP_8A_9	False (*)	AD Type-Service Solicitation (O)
+TSPC_GAP_8A_10	False (*)	AD Type-Service Data (O)
+TSPC_GAP_8A_11	False (*)	AD Type-Appearance (O)
+TSPC_GAP_8A_12	False (*)	AD Type-Public Target Address (O)
+TSPC_GAP_8A_13	False (*)	AD Type-Random Target Address (O)
+TSPC_GAP_8A_14	False (*)	AD Type-Advertising Interval (O)
+TSPC_GAP_8A_15	False (*)	AD Type-LE Bluetooth Device Address (O)
+TSPC_GAP_8A_16	False (*)	AD Type –LE Role (O)
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_SM_2_4 (OOB supported) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
@@ -224,9 +224,9 @@ TSPC_GAP_9_1	False (*)	Broadcaster: Non-Connectable Mode
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_10_1	False (*)	Broadcaster: Broadcast Mode
-TSPC_GAP_11_1	False		Broadcaster: Privacy Feature
+TSPC_GAP_11_1	False (*)	Broadcaster: Privacy Feature
 TSPC_GAP_11_1A	False (*)	Broadcaster: Privacy Feature v1.1 (O)
-TSPC_GAP_11_2	False		Broadcaster: Resolvable Private Address
+TSPC_GAP_11_2	False (*)	Broadcaster: Resolvable Private Address
 					Generation Procedure
 TSPC_GAP_11_3	False (*)	Broadcaster: Non-Resolvable Private Address
 					Generation Procedure (O)
@@ -238,7 +238,7 @@ TSPC_GAP_11_3	False (*)	Broadcaster: Non-Resolvable Private Address
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_12_1	False (*)	Observer: Receiver
-TSPC_GAP_12_2	False		Observer: Transmitter
+TSPC_GAP_12_2	False (*)	Observer: Transmitter
 -------------------------------------------------------------------------------
 
 
@@ -256,7 +256,7 @@ TSPC_GAP_13_2	False (*)	Observer: Scanning
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_14_1	False (*)	Observer: Passive Scanning
-TSPC_GAP_14_2	False		Observer: Active Scanning
+TSPC_GAP_14_2	False (*)	Observer: Active Scanning
 -------------------------------------------------------------------------------
 
 
@@ -280,13 +280,13 @@ TSPC_GAP_16_1	False (*)	Observer: Observation Procedure
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_17_1	False		Observer: Privacy Feature (O)
-TSPC_GAP_17_1A	False		Observer: Privacy Feature v1.1 (O)
-TSPC_GAP_17_2	False		Observer: Non-Resolvable Private Address
+TSPC_GAP_17_1	False (*)	Observer: Privacy Feature (O)
+TSPC_GAP_17_1A	False (*)	Observer: Privacy Feature v1.1 (O)
+TSPC_GAP_17_2	False (*)	Observer: Non-Resolvable Private Address
 					Generation Procedure (C.1)
-TSPC_GAP_17_3	False		Observer: Resolvable Private Address Resolution
+TSPC_GAP_17_3	False (*)	Observer: Resolvable Private Address Resolution
 					Procedure (C.2)
-TSPC_GAP_17_4	False		Observer: Resolvable Private Address Generation
+TSPC_GAP_17_4	False (*)	Observer: Resolvable Private Address Generation
 					Procedure (C.3)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_17_1 and TSPC_GAP_14_2 (Active Scanning) are
@@ -306,8 +306,8 @@ C.3: Mandatory if CSA3 or later and TSPC_GAP_17_1 and TSPC_GAP_14_2
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_18_1	True (*)	Peripheral: Transmitter
-TSPC_GAP_18_2	True (*)	Peripheral: Receiver
+TSPC_GAP_18_1	True		Peripheral: Transmitter
+TSPC_GAP_18_2	True		Peripheral: Receiver
 -------------------------------------------------------------------------------
 
 
@@ -315,9 +315,9 @@ TSPC_GAP_18_2	True (*)	Peripheral: Receiver
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_19_1	True (*)	Peripheral: Standby
-TSPC_GAP_19_2	True (*)	Peripheral: Advertising
-TSPC_GAP_19_3	True (*)	Peripheral: Connection, Slave Role
+TSPC_GAP_19_1	True		Peripheral: Standby
+TSPC_GAP_19_2	True		Peripheral: Advertising
+TSPC_GAP_19_3	True		Peripheral: Connection, Slave Role
 -------------------------------------------------------------------------------
 
 
@@ -325,11 +325,11 @@ TSPC_GAP_19_3	True (*)	Peripheral: Connection, Slave Role
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_20_1	True (*)	Peripheral: Connectable Undirected Event (C.1)
-TSPC_GAP_20_2	True (*)	Peripheral: Connectable Directed Event (C.2)
-TSPC_GAP_20_2A	True (*)	Peripheral: Low Duty Directed Advertising (C.3)
-TSPC_GAP_20_3	True (*)	Peripheral: Non-Connectable Undirected Event
-TSPC_GAP_20_4	True (*)	Peripheral: Scannable Undirected Event
+TSPC_GAP_20_1	True		Peripheral: Connectable Undirected Event (C.1)
+TSPC_GAP_20_2	True		Peripheral: Connectable Directed Event (C.2)
+TSPC_GAP_20_2A	True		Peripheral: Low Duty Directed Advertising (C.3)
+TSPC_GAP_20_3	True		Peripheral: Non-Connectable Undirected Event
+TSPC_GAP_20_4	True		Peripheral: Scannable Undirected Event
 -------------------------------------------------------------------------------
 
 
@@ -337,22 +337,22 @@ TSPC_GAP_20_4	True (*)	Peripheral: Scannable Undirected Event
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_20A_1	False		AD Type-Service UUID (C.1)
-TSPC_GAP_20A_2	True (*)	AD Type-Local Name (C.1)
-TSPC_GAP_20A_3	True (*)	AD Type-Flags (C.2)
-TSPC_GAP_20A_4	False		AD Type-Manufacturer Specific Data (C.1)
-TSPC_GAP_20A_5	True (*)	AD Type-TX Power Level (C.1)
-TSPC_GAP_20A_6	False		AD Type-Security Manager Out of Band (OOB) (C.3)
-TSPC_GAP_20A_7	False		AD Type-Security manager TK Value (C.1)
-TSPC_GAP_20A_8	False		AD Type-Slave Connection Interval Range (C.1)
-TSPC_GAP_20A_9	False		AD Type-Service Solicitation (C.1)
-TSPC_GAP_20A_10	False		AD Type-Service Data (C.1)
-TSPC_GAP_20A_11	False		AD Type –Appearance (C.1)
-TSPC_GAP_20A_12	False		AD Type-Public Target Address (C.1)
-TSPC_GAP_20A_13	False		AD Type-Random Target Address (C.1)
-TSPC_GAP_20A_14	False		AD Type-Advertising Interval (C.1)
-TSPC_GAP_20A_15	False		AD Type-LE Bluetooth Device Address (C.1)
-TSPC_GAP_20A_16	False		AD Type – LE Role (C.1)
+TSPC_GAP_20A_1	False (*)	AD Type-Service UUID (C.1)
+TSPC_GAP_20A_2	True		AD Type-Local Name (C.1)
+TSPC_GAP_20A_3	True		AD Type-Flags (C.2)
+TSPC_GAP_20A_4	False (*)	AD Type-Manufacturer Specific Data (C.1)
+TSPC_GAP_20A_5	True		AD Type-TX Power Level (C.1)
+TSPC_GAP_20A_6	False (*)	AD Type-Security Manager Out of Band (OOB) (C.3)
+TSPC_GAP_20A_7	False (*)	AD Type-Security manager TK Value (C.1)
+TSPC_GAP_20A_8	False (*)	AD Type-Slave Connection Interval Range (C.1)
+TSPC_GAP_20A_9	False (*)	AD Type-Service Solicitation (C.1)
+TSPC_GAP_20A_10	False (*)	AD Type-Service Data (C.1)
+TSPC_GAP_20A_11	False (*)	AD Type –Appearance (C.1)
+TSPC_GAP_20A_12	False (*)	AD Type-Public Target Address (C.1)
+TSPC_GAP_20A_13	False (*)	AD Type-Random Target Address (C.1)
+TSPC_GAP_20A_14	False (*)	AD Type-Advertising Interval (C.1)
+TSPC_GAP_20A_15	False (*)	AD Type-LE Bluetooth Device Address (C.1)
+TSPC_GAP_20A_16	False (*)	AD Type – LE Role (C.1)
 -------------------------------------------------------------------------------
 C.1: Optional if (TSPC_GAP_20_1 or TSPC_GAP_20_3 or TSPC_GAP_20_4) is
 	supported, otherwise Excluded.
@@ -371,7 +371,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_21_1	True		Peripheral: Connection Update Procedure (M)
 TSPC_GAP_21_2	True		Peripheral: Channel Map Update Procedure (M)
-TSPC_GAP_21_3	True (*)	Peripheral: Encryption Procedure (O)
+TSPC_GAP_21_3	True		Peripheral: Encryption Procedure (O)
 TSPC_GAP_21_4	True		Peripheral: Feature Exchange Procedure (M)
 TSPC_GAP_21_5	True		Peripheral: Version Exchange Procedure (M)
 TSPC_GAP_21_6	True		Peripheral: Termination Procedure (M)
@@ -387,10 +387,10 @@ TSPC_GAP_21_9	True		Peripheral: Connection Parameter Request
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_22_1	True (*)	Peripheral: Non-Discoverable Mode (C.2)
-TSPC_GAP_22_2	True (*)	Peripheral: Limited Discoverable Mode (C.1)
-TSPC_GAP_22_3	True (*)	Peripheral: General Discoverable Mode (C.1)
-TSPC_GAP_22_4	True (*)	Peripheral: Name Discovery Procedure (C.3)
+TSPC_GAP_22_1	True		Peripheral: Non-Discoverable Mode (C.2)
+TSPC_GAP_22_2	True		Peripheral: Limited Discoverable Mode (C.1)
+TSPC_GAP_22_3	True		Peripheral: General Discoverable Mode (C.1)
+TSPC_GAP_22_4	True		Peripheral: Name Discovery Procedure (C.3)
 -------------------------------------------------------------------------------
 C.1: Optional if (TSPC_GAP_5_3 OR TSPC_GAP_42_2), otherwise Excluded.
 C.2: Mandatory if (TSPC_GAP_5_3 or TSPC_GAP_42_1) is supported,
@@ -404,11 +404,11 @@ C.3: Optional if TSPC_GAP_5_3 is supported, otherwise Excluded.
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_23_1	False (*)	Peripheral: Non-Connectable Mode (C.1)
-TSPC_GAP_23_2	True (*)	Peripheral: Directed Connectable Mode (O)
-TSPC_GAP_23_3	True (*)	Peripheral: Undirected Connectable Mode (M)
-TSPC_GAP_23_4	True (*)	Peripheral: Connection Parameter Update
+TSPC_GAP_23_2	True		Peripheral: Directed Connectable Mode (O)
+TSPC_GAP_23_3	True		Peripheral: Undirected Connectable Mode (M)
+TSPC_GAP_23_4	True		Peripheral: Connection Parameter Update
 					Procedure (O)
-TSPC_GAP_23_5	True (*)	Peripheral: Terminate Connection Procedure (M)
+TSPC_GAP_23_5	True		Peripheral: Terminate Connection Procedure (M)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_5_3 (LE Only – Peripheral role) OR TSPC_GAP_42_3
 	(BR/EDR/LE – Non-Connectable Mode) OR TSPC_GAP_42_4
@@ -420,10 +420,10 @@ C.1: Mandatory if TSPC_GAP_5_3 (LE Only – Peripheral role) OR TSPC_GAP_42_3
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_24_1	True (*)	Peripheral: Non-Bondable Mode (M)
-TSPC_GAP_24_2	True (*)	Peripheral: Bondable Mode (C.1)
-TSPC_GAP_24_3	True (*)	Peripheral: Bonding Procedure  (C.2)
-TSPC_GAP_24_4	True (*)	Peripheral: Multiple Bonds (C.3)
+TSPC_GAP_24_1	True		Peripheral: Non-Bondable Mode (M)
+TSPC_GAP_24_2	True		Peripheral: Bondable Mode (C.1)
+TSPC_GAP_24_3	True		Peripheral: Bonding Procedure  (C.2)
+TSPC_GAP_24_4	True		Peripheral: Multiple Bonds (C.3)
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_GAP_5_3 (LE Only – Peripheral role) OR (TSPC_GAP_38_3
 	(BR/EDR/LE – Peripheral role) AND NOT TSPC_GAP_42_6 (BR.EDR/LE -
@@ -437,17 +437,17 @@ C.2: Optional if TSPC_GAP_24_2 (Bondable Mode) is supported, otherwise Excluded
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_25_1	True (*)	Peripheral: Security Mode (O)
-TSPC_GAP_25_2	True (*)	Peripheral: Security Mode 2 (O)
-TSPC_GAP_25_3	True (*)	Peripheral: Authentication Procedure (C.2)
-TSPC_GAP_25_4	True (*)	Peripheral: Authorization Procedure (O)
-TSPC_GAP_25_5	True (*)	Peripheral: Connection Data Signing Procedure
+TSPC_GAP_25_1	True		Peripheral: Security Mode (O)
+TSPC_GAP_25_2	True		Peripheral: Security Mode 2 (O)
+TSPC_GAP_25_3	True		Peripheral: Authentication Procedure (C.2)
+TSPC_GAP_25_4	True		Peripheral: Authorization Procedure (O)
+TSPC_GAP_25_5	True		Peripheral: Connection Data Signing Procedure
 				(O)
-TSPC_GAP_25_6	True (*)	Peripheral: Authenticate Signed Data Procedure
+TSPC_GAP_25_6	True		Peripheral: Authenticate Signed Data Procedure
 				(O)
-TSPC_GAP_25_7	True (*)	Peripheral: Authenticated Pairing
+TSPC_GAP_25_7	True		Peripheral: Authenticated Pairing
 				(LE security mode 1 level 3) (C.1)
-TSPC_GAP_25_8	True (*)	Peripheral: Unauthenticated Pairing
+TSPC_GAP_25_8	True		Peripheral: Unauthenticated Pairing
 				(LE security mode 1 level 2) (C.1)
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_GAP_25_1 is supported, otherwise Excluded.
@@ -460,13 +460,13 @@ C.2: Mandatory if TSPC_GAP_0A_1 and TSPC_GAP_27_4 are supported,
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_26_1	False		Peripheral: Privacy Feature (O)
-TSPC_GAP_26_1A	True (*)	Peripheral: Privacy Feature v1.1 (O)
-TSPC_GAP_26_2	True (*)	Peripheral: Non-Resolvable Private Address
+TSPC_GAP_26_1	False (*)	Peripheral: Privacy Feature (O)
+TSPC_GAP_26_1A	True		Peripheral: Privacy Feature v1.1 (O)
+TSPC_GAP_26_2	True		Peripheral: Non-Resolvable Private Address
 					Generation Procedure (C.1)
-TSPC_GAP_26_3	True (*)	Peripheral: Resolvable Private Address
+TSPC_GAP_26_3	True		Peripheral: Resolvable Private Address
 					Generation Procedure (C.2)
-TSPC_GAP_26_4	True (*)	Peripheral: Resolvable Private Address
+TSPC_GAP_26_4	True		Peripheral: Resolvable Private Address
 					Generation Procedure (C.4)
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_GAP_26_1 is supported, otherwise Excluded.
@@ -480,13 +480,13 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GAP_27_1	True		Peripheral: Device Name (M)
 TSPC_GAP_27_2	True		Peripheral: Appearance (M)
-TSPC_GAP_27_3	False		Peripheral: Peripheral Privacy Flag (C.1)
-TSPC_GAP_27_4	False		Peripheral: Reconnection Address (C.2)
-TSPC_GAP_27_5	False		Peripheral: Peripheral Preferred Connection
+TSPC_GAP_27_3	False (*)	Peripheral: Peripheral Privacy Flag (C.1)
+TSPC_GAP_27_4	False (*)	Peripheral: Reconnection Address (C.2)
+TSPC_GAP_27_5	False (*)	Peripheral: Peripheral Preferred Connection
 					Parameters (O)
-TSPC_GAP_27_6	False		Peripheral: Writeable Device Name (O)
-TSPC_GAP_27_7	False		Peripheral: Writeable Appearance (O)
-TSPC_GAP_27_8	False		Peripheral: Writeable Peripheral Privacy Flag
+TSPC_GAP_27_6	False (*)	Peripheral: Writeable Device Name (O)
+TSPC_GAP_27_7	False (*)	Peripheral: Writeable Appearance (O)
+TSPC_GAP_27_8	False (*)	Peripheral: Writeable Peripheral Privacy Flag
 				(O)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_26_1 is supported, otherwise Excluded.
@@ -499,8 +499,8 @@ C.2: Optional if TSPC_GAP_26_1 and TSPC_GAP_27_3 are supported,
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_28_1	True (*)	Central: Transmitter (M)
-TSPC_GAP_28_2	True (*)	Central: Receiver (M)
+TSPC_GAP_28_1	True		Central: Transmitter (M)
+TSPC_GAP_28_2	True		Central: Receiver (M)
 -------------------------------------------------------------------------------
 
 
@@ -508,10 +508,10 @@ TSPC_GAP_28_2	True (*)	Central: Receiver (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_29_1	True (*)	Central: Standby (M)
-TSPC_GAP_29_2	True (*)	Central: Scanning (M)
-TSPC_GAP_29_3	True (*)	Central: Initiating (M)
-TSPC_GAP_29_4	True (*)	Central: Connection, Master Role (M)
+TSPC_GAP_29_1	True		Central: Standby (M)
+TSPC_GAP_29_2	True		Central: Scanning (M)
+TSPC_GAP_29_3	True		Central: Initiating (M)
+TSPC_GAP_29_4	True		Central: Connection, Master Role (M)
 -------------------------------------------------------------------------------
 
 
@@ -519,8 +519,8 @@ TSPC_GAP_29_4	True (*)	Central: Connection, Master Role (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_30_1	True (*)	Central: Passive Scanning (O)
-TSPC_GAP_30_2	True (*)	Central: Active Scanning (C.1)
+TSPC_GAP_30_1	True		Central: Passive Scanning (O)
+TSPC_GAP_30_2	True		Central: Active Scanning (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory if (TSPC_GAP_5_4 or TSPC_GAP_38_4) is supported.
 	Optional if TSPC_GAP_30_1 and (TSPC_GAP_5_4 OR TSPC_GAP_38_4)
@@ -532,16 +532,16 @@ C.1: Mandatory if (TSPC_GAP_5_4 or TSPC_GAP_38_4) is supported.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_31_1	True (*)	Central: Connection Update Procedure (M)
-TSPC_GAP_31_2	True (*)	Central: Channel Map Update Procedure (M)
-TSPC_GAP_31_3	True (*)	Central: Encryption Procedure (O)
-TSPC_GAP_31_4	True (*)	Central: Feature Exchange Procedure (M)
-TSPC_GAP_31_5	True (*)	Central: Version Exchange Procedure (M)
-TSPC_GAP_31_6	True (*)	Central: Termination Procedure (M)
-TSPC_GAP_31_7	True (*)	Central: LE Ping Procedure (C.1)
-TSPC_GAP_31_8	True (*)	Central: Slave Initiated Feature Exchange
+TSPC_GAP_31_1	True		Central: Connection Update Procedure (M)
+TSPC_GAP_31_2	True		Central: Channel Map Update Procedure (M)
+TSPC_GAP_31_3	True		Central: Encryption Procedure (O)
+TSPC_GAP_31_4	True		Central: Feature Exchange Procedure (M)
+TSPC_GAP_31_5	True		Central: Version Exchange Procedure (M)
+TSPC_GAP_31_6	True		Central: Termination Procedure (M)
+TSPC_GAP_31_7	True		Central: LE Ping Procedure (C.1)
+TSPC_GAP_31_8	True		Central: Slave Initiated Feature Exchange
 					Procedure (C.2)
-TSPC_GAP_31_9	True (*)	Central: Connection Parameter Request Procedure
+TSPC_GAP_31_9	True		Central: Connection Parameter Request Procedure
 					(C.3)
 -------------------------------------------------------------------------------
 
@@ -550,9 +550,9 @@ TSPC_GAP_31_9	True (*)	Central: Connection Parameter Request Procedure
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_32_1	True (*)	Central: Limited Discovery Procedure (C.2)
-TSPC_GAP_32_2	True (*)	Central: General Discovery Procedure (C.1)
-TSPC_GAP_32_3	True (*)	Central: Name Discovery Procedure (C.3)
+TSPC_GAP_32_1	True		Central: Limited Discovery Procedure (C.2)
+TSPC_GAP_32_2	True		Central: General Discovery Procedure (C.1)
+TSPC_GAP_32_3	True		Central: Name Discovery Procedure (C.3)
 -------------------------------------------------------------------------------
 C.1: Mandatory if (TSPC_GAP_5_4 or TSPC_GAP_40_1) is supported, else Excluded.
 C.2: Optional if (TSPC_GAP_5_4 or TSPC_GAP_40_2) is supported,
@@ -566,17 +566,17 @@ C.3: Optional if (TSPC_GAP_5_4 or TSPC_GAP_40_4) is supported,
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_33_1	True (*)	Central: Auto Connection Establishment
+TSPC_GAP_33_1	True		Central: Auto Connection Establishment
 					Procedure (C.3)
-TSPC_GAP_33_2	True (*)	Central: General Connection Establishment
+TSPC_GAP_33_2	True		Central: General Connection Establishment
 					Procedure (C.1)
-TSPC_GAP_33_3	True (*)	Central: Selective Connection Establishment
+TSPC_GAP_33_3	True		Central: Selective Connection Establishment
 					Procedure (C.3)
-TSPC_GAP_33_4	True (*)	Central: Direct Connection Establishment
+TSPC_GAP_33_4	True		Central: Direct Connection Establishment
 					Procedure (C.2)
-TSPC_GAP_33_5	True (*)	Central: Connection Parameter Update Procedure
+TSPC_GAP_33_5	True		Central: Connection Parameter Update Procedure
 					(C.2)
-TSPC_GAP_33_6	True (*)	Central: Terminate Connection Procedure
+TSPC_GAP_33_6	True		Central: Terminate Connection Procedure
 					(C.2)
 -------------------------------------------------------------------------------
 C.1: Mandatory if (TSPC_GAP_5_4 or TSPC_GAP_40_5) and TSPC_GAP_36_1 is
@@ -592,9 +592,9 @@ C.3: Optional if (TSPC_GAP_5_4 or TSPC_GAP_40_5) is supported,
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_34_1	True (*)	Central: Non-Bondable Mode (C.1)
-TSPC_GAP_34_2	True (*)	Central: Bondable Mode (C.2)
-TSPC_GAP_34_3	True (*)	Central: Bonding Procedure (O)
+TSPC_GAP_34_1	True		Central: Non-Bondable Mode (C.1)
+TSPC_GAP_34_2	True		Central: Bondable Mode (C.2)
+TSPC_GAP_34_3	True		Central: Bonding Procedure (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory if (TSPC_GAP_5_4 or 39/5) is supported, otherwise Excluded.
 C.2: Optional if (TSPC_GAP_5_4 or 39/6) is supported, otherwise Excluded.
@@ -605,15 +605,15 @@ C.2: Optional if (TSPC_GAP_5_4 or 39/6) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_35_1	True (*)	Central: Security Mode 1 (O)
-TSPC_GAP_35_2	True (*)	Central: Security Mode 2 (O)
-TSPC_GAP_35_3	True (*)	Central: Authentication Procedure (O)
-TSPC_GAP_35_4	True (*)	Central: Authorization Procedure (O)
-TSPC_GAP_35_5	True (*)	Central: Connection Data Signing Procedure (O)
-TSPC_GAP_35_6	True (*)	Central: Authenticate Signed Data Procedure (O)
-TSPC_GAP_35_7	True (*)	Central: Authenticated Pairing
+TSPC_GAP_35_1	True		Central: Security Mode 1 (O)
+TSPC_GAP_35_2	True		Central: Security Mode 2 (O)
+TSPC_GAP_35_3	True		Central: Authentication Procedure (O)
+TSPC_GAP_35_4	True		Central: Authorization Procedure (O)
+TSPC_GAP_35_5	True		Central: Connection Data Signing Procedure (O)
+TSPC_GAP_35_6	True		Central: Authenticate Signed Data Procedure (O)
+TSPC_GAP_35_7	True		Central: Authenticated Pairing
 					(LE security mode 1 level 3) (C.1)
-TSPC_GAP_35_8	True (*)	Central: Unauthenticated Pairing
+TSPC_GAP_35_8	True		Central: Unauthenticated Pairing
 					(LE security mode 1 level 2) (C.1)
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_GAP_35_1 is supported, otherwise Excluded.
@@ -624,15 +624,15 @@ C.1: Optional if TSPC_GAP_35_1 is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_36_1	True (*)	Central: Privacy Feature (C.3)
-TSPC_GAP_36_1A	True (*)	Central: Privacy Feature v1.1 (C.4)
-TSPC_GAP_36_2	True (*)	Central: Non-Resolvable Private Address
+TSPC_GAP_36_1	True		Central: Privacy Feature (C.3)
+TSPC_GAP_36_1A	True		Central: Privacy Feature v1.1 (C.4)
+TSPC_GAP_36_2	True		Central: Non-Resolvable Private Address
 					Generation Procedure (C.1)
-TSPC_GAP_36_3	True (*)	Central: Resolvable Private Address Resolution
+TSPC_GAP_36_3	True		Central: Resolvable Private Address Resolution
 					Procedure (C.2)
-TSPC_GAP_36_4	True (*)	Central: Write to Privacy Characteristic
+TSPC_GAP_36_4	True		Central: Write to Privacy Characteristic
 					(Enable/Disable Privacy) (O)
-TSPC_GAP_36_5	True (*)	Central: Resolvable Private Address Generation
+TSPC_GAP_36_5	True		Central: Resolvable Private Address Generation
 					Procedure (C.6)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_36_1 and TSPC_GAP_30_2 are supported,
@@ -645,8 +645,8 @@ C.2: Mandatory if TSPC_GAP_36_1 is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_37_1	True (*)	Central: Device Name (M)
-TSPC_GAP_37_2	True (*)	Central: Appearance (M)
+TSPC_GAP_37_1	True		Central: Device Name (M)
+TSPC_GAP_37_2	True		Central: Appearance (M)
 -------------------------------------------------------------------------------
 
 
@@ -654,10 +654,10 @@ TSPC_GAP_37_2	True (*)	Central: Appearance (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_38_1	False		BR/EDR/LE: Broadcaster (C.1)
-TSPC_GAP_38_2	False		BR/EDR/LE: Observer (C.1)
-TSPC_GAP_38_3	True (*)	BR/EDR/LE: Peripheral (C.1)
-TSPC_GAP_38_4	True (*)	BR/EDR/LE: Central (C.1)
+TSPC_GAP_38_1	False (*)	BR/EDR/LE: Broadcaster (C.1)
+TSPC_GAP_38_2	False (*)	BR/EDR/LE: Observer (C.1)
+TSPC_GAP_38_3	True		BR/EDR/LE: Peripheral (C.1)
+TSPC_GAP_38_4	True		BR/EDR/LE: Central (C.1)
 -------------------------------------------------------------------------------
 C.1: It is mandatory to support at least one of the defined roles.
 This table is applicable for BR/EDR/LE configurations. For LE-only
@@ -669,12 +669,12 @@ configurations, see 'LE Roles' table for role declarations.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_39_1	True (*)	Central BR/EDR/LE: Non-Discoverable Mode (C.1)
-TSPC_GAP_39_2	True (*)	Central BR/EDR/LE: Discoverable Mode (C.2)
-TSPC_GAP_39_3	True (*)	Central BR/EDR/LE: Non-Connectable Mode (C.3)
-TSPC_GAP_39_4	True (*)	Central BR/EDR/LE: Connectable Mode (M)
-TSPC_GAP_39_5	True (*)	Central BR/EDR/LE: Non-Bondable Mode (C.4)
-TSPC_GAP_39_6	True (*)	Central BR/EDR/LE: Bondable Mode (C.5)
+TSPC_GAP_39_1	True		Central BR/EDR/LE: Non-Discoverable Mode (C.1)
+TSPC_GAP_39_2	True		Central BR/EDR/LE: Discoverable Mode (C.2)
+TSPC_GAP_39_3	True		Central BR/EDR/LE: Non-Connectable Mode (C.3)
+TSPC_GAP_39_4	True		Central BR/EDR/LE: Connectable Mode (M)
+TSPC_GAP_39_5	True		Central BR/EDR/LE: Non-Bondable Mode (C.4)
+TSPC_GAP_39_6	True		Central BR/EDR/LE: Bondable Mode (C.5)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_1_1 is supported over BR/EDR, otherwise Excluded.
 C.2: Mandatory if (TSPC_GAP_1_2 or TSPC_GAP_1_3) is supported over BR/EDR,
@@ -689,11 +689,11 @@ C.5: Mandatory if TSPC_GAP_1_7 is supported over BR/EDR, otherwise Excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_40_1	True (*)	Central BR/EDR/LE: General Discovery (C.1)
-TSPC_GAP_40_2	True (*)	Central BR/EDR/LE: Limited Discovery (C.2)
-TSPC_GAP_40_3	True (*)	Central BR/EDR/LE: Device Type Discovery (C.3)
-TSPC_GAP_40_4	True (*)	Central BR/EDR/LE: Name Discovery (C.4)
-TSPC_GAP_40_5	True (*)	Central BR/EDR/LE: Link Establishment (C.5)
+TSPC_GAP_40_1	True		Central BR/EDR/LE: General Discovery (C.1)
+TSPC_GAP_40_2	True		Central BR/EDR/LE: Limited Discovery (C.2)
+TSPC_GAP_40_3	True		Central BR/EDR/LE: Device Type Discovery (C.3)
+TSPC_GAP_40_4	True		Central BR/EDR/LE: Name Discovery (C.4)
+TSPC_GAP_40_5	True		Central BR/EDR/LE: Link Establishment (C.5)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_3_1 is supported over BR/EDR, otherwise Excluded.
 C.2: Mandatory if TSPC_GAP_3_2 is supported over BR/EDR, otherwise Excluded.
@@ -717,16 +717,16 @@ TSPC_GAP_41_1	True		Central BR/EDR/LE: Security Aspects (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_42_1	True (*)	Peripheral BR/EDR/LE: Non-Discoverable Mode
+TSPC_GAP_42_1	True		Peripheral BR/EDR/LE: Non-Discoverable Mode
 				(See Spec)
-TSPC_GAP_42_2	True (*)	Peripheral BR/EDR/LE: Discoverable Mode
+TSPC_GAP_42_2	True		Peripheral BR/EDR/LE: Discoverable Mode
 				(See Spec)
-TSPC_GAP_42_3	False		Peripheral BR/EDR/LE: Non-Connectable Mode
+TSPC_GAP_42_3	False (*)	Peripheral BR/EDR/LE: Non-Connectable Mode
 				(See Spec)
 TSPC_GAP_42_4	True		Peripheral BR/EDR/LE: Connectable Mode (M)
-TSPC_GAP_42_5	True (*)	Peripheral BR/EDR/LE: Non-Bondable Mode
+TSPC_GAP_42_5	True		Peripheral BR/EDR/LE: Non-Bondable Mode
 				(See Spec)
-TSPC_GAP_42_6	True (*)	Peripheral BR/EDR/LE: Bondable Mode (See Spec)
+TSPC_GAP_42_6	True		Peripheral BR/EDR/LE: Bondable Mode (See Spec)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_1_1 is supported over BR/EDR, otherwise Excluded.
 C.2: Mandatory if (TSPC_GAP_1_2 or TSPC_GAP_1_3) is supported over BR/EDR,
@@ -749,10 +749,10 @@ TSPC_GAP_43_1	True		Peripheral BR/EDR/LE: Non-Discoverable Mode
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_44_1	True (*)	Central BR/EDR/LE: Simultaneous BR/EDR and LE
+TSPC_GAP_44_1	True		Central BR/EDR/LE: Simultaneous BR/EDR and LE
 					Transports – BR/EDR Slave to the same
 					device (O)
-TSPC_GAP_44_2	True (*)	Central BR/EDR/LE: Simultaneous BR/EDR and LE
+TSPC_GAP_44_2	True		Central BR/EDR/LE: Simultaneous BR/EDR and LE
 					Transports – BR/EDR Master to the same
 					device (O)
 -------------------------------------------------------------------------------
@@ -762,9 +762,9 @@ TSPC_GAP_44_2	True (*)	Central BR/EDR/LE: Simultaneous BR/EDR and LE
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_45_1	True (*)	Simultaneous BR/EDR and LE Transports – BR/EDR
+TSPC_GAP_45_1	True		Simultaneous BR/EDR and LE Transports – BR/EDR
 					Slave to the same device (C.1)
-TSPC_GAP_45_2	True (*)	Simultaneous BR/EDR and LE Transports – BR/EDR
+TSPC_GAP_45_2	True		Simultaneous BR/EDR and LE Transports – BR/EDR
 					Master to the same device (C.1)
 -------------------------------------------------------------------------------
 C.1: Optional if ((SUM ICS 31/14 (Core Spec Version 4.1) or SUM ICS 31/15
@@ -775,9 +775,9 @@ C.1: Optional if ((SUM ICS 31/14 (Core Spec Version 4.1) or SUM ICS 31/15
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_SM_1_1	True (*)	Master Role (Initiator)
-TSPC_SM_1_2	True (*)	Slave Role (Responder)
-TSPC_SM_2_4	True (*)	OOB supported (O)
+TSPC_SM_1_1	True		Master Role (Initiator)
+TSPC_SM_1_2	True		Slave Role (Responder)
+TSPC_SM_2_4	True		OOB supported (O)
 TSPC_ALL	False		Turns on all
 TSPC_GATT_1_1	True		GATT Client Role
 -------------------------------------------------------------------------------
-- 
1.8.5.3

