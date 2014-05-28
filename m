Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/pts: Update GATT PTS results
Date: Wed, 28 May 2014 10:52:27 +0200
Message-Id: <1401267147-18678-1-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401263293-30611-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401263293-30611-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index b5126ee..f9667e2 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -149,9 +149,9 @@ TC_GAR_SR_BI_06_C	PASS	haltest:
 				gatts start_service
 TC_GAR_SR_BI_07_C	PASS
 TC_GAR_SR_BI_08_C	PASS
-TC_GAR_SR_BI_09_C	INC
-TC_GAR_SR_BI_10_C	INC
-TC_GAR_SR_BI_11_C	INC
+TC_GAR_SR_BI_09_C	PASS
+TC_GAR_SR_BI_10_C	PASS
+TC_GAR_SR_BI_11_C	PASS
 TC_GAR_SR_BV_04_C	PASS	haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
-- 
1.9.3

