Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/2] android/pts: Update GATT PTS results
Date: Wed, 28 May 2014 11:18:00 +0200
Message-Id: <1401268680-21765-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401268680-21765-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401268680-21765-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index b5126ee..6508ec1 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -149,9 +149,24 @@ TC_GAR_SR_BI_06_C	PASS	haltest:
 				gatts start_service
 TC_GAR_SR_BI_07_C	PASS
 TC_GAR_SR_BI_08_C	PASS
-TC_GAR_SR_BI_09_C	INC
-TC_GAR_SR_BI_10_C	INC
-TC_GAR_SR_BI_11_C	INC
+TC_GAR_SR_BI_09_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 8
+TC_GAR_SR_BI_10_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 5
+TC_GAR_SR_BI_11_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts start_service
+				gatts send_response: <status> 12
 TC_GAR_SR_BV_04_C	PASS	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
-- 
1.9.3

