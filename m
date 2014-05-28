Return-Path: <cyrus@holtmann.org>
From: Eva Kolanska <eva.kolanska@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCH] android/pts: Update GATT Server test results
Date: Wed, 28 May 2014 16:24:48 +0200
Message-Id: <1401287088-1256-1-git-send-email-eva.kolanska@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt |  224 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 193 insertions(+), 31 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 60968e2..a15c1d2 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -286,7 +286,9 @@ TC_GAR_SR_BV_08_C	PASS	haltest:
 						<properties> 2 <permissions> 1
 				gatts add_descriptor: <permissions> 1
 				gatts start_service
-				gatts send_response: repeat with correct offset
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
 TC_GAR_SR_BI_28_C	PASS	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
@@ -579,22 +581,98 @@ TC_GAW_CL_BI_36_C	PASS	haltest:
 				gattc get_descriptor
 				gattc write_descriptor 2 <long_value>
 				gattc disconnect
-TC_GAW_SR_BV_01_C	INC
-TC_GAW_SR_BV_02_C	INC
-TC_GAW_SR_BI_01_C	INC
-TC_GAW_SR_BV_03_C	INC
-TC_GAW_SR_BI_02_C	INC
-TC_GAW_SR_BI_03_C	INC
-TC_GAW_SR_BI_04_C	INC
-TC_GAW_SR_BI_05_C	INC
-TC_GAW_SR_BI_06_C	INC
+TC_GAW_SR_BV_01_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 4 <permissions> 16
+				gatts start_service
+TC_GAW_SR_BV_02_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 68
+						<permissions> 129
+				gatts start_service
+				gatts send_response: repeat with correct <data>
+TC_GAW_SR_BI_01_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 68
+						<permissions> 129
+				gatts start_service
+				gatts send_response: repeat with <data> 1
+TC_GAW_SR_BV_03_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+TC_GAW_SR_BI_02_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 1
+TC_GAW_SR_BI_03_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 1
+				gatts start_service
+TC_GAW_SR_BI_04_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 8
+TC_GAW_SR_BI_05_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 5
+TC_GAW_SR_BI_06_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 12
 TC_GAW_SR_BV_05_C	INC
-TC_GAW_SR_BI_07_C	INC
-TC_GAW_SR_BI_08_C	INC
+TC_GAW_SR_BI_07_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response
+TC_GAW_SR_BI_08_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 2 <permissions> 1
+				gatts start_service
 TC_GAW_SR_BI_09_C	INC
-TC_GAW_SR_BI_11_C	INC
-TC_GAW_SR_BI_12_C	INC
-TC_GAW_SR_BI_13_C	INC
+TC_GAW_SR_BI_11_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 8
+TC_GAW_SR_BI_12_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 5
+TC_GAW_SR_BI_13_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 12
 TC_GAW_SR_BV_06_C	INC
 TC_GAW_SR_BV_10_C	INC
 TC_GAW_SR_BI_14_C	INC
@@ -603,22 +681,95 @@ TC_GAW_SR_BI_17_C	INC
 TC_GAW_SR_BI_18_C	INC
 TC_GAW_SR_BI_19_C	INC
 TC_GAW_SR_BV_07_C	INC
-TC_GAW_CL_BV_08_C	INC
-TC_GAW_SR_BI_20_C	INC
-TC_GAW_SR_BI_21_C	INC
-TC_GAW_SR_BI_22_C	INC
-TC_GAW_SR_BI_23_C	INC
-TC_GAW_SR_BI_24_C	INC
+TC_GAW_CL_BV_08_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response
+TC_GAW_SR_BI_20_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response: <status> 1
+TC_GAW_SR_BI_21_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permmisions> 1
+				gatts start_service
+TC_GAW_SR_BI_22_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response: <status> 8
+
+TC_GAW_SR_BI_23_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response: <status> 5
+TC_GAW_SR_BI_24_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response: <status> 12
 TC_GAW_SR_BV_09_C	INC
-TC_GAW_SR_BI_25_C	INC
+TC_GAW_SR_BI_25_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response: <status> 1
 TC_GAW_SR_BI_26_C	INC
 TC_GAW_SR_BI_27_C	INC
-TC_GAW_SR_BI_29_C	INC
-TC_GAW_SR_BI_30_C	INC
-TC_GAW_SR_BI_31_C	INC
-TC_GAW_SR_BI_32_C	INC
+TC_GAW_SR_BI_29_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response: <status> 8
+TC_GAW_SR_BI_30_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response: <status> 5
+TC_GAW_SR_BI_31_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response: <status> 12
+TC_GAW_SR_BI_32_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response
+				gatts send_response: <status> 13
 TC_GAW_SR_BI_33_C	INC
-TC_GAW_SR_BI_34_C	INC
+TC_GAW_SR_BI_34_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response
+				gatts send_response: <status> 13
 TC_GAW_SR_BI_35_C	INC
 TC_GAN_CL_BV_01_C	INC	PTS issue #12249
 TC_GAN_SR_BV_01_C	INC
@@ -653,10 +804,21 @@ TC_GPA_CL_BV_07_C	INC	gatttool required
 TC_GPA_CL_BV_08_C	INC	gatttool required
 TC_GPA_CL_BV_11_C	INC	gatttool required
 TC_GPA_CL_BV_12_C	INC	gatttool required
-TC_GPA_SR_BV_01_C	INC
-TC_GPA_SR_BV_02_C	INC
-TC_GPA_SR_BV_03_C	INC
-TC_GPA_SR_BV_04_C	INC
+TC_GPA_SR_BV_01_C	PASS
+TC_GPA_SR_BV_02_C	PASS	haltest:
+				gatts add_service
+				gatts start_service
+TC_GPA_SR_BV_03_C	PASS	haltest:
+				gatts add_service
+				gatts add_service
+				add_included_service
+				gatts start_service
+				gatts start_service
+TC_GPA_SR_BV_04_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
 TC_GPA_SR_BV_05_C	INC
 TC_GPA_SR_BV_06_C	INC
 TC_GPA_SR_BV_07_C	INC
-- 
1.7.9.5

