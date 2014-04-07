Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Re-test MAP against PTS 5.1
Date: Mon,  7 Apr 2014 17:53:54 +0200
Message-Id: <1396886034-31640-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-map.txt  | 2 +-
 android/pixit-map.txt | 7 ++++---
 android/pts-map.txt   | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/android/pics-map.txt b/android/pics-map.txt
index 2875885..1e0695f 100644
--- a/android/pics-map.txt
+++ b/android/pics-map.txt
@@ -1,6 +1,6 @@
 MAP PICS for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-map.txt b/android/pixit-map.txt
index 48419f0..ba687c1 100644
--- a/android/pixit-map.txt
+++ b/android/pixit-map.txt
@@ -1,10 +1,11 @@
 MAP PIXIT for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
 # - should be set to tester's phone number
+$ - should be set to IUT e-mail address
 
 		Required PIXIT settings
 -------------------------------------------------------------------------------
@@ -12,7 +13,7 @@ Parameter Name						Value
 -------------------------------------------------------------------------------
 TSPX_auth_password					0000
 TSPX_auth_user_id					PTS
-TSPX_bd_addr_iut					08606E414394 (*&)
+TSPX_bd_addr_iut					112233445566 (*&)
 TSPX_client_class_of_device				100204
 TSPX_delete_link_key					FALSE
 TSPX_get_object_name					put.gif
@@ -42,5 +43,5 @@ TSPX_MASInstanceID_Email				0
 TSPX_message_notification_l2cap_psm			1003
 TSPX_message_notification_rfcomm_channel		9
 TSPX_upload_msg_phonenumber				123456789 (#)
-TSPX_upload_msg_emailaddress				PTS_Test@bluetooth.com
+TSPX_upload_msg_emailaddress				IUT-email ($)
 -------------------------------------------------------------------------------
diff --git a/android/pts-map.txt b/android/pts-map.txt
index 856077d..b19a678 100644
--- a/android/pts-map.txt
+++ b/android/pts-map.txt
@@ -1,7 +1,7 @@
 PTS test results for MAP
 
-PTS version: 5.0
-Tested: 19-Feb-2014
+PTS version: 5.1
+Tested: 07-April-2014
 
 Results:
 PASS	test passed
-- 
1.8.5.3

