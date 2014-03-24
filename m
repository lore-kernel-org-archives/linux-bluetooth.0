Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianchlad@gmail.com>
Subject: [PATCH 3/4] android: Add doc folder
Date: Mon, 24 Mar 2014 15:14:56 +0100
Message-Id: <1395670497-12969-3-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1395670497-12969-1-git-send-email-sebastian.chlad@tieto.com>
References: <1395670497-12969-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sebastian Chlad <sebastianchlad@gmail.com>

As the number of files for PTS, PIXIT and PICS is growing we could
store these under doc/
---
 android/doc/pics-avctp.txt  | 75 +++++++++++++++++++++++++++++++++++++++++++++
 android/doc/pixit-avctp.txt | 40 ++++++++++++++++++++++++
 android/doc/pts-avctp.txt   | 42 +++++++++++++++++++++++++
 android/pics-avctp.txt      | 75 ---------------------------------------------
 android/pixit-avctp.txt     | 40 ------------------------
 android/pts-avctp.txt       | 42 -------------------------
 6 files changed, 157 insertions(+), 157 deletions(-)
 create mode 100644 android/doc/pics-avctp.txt
 create mode 100644 android/doc/pixit-avctp.txt
 create mode 100644 android/doc/pts-avctp.txt
 delete mode 100644 android/pics-avctp.txt
 delete mode 100644 android/pixit-avctp.txt
 delete mode 100644 android/pts-avctp.txt

diff --git a/android/doc/pics-avctp.txt b/android/doc/pics-avctp.txt
new file mode 100644
index 0000000..fa7759c
--- /dev/null
+++ b/android/doc/pics-avctp.txt
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
+TSPC_AVCTP_0_2	False		AVCTP 1.2 (C.1)
+TSPC_AVCTP_0_3	False		AVCTP 1.3 (C.1)
+TSPC_AVCTP_0_4	True (*)	AVCTP 1.4 (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support only one Protocol Version.
+-------------------------------------------------------------------------------
+
+
+		Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVCTP_1_1	True (*)	Controller (C.1)
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
+TSPC_AVCTP_2_2	True		Transaction label management (M)
+TSPC_AVCTP_2_3	True		Packet type field management (M)
+TSPC_AVCTP_2_4	True		Message type field management (M)
+TSPC_AVCTP_2_5	True		PID field management (M)
+TSPC_AVCTP_2_6	True		IPID field mangement (M)
+TSPC_AVCTP_2_7	True		Message information management (M)
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
+TSPC_AVCTP_3_1	False		Message fragmentation (O)
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
diff --git a/android/doc/pixit-avctp.txt b/android/doc/pixit-avctp.txt
new file mode 100644
index 0000000..9f54bcf
--- /dev/null
+++ b/android/doc/pixit-avctp.txt
@@ -0,0 +1,40 @@
+AVCTP PIXIT for the PTS tool.
+
+PTS version: 5.0
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+# - should be set to PTS's bin/audio folder
+^ - should be set accordingly
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
+TSPX_bd_addr_iut		112233445566 (*&)
+TSPX_pin_code			0000
+TSPX_delete_link_key		FALSE
+TSPX_security_enabled		FALSE
+TSPX_class_of_device		20050C
+TSPX_player_feature_bitmask	0000000000000007FFF00070000000000
+TSPX_avrcp_version		1.5 (*^)
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
diff --git a/android/doc/pts-avctp.txt b/android/doc/pts-avctp.txt
new file mode 100644
index 0000000..e7b0ab9
--- /dev/null
+++ b/android/doc/pts-avctp.txt
@@ -0,0 +1,42 @@
+PTS test results for AVCTP
+
+PTS version: 5.0
+Tested: 24-Mar-2014
+Android version: 4.4.2
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+
+		Controller (CT)
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_CT_CCM_BV_01_C	N/A
+TC_CT_CCM_BV_02_C	N/A
+TC_CT_CCM_BV_03_C	N/A
+TC_CT_CCM_BV_04_C	N/A
+TC_CT_CCM_BI_01_C	N/A
+TC_CT_NFR_BV_01_C	N/A
+TC_CT_NFR_BV_04_C	INC
+TC_CT_FRA_BV_01_C	N/A
+TC_CT_FRA_BV_04_C	N/A
+-------------------------------------------------------------------------------
+
+
+		Target (TG)
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_TG_CCM_BV_01_C	INC
+TC_TG_CCM_BV_02_C	PASS
+TC_TG_CCM_BV_03_C	PASS
+TC_TG_CCM_BV_04_C	INC
+TC_TG_NFR_BV_02_C	INC
+TC_TG_NFR_BV_03_C	INC
+TC_TG_NFR_BI_01_C	PASS
+TC_TG_FRA_BV_02_C	N/A	Fragmentation not supported
+TC_TG_FRA_BV_03_C	N/A	Fragmentation not supported
+-------------------------------------------------------------------------------
diff --git a/android/pics-avctp.txt b/android/pics-avctp.txt
deleted file mode 100644
index fa7759c..0000000
--- a/android/pics-avctp.txt
+++ /dev/null
@@ -1,75 +0,0 @@
-AVCTP PICS for the PTS tool.
-
-PTS version: 5.0
-
-* - different than PTS defaults
-# - not yet implemented/supported
-
-M - mandatory if such role selected
-O - optional
-
-		Protocol Version
--------------------------------------------------------------------------------
-Parameter Name	Selected	Description
--------------------------------------------------------------------------------
-TSPC_AVCTP_0_1	False		AVCTP 1.0 (C.1)
-TSPC_AVCTP_0_2	False		AVCTP 1.2 (C.1)
-TSPC_AVCTP_0_3	False		AVCTP 1.3 (C.1)
-TSPC_AVCTP_0_4	True (*)	AVCTP 1.4 (C.1)
--------------------------------------------------------------------------------
-C.1: Mandatory to support only one Protocol Version.
--------------------------------------------------------------------------------
-
-
-		Roles
--------------------------------------------------------------------------------
-Parameter Name	Selected	Description
--------------------------------------------------------------------------------
-TSPC_AVCTP_1_1	True (*)	Controller (C.1)
-TSPC_AVCTP_1_2	True (*)	Target (C.1)
--------------------------------------------------------------------------------
-C.1: Mandatory to support at least one of the defined roles.
--------------------------------------------------------------------------------
-
-
-		Controller Features
--------------------------------------------------------------------------------
-Parameter Name	Selected	Description
--------------------------------------------------------------------------------
-TSPC_AVCTP_2_1	False		Message fragmentation (O)
-TSPC_AVCTP_2_2	True		Transaction label management (M)
-TSPC_AVCTP_2_3	True		Packet type field management (M)
-TSPC_AVCTP_2_4	True		Message type field management (M)
-TSPC_AVCTP_2_5	True		PID field management (M)
-TSPC_AVCTP_2_6	True		IPID field mangement (M)
-TSPC_AVCTP_2_7	True		Message information management (M)
-TSPC_AVCTP_2_8	False		Event registration for message reception (O)
-TSPC_AVCTP_2_9	False		Event registration for connection request (O)
-TSPC_AVCTP_2_10	False		Event registration for disconnection (O)
-TSPC_AVCTP_2_11	False		Connect request (O)
-TSPC_AVCTP_2_12	False		Disconnect request (O)
-TSPC_AVCTP_2_13	False		Send message (O)
-TSPC_AVCTP_2_14	False		Support for multiple AVCTP channel establishment
-					(O)
--------------------------------------------------------------------------------
-
-
-		Target Features
--------------------------------------------------------------------------------
-Parameter Name	Selected	Description
--------------------------------------------------------------------------------
-TSPC_AVCTP_3_1	False		Message fragmentation (O)
-TSPC_AVCTP_3_2	True		Transaction label management (M)
-TSPC_AVCTP_3_3	True		Packet type field management (M)
-TSPC_AVCTP_3_4	True		Message type field management (M)
-TSPC_AVCTP_3_5	True		PID field management (M)
-TSPC_AVCTP_3_6	True		IPID field management (M)
-TSPC_AVCTP_3_7	True		Message information management (M)
-TSPC_AVCTP_3_8	True (*)	Event registration for message reception (O)
-TSPC_AVCTP_3_9	True (*)	Event registration for connection request (O)
-TSPC_AVCTP_3_10	True (*)	Event registration for disconnection request (O)
-TSPC_AVCTP_3_11	True (*)	Connect request (O)
-TSPC_AVCTP_3_12	True (*)	Disconnect request (O)
-TSPC_AVCTP_3_13	True (*)	Send message (O)
-TSPC_AVCTP_ALL	False		Enables all test cases when set to TRUE
--------------------------------------------------------------------------------
diff --git a/android/pixit-avctp.txt b/android/pixit-avctp.txt
deleted file mode 100644
index 9f54bcf..0000000
--- a/android/pixit-avctp.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-AVCTP PIXIT for the PTS tool.
-
-PTS version: 5.0
-
-* - different than PTS defaults
-& - should be set to IUT Bluetooth address
-# - should be set to PTS's bin/audio folder
-^ - should be set accordingly
-
-		Required PIXIT settings
--------------------------------------------------------------------------------
-Parameter Name			Value
--------------------------------------------------------------------------------
-TSPX_avctp_psm			0017
-TSPX_avctp_profile_id		110E
-TSPX_connect_avdtp		TRUE
-TSPX_avctp_tester_command_data
-TSPX_avctp_tester_response_data
-TSPX_avctp_iut_command_data
-TSPX_avctp_iut_response_data
-TSPX_bd_addr_iut		112233445566 (*&)
-TSPX_pin_code			0000
-TSPX_delete_link_key		FALSE
-TSPX_security_enabled		FALSE
-TSPX_class_of_device		20050C
-TSPX_player_feature_bitmask	0000000000000007FFF00070000000000
-TSPX_avrcp_version		1.5 (*^)
-TSPX_establish_avdtp_stream	TRUE
-TSPX_tester_av_role
-TSPX_time_guard			300000
-TSPX_avrcp_only			FALSE
-TSPX_use_implicit_send		TRUE
-TSPX_media_directory		C:\Program Files\Bluetooth SIG\Bluetooth PTS\
-					bin\audio (#)
-TSPX_no_confirmations		FALSE
-TSPX_auth_password		0000
-TSPX_auth_user_id		PTS
-TSPX_rfcomm_channel		8
-TSPX_l2cap_psm			1011
--------------------------------------------------------------------------------
diff --git a/android/pts-avctp.txt b/android/pts-avctp.txt
deleted file mode 100644
index e7b0ab9..0000000
--- a/android/pts-avctp.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-PTS test results for AVCTP
-
-PTS version: 5.0
-Tested: 24-Mar-2014
-Android version: 4.4.2
-
-Results:
-PASS	test passed
-FAIL	test failed
-INC	test is inconclusive
-N/A	test is disabled due to PICS setup
-
-		Controller (CT)
--------------------------------------------------------------------------------
-Test Name		Result	Notes
--------------------------------------------------------------------------------
-TC_CT_CCM_BV_01_C	N/A
-TC_CT_CCM_BV_02_C	N/A
-TC_CT_CCM_BV_03_C	N/A
-TC_CT_CCM_BV_04_C	N/A
-TC_CT_CCM_BI_01_C	N/A
-TC_CT_NFR_BV_01_C	N/A
-TC_CT_NFR_BV_04_C	INC
-TC_CT_FRA_BV_01_C	N/A
-TC_CT_FRA_BV_04_C	N/A
--------------------------------------------------------------------------------
-
-
-		Target (TG)
--------------------------------------------------------------------------------
-Test Name		Result	Notes
--------------------------------------------------------------------------------
-TC_TG_CCM_BV_01_C	INC
-TC_TG_CCM_BV_02_C	PASS
-TC_TG_CCM_BV_03_C	PASS
-TC_TG_CCM_BV_04_C	INC
-TC_TG_NFR_BV_02_C	INC
-TC_TG_NFR_BV_03_C	INC
-TC_TG_NFR_BI_01_C	PASS
-TC_TG_FRA_BV_02_C	N/A	Fragmentation not supported
-TC_TG_FRA_BV_03_C	N/A	Fragmentation not supported
--------------------------------------------------------------------------------
-- 
1.8.5.3

