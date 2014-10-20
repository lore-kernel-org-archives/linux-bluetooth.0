Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Update PTS files for HOGP
Date: Mon, 20 Oct 2014 15:52:06 +0200
Message-Id: <1413813126-746-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PICS and PIXITs updated to PTS 5.3. Regression done for Android
4.4.4.
---
 android/pics-hogp.txt  |  2 +-
 android/pixit-hogp.txt |  2 +-
 android/pts-hogp.txt   | 14 ++++++++------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/android/pics-hogp.txt b/android/pics-hogp.txt
index d7192bf..61cf56a 100644
--- a/android/pics-hogp.txt
+++ b/android/pics-hogp.txt
@@ -1,6 +1,6 @@
 HOGP PICS for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-hogp.txt b/android/pixit-hogp.txt
index 067c280..d32fe69 100644
--- a/android/pixit-hogp.txt
+++ b/android/pixit-hogp.txt
@@ -1,6 +1,6 @@
 HOGP PIXIT for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-hogp.txt b/android/pts-hogp.txt
index 19292d1..d874c9c 100644
--- a/android/pts-hogp.txt
+++ b/android/pts-hogp.txt
@@ -1,7 +1,7 @@
 PTS test results for HoG
 
-PTS version: 5.2
-Tested: 22-July-2014
+PTS version: 5.3
+Tested: 20-October-2014
 Android version: 4.4.4
 
 Results:
@@ -54,19 +54,21 @@ TC_HGRF_BH_BV_15_I	N/A
 TC_HGRF_BH_BV_16_I	N/A
 TC_HGRF_BH_BV_17_I	N/A
 TC_HGRF_HH_BV_18_I	N/A
-TC_HGWF_RH_BV_01_I	PASS	haltest: hidhost connect <addr>
+				Note: JIRA bug #BA-175 affecting TC_HGWF_RH
+				section
+TC_HGWF_RH_BV_01_I	INC	haltest: hidhost connect <addr>
 				hidhost set_report <addr> BTHH_INPUT_REPORT
 					AAB3F8A6CD
 				hidhost disconnect <addr>
-TC_HGWF_RH_BV_02_I	PASS	haltest: hidhost connect <addr>
+TC_HGWF_RH_BV_02_I	INC	haltest: hidhost connect <addr>
 				hidhost set_report <addr> BTHH_OUTPUT_REPORT
 					EF907856341200
 				hidhost disconnect <addr>
-TC_HGWF_RH_BV_03_I	PASS	haltest: hidhost connect <addr>
+TC_HGWF_RH_BV_03_I	INC	haltest: hidhost connect <addr>
 				hidhost set_report <addr> BTHH_OUTPUT_REPORT
 					EF907856341200
 				hidhost disconnect <addr>
-TC_HGWF_RH_BV_04_I	PASS	haltest: hidhost connect <addr>
+TC_HGWF_RH_BV_04_I	INC	haltest: hidhost connect <addr>
 				hidhost set_report <addr> BTHH_FEATURE_REPORT
 					EA453F2D87
 				hidhost disconnect <addr>
-- 
1.8.5.3

