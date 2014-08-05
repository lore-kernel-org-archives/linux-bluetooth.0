Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Tests round for OPP
Date: Tue,  5 Aug 2014 13:10:04 +0200
Message-Id: <1407237004-27005-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updating PICS and PIXITs for PTS 5.2. Regression round for OPP
against PTS 5.2. All previously raised erratas solved in PTS 5.2.
---
 android/pics-opp.txt  |  2 +-
 android/pixit-opp.txt |  2 +-
 android/pts-opp.txt   | 68 +++++++++++++++------------------------------------
 3 files changed, 22 insertions(+), 50 deletions(-)

diff --git a/android/pics-opp.txt b/android/pics-opp.txt
index 0a5919e..d01865b 100644
--- a/android/pics-opp.txt
+++ b/android/pics-opp.txt
@@ -1,6 +1,6 @@
 OPP PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-opp.txt b/android/pixit-opp.txt
index 7b0f4f2..6d7a76b 100644
--- a/android/pixit-opp.txt
+++ b/android/pixit-opp.txt
@@ -1,6 +1,6 @@
 OPP PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-opp.txt b/android/pts-opp.txt
index e1b0def..8bf89e2 100644
--- a/android/pts-opp.txt
+++ b/android/pts-opp.txt
@@ -1,8 +1,8 @@
 PTS test results for OPP
 
-PTS version: 5.1
-Tested: 17-April-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 05-August-2014
+Android version: 4.4.4
 
 Results:
 PASS	test passed
@@ -28,12 +28,10 @@ TC_CLIENT_BCP_BV_03_I   N/A
 TC_CLIENT_BCP_BV_04_I   N/A
 TC_CLIENT_BCP_BV_05_I   N/A
 TC_CLIENT_CON_BV_01_C	N/A
-TC_CLIENT_OPH_BI_01_C	PASS	PTS issue #12081
-				ETS-12081 required
-TC_CLIENT_OPH_BV_01_I	PASS	PTS issue #12081
-				ETS-12160 required
+TC_CLIENT_OPH_BI_01_C	PASS
+TC_CLIENT_OPH_BV_01_I	PASS
 TC_CLIENT_OPH_BV_02_I	N/A
-TC_CLIENT_OPH_BV_03_I	PASS	ETS-12081 required (bluetooth.org)
+TC_CLIENT_OPH_BV_03_I	PASS
 TC_CLIENT_OPH_BV_04_I	N/A
 TC_CLIENT_OPH_BV_05_I	PASS
 TC_CLIENT_OPH_BV_07_I	N/A
@@ -48,13 +46,10 @@ TC_CLIENT_OPH_BV_15_I	N/A
 TC_CLIENT_OPH_BV_16_I	N/A
 TC_CLIENT_OPH_BV_17_I	N/A
 TC_CLIENT_OPH_BV_18_I	N/A
-TC_CLIENT_OPH_BV_19_I	PASS	PTS issue #12081
-				ETS-12081 required
+TC_CLIENT_OPH_BV_19_I	PASS
 TC_CLIENT_OPH_BV_20_I	PASS
-TC_CLIENT_OPH_BV_22_I	PASS	PTS issue #12081
-				ETS-12081 required
-TC_CLIENT_OPH_BV_23_I	PASS	PTS issue #12081
-				ETS-12081 required
+TC_CLIENT_OPH_BV_22_I	PASS
+TC_CLIENT_OPH_BV_23_I	PASS
 TC_CLIENT_OPH_BV_24_I	N/A
 TC_CLIENT_OPH_BV_25_I	N/A
 TC_CLIENT_OPH_BV_26_I	N/A
@@ -76,54 +71,32 @@ TC_SERVER_BCE_BV_05_I	N/A
 TC_SERVER_BCE_BV_06_I	N/A
 TC_SERVER_BCE_BV_07_I	N/A
 TC_SERVER_BCP_BV_01_I	N/A
-TC_SERVER_BCP_BV_02_I	PASS	PTS issue #12081
-				ETS-12081 required
+TC_SERVER_BCP_BV_02_I	PASS
 TC_SERVER_BCP_BV_03_I	N/A
 TC_SERVER_BCP_BV_04_I	N/A
 TC_SERVER_BCP_BV_05_I	N/A
 TC_SERVER_CON_BV_02_C	N/A
 TC_SERVER_OPH_BV_01_I	PASS
 TC_SERVER_OPH_BV_02_I	PASS
-TC_SERVER_OPH_BV_03_I	PASS	PTS issue #12081
-				ETS-12081 required
-				IUT must be in the connectable mode. Tester must
-					accept incoming file
-TC_SERVER_OPH_BV_04_I	PASS	PTS issue #12081
-				ETS-12081 required
-				IUT must be in the connectable mode. Tester must
-					accept incoming file
-TC_SERVER_OPH_BV_05_I	PASS	PTS issue #12081
-				ETS-12081 required
-				IUT must be in the connectable mode. Tester must
-					reject incoming file
+TC_SERVER_OPH_BV_03_I	PASS
+TC_SERVER_OPH_BV_04_I	PASS
+TC_SERVER_OPH_BV_05_I	PASS
 TC_SERVER_OPH_BV_07_I	N/A
 TC_SERVER_OPH_BV_08_I	N/A
 TC_SERVER_OPH_BV_09_I	N/A
-TC_SERVER_OPH_BV_10_I	PASS	PTS issue #12081
-				ETS-12081 required
-				IUT must be in the connectable mode
+TC_SERVER_OPH_BV_10_I	PASS
 TC_SERVER_OPH_BV_11_I	N/A
 TC_SERVER_OPH_BV_12_I	N/A
 TC_SERVER_OPH_BV_13_I	N/A
-TC_SERVER_OPH_BV_14_I	PASS	PTS issue #12081
-				ETS-12081 required
-				IUT must be in the connectable mode
+TC_SERVER_OPH_BV_14_I	PASS
 TC_SERVER_OPH_BV_15_I	N/A
 TC_SERVER_OPH_BV_16_I	N/A
 TC_SERVER_OPH_BV_17_I	N/A
-TC_SERVER_OPH_BV_18_I	PASS	PTS issue #12081
-				ETS-12081 required
-				IUT must be in the connectable mode
-TC_SERVER_OPH_BV_19_I	PASS	PTS issue #12081
-				ETS-12081 required
-				IUT must be in the connectable mode
+TC_SERVER_OPH_BV_18_I	PASS
+TC_SERVER_OPH_BV_19_I	PASS
 TC_SERVER_OPH_BV_21_I	N/A
-TC_SERVER_OPH_BV_22_I	PASS	PTS issue #12081
-				ETS-12081 required
-				IUT must be in the connectable mode
-TC_SERVER_OPH_BV_23_I	PASS	PTS issue #12081
-				ETS-12081 required
-				IUT must be in the connectable mode
+TC_SERVER_OPH_BV_22_I	PASS
+TC_SERVER_OPH_BV_23_I	PASS
 TC_SERVER_OPH_BV_24_I	N/A
 TC_SERVER_OPH_BV_25_I	N/A
 TC_SERVER_OPH_BV_26_I	N/A
@@ -142,6 +115,5 @@ TC_SERVER_OPH_BV_30_I	N/A
 TC_SERVER_OPH_BV_31_I	N/A
 TC_SERVER_OPH_BV_32_I	N/A
 TC_SERVER_OPH_BV_33_I	N/A
-TC_SERVER_OPH_BV_34_I	PASS	PTS issue #12081
-				ETS-12081 required
+TC_SERVER_OPH_BV_34_I	PASS
 -------------------------------------------------------------------------------
-- 
1.8.5.3

