Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/cts: Update CTS test results for Android 5.0
Date: Mon, 17 Nov 2014 15:50:09 +0100
Message-Id: <1416235809-12637-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/cts.txt | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/android/cts.txt b/android/cts.txt
index 9a7f651..68feabf 100644
--- a/android/cts.txt
+++ b/android/cts.txt
@@ -1,15 +1,8 @@
 Android Compatibility Test Suite results
 
-Tested: 11-July-2014
-Android version: 4.4.4
-CTS version: 4.4 R3
-
-Note:
-CTS reliable write GATT tests require using CTS from master branch
-or https://android-review.googlesource.com/99354 applied.
-
-(*) Due to bug in Bluedroid L2CAP implementation GATT server connect tests fails
-without modified Linux kernel. Patches for Linux and/or Bluedroid are still TBD.
+Tested: 17-November-2014
+Android version: 5.0
+CTS version: 5.0 r0.5
 
 -------------------------------------------------------------------------------
 android.bluetooth.cts.BasicAdapterTest (automated tests)
@@ -17,13 +10,13 @@ Test Name				Result	Notes
 -------------------------------------------------------------------------------
 testAndroidTestCaseSetupProperly	PASS
 test_checkBluetoothAddress		PASS
-test_enableDisable			PASS
-test_getAddress				PASS
-test_getBondedDevices			PASS
+test_enableDisable			FAIL
+test_getAddress				FAIL
+test_getBondedDevices			FAIL
 test_getDefaultAdapter			PASS
 test_getName				PASS
 test_getRemoteDevice			PASS
-test_listenUsingRfcommWithServiceRecord	PASS
+test_listenUsingRfcommWithServiceRecord	FAIL
 -------------------------------------------------------------------------------
 
 
@@ -43,16 +36,23 @@ BLE Client Test:
 	disconnect			PASS
 BLE Server Test:
 	add service			PASS
-	connection			FAIL	(*) bluedroid issue.
-	read characteristic request	FAIL	(*)
-	write characteristic request	FAIL	(*)
-	read descriptor request		FAIL	(*)
-	write descriptor request	FAIL	(*)
-	reliable write			FAIL	(*)
-	disconnection			FAIL	(*)
-Insecure Client				PASS
-Insecure Server				PASS	Required kernel patch commit ID:
+	connection			PASS
+	read characteristic request	FAIL
+	write characteristic request	FAIL
+	read descriptor request		FAIL
+	write descriptor request	FAIL
+	reliable write			FAIL
+	disconnection			FAIL
+Insecure Client				FAIL
+Insecure Server				FAIL	Required kernel patch commit ID:
 						ba15a58b179ed76a7e887177f2b06de1
-Secure Client				PASS
-Secure Server				PASS
+Secure Client				FAIL
+Secure Server				FAIL
+BLE Advertiser Test:
+	BLE Hardware Scan Filter	FAIL
+	BLE Tx Power Level		FAIL
+BLE Scanner Test
+	BLE Hardware Scan Filter	FAIL
+	BLE Tx Power Level		FAIL
+
 -------------------------------------------------------------------------------
-- 
1.9.3

