Return-Path: <cyrus@holtmann.org>
From: Eva Kolanska <eva.kolanska@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCH] android/gatt: Update GATT test results
Date: Fri, 30 May 2014 13:51:49 +0200
Message-Id: <1401450709-3180-1-git-send-email-eva.kolanska@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt |   36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 5c8fca9..4a650e2 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -842,7 +842,12 @@ TC_GAW_SR_BI_25_C	PASS	haltest:
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 1
-TC_GAW_SR_BI_26_C	INC
+TC_GAW_SR_BI_26_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 1
+				gatts start_service
 TC_GAW_SR_BI_27_C	INC
 TC_GAW_SR_BI_29_C	PASS	haltest:
 				gatts add_service
@@ -951,8 +956,33 @@ TC_GPA_CL_BV_08_C	PASS	haltest:
 				gattc connect
 				test_command: <cmd> 224 [u1] 8
 				gattc disconnect
-TC_GPA_CL_BV_11_C	INC	gatttool required
-TC_GPA_CL_BV_12_C	INC	gatttool required
+TC_GPA_CL_BV_11_C	PASS	haltest:
+				gattc connect
+				Repeat following steps 5 times:
+				1.Find Characteristic Aggregate Format
+				gattc test_command <cmd> 224 [u1] 8
+				2.Read aggregate descriptor
+				gattc test_command <cmd> 224 [u1] 10
+				3.Read 3 handles from aggregate descriptor
+									value
+				gattc test_command <cmd> 224 [u1] 10
+				4.Compare descriptors values
+				gattc disconnect
+
+TC_GPA_CL_BV_12_C	PASS	haltest:
+				gattc connect
+				Repeat following steps 5 times:
+				1.Find Characteristic Presentation Format
+				gattc test_command <cmd> 224 [u1] 8
+				2.Find characteristic in this range
+				gattc test_command <cmd> 224 <uuid> 2803 [u1] 8
+				3.Read characteristic declaration
+				gattc test_command <cmd> 224 [u1] 10
+				4.Read characteristic value
+				gattc test_command <cmd> 224 [u1] 10
+				5.Compare characteristic value and
+							presentation format
+				gattc disconnect
 TC_GPA_SR_BV_01_C	PASS
 TC_GPA_SR_BV_02_C	PASS	haltest:
 				gatts add_service
-- 
1.7.9.5

