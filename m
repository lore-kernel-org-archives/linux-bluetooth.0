Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update GATT test results and notes
Date: Thu,  5 Mar 2015 09:21:12 +0100
Message-Id: <1425543672-4292-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 145e21f..cbb5cee 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -18,7 +18,8 @@ TC_GAC_CL_BV_01_C	PASS	haltest:
 				gattc search_service
 				gattc get_characteristic
 				gattc write_characteristic: type 3
-TC_GAC_SR_BV_01_C	FAIL	PTS issue #13073
+TC_GAC_SR_BV_01_C	PASS	PTS issue #13073
+				TSE #6271
 				haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
@@ -992,7 +993,7 @@ TC_GAW_SR_BI_31_C	PASS	haltest:
 				gatts add_descriptor: <permmisions> 17
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAW_SR_BI_32_C	FAIL	PTS issue #12823
+TC_GAW_SR_BI_32_C	PASS	PTS issue #12823
 				haltest:
 				gatts add_service
 				gatts add_characteristic:
-- 
1.9.1

