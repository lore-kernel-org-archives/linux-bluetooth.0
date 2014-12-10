Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/3] android/pts: Update gatt serwer results
Date: Wed, 10 Dec 2014 13:40:51 +0100
Message-Id: <1418215251-24018-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1418215251-24018-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418215251-24018-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 43e1c8a..d1cf981 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -783,7 +783,7 @@ TC_GAW_SR_BI_06_C	PASS	haltest:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_05_C	FAIL	haltest:
+TC_GAW_SR_BV_05_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -793,18 +793,18 @@ TC_GAW_SR_BV_05_C	FAIL	haltest:
 						repeat with correct offset
 				gatts send_response:
 						repeat with correct value
-TC_GAW_SR_BI_07_C	FAIL	haltest:
+TC_GAW_SR_BI_07_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response
-TC_GAW_SR_BI_08_C	FAIL	haltest:
+TC_GAW_SR_BI_08_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 2 <permissions> 1
 				gatts start_service
-TC_GAW_SR_BI_09_C	FAIL	haltest:
+TC_GAW_SR_BI_09_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -813,7 +813,7 @@ TC_GAW_SR_BI_09_C	FAIL	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 7
-TC_GAW_SR_BI_11_C	FAIL	haltest:
+TC_GAW_SR_BI_11_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -822,7 +822,7 @@ TC_GAW_SR_BI_11_C	FAIL	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 8
-TC_GAW_SR_BI_12_C	FAIL	haltest:
+TC_GAW_SR_BI_12_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -831,7 +831,7 @@ TC_GAW_SR_BI_12_C	FAIL	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 5
-TC_GAW_SR_BI_13_C	FAIL	haltest:
+TC_GAW_SR_BI_13_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -840,14 +840,14 @@ TC_GAW_SR_BI_13_C	FAIL	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_06_C	FAIL	haltest:
+TC_GAW_SR_BV_06_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response:
 						repeat with correct value
-TC_GAW_SR_BV_10_C	FAIL	haltest:
+TC_GAW_SR_BV_10_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
@@ -857,37 +857,37 @@ TC_GAW_SR_BV_10_C	FAIL	haltest:
 						repeat with correct offset
 				gatts send_response:
 						repeat with correct value
-TC_GAW_SR_BI_14_C	FAIL	haltest:
+TC_GAW_SR_BI_14_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 1
-TC_GAW_SR_BI_15_C	FAIL	haltest:
+TC_GAW_SR_BI_15_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 3
-TC_GAW_SR_BI_17_C	FAIL	haltest:
+TC_GAW_SR_BI_17_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 8
-TC_GAW_SR_BI_18_C	FAIL	haltest:
+TC_GAW_SR_BI_18_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 5
-TC_GAW_SR_BI_19_C	FAIL	haltest:
+TC_GAW_SR_BI_19_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_07_C	FAIL	haltest:
+TC_GAW_SR_BV_07_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 10 <permissions> 17
-- 
1.9.1

