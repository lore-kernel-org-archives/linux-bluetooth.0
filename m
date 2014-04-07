Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 1/2] android/pts: Bump PICS and PIXIT for AVRCP
Date: Mon,  7 Apr 2014 12:15:26 +0200
Message-Id: <1396865727-27607-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bumping version of PTS for AVRCP profile.
---
 android/pics-avrcp.txt  | 2 +-
 android/pixit-avrcp.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
index bee22c8..969be6a 100644
--- a/android/pics-avrcp.txt
+++ b/android/pics-avrcp.txt
@@ -1,6 +1,6 @@
 AVRCP PICS for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-avrcp.txt b/android/pixit-avrcp.txt
index 9b278ad..ceae884 100644
--- a/android/pixit-avrcp.txt
+++ b/android/pixit-avrcp.txt
@@ -1,6 +1,6 @@
 AVRCP PIXIT for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
-- 
1.8.5.3

