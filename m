Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Update PTS tests for DID
Date: Mon,  7 Apr 2014 08:33:55 +0200
Message-Id: <1396852435-10287-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

DID tests results on PTS 5.1.
---
 android/pics-did.txt  | 2 +-
 android/pixit-did.txt | 2 +-
 android/pts-did.txt   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/pics-did.txt b/android/pics-did.txt
index 58cee41..fe1c03a 100644
--- a/android/pics-did.txt
+++ b/android/pics-did.txt
@@ -1,6 +1,6 @@
 DID PICS for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-did.txt b/android/pixit-did.txt
index 8c64d52..c40f938 100644
--- a/android/pixit-did.txt
+++ b/android/pixit-did.txt
@@ -1,6 +1,6 @@
 DID PIXIT for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-did.txt b/android/pts-did.txt
index b9ad0c7..2a18d3e 100644
--- a/android/pts-did.txt
+++ b/android/pts-did.txt
@@ -1,7 +1,7 @@
 PTS test results for DID
 
-PTS version: 5.0
-Tested: 28-Jan-2014
+PTS version: 5.1
+Tested: 07-April-2014
 Android version: 4.4.2
 
 Results:
-- 
1.8.5.3

