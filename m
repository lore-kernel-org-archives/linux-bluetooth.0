Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/8] android/pts: Remove PIXIT info from PICS files
Date: Wed, 11 Dec 2013 16:27:11 +0100
Message-Id: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Full PIXIT configuration will be provided in separate files.
---
 android/pics-did.txt  | 11 -----------
 android/pics-gap.txt  |  5 -----
 android/pics-hid.txt  |  5 -----
 android/pics-opp.txt  |  5 -----
 android/pics-pan.txt  |  5 -----
 android/pics-pbap.txt |  5 -----
 6 files changed, 36 deletions(-)

diff --git a/android/pics-did.txt b/android/pics-did.txt
index e8c914a..8f92bc1 100644
--- a/android/pics-did.txt
+++ b/android/pics-did.txt
@@ -29,14 +29,3 @@ TSPC_DID_1_5	True		Primary Record (M)
 TSPC_DID_1_6	True		Vendor ID Source (M)
 TSPC_ALL	False		Turns on all the test cases
 -------------------------------------------------------------------------------
-
-
-		Required PIXIT settings
--------------------------------------------------------------------------------
-Parameter Name			Value
--------------------------------------------------------------------------------
-TSPX_ClientExecutableURL	False
-TSPX_ServiceDescription		False
-TSPX_DocumentationURL		False
--------------------------------------------------------------------------------
-Other should be set according to Tester's test environment.
diff --git a/android/pics-gap.txt b/android/pics-gap.txt
index cd274e8..e8ab2ab 100644
--- a/android/pics-gap.txt
+++ b/android/pics-gap.txt
@@ -707,8 +707,3 @@ TSPC_SM_1_2	False		Slave Role (Responder)
 TSPC_SM_2_4	False		OOB supported (O)
 TSPC_ALL	False		Turns on all
 -------------------------------------------------------------------------------
-
-
--------------------------------------------------------------------------------
-No special PIXIT settings required. All should be set according to Tester's
-test environment.
diff --git a/android/pics-hid.txt b/android/pics-hid.txt
index ba50626..b0b7d52 100644
--- a/android/pics-hid.txt
+++ b/android/pics-hid.txt
@@ -283,8 +283,3 @@ TSPC_ALL	False		Enables all test cases when set to true.
 -------------------------------------------------------------------------------
 M.1: Mandatory IF (TSPC_HID_1_2) is supported.
 -------------------------------------------------------------------------------
-
-
--------------------------------------------------------------------------------
-No special PIXIT settings required. All should be set according to Tester's
-test environment.
diff --git a/android/pics-opp.txt b/android/pics-opp.txt
index 11e61ff..c0f2ad6 100644
--- a/android/pics-opp.txt
+++ b/android/pics-opp.txt
@@ -182,8 +182,3 @@ TSPC_ALL	False		Turn on all test cases.
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_OPP_1_2 is supported, otherwise excluded.
 -------------------------------------------------------------------------------
-
-
--------------------------------------------------------------------------------
-No special PIXIT settings required. All should be set according to Tester's
-test environment.
diff --git a/android/pics-pan.txt b/android/pics-pan.txt
index 406b6a9..7576d2d 100644
--- a/android/pics-pan.txt
+++ b/android/pics-pan.txt
@@ -144,8 +144,3 @@ C.1: PAN User devices must support at least One of items (TSPC_PAN_4_2) or
 C.2: Mandatory to support if (TSPC_PAN_4_2) is supported.
 C.3: Mandatory to support if (TSPC_PAN_4_8) is supported.
 -------------------------------------------------------------------------------
-
-
--------------------------------------------------------------------------------
-No special PIXIT settings required. All should be set according to Tester's
-test environment.
diff --git a/android/pics-pbap.txt b/android/pics-pbap.txt
index 2af5fd8..7b2d7d2 100644
--- a/android/pics-pbap.txt
+++ b/android/pics-pbap.txt
@@ -439,8 +439,3 @@ TSPC_ALL	False (*)	Turns on all the test cases
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_PBAP_26_4 (OBEX SRM) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
-
-
--------------------------------------------------------------------------------
-No special PIXIT settings required. All should be set according to Tester's
-test environment.
-- 
1.8.3.2

