Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCH 3/4] android/pts: Update GATT tests results
Date: Mon, 26 May 2014 17:03:46 +0200
Message-Id: <1401116627-28767-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1401116627-28767-1-git-send-email-szymon.janc@tieto.com>
References: <1401116627-28767-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eva Kolanska <eva.kolanska@tieto.com>

---
 android/pts-gatt.txt | 179 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 152 insertions(+), 27 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 12d9b30..c017751 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -186,7 +186,7 @@ TC_GAW_CL_BV_03_C	PASS 	haltest:
 								handle from logs
 				gattc write_characteristic
 				gattc disconnect
-TC_GAW_CL_BI_02_C	INC
+TC_GAW_CL_BI_02_C	INC	gatttool required
 TC_GAW_CL_BI_03_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -222,7 +222,7 @@ TC_GAW_CL_BV_05_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-TC_GAW_CL_BI_07_C	INC
+TC_GAW_CL_BI_07_C	INC	gatttool required
 TC_GAW_CL_BI_08_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -265,7 +265,7 @@ TC_GAW_CL_BV_06_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-TC_GAW_CL_BI_14_C	INC
+TC_GAW_CL_BI_14_C	INC	gatttool required
 TC_GAW_CL_BI_15_C	PASS	haltest:
 				gattc connect
 				gattc search_service
@@ -273,27 +273,150 @@ TC_GAW_CL_BI_15_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic 2 <long_value>
 				gattc disconnect
-TC_GAW_CL_BI_17_C	INC
-TC_GAW_CL_BI_18_C	INC
-TC_GAW_CL_BI_19_C	INC
-TC_GAW_CL_BV_08_C	INC
-TC_GAW_CL_BI_20_C	INC
-TC_GAW_CL_BI_21_C	INC
-TC_GAW_CL_BI_22_C	INC
-TC_GAW_CL_BI_23_C	INC
-TC_GAW_CL_BI_24_C	INC
-TC_GAW_CL_BV_09_C	INC
-TC_GAW_CL_BI_25_C	INC
-TC_GAW_CL_BI_26_C	INC
-TC_GAW_CL_BI_27_C	INC
-TC_GAW_CL_BI_29_C	INC
-TC_GAW_CL_BI_30_C	INC
-TC_GAW_CL_BI_31_C	INC
-TC_GAW_CL_BI_32_C	INC
-TC_GAW_CL_BI_33_C	INC
-TC_GAW_CL_BI_34_C	INC
-TC_GAW_CL_BI_35_C	INC
-TC_GAW_CL_BI_36_C	INC
+TC_GAW_CL_BI_17_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc write_characteristic 2 <long_value>
+				gattc disconnect
+TC_GAW_CL_BI_18_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc write_characteristic 2 <long_value>
+				gattc disconnect
+TC_GAW_CL_BI_19_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc write_characteristic 2 <long_value>
+				gattc disconnect
+TC_GAW_CL_BV_08_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor
+				gattc write_descriptor 2 <short_value>
+				gattc disconnect
+TC_GAW_CL_BI_20_C	INC	gatttool required
+TC_GAW_CL_BI_21_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor
+				gattc write_descriptor 2 <short_value>
+				gattc disconnect
+TC_GAW_CL_BI_22_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor
+				gattc write_descriptor 2 <short_value>
+				gattc disconnect
+TC_GAW_CL_BI_23_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor
+				gattc write_descriptor 2 <short_value>
+				gattc disconnect
+TC_GAW_CL_BI_24_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor
+				gattc write_descriptor 2 <short_value>
+				gattc disconnect
+TC_GAW_CL_BV_09_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor
+				gattc write_descriptor 2 <long_value>
+				gattc disconnect
+TC_GAW_CL_BI_25_C	INC	gatttool required
+TC_GAW_CL_BI_26_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc write_characteristic 2 <long_value>
+				gattc disconnect
+TC_GAW_CL_BI_27_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc write_characteristic 2 <long_value>
+				gattc disconnect
+TC_GAW_CL_BI_29_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc write_characteristic 2 <long_value>
+				gattc disconnect
+TC_GAW_CL_BI_30_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc write_characteristic 2 <long_value>
+				gattc disconnect
+TC_GAW_CL_BI_31_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc write_characteristic 2 <long_value>
+				gattc disconnect
+TC_GAW_CL_BI_32_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc write_characteristic 2 <long_value>
+				gattc execute_write
+				gattc disconnect
+TC_GAW_CL_BI_33_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc write_characteristic 2
+				gattc disconnect
+TC_GAW_CL_BI_34_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc write_characteristic 2 <long_value>
+				gattc disconnect
+TC_GAW_CL_BI_35_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor
+				gattc write_descriptor 2
+				gattc disconnect
+TC_GAW_CL_BI_36_C	PASS	haltest:
+				gattc connect
+				gattc search_service
+				gattc get_characteristic: srvc_id based on
+								handle from logs
+				gattc get_descriptor
+				gattc write_descriptor 2 <long_value>
+				gattc disconnect
 TC_GAW_SR_BV_01_C	INC
 TC_GAW_SR_BV_02_C	INC
 TC_GAW_SR_BI_01_C	INC
@@ -335,11 +458,13 @@ TC_GAW_SR_BI_32_C	INC
 TC_GAW_SR_BI_33_C	INC
 TC_GAW_SR_BI_34_C	INC
 TC_GAW_SR_BI_35_C	INC
-TC_GAN_CL_BV_01_C	INC
+TC_GAN_CL_BV_01_C	INC	PTS issue will come
 TC_GAN_SR_BV_01_C	INC
-TC_GAI_CL_BV_01_C	INC
+TC_GAI_CL_BV_01_C	INC  	PTS issue #12211
 TC_GAI_SR_BV_01_C	INC
-TC_GAS_CL_BV_01_C	INC
+TC_GAS_CL_BV_01_C	PASS	haltest:
+				gattc connect
+				gattc disconnect
 TC_GAS_SR_BV_01_C	INC
 TC_GAT_CL_BV_01_C	INC
 TC_GAT_CL_BV_02_C	INC
-- 
1.9.1

