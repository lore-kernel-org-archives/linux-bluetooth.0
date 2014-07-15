Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Update PTS files for HSP
Date: Tue, 15 Jul 2014 16:20:56 +0200
Message-Id: <1405434056-17558-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Re-run PTS tests for HSP on PTS 5.2 and Android 4.4.4
---
 android/pics-hsp.txt  | 2 +-
 android/pixit-hsp.txt | 2 +-
 android/pts-hsp.txt   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/pics-hsp.txt b/android/pics-hsp.txt
index 3c4962c..330a197 100644
--- a/android/pics-hsp.txt
+++ b/android/pics-hsp.txt
@@ -1,6 +1,6 @@
 HSP PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-hsp.txt b/android/pixit-hsp.txt
index 2d5b14b..a097277 100644
--- a/android/pixit-hsp.txt
+++ b/android/pixit-hsp.txt
@@ -1,6 +1,6 @@
 HSP PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-hsp.txt b/android/pts-hsp.txt
index 7da71e8..0df9806 100644
--- a/android/pts-hsp.txt
+++ b/android/pts-hsp.txt
@@ -1,8 +1,8 @@
 PTS test results for HSP
 
-PTS version: 5.1
-Tested: 10-April-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 15-July-2014
+Android version: 4.4.4
 
 Results:
 PASS    test passed
-- 
1.8.5.3

