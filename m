Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Add PTS testing files for MPS
Date: Tue, 13 May 2014 12:59:03 +0200
Message-Id: <1399978743-7383-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adding all required files for MPS: PICS, PIXIT as well as pts
tests listing.
---
 android/Makefile.am   |   5 +-
 android/pics-mps.txt  | 339 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-mps.txt |  46 +++++++
 android/pts-mps.txt   |  53 ++++++++
 4 files changed, 442 insertions(+), 1 deletion(-)
 create mode 100644 android/pics-mps.txt
 create mode 100644 android/pixit-mps.txt
 create mode 100644 android/pts-mps.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index fb3dcbb..d887d30 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -228,6 +228,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pics-hdp.txt \
 				android/pics-iopt.txt \
 				android/pics-sm.txt \
+				android/pics-mps.txt \
 				android/pixit-l2cap.txt \
 				android/pixit-gap.txt \
 				android/pixit-did.txt \
@@ -246,6 +247,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-hdp.txt \
 				android/pixit-iopt.txt \
 				android/pixit-sm.txt \
+				android/pixi-mps.txt \
 				android/bite-rfcomm.txt \
 				android/bite-spp.txt \
 				android/pts-l2cap.txt \
@@ -264,4 +266,5 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-hsp.txt \
 				android/pts-iopt.txt \
 				android/pts-hdp.txt \
-				android/pts-mcap.txt
+				android/pts-mcap.txt \
+				android/pts-mps.txt
diff --git a/android/pics-mps.txt b/android/pics-mps.txt
new file mode 100644
index 0000000..987880f
--- /dev/null
+++ b/android/pics-mps.txt
@@ -0,0 +1,339 @@
+MPS PICS for the PTS tool.
+
+PTS version 5.1
+
+* - different than PTS defaults
+# - not yet implemented/supported
+
+M - mandatory
+O - optional
+
+		Profile Version
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MPS_0_1	True		MPS v1.0 (M)
+-------------------------------------------------------------------------------
+
+
+		Profile Version Requirements
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MPS_1_1	True (*)	A2DP 1.2 or later (O)
+TSPC_MPS_1_2	True (*)	AVRCP 1.3 or later (O)
+TSPC_MPS_1_3	False		DUN 1.1 or later (O)
+TSPC_MPS_1_4	True (*)	HFP 1.5 or later (O)
+TSPC_MPS_1_5	False		PAN 1.0 or later (O)
+TSPC_MPS_1_6	False		PBAP 1.1 or later (O)
+-------------------------------------------------------------------------------
+
+
+		Profile Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MPS_2_1	True (*)	A2DP Source (SRC) (C.1)
+TSPC_MPS_2_2	False		A2DP Sink (SNK) (C.1)
+TSPC_MPS_2_3	True (*)	AVRCP Controller (CT) (C.1)
+TSPC_MPS_2_4	True (*)	AVRCP Target (TG) (C.1)
+TSPC_MPS_2_5	False		DUN Gateway (GW) (C.1)
+TSPC_MPS_2_6	False		DUN Data Terminal (DT) (C.1)
+TSPC_MPS_2_7	True (*)	HFP Audio Gateway (AG) (C.1)
+TSPC_MPS_2_8	False		HFP Hands-Free (HF) (C.1)
+TSPC_MPS_2_9	False		PAN Network Access Point (NAP) (C.1)
+TSPC_MPS_2_10	False		PAN Group Ad-hoc Network (GN) (C.1)
+TSPC_MPS_2_11	False		PAN User (PANU) (C.1)
+TSPC_MPS_2_12	False		PBAP PCE (C.1)
+TSPC_MPS_2_13	False		PBAP PSE (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory to declare each role as supported within the represented Profile
+	otherwise Excluded. The roles declared shall match that of the roles
+	supported within the Profile.
+-------------------------------------------------------------------------------
+
+
+		Profile Features
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MPS_3_1	True (*)	Receiving PASS THROUGH command in Category 1
+				(AVRCP - TG)  (C.1)
+TSPC_MPS_3_2	True (*)	Receiving PASS THROUGH command in Category 1
+				(AVRCP - TG) - PAUSE (C.1)
+TSPC_MPS_3_3	False		Sending PASS THROUGH command in Category 1
+				(AVRCP - CT) - PLAY (C.2)
+TSPC_MPS_3_4	False		Sending PASS THROUGH command in Category 1
+				(AVRCP - CT) - PAUSE (C.2)
+TSPC_MPS_3_5	True (*)	Transfer Control - Suspend (GAVDP - Initiator)
+				(C.3)
+TSPC_MPS_3_6	True (*)	Transfer Control - Suspend (GAVDP - Acceptor)
+				(C.4)
+TSPC_MPS_3_7	False		Accept an incoming voice call (in-band ring)
+				(C.5)
+TSPC_MPS_3_8	True (*)	Accept an incoming voice call (no in-band ring)
+				(C.5)
+TSPC_MPS_3_9	False		Place a call with a phone number supplied by
+				the HF (C.6)
+TSPC_MPS_3_10	True (*)	Register Notification: PLAYBACK_STATUS_CHANGED
+				(C.7)
+TSPC_MPS_3_11	False		Ability to support parallel data and call
+				operation (O)
+TSPC_MPS_3_12	False		PBAP Phone Book Download (C.8)
+TSPC_MPS_3_13	False		Ability to support multiple concurrent device
+				connections (O)
+-------------------------------------------------------------------------------
+C.1: Mandatory if TSPC_MPS_2_1 (A2DP Source role) and TSPC_MPS_2_4 (AVRCP
+	Target role) are supported, otherwise Excluded.
+C.2: Mandatory if TSPC_MPS_2_2 (A2DP Sink role) and TSPC_MPS_2_3 (AVRCP
+	Controller role) are supported, otherwise Excluded.
+C.3: Mandatory if TSPC_MPS_1_4 (HFP 1.5 or later) and TSPC_MPS_2_1 (A2DP Source
+	role) are supported; Optional if TSPC_MPS_1_4 (HFP 1.5 or later) and
+	TSPC_MPS_2_2 (A2DP Sink role) are supported, otherwise Excluded.
+C.4: Mandatory if TSPC_MPS_1_4 (HFP 1.5 or later) and TSPC_MPS_2_1 (A2DP Source
+	role) or TSPC_MPS_2_2 (A2DP Sink role) are supported, otherwise
+	Excluded.
+C.5: Mandatory to support at least one if TSPC_MPS_1_4 (HFP 1.5 or later) is
+	supported, otherwise Excluded.
+C.6: Mandatory if TSPC_MPS_1_4 (HFP 1.5 or later) and HFP 3/8 (Place a call with
+	a phone number supplied by the HF) are supported, otherwise Excluded.
+C.7: Mandatory if TSPC_MPS_2_3 (AVRCP Controller role) is supported, otherwise
+	Excluded.
+C.8: Mandatory if TSPC_MPS_1_6 (PBAP 1.1 or later) and PBAP 2/1 (Phone Book
+	Download) are supported, otherwise Excluded.
+-------------------------------------------------------------------------------
+
+
+		Device Capability Support
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MPS_4_1	True		Multiple Profiles Single Device (MPSD) (M)
+TSPC_MPS_4_2	False		Multiple Profiles Multiple Devices (MPMD) (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory if TSPC_MPS_3_13 (Ability to support multiple concurrent device
+	connections), otherwise Excluded.
+-------------------------------------------------------------------------------
+
+
+		MPSD scenarios
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MPS_6_1	True (*)	HFP-AG and A2DP-SRC Implementation Answer
+				Incoming Call during Audio Streaming (C.1)
+TSPC_MPS_6_2	False		HFP-HF and A2DP-SNK Implementation Answer
+				Incoming Call during Audio Streaming (C.2)
+TSPC_MPS_6_3	True (*)	HFP-AG and A2DP-SRC Implementation Outgoing
+				Call during Audio Streaming (C.1)
+TSPC_MPS_6_4	False		HFP-HF and A2DP-SNK Implementation Outgoing
+				Call during Audio Streaming (C.2)
+TSPC_MPS_6_5	True (*)	HFP-AG and A2DP-SRC Implementation Reject/Ignore
+				Incoming Call during Audio Streaming (C.1)
+TSPC_MPS_6_6	False		HFP-HF and A2DP-SNK Implementation Reject/Ignore
+				Incoming Call during Audio Streaming (C.2)
+TSPC_MPS_6_7	True (*)	HFP-AG and A2DP-SRC Implementation HFP Call
+				Termination during AVP Connection (C.1)
+TSPC_MPS_6_8	False		HFP-HF and A2DP-SNK Implementation HFP Call
+				Termination during AVP Connection (C.2)
+TSPC_MPS_6_9	True (*)	HFP-AG and A2DP-SRC Implementation Press Play
+				on Audio Player during Active Call (C.1)
+TSPC_MPS_6_10	False		HFP-HF and A2DP-SNK Implementation Press Play
+				on Audio Player during Active Call (C.2)
+TSPC_MPS_6_11	True (*)	HFP-AG and A2DP-SRC Implementation Start Audio
+				Streaming after AVRCP Play Command (C.1)
+TSPC_MPS_6_12	False		HFP-HF and A2DP-SNK Implementation Start Audio
+				Streaming after AVRCP Play Command (C.2)
+TSPC_MPS_6_13	True (*)	HFP-AG and A2DP-SRC Implementation Suspend Audio
+				Streaming after AVRCP Pause/Stop (C.1)
+TSPC_MPS_6_14	False		HFP-HF and A2DP-SNK Implementation Suspend Audio
+				Streaming after AVRCP Pause/Stop (C.2)
+TSPC_MPS_6_15	False		HFP-AG and DUN-GW Implementation Data
+				Communication under PSDM (DUN) during Active
+				Voice Call (C.3)
+TSPC_MPS_6_16	False		HFP-HF and DUN-DT Implementation Data
+				Communication under PSDM (DUN) during Active
+				Voice call (C.4)
+TSPC_MPS_6_17	False		HFP-AG and DUN-GW Implementation Outgoing Voice
+				Call during Data Communication under PSDM (DUN)
+				(C.3)
+TSPC_MPS_6_18	False		HFP-HF and DUN-DT Implementation Outgoing Voice
+				Call during Data Communication under PSDM (DUN)
+				(C.4)
+TSPC_MPS_6_19	False		HFP-AG and DUN-GW Implementation Incoming Voice
+				Call during Data Communication under PSDM (DUN)
+				(C.3)
+TSPC_MPS_6_20	False		HFP-HF and DUN-DT Implementation Incoming Voice
+				Call during Data Communication under PSDM (DUN)
+				(C.4)
+TSPC_MPS_6_21	False		A2DP-SRC and DUN-GW Implementation Start Audio
+				Streaming during Data Communication under PSDM
+				(DUN) (C.5)
+TSPC_MPS_6_22	False		A2DP-SNK and DUN-DT Implementation Start Audio
+				Streaming during Data Communication under PSDM
+				(DUN) (C.6)
+TSPC_MPS_6_23	False		A2DP-SRC and DUN-GW Implementation Data
+				Communication Establishment under PSDM (DUN)
+				during Audio Streaming (C.5)
+TSPC_MPS_6_24	False		A2DP-SNK and DUN-DT Implementation Data
+				Communication Establishment under PSDM (DUN)
+				during Audio Streaming (C.6)
+TSPC_MPS_6_25	False		HFP-AG and DUN-GW Implementation Terminate
+				Voice Call/Data Call during Data Communication
+				and Voice Call (C.5)
+TSPC_MPS_6_26	False		HFP-HF and DUN-DT Implementation Terminate
+				Voice Call/Data Call during Data Communication
+				and Voice Call (C.6)
+TSPC_MPS_6_27	False		HFP-AG and PAN-NAP Implementation Data
+				Communication in Personal Area Network during
+				Active Voice Call (C.7)
+TSPC_MPS_6_28	False		HFP-HF and PAN-PANU Implementation Data
+				Communication in Personal Area Network during
+				Active Voice Call (C.8)
+TSPC_MPS_6_29	False		HFP-AG and PAN-NAP Implementation Outgoing
+				Voice Call during Data Communication in Personal
+				Area Network (C.7)
+TSPC_MPS_6_30	False		HFP-HF and PAN-PANU Implementation Outgoing
+				Voice Call during Data Communication in Personal
+				Area Network (C.8)
+TSPC_MPS_6_31	False		HFP-AG and PAN-NAP Implementation Incoming Voice
+				Call during Data Communication in Personal Area
+				Network (C.7)
+TSPC_MPS_6_32	False		HFP-HF and PAN-PANU Implementation Incoming
+				Voice Call during Data Communication in Personal
+				Area Network (C.8)
+TSPC_MPS_6_33	False		A2DP-SRC and PAN-NAP Implementation Start Audio
+				Streaming during Data Communication in Personal
+				Area Network (C.9)
+TSPC_MPS_6_34	False		A2DP-SNK and PAN-PANU Implementation Start Audio
+				Streaming during Data Communication in Personal
+				Area Network (C.10)
+TSPC_MPS_6_35	False		A2DP-SRC and PAN-NAP Implementation Data
+				Communication Establishment in Personal Area
+				Network during Audio Streaming (C.9)
+TSPC_MPS_6_36	False		A2DP-SNK and PAN_PANU Implementation Data
+				Communication Establishment in Personal Area
+				Network during Audio Streaming (C.10)
+TSPC_MPS_6_37	False		A2DP-SRC_PBAP-Server Implementation Phonebook
+				Download during Audio Streaming (C.11)
+TSPC_MPS_6_38	False		A2DP-SNK and PBAP-Client Implementation
+				Phonebook Download during Audio Streaming (C.12)
+TSPC_MPS_6_39	False		HFP-AG and PBAP-Server Implementation PBAP and
+				HFP Connection Behavior (C.13)
+-------------------------------------------------------------------------------
+C.1: Mandatory if 2/1 (A2DP Source role), 2/4 (AVRCP Target role) and 2/7
+	(HFP Audio Gateway role) are supported, otherwise Excluded.
+C.2: Mandatory if 2/2 (A2DP Sink role), 2/3 (AVRCP Controller role) and 2/8
+	(HFP Hands-Free role) are supported, otherwise Excluded.
+C.3: Mandatory if 2/5 (DUN Gateway role) and 2/7 (HFP Audio Gateway role)
+	are supported and 3/9 ( Ability to support parallel data and call
+	operation), otherwise Excluded.
+C.4: Mandatory if 2/6 (DUN Data Terminal role) and 2/8 (HFP Hands-Free role)
+	are supported, otherwise Excluded.
+C.5: Mandatory if 2/1 (A2DP Source role) and 2/5 (DUN Gateway role) are
+	supported, otherwise Excluded.
+C.6: Mandatory if 2/2 (A2DP Sink role) and 2/6 (DUN Data Terminal role) are
+	supported, otherwise Excluded.
+C.7: Mandatory if 2/7 (HFP Audio Gateway role) and 2/9 (PAN Network Access Point
+	role) and 3/11 (Ability to support parallel data and call operation) are
+	supported, otherwise Excluded.
+C.8: Mandatory if 2/8 (HFP Hands-Free role) and 2/11 (PAN User role) are
+	supported and 3/11, otherwise Excluded.
+C.9: Mandatory if 2/1 (A2DP Source role) and 2/9 (PAN Network Access Point role)
+	are supported, otherwise Excluded.
+C.10: Mandatory if 2/2 (A2DP Sink role) and 2/11 (PAN User role) are supported,
+	otherwise Excluded.
+C.11: Mandatory if 2/1 (A2DP Source role) and 2/13 (PBAP PSE role) are
+	supported, otherwise Excluded.
+C.12: Mandatory if 2/2 (A2DP Sink role) and 2/12 (PBAP PCE role) are supported,
+	otherwise Excluded.
+C.13: Mandatory if 2/7 (HFP Audio Gateway role) and 2/13 (PBAP PSE role) are
+	supported, otherwise Excluded.
+-------------------------------------------------------------------------------
+
+
+		MPMD Features
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MPS_7_1	False		HFP-HF and A2DP-SNK and AVRCP-CT Implementation
+				Answer Incoming Call during Audio Streaming
+				(C.1)
+TSPC_MPS_7_2	True (*)	A2DP-SRC and AVRCP-TG Implementation Answer
+				Incoming Call during Audio Streaming (C.2)
+TSPC_MPS_7_3	False		HFP-HF and A2DP-SNK and AVRCP-CT Implementation
+				Outgoing Call during Audio Streaming (C.1)
+TSPC_MPS_7_4	True (*)	A2DP-SRC and AVRCP-TG Implementation Outgoing
+				Call during Audio Streaming (C.2)
+TSPC_MPS_7_5	False		HFP-HF and A2DP-SNK and AVRCP-CT Implementation
+				Reject/Ignore Incoming Call during Audio
+				Streaming (C.1)
+TSPC_MPS_7_6	True (*)	A2DP-SRC and AVRCP-TG Implementation
+				Reject/Ignore Incoming Call during Audio
+				Streaming (C.2)
+TSPC_MPS_7_7	False		HFP-HF and A2DP-SNK and AVRCP-CT Implementation
+				HFP Call Termination during AVP Connection (C.1)
+TSPC_MPS_7_8	True (*)	A2DP-SRC and AVRCP-TG Implementation HFP Call
+				Termination during AVP Connection (C.2)
+TSPC_MPS_7_9	False		HFP-HF and A2DP-SNK and AVRCP-CT Implementation
+				Press Play on Audio Player during Active Call
+				(C.1)
+TSPC_MPS_7_10	True (*)	A2DP-SRC and AVRCP-TG Implementation Press Play
+				on Audio Player during Active Call (C.2)
+TSPC_MPS_7_11	True (*)	A2DP-SRC and AVRCP-TG Implementation Start Audio
+				Streaming during Data Communication under PSDM
+				(C.2)
+TSPC_MPS_7_12	False		A2DP-SNK and AVRCP-CT and DUN-DT Implementation
+				Start Audio Streaming during Data Communication
+				under PSDM (C.3)
+TSPC_MPS_7_13	True (*)	A2DP-SRC and AVRCP-TG Implementation Start
+				Packet Data Communication during Audio Streaming
+				(C.2)
+TSPC_MPS_7_14	False		A2DP-SNK and AVRCP-CT and DUN-DT Implementation
+				Start Packet Data Communication during Audio
+				Streaming (C.3)
+-------------------------------------------------------------------------------
+C.1: Mandatory if 2/2 (A2DP Sink role), 2/3 (AVRCP Controller role) and 2/8
+	(HFP Hands-Free role) are supported, otherwise Excluded.
+C.2: Mandatory if 2/1 (A2DP Source role) and 2/4 (AVRCP Target role) are
+	supported, otherwise Excluded.
+C.3: Mandatory if 2/2 (A2DP Sink role), 2/3 (AVRCP Controller role) and 2/6
+	(DUN Data Terminal role) supported, otherwise Excluded.
+-------------------------------------------------------------------------------
+
+
+		MPS Procedures
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MPS_8_1	True (*)	AVP Suspension (C.1)
+TSPC_MPS_8_2	True (*)	Profile (Dis-)Connection behavior (C.2)
+-------------------------------------------------------------------------------
+C.1: Mandatory if 1/1 (A2DP 1.2 or later) and 1/2 (AVRCP 1.3 or later) are
+	supported, otherwise Excluded.
+C.2: Mandatory if 1/1 (A2DP 1.2 or later), 1/2 (AVRCP 1.3 or later) and 1/4 (HFP
+	1.5 or later) are supported, otherwise Excluded.
+-------------------------------------------------------------------------------
+
+
+		MPS Dependencies
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MPS_9_1	True		Implements Bluetooth Core Specification v2.1
+				+ EDR or later (M)
+-------------------------------------------------------------------------------
+
+
+		MPS Requirements
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MPS_10_1	True		SDP Record (M)
+TSPC_MPS_10_2	True (*)	Media Stream Suspension (C.1)
+TSPC_MPS_10_3	True (*)	Sniff Mode during Streaming (C.2)
+-------------------------------------------------------------------------------
+C.1: Mandatory if 1/1 (A2DP1.2 or later) and 1/4 (HFP 1.5 or later) are
+	supported, otherwise Excluded.
+C.2: Mandatory if 1/1 (A2DP 1.2 or later) is supported, otherwise Excluded.
+-------------------------------------------------------------------------------
diff --git a/android/pixit-mps.txt b/android/pixit-mps.txt
new file mode 100644
index 0000000..c59c913
--- /dev/null
+++ b/android/pixit-mps.txt
@@ -0,0 +1,46 @@
+MPS PIXIT for the PTS tool.
+
+PTS version: 5.1
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+^ - should be set accordingly
+
+               Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_avrcp_revision
+TSPX_class_of_device					20050C
+TSPX_establish_avdtp_stream				TRUE
+TSPX_iut_establishes_initial_condition			FALSE
+TSPX_tester_device
+TSPX_media_directory
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_delete_link_key					FALSE
+TSPX_pin_code						0000
+TSPX_security_enabled					FALSE
+TSPX_time_guard						300000
+TSPX_use_implicit_send					TRUE
+TSPX_auth_password					0000
+TSPX_auth_user_id					PTS
+TSPX_l2cap_psm						1003
+TSPX_rfcomm_channel					8
+TSPX_no_confirmations					FALSE
+TSPX_AG_match_tester_BRSF_codec_negotiation_bit		FALSE
+TSPX_network_supports_correct_call_and_callstatus	TRUE
+TSPX_no_fail_verdicts					FALSE
+TSPX_packet_type_sco					00A0
+TSPX_phone_number					1234567 (^)
+TSPX_phone_number_memory				1
+TSPX_phone_number_memory_invalid_index			9999
+TSPX_phone_number_type					129
+TSPX_scan_all_memory_dial_locations			FALSE
+TSPX_second_phone_number				1234567 (^)
+TSPX_second_phone_type					129
+TSPX_secure_simple_pairing_pass_key_confirmation	FALSE
+TSPX_server_channel_iut					00
+TSPX_server_channel_tester				01
+TSPX_verbose_implicit_send				FALSE
+TSPX_verify_CLIP_information				TRUE
+-------------------------------------------------------------------------------
diff --git a/android/pts-mps.txt b/android/pts-mps.txt
new file mode 100644
index 0000000..005318d
--- /dev/null
+++ b/android/pts-mps.txt
@@ -0,0 +1,53 @@
+PTS test results for MPS
+
+PTS version: 5.1
+Tested: not tested
+Android version: 4.4.2
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+NONE	test result is none
+
+-------------------------------------------------------------------------------
+Test Name				Result	Notes
+-------------------------------------------------------------------------------
+TC_AG_SRC_HFAV_ACT_SD_BV_01_I		INC
+TC_AG_SRC_HFAV_ACT_SD_BV_02_I		INC
+TC_AG_SRC_HFAV_ACT_SD_BV_03_I		INC
+TC_AG_SRC_HFAV_CLH_SD_BV_01_I		INC
+TC_AG_SRC_HFAV_CLH_SD_BV_02_I		N/A
+TC_AG_SRC_HFAV_CLH_SD_BV_03_I		INC
+TC_AG_SRC_HFAV_CLH_SD_BV_04_I		INC
+TC_AG_SRC_HFAV_CLH_SD_BV_05_I		INC
+TC_AG_SRC_HFAV_CLH_SD_BV_06_I		INC
+TC_AVP_CTH_SD_BI_01_I			INC
+TC_AVP_CTH_SD_BI_02_I			INC
+TC_HF_SNK_HFAV_ACT_SD_BV_01_I		N/A
+TC_HF_SNK_HFAV_ACT_SD_BV_02_I		N/A
+TC_HF_SNK_HFAV_ACT_SD_BV_03_I		N/A
+TC_HF_SNK_HFAV_CLH_SD_BV_01_I		N/A
+TC_HF_SNK_HFAV_CLH_SD_BV_02_I		N/A
+TC_HF_SNK_HFAV_CLH_SD_BV_03_I		N/A
+TC_HF_SNK_HFAV_CLH_SD_BV_04_I		N/A
+TC_HF_SNK_HFAV_CLH_SD_BV_05_I		N/A
+TC_HF_SNK_HFAV_CLH_SD_BV_06_I		N/A
+TC_HF_SNK_CT_HFAV_ACT_MD_BV_01_I	N/A
+TC_HF_SNK_CT_HFAV_CLH_MD_BV_01_I	N/A
+TC_HF_SNK_CT_HFAV_CLH_MD_BV_02_I	N/A
+TC_HF_SNK_CT_HFAV_CLH_MD_BV_03_I	N/A
+TC_HF_SNK_CT_HFAV_CLH_MD_BV_04_I	N/A
+TC_HF_SNK_CT_HFAV_CLH_MD_BV_05_I	N/A
+TC_HF_SNK_CT_HFAV_CLH_MD_BV_06_I	N/A
+TC_SDP_CTH_SD_BV_01_I			INC
+TC_SRC_TG_HFAV_ACT_MD_BV_01_I		INC
+TC_SRC_TG_HFAV_CLH_MD_BV_01_I		INC
+TC_SRC_TG_HFAV_CLH_MD_BV_02_I		INC
+TC_SRC_TG_HFAV_CLH_MD_BV_03_I		INC
+TC_SRC_TG_HFAV_CLH_MD_BV_04_I		INC
+TC_SRC_TG_HFAV_CLH_MD_BV_05_I		INC
+TC_SRC_TG_HFAV_CLH_MD_BV_06_I		INC
+TC_PAIRING_HF_SNK_CT			INC
+-------------------------------------------------------------------------------
-- 
1.8.5.3

