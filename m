Return-Path: <cyrus@holtmann.org>
From: Eva Kolanska <eva.kolanska@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCH] android/pts: Update GATT test results
Date: Wed,  4 Jun 2014 12:45:35 +0200
Message-Id: <1401878735-32340-1-git-send-email-eva.kolanska@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 8724532..08ade26 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -1040,7 +1040,14 @@ TC_GPA_SR_BV_11_C	PASS	haltest:
 						<properties> 138 <permissions> 17
 				gatts add_descriptor <UUID> 2905
 				gatts start_service
-				gatts send_respons: repeat with correct offset
+				gatts send_response: repeat with correct offset
 								and data
-TC_GPA_SR_BV_12_C	INC
+TC_GPA_SR_BV_12_C	PASS	For this test use build from PTS issue #12262
+				haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 10 <permissions> 17
+				gatts add_descriptor <UUID> 2904
+				gatts start_service
+				gatts send_response: repeat with correct data
 -------------------------------------------------------------------------------
-- 
1.7.9.5

