Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pics: Add PICS and PIXIT for AVCTP
Date: Wed, 15 Jan 2014 10:31:35 +0100
Message-Id: <1389778295-846-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add PICS/PIXIT for AVCTP, targeting Android 4.4.
---
 android/Makefile.am     |  1 +
 android/pics-avctp.txt  | 75 +++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-avctp.txt | 39 +++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 android/pics-avctp.txt
 create mode 100644 android/pixit-avctp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 7806f79..cd4a526 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -147,4 +147,5 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pics-l2cap.txt android/pixit-l2cap.txt \
 		android/pics-avrcp.txt android/pixit-avrcp.txt \
 		android/pics-a2dp.txt android/pixit-a2dp.txt \
+		android/pics-avctp.txt android/pixit-avctp.txt \
 		android/pts-l2cap.txt
diff --git a/android/pics-avctp.txt b/android/pics-avctp.txt
new file mode 100644
index 0000000..939ffdb
--- /dev/null
+++ b/android/pics-avctp.txt
@@ -0,0 +1,75 @@
+AVCTP PICS for the PTS tool.
+
+PTS version: 5.0
+
+* - different than PTS defaults
+# - not yet implemented/supported
+
+M - mandatory if such role selected
+O - optional
+
+		Protocol Version
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVCTP_0_1	False		AVCTP 1.0 (C.1)
+TSPC_AVCTP_0_2	True (*)	AVCTP 1.2 (C.1)
+TSPC_AVCTP_0_3	False		AVCTP 1.3 (C.1)
+TSPC_AVCTP_0_4	False		AVCTP 1.4 (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support only one Protocol Version.
+-------------------------------------------------------------------------------
+
+
+		Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVCTP_1_1	False		Controller (C.1)
+TSPC_AVCTP_1_2	True (*)	Target (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support at least one of the defined roles.
+-------------------------------------------------------------------------------
+
+
+		Controller Features
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVCTP_2_1	False		Message fragmentation (O)
+TSPC_AVCTP_2_2	False (*)	Transaction label management (M)
+TSPC_AVCTP_2_3	False (*)	Packet type field management (M)
+TSPC_AVCTP_2_4	False (*)	Message type field management (M)
+TSPC_AVCTP_2_5	False (*)	PID field management (M)
+TSPC_AVCTP_2_6	False (*)	IPID field mangement (M)
+TSPC_AVCTP_2_7	False (*)	Message information management (M)
+TSPC_AVCTP_2_8	False		Event registration for message reception (O)
+TSPC_AVCTP_2_9	False		Event registration for connection request (O)
+TSPC_AVCTP_2_10	False		Event registration for disconnection (O)
+TSPC_AVCTP_2_11	False		Connect request (O)
+TSPC_AVCTP_2_12	False		Disconnect request (O)
+TSPC_AVCTP_2_13	False		Send message (O)
+TSPC_AVCTP_2_14	False		Support for multiple AVCTP channel establishment
+					(O)
+-------------------------------------------------------------------------------
+
+
+		Target Features
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVCTP_3_1	True (*)	Message fragmentation (O)
+TSPC_AVCTP_3_2	True		Transaction label management (M)
+TSPC_AVCTP_3_3	True		Packet type field management (M)
+TSPC_AVCTP_3_4	True		Message type field management (M)
+TSPC_AVCTP_3_5	True		PID field management (M)
+TSPC_AVCTP_3_6	True		IPID field management (M)
+TSPC_AVCTP_3_7	True		Message information management (M)
+TSPC_AVCTP_3_8	True (*)	Event registration for message reception (O)
+TSPC_AVCTP_3_9	True (*)	Event registration for connection request (O)
+TSPC_AVCTP_3_10	True (*)	Event registration for disconnection request (O)
+TSPC_AVCTP_3_11	True (*)	Connect request (O)
+TSPC_AVCTP_3_12	True (*)	Disconnect request (O)
+TSPC_AVCTP_3_13	True (*)	Send message (O)
+TSPC_AVCTP_ALL	False		Enables all test cases when set to TRUE
+-------------------------------------------------------------------------------
diff --git a/android/pixit-avctp.txt b/android/pixit-avctp.txt
new file mode 100644
index 0000000..c5782fd
--- /dev/null
+++ b/android/pixit-avctp.txt
@@ -0,0 +1,39 @@
+AVCTP PIXIT for the PTS tool.
+
+PTS version: 5.0
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+# - should be set to PTS's bin/audio folder
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name			Value
+-------------------------------------------------------------------------------
+TSPX_avctp_psm			0017
+TSPX_avctp_profile_id		110E
+TSPX_connect_avdtp		TRUE
+TSPX_avctp_tester_command_data
+TSPX_avctp_tester_response_data
+TSPX_avctp_iut_command_data
+TSPX_avctp_iut_response_data
+TSPX_bd_addr_iut		08606E414394 (&)
+TSPX_pin_code			0000
+TSPX_delete_link_key		FALSE
+TSPX_security_enabled		FALSE
+TSPX_class_of_device		20050C
+TSPX_player_feature_bitmask	0000000000000007FFF00070000000000
+TSPX_avrcp_version
+TSPX_establish_avdtp_stream	TRUE
+TSPX_tester_av_role
+TSPX_time_guard			300000
+TSPX_avrcp_only			FALSE
+TSPX_use_implicit_send		TRUE
+TSPX_media_directory		C:\Program Files\Bluetooth SIG\Bluetooth PTS\
+					bin\audio (#)
+TSPX_no_confirmations		FALSE
+TSPX_auth_password		0000
+TSPX_auth_user_id		PTS
+TSPX_rfcomm_channel		8
+TSPX_l2cap_psm			1011
+-------------------------------------------------------------------------------
-- 
1.8.5.2

