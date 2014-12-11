Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update of GATT test results
Date: Thu, 11 Dec 2014 15:16:35 +0100
Message-Id: <1418307395-22214-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index d1cf981..5993f05 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -1060,10 +1060,10 @@ TC_GAI_SR_BV_01_C	PASS	haltest:
 				gatts start_service
 				gatts add_service
 				gatts start_service
-TC_GAS_CL_BV_01_C	FAIL	haltest:
+TC_GAS_CL_BV_01_C	PASS	haltest:
 				gattc connect
 				gattc disconnect
-TC_GAS_SR_BV_01_C	FAIL	haltest:
+TC_GAS_SR_BV_01_C	PASS	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 						<properties> 42 <permissions> 17
-- 
1.9.1

