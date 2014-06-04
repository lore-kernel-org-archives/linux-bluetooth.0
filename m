Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/pts: Update GATT results
Date: Wed,  4 Jun 2014 16:36:33 +0200
Message-Id: <1401892593-11586-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401892593-11586-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401892593-11586-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update results for server's Service Changed Indication (CCC) tests.
---
 android/pts-gatt.txt | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 08ade26..e4d38c0 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -918,11 +918,25 @@ TC_GAI_CL_BV_01_C	PASS	haltest:
 				gattc get_descriptor
 				gattc write_descriptor 2 <hex_value> 0002
 				gattc disconnect
-TC_GAI_SR_BV_01_C	INC
+TC_GAI_SR_BV_01_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 42 <permissions> 17
+				gatts add_descriptor: <permissions> 17
+				gatts start_service
+				gatts add_service
+				gatts start_service
 TC_GAS_CL_BV_01_C	PASS	haltest:
 				gattc connect
 				gattc disconnect
-TC_GAS_SR_BV_01_C	INC
+TC_GAS_SR_BV_01_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 42 <permissions> 17
+				gatts add_descriptor: <permissions> 17
+				gatts start_service
+				gatts add_service
+				gatts start_service
 TC_GAT_CL_BV_01_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -937,7 +951,14 @@ TC_GAT_CL_BV_02_C	PASS	haltest:
 								handle from logs
 				gattc write_characcteristic 2 <short_value>
 				gattc disconnect
-TC_GAT_SR_BV_01_C	INC
+TC_GAT_SR_BV_01_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 42 <permissions> 17
+				gatts add_descriptor: <permissions> 17
+				gatts start_service
+				gatts add_service
+				gatts start_service
 TC_GPA_CL_BV_01_C	PASS	haltest:
 				gattc connect
 				test_command: <cmd> 224 [u1] 8
-- 
2.0.0

