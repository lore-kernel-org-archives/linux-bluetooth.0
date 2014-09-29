Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 1/2] android/pts: Update PTS files for DID
Date: Mon, 29 Sep 2014 10:07:16 +0200
Message-Id: <1411978037-4561-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updated PICS, PIXITs and PTS tests results for DID.
PTS version 5.3. Android version 4.4.4
---
 android/pics-did.txt  | 2 +-
 android/pixit-did.txt | 2 +-
 android/pts-did.txt   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/pics-did.txt b/android/pics-did.txt
index f1441c8..b516aa8 100644
--- a/android/pics-did.txt
+++ b/android/pics-did.txt
@@ -1,6 +1,6 @@
 DID PICS for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-did.txt b/android/pixit-did.txt
index 60961da..99f411b 100644
--- a/android/pixit-did.txt
+++ b/android/pixit-did.txt
@@ -1,6 +1,6 @@
 DID PIXIT for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-did.txt b/android/pts-did.txt
index 99e0bc0..facfa5c 100644
--- a/android/pts-did.txt
+++ b/android/pts-did.txt
@@ -1,7 +1,7 @@
 PTS test results for DID
 
-PTS version: 5.2
-Tested: 09-July-2014
+PTS version: 5.3
+Tested: 26-September-2014
 Android version: 4.4.4
 
 Results:
-- 
1.8.5.3

