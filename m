Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/pts: Update GATT PTS results
Date: Wed, 28 May 2014 11:19:07 +0200
Message-Id: <1401268747-21901-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401268747-21901-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401268747-21901-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 6508ec1..6de65d2 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -227,7 +227,13 @@ TC_GAR_SR_BV_07_C	PASS	haltest:
 				gatts send_response:
 						<data> value greater than MTU
 						repeat with correct offset
-TC_GAR_SR_BV_08_C	INC
+TC_GAR_SR_BV_08_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 2 <permissions> 1
+				gatts add_descriptor: <permissions> 1
+				gatts start_service
+				gatts send_response: repeat with correct offset
 TC_GAR_SR_BI_28_C	INC
 TC_GAR_SR_BI_29_C	PASS	haltest:
 				gatts add_service
-- 
1.9.3

