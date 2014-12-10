Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/3] android/pts: Update gatt server results
Date: Wed, 10 Dec 2014 10:57:06 +0100
Message-Id: <1418205428-6122-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patches fixing this issues were already merged.
---
 android/pts-gatt.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 167a6dc..43e1c8a 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -729,12 +729,12 @@ TC_GAW_CL_BI_36_C	PASS	haltest:
 				gattc get_descriptor
 				gattc write_descriptor 2 <long_value>
 				gattc disconnect
-TC_GAW_SR_BV_01_C	FAIL	haltest:
+TC_GAW_SR_BV_01_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 4 <permissions> 17
 				gatts start_service
-TC_GAW_SR_BV_02_C	FAIL	haltest:
+TC_GAW_SR_BV_02_C	PASS	haltest:
 				gatts add service
 				gatts add_characteristics:
 					<properties> 66 <permisions> 145
@@ -743,7 +743,7 @@ TC_GAW_SR_BV_02_C	FAIL	haltest:
 				gatts send_response: (twice)
 				NOTE: gatts_request_write_cb shall be called
 								 (verify it)
-TC_GAW_SR_BI_01_C	FAIL	haltest:
+TC_GAW_SR_BI_01_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 68
-- 
1.9.1

