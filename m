Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 2/2] android/pts: Update PTS files for A2DP
Date: Mon, 29 Sep 2014 10:07:17 +0200
Message-Id: <1411978037-4561-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1411978037-4561-1-git-send-email-sebastian.chlad@tieto.com>
References: <1411978037-4561-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updated PICS, PIXITs and PTS tests results for A2DP.
PTS version 5.3. Android version 4.4.4
---
 android/pics-a2dp.txt  | 2 +-
 android/pixit-a2dp.txt | 2 +-
 android/pts-a2dp.txt   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/pics-a2dp.txt b/android/pics-a2dp.txt
index 782132c..adac664 100644
--- a/android/pics-a2dp.txt
+++ b/android/pics-a2dp.txt
@@ -1,6 +1,6 @@
 A2DP PICS for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-a2dp.txt b/android/pixit-a2dp.txt
index b9984d3..3e26eac 100644
--- a/android/pixit-a2dp.txt
+++ b/android/pixit-a2dp.txt
@@ -1,6 +1,6 @@
 A2DP PIXIT for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
index 8d61839..c3d04b2 100644
--- a/android/pts-a2dp.txt
+++ b/android/pts-a2dp.txt
@@ -1,7 +1,7 @@
 PTS test results for A2DP
 
-PTS version: 5.2
-Tested: 02-September-2014
+PTS version: 5.3
+Tested: 26-September-2014
 Android version: 4.4.4
 
 Results:
-- 
1.8.5.3

