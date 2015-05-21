Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update IOPT test results
Date: Thu, 21 May 2015 18:10:25 +0200
Message-Id: <1432224625-20977-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-iopt.txt  | 2 +-
 android/pixit-iopt.txt | 2 +-
 android/pts-iopt.txt   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/pics-iopt.txt b/android/pics-iopt.txt
index 4d07d70..7277c4c 100644
--- a/android/pics-iopt.txt
+++ b/android/pics-iopt.txt
@@ -1,6 +1,6 @@
 IOPT PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-iopt.txt b/android/pixit-iopt.txt
index 4cc6fd4..181a91d 100644
--- a/android/pixit-iopt.txt
+++ b/android/pixit-iopt.txt
@@ -1,6 +1,6 @@
 IOPT PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-iopt.txt b/android/pts-iopt.txt
index 7b776a9..ef916b8 100644
--- a/android/pts-iopt.txt
+++ b/android/pts-iopt.txt
@@ -1,8 +1,8 @@
 PTS test results for IOPT
 
-PTS version: 6.0
-Tested: 03-February-2015
-Android version: 5.0
+PTS version: 6.1
+Tested: 21-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
@@ -14,7 +14,7 @@ N/A	test is disabled due to PICS setup
 Test Name	Result	Notes
 -------------------------------------------------------------------------------
 TC_COD_BV_01_I	PASS	IUT must be discoverable
-TC_COD_BV_02_I	N/A
+TC_COD_BV_02_I	INC	PTS issue#13473
 TC_SDSS_BV_02_I	PASS	Note: HDP sink record should be registered before test
 				run, e.g. register health app via HDPSample.apk
 TC_SDAS_BV_03_I	PASS	Note: HDP sink record should be registered before test
-- 
1.9.1

