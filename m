Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 09/10] android/pts: Update GATT PTS test results
Date: Thu, 29 May 2014 15:49:43 +0200
Message-Id: <1401371384-10427-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401371384-10427-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401371384-10427-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update tests related to write signed
---
 android/pts-gatt.txt | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 46bdc32..e1a90f1 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -428,7 +428,15 @@ TC_GAW_CL_BV_01_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic
 				gattc disconnect
-TC_GAW_CL_BV_02_C	INC
+TC_GAW_CL_BV_02_C	PASS	haltest:
+				bluetooth create_bond
+				gattc disconnect
+				gattc connect
+				gattc search_service
+				gattc get_characteristics
+				gattc write_characteristics: <type> 4
+				gattc disconnect
+
 TC_GAW_CL_BV_03_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -672,7 +680,15 @@ TC_GAW_SR_BV_01_C	PASS	haltest:
 				gatts add_characteristic:
 						<properties> 4 <permissions> 16
 				gatts start_service
-TC_GAW_SR_BV_02_C	INC
+TC_GAW_SR_BV_02_C	PASS	haltest:
+				gatts add service
+				gatts add_characteristics:
+					<properties> 66 <permisions> 147
+				gatts start_service
+				gattc listen
+				gatts send_response: (twice)
+				NOTE: gatts_request_write_cb shall be called
+								 (verify it)
 TC_GAW_SR_BI_01_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
-- 
1.8.4

