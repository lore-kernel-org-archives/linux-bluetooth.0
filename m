Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: PTS files update for PBAP
Date: Tue,  5 Aug 2014 11:32:48 +0200
Message-Id: <1407231168-19714-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test round for PBAP against PTS 5.2 as well as PICS and PIXIT
checked against PTS 5.2.
---
 android/pics-pbap.txt  |  2 +-
 android/pixit-pbap.txt |  3 ++-
 android/pts-pbap.txt   | 10 ++++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/android/pics-pbap.txt b/android/pics-pbap.txt
index 3673a79..bcb71b6 100644
--- a/android/pics-pbap.txt
+++ b/android/pics-pbap.txt
@@ -1,6 +1,6 @@
 PBAP PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-pbap.txt b/android/pixit-pbap.txt
index fc89e15..7bc374b 100644
--- a/android/pixit-pbap.txt
+++ b/android/pixit-pbap.txt
@@ -1,6 +1,6 @@
 PBAP PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -32,4 +32,5 @@ TSPX_rfcomm_channel					2
 TSPX_obex_auth_password					0000
 TSPX_no_confirmations					False
 TSPX_PSE_vCardSelector					0000000000000001
+TSPX_Automation						False
 -------------------------------------------------------------------------------
diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
index ac6797f..4f8b534 100644
--- a/android/pts-pbap.txt
+++ b/android/pts-pbap.txt
@@ -1,8 +1,8 @@
 PTS test results for PBAP
 
-PTS version: 5.1
-Tested: 08-April-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 04-August-2014
+Android version: 4.4.4
 
 Results:
 PASS	test passed
@@ -126,12 +126,14 @@ TC_PSE_PBB_BV_46_C	N/A
 TC_PSE_PBB_BV_28_C	N/A
 TC_PSE_PBB_BV_29_C	N/A
 TC_PSE_PBB_BV_30_C	N/A
-TC_PSE_PBB_BV_31_C	PASS
+TC_PSE_PBB_BV_31_C	INC	JIRA #BA-71
 TC_PSE_PBB_BV_32_C	N/A
 TC_PSE_PBF_BV_01_I	PASS
 TC_PSE_PBF_BV_02_I	PASS	Tester must verify vcard content received by PTS
+TC_PSE_PBF_BV_03_I	PASS
 TC_PSE_PDF_BV_01_I	PASS	Tester must compare phone book size with the
 				value given by PTS
+TC_PSE_PDF_BV_06_I	PASS
 TC_PSE_BC_BV_03_I	N/A
 TC_PSE_CON_BV_02_I	N/A
 TC_PSE_ROB_BV_01_I	N/A
-- 
1.8.5.3

