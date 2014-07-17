Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Update PTS files for MAP
Date: Thu, 17 Jul 2014 10:17:06 +0200
Message-Id: <1405585026-21486-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Regression tests for MAP on PTS 5.2 and Android 4.4.4.
---
 android/pics-map.txt  |  2 +-
 android/pixit-map.txt |  7 ++-----
 android/pts-map.txt   | 42 +++++++++++++++++++-----------------------
 3 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/android/pics-map.txt b/android/pics-map.txt
index 1e0695f..461c6ce 100644
--- a/android/pics-map.txt
+++ b/android/pics-map.txt
@@ -1,6 +1,6 @@
 MAP PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-map.txt b/android/pixit-map.txt
index ba687c1..45a374a 100644
--- a/android/pixit-map.txt
+++ b/android/pixit-map.txt
@@ -1,6 +1,6 @@
 MAP PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -36,12 +36,9 @@ TSPX_filter_recipient					PTS
 TSPX_filter_originator					PTS
 TSPX_default_message_upload_folder_in_msg		draft
 TSPX_default_test_folder_in_msg				inbox
-TSPX_use_fixed_MASInstanceID				FALSE
-TSPX_MASInstanceID_SMS					0
-TSPX_MASInstanceID_MMS					0
-TSPX_MASInstanceID_Email				0
 TSPX_message_notification_l2cap_psm			1003
 TSPX_message_notification_rfcomm_channel		9
 TSPX_upload_msg_phonenumber				123456789 (#)
 TSPX_upload_msg_emailaddress				IUT-email ($)
+TSPX_Automation						FALSE
 -------------------------------------------------------------------------------
diff --git a/android/pts-map.txt b/android/pts-map.txt
index b19a678..98ab9e1 100644
--- a/android/pts-map.txt
+++ b/android/pts-map.txt
@@ -1,7 +1,7 @@
 PTS test results for MAP
 
-PTS version: 5.1
-Tested: 07-April-2014
+PTS version: 5.2
+Tested: 16-July-2014
 
 Results:
 PASS	test passed
@@ -49,35 +49,31 @@ TC_MCE_SRMP_BV_01_I	N/A
 TC_MCE_SRMP_BV_04_I	N/A
 TC_MCE_SRMP_BV_05_I	N/A
 TC_MCE_SRMP_BV_06_I	N/A
-TC_MSE_MSM_BV_05_I	PASS	If prompted tester must accept obex request
-TC_MSE_MSM_BV_06_I	PASS	If prompted tester must accept obex request
-TC_MSE_MSM_BV_07_I	PASS	If prompted tester must accept obex request
-TC_MSE_MSM_BV_08_I	PASS	If prompted tester must accept obex request
+TC_MSE_MSM_BV_05_I	PASS
+TC_MSE_MSM_BV_06_I	PASS
+TC_MSE_MSM_BV_07_I	PASS
+TC_MSE_MSM_BV_08_I	PASS
 TC_MSE_MSM_BV_09_I	N/A
 TC_MSE_MSM_BV_10_I	N/A
 TC_MSE_MSM_BV_11_I	N/A
 TC_MSE_MSM_BV_12_I	N/A
-TC_MSE_MNR_BV_03_I	PASS	If prompted tester must accept obex request
-TC_MSE_MNR_BV_04_I	PASS	If prompted tester must accept obex request
-TC_MSE_MMB_BV_09_I	PASS	If prompted tester must accept obex request
-TC_MSE_MMB_BV_10_I	PASS	If prompted tester must accept obex request
-TC_MSE_MMB_BV_11_I	PASS	If prompted tester must accept obex request
-TC_MSE_MMB_BV_20_I	PASS	If prompted tester must accept obex request
+TC_MSE_MNR_BV_03_I	PASS
+TC_MSE_MNR_BV_04_I	PASS
+TC_MSE_MMB_BV_09_I	PASS
+TC_MSE_MMB_BV_10_I	PASS
+TC_MSE_MMB_BV_11_I	PASS
+TC_MSE_MMB_BV_20_I	PASS
 TC_MSE_MMB_BV_12_I	N/A
 TC_MSE_MMB_BV_18_I	N/A
-TC_MSE_MMB_BV_13_I	PASS	If prompted tester must accept obex request
-TC_MSE_MMB_BV_14_I	PASS	If prompted tester must accept obex request
-TC_MSE_MMB_BV_15_I	PASS	If prompted tester must accept obex request
+TC_MSE_MMB_BV_13_I	PASS
+TC_MSE_MMB_BV_14_I	PASS
+TC_MSE_MMB_BV_15_I	PASS
 TC_MSE_MMB_BV_16_I	PASS	Android MAP server bug, fix provided at
 				android-review.googlesource.com/#/c/82757
-TC_MSE_MMD_BV_02_I	PASS	If prompted tester must accept obex request
-TC_MSE_MMU_BV_02_I	PASS	If prompted tester must accept obex request,
-				at least one SMS must be present in inbox
-TC_MSE_MMU_BV_03_I	PASS	If prompted tester must accept obex request,
-				when asked by PTS tester must verify that SMS
-				was successfully delivered onto network
-TC_MSE_MMN_BV_02_I	PASS	If prompted tester must accept obex request,
-				when asked by PTS tester must send SMS to IUT
+TC_MSE_MMD_BV_02_I	PASS
+TC_MSE_MMU_BV_02_I	PASS	At least one SMS must be present in inbox
+TC_MSE_MMU_BV_03_I	PASS
+TC_MSE_MMN_BV_02_I	PASS
 TC_MSE_MMN_BV_04_I	N/A
 TC_MSE_MMI_BV_02_I	N/A
 TC_MSE_MFB_BV_02_I	N/A
-- 
1.8.5.3

