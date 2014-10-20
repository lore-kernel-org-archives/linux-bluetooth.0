Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pts: Update PICS, PIXIT and test results for MPS
Date: Mon, 20 Oct 2014 15:33:52 +0200
Message-Id: <1413812032-26631-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1413812032-26631-1-git-send-email-marcin.kraglak@tieto.com>
References: <1413812032-26631-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-mps.txt  | 2 +-
 android/pixit-mps.txt | 2 +-
 android/pts-mps.txt   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/pics-mps.txt b/android/pics-mps.txt
index 6fa9858..ab937a6 100644
--- a/android/pics-mps.txt
+++ b/android/pics-mps.txt
@@ -1,6 +1,6 @@
 MPS PICS for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-mps.txt b/android/pixit-mps.txt
index 088efe9..56f5122 100644
--- a/android/pixit-mps.txt
+++ b/android/pixit-mps.txt
@@ -1,6 +1,6 @@
 MPS PIXIT for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-mps.txt b/android/pts-mps.txt
index 2f661bb..46d2510 100644
--- a/android/pts-mps.txt
+++ b/android/pts-mps.txt
@@ -1,7 +1,7 @@
 PTS test results for MPS
 
-PTS version: 5.2
-Tested: 31.07.2014
+PTS version: 5.3
+Tested: 20.10.2014
 Android version: 4.4.4
 
 Results:
@@ -50,5 +50,5 @@ TC_SRC_TG_HFAV_CLH_MD_BV_04_I		PASS	Do not use AOSP Music player.
 						Use e.g. MortPlayer or Poweramp
 TC_SRC_TG_HFAV_CLH_MD_BV_05_I		PASS
 TC_SRC_TG_HFAV_CLH_MD_BV_06_I		PASS
-TC_PAIRING_HF_SNK_CT			PASS
+TC_PAIRING_HF_SNK_CT			N/A	Pairing helper for MD tests
 -------------------------------------------------------------------------------
-- 
1.9.3

