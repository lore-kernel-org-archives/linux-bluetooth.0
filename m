Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update GATT PTS 6.1 TC_GPA_SR_BV_11_C result
Date: Fri, 24 Apr 2015 19:06:56 +0200
Message-Id: <1429895216-26420-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates GATT PTS 6.1 TC_GPA_SR_BV_11_C result by PTS errata
number and result.
---
 android/pts-gatt.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 0f0b706..29e4761 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -1403,7 +1403,8 @@ TC_GPA_SR_BV_08_C	PASS	haltest:
 				gatts add_descriptor <UUID> 2903
 				gatts start_service
 				gatts send_response
-TC_GPA_SR_BV_11_C	PASS	haltest:
+TC_GPA_SR_BV_11_C	INC	PTS Issue #13392
+				haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 						<properties> 138 <permissions> 17
-- 
2.1.0

