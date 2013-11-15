Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] android: Add PTS PICS for GAP
Date: Fri, 15 Nov 2013 11:45:31 +0100
Message-Id: <1384512332-21906-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1384512332-21906-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1384435587-12427-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1384512332-21906-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS PICS for GAP, targeting Android 4.4.

---
 android/pics-gap.txt | 223 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)
 create mode 100644 android/pics-gap.txt

diff --git a/android/pics-gap.txt b/android/pics-gap.txt
new file mode 100644
index 0000000..1ef94a6
--- /dev/null
+++ b/android/pics-gap.txt
@@ -0,0 +1,223 @@
+GAP PICS for the PTS tool.
+
+* - different than PTS defaults
+
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_GAP_0_1	False		BR/EDR
+TSPC_GAP_0_2	False		LE
+TSPC_GAP_0_3	True (*)	BR/EDR/LE
+TSPC_GAP_0A_1	False		Core Specification Addendum 3 (CSA3),
+					GAP Connection Parameters Changes,
+					Authentication and Lost Bond Changes,
+					Private Addressing Changes,
+					Dual Mode Addressing Changes,
+					Adopted 24 July 2012
+TSPC_GAP_1_1	True (*)	Non-discoverable mode
+TSPC_GAP_1_2	False		Limited-discoverable mode
+TSPC_GAP_1_3	True (*)	General-discoverable mode
+TSPC_GAP_1_4	True (*)	Non-connectable mode
+TSPC_GAP_1_5	True		Connectable mode
+TSPC_GAP_1_6	False		Non-bondable mode
+TSPC_GAP_1_7	True (*)	Bondable mode
+TSPC_GAP_2_1	True (*)	Authentication procedure
+TSPC_GAP_2_2	True (*)	Support of LMP-Authentication
+TSPC_GAP_2_3	True (*)	Initiate LMP-Authentication
+TSPC_GAP_2_4	False		Security mode 1
+TSPC_GAP_2_5	True (*)	Security mode 2
+TSPC_GAP_2_6	False		Security mode 3
+TSPC_GAP_2_7	True (*)	Security mode 4
+TSPC_GAP_2_8	True (*)	Support of Authenticated link key
+TSPC_GAP_2_9	True (*)	Support of Unauthenticated link key
+TSPC_GAP_2_10	False		No security
+TSPC_GAP_3_1	True (*)	Initiation of general inquiry
+TSPC_GAP_3_2	False		Initiation of limited inquiry
+TSPC_GAP_3_3	True (*)	Initiation of name discover
+TSPC_GAP_3_4	True (*)	Initiation of device discovery
+TSPC_GAP_3_5	True (*)	Initiation of general bonding
+TSPC_GAP_3_6	True (*)	Initiation of dedicated bonding
+TSPC_GAP_4_1	True		Support link establishment as initiator
+TSPC_GAP_4_2	True		Support link establishment as acceptor
+TSPC_GAP_4_3	True (*)	Support channel establishment as initiator
+TSPC_GAP_4_4	True		Support channel establishment as acceptor
+TSPC_GAP_4_5	True (*)	Support connection establishment as initiator
+TSPC_GAP_4_6	True (*)	Support connection establishment as acceptor
+TSPC_GAP_5_1	False (*)	Broadcaster
+TSPC_GAP_5_2	False		Observer
+TSPC_GAP_5_3	False (*)	Peripheral
+TSPC_GAP_5_4	True (*)	Central
+TSPC_GAP_6_1	False (*)	Broadcaster: Transmitter
+TSPC_GAP_6_2	False		Broadcaster: Receiver
+TSPC_GAP_7_1	False (*)	Broadcaster: Standby
+TSPC_GAP_7_2	False (*)	Broadcaster: Advertising
+TSPC_GAP_8_1	False (*)	Broadcaster: Non-Connectable Undirected Event
+TSPC_GAP_8_2	False		Broadcaster: Scannable Undirected Event
+TSPC_GAP_8A_1	False		AD Type-Service UUID
+TSPC_GAP_8A_2	False		AD Type-Local Name
+TSPC_GAP_8A_3	False (*)	AD Type-Flags
+TSPC_GAP_8A_4	False		AD Type-Manufacturer Specific Data
+TSPC_GAP_8A_5	False		AD Type-TX Power Level
+TSPC_GAP_8A_6	False		AD Type-Security Manager Out of Band (OOB)
+TSPC_GAP_8A_7	False		AD Type-Security manager TK Value
+TSPC_GAP_8A_8	False		AD Type-Slave Connection Interval Range
+TSPC_GAP_8A_9	False		AD Type-Service Solicitation
+TSPC_GAP_8A_10	False		AD Type-Service Data
+TSPC_GAP_9_1	False (*)	Broadcaster: Non-Connectable Mode
+TSPC_GAP_10_1	False (*)	Broadcaster: Broadcast Mode
+TSPC_GAP_11_1	False		Broadcaster: Privacy Feature
+TSPC_GAP_11_2	False		Broadcaster: Resolvable Private Address
+					Generation Procedure
+TSPC_GAP_12_1	True		Observer: Receiver
+TSPC_GAP_12_2	False		Observer: Transmitter
+TSPC_GAP_13_1	True		Observer: Standby
+TSPC_GAP_13_2	True		Observer: Scanning
+TSPC_GAP_14_1	True		Observer: Passive Scanning
+TSPC_GAP_14_2	False		Observer: Active Scanning
+TSPC_GAP_15_1	True		Observer: Non-Connectable Mode
+TSPC_GAP_16_1	True		Observer: Observation Procedure
+TSPC_GAP_17_1	False		Observer: Privacy Feature
+TSPC_GAP_17_2	False		Observer: Non-Resolvable Private Address
+					Generation Procedure
+TSPC_GAP_17_3	False		Observer: Resolvable Private Address Resolution
+					Procedure
+TSPC_GAP_17_4	False		Observer: Resolvable Private Address Generation
+					Procedure
+TSPC_GAP_18_1	False		Peripheral: Transmitter
+TSPC_GAP_18_2	False		Peripheral: Receiver
+TSPC_GAP_19_1	False		Peripheral: Standby
+TSPC_GAP_19_2	False		Peripheral: Advertising
+TSPC_GAP_19_3	False		Peripheral: Connection, Slave Role
+TSPC_GAP_20_1	False		Peripheral: Connectable Undirected Event
+TSPC_GAP_20_2	False		Peripheral: Connectable Directed Event
+TSPC_GAP_20_3	False		Peripheral: Non-Connectable Undirected Event
+TSPC_GAP_20_4	False		Peripheral: Scannable Undirected Event
+TSPC_GAP_20A_1	False		AD Type-Service UUID
+TSPC_GAP_20A_2	False		AD Type-Local Name
+TSPC_GAP_20A_3	False		AD Type-Flags
+TSPC_GAP_20A_4	False		AD Type-Manufacturer Specific Data
+TSPC_GAP_20A_5	False		AD Type-TX Power Level
+TSPC_GAP_20A_6	False		AD Type-Security Manager Out of Band (OOB)
+TSPC_GAP_20A_7	False		AD Type-Security manager TK Value
+TSPC_GAP_20A_8	False		AD Type-Slave Connection Interval Range
+TSPC_GAP_20A_9	False		AD Type-Service Solicitation
+TSPC_GAP_20A_10	False		AD Type-Service Data
+TSPC_GAP_21_1	False (*)	Peripheral: Connection Update Procedure
+TSPC_GAP_21_2	False (*)	Peripheral: Channel Map Update Procedure
+TSPC_GAP_21_3	False		Peripheral: Encryption Procedure
+TSPC_GAP_21_4	False (*)	Peripheral: Feature Exchange Procedure
+TSPC_GAP_21_5	False (*)	Peripheral: Version Exchange Procedure
+TSPC_GAP_21_6	False (*)	Peripheral: Termination Procedure
+TSPC_GAP_22_1	False		Peripheral: Non-Discoverable Mode
+TSPC_GAP_22_2	False		Peripheral: Limited Discoverable Mode
+TSPC_GAP_22_3	False		Peripheral: General Discoverable Mode
+TSPC_GAP_22_4	False		Peripheral: Name Discovery Procedure
+TSPC_GAP_23_1	False		Peripheral: Non-Connectable Mode
+TSPC_GAP_23_2	False		Peripheral: Directed Connectable Mode
+TSPC_GAP_23_3	False		Peripheral: Undirected Connectable Mode
+TSPC_GAP_23_4	False		Peripheral: Connection Parameter Update
+					Procedure
+TSPC_GAP_23_5	False		Peripheral: Terminate Connection Procedure
+TSPC_GAP_24_1	False		Peripheral: Non-Bondable Mode
+TSPC_GAP_24_2	False		Peripheral: Bondable Mode
+TSPC_GAP_24_3	False		Peripheral: Bonding Procedure
+TSPC_GAP_24_4	False		Peripheral: Multiple Bonds
+TSPC_GAP_25_1	False		Peripheral: Security Mode 1
+TSPC_GAP_25_2	False		Peripheral: Security Mode 2
+TSPC_GAP_25_3	False		Peripheral: Authentication Procedure
+TSPC_GAP_25_4	False		Peripheral: Authorization Procedure
+TSPC_GAP_25_5	False		Peripheral: Connection Data Signing Procedure
+TSPC_GAP_25_6	False		Peripheral: Authenticate Signed Data Procedure
+TSPC_GAP_25_7	False		Peripheral: Authenticated Pairing
+					(LE security mode 1 level 3)
+TSPC_GAP_25_8	False		Peripheral: Unauthenticated Pairing
+					(LE security mode 1 level 2)
+TSPC_GAP_26_1	False		Peripheral: Privacy Feature
+TSPC_GAP_26_2	False		Peripheral: Non-Resolvable Private Address
+					Generation Procedure
+TSPC_GAP_26_3	False		Peripheral: Resolvable Private Address
+					Generation Procedure
+TSPC_GAP_27_1	False (*)	Peripheral: Device Name
+TSPC_GAP_27_2	False (*)	Peripheral: Appearance
+TSPC_GAP_27_3	False		Peripheral: Peripheral Privacy Flag
+TSPC_GAP_27_4	False		Peripheral: Reconnection Address
+TSPC_GAP_27_5	False		Peripheral: Peripheral Preferred Connection
+					Parameters
+TSPC_GAP_27_6	False		Peripheral: Writeable Device Name
+TSPC_GAP_27_7	False		Peripheral: Writeable Appearance
+TSPC_GAP_27_8	False		Peripheral: Writeable Peripheral Privacy Flag
+TSPC_GAP_28_1	True (*)	Central: Transmitter
+TSPC_GAP_28_2	True (*)	Central: Receiver
+TSPC_GAP_29_1	True (*)	Central: Standby
+TSPC_GAP_29_2	True (*)	Central: Scanning
+TSPC_GAP_29_3	True (*)	Central: Initiating
+TSPC_GAP_29_4	True (*)	Central: Connection, Master Role
+TSPC_GAP_30_1	True (*)	Central: Passive Scanning
+TSPC_GAP_30_2	True (*)	Central: Active Scanning
+TSPC_GAP_31_1	True (*)	Central: Connection Update Procedure
+TSPC_GAP_31_2	True (*)	Central: Channel Map Update Procedure
+TSPC_GAP_31_3	True (*)	Central: Encryption Procedure
+TSPC_GAP_31_4	True (*)	Central: Feature Exchange Procedure
+TSPC_GAP_31_5	True (*)	Central: Version Exchange Procedure
+TSPC_GAP_31_6	True (*)	Central: Termination Procedure
+TSPC_GAP_32_1	False		Central: Limited Discovery Procedure
+TSPC_GAP_32_2	True (*)	Central: General Discovery Procedure
+TSPC_GAP_32_3	True (*)	Central: Name Discovery Procedure
+TSPC_GAP_33_1	True (*)	Central: Auto Connection Establishment
+					Procedure
+TSPC_GAP_33_2	True (*)	Central: General Connection Establishment
+					Procedure
+TSPC_GAP_33_3	True (*)	Central: Selective Connection Establishment
+					Procedure
+TSPC_GAP_33_4	True (*)	Central: Direct Connectin Establishment
+					Procedure
+TSPC_GAP_33_5	True (*)	Central: Connection Parameter Update Procedure
+TSPC_GAP_33_6	True (*)	Central: Terminate Connection Procedure
+TSPC_GAP_34_1	False		Central: Non-Bondable Mode
+TSPC_GAP_34_2	True (*)	Central: Bondable Mode
+TSPC_GAP_34_3	True (*)	Central: Bonding Procedure
+TSPC_GAP_35_1	True (*)	Central: Security Mode 1
+TSPC_GAP_35_2	True (*)	Central: Security Mode 2
+TSPC_GAP_35_3	True (*)	Central: Authentication Procedure
+TSPC_GAP_35_4	True (*)	Central: Authorization Procedure
+TSPC_GAP_35_5	True (*)	Central: Connection Data Signing Procedure
+TSPC_GAP_35_6	True (*)	Central: Authenticate Signed Data Procedure
+TSPC_GAP_35_7	False		Central: Authenticated Pairing
+					(LE security mode 1 level 3)
+TSPC_GAP_35_8	False		Central: Unauthenticated Pairing
+					(LE security mode 1 level 2)
+TSPC_GAP_36_1	False		Central: Privacy Feature
+TSPC_GAP_36_2	False		Central: Non-Resolvable Private Address
+					Generation Procedure
+TSPC_GAP_36_3	False		Central: Resolvable Private Address Resolution
+					Procedure
+TSPC_GAP_36_4	False		Central: Write to Privacy Characteristic
+					(Enable/Disable Privacy)
+TSPC_GAP_37_1	True (*)	Central: Device Name
+TSPC_GAP_37_2	True (*)	Central: Appearance
+TSPC_GAP_38_1	False		BR/EDR/LE: Broadcaster
+TSPC_GAP_38_2	True (*)	BR/EDR/LE: Observer
+TSPC_GAP_38_3	False		BR/EDR/LE: Peripheral
+TSPC_GAP_38_4	True (*)	BR/EDR/LE: Central
+TSPC_GAP_39_1	True (*)	Central BR/EDR/LE: Non-Discoverable Mode
+TSPC_GAP_39_2	True (*)	Central BR/EDR/LE: Discoverable Mode
+TSPC_GAP_39_3	True (*)	Central BR/EDR/LE: Non-Connectable Mode
+TSPC_GAP_39_4	True		Central BR/EDR/LE: Connectable Mode
+TSPC_GAP_39_5	False		Central BR/EDR/LE: Non-Bondable Mode
+TSPC_GAP_39_6	True (*)	Central BR/EDR/LE: Bondable Mode
+TSPC_GAP_40_1	True (*)	Central BR/EDR/LE: General Discovery
+TSPC_GAP_40_2	False		Central BR/EDR/LE: Limited Discovery
+TSPC_GAP_40_3	True (*)	Central BR/EDR/LE: Device Type Discovery
+TSPC_GAP_40_4	True (*)	Central BR/EDR/LE: Name Discovery
+TSPC_GAP_40_5	True (*)	Central BR/EDR/LE: Link Establishment
+TSPC_GAP_41_1	True		Central BR/EDR/LE: Security Aspects
+TSPC_GAP_42_1	False		Peripheral BR/EDR/LE: Non-Discoverable Mode
+TSPC_GAP_42_2	False		Peripheral BR/EDR/LE: Discoverable Mode
+TSPC_GAP_42_3	False		Peripheral BR/EDR/LE: Non-Connectable Mode
+TSPC_GAP_42_4	False (*)	Peripheral BR/EDR/LE: Connectable Mode
+TSPC_GAP_42_5	False		Peripheral BR/EDR/LE: Non-Bondable Mode
+TSPC_GAP_42_6	False		Peripheral BR/EDR/LE: Bondable Mode
+TSPC_GAP_43_1	False (*)	Peripheral BR/EDR/LE: Security Aspects
+TSPC_SM_1_1	False		Master Role (Initiator)
+TSPC_SM_1_2	False		Slave Role (Responder)
+TSPC_SM_2_4	False		OOB supported
+TSPC_ALL	False		Turns on all
-- 
1.8.4.1

