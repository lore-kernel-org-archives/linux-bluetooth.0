Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] Add PICS, PIXITs and PTS test results for L2CAP
Date: Sun, 15 Dec 2013 23:39:52 +0100
Message-Id: <1387147192-19246-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows better tracking of the current state of implementation
---
 android/pics-l2cap.txt  | 157 ++++++++++++++++++++++++++
 android/pixit-l2cap.txt |  39 +++++++
 android/pts-l2cap.txt   | 293 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 489 insertions(+)
 create mode 100644 android/pics-l2cap.txt
 create mode 100644 android/pixit-l2cap.txt
 create mode 100644 android/pts-l2cap.txt

diff --git a/android/pics-l2cap.txt b/android/pics-l2cap.txt
new file mode 100644
index 0000000..72ec932
--- /dev/null
+++ b/android/pics-l2cap.txt
@@ -0,0 +1,157 @@
+L2CAP PICS for the PTS tool.
+
+* - different than PTS defaults
+# - not yet implemented/supported
+
+M - mandatory
+O - optional
+
+		Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_L2CAP_1_1	True		Data Channel Initiator (C.1)
+TSPC_L2CAP_1_2	True		Data Channel Acceptor (C.1)
+TSPC_L2CAP_1_3	False (#)	LE Master (C.2)
+TSPC_L2CAP_1_4	False (#)	LE Slave (C.2)
+-------------------------------------------------------------------------------
+C.1: Mandatory IF BR/EDR or BR/EDR/LE is claimed, ELSE Excluded.
+C.2: Mandatory to support (at least one of TSPC_L2CAP_1_3 or TSPC_L2CAP_1_4)
+	IF LE or BR/EDR/LE claimed, ELSE Excluded.
+-------------------------------------------------------------------------------
+
+
+		General Operation
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_L2CAP_2_1	True		Support of L2CAP signaling channel (C.20)
+TSPC_L2CAP_2_2	True		Support of configuration process (C.20)
+TSPC_L2CAP_2_4	True		Support of command echo request (C.21)
+TSPC_L2CAP_2_3  True            Support of connection oriented data
+                                        channel (C.20)
+TSPC_L2CAP_2_5	True		Support of command echo response (C.20)
+TSPC_L2CAP_2_6	True (*)	Support of command information request (C.21)
+TSPC_L2CAP_2_7	True		Support of command information response (C.20)
+TSPC_L2CAP_2_8	False		Support of a channel group (C.21)
+TSPC_L2CAP_2_9	False		Support of packet for connectionless
+					channel (C.21)
+TSPC_L2CAP_2_10	False		Support retransmission mode (C.21)
+TSPC_L2CAP_2_11	False		Support flow control mode(C.21)
+TSPC_L2CAP_2_12	True (*)	Enhanced Retransmission Mode (C.1, C.13)
+TSPC_L2CAP_2_13	True (*)	Streaming Mode (C.1, C.14)
+TSPC_L2CAP_2_14	True (*)	FCS Option (C.2)
+TSPC_L2CAP_2_15	True (*)	Generate Local Busy Condition (C.3)
+TSPC_L2CAP_2_16	True (*)	Send Reject (C.3)
+TSPC_L2CAP_2_17	True (*)	Send Selective Reject (C.3)
+TSPC_L2CAP_2_18	True (*)	Mandatory use of ERTM (C.4)
+TSPC_L2CAP_2_19	True (*)	Mandatory use of Streaming Mode (C.5)
+TSPC_L2CAP_2_20	True (*)	Optional use of ERTM (C.4)
+TSPC_L2CAP_2_21	True (*)	Optional use of Streaming Mode (C.5)
+TSPC_L2CAP_2_22	True (*)	Send data using SAR in ERTM (C.6)
+TSPC_L2CAP_2_23	True (*)	Send data using SAR in Streaming Mode (C.7)
+TSPC_L2CAP_2_24	True (*)	Actively request Basic Mode for a PSM that
+					supports the use of ERTM or Streaming
+					Mode (C.8)
+TSPC_L2CAP_2_25	True (*)	Supports performing L2CAP channel mode
+					configuration fallback from SM
+					 to ERTM (C.9)
+TSPC_L2CAP_2_26	True (*)	Supports sending more than one unacknowledged
+					I-Frame when operating in ERTM (C.10)
+TSPC_L2CAP_2_27	True (*)	Supports sending more than three unacknowledged
+					I-Frame when operating in ERTM (C.10)
+TSPC_L2CAP_2_28	True (*)	Supports configuring the peer TxWindow
+					greater than 1 (C.11)
+TSPC_L2CAP_2_29	False		AMP Support (C.12)
+TSPC_L2CAP_2_30	True (*)	Fixed Channel Support (C.12)
+TSPC_L2CAP_2_31	False		AMP Manager Support (C.12)
+TSPC_L2CAP_2_32	False		ERTM over AMP (C.12)
+TSPC_L2CAP_2_33	False		Streaming Mode Source over AMP Support (C.15)
+TSPC_L2CAP_2_34	False		Streaming Mode Sink over AMP Support (C.15)
+TSPC_L2CAP_2_35	False		Unicast Connectionless Data, Reception (C.1, C.16)
+TSPC_L2CAP_2_36	False		Ability to transmit an unencrypted packet over
+					a Unicast connectionless L2CAP
+					channel (C.16)
+TSPC_L2CAP_2_37	False		Ability to transmit an encrypted packet over
+					a Unicast connectionless L2CAP
+					channel (C.16)
+TSPC_L2CAP_2_38	False		Extended Flow Specification for BR/EDR (C.8)
+TSPC_L2CAP_2_39	False		Extended Window Size (C.8)
+TSPC_L2CAP_2_40	False		Support of Low Energy signaling channel (C.17)
+TSPC_L2CAP_2_41	False		Support of command reject (C.17)
+TSPC_L2CAP_2_42	False		Send Connection Parameter Update Request (C.18)
+TSPC_L2CAP_2_43	False		Send Connection Parameter Update Response (C.19)
+TSPC_L2CAP_2_44	False		Extended Flow Specification for AMP (C.22)
+TSPC_L2CAP_2_45	False		Send disconnect request command (O)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support at least one of TSPC_L2CAP_2_12 OR TSPC_L2CAP_2_13 OR
+	TSPC_L2CAP_2_35 IF BR/EDR BR/EDR/LE AND SUM_ICS 31/7 (CSA1) OR
+	SUM_ICS 31/8 (3.0) OR SUM_ICS 31/9 (3.0+HS) OR SUM_ICS 31/10 (4.0))
+	is supported, ELSE Excluded
+C.2: Optional IF TSPC_L2CAP_2_12 OR TSPC_L2CAP_2_13 is claimed, ELSE Excluded.
+C.3: Optional IF TSPC_L2CAP_2_12 AND TSPC_L2CAP_2_28 is claimed, ELSE Excluded.
+C.4: IF TSPC_L2CAP_2_12 is claimed THEN either TSPC_L2CAP_2_18
+	OR TSPC_L2CAP_2_20 are Mandatory, ELSE Excluded.
+C.5: IF TSPC_L2CAP_2_13 is claimed THEN either TSPC_L2CAP_2_19
+	OR TSPC_L2CAP_2_21 are Mandatory, ELSE Excluded.
+C.6: Optional IF TSPC_L2CAP_2_12 is claimed, ELSE Excluded.
+C.7: Optional IF TSPC_L2CAP_2_13 is claimed, ELSE Excluded.
+C.8: Optional IF TSPC_L2CAP_2_12 OR TSPC_L2CAP_2_13 is claimed, ELSE Excluded.
+C.9: Mandatory IF TSPC_L2CAP_2_12 AND TSPC_L2CAP_2_13 AND TSPC_L2CAP_2_21
+       is claimed, ELSE Excluded.
+C.10: Optional IF TSPC_L2CAP_2_12 is claimed, ELSE Excluded.
+C.11: Optional IF TSPC_L2CAP_2_12 is claimed, ELSE Excluded.
+C.12: Mandatory IF SUM_ICS 31/9 (3.0 + HS) is claimed, ELSE Optional.
+C.13: Mandatory IF SUM_ICS 31/9 (3.0 + HS) is claimed, ELSE Optional.
+C.14: Optional IF SUM_ICS 31/8 OR 31/9 OR 31/10 OR 31/11 is claimed, ELSE Excluded.
+C.15: Optional IF TSPC_L2CAP_2_29 is claimed, ELSE Excluded.
+C.16: Optional IF (SUM_ICS 31/8 OR SUM_ICS 31/9 OR 31/10 OR 31/11) is claimed,
+       ELSE Excluded.
+C.17: Mandatory IF LE OR BR/EDR/LE is claimed, ELSE Excluded.
+C.18: Optional IF (SUM_ICS 31/10 AND 1/4) is claimed, ELSE Excluded.
+C.19: Mandatory IF (SUM_ICS 31/10 AND 1/3) is claimed, ELSE Excluded.
+C.20: Mandatory IF LE OR BR/EDR/LE, is claimed, ELSE Excluded
+C.21: Optional IF LE OR BR/EDR/LE, is claimed, ELSE Excluded
+C.22: Mandatory IF TSPC_L2CAP_2_29 is claimed, ELSE Excluded.
+-------------------------------------------------------------------------------
+
+
+		Configurable Parameters
+-------------------------------------------------------------------------------
+Parameter	Name Selected	Description
+-------------------------------------------------------------------------------
+TSPC_L2CAP_3_1	True		Support of RTX timer (M)
+TSPC_L2CAP_3_2	True		Support of ERTX timer (C.4)
+TSPC_L2CAP_3_3	True		Support minimum MTU size 48 octets (C.4)
+TSPC_L2CAP_3_4	True (*)	Support MTU size larger than 48 octets (C.5)
+TSPC_L2CAP_3_5	True		Support of flush timeout value for reliable
+					channel (C.4)
+TSPC_L2CAP_3_6	False		Support of flush timeout value for unreliable
+					channel (C.5)
+TSPC_L2CAP_3_7	False		Support of bi-directional quality of service
+					(QoS) option field (C.1)
+TSPC_L2CAP_3_8	False		Negotiate QoS service type (C.5)
+TSPC_L2CAP_3_9	False		Negotiate and support service type ‘No
+					traffic’ (C.2)
+TSPC_L2CAP_3_10	False		Negotiate and support service type ‘Best
+					effort’ (C.3)
+TSPC_L2CAP_3_11	False		Negotiate and support service type
+					‘Guaranteed’ (C.2)
+TSPC_L2CAP_3_12	True (*)	Support minimum MTU size 23 octets (C.6)
+TSPC_L2CAP_3_13	False		Negotiate and support service type ‘No traffic’
+					for Extended Flow Specification (C.7)
+TSPC_L2CAP_3_14	False		Negotiate and support service type ‘Best Effort'
+					for Extended Flow Specification (C.8)
+TSPC_L2CAP_3_15	False		Negotiate and support service type ‘Guaranteed’
+					for Extended Flow Specification (C.9)
+-------------------------------------------------------------------------------
+C.1: Mandatory if TSPC_L2CAP_3_8 is supported, ELSE Optional.
+C.2: Optional if TSPC_L2CAP_3_8 is supported, ELSE Excluded.
+C.3: Mandatory if TSPC_L2CAP_3_8 is supported, ELSE Excluded.
+C.4: Mandatory IF BR/EDR OR BR/EDR/LE is claimed, ELSE Excluded.
+C.5: Optional IF BR/EDR OR BR/EDR/LE is claimed, ELSE Excluded.
+C.6: Mandatory IF LE OR BR/EDR/LE is claimed, ELSE Excluded.
+C.7: Optional if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
+C.8: Mandatory if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
+C.9: Optional if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
+-------------------------------------------------------------------------------
diff --git a/android/pixit-l2cap.txt b/android/pixit-l2cap.txt
new file mode 100644
index 0000000..6f2beae
--- /dev/null
+++ b/android/pixit-l2cap.txt
@@ -0,0 +1,39 @@
+L2CAP PIXIT for the PTS tool.
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+               Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name                                         Value
+-------------------------------------------------------------------------------
+TSPX_bd_addr_iut                                       112233445566 (*&)
+TSPX_client_class_of_device                            100104
+TSPX_server_class_of_device                            100104
+TSPX_security_enabled                                  False
+TSPX_delete_link_key                                   False
+TSPX_pin_code                                          0000
+TSPX_flushto                                           FFFF
+TSPX_inmtu                                             02A0
+TSPX_no_fail_verditcs                                  FALSE
+TSPX_oumtu                                             02A0
+TSPX_iut_role_initiator                                FALSE
+TSPX_psm                                               0001
+TSPX_time_guard                                        180000
+TSPX_timer_ertx                                        120000
+TSPX_timer_ertx_max                                    300000
+TSPX_timer_ertx_min                                    60000
+TSPX_timer_rtx                                         10000
+TSPX_timer_rtx_max                                     60000
+TSPX_timer_rtx_min                                     1000
+TSPX_rfc_mode_tx_window_size                           08
+TSPX_rfc_mode_max_transmit                             03
+TSPX_rfc_mode_retransmission_timeout                   07D0
+TSPX_rfc_mode_monitor_timeout                          2EE0
+TSPX_rfc_mode_maximum_pdu_size                         02A0
+TSPX_extended_window_size                              0012
+TSPX_use_implicit_send                                 TRUE
+TSPX_use_dynamic_pin                                   FALSE
+TSPX_iut_SDU_size_in_bytes                             144
+TSPX_secure_simple_pairing_pass_key_confirmation       FALSE
+-------------------------------------------------------------------------------
diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
new file mode 100644
index 0000000..a599515
--- /dev/null
+++ b/android/pts-l2cap.txt
@@ -0,0 +1,293 @@
+PTS test results for L2CAP
+
+PTS version: 5.0
+Tested: 10-11.12.2013
+
+Results:
+PASS   test passed
+FAIL   test failed
+INC    test is inconclusive
+N/A    test is disabled due to PICS setup
+
+-------------------------------------------------------------------------------
+Test Name              Result  Notes
+-------------------------------------------------------------------------------
+TC_COS_CED_BV_01_C     INC     IUT should introduce testing tools
+TC_COS_CED_BV_03_C     INC     IUT should introduce testing tools
+TC_COS_CED_BV_04_C     N/A
+TC_COS_CED_BV_05_C     PASS    IUT must be connectable and discoverable
+TC_COS_CED_BV_07_C     PASS    IUT must be connectable and discoverable
+TC_COS_CED_BV_08_C     PASS    IUT must be connectable and discoverable
+TC_COS_CED_BV_09_C     PASS    IUT should introduce testing tools
+TC_COS_CED_BV_10_C     N/A
+TC_COS_CED_BV_11_C     PASS    IUT must be connectable and discoverable
+TC_COS_CED_BI_01_C     PASS    IUT must be connectable and discoverable
+TC_COS_CFD_BV_01_C     PASS    IUT must be connectable
+TC_COS_CFD_BV_02_C     PASS    IUT must be connectable
+TC_COS_CFD_BV_03_C     PASS    IUT must be connectable
+TC_COS_CED_BV_08_C     INC     IUT should introduce testing tools
+TC_COS_CED_BV_09_C     INC     IUT should introduce testing tools
+TC_COS_CED_BV_10_C     N/A
+TC_COS_CED_BI_11_C     PASS    IUT must be connectable
+TC_COS_CFD_BV_12_C     PASS    IUT must be connectable
+TC_COS_CFD_BV_13_C     N/A
+TC_COS_IEX_BV_01_C     PASS    IUT must be connectable
+TC_COS_IEX_BV_02_C     PASS    IUT must be connectable
+TC_COS_ECH_BV_01_C     PASS    IUT must be connectable
+TC_COS_ECH_BV_02_C     INC     IUT should introduce testing tools
+TC_CLS_CLR_BV_01_C     N/A
+TC_CLS_UCD_BV_01_C     N/A
+TC_CLS_UCD_BV_02_C     N/A
+TC_CLS_UCD_BV_03_C     N/A
+TC_EXF_BV_01_C         PASS    IUT must be connectable
+TC_EXF_BV_02_C         PASS    IUT must be connectable
+TC_EXF_BV_03_C         PASS    IUT must be connectable
+TC_EXF_BV_04_C         N/A
+TC_EXF_BV_05_C         PASS    IUT must be connectable
+TC_EXF_BV_06_C         N/A
+TC_CMC_BV_01_C         INC     IUT should introduce testing tools
+TC_CMC_BV_02_C         INC     IUT should introduce testing tools
+TC_CMC_BV_03_C         INC     IUT should introduce testing tools
+TC_CMC_BV_04_C         INC     IUT should introduce testing tools
+TC_CMC_BV_05_C         INC     IUT should introduce testing tools
+TC_CMC_BV_06_C         INC     IUT should introduce testing tools
+TC_CMC_BV_07_C         INC     IUT should introduce testing tools
+TC_CMC_BV_08_C         INC     IUT should introduce testing tools
+TC_CMC_BV_09_C         INC     IUT should introduce testing tools
+TC_CMC_BV_10_C         INC     IUT should introduce testing tools
+TC_CMC_BV_11_C         INC     IUT should introduce testing tools
+TC_CMC_BV_12_C         INC     IUT should introduce testing tools
+TC_CMC_BV_13_C         INC     IUT should introduce testing tools
+TC_CMC_BV_14_C         INC     IUT should introduce testing tools
+TC_CMC_BV_15_C         INC     IUT should introduce testing tools
+TC_CMC_BI_01_C         INC     IUT should introduce testing tools
+TC_CMC_BI_02_C         INC     IUT should introduce testing tools
+TC_CMC_BI_03_C         INC     IUT should introduce testing tools
+TC_CMC_BI_04_C         INC     IUT should introduce testing tools
+TC_CMC_BI_05_C         INC     IUT should introduce testing tools
+TC_CMC_BI_06_C         INC     IUT should introduce testing tools
+TC_FOC_BV_01_C         INC     IUT should introduce testing tools
+TC_FOC_BV_02_C         INC     IUT should introduce testing tools
+TC_FOC_BV_03_C         INC     IUT should introduce testing tools
+TC_FOC_BV_04_C         INC     IUT should introduce testing tools
+TC_OFS_BV_01_C         INC     IUT should introduce testing tools
+TC_OFS_BV_02_C         INC     IUT should introduce testing tools
+TC_OFS_BV_03_C         INC     IUT should introduce testing tools
+TC_OFS_BV_04_C         INC     IUT should introduce testing tools
+TC_OFS_BV_05_C         INC     IUT should introduce testing tools
+TC_OFS_BV_06_C         INC     IUT should introduce testing tools
+TC_OFS_BV_07_C         INC     IUT should introduce testing tools
+TC_OFS_BV_08_C         INC     IUT should introduce testing tools
+TC_ERM_BV_01_C         INC     IUT should introduce testing tools
+TC_ERM_BV_02_C         INC     IUT should introduce testing tools
+TC_ERM_BV_03_C         INC     IUT should introduce testing tools
+TC_ERM_BV_04_C         INC     IUT should introduce testing tools
+TC_ERM_BV_05_C         INC     IUT should introduce testing tools
+TC_ERM_BV_06_C         INC     IUT should introduce testing tools
+TC_ERM_BV_07_C         INC     IUT should introduce testing tools
+TC_ERM_BV_08_C         INC     IUT should introduce testing tools
+TC_ERM_BV_09_C         INC     IUT should introduce testing tools
+TC_ERM_BV_10_C         INC     IUT should introduce testing tools
+TC_ERM_BV_11_C         INC     IUT should introduce testing tools
+TC_ERM_BV_12_C         INC     IUT should introduce testing tools
+TC_ERM_BV_13_C         INC     IUT should introduce testing tools
+TC_ERM_BV_14_C         INC     IUT should introduce testing tools
+TC_ERM_BV_15_C         INC     IUT should introduce testing tools
+TC_ERM_BV_16_C         INC     IUT should introduce testing tools
+TC_ERM_BV_17_C         INC     IUT should introduce testing tools
+TC_ERM_BV_18_C         INC     IUT should introduce testing tools
+TC_ERM_BV_19_C         INC     IUT should introduce testing tools
+TC_ERM_BV_20_C         INC     IUT should introduce testing tools
+TC_ERM_BV_21_C         INC     IUT should introduce testing tools
+TC_ERM_BV_22_C         INC     IUT should introduce testing tools
+TC_ERM_BV_23_C         INC     IUT should introduce testing tools
+TC_ERM_BI_01_C         INC     IUT should introduce testing tools
+TC_ERM_BI_02_C         INC     IUT should introduce testing tools
+TC_ERM_BI_03_C         INC     IUT should introduce testing tools
+TC_ERM_BI_04_C         INC     IUT should introduce testing tools
+TC_ERM_BI_05_C         INC     IUT should introduce testing tools
+TC_STM_BV_01_C         INC     IUT should introduce testing tools
+TC_STM_BV_02_C         INC     IUT should introduce testing tools
+TC_STM_BV_03_C         INC     IUT should introduce testing tools
+TC_STM_BV_11_C         N/A
+TC_STM_BV_12_C         N/A
+TC_STM_BV_13_C         N/A
+TC_FIX_BV_01_C         PASS    IUT must be connectable
+TC_FIX_BV_02_C         N/A
+TC_EWC_BV_01_C         N/A
+TC_EWC_BV_02_C         N/A
+TC_EWC_BV_03_C         N/A
+TC_LSC_BV_01_C         N/A
+TC_LSC_BV_02_C         N/A
+TC_LSC_BV_03_C         N/A
+TC_LSC_BI_04_C         N/A
+TC_LSC_BI_05_C         N/A
+TC_LSC_BV_06_C         N/A
+TC_LSC_BV_07_C         N/A
+TC_LSC_BV_08_C         N/A
+TC_LSC_BV_09_C         N/A
+TC_LSC_BI_10_C         N/A
+TC_LSC_BI_11_C         N/A
+TC_LSC_BV_12_C         N/A
+TC_CCH_BV_01_C         N/A
+TC_CCH_BV_02_C         N/A
+TC_CCH_BV_03_C         N/A
+TC_CCH_BV_04_C         N/A
+TC_ECF_BV_01_C         N/A
+TC_ECF_BV_02_C         N/A
+TC_ECF_BV_03_C         N/A
+TC_ECF_BV_04_C         N/A
+TC_ECF_BV_05_C         N/A
+TC_ECF_BV_06_C         N/A
+TC_ECF_BV_07_C         N/A
+TC_ECF_BV_08_C         N/A
+TC_LE_CPU_BV_01_C      N/A
+TC_LE_CPU_BV_02_C      N/A
+TC_LE_CPU_BI_01_C      N/A
+TC_LE_CPU_BI_02_C      N/A
+TC_LE_REJ_BV_01_C      N/A
+
+-------------------------------------------------------------------------------
+	HELPER SECTION
+-------------------------------------------------------------------------------
+Test Name                          Result  Notes
+-------------------------------------------------------------------------------
+TC_HELPER_COS_CED_BV_01_C          PASS    IUT must be connectable
+TC_HELPER_COS_CED_BV_03_C          INC     IUT should introduce testing tools
+TC_HELPER_COS_CED_BV_04_C          N/A
+TC_HELPER_COS_CED_BV_05_C          INC     IUT should introduce testing tools
+TC_HELPER_COS_CED_BV_07_C          N/A
+TC_HELPER_COS_CED_BV_08_C          INC
+TC_HELPER_COS_CED_BV_09_C          INC
+TC_HELPER_COS_CED_BV_11_C          INC     IUT should introduce testing tools
+TC_HELPER_COS_CED_BI_01_C          PASS    IUT must be connectable
+TC_HELPER_COS_CFD_BV_01_C          INC
+TC_HELPER_COS_CFD_BV_02_C          INC     IUT should introduce testing tools
+TC_HELPER_COS_CFD_BV_03_C          INC     IUT should introduce testing tools
+TC_HELPER_COS_CFD_BV_08_C          PASS    IUT must be connectable
+TC_HELPER_COS_CFD_BV_09_C          PASS    IUT must be connectable
+TC_HELPER_COS_CFD_BV_10_C          INC
+TC_HELPER_COS_CFD_BV_11_C          INC     IUT should introduce testing tools
+TC_HELPER_COS_CFD_BV_12_C          PASS    IUT must be connectable
+TC_HELPER_COS_CFD_BV_13_C          INC
+TC_HELPER_CLS_CLR_BV_01_C          PASS    IUT must be connectable
+TC_HELPER_CLS_UCD_BV_01_C          N/A
+TC_HELPER_CLS_UCD_BV_02_C          N/A
+TC_HELPER_CLS_UCD_BV_03_C          N/A
+TC_HELPER_EXF_BV_01_C              PASS    IUT must be connectable
+TC_HELPER_EXF_BV_02_C              PASS    IUT must be connectable
+TC_HELPER_EXF_BV_03_C              PASS    IUT must be connectable
+TC_HELPER_EXF_BV_04_C              PASS    IUT must be connectable
+TC_HELPER_EXF_BV_05_C              PASS    IUT must be connectable
+TC_HELPER_EXF_BV_06_C              PASS    IUT must be connectable
+TC_HELPER_CMC_BV_01_C              INC
+TC_HELPER_CMC_BV_02_C              INC
+TC_HELPER_CMC_BV_03_C              INC
+TC_HELPER_CMC_BV_405_C             INC
+TC_HELPER_CMC_BV_06_C              INC
+TC_HELPER_CMC_BV_07_C              INC
+TC_HELPER_CMC_BV_08_C              INC
+TC_HELPER_CMC_BV_09_C              INC
+TC_HELPER_CMC_BV_10_C              INC
+TC_HELPER_CMC_BV_11_C              INC
+TC_HELPER_CMC_BV_12_C              INC
+TC_HELPER_CMC_BV_13_C              INC
+TC_HELPER_CMC_BV_14_C              INC
+TC_HELPER_CMC_BV_15_C              INC
+TC_HELPER_CMC_BI_01_C              INC
+TC_HELPER_CMC_BI_02_C              INC
+TC_HELPER_CMC_BI_03_C              INC
+TC_HELPER_CMC_BI_04_C              INC
+TC_HELPER_CMC_BI_05_C              INC
+TC_HELPER_CMC_BI_06_C              INC
+TC_HELPER_FOC_BV_01_ALT_1_C        INC
+TC_HELPER_FOC_BV_01_ALT_2_C        INC
+TC_HELPER_FOC_BV_02_ALT_1_C        INC
+TC_HELPER_FOC_BV_02_ALT_2_C        INC
+TC_HELPER_FOC_BV_03_ALT_1_C        INC
+TC_HELPER_FOC_BV_03_ALT_2_C        INC
+TC_HELPER_FOC_BV_04_ALT_1_C        INC
+TC_HELPER_FOC_BV_04_ALT_2_C        INC
+TC_HELPER_OFS_BV_01_C              INC
+TC_HELPER_OFS_BV_02_C              INC
+TC_HELPER_OFS_BV_03_C              INC
+TC_HELPER_OFS_BV_04_C              INC
+TC_HELPER_OFS_BV_05_C              INC
+TC_HELPER_OFS_BV_06_C              INC
+TC_HELPER_OFS_BV_07_C              INC
+TC_HELPER_OFS_BV_08_C              INC
+TC_HELPER_ERM_BV_01_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_02_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_02_C__no_Sframe_C INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_03_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_05_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_06_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_07_C_ALT_1_C      INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_07_C_ALT_2_C      INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_08_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_09_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_10_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_11_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_12_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_13_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_14_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_15_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_16_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_17_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_18_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_19_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_20_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_21_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_21_TxWin1_C       INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_21_ALT_1_C        INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_21_ALT_2_C        INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_22_ALT_1_C        INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_22_ALT_2_C        INC     IUT should introduce testing tools
+TC_HELPER_ERM_BV_23_C              INC     IUT should introduce testing tools
+TC_HELPER_ERM_BI_1_C               INC     IUT should introduce testing tools
+TC_HELPER_ERM_BI_2_C               INC     IUT should introduce testing tools
+TC_HELPER_ERM_BI_3_C               INC     IUT should introduce testing tools
+TC_HELPER_ERM_BI_4_C               INC     IUT should introduce testing tools
+TC_HELPER_ERM_BI_5_ALT_1_C         INC     IUT should introduce testing tools
+TC_HELPER_ERM_BI_5_ALT_2_C         INC     IUT should introduce testing tools
+TC_HELPER_ERM_BI_5_ALT_3_C         INC     IUT should introduce testing tools
+TC_HELPER_STM_BV_01_C              INC
+TC_HELPER_STM_BV_02_C              INC
+TC_HELPER_STM_BV_03_C              INC
+TC_HELPER_STM_BV_11_C              N/A
+TC_HELPER_STM_BV_12_C              N/A
+TC_HELPER_STM_BV_13_C              N/A
+TC_HELPER_FIX_BV_01_C              N/A
+TC_HELPER_FIX_BV_02_C              PASS    IUT must be connectable
+TC_HELPER_EWC_BV_01_C              INC
+TC_HELPER_EWC_BV_02_C              INC
+TC_HELPER_EWC_BV_03_C              INC
+TC_HELPER_LSC_BV_01_C              N/A
+TC_HELPER_LSC_BV_02_C              N/A
+TC_HELPER_LSC_BV_03_C              N/A
+TC_HELPER_LSC_BI_04_C              N/A
+TC_HELPER_LSC_BI_05_C              N/A
+TC_HELPER_LSC_BV_06_C              N/A
+TC_HELPER_LSC_BV_07_C              N/A
+TC_HELPER_LSC_BV_08_C              N/A
+TC_HELPER_LSC_BV_09_C           N/A
+TC_HELPER_LSC_BI_10_C           N/A
+TC_HELPER_LSC_BI_11_C           N/A
+TC_HELPER_LSC_BV_12_C           N/A
+TC_HELPER_CCH_BV_01_C           N/A
+TC_HELPER_CCH_BV_02_C           N/A
+TC_HELPER_CCH_BV_03_C           N/A
+TC_HELPER_CCH_BV_04_C           N/A
+TC_HELPER_ECF_BV_01_C           N/A
+TC_HELPER_ECF_BV_02_C           N/A
+TC_HELPER_ECF_BV_03_C           N/A
+TC_HELPER_ECF_BV_04_C           N/A
+TC_HELPER_ECF_BV_05_C           N/A
+TC_HELPER_ECF_BV_06_C           N/A
+TC_HELPER_ECF_BV_07_C           N/A
+TC_HELPER_ECF_BV_08_C           N/A
+TC_HELPER_LE_CPU_BV_01_C        N/A
+TC_HELPER_LE_CPU_BV_02_C        N/A
+TC_HELPER_LE_CPU_BI_01_C        N/A
+TC_HELPER_LE_CPU_BI_02_C        N/A
+TC_HELPER_LE_REJ_BI_01_C        N/A
-- 
1.8.1.2

