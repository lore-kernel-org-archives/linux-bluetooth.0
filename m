Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 1/2] android/pts: Update GATT test results for PTS 6.0
Date: Wed, 11 Feb 2015 14:28:11 +0100
Message-Id: <1423661292-16660-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index a452726..01bc947 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -1,7 +1,7 @@
 PTS test results for GATT
 
-PTS version: 5.3
-Tested: 05-December-2014
+PTS version: 6.0.1
+Tested: 02-February-2015
 Android version: 5.0
 
 Results:
@@ -18,8 +18,7 @@ TC_GAC_CL_BV_01_C	PASS	haltest:
 				gattc search_service
 				gattc get_characteristic
 				gattc write_characteristic: type 3
-TC_GAC_SR_BV_01_C	PASS	PTS issue #12357
-				NOTE: tested with ETS attached to errata
+TC_GAC_SR_BV_01_C	FAIL	PTS issue #13073
 				haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
@@ -49,12 +48,14 @@ TC_GAD_CL_BV_02_C	PASS	haltest:
 				gattc connect
 				gattc refresh
 TC_GAD_CL_BV_03_C	PASS	haltest:
-                                gattc register_client
-                                gattc scan
-                                gattc connect
-                                gattc search_service
+				gattc register_client
+				gattc scan
+				gattc connect
+				gattc search_service
 				gattc get_included_service
 				gattc_disconnect
+				gattc connect
+				gattc refresh
 TC_GAD_CL_BV_04_C	PASS	haltest:
 				when requested: gattc get_characteristic
 TC_GAD_CL_BV_05_C	PASS	haltest:
@@ -696,7 +697,7 @@ TC_GAW_CL_BI_32_C	PASS	haltest:
 				gattc search_service
 				gattc get_characteristic: srvc_id based on
 								handle from logs
-				gattc write_characteristic 2 <long_value>
+				gattc write_characteristic 3 <value>
 				gattc execute_write
 				gattc disconnect
 TC_GAW_CL_BI_33_C	PASS	haltest:
@@ -991,7 +992,7 @@ TC_GAW_SR_BI_31_C	PASS	haltest:
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BI_32_C	PASS	haltest:
+TC_GAW_SR_BI_32_C	FAIL	PTS issue #12823 haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -1077,7 +1078,7 @@ TC_GAT_CL_BV_01_C	PASS	haltest:
 				gattc get_characteristic: srvc_id based on
 								handle from logs
 				gattc read_characcteristic
-				gattc disconnect
+				wait for 30 sec timeout
 TC_GAT_CL_BV_02_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -1085,6 +1086,7 @@ TC_GAT_CL_BV_02_C	PASS	haltest:
 								handle from logs
 				gattc write_characcteristic 2 <short_value>
 				gattc disconnect
+				wait for 30 sec timeout
 TC_GAT_SR_BV_01_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
-- 
1.9.1

