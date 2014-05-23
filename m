Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/4] android/pics: Enable NAP and PBAP in MPS settings
Date: Fri, 23 May 2014 17:11:21 +0200
Message-Id: <1400857882-3298-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400857882-3298-1-git-send-email-szymon.janc@tieto.com>
References: <1400857882-3298-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-mps.txt  | 32 ++++++++++++++++----------------
 android/pixit-mps.txt |  2 +-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/android/pics-mps.txt b/android/pics-mps.txt
index e12cad0..5cbe1d8 100644
--- a/android/pics-mps.txt
+++ b/android/pics-mps.txt
@@ -24,8 +24,8 @@ TSPC_MPS_1_1	True (*)	A2DP 1.2 or later (O)
 TSPC_MPS_1_2	True (*)	AVRCP 1.3 or later (O)
 TSPC_MPS_1_3	False		DUN 1.1 or later (O)
 TSPC_MPS_1_4	True (*)	HFP 1.5 or later (O)
-TSPC_MPS_1_5	False		PAN 1.0 or later (O)
-TSPC_MPS_1_6	False		PBAP 1.1 or later (O)
+TSPC_MPS_1_5	True (*)	PAN 1.0 or later (O)
+TSPC_MPS_1_6	True (*)	PBAP 1.1 or later (O)
 -------------------------------------------------------------------------------
 
 
@@ -41,11 +41,11 @@ TSPC_MPS_2_5	False		DUN Gateway (GW) (C.1)
 TSPC_MPS_2_6	False		DUN Data Terminal (DT) (C.1)
 TSPC_MPS_2_7	True (*)	HFP Audio Gateway (AG) (C.1)
 TSPC_MPS_2_8	False		HFP Hands-Free (HF) (C.1)
-TSPC_MPS_2_9	False		PAN Network Access Point (NAP) (C.1)
+TSPC_MPS_2_9	True (*)	PAN Network Access Point (NAP) (C.1)
 TSPC_MPS_2_10	False		PAN Group Ad-hoc Network (GN) (C.1)
-TSPC_MPS_2_11	False		PAN User (PANU) (C.1)
+TSPC_MPS_2_11	True (*)	PAN User (PANU) (C.1)
 TSPC_MPS_2_12	False		PBAP PCE (C.1)
-TSPC_MPS_2_13	False		PBAP PSE (C.1)
+TSPC_MPS_2_13	True (*)	PBAP PSE (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory to declare each role as supported within the represented Profile
 	otherwise Excluded. The roles declared shall match that of the roles
@@ -77,10 +77,10 @@ TSPC_MPS_3_9	False		Place a call with a phone number supplied by
 				the HF (C.6)
 TSPC_MPS_3_10	True (*)	Register Notification: PLAYBACK_STATUS_CHANGED
 				(C.7)
-TSPC_MPS_3_11	False		Ability to support parallel data and call
+TSPC_MPS_3_11	True (*)	Ability to support parallel data and call
 				operation (O)
-TSPC_MPS_3_12	False		PBAP Phone Book Download (C.8)
-TSPC_MPS_3_13	False		Ability to support multiple concurrent device
+TSPC_MPS_3_12	True (*)	PBAP Phone Book Download (C.8)
+TSPC_MPS_3_13	True (*)	Ability to support multiple concurrent device
 				connections (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_MPS_2_1 (A2DP Source role) and TSPC_MPS_2_4 (AVRCP
@@ -109,7 +109,7 @@ C.8: Mandatory if TSPC_MPS_1_6 (PBAP 1.1 or later) and PBAP 2/1 (Phone Book
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_MPS_4_1	True		Multiple Profiles Single Device (MPSD) (M)
-TSPC_MPS_4_2	False		Multiple Profiles Multiple Devices (MPMD) (C.1)
+TSPC_MPS_4_2	True (*)	Multiple Profiles Multiple Devices (MPMD) (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_MPS_3_13 (Ability to support multiple concurrent device
 	connections), otherwise Excluded.
@@ -184,41 +184,41 @@ TSPC_MPS_6_25	False		HFP-AG and DUN-GW Implementation Terminate
 TSPC_MPS_6_26	False		HFP-HF and DUN-DT Implementation Terminate
 				Voice Call/Data Call during Data Communication
 				and Voice Call (C.6)
-TSPC_MPS_6_27	False		HFP-AG and PAN-NAP Implementation Data
+TSPC_MPS_6_27	True (*)	HFP-AG and PAN-NAP Implementation Data
 				Communication in Personal Area Network during
 				Active Voice Call (C.7)
 TSPC_MPS_6_28	False		HFP-HF and PAN-PANU Implementation Data
 				Communication in Personal Area Network during
 				Active Voice Call (C.8)
-TSPC_MPS_6_29	False		HFP-AG and PAN-NAP Implementation Outgoing
+TSPC_MPS_6_29	True (*)	HFP-AG and PAN-NAP Implementation Outgoing
 				Voice Call during Data Communication in Personal
 				Area Network (C.7)
 TSPC_MPS_6_30	False		HFP-HF and PAN-PANU Implementation Outgoing
 				Voice Call during Data Communication in Personal
 				Area Network (C.8)
-TSPC_MPS_6_31	False		HFP-AG and PAN-NAP Implementation Incoming Voice
+TSPC_MPS_6_31	True (*)	HFP-AG and PAN-NAP Implementation Incoming Voice
 				Call during Data Communication in Personal Area
 				Network (C.7)
 TSPC_MPS_6_32	False		HFP-HF and PAN-PANU Implementation Incoming
 				Voice Call during Data Communication in Personal
 				Area Network (C.8)
-TSPC_MPS_6_33	False		A2DP-SRC and PAN-NAP Implementation Start Audio
+TSPC_MPS_6_33	True (*)	A2DP-SRC and PAN-NAP Implementation Start Audio
 				Streaming during Data Communication in Personal
 				Area Network (C.9)
 TSPC_MPS_6_34	False		A2DP-SNK and PAN-PANU Implementation Start Audio
 				Streaming during Data Communication in Personal
 				Area Network (C.10)
-TSPC_MPS_6_35	False		A2DP-SRC and PAN-NAP Implementation Data
+TSPC_MPS_6_35	True (*)	A2DP-SRC and PAN-NAP Implementation Data
 				Communication Establishment in Personal Area
 				Network during Audio Streaming (C.9)
 TSPC_MPS_6_36	False		A2DP-SNK and PAN_PANU Implementation Data
 				Communication Establishment in Personal Area
 				Network during Audio Streaming (C.10)
-TSPC_MPS_6_37	False		A2DP-SRC_PBAP-Server Implementation Phonebook
+TSPC_MPS_6_37	True (*)	A2DP-SRC_PBAP-Server Implementation Phonebook
 				Download during Audio Streaming (C.11)
 TSPC_MPS_6_38	False		A2DP-SNK and PBAP-Client Implementation
 				Phonebook Download during Audio Streaming (C.12)
-TSPC_MPS_6_39	False		HFP-AG and PBAP-Server Implementation PBAP and
+TSPC_MPS_6_39	True (*)	HFP-AG and PBAP-Server Implementation PBAP and
 				HFP Connection Behavior (C.13)
 -------------------------------------------------------------------------------
 C.1: Mandatory if 2/1 (A2DP Source role), 2/4 (AVRCP Target role) and 2/7
diff --git a/android/pixit-mps.txt b/android/pixit-mps.txt
index 317a391..e3c8096 100644
--- a/android/pixit-mps.txt
+++ b/android/pixit-mps.txt
@@ -14,7 +14,7 @@ TSPX_avrcp_revision					1.5 (^)
 TSPX_class_of_device					20050C
 TSPX_establish_avdtp_stream				TRUE
 TSPX_iut_establishes_initial_condition			FALSE
-TSPX_tester_device
+TSPX_tester_device					A (*)
 TSPX_media_directory
 TSPX_bd_addr_iut					112233445566 (*&)
 TSPX_delete_link_key					FALSE
-- 
1.9.1

