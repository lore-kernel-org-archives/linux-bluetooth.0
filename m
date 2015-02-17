Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/pts: Update PAN pics, pixits for PTS 6.0
Date: Tue, 17 Feb 2015 13:29:13 +0100
Message-Id: <1424176154-4285-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates pics and pixits for PTS 6.0.
---
 android/pics-pan.txt  |  5 ++++-
 android/pixit-pan.txt | 13 +++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/android/pics-pan.txt b/android/pics-pan.txt
index 7c4939a..73461f5 100644
--- a/android/pics-pan.txt
+++ b/android/pics-pan.txt
@@ -1,6 +1,6 @@
 PAN PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -18,6 +18,9 @@ TSPC_PAN_1_3	True (*)	Role: PAN User (O.1)
 TSPC_PAN_1a_1	True		BNEP: BNEP Connection Setup (M)
 TSPC_PAN_1a_2	True		BNEP: BNEP Data Packet Reception (M)
 TSPC_PAN_1a_3	True		BNEP: BNEP Data Packet Transmission (M)
+TSPC_PAN_1a_3a	True		BNEP: BNEP Compressed Packet Transmission (O)
+TSPC_PAN_1a_3b	True		BNEP: BNEP Compressed Packet Transmission
+								Source Only (O)
 TSPC_PAN_1a_4	True		BNEP: BNEP Control Message Processing (M)
 TSPC_PAN_1a_5	True		BNEP: BNEP Extension Header Processing (M)
 TSPC_PAN_1a_6	False		BNEP: Network Protocol Filter Message
diff --git a/android/pixit-pan.txt b/android/pixit-pan.txt
index 680abb2..6c00d27 100644
--- a/android/pixit-pan.txt
+++ b/android/pixit-pan.txt
@@ -1,9 +1,9 @@
 PAN PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
-& - should be set to IUT or PTS Bluetooth address respectively
+& - should be set to IUT or PTS Bluetooth/MAC address respectively
 
 		Required PIXIT settings
 -------------------------------------------------------------------------------
@@ -27,4 +27,13 @@ TSPX_checksum						E851
 TSPX_secure_simple_pairing_pass_key_confirmation	False
 TSPX_iut_friendly_bt_name				gprs-pc
 TSPX_PTS_role_when_iut_is_PANU				default
+TSPX_auth_password					0000
+TSPX_auth_user_id					PTS
+TSPX_l2cap_psm						000F
+TSPX_rfcomm_channel					8
+TSPX_no_confirmations					FALSE
+TSPX_UUID_dest_address					0000
+TSPX_UUID_source_address				0000
+TSPX_MAC_dest_address					112233445566 (*&)
+TSPX_MAC_source_address					112233445566 (*&)
 -------------------------------------------------------------------------------
-- 
1.9.3

