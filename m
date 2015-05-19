Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update PBAP test results
Date: Tue, 19 May 2015 14:55:01 +0200
Message-Id: <1432040101-22857-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-pbap.txt  | 8 ++++----
 android/pixit-pbap.txt | 3 ++-
 android/pts-pbap.txt   | 6 +++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/android/pics-pbap.txt b/android/pics-pbap.txt
index afd100b..bc01d8a 100644
--- a/android/pics-pbap.txt
+++ b/android/pics-pbap.txt
@@ -1,6 +1,6 @@
 PBAP PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -158,10 +158,10 @@ TSPC_PBAP_7_11	False		PCE: Single Response Mode (C.1)
 TSPC_PBAP_7_12	False		PCE: Single Response Mode Parameter
 					(ability to parse) (C.1)
 TSPC_PBAP_7_13	False		PCE: Single Response Mode Parameter
-					(ability to send) (C.1)
+					(ability to send) (C.2)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_PBAP_0_3 (PBAP 1.2) is supported, otherwise Excluded.
-C.2: Optional if TSPC_PBAP_0_3 (PBAP 1.2) is supported, otherwise Excluded.
+C.2: Optional if TSPC_PBAP_2a_3 (PBAP 1.2) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -322,7 +322,7 @@ TSPC_PBAP_14_13	False		PSE: Single Response Mode Parameter
 					(ability to send) (C.2)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_PBAP_0_3 (PBAP 1.2) is supported, otherwise Excluded.
-C.2: Optional if TSPC_PBAP_0_3 (PBAP 1.2) is supported, otherwise Excluded.
+C.2: Optional if TSPC_PBAP_9a_3 (PBAP 1.2) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
diff --git a/android/pixit-pbap.txt b/android/pixit-pbap.txt
index 034456a..9bf6c06 100644
--- a/android/pixit-pbap.txt
+++ b/android/pixit-pbap.txt
@@ -1,6 +1,6 @@
 PBAP PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -33,4 +33,5 @@ TSPX_obex_auth_password					0000
 TSPX_no_confirmations					False
 TSPX_PSE_vCardSelector					0000000000000001
 TSPX_Automation						False
+TSPX_search_criteria					PTS
 -------------------------------------------------------------------------------
diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
index 8931690..0c597eb 100644
--- a/android/pts-pbap.txt
+++ b/android/pts-pbap.txt
@@ -1,8 +1,8 @@
 PTS test results for PBAP
 
-PTS version: 6.0
-Tested: 30-January-2015
-Android version: 5.0
+PTS version: 6.1
+Tested: 19-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
-- 
1.9.1

