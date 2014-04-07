Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 1/2] android/pts: Update PICS and PIXITs for AVCTP
Date: Mon,  7 Apr 2014 16:45:55 +0200
Message-Id: <1396881956-26016-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bumping version of PTS to 5.1 as well as adding the CT role. Since
both roles are enabled for AVRCP, AVCTP should follow the suit.
---
 android/pics-avctp.txt  | 16 ++++++++--------
 android/pixit-avctp.txt |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/android/pics-avctp.txt b/android/pics-avctp.txt
index 41ad4db..3490db5 100644
--- a/android/pics-avctp.txt
+++ b/android/pics-avctp.txt
@@ -1,6 +1,6 @@
 AVCTP PICS for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
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
index c5782fd..a9b3f4f 100644
--- a/android/pixit-avctp.txt
+++ b/android/pixit-avctp.txt
@@ -1,6 +1,6 @@
 AVCTP PIXIT for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -17,7 +17,7 @@ TSPX_avctp_tester_command_data
 TSPX_avctp_tester_response_data
 TSPX_avctp_iut_command_data
 TSPX_avctp_iut_response_data
-TSPX_bd_addr_iut		08606E414394 (&)
+TSPX_bd_addr_iut		11223344556677 (*&)
 TSPX_pin_code			0000
 TSPX_delete_link_key		FALSE
 TSPX_security_enabled		FALSE
-- 
1.8.5.3

