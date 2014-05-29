Return-Path: <cyrus@holtmann.org>
From: Eva Kolanska <eva.kolanska@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCH] android/pts: Update GATT test results
Date: Thu, 29 May 2014 13:00:51 +0200
Message-Id: <1401361251-15309-1-git-send-email-eva.kolanska@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt |   89 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 11 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 9c8d191..97dcbd1 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -120,7 +120,13 @@ TC_GAR_CL_BI_03_C	PASS	haltest:
 				gattc read_characteristic
 TC_GAR_CL_BI_04_C	PASS	haltest:
 				gattc read_characteristic
-TC_GAR_CL_BI_05_C	INC	not implemented (encryption)
+TC_GAR_CL_BI_05_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc read_characteristic
+				gattc disconnect
 TC_GAR_CL_BV_03_C	INC	JIRA: BZ-31
 TC_GAR_CL_BI_06_C	INC	JIRA: BZ-31
 TC_GAR_CL_BI_07_C	INC	JIRA: BZ-31
@@ -139,7 +145,13 @@ TC_GAR_CL_BI_15_C	PASS	haltest:
 				gattc read_characteristic
 TC_GAR_CL_BI_16_C	PASS	haltest:
 				gattc read_characteristic
-TC_GAR_CL_BI_17_C	INC	not implemented (encryption)
+TC_GAR_CL_BI_17_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc read_characteristic
+				gattc disconnect
 TC_GAR_CL_BV_05_C	N/A
 TC_GAR_CL_BI_18_C	N/A
 TC_GAR_CL_BI_19_C	N/A
@@ -156,7 +168,15 @@ TC_GAR_CL_BI_25_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_26_C	PASS	haltest:
 				gattc read_descriptor
-TC_GAR_CL_BI_27_C	INC	not implemented (encryption)
+TC_GAR_CL_BI_27_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor: srvc_id based on
+								handle from logs
+				gattc read_descriptor
+				gattc disconnect
 TC_GAR_CL_BV_07_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_28_C	PASS	haltest:
@@ -169,7 +189,15 @@ TC_GAR_CL_BI_31_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_32_C	PASS	haltest:
 				gattc read_descriptor
-TC_GAR_CL_BI_33_C	INC	not implemented (encryption)
+TC_GAR_CL_BI_33_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor: srvc_id based on
+								handle from logs
+				gattc read_descriptor
+				gattc disconnect
 TC_GAR_CL_BI_34_C	N/A
 TC_GAR_CL_BI_35_C	PASS	haltest:
 				gattc read_characteristic
@@ -814,9 +842,23 @@ TC_GAW_SR_BI_34_C	PASS	haltest:
 				gatts send_response
 				gatts send_response: <status> 13
 TC_GAW_SR_BI_35_C	INC
-TC_GAN_CL_BV_01_C	INC	PTS issue #12249
+TC_GAN_CL_BV_01_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor
+				gattc write_descriptor 2 <hex_value> 0001
+				gattc disconnect
 TC_GAN_SR_BV_01_C	INC
-TC_GAI_CL_BV_01_C	INC  	PTS issue #12211
+TC_GAI_CL_BV_01_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor
+				gattc write_descriptor 2 <hex_value> 0002
+				gattc disconnect
 TC_GAI_SR_BV_01_C	INC
 TC_GAS_CL_BV_01_C	PASS	haltest:
 				gattc connect
@@ -862,10 +904,35 @@ TC_GPA_SR_BV_04_C	PASS	haltest:
 				gatts add_chaaracteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
-TC_GPA_SR_BV_05_C	INC
-TC_GPA_SR_BV_06_C	INC
-TC_GPA_SR_BV_07_C	INC
-TC_GPA_SR_BV_08_C	INC
-TC_GPA_SR_BV_11_C	INC
+TC_GPA_SR_BV_05_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 138 <permissions> 17
+				gatts add_descriptor <UUID> 2900
+				gatts start_service
+				gatts send_response
+TC_GPA_SR_BV_06_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 138 <permissions> 17
+				gatts add_descriptor <UUID> 2901
+				gatts start_service
+				gatts send_respons
+TC_GPA_SR_BV_07_C	PASS
+TC_GPA_SR_BV_08_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 138 <permissions> 17
+				gatts add_descriptor <UUID> 2903
+				gatts start_service
+				gatts send_respons
+TC_GPA_SR_BV_11_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 138 <permissions> 17
+				gatts add_descriptor <UUID> 2905
+				gatts start_service
+				gatts send_respons: repeat with correct offset
+								and data
 TC_GPA_SR_BV_12_C	INC
 -------------------------------------------------------------------------------
-- 
1.7.9.5

