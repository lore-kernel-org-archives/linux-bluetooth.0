Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Add comments to PTS results for GATT
Date: Wed,  4 Jun 2014 14:06:31 +0200
Message-Id: <1401883591-23242-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 08ade26..8e1ce03 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -748,7 +748,7 @@ TC_GAW_SR_BI_06_C	PASS	haltest:
 						<properties> 10 <permissions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_05_C	INC
+TC_GAW_SR_BV_05_C	INC	JIRA: BZ-35
 TC_GAW_SR_BI_07_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -760,7 +760,7 @@ TC_GAW_SR_BI_08_C	PASS	haltest:
 				gatts add_characteristic:
 						<properties> 2 <permissions> 1
 				gatts start_service
-TC_GAW_SR_BI_09_C	INC
+TC_GAW_SR_BI_09_C	INC	JIRA: BZ-35
 TC_GAW_SR_BI_11_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -788,14 +788,14 @@ TC_GAW_SR_BI_13_C	PASS	haltest:
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
+TC_GAW_SR_BV_06_C	INC	JIRA: BZ-35
+TC_GAW_SR_BV_10_C	INC	JIRA: BZ-35
+TC_GAW_SR_BI_14_C	INC	JIRA: BZ-35
+TC_GAW_SR_BI_15_C	INC	JIRA: BZ-35
+TC_GAW_SR_BI_17_C	INC	JIRA: BZ-35
+TC_GAW_SR_BI_18_C	INC	JIRA: BZ-35
+TC_GAW_SR_BI_19_C	INC	JIRA: BZ-35
+TC_GAW_SR_BV_07_C	INC	JIRA: BZ-35
 TC_GAW_CL_BV_08_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -838,7 +838,7 @@ TC_GAW_SR_BI_24_C	PASS	haltest:
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BV_09_C	INC
+TC_GAW_SR_BV_09_C	INC	JIRA: BZ-35
 TC_GAW_SR_BI_25_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -852,7 +852,7 @@ TC_GAW_SR_BI_26_C	PASS	haltest:
 						<properties> 10 <permissions> 17
 				gatts add_descriptor: <permmisions> 1
 				gatts start_service
-TC_GAW_SR_BI_27_C	INC
+TC_GAW_SR_BI_27_C	INC	JIRA: BZ-35
 TC_GAW_SR_BI_29_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -881,7 +881,7 @@ TC_GAW_SR_BI_32_C	PASS	haltest:
 				gatts start_service
 				gatts send_response
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_33_C	INC
+TC_GAW_SR_BI_33_C	INC	JIRA: BZ-35
 TC_GAW_SR_BI_34_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
@@ -890,7 +890,7 @@ TC_GAW_SR_BI_34_C	PASS	haltest:
 				gatts start_service
 				gatts send_response
 				gatts send_response: <status> 13
-TC_GAW_SR_BI_35_C	INC
+TC_GAW_SR_BI_35_C	INC	JIRA: BZ-35
 TC_GAN_CL_BV_01_C	PASS	haltest:
 				gattc connect
 				gattc search_service
-- 
1.8.5.3

