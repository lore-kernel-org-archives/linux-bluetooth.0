Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update OPP test results
Date: Wed, 20 May 2015 11:57:23 +0200
Message-Id: <1432115843-30962-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pixit-opp.txt |  2 +-
 android/pts-opp.txt   | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/pixit-opp.txt b/android/pixit-opp.txt
index 385cc1f..f6651a1 100644
--- a/android/pixit-opp.txt
+++ b/android/pixit-opp.txt
@@ -1,6 +1,6 @@
 OPP PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-opp.txt b/android/pts-opp.txt
index 3f22a33..8496700 100644
--- a/android/pts-opp.txt
+++ b/android/pts-opp.txt
@@ -1,8 +1,8 @@
 PTS test results for OPP
 
-PTS version: 6.0
-Tested: 30-January-2015
-Android version: 5.0
+PTS version: 6.1
+Tested: 20-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
@@ -46,10 +46,10 @@ TC_CLIENT_OPH_BV_15_I	N/A
 TC_CLIENT_OPH_BV_16_I	N/A
 TC_CLIENT_OPH_BV_17_I	N/A
 TC_CLIENT_OPH_BV_18_I	N/A
-TC_CLIENT_OPH_BV_19_I	PASS
+TC_CLIENT_OPH_BV_19_I	PASS	Send file other than vCard
 TC_CLIENT_OPH_BV_20_I	PASS
-TC_CLIENT_OPH_BV_22_I	PASS
-TC_CLIENT_OPH_BV_23_I	PASS
+TC_CLIENT_OPH_BV_22_I	PASS	Send file greater than 2 MB
+TC_CLIENT_OPH_BV_23_I	PASS	Send two vCards in a single operation
 TC_CLIENT_OPH_BV_24_I	N/A
 TC_CLIENT_OPH_BV_25_I	N/A
 TC_CLIENT_OPH_BV_26_I	N/A
-- 
1.9.1

