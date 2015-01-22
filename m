Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pts: Update DIS PTS 6.0 pixits, pics, results for android 5.0
Date: Thu, 22 Jan 2015 16:01:52 +0100
Message-Id: <1421938912-17448-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1421938912-17448-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1421938912-17448-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test pixits, pics, test case list with results for
DIS profile against android 5.0.
---
 android/pics-dis.txt  | 2 +-
 android/pixit-dis.txt | 3 ++-
 android/pts-dis.txt   | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/android/pics-dis.txt b/android/pics-dis.txt
index 169173d..ed207c8 100644
--- a/android/pics-dis.txt
+++ b/android/pics-dis.txt
@@ -1,6 +1,6 @@
 DIS PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 
diff --git a/android/pixit-dis.txt b/android/pixit-dis.txt
index 71729fe..13fe78f 100644
--- a/android/pixit-dis.txt
+++ b/android/pixit-dis.txt
@@ -1,6 +1,6 @@
 DIS PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -22,4 +22,5 @@ TSPX_delete_ltk						FALSE
 TSPX_security_enabled					TRUE (*)
 TSPX_iut_setup_att_over_br_edr				FALSE
 TSPX_tester_appearance					0000
+TSPX_iut_use_resolvable_random_address			FALSE
 -------------------------------------------------------------------------------
diff --git a/android/pts-dis.txt b/android/pts-dis.txt
index fb67687..857a149 100644
--- a/android/pts-dis.txt
+++ b/android/pts-dis.txt
@@ -1,7 +1,7 @@
 PTS test results for DIS
 
-PTS version: 5.3
-Tested: 26-November-2014
+PTS version: 6.0
+Tested: 22-January-2015
 Android version: 5.0
 
 Results:
-- 
1.9.3

