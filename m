Return-Path: <cyrus@holtmann.org>
From: Eva Kolanska <eva.kolanska@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCH] android/pts: Update GATT test results
Date: Wed, 28 May 2014 10:53:21 +0200
Message-Id: <1401267201-20455-1-git-send-email-eva.kolanska@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt |  108 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 16 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index b5126ee..57c99dc 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -133,14 +133,24 @@ TC_GAR_CL_BI_35_C	PASS	haltest:
 TC_GAR_SR_BV_01_C	PASS
 TC_GAR_SR_BI_01_C	PASS
 TC_GAR_SR_BI_02_C	PASS
-TC_GAR_SR_BI_03_C	INC
+TC_GAR_SR_BI_03_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						 <properties> 2 <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 8
 TC_GAR_SR_BI_04_C	PASS	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 						<properties> 2 <permissions> 3
 				gatts start_service
 				gatts send_response
-TC_GAR_SR_BI_05_C	INC
+TC_GAR_SR_BI_05_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						 <properties> 2 <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 12
 TC_GAR_SR_BV_03_C	PASS
 TC_GAR_SR_BI_06_C	PASS	haltest:
 				gatts add_service
@@ -175,34 +185,77 @@ TC_GAR_SR_BI_13_C	PASS	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 7
-TC_GAR_SR_BI_14_C	INC
-TC_GAR_SR_BI_15_C	INC
-TC_GAR_SR_BI_16_C	INC
-TC_GAR_SR_BI_17_C	INC
+TC_GAR_SR_BI_14_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						 <properties> 2 <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 1
+TC_GAR_SR_BI_15_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						 <properties> 2 <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 8
+TC_GAR_SR_BI_16_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						 <properties> 2 <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 5
+TC_GAR_SR_BI_17_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						 <properties> 2 <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 12
 TC_GAR_SR_BV_05_C	INC
 TC_GAR_SR_BI_18_C	INC
 TC_GAR_SR_BI_19_C	INC
 TC_GAR_SR_BI_20_C	INC
 TC_GAR_SR_BI_21_C	INC
 TC_GAR_SR_BI_22_C	INC
-TC_GAR_SR_BV_06_C	PASS haltest:
+TC_GAR_SR_BV_06_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 2 <permissions> 1
 				gatts add_descriptor
 				gatts start_service
 				gatts send_response
-TC_GAR_SR_BI_23_C	INC
-TC_GAR_SR_BI_24_C	PASS haltest:
+TC_GAR_SR_BI_23_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 16
+				gatts start_service
+TC_GAR_SR_BI_24_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 2 <permissions> 1
 				gatts add_descriptor
 				gatts start_service
 				gatts send_response: <status> 1
-TC_GAR_SR_BI_25_C	INC
-TC_GAR_SR_BI_26_C	INC
-TC_GAR_SR_BI_27_C	INC
+TC_GAR_SR_BI_25_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 8
+TC_GAR_SR_BI_26_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 5
+TC_GAR_SR_BI_27_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 12
 TC_GAR_SR_BV_07_C	PASS	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
@@ -213,7 +266,12 @@ TC_GAR_SR_BV_07_C	PASS	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 TC_GAR_SR_BV_08_C	INC
-TC_GAR_SR_BI_28_C	INC
+TC_GAR_SR_BI_28_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 16
+				gatts start_service
 TC_GAR_SR_BI_29_C	PASS	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
@@ -231,9 +289,27 @@ TC_GAR_SR_BI_30_C	PASS	haltest:
 				gatts add_descriptor: <permissions> 1
 				gatts start_service
 				gatts send_response: <status> 1
-TC_GAR_SR_BI_31_C	INC
-TC_GAR_SR_BI_32_C	INC
-TC_GAR_SR_BI_33_C	INC
+TC_GAR_SR_BI_31_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 8
+TC_GAR_SR_BI_32_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 5
+TC_GAR_SR_BI_33_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 12
 TC_GAR_SR_BI_34_C	INC
 TC_GAR_SR_BI_35_C	INC
 TC_GAW_CL_BV_01_C	PASS 	haltest:
-- 
1.7.9.5

