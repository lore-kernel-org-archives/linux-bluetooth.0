Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/cts: Update test results for CTS 4.4 R3
Date: Fri, 25 Jul 2014 13:10:42 +0200
Message-Id: <1406286642-31184-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

---
 android/cts.txt | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/android/cts.txt b/android/cts.txt
index 5193571..9a7f651 100644
--- a/android/cts.txt
+++ b/android/cts.txt
@@ -1,9 +1,16 @@
 Android Compatibility Test Suite results
 
-Tested: 25-June-2014
-Android version: 4.4.2
+Tested: 11-July-2014
+Android version: 4.4.4
 CTS version: 4.4 R3
 
+Note:
+CTS reliable write GATT tests require using CTS from master branch
+or https://android-review.googlesource.com/99354 applied.
+
+(*) Due to bug in Bluedroid L2CAP implementation GATT server connect tests fails
+without modified Linux kernel. Patches for Linux and/or Bluedroid are still TBD.
+
 -------------------------------------------------------------------------------
 android.bluetooth.cts.BasicAdapterTest (automated tests)
 Test Name				Result	Notes
@@ -22,12 +29,30 @@ test_listenUsingRfcommWithServiceRecord	PASS
 
 -------------------------------------------------------------------------------
 com.android.cts.verifier (manual tests)
-Test Name		Result	Notes
+Test Name				Result	Notes
 -------------------------------------------------------------------------------
-Toggle Bluetooth	PASS
-Insecure Client		PASS
-Insecure Server		PASS	Required kernel patch commit ID:
-				6453462e99e8be13a2c8f2b3535f340b742d8192
-Secure Client		PASS
-Secure Server		PASS
+Toggle Bluetooth			PASS
+BLE Client Test:
+	connect				PASS
+	discover service		PASS
+	read/write characteristic	PASS
+	reliable write			PASS
+	notify characteristic		PASS
+	read/write descriptor		PASS
+	read RSSI			PASS
+	disconnect			PASS
+BLE Server Test:
+	add service			PASS
+	connection			FAIL	(*) bluedroid issue.
+	read characteristic request	FAIL	(*)
+	write characteristic request	FAIL	(*)
+	read descriptor request		FAIL	(*)
+	write descriptor request	FAIL	(*)
+	reliable write			FAIL	(*)
+	disconnection			FAIL	(*)
+Insecure Client				PASS
+Insecure Server				PASS	Required kernel patch commit ID:
+						ba15a58b179ed76a7e887177f2b06de1
+Secure Client				PASS
+Secure Server				PASS
 -------------------------------------------------------------------------------
-- 
1.8.5.3

