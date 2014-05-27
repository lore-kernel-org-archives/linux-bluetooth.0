Return-Path: <cyrus@holtmann.org>
From: Eva Kolanska <eva.kolanska@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCH] android/pts: Update GATT PTS tests results
Date: Tue, 27 May 2014 16:22:39 +0200
Message-Id: <1401200559-10561-1-git-send-email-eva.kolanska@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt |   87 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 76 insertions(+), 11 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index d025064..b5126ee 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -19,6 +19,7 @@ TC_GAC_CL_BV_01_C	PASS	haltest:
 				gattc get_characteristic
 				gattc write_characteristic: type 3
 TC_GAC_SR_BV_01_C	INC	JIRA: BZ-22
+				PTS issue #12250
 TC_GAD_CL_BV_01_C	PASS	haltest:
 				gattc register_client
 				gattc scan
@@ -131,20 +132,49 @@ TC_GAR_CL_BI_35_C	PASS	haltest:
 				gattc read_characteristic
 TC_GAR_SR_BV_01_C	PASS
 TC_GAR_SR_BI_01_C	PASS
-TC_GAR_SR_BI_02_C	INC
+TC_GAR_SR_BI_02_C	PASS
 TC_GAR_SR_BI_03_C	INC
-TC_GAR_SR_BI_04_C	INC
+TC_GAR_SR_BI_04_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 3
+				gatts start_service
+				gatts send_response
 TC_GAR_SR_BI_05_C	INC
 TC_GAR_SR_BV_03_C	PASS
-TC_GAR_SR_BI_06_C	INC
+TC_GAR_SR_BI_06_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 16
+				gatts start_service
 TC_GAR_SR_BI_07_C	PASS
 TC_GAR_SR_BI_08_C	PASS
 TC_GAR_SR_BI_09_C	INC
 TC_GAR_SR_BI_10_C	INC
 TC_GAR_SR_BI_11_C	INC
-TC_GAR_SR_BV_04_C	INC
-TC_GAR_SR_BI_12_C	INC
-TC_GAR_SR_BI_13_C	INC
+TC_GAR_SR_BV_04_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+TC_GAR_SR_BI_12_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 8 <permissions> 16
+				gatts start_service
+				gatts send_response
+TC_GAR_SR_BI_13_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 7
 TC_GAR_SR_BI_14_C	INC
 TC_GAR_SR_BI_15_C	INC
 TC_GAR_SR_BI_16_C	INC
@@ -155,17 +185,52 @@ TC_GAR_SR_BI_19_C	INC
 TC_GAR_SR_BI_20_C	INC
 TC_GAR_SR_BI_21_C	INC
 TC_GAR_SR_BI_22_C	INC
-TC_GAR_SR_BV_06_C	INC
+TC_GAR_SR_BV_06_C	PASS haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor
+				gatts start_service
+				gatts send_response
 TC_GAR_SR_BI_23_C	INC
-TC_GAR_SR_BI_24_C	INC
+TC_GAR_SR_BI_24_C	PASS haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor
+				gatts start_service
+				gatts send_response: <status> 1
 TC_GAR_SR_BI_25_C	INC
 TC_GAR_SR_BI_26_C	INC
 TC_GAR_SR_BI_27_C	INC
-TC_GAR_SR_BV_07_C	INC
+TC_GAR_SR_BV_07_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 1
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
 TC_GAR_SR_BV_08_C	INC
 TC_GAR_SR_BI_28_C	INC
-TC_GAR_SR_BI_29_C	INC
-TC_GAR_SR_BI_30_C	INC
+TC_GAR_SR_BI_29_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 1
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 7
+TC_GAR_SR_BI_30_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 1
 TC_GAR_SR_BI_31_C	INC
 TC_GAR_SR_BI_32_C	INC
 TC_GAR_SR_BI_33_C	INC
-- 
1.7.9.5

