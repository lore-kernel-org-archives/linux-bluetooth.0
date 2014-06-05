Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCH 2/2] android/pts: Update GATT test result
Date: Thu,  5 Jun 2014 18:32:35 +0200
Message-Id: <1401985955-13502-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401985955-13502-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401985955-13502-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eva Kolanska <eva.kolanska@tieto.com>

---
 android/pts-gatt.txt | 128 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 114 insertions(+), 14 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 08ade26..3f986ee 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -748,7 +748,16 @@ TC_GAW_SR_BI_06_C	PASS	haltest:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_05_C	INC
+TC_GAW_SR_BV_05_C       PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response:
+						repeat with correct value
 TC_GAW_SR_BI_07_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -760,7 +769,15 @@ TC_GAW_SR_BI_08_C	PASS	haltest:
 				gatts add_characteristic:
 						<properties> 2 <permissions> 1
 				gatts start_service
-TC_GAW_SR_BI_09_C	INC
+TC_GAW_SR_BI_09_C       PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 7
 TC_GAW_SR_BI_11_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -788,14 +805,60 @@ TC_GAW_SR_BI_13_C	PASS	haltest:
 						<data> value greater than MTU
 						repeat with correct offset
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_06_C	INC
-TC_GAW_SR_BV_10_C	INC
-TC_GAW_SR_BI_14_C	INC
-TC_GAW_SR_BI_15_C	INC
-TC_GAW_SR_BI_17_C	INC
-TC_GAW_SR_BI_18_C	INC
-TC_GAW_SR_BI_19_C	INC
-TC_GAW_SR_BV_07_C	INC
+TC_GAW_SR_BV_06_C       PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						repeat with correct value
+TC_GAW_SR_BV_10_C       PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response:
+						repeat with correct value
+TC_GAW_SR_BI_14_C       PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 1
+TC_GAW_SR_BI_15_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 3
+TC_GAW_SR_BI_17_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 8
+TC_GAW_SR_BI_18_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 5
+TC_GAW_SR_BI_19_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response: <status> 12
+TC_GAW_SR_BV_07_C       PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						repeat with correct value
 TC_GAW_CL_BV_08_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -838,7 +901,18 @@ TC_GAW_SR_BI_24_C	PASS	haltest:
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_09_C	INC
+TC_GAW_SR_BV_09_C        PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response:
+						repeat with correct value
 TC_GAW_SR_BI_25_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -852,7 +926,16 @@ TC_GAW_SR_BI_26_C	PASS	haltest:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 1
 				gatts start_service
-TC_GAW_SR_BI_27_C	INC
+TC_GAW_SR_BI_27_C       PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 1
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 7
 TC_GAW_SR_BI_29_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -881,7 +964,15 @@ TC_GAW_SR_BI_32_C	PASS	haltest:
 				gatts start_service
 				gatts send_response
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_33_C	INC
+TC_GAW_SR_BI_33_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 13
 TC_GAW_SR_BI_34_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -890,7 +981,16 @@ TC_GAW_SR_BI_34_C	PASS	haltest:
 				gatts start_service
 				gatts send_response
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_35_C	INC
+TC_GAW_SR_BI_35_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor: <permmisions> 17
+				gatts start_service
+				gatts send_response:
+						<data> value greater than MTU
+						repeat with correct offset
+				gatts send_response: <status> 13
 TC_GAN_CL_BV_01_C	PASS	haltest:
 				gattc connect
 				gattc search_service
-- 
1.9.0

