Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: PIXITs and PICS' for L2CAP on PTS 5.3
Date: Mon, 13 Oct 2014 12:57:51 +0200
Message-Id: <1413197871-16570-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-l2cap.txt  | 136 +++++++++++++++++++++++++++---------------------
 android/pixit-l2cap.txt |  12 ++++-
 2 files changed, 87 insertions(+), 61 deletions(-)

diff --git a/android/pics-l2cap.txt b/android/pics-l2cap.txt
index 8e726e4..56036a0 100644
--- a/android/pics-l2cap.txt
+++ b/android/pics-l2cap.txt
@@ -1,6 +1,6 @@
 L2CAP PICS for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -12,14 +12,21 @@ O - optional
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_L2CAP_1_1	True		Data Channel Initiator (C.1)
+TSPC_L2CAP_1_1	True		Data Channel Initiator (C.3)
 TSPC_L2CAP_1_2	True		Data Channel Acceptor (C.1)
-TSPC_L2CAP_1_3	True (#)	LE Master (C.2)
-TSPC_L2CAP_1_4	True (#)	LE Slave (C.2)
+TSPC_L2CAP_1_3	True		LE Master (C.2)
+TSPC_L2CAP_1_4	True		LE Slave (C.2)
+TSPC_L2CAP_1_5	True		LE Data Channel Initiator (C.4)
+TSPC_L2CAP_1_6	True		LE Data Channel Acceptor (C.5)
 -------------------------------------------------------------------------------
-C.1: Mandatory IF BR/EDR or BR/EDR/LE is claimed, ELSE Excluded.
+C.1: Mandatory IF BR/EDR or BR/EDR/LE is supported, otherwise Excluded.
 C.2: Mandatory to support (at least one of TSPC_L2CAP_1_3 or TSPC_L2CAP_1_4)
-	IF LE or BR/EDR/LE claimed, ELSE Excluded.
+	IF LE or BR/EDR/LE is supported, otherwise Excluded.
+C.3: Optional IF LE or BR/EDR/LE is supported, otherwise Excluded.
+C.4: Optional IF LE or BR/EDR/LE and Core Spec v4.1 or Core Spec v4.1+HS and
+	TSPC_L2CAP_2_46 is supported, otherwise Excluded.
+C.5: Mandatory IF LE or BR/EDR/LE and Core Spec v4.1 or Core Spec v4.1+HS and
+	TSPC_L2CAP_2_46 is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -29,63 +36,66 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_L2CAP_2_1	True		Support of L2CAP signaling channel (C.20)
 TSPC_L2CAP_2_2	True		Support of configuration process (C.20)
-TSPC_L2CAP_2_4	True		Support of command echo request (C.21)
 TSPC_L2CAP_2_3  True            Support of connection oriented data
                                         channel (C.20)
+TSPC_L2CAP_2_4	True		Support of command echo request (C.21)
 TSPC_L2CAP_2_5	True		Support of command echo response (C.20)
-TSPC_L2CAP_2_6	True (*)	Support of command information request (C.21)
+TSPC_L2CAP_2_6	True		Support of command information request (C.21)
 TSPC_L2CAP_2_7	True		Support of command information response (C.20)
-TSPC_L2CAP_2_8	False		Support of a channel group (C.21)
-TSPC_L2CAP_2_9	False		Support of packet for connectionless
+TSPC_L2CAP_2_8	False (*)	Support of a channel group (C.21)
+TSPC_L2CAP_2_9	False (*)	Support of packet for connectionless
 					channel (C.21)
-TSPC_L2CAP_2_10	False		Support retransmission mode (C.21)
-TSPC_L2CAP_2_11	False		Support flow control mode(C.21)
-TSPC_L2CAP_2_12	True (*)	Enhanced Retransmission Mode (C.1, C.13)
-TSPC_L2CAP_2_13	True (*)	Streaming Mode (C.1, C.14)
-TSPC_L2CAP_2_14	True (*)	FCS Option (C.2)
-TSPC_L2CAP_2_15	True (*)	Generate Local Busy Condition (C.3)
-TSPC_L2CAP_2_16	False		Send Reject (C.3)
-TSPC_L2CAP_2_17	True (*)	Send Selective Reject (C.3)
-TSPC_L2CAP_2_18	True (*)	Mandatory use of ERTM (C.4)
-TSPC_L2CAP_2_19	True (*)	Mandatory use of Streaming Mode (C.5)
-TSPC_L2CAP_2_20	True (*)	Optional use of ERTM (C.4)
-TSPC_L2CAP_2_21	True (*)	Optional use of Streaming Mode (C.5)
-TSPC_L2CAP_2_22	True (*)	Send data using SAR in ERTM (C.6)
-TSPC_L2CAP_2_23	True (*)	Send data using SAR in Streaming Mode (C.7)
-TSPC_L2CAP_2_24	True (*)	Actively request Basic Mode for a PSM that
+TSPC_L2CAP_2_10	False (*)	Support retransmission mode (C.21)
+TSPC_L2CAP_2_11	False (*)	Support flow control mode(C.21)
+TSPC_L2CAP_2_12	True		Enhanced Retransmission Mode (C.1, C.13)
+TSPC_L2CAP_2_13	True		Streaming Mode (C.1, C.14)
+TSPC_L2CAP_2_14	True		FCS Option (C.2)
+TSPC_L2CAP_2_15	True		Generate Local Busy Condition (C.3)
+TSPC_L2CAP_2_16	False (*)	Send Reject (C.3)
+TSPC_L2CAP_2_17	True		Send Selective Reject (C.3)
+TSPC_L2CAP_2_18	True		Mandatory use of ERTM (C.4)
+TSPC_L2CAP_2_19	True		Mandatory use of Streaming Mode (C.5)
+TSPC_L2CAP_2_20	True		Optional use of ERTM (C.4)
+TSPC_L2CAP_2_21	True		Optional use of Streaming Mode (C.5)
+TSPC_L2CAP_2_22	True		Send data using SAR in ERTM (C.6)
+TSPC_L2CAP_2_23	True		Send data using SAR in Streaming Mode (C.7)
+TSPC_L2CAP_2_24	True		Actively request Basic Mode for a PSM that
 					supports the use of ERTM or Streaming
 					Mode (C.8)
-TSPC_L2CAP_2_25	True (*)	Supports performing L2CAP channel mode
+TSPC_L2CAP_2_25	True		Supports performing L2CAP channel mode
 					configuration fallback from SM
 					 to ERTM (C.9)
-TSPC_L2CAP_2_26	True (*)	Supports sending more than one unacknowledged
+TSPC_L2CAP_2_26	True		Supports sending more than one unacknowledged
 					I-Frame when operating in ERTM (C.10)
-TSPC_L2CAP_2_27	True (*)	Supports sending more than three unacknowledged
+TSPC_L2CAP_2_27	True		Supports sending more than three unacknowledged
 					I-Frame when operating in ERTM (C.10)
-TSPC_L2CAP_2_28	True (*)	Supports configuring the peer TxWindow
+TSPC_L2CAP_2_28	True		Supports configuring the peer TxWindow
 					greater than 1 (C.11)
-TSPC_L2CAP_2_29	False		AMP Support (C.12)
-TSPC_L2CAP_2_30	True (*)	Fixed Channel Support (C.12)
-TSPC_L2CAP_2_31	False		AMP Manager Support (C.12)
-TSPC_L2CAP_2_32	False		ERTM over AMP (C.12)
-TSPC_L2CAP_2_33	False		Streaming Mode Source over AMP Support (C.15)
-TSPC_L2CAP_2_34	False		Streaming Mode Sink over AMP Support (C.15)
-TSPC_L2CAP_2_35	True (*)	Unicast Connectionless Data, Reception
+TSPC_L2CAP_2_29	False (*)	AMP Support (C.12)
+TSPC_L2CAP_2_30	True		Fixed Channel Support (C.12)
+TSPC_L2CAP_2_31	False (*)	AMP Manager Support (C.12)
+TSPC_L2CAP_2_32	False (*)	ERTM over AMP (C.12)
+TSPC_L2CAP_2_33	False (*)	Streaming Mode Source over AMP Support (C.15)
+TSPC_L2CAP_2_34	False (*)	Streaming Mode Sink over AMP Support (C.15)
+TSPC_L2CAP_2_35	True		Unicast Connectionless Data, Reception
 				(C.1, C.16)
-TSPC_L2CAP_2_36	True (*)	Ability to transmit an unencrypted packet over
+TSPC_L2CAP_2_36	True		Ability to transmit an unencrypted packet over
 					a Unicast connectionless L2CAP
 					channel (C.16)
-TSPC_L2CAP_2_37	True (*)	Ability to transmit an encrypted packet over
+TSPC_L2CAP_2_37	True		Ability to transmit an encrypted packet over
 					a Unicast connectionless L2CAP
 					channel (C.16)
-TSPC_L2CAP_2_38	False		Extended Flow Specification for BR/EDR (C.8)
-TSPC_L2CAP_2_39	False		Extended Window Size (C.8)
-TSPC_L2CAP_2_40	True (*)	Support of Low Energy signaling channel (C.17)
-TSPC_L2CAP_2_41	True (*)	Support of command reject (C.17)
-TSPC_L2CAP_2_42	True (*)	Send Connection Parameter Update Request (C.18)
-TSPC_L2CAP_2_43	True (*)	Send Connection Parameter Update Response (C.19)
-TSPC_L2CAP_2_44	False		Extended Flow Specification for AMP (C.22)
-TSPC_L2CAP_2_45	True (*)	Send disconnect request command (O)
+TSPC_L2CAP_2_38	False (*)	Extended Flow Specification for BR/EDR (C.8)
+TSPC_L2CAP_2_39	False (*)	Extended Window Size (C.8)
+TSPC_L2CAP_2_40	True		Support of Low Energy signaling channel (C.17)
+TSPC_L2CAP_2_41	True		Support of command reject (C.17)
+TSPC_L2CAP_2_42	True		Send Connection Parameter Update Request (C.18)
+TSPC_L2CAP_2_43	True		Send Connection Parameter Update Response (C.19)
+TSPC_L2CAP_2_44	False (*)	Extended Flow Specification for AMP (C.22)
+TSPC_L2CAP_2_45	True		Send disconnect request command (O)
+TSCP_L2CAP_2_46	True		Support LE Credit Based Flow Control
+				Mode (C.23)
+TSCP_L2CAP_2_47	True		Support for LE Data Channel (C.24)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support at least one of TSPC_L2CAP_2_12 OR TSPC_L2CAP_2_13 OR
 	TSPC_L2CAP_2_35 IF BR/EDR BR/EDR/LE AND SUM_ICS 31/7 (CSA1) OR
@@ -115,8 +125,12 @@ C.17: Mandatory IF LE OR BR/EDR/LE is claimed, ELSE Excluded.
 C.18: Optional IF (SUM_ICS 31/10 AND 1/4) is claimed, ELSE Excluded.
 C.19: Mandatory IF (SUM_ICS 31/10 AND 1/3) is claimed, ELSE Excluded.
 C.20: Mandatory IF LE OR BR/EDR/LE, is claimed, ELSE Excluded
-C.21: Optional IF LE OR BR/EDR/LE, is claimed, ELSE Excluded
+C.21: Optional IF LE OR BR/EDR/LE, is claimed, ELSE Excluded.
 C.22: Mandatory IF TSPC_L2CAP_2_29 is claimed, ELSE Excluded.
+C.23: Optional LE OR BR/EDR/LE AND Core Spec v4.1 OR Core Spec v4.1+HS
+	is supported, otherwise Excluded.
+C.24: Mandatory IF TSPC_L2CAP_2_46 (Support LE Credit Based Flow Control Mode)
+	is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -124,30 +138,32 @@ C.22: Mandatory IF TSPC_L2CAP_2_29 is claimed, ELSE Excluded.
 -------------------------------------------------------------------------------
 Parameter	Name Selected	Description
 -------------------------------------------------------------------------------
-TSPC_L2CAP_3_1	True		Support of RTX timer (M)
+TSPC_L2CAP_3_1	True		Support of RTX timer (C.4)
 TSPC_L2CAP_3_2	True		Support of ERTX timer (C.4)
 TSPC_L2CAP_3_3	True		Support minimum MTU size 48 octets (C.4)
-TSPC_L2CAP_3_4	True (*)	Support MTU size larger than 48 octets (C.5)
+TSPC_L2CAP_3_4	True		Support MTU size larger than 48 octets (C.5)
 TSPC_L2CAP_3_5	True		Support of flush timeout value for reliable
 					channel (C.4)
-TSPC_L2CAP_3_6	False		Support of flush timeout value for unreliable
+TSPC_L2CAP_3_6	False (*)	Support of flush timeout value for unreliable
 					channel (C.5)
-TSPC_L2CAP_3_7	False		Support of bi-directional quality of service
+TSPC_L2CAP_3_7	False (*)	Support of bi-directional quality of service
 					(QoS) option field (C.1)
-TSPC_L2CAP_3_8	False		Negotiate QoS service type (C.5)
-TSPC_L2CAP_3_9	False		Negotiate and support service type ‘No
+TSPC_L2CAP_3_8	False (*)	Negotiate QoS service type (C.5)
+TSPC_L2CAP_3_9	False (*)	Negotiate and support service type ‘No
 					traffic’ (C.2)
-TSPC_L2CAP_3_10	False		Negotiate and support service type ‘Best
+TSPC_L2CAP_3_10	False (*)	Negotiate and support service type ‘Best
 					effort’ (C.3)
-TSPC_L2CAP_3_11	False		Negotiate and support service type
+TSPC_L2CAP_3_11	False (*)	Negotiate and support service type
 					‘Guaranteed’ (C.2)
-TSPC_L2CAP_3_12	True (*)	Support minimum MTU size 23 octets (C.6)
-TSPC_L2CAP_3_13	False		Negotiate and support service type ‘No traffic’
+TSPC_L2CAP_3_12	True		Support minimum MTU size 23 octets (C.6)
+TSPC_L2CAP_3_13	False (*)	Negotiate and support service type ‘No traffic’
 					for Extended Flow Specification (C.7)
-TSPC_L2CAP_3_14	False		Negotiate and support service type ‘Best Effort'
+TSPC_L2CAP_3_14	False (*)	Negotiate and support service type ‘Best Effort'
 					for Extended Flow Specification (C.8)
-TSPC_L2CAP_3_15	False		Negotiate and support service type ‘Guaranteed’
+TSPC_L2CAP_3_15	False (*)	Negotiate and support service type ‘Guaranteed’
 					for Extended Flow Specification (C.9)
+TSPC_L2CAP_3_16	True		Support Multiple Simultaneous LE Data
+				Channels (C.10)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_L2CAP_3_8 is supported, ELSE Optional.
 C.2: Optional if TSPC_L2CAP_3_8 is supported, ELSE Excluded.
@@ -159,4 +175,6 @@ C.7: Optional if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
 C.8: Mandatory if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported,
 	ELSE Excluded.
 C.9: Optional if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
+C.10: Optional IF TSPC_L2CAP_2_47 (Support LE Data Channel) is supported,
+	otherwise Excluded.
 -------------------------------------------------------------------------------
diff --git a/android/pixit-l2cap.txt b/android/pixit-l2cap.txt
index f0d6b1d..07b24e1 100644
--- a/android/pixit-l2cap.txt
+++ b/android/pixit-l2cap.txt
@@ -1,6 +1,6 @@
 L2CAP PIXIT for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -19,8 +19,15 @@ TSPX_flushto                                           FFFF
 TSPX_inmtu                                             02A0
 TSPX_no_fail_verditcs                                  FALSE
 TSPX_oumtu                                             02A0
-TSPX_iut_role_initiator                                TRUE
+TSPX_tester_mps                                        0010
+TSPX_tester_mtu                                        02A0
+TSPX_iut_role_initiator                                TRUE (*)
+TSPX_le_psm                                            0080 (*)
 TSPX_psm                                               1011 (*)
+TSPX_psm_unsupported                                   00F1
+TSPX_psm_authentication_required                       00F2
+TSPX_psm_authorization_required                        00F3
+TSPX_psm_encryption_key_size_required                  00F4
 TSPX_time_guard                                        180000
 TSPX_timer_ertx                                        120000
 TSPX_timer_ertx_max                                    300000
@@ -38,4 +45,5 @@ TSPX_use_implicit_send                                 TRUE
 TSPX_use_dynamic_pin                                   FALSE
 TSPX_iut_SDU_size_in_bytes                             144
 TSPX_secure_simple_pairing_pass_key_confirmation       FALSE
+TSPX_iut_address_type_random                           FALSE
 -------------------------------------------------------------------------------
-- 
1.8.5.3

