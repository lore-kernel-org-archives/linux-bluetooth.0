Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: RFCOMM PTS 5.3 update
Date: Thu,  9 Oct 2014 17:15:44 +0200
Message-Id: <1412867744-11403-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS tests results for RFCOMM on PTS 5.3.
PICS' and PIXITs checked against PTS 5.3.
---
 android/pics-rfcomm.txt  |  2 +-
 android/pixit-rfcomm.txt |  2 +-
 android/pts-rfcomm.txt   | 22 ++++++++--------------
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/android/pics-rfcomm.txt b/android/pics-rfcomm.txt
index 9dfb32e..c970363 100644
--- a/android/pics-rfcomm.txt
+++ b/android/pics-rfcomm.txt
@@ -1,6 +1,6 @@
 RFCOMM PICS for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-rfcomm.txt b/android/pixit-rfcomm.txt
index 07810d2..187f3b4 100644
--- a/android/pixit-rfcomm.txt
+++ b/android/pixit-rfcomm.txt
@@ -1,6 +1,6 @@
 RFCOMM PIXIT for the PTS tool.
 
-PTS version: 5.2
+PTS version: 5.3
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-rfcomm.txt b/android/pts-rfcomm.txt
index 9bfc7a2..d869ee0 100644
--- a/android/pts-rfcomm.txt
+++ b/android/pts-rfcomm.txt
@@ -1,7 +1,7 @@
 PTS test results for RFCOMM
 
-PTS version: 5.2
-Tested: 17-July-2014
+PTS version: 5.3
+Tested: 08-October-2014
 Android version: 4.4.4
 
 Results:
@@ -17,29 +17,23 @@ Test Name		Result	Notes
 TC_RFC_BV_01_C		PASS	rctest -n -P 1 <btaddr>
 TC_RFC_BV_02_C		PASS	rctest -r -P 1
 TC_RFC_BV_03_C		PASS	rctest -r -P 1
-TC_RFC_BV_04_C		FAIL	PTS issue #12421
-				PTS issue #12414
-				NOTE: DISC on DLC is expected; IUT disconnects
-					rfcomm session (close)
+TC_RFC_BV_04_C		PASS	NOTE: use ets provided in PTS issue #12414
 TC_RFC_BV_05_C		PASS	rctest -n -P 4 <btaddr>
 				Note: test requires IUT to connect on the given
 				channel. sdptool browse <btaddr> to check the
 				channel.
 TC_RFC_BV_06_C		PASS	rctest -r -P 1
 TC_RFC_BV_07_C		PASS	rctest -r -P 1
-TC_RFC_BV_08_C		INC	PTS issue #12397
-				NOTE: Incorrect frame type sent in response to
-					the DISC command
+TC_RFC_BV_08_C		PASS	rctest -r -P 1
+				Note: use ets provided in PTS issue #12397
 TC_RFC_BV_11_C		PASS	rctest -r -P 1
-TC_RFC_BV_13_C		FAIL	PTS issue #12397
-				NOTE: IUT sent the correct frame type (UIH)
-				but the parameters did not match the
-				requirements
+TC_RFC_BV_13_C		PASS	rctest -r -P 1
+				Note: use ets provided in PTS issue #12397
 TC_RFC_BV_14_C		N/A
 TC_RFC_BV_15_C		PASS	rctest -r -P 1
 TC_RFC_BV_17_C		PASS	rctest -d -P 1
 TC_RFC_BV_19_C		PASS
 TC_RFC_BV_21_C		INC	PTS issue #12421
 TC_RFC_BV_22_C		INC	PTS issue #12421
-TC_RFC_BV_25_C		INC	PTS issue #12421
+TC_RFC_BV_25_C		INC	PTS issue #12621
 -------------------------------------------------------------------------------
-- 
1.8.5.3

