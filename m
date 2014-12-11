Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/pts: Update gatt server status
Date: Thu, 11 Dec 2014 18:16:53 +0100
Message-Id: <1418318213-23944-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1418318213-23944-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418318213-23944-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index d1cf981..c418282 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -936,7 +936,7 @@ TC_GAW_SR_BI_24_C	PASS	haltest:
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_09_C	FAIL	haltest:
+TC_GAW_SR_BV_09_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -947,20 +947,20 @@ TC_GAW_SR_BV_09_C	FAIL	haltest:
 						repeat with correct offset
 				gatts send_response:
 						repeat with correct value
-TC_GAW_SR_BI_25_C	FAIL	haltest:
+TC_GAW_SR_BI_25_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 1
-TC_GAW_SR_BI_26_C	FAIL	haltest:
+TC_GAW_SR_BI_26_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 1
 				gatts start_service
-TC_GAW_SR_BI_27_C	FAIL	haltest:
+TC_GAW_SR_BI_27_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -970,35 +970,35 @@ TC_GAW_SR_BI_27_C	FAIL	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 7
-TC_GAW_SR_BI_29_C	FAIL	haltest:
+TC_GAW_SR_BI_29_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 8
-TC_GAW_SR_BI_30_C	FAIL	haltest:
+TC_GAW_SR_BI_30_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 5
-TC_GAW_SR_BI_31_C	FAIL	haltest:
+TC_GAW_SR_BI_31_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BI_32_C	FAIL	haltest:
+TC_GAW_SR_BI_32_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_33_C	FAIL	haltest:
+TC_GAW_SR_BI_33_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -1007,7 +1007,7 @@ TC_GAW_SR_BI_33_C	FAIL	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_34_C	FAIL	haltest:
+TC_GAW_SR_BI_34_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -1015,7 +1015,7 @@ TC_GAW_SR_BI_34_C	FAIL	haltest:
 				gatts start_service
 				gatts send_response
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_35_C	FAIL	haltest:
+TC_GAW_SR_BI_35_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
-- 
1.9.1

