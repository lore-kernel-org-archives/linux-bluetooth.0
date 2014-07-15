Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Update PTS files for AVRCP
Date: Tue, 15 Jul 2014 14:51:44 +0200
Message-Id: <1405428704-10324-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Regression test round using PTS 5.2 and Android 4.4.4
---
 android/pics-avrcp.txt  | 2 +-
 android/pixit-avrcp.txt | 2 +-
 android/pts-avrcp.txt   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
index 969be6a..f339689 100644
--- a/android/pics-avrcp.txt
+++ b/android/pics-avrcp.txt
@@ -1,6 +1,6 @@
 AVRCP PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-avrcp.txt b/android/pixit-avrcp.txt
index ceae884..7ab5f18 100644
--- a/android/pixit-avrcp.txt
+++ b/android/pixit-avrcp.txt
@@ -1,6 +1,6 @@
 AVRCP PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
index b05bdbf..c8663be 100644
--- a/android/pts-avrcp.txt
+++ b/android/pts-avrcp.txt
@@ -1,8 +1,8 @@
 PTS test results for AVRCP
 
-PTS version: 5.1
-Tested: 07-April-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 15-July-2014
+Android version: 4.4.4
 
 Results:
 PASS	test passed
-- 
1.8.5.3

