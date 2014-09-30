Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH] android/pts: Update HID PICS and PIXIT for PTS 5.3
Date: Tue, 30 Sep 2014 14:17:13 +0300
Message-Id: <1412075833-9696-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-hid.txt  | 2 +-
 android/pixit-hid.txt | 2 +-
 android/pts-hid.txt   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/pics-hid.txt b/android/pics-hid.txt
index 3ed4e73..aa03878 100644
--- a/android/pics-hid.txt
+++ b/android/pics-hid.txt
@@ -1,6 +1,6 @@
 HID PICS for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-hid.txt b/android/pixit-hid.txt
index 3c54abf..42a3310 100644
--- a/android/pixit-hid.txt
+++ b/android/pixit-hid.txt
@@ -1,6 +1,6 @@
 HID PIXIT for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-hid.txt b/android/pts-hid.txt
index f42f225..817fc7f 100644
--- a/android/pts-hid.txt
+++ b/android/pts-hid.txt
@@ -1,7 +1,7 @@
 PTS test results for HID
 
-PTS version: 5.2
-Tested: 18-July-2014
+PTS version: 5.3
+Tested: 30-September-2014
 Android version: 4.4.4
 
 Results:
-- 
1.9.1

