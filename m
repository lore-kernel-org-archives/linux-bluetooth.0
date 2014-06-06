Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCHv2 2/2] android/pts: Update GATT test result
Date: Fri,  6 Jun 2014 10:35:52 +0200
Message-Id: <1402043752-11390-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1402043752-11390-1-git-send-email-marcin.kraglak@tieto.com>
References: <1402043752-11390-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eva Kolanska <eva.kolanska@tieto.com>

---
 android/pts-gatt.txt | 141 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 125 insertions(+), 16 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index e4d38c0..216449b 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -18,8 +18,17 @@ TC_GAC_CL_BV_01_C	PASS	haltest:
 				gattc search_service
 				gattc get_characteristic
 				gattc write_characteristic: type 3
-TC_GAC_SR_BV_01_C	INC	JIRA: BZ-22
-				PTS issue #12250
+TC_GAC_SR_BV_01_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+					<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+					<data> value greater than MTU
+					repeat with correct offset
+				gatts send_response:
+					<data> value greater than MTU
+					repeat with correct offset
 TC_GAD_CL_BV_01_C	PASS	haltest:
 				gattc register_client
 				gattc scan
@@ -748,7 +757,16 @@ TC_GAW_SR_BI_06_C	PASS	haltest:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_05_C	INC
+TC_GAW_SR_BV_05_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response:
+						repeat with correct value
 TC_GAW_SR_BI_07_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -760,7 +778,15 @@ TC_GAW_SR_BI_08_C	PASS	haltest:
 				gatts add_characteristic:
 						<properties> 2 <permissions> 1
 				gatts start_service
-TC_GAW_SR_BI_09_C	INC
+TC_GAW_SR_BI_09_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 7
 TC_GAW_SR_BI_11_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -788,14 +814,60 @@ TC_GAW_SR_BI_13_C	PASS	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_06_C	INC
-TC_GAW_SR_BV_10_C	INC
-TC_GAW_SR_BI_14_C	INC
-TC_GAW_SR_BI_15_C	INC
-TC_GAW_SR_BI_17_C	INC
-TC_GAW_SR_BI_18_C	INC
-TC_GAW_SR_BI_19_C	INC
-TC_GAW_SR_BV_07_C	INC
+TC_GAW_SR_BV_06_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						repeat with correct value
+TC_GAW_SR_BV_10_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response:
+						repeat with correct value
+TC_GAW_SR_BI_14_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 1
+TC_GAW_SR_BI_15_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 3
+TC_GAW_SR_BI_17_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 8
+TC_GAW_SR_BI_18_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 5
+TC_GAW_SR_BI_19_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 12
+TC_GAW_SR_BV_07_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						repeat with correct value
 TC_GAW_CL_BV_08_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -838,7 +910,18 @@ TC_GAW_SR_BI_24_C	PASS	haltest:
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_09_C	INC
+TC_GAW_SR_BV_09_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response:
+						repeat with correct value
 TC_GAW_SR_BI_25_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -852,7 +935,16 @@ TC_GAW_SR_BI_26_C	PASS	haltest:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 1
 				gatts start_service
-TC_GAW_SR_BI_27_C	INC
+TC_GAW_SR_BI_27_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 1
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 7
 TC_GAW_SR_BI_29_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -881,7 +973,15 @@ TC_GAW_SR_BI_32_C	PASS	haltest:
 				gatts start_service
 				gatts send_response
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_33_C	INC
+TC_GAW_SR_BI_33_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 13
 TC_GAW_SR_BI_34_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -890,7 +990,16 @@ TC_GAW_SR_BI_34_C	PASS	haltest:
 				gatts start_service
 				gatts send_response
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_35_C	INC
+TC_GAW_SR_BI_35_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 13
 TC_GAN_CL_BV_01_C	PASS	haltest:
 				gattc connect
 				gattc search_service
-- 
1.9.3

