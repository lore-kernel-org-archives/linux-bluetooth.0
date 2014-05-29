Return-Path: <cyrus@holtmann.org>
From: Eva Kolanska <eva.kolanska@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCH v2] android/pts: Update GATT test results
Date: Thu, 29 May 2014 15:34:15 +0200
Message-Id: <1401370455-20995-1-git-send-email-eva.kolanska@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt |  129 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 110 insertions(+), 19 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 8fe019c..283e81a 100644
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
 TC_GAR_CL_BV_03_C	INC	JIRA: BZ-31, Possible PTS issue #12227
 TC_GAR_CL_BI_06_C	PASS	haltest:
 				gattc connect
@@ -154,7 +160,13 @@ TC_GAR_CL_BI_15_C	PASS	haltest:
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
@@ -171,7 +183,15 @@ TC_GAR_CL_BI_25_C	PASS	haltest:
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
@@ -184,7 +204,15 @@ TC_GAR_CL_BI_31_C	PASS	haltest:
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
@@ -829,9 +857,23 @@ TC_GAW_SR_BI_34_C	PASS	haltest:
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
@@ -852,14 +894,38 @@ TC_GAT_CL_BV_02_C	PASS	haltest:
 				gattc write_characcteristic 2 <short_value>
 				gattc disconnect
 TC_GAT_SR_BV_01_C	INC
-TC_GPA_CL_BV_01_C	INC	gatttool required
-TC_GPA_CL_BV_02_C	INC	gatttool required
-TC_GPA_CL_BV_03_C	INC	gatttool required
-TC_GPA_CL_BV_04_C	INC	gatttool required
-TC_GPA_CL_BV_05_C	INC	gatttool required
-TC_GPA_CL_BV_06_C	INC	gatttool required
-TC_GPA_CL_BV_07_C	INC	gatttool required
-TC_GPA_CL_BV_08_C	INC	gatttool required
+TC_GPA_CL_BV_01_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
+TC_GPA_CL_BV_02_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
+TC_GPA_CL_BV_03_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
+TC_GPA_CL_BV_04_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
+TC_GPA_CL_BV_05_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
+TC_GPA_CL_BV_06_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
+TC_GPA_CL_BV_07_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
+TC_GPA_CL_BV_08_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
 TC_GPA_CL_BV_11_C	INC	gatttool required
 TC_GPA_CL_BV_12_C	INC	gatttool required
 TC_GPA_SR_BV_01_C	PASS
@@ -877,10 +943,35 @@ TC_GPA_SR_BV_04_C	PASS	haltest:
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

