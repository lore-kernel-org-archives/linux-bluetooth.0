Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: PTS tests update for RFCOMM
Date: Mon, 13 Oct 2014 13:29:43 +0200
Message-Id: <1413199783-19452-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test TC_RFC_BV_25_C depends on kernel patches for Non-Supported Command,
"Bluetooth: Fix RFCOMM NSC response" and "Bluetooth: Improve
RFCOMM__test_pf macro robustness"
---
 android/pts-rfcomm.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/pts-rfcomm.txt b/android/pts-rfcomm.txt
index 5d51905..98a691b 100644
--- a/android/pts-rfcomm.txt
+++ b/android/pts-rfcomm.txt
@@ -1,8 +1,9 @@
 PTS test results for RFCOMM
 
 PTS version: 5.3
-Tested: 08-October-2014
+Tested: 13-October-2014
 Android version: 4.4.4
+Kernel version: 3.18
 
 Results:
 PASS	test passed
@@ -18,6 +19,7 @@ TC_RFC_BV_01_C		PASS	rctest -n -P 1 <btaddr>
 TC_RFC_BV_02_C		PASS	rctest -r -P 1
 TC_RFC_BV_03_C		PASS	rctest -r -P 1
 TC_RFC_BV_04_C		PASS	Note: use ETS provided in PTS issue #12414
+				rctest -r -P 1
 TC_RFC_BV_05_C		PASS	rctest -n -P 4 <btaddr>
 				Note: test requires IUT to connect on the given
 				channel. sdptool browse <btaddr> to check the
@@ -35,5 +37,5 @@ TC_RFC_BV_17_C		PASS	rctest -d -P 1
 TC_RFC_BV_19_C		PASS
 TC_RFC_BV_21_C		INC	PTS issue #12421
 TC_RFC_BV_22_C		INC	PTS issue #12421
-TC_RFC_BV_25_C		INC	PTS issue #12621
+TC_RFC_BV_25_C		PASS	rctest -r -P 1
 -------------------------------------------------------------------------------
-- 
1.8.5.3

