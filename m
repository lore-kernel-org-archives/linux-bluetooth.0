Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pts: Update PTS results for GATT
Date: Wed, 23 Jul 2014 11:22:25 +0200
Message-Id: <1406107345-2510-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1406107345-2510-1-git-send-email-marcin.kraglak@tieto.com>
References: <1406107345-2510-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 75 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 14 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 9cf0758..d2a64be 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -1,8 +1,8 @@
 PTS test results for GATT
 
-PTS version: 5.1
-Tested: 19-May-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 22-July-2014
+Android version: 4.4.4
 
 Results:
 PASS	test passed
@@ -18,7 +18,8 @@ TC_GAC_CL_BV_01_C	PASS	haltest:
 				gattc search_service
 				gattc get_characteristic
 				gattc write_characteristic: type 3
-TC_GAC_SR_BV_01_C	PASS	haltest:
+TC_GAC_SR_BV_01_C	FAIL	PTS issue #12357
+				haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 					<properties> 10 <permissions> 17
@@ -117,8 +118,14 @@ TC_GAD_SR_BV_06_C	PASS	haltest:
 				gatts add_service
 				gatts add_included_service
 				gatts start_service
-TC_GAD_SR_BV_07_C	N/A
-TC_GAD_SR_BV_08_C	N/A
+TC_GAD_SR_BV_07_C	PASS	haltest:
+				when requested:
+				bluetooth get_remote_services
+				NOTE: check if found requested service
+TC_GAD_SR_BV_08_C	PASS	haltest:
+				when requested:
+				bluetooth get_remote_services
+				NOTE: check if found requested service
 TC_GAR_CL_BV_01_C	PASS	haltest:
 				gattc read_characteristic
 TC_GAR_CL_BI_01_C	PASS	haltest:
@@ -196,6 +203,8 @@ TC_GAR_CL_BI_25_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_26_C	PASS	haltest:
 				gattc read_descriptor
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAR_CL_BI_27_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -205,6 +214,8 @@ TC_GAR_CL_BI_27_C	PASS	haltest:
 								handle from logs
 				gattc read_descriptor
 				gattc disconnect
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAR_CL_BV_07_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_28_C	PASS	haltest:
@@ -217,6 +228,8 @@ TC_GAR_CL_BI_31_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_32_C	PASS	haltest:
 				gattc read_descriptor
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAR_CL_BI_33_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -226,7 +239,12 @@ TC_GAR_CL_BI_33_C	PASS	haltest:
 								handle from logs
 				gattc read_descriptor
 				gattc disconnect
-TC_GAR_CL_BI_34_C	N/A
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
+TC_GAR_CL_BI_34_C	PASS	haltest:
+				gattc connect
+				gattc test_command 224 <addr> 0 0x0a <handle>
+				gattc disconnect
 TC_GAR_CL_BI_35_C	PASS	haltest:
 				gattc read_characteristic
 TC_GAR_SR_BV_01_C	PASS
@@ -251,7 +269,8 @@ TC_GAR_SR_BI_05_C	PASS	haltest:
 				gatts start_service
 				gatts send_response: <status> 12
 TC_GAR_SR_BV_03_C	PASS
-TC_GAR_SR_BI_06_C	PASS	haltest:
+TC_GAR_SR_BI_06_C	PASS	PTS issue #12346 tested with ETS
+				haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 						<properties> 2 <permissions> 16
@@ -432,8 +451,16 @@ TC_GAR_SR_BI_33_C	PASS	haltest:
 				gatts add_descriptor: <permissions> 1
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAR_SR_BI_34_C	N/A
-TC_GAR_SR_BI_35_C	N/A
+TC_GAR_SR_BI_34_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic
+				gatts start_service
+				gatts send_response <status> 0x80-0x9F
+TC_GAR_SR_BI_35_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic
+				gatts start_service
+				gatts send_response <status> 0x80-0x9F
 TC_GAW_CL_BV_01_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -441,7 +468,7 @@ TC_GAW_CL_BV_01_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic
 				gattc disconnect
-TC_GAW_CL_BV_02_C	PASS	haltest:
+TC_GAW_CL_BV_02_C	INC	haltest:
 				bluetooth create_bond
 				gattc disconnect
 				gattc connect
@@ -482,6 +509,8 @@ TC_GAW_CL_BI_05_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAW_CL_BI_06_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -489,6 +518,8 @@ TC_GAW_CL_BI_06_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAW_CL_BV_05_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -528,6 +559,8 @@ TC_GAW_CL_BI_12_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAW_CL_BI_13_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -535,6 +568,8 @@ TC_GAW_CL_BI_13_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAW_CL_BV_06_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -567,6 +602,8 @@ TC_GAW_CL_BI_18_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAW_CL_BI_19_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -574,6 +611,8 @@ TC_GAW_CL_BI_19_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAW_CL_BV_08_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -610,6 +649,8 @@ TC_GAW_CL_BI_23_C	PASS	haltest:
 				gattc get_descriptor
 				gattc write_descriptor 2 <short_value>
 				gattc disconnect
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAW_CL_BI_24_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -618,6 +659,8 @@ TC_GAW_CL_BI_24_C	PASS	haltest:
 				gattc get_descriptor
 				gattc write_descriptor 2 <short_value>
 				gattc disconnect
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAW_CL_BV_09_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -658,6 +701,8 @@ TC_GAW_CL_BI_30_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAW_CL_BI_31_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -665,6 +710,8 @@ TC_GAW_CL_BI_31_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
+				NOTE: TSPX_delete_ltk must be set to true
+				PTS issue #12371
 TC_GAW_CL_BI_32_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -706,7 +753,7 @@ TC_GAW_CL_BI_36_C	PASS	haltest:
 TC_GAW_SR_BV_01_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
-						<properties> 4 <permissions> 16
+						<properties> 4 <permissions> 17
 				gatts start_service
 TC_GAW_SR_BV_02_C	PASS	haltest:
 				gatts add service
@@ -1006,7 +1053,7 @@ TC_GAN_CL_BV_01_C	PASS	haltest:
 				gattc get_characteristic: srvc_id based on
 								handle from logs
 				gattc get_descriptor
-				gattc write_descriptor 2 <hex_value> 0001
+				gattc write_descriptor 2 <hex_value> 0100
 				gattc disconnect
 TC_GAN_SR_BV_01_C	PASS	haltest:
 				gatts add_service
@@ -1025,7 +1072,7 @@ TC_GAI_CL_BV_01_C	PASS	haltest:
 				gattc get_characteristic: srvc_id based on
 								handle from logs
 				gattc get_descriptor
-				gattc write_descriptor 2 <hex_value> 0002
+				gattc write_descriptor 2 <hex_value> 0200
 				gattc disconnect
 TC_GAI_SR_BV_01_C	PASS	haltest:
 				gatts add_service
-- 
1.9.3

