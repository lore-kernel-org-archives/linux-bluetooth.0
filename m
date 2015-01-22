Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update DID PTS 6.0 pixits, pics, results for android 5.0
Date: Thu, 22 Jan 2015 11:40:25 +0100
Message-Id: <1421923225-25912-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test pixits, pics and case list and results for
DID profile against android 5.0.
---
 android/pics-did.txt  | 2 +-
 android/pixit-did.txt | 2 +-
 android/pts-did.txt   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/pics-did.txt b/android/pics-did.txt
index b516aa8..da2e090 100644
--- a/android/pics-did.txt
+++ b/android/pics-did.txt
@@ -1,6 +1,6 @@
 DID PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-did.txt b/android/pixit-did.txt
index 99f411b..295febc 100644
--- a/android/pixit-did.txt
+++ b/android/pixit-did.txt
@@ -1,6 +1,6 @@
 DID PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-did.txt b/android/pts-did.txt
index fedf779..8fd434d 100644
--- a/android/pts-did.txt
+++ b/android/pts-did.txt
@@ -1,7 +1,7 @@
 PTS test results for DID
 
-PTS version: 5.3
-Tested: 07-November-2014
+PTS version: 6.0
+Tested: 22-January-2015
 Android version: 5.0
 
 Results:
-- 
1.9.3

