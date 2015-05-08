Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pts: Update HDP pixits, pics, and test results for PTS 6.1
Date: Fri,  8 May 2015 15:31:53 +0200
Message-Id: <1431091913-21208-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1431091913-21208-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1431091913-21208-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test pixits, pics, and results for HDP profile
against android 5.1.
---
 android/pics-hdp.txt  | 2 +-
 android/pixit-hdp.txt | 2 +-
 android/pts-hdp.txt   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/pics-hdp.txt b/android/pics-hdp.txt
index 2f29320..a613c97 100644
--- a/android/pics-hdp.txt
+++ b/android/pics-hdp.txt
@@ -1,6 +1,6 @@
 HDP PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-hdp.txt b/android/pixit-hdp.txt
index ccf0cf3..ca9b8a8 100644
--- a/android/pixit-hdp.txt
+++ b/android/pixit-hdp.txt
@@ -1,6 +1,6 @@
 HDP PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
index f6bf5cc..cbe1b3a 100644
--- a/android/pts-hdp.txt
+++ b/android/pts-hdp.txt
@@ -1,8 +1,8 @@
 PTS test results for HDP
 
-PTS version: 6.0
-Tested: 16-February-2015
-Android version: 5.0
+PTS version: 6.1
+Tested: 08-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
-- 
2.1.0

