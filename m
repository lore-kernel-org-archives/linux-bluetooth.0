Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update RFCOMM test results
Date: Tue, 12 May 2015 11:34:22 +0200
Message-Id: <1431423262-31970-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-rfcomm.txt  |  8 +++-----
 android/pixit-rfcomm.txt |  2 +-
 android/pts-rfcomm.txt   | 14 ++++++--------
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/android/pics-rfcomm.txt b/android/pics-rfcomm.txt
index 384f81d..032ee73 100644
--- a/android/pics-rfcomm.txt
+++ b/android/pics-rfcomm.txt
@@ -1,6 +1,6 @@
 RFCOMM PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -25,7 +25,7 @@ Parameter Name		Selected	Description
 -------------------------------------------------------------------------------
 TSPC_RFCOMM_1_1		True (*)	Initialize RFCOMM Session (C.2)
 TSPC_RFCOMM_1_2		True (*)	Respond to Initialization of an RFCOMM
-					Session (C.2)
+					Session (C.1)
 TSPC_RFCOMM_1_3		True		Shutdown RFCOMM Session (M)
 TSPC_RFCOMM_1_4		True		Respond to a Shutdown of an RFCOMM
 					Session (M)
@@ -49,13 +49,11 @@ TSPC_RFCOMM_1_20	True (*)	Send RPN Command (O)
 TSPC_RFCOMM_1_21	True (*)	Closing Multiplexer by First Sending
 					a DISC Command (O)
 TSPC_RFCOMM_1_22	True		Support of Credit Based Flow Control (M)
-TSPC_RFCOMM_1_23	True (*)	IUT Responds to Establishment of
-					a DLC (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory if SPP 1/2 (Device B) is supported, otherwise Excluded.
 C.2: Mandatory if SPP 1/1 (Device A) is supported, otherwise Excluded.
 C.3: Mandatory if SPP 1/1 (Device A) is supported, otherwise Optional.
-C.4: Mandatory to support if 0/2 (RFCOMM 1.2) is supported, otherwise Optional.
+C.4: Mandatory to support if TSPC_RFCOMM_0_2 is supported, otherwise Optional.
 -------------------------------------------------------------------------------
 
 
diff --git a/android/pixit-rfcomm.txt b/android/pixit-rfcomm.txt
index a3fbb27..88402a5 100644
--- a/android/pixit-rfcomm.txt
+++ b/android/pixit-rfcomm.txt
@@ -1,6 +1,6 @@
 RFCOMM PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-rfcomm.txt b/android/pts-rfcomm.txt
index e9b3f26..b1fce28 100644
--- a/android/pts-rfcomm.txt
+++ b/android/pts-rfcomm.txt
@@ -1,9 +1,9 @@
 PTS test results for RFCOMM
 
-PTS version: 6.0
-Tested: 02-February-2015
-Android version: 5.0
-Kernel version: 3.19
+PTS version: 6.1
+Tested: 12-May-2015
+Android version: 5.1
+Kernel version: 4.1
 
 Results:
 PASS	test passed
@@ -32,9 +32,7 @@ TC_RFC_BV_14_C		N/A
 TC_RFC_BV_15_C		PASS	rctest -r -P 1
 TC_RFC_BV_17_C		PASS	rctest -d -P 1
 TC_RFC_BV_19_C		PASS
-TC_RFC_BV_21_C		PASS	PTS issue #13011
-				rctest -w -N 10 -P 1
-TC_RFC_BV_22_C		PASS	PTS issue #13011
-				rctest -w -N 10 -P 1
+TC_RFC_BV_21_C		PASS	rctest -w -N 10 -P 1
+TC_RFC_BV_22_C		PASS	rctest -w -N 10 -P 1
 TC_RFC_BV_25_C		PASS	rctest -r -P 1
 -------------------------------------------------------------------------------
-- 
1.9.1

