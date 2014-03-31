Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Bump PTS version
Date: Mon, 31 Mar 2014 15:38:02 +0200
Message-Id: <1396273082-11250-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add proper PTS version for PICS and PIXIT.
---
 android/pics-l2cap.txt  | 2 +-
 android/pixit-l2cap.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pics-l2cap.txt b/android/pics-l2cap.txt
index 7b49627..096fbf4 100644
--- a/android/pics-l2cap.txt
+++ b/android/pics-l2cap.txt
@@ -1,6 +1,6 @@
 L2CAP PICS for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-l2cap.txt b/android/pixit-l2cap.txt
index 3ee8b44..914a995 100644
--- a/android/pixit-l2cap.txt
+++ b/android/pixit-l2cap.txt
@@ -1,6 +1,6 @@
 L2CAP PIXIT for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
-- 
1.8.5.3

