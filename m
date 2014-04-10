Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 1/2] android/pts: Bump PTS version for HSP
Date: Thu, 10 Apr 2014 11:02:32 +0200
Message-Id: <1397120553-23372-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Rechecking of PICS and PIXITs for HSP on PTS 5.1.
---
 android/pics-hsp.txt  | 2 +-
 android/pixit-hsp.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pics-hsp.txt b/android/pics-hsp.txt
index 34ad44a..3c4962c 100644
--- a/android/pics-hsp.txt
+++ b/android/pics-hsp.txt
@@ -1,6 +1,6 @@
 HSP PICS for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-hsp.txt b/android/pixit-hsp.txt
index ee106a7..2d5b14b 100644
--- a/android/pixit-hsp.txt
+++ b/android/pixit-hsp.txt
@@ -1,6 +1,6 @@
 HSP PIXIT for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
-- 
1.8.5.3

