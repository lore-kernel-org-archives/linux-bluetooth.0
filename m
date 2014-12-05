Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 1/1] android/pts: GATT PTS test results for Android 5.0
Date: Fri,  5 Dec 2014 16:26:25 +0100
Message-Id: <1417793185-17030-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 66 ++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index ea6a014..167a6dc 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -1,8 +1,8 @@
 PTS test results for GATT
 
 PTS version: 5.3
-Tested: 16-October-2014
-Android version: 4.4.4
+Tested: 05-December-2014
+Android version: 5.0
 
 Results:
 PASS	test passed
@@ -729,12 +729,12 @@ TC_GAW_CL_BI_36_C	PASS	haltest:
 				gattc get_descriptor
 				gattc write_descriptor 2 <long_value>
 				gattc disconnect
-TC_GAW_SR_BV_01_C	PASS	haltest:
+TC_GAW_SR_BV_01_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 4 <permissions> 17
 				gatts start_service
-TC_GAW_SR_BV_02_C	PASS	haltest:
+TC_GAW_SR_BV_02_C	FAIL	haltest:
 				gatts add service
 				gatts add_characteristics:
 					<properties> 66 <permisions> 145
@@ -743,7 +743,7 @@ TC_GAW_SR_BV_02_C	PASS	haltest:
 				gatts send_response: (twice)
 				NOTE: gatts_request_write_cb shall be called
 								 (verify it)
-TC_GAW_SR_BI_01_C	PASS	haltest:
+TC_GAW_SR_BI_01_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 68
@@ -783,7 +783,7 @@ TC_GAW_SR_BI_06_C	PASS	haltest:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_05_C	PASS	haltest:
+TC_GAW_SR_BV_05_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -793,18 +793,18 @@ TC_GAW_SR_BV_05_C	PASS	haltest:
 						repeat with correct offset
 				gatts send_response:
 						repeat with correct value
-TC_GAW_SR_BI_07_C	PASS	haltest:
+TC_GAW_SR_BI_07_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response
-TC_GAW_SR_BI_08_C	PASS	haltest:
+TC_GAW_SR_BI_08_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 2 <permissions> 1
 				gatts start_service
-TC_GAW_SR_BI_09_C	PASS	haltest:
+TC_GAW_SR_BI_09_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -813,7 +813,7 @@ TC_GAW_SR_BI_09_C	PASS	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 7
-TC_GAW_SR_BI_11_C	PASS	haltest:
+TC_GAW_SR_BI_11_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -822,7 +822,7 @@ TC_GAW_SR_BI_11_C	PASS	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 8
-TC_GAW_SR_BI_12_C	PASS	haltest:
+TC_GAW_SR_BI_12_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -831,7 +831,7 @@ TC_GAW_SR_BI_12_C	PASS	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 5
-TC_GAW_SR_BI_13_C	PASS	haltest:
+TC_GAW_SR_BI_13_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -840,14 +840,14 @@ TC_GAW_SR_BI_13_C	PASS	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_06_C	PASS	haltest:
+TC_GAW_SR_BV_06_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response:
 						repeat with correct value
-TC_GAW_SR_BV_10_C	PASS	haltest:
+TC_GAW_SR_BV_10_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -857,37 +857,37 @@ TC_GAW_SR_BV_10_C	PASS	haltest:
 						repeat with correct offset
 				gatts send_response:
 						repeat with correct value
-TC_GAW_SR_BI_14_C	PASS	haltest:
+TC_GAW_SR_BI_14_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 1
-TC_GAW_SR_BI_15_C	PASS	haltest:
+TC_GAW_SR_BI_15_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 3
-TC_GAW_SR_BI_17_C	PASS	haltest:
+TC_GAW_SR_BI_17_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 8
-TC_GAW_SR_BI_18_C	PASS	haltest:
+TC_GAW_SR_BI_18_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 5
-TC_GAW_SR_BI_19_C	PASS	haltest:
+TC_GAW_SR_BI_19_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_07_C	PASS	haltest:
+TC_GAW_SR_BV_07_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -936,7 +936,7 @@ TC_GAW_SR_BI_24_C	PASS	haltest:
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_09_C	PASS	haltest:
+TC_GAW_SR_BV_09_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -947,20 +947,20 @@ TC_GAW_SR_BV_09_C	PASS	haltest:
 						repeat with correct offset
 				gatts send_response:
 						repeat with correct value
-TC_GAW_SR_BI_25_C	PASS	haltest:
+TC_GAW_SR_BI_25_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 1
-TC_GAW_SR_BI_26_C	PASS	haltest:
+TC_GAW_SR_BI_26_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 1
 				gatts start_service
-TC_GAW_SR_BI_27_C	PASS	haltest:
+TC_GAW_SR_BI_27_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -970,35 +970,35 @@ TC_GAW_SR_BI_27_C	PASS	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 7
-TC_GAW_SR_BI_29_C	PASS	haltest:
+TC_GAW_SR_BI_29_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 8
-TC_GAW_SR_BI_30_C	PASS	haltest:
+TC_GAW_SR_BI_30_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 5
-TC_GAW_SR_BI_31_C	PASS	haltest:
+TC_GAW_SR_BI_31_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BI_32_C	PASS	haltest:
+TC_GAW_SR_BI_32_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_33_C	PASS	haltest:
+TC_GAW_SR_BI_33_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -1007,7 +1007,7 @@ TC_GAW_SR_BI_33_C	PASS	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_34_C	PASS	haltest:
+TC_GAW_SR_BI_34_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -1015,7 +1015,7 @@ TC_GAW_SR_BI_34_C	PASS	haltest:
 				gatts start_service
 				gatts send_response
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_35_C	PASS	haltest:
+TC_GAW_SR_BI_35_C	FAIL	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -1060,10 +1060,10 @@ TC_GAI_SR_BV_01_C	PASS	haltest:
 				gatts start_service
 				gatts add_service
 				gatts start_service
-TC_GAS_CL_BV_01_C	PASS	haltest:
+TC_GAS_CL_BV_01_C	FAIL	haltest:
 				gattc connect
 				gattc disconnect
-TC_GAS_SR_BV_01_C	PASS	haltest:
+TC_GAS_SR_BV_01_C	FAIL	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 						<properties> 42 <permissions> 17
-- 
1.9.1

