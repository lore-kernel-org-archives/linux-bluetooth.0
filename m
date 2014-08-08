Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: PTS files for MCAP
Date: Fri,  8 Aug 2014 13:58:20 +0200
Message-Id: <1407499100-12028-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update for PIXIT and PICS for MCAP on PTS 5.2 as well as regression
test round on Android 4.4.4 against PTS 5.2
---
 android/pics-mcap.txt  | 2 +-
 android/pixit-mcap.txt | 2 +-
 android/pts-mcap.txt   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/pics-mcap.txt b/android/pics-mcap.txt
index 3b1086a..adc97d7 100644
--- a/android/pics-mcap.txt
+++ b/android/pics-mcap.txt
@@ -1,6 +1,6 @@
 MCAP PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-mcap.txt b/android/pixit-mcap.txt
index 81cc6dc..fb6f456 100644
--- a/android/pixit-mcap.txt
+++ b/android/pixit-mcap.txt
@@ -1,6 +1,6 @@
 MCAP PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-mcap.txt b/android/pts-mcap.txt
index 55b51d7..c35fefb 100644
--- a/android/pts-mcap.txt
+++ b/android/pts-mcap.txt
@@ -1,8 +1,8 @@
 PTS test results for MCAP
 
-PTS version: 5.1
-Tested: 27-June-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 07-August-2014
+Android version: 4.4.4
 
 Results:
 PASS	test passed
@@ -37,7 +37,7 @@ TC_MCAP_CM_REC_BV_02_C	PASS	mcaptest -C 4099 -D 4101
 TC_MCAP_CM_REC_BV_03_C	N/A
 TC_MCAP_CM_REC_BV_04_C	PASS	mcaptest -C 4099 -D 4101
 				Note: It may be necessary to confirm pairing
-					twice (second time when UIT is back in
+					twice (second time when IUT is back in
 					range).
 TC_MCAP_CM_REC_BV_05_C	N/A
 TC_MCAP_CM_REC_BV_06_C	PASS	mcaptest -C 4099 -D 4101
-- 
1.8.5.3

