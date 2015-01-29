Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update SPP PTS 6.0 results for android 5.0
Date: Thu, 29 Jan 2015 10:58:19 +0100
Message-Id: <1422525499-4483-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test case list, pixits, pics and results for SPP
profile against android 5.0
---
 android/pics-spp.txt  |  2 +-
 android/pixit-spp.txt |  2 +-
 android/pts-spp.txt   | 15 ++++++++-------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/android/pics-spp.txt b/android/pics-spp.txt
index f015236..d9bb883 100644
--- a/android/pics-spp.txt
+++ b/android/pics-spp.txt
@@ -1,6 +1,6 @@
 SPP PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-spp.txt b/android/pixit-spp.txt
index a8a8202..8e2d70f 100644
--- a/android/pixit-spp.txt
+++ b/android/pixit-spp.txt
@@ -1,6 +1,6 @@
 SPP PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-spp.txt b/android/pts-spp.txt
index ea4e26c..6972020 100644
--- a/android/pts-spp.txt
+++ b/android/pts-spp.txt
@@ -1,7 +1,7 @@
 PTS test results for SPP
 
-PTS version: 5.3
-Tested: 12-November-2014
+PTS version: 6.0
+Tested: 29-January-2015
 Android version: 5.0
 
 Results:
@@ -13,11 +13,12 @@ N/A	test is disabled due to PICS setup
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_DevA_APP_BV_01_C	PASS	rctest -n -P <channel> <bdaddr>
-				Note: IUT should sdp query PTS in order to
-				check given channel for COM5
-TC_DevB_APP_BV_02_C	PASS	haltest: socket listen BTSOCK_RFCOMM
-				<srvc_name> <uuid>
+TC_DevA_APP_BV_01_C	PASS	sdptool browse <bdaddr> - check RFCOMM channel
+				rctest -n -P <channel> <bdaddr>
+TC_DevB_APP_BV_02_C	PASS	haltest: socket listen BTSOCK_RFCOMM SerialPort
+					00001101
+				Note: IUT must be in connectable, discoverable
+					mode.
 TC_APP_BV_03_C		N/A	Missing in PTS
 				PTS issue #12388
 				Note: tests BV_03 : BV_6 currently not supported
-- 
1.9.3

