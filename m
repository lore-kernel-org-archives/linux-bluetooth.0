Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/6] android/pts: Update GATT results
Date: Thu, 29 May 2014 15:05:04 +0200
Message-Id: <1401368704-4265-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401368704-4265-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401368704-4265-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 2d13330..003b439 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -436,7 +436,10 @@ TC_GAW_CL_BV_03_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic
 				gattc disconnect
-TC_GAW_CL_BI_02_C	INC	gatttool required
+TC_GAW_CL_BI_02_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 225 [u1] 18
+				gattc disconnect
 TC_GAW_CL_BI_03_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -472,7 +475,10 @@ TC_GAW_CL_BV_05_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-TC_GAW_CL_BI_07_C	INC	gatttool required
+TC_GAW_CL_BI_07_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 225 [u1] 22
+				gattc disconnect
 TC_GAW_CL_BI_08_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -515,7 +521,10 @@ TC_GAW_CL_BV_06_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-TC_GAW_CL_BI_14_C	INC	gatttool required
+TC_GAW_CL_BI_14_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 225 [u1] 22
+				gattc disconnect
 TC_GAW_CL_BI_15_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -552,7 +561,10 @@ TC_GAW_CL_BV_08_C	PASS	haltest:
 				gattc get_descriptor
 				gattc write_descriptor 2 <short_value>
 				gattc disconnect
-TC_GAW_CL_BI_20_C	INC	gatttool required
+TC_GAW_CL_BI_20_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 225 [u1] 18
+				gattc disconnect
 TC_GAW_CL_BI_21_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -593,7 +605,10 @@ TC_GAW_CL_BV_09_C	PASS	haltest:
 				gattc get_descriptor
 				gattc write_descriptor 2 <long_value>
 				gattc disconnect
-TC_GAW_CL_BI_25_C	INC	gatttool required
+TC_GAW_CL_BI_25_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 225 [u1] 22
+				gattc disconnect
 TC_GAW_CL_BI_26_C	PASS	haltest:
 				gattc connect
 				gattc search_service
-- 
1.9.3

