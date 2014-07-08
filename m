Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: PTS updates for A2DP
Date: Tue,  8 Jul 2014 12:56:10 +0200
Message-Id: <1404816970-27996-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PICS and PIXITs files checked against PTS 5.2.
---
 android/pics-a2dp.txt  | 2 +-
 android/pixit-a2dp.txt | 2 +-
 android/pts-a2dp.txt   | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/android/pics-a2dp.txt b/android/pics-a2dp.txt
index 53b3c1c..782132c 100644
--- a/android/pics-a2dp.txt
+++ b/android/pics-a2dp.txt
@@ -1,6 +1,6 @@
 A2DP PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-a2dp.txt b/android/pixit-a2dp.txt
index 807ce3b..b9984d3 100644
--- a/android/pixit-a2dp.txt
+++ b/android/pixit-a2dp.txt
@@ -1,6 +1,6 @@
 A2DP PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
index 5780db1..7b9119c 100644
--- a/android/pts-a2dp.txt
+++ b/android/pts-a2dp.txt
@@ -1,8 +1,8 @@
 PTS test results for A2DP
 
-PTS version: 5.1
-Tested: 06-June-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 08-July-2014
+Android version: 4.4.4
 
 Results:
 PASS	test passed
@@ -16,7 +16,8 @@ Test Name		Result	Notes
 -------------------------------------------------------------------------------
 TC_SRC_CC_BV_09_I	PASS	Start streaming
 TC_SRC_CC_BV_10_I	N/A
-TC_SRC_REL_BV_01_I	PASS	Connect to PTS from IUT. When requested
+TC_SRC_REL_BV_01_I	INC	JIRA: BA-2
+				Connect to PTS from IUT. When requested
 				disconnect from IUT
 TC_SRC_REL_BV_02_I	PASS
 TC_SRC_SET_BV_01_I	PASS	Connect to PTS (open a2dp)
-- 
1.8.5.3

