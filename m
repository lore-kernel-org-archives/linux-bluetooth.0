Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pts: Update PTS test results for GATT
Date: Thu, 16 Oct 2014 14:41:02 +0200
Message-Id: <1413463262-4090-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1413463262-4090-1-git-send-email-marcin.kraglak@tieto.com>
References: <1413463262-4090-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 74 +++++++++++++++-------------------------------------
 1 file changed, 21 insertions(+), 53 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 9d57007..22e3bdb 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -1,7 +1,7 @@
 PTS test results for GATT
 
-PTS version: 5.2
-Tested: 22-July-2014
+PTS version: 5.3
+Tested: 16-October-2014
 Android version: 4.4.4
 
 Results:
@@ -18,7 +18,8 @@ TC_GAC_CL_BV_01_C	PASS	haltest:
 				gattc search_service
 				gattc get_characteristic
 				gattc write_characteristic: type 3
-TC_GAC_SR_BV_01_C	FAIL	PTS issue #12357
+TC_GAC_SR_BV_01_C	PASS	PTS issue #12357
+				NOTE: tested with ETS attached to errata
 				haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
@@ -47,8 +48,7 @@ TC_GAD_CL_BV_02_C	PASS	haltest:
 				gattc disconnect
 				gattc connect
 				gattc refresh
-TC_GAD_CL_BV_03_C	PASS	haltest:
-				when requested: gattc get_characteristic
+TC_GAD_CL_BV_03_C	FAIL
 TC_GAD_CL_BV_04_C	PASS	haltest:
 				when requested: gattc get_characteristic
 TC_GAD_CL_BV_05_C	PASS	haltest:
@@ -56,8 +56,8 @@ TC_GAD_CL_BV_05_C	PASS	haltest:
 				handle: check from btmon logs
 TC_GAD_CL_BV_06_C	PASS	haltest:
 				when requested: gattc get_descriptor
-TC_GAD_CL_BV_07_C	N/A
-TC_GAD_CL_BV_08_C	N/A
+TC_GAD_CL_BV_07_C	PASS	bluetooth get_remote_services
+TC_GAD_CL_BV_08_C	PASS	bluetooth get_remote_services
 TC_GAD_SR_BV_01_C	PASS	haltest:
 				gattc register_client
 				gattc listen
@@ -173,9 +173,9 @@ TC_GAR_CL_BV_04_C	PASS	haltest:
 TC_GAR_CL_BI_12_C	PASS	haltest:
 				gattc read_characteristic
 TC_GAR_CL_BI_13_C	PASS	haltest:
-				gattc read_characteristic
+				gattc test_command <u1> 0x0c
 TC_GAR_CL_BI_14_C	PASS	haltest:
-				gattc read_characteristic
+				gattc test_command <u1> 0x0a
 TC_GAR_CL_BI_15_C	PASS	haltest:
 				gattc read_characteristic
 TC_GAR_CL_BI_16_C	PASS	haltest:
@@ -203,8 +203,6 @@ TC_GAR_CL_BI_25_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_26_C	PASS	haltest:
 				gattc read_descriptor
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAR_CL_BI_27_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -214,22 +212,19 @@ TC_GAR_CL_BI_27_C	PASS	haltest:
 								handle from logs
 				gattc read_descriptor
 				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAR_CL_BV_07_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_28_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_29_C	PASS	haltest:
-				gattc read_descriptor
+				gattc test_command <u1> 0x0c
+							<u2> handle <u3>offset
 TC_GAR_CL_BI_30_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_31_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_32_C	PASS	haltest:
 				gattc read_descriptor
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAR_CL_BI_33_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -239,8 +234,6 @@ TC_GAR_CL_BI_33_C	PASS	haltest:
 								handle from logs
 				gattc read_descriptor
 				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAR_CL_BI_34_C	PASS	haltest:
 				gattc connect
 				gattc test_command 224 <addr> 0 0x0a <handle>
@@ -269,8 +262,7 @@ TC_GAR_SR_BI_05_C	PASS	haltest:
 				gatts start_service
 				gatts send_response: <status> 12
 TC_GAR_SR_BV_03_C	PASS
-TC_GAR_SR_BI_06_C	PASS	PTS issue #12346 tested with ETS
-				haltest:
+TC_GAR_SR_BI_06_C	PASS	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 						<properties> 2 <permissions> 16
@@ -510,17 +502,12 @@ TC_GAW_CL_BI_05_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAW_CL_BI_06_C	PASS	haltest:
 				gattc connect
 				gattc search_service
 				gattc get_characteristic: srvc_id based on
 								handle from logs
 				gattc write_characteristic 2 <long_value>
-				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAW_CL_BV_05_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -542,9 +529,9 @@ TC_GAW_CL_BI_08_C	PASS	haltest:
 TC_GAW_CL_BI_09_C	PASS	haltest:
 				gattc connect
 				gattc search_service
-				gattc get_characteristic: srvc_id based on
-								handle from logs
-				gattc write_characteristic 2 <long_value>
+				gattc test_command <u1> 0x16 <u2> handle
+							<u3> offset <u4> data
+				gattc test_command <u1> 0x18 <u2> 1
 				gattc disconnect
 TC_GAW_CL_BI_11_C	PASS	haltest:
 				gattc connect
@@ -560,8 +547,6 @@ TC_GAW_CL_BI_12_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAW_CL_BI_13_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -569,14 +554,13 @@ TC_GAW_CL_BI_13_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAW_CL_BV_06_C	PASS	haltest:
 				gattc connect
 				gattc search_service
 				gattc get_characteristic: srvc_id based on
 								handle from logs
-				gattc write_characteristic 2 <long_value>
+				gattc write_characteristic 3
+				gattc execute_write 1
 				gattc disconnect
 TC_GAW_CL_BI_14_C	PASS	haltest:
 				gattc connect
@@ -603,8 +587,6 @@ TC_GAW_CL_BI_18_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAW_CL_BI_19_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -612,8 +594,6 @@ TC_GAW_CL_BI_19_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAW_CL_BV_08_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -650,8 +630,6 @@ TC_GAW_CL_BI_23_C	PASS	haltest:
 				gattc get_descriptor
 				gattc write_descriptor 2 <short_value>
 				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAW_CL_BI_24_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -660,8 +638,6 @@ TC_GAW_CL_BI_24_C	PASS	haltest:
 				gattc get_descriptor
 				gattc write_descriptor 2 <short_value>
 				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAW_CL_BV_09_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -702,8 +678,6 @@ TC_GAW_CL_BI_30_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAW_CL_BI_31_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -711,8 +685,6 @@ TC_GAW_CL_BI_31_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-				NOTE: TSPX_delete_ltk must be set to true
-				PTS issue #12371
 TC_GAW_CL_BI_32_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -759,7 +731,7 @@ TC_GAW_SR_BV_01_C	PASS	haltest:
 TC_GAW_SR_BV_02_C	PASS	haltest:
 				gatts add service
 				gatts add_characteristics:
-					<properties> 66 <permisions> 147
+					<properties> 66 <permisions> 145
 				gatts start_service
 				gattc listen
 				gatts send_response: (twice)
@@ -962,8 +934,7 @@ TC_GAW_SR_BV_09_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
-				gatts add_characteristic:
-						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permissions> 17
 				gatts start_service
 				gatts send_response:
 						<data> value greater than MTU
@@ -1110,7 +1081,7 @@ TC_GAT_CL_BV_02_C	PASS	haltest:
 				gattc disconnect
 TC_GAT_SR_BV_01_C	PASS	haltest:
 				gatts add_service
-				gatts add_chaaracteristic:
+				gatts add_characteristic:
 						<properties> 42 <permissions> 17
 				gatts add_descriptor: <permissions> 17
 				gatts start_service
@@ -1196,14 +1167,12 @@ TC_GPA_SR_BV_05_C	PASS	haltest:
 						<properties> 138 <permissions> 17
 				gatts add_descriptor <UUID> 2900
 				gatts start_service
-				gatts send_response
 TC_GPA_SR_BV_06_C	PASS	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 						<properties> 138 <permissions> 17
 				gatts add_descriptor <UUID> 2901
 				gatts start_service
-				gatts send_response
 TC_GPA_SR_BV_07_C	PASS
 TC_GPA_SR_BV_08_C	PASS	haltest:
 				gatts add_service
@@ -1220,8 +1189,7 @@ TC_GPA_SR_BV_11_C	PASS	haltest:
 				gatts start_service
 				gatts send_response: repeat with correct offset
 								and data
-TC_GPA_SR_BV_12_C	PASS	PTS issue #12262
-				haltest:
+TC_GPA_SR_BV_12_C	PASS	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 						<properties> 10 <permissions> 17
-- 
1.9.3

