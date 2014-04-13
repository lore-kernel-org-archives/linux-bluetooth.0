Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Bump PTS version for GATT
Date: Sun, 13 Apr 2014 17:08:22 +0200
Message-Id: <1397401702-5762-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-gatt.txt  | 2 +-
 android/pixit-gatt.txt | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pics-gatt.txt b/android/pics-gatt.txt
index 8abf8c2..f3e8199 100644
--- a/android/pics-gatt.txt
+++ b/android/pics-gatt.txt
@@ -1,6 +1,6 @@
 GATT PICS for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 
diff --git a/android/pixit-gatt.txt b/android/pixit-gatt.txt
index 7bb8a28..c073452 100644
--- a/android/pixit-gatt.txt
+++ b/android/pixit-gatt.txt
@@ -1,6 +1,6 @@
 GATT PIXIT for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -26,6 +26,6 @@ TSPX_mtu_size						23
 TSPX_pin_code						0000
 TSPX_use_dynamic_pin					FALSE
 TSPX_delete_ltk						FALSE
-TSPX_characteristic_readable
+TSPX_characteristic_readable				FALSE
 TSPX_tester_appearance					0000
 -------------------------------------------------------------------------------
-- 
1.8.5.3

