Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/pts: Update PTS pics, pixit for MCAP
Date: Thu, 30 Oct 2014 13:44:45 +0100
Message-Id: <1414673086-4076-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PICS and PIXIT checked against PTS 5.3. Regression round on PTS 5.3
against androi 4.4.4.
---
 android/pics-mcap.txt  | 4 ++--
 android/pixit-mcap.txt | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/pics-mcap.txt b/android/pics-mcap.txt
index adc97d7..dd71ab4 100644
--- a/android/pics-mcap.txt
+++ b/android/pics-mcap.txt
@@ -1,6 +1,6 @@
 MCAP PICS for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -13,7 +13,7 @@ O - optional
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_MCAP_1_A_1	True (*)	Supports Standard Op Codes (C.1)
-TSPC_MCAP_1_A_2	False		Supports Clock Synchronization Protocol (C.1)
+TSPC_MCAP_1_A_2	True (*)	Supports Clock Synchronization Protocol (C.1)
 -------------------------------------------------------------------------------
 C.1: Support for at least one of the defined protocols is Mandatory.
 -------------------------------------------------------------------------------
diff --git a/android/pixit-mcap.txt b/android/pixit-mcap.txt
index fb6f456..d05a953 100644
--- a/android/pixit-mcap.txt
+++ b/android/pixit-mcap.txt
@@ -1,6 +1,6 @@
 MCAP PIXIT for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -19,7 +19,7 @@ TSPX_MCAP_l2cap_psm_data_B
 TSPX_MCAP_bluetooth_clock_access_resolution		55
 TSPX_MCAP_create_mdl_configuration
 TSPX_MCAP_data_channel_setup_mode
-TSPX_MCAP_iut_initiate_connection			TRUE (*)
+TSPX_MCAP_iut_initiate_connection			FALSE
 TSPX_MCAP_mdep_id					12
 TSPX_MCAP_profile_name
 TSPX_MCAP_sync_lead_time				0BB8
-- 
1.9.3

