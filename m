Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/doc: Update cts results for Android 5
Date: Thu, 27 Nov 2014 12:22:36 +0100
Message-Id: <1417087356-25455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Google decided to disable BLE tests in CTS due to some quality issues.
Our tests shows that pure AOSP on Nexus devices was not passing.
We need to rerun BLE section when it becomes available again.
---
 android/cts.txt | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/android/cts.txt b/android/cts.txt
index 9a7f651..f679263 100644
--- a/android/cts.txt
+++ b/android/cts.txt
@@ -1,15 +1,16 @@
 Android Compatibility Test Suite results
 
-Tested: 11-July-2014
-Android version: 4.4.4
-CTS version: 4.4 R3
+Tested: 27-Nov-2014
+Android version: 5.0
+Kernel Version: 3.18
+CTS version: 5.0 R1 (android-5.0.0_r7)
 
 Note:
 CTS reliable write GATT tests require using CTS from master branch
 or https://android-review.googlesource.com/99354 applied.
 
-(*) Due to bug in Bluedroid L2CAP implementation GATT server connect tests fails
-without modified Linux kernel. Patches for Linux and/or Bluedroid are still TBD.
+(*) Tests are disabled due to CTS quality issues. Link for reference:
+https://android.googlesource.com/platform/cts/+/0a62e4a0a9910101ccf2ccc43f6%5E!/
 
 -------------------------------------------------------------------------------
 android.bluetooth.cts.BasicAdapterTest (automated tests)
@@ -33,26 +34,25 @@ Test Name				Result	Notes
 -------------------------------------------------------------------------------
 Toggle Bluetooth			PASS
 BLE Client Test:
-	connect				PASS
-	discover service		PASS
-	read/write characteristic	PASS
-	reliable write			PASS
-	notify characteristic		PASS
-	read/write descriptor		PASS
-	read RSSI			PASS
-	disconnect			PASS
+	connect				N/A	(*)
+	discover service		N/A	(*)
+	read/write characteristic	N/A	(*)
+	reliable write			N/A	(*)
+	notify characteristic		N/A	(*)
+	read/write descriptor		N/A	(*)
+	read RSSI			N/A	(*)
+	disconnect			N/A	(*)
 BLE Server Test:
-	add service			PASS
-	connection			FAIL	(*) bluedroid issue.
-	read characteristic request	FAIL	(*)
-	write characteristic request	FAIL	(*)
-	read descriptor request		FAIL	(*)
-	write descriptor request	FAIL	(*)
-	reliable write			FAIL	(*)
-	disconnection			FAIL	(*)
+	add service			N/A	(*)
+	connection			N/A	(*)
+	read characteristic request	N/A	(*)
+	write characteristic request	N/A	(*)
+	read descriptor request		N/A	(*)
+	write descriptor request	N/A	(*)
+	reliable write			N/A	(*)
+	disconnection			N/A	(*)
 Insecure Client				PASS
-Insecure Server				PASS	Required kernel patch commit ID:
-						ba15a58b179ed76a7e887177f2b06de1
+Insecure Server				PASS
 Secure Client				PASS
 Secure Server				PASS
 -------------------------------------------------------------------------------
-- 
1.9.1

