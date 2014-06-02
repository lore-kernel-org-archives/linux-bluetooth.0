Return-Path: <cyrus@holtmann.org>
From: Eva Kolanska <eva.kolanska@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCH] android/pts: Update GATT test results
Date: Mon,  2 Jun 2014 15:11:32 +0200
Message-Id: <1401714692-27001-1-git-send-email-eva.kolanska@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 4a650e2..8724532 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -127,7 +127,11 @@ TC_GAR_CL_BI_05_C	PASS	haltest:
 								handle from logs
 				gattc read_characteristic
 				gattc disconnect
-TC_GAR_CL_BV_03_C	INC	JIRA: BZ-31, Possible PTS issue #12227
+TC_GAR_CL_BV_03_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
 TC_GAR_CL_BI_06_C	PASS	haltest:
 				gattc connect
 				test_command: <cmd> 224 [u1] 8
@@ -895,7 +899,17 @@ TC_GAN_CL_BV_01_C	PASS	haltest:
 				gattc get_descriptor
 				gattc write_descriptor 2 <hex_value> 0001
 				gattc disconnect
-TC_GAN_SR_BV_01_C	INC
+TC_GAN_SR_BV_01_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 26 <permissions> 17
+				gatts add_descriptor: <uuid> 2902
+				gatts start_service
+				gatts send_response
+				gatts send_response
+				gatts send_indication:
+						<attr_handle> char value handle
+						<confirm> 0
 TC_GAI_CL_BV_01_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -1011,7 +1025,7 @@ TC_GPA_SR_BV_06_C	PASS	haltest:
 						<properties> 138 <permissions> 17
 				gatts add_descriptor <UUID> 2901
 				gatts start_service
-				gatts send_respons
+				gatts send_response
 TC_GPA_SR_BV_07_C	PASS
 TC_GPA_SR_BV_08_C	PASS	haltest:
 				gatts add_service
@@ -1019,7 +1033,7 @@ TC_GPA_SR_BV_08_C	PASS	haltest:
 						<properties> 138 <permissions> 17
 				gatts add_descriptor <UUID> 2903
 				gatts start_service
-				gatts send_respons
+				gatts send_response
 TC_GPA_SR_BV_11_C	PASS	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
-- 
1.7.9.5

