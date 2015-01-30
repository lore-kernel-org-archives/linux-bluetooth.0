Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update HID PTS 6.0 pixits, pics, results for android 5.0
Date: Fri, 30 Jan 2015 16:45:39 +0100
Message-Id: <1422632739-10844-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test pixits, pics, test results for HID profile
against android 5.0
---
 android/pics-hid.txt  |  2 +-
 android/pixit-hid.txt |  3 ++-
 android/pts-hid.txt   | 22 ++++++++++------------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/android/pics-hid.txt b/android/pics-hid.txt
index aa03878..ffd0aff 100644
--- a/android/pics-hid.txt
+++ b/android/pics-hid.txt
@@ -1,6 +1,6 @@
 HID PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-hid.txt b/android/pixit-hid.txt
index 42a3310..3c93fca 100644
--- a/android/pixit-hid.txt
+++ b/android/pixit-hid.txt
@@ -1,6 +1,6 @@
 HID PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -27,4 +27,5 @@ TSPX_no_fail_verdicts					False
 TSPX_time_reconnect					30000
 TSPX_secure_simple_pairing_pass_key_confirmation	False
 TSPX_hid_report_id					1
+TSPX_hid_report_data					ff00 (*)
 -------------------------------------------------------------------------------
diff --git a/android/pts-hid.txt b/android/pts-hid.txt
index 62a79e1..7918650 100644
--- a/android/pts-hid.txt
+++ b/android/pts-hid.txt
@@ -1,7 +1,7 @@
 PTS test results for HID
 
-PTS version: 5.3
-Tested: 26-November-2014
+PTS version: 6.0
+Tested: 30-January-2015
 Android version: 5.0
 
 Results:
@@ -22,11 +22,10 @@ TC_HOS_HCR_BV_02_I	PASS
 TC_HOS_HCR_BV_03_I	N/A
 TC_HOS_HCR_BV_04_I	N/A
 TC_HOS_HDT_BV_01_I	PASS
-TC_HOS_HDT_BV_02_I	PASS	from shell execute:
-				haltest
-				bluetooth enable
-				hidhost connect <PTS bdaddr>
-				hidhost send_data <PTS bdaddr> ff00
+TC_HOS_HDT_BV_02_I	PASS	haltest: hidhost connect <addr>
+				hidhost send_data <addr> ff00
+				NOTE: PTS displays wrong report data on popup
+					PTS issue #13021
 TC_HOS_HDT_BV_03_I	N/A
 TC_HOS_HDT_BV_04_I	N/A
 TC_HOS_HID_BV_01_C	N/A
@@ -38,11 +37,10 @@ TC_HOS_HID_BV_06_C	N/A
 TC_HOS_HID_BV_08_C	N/A
 TC_HOS_HID_BV_09_C	N/A
 TC_HOS_HID_BV_10_C	N/A
-TC_HOS_DAT_BV_01_C	PASS	from shell execute:
-				haltest
-				bluetooth enable
-				hidhost connect <PTS bdaddr>
-				hidhost send_data <PTS bdaddr> ff00
+TC_HOS_DAT_BV_01_C	PASS	haltest: hidhost connect <addr>
+				hidhost send_data <addr> ff00
+				NOTE: PTS displays wrong report data on popup
+					PTS issue #13021
 TC_HOS_DAT_BV_02_C	N/A
 TC_HOS_DAT_BI_01_C	N/A
 TC_HOS_DAT_BI_02_C	N/A
-- 
1.9.3

