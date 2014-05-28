Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 9/9] android/pts: Update GATT PTS test results
Date: Wed, 28 May 2014 16:44:43 +0200
Message-Id: <1401288283-13480-16-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update tests related to write signed
---
 android/pts-gatt.txt | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 60968e2..cd4660d 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -340,7 +340,15 @@ TC_GAW_CL_BV_01_C	PASS 	haltest:
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
 TC_GAW_CL_BV_03_C	PASS 	haltest:
 				gattc connect
 				gattc search_service
@@ -580,7 +588,16 @@ TC_GAW_CL_BI_36_C	PASS	haltest:
 				gattc write_descriptor 2 <long_value>
 				gattc disconnect
 TC_GAW_SR_BV_01_C	INC
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
+
 TC_GAW_SR_BI_01_C	INC
 TC_GAW_SR_BV_03_C	INC
 TC_GAW_SR_BI_02_C	INC
-- 
1.8.4

