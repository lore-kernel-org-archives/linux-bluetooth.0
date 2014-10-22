Return-Path: <cyrus@holtmann.org>
From: Ruslan Mstoi <ruslan.mstoi@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ruslan Mstoi <ruslan.mstoi@linux.intel.com>
Subject: [PATCH] android/pts: Updated AVCTP PICS and PIXITs for PTS 5.3
Date: Wed, 22 Oct 2014 10:11:00 +0300
Message-Id: <1413961860-11390-1-git-send-email-ruslan.mstoi@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-avctp.txt  | 2 +-
 android/pixit-avctp.txt | 6 +++---
 android/pts-avctp.txt   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/pics-avctp.txt b/android/pics-avctp.txt
index 5900d00..0afa33c 100644
--- a/android/pics-avctp.txt
+++ b/android/pics-avctp.txt
@@ -1,6 +1,6 @@
 AVCTP PICS for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-avctp.txt b/android/pixit-avctp.txt
index 3c6a864..06a0798 100644
--- a/android/pixit-avctp.txt
+++ b/android/pixit-avctp.txt
@@ -1,6 +1,6 @@
 AVCTP PIXIT for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -12,7 +12,7 @@ Parameter Name			Value
 -------------------------------------------------------------------------------
 TSPX_avctp_psm			0017
 TSPX_avctp_profile_id		110E
-TSPX_connect_avdtp		FALSE (*)
+TSPX_connect_avdtp		TRUE
 TSPX_avctp_tester_command_data
 TSPX_avctp_tester_response_data
 TSPX_avctp_iut_command_data
@@ -25,7 +25,7 @@ TSPX_class_of_device		20050C
 TSPX_player_feature_bitmask	0000000000000007FFF00070000000000
 TSPX_avrcp_version
 TSPX_establish_avdtp_stream	TRUE
-TSPX_tester_av_role
+TSPX_tester_av_role		SNK
 TSPX_time_guard			300000
 TSPX_avrcp_only			FALSE
 TSPX_use_implicit_send		TRUE
diff --git a/android/pts-avctp.txt b/android/pts-avctp.txt
index a461ee9..fd22ee1 100644
--- a/android/pts-avctp.txt
+++ b/android/pts-avctp.txt
@@ -1,7 +1,7 @@
 PTS test results for AVCTP
 
-PTS version: 5.2
-Tested: 10-July-2014
+PTS version: 5.3
+Tested: 22-October-2014
 Android version: 4.4.4
 
 Results:
-- 
1.9.1

