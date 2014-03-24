Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianchlad@gmail.com>
Subject: [PATCH 2/4] android/pts: Update PICS and PIXIT for AVCTP
Date: Mon, 24 Mar 2014 15:14:55 +0100
Message-Id: <1395670497-12969-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1395670497-12969-1-git-send-email-sebastian.chlad@tieto.com>
References: <1395670497-12969-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sebastian Chlad <sebastianchlad@gmail.com>

Updated PICS include both roles - controller as well as target.
---
 android/pics-avctp.txt  | 14 +++++++-------
 android/pixit-avctp.txt |  5 +++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/android/pics-avctp.txt b/android/pics-avctp.txt
index 41ad4db..fa7759c 100644
--- a/android/pics-avctp.txt
+++ b/android/pics-avctp.txt
@@ -25,7 +25,7 @@ C.1: Mandatory to support only one Protocol Version.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVCTP_1_1	False		Controller (C.1)
+TSPC_AVCTP_1_1	True (*)	Controller (C.1)
 TSPC_AVCTP_1_2	True (*)	Target (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support at least one of the defined roles.
@@ -37,12 +37,12 @@ C.1: Mandatory to support at least one of the defined roles.
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_AVCTP_2_1	False		Message fragmentation (O)
-TSPC_AVCTP_2_2	False (*)	Transaction label management (M)
-TSPC_AVCTP_2_3	False (*)	Packet type field management (M)
-TSPC_AVCTP_2_4	False (*)	Message type field management (M)
-TSPC_AVCTP_2_5	False (*)	PID field management (M)
-TSPC_AVCTP_2_6	False (*)	IPID field mangement (M)
-TSPC_AVCTP_2_7	False (*)	Message information management (M)
+TSPC_AVCTP_2_2	True		Transaction label management (M)
+TSPC_AVCTP_2_3	True		Packet type field management (M)
+TSPC_AVCTP_2_4	True		Message type field management (M)
+TSPC_AVCTP_2_5	True		PID field management (M)
+TSPC_AVCTP_2_6	True		IPID field mangement (M)
+TSPC_AVCTP_2_7	True		Message information management (M)
 TSPC_AVCTP_2_8	False		Event registration for message reception (O)
 TSPC_AVCTP_2_9	False		Event registration for connection request (O)
 TSPC_AVCTP_2_10	False		Event registration for disconnection (O)
diff --git a/android/pixit-avctp.txt b/android/pixit-avctp.txt
index c5782fd..9f54bcf 100644
--- a/android/pixit-avctp.txt
+++ b/android/pixit-avctp.txt
@@ -5,6 +5,7 @@ PTS version: 5.0
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
 # - should be set to PTS's bin/audio folder
+^ - should be set accordingly
 
 		Required PIXIT settings
 -------------------------------------------------------------------------------
@@ -17,13 +18,13 @@ TSPX_avctp_tester_command_data
 TSPX_avctp_tester_response_data
 TSPX_avctp_iut_command_data
 TSPX_avctp_iut_response_data
-TSPX_bd_addr_iut		08606E414394 (&)
+TSPX_bd_addr_iut		112233445566 (*&)
 TSPX_pin_code			0000
 TSPX_delete_link_key		FALSE
 TSPX_security_enabled		FALSE
 TSPX_class_of_device		20050C
 TSPX_player_feature_bitmask	0000000000000007FFF00070000000000
-TSPX_avrcp_version
+TSPX_avrcp_version		1.5 (*^)
 TSPX_establish_avdtp_stream	TRUE
 TSPX_tester_av_role
 TSPX_time_guard			300000
-- 
1.8.5.3

