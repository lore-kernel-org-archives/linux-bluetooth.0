Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pts: Update AVRCP PTS 6.0 results for android 5.0
Date: Wed, 21 Jan 2015 16:35:44 +0100
Message-Id: <1421854544-17726-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1421854544-17726-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1421854544-17726-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test case list and results for AVRCP profile against
android 5.0.
---
 android/pts-avrcp.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
index e6711ed..955b37e 100644
--- a/android/pts-avrcp.txt
+++ b/android/pts-avrcp.txt
@@ -1,7 +1,7 @@
 PTS test results for AVRCP
 
-PTS version: 5.3
-Tested: 20-November-2014
+PTS version: 6.0
+Tested: 21-January-2015
 Android version: 5.0
 
 Results:
@@ -83,10 +83,11 @@ TC_CT_VLH_BI_03_C	PASS	Send SetAbsolute Volume command by pressing
 TC_CT_VLH_BI_04_C	PASS	adb logcat: check VOLUME_CHANGED value
 TC_CT_VLH_BV_01_C	PASS	Send SetAbsolute Volume command by pressing
 				volume up or down buttons
-TC_CT_VLH_BV_01_I	PASS	adb logcat: check VOLUME_CHANGED value
-TC_CT_VLH_BV_02_I	PASS	Send SetAbsolute Volume command by pressing
+TC_CT_VLH_BV_03_C	PASS	adb logcat: check VOLUME_CHANGED value
+TC_CT_VLH_BV_01_I	PASS	Send SetAbsolute Volume command by pressing
+				volume up or down buttons
+TC_CT_VLH_BV_02_I	PASS 	Send SetAbsolute Volume command by pressing
 				volume up or down buttons
-TC_CT_VLH_BV_03_C	PASS
 -------------------------------------------------------------------------------
 
 
@@ -188,8 +189,10 @@ TC_TG_PTT_BV_02_I	PASS
 TC_TG_PTT_BV_03_I	N/A
 TC_TG_PTT_BV_04_I	N/A
 TC_TG_PTT_BV_05_I	N/A
-TC_TG_RCR_BV_02_C	PASS	One can use: lame --ta/tl for creating metadata
-TC_TG_RCR_BV_04_C	PASS
+TC_TG_RCR_BV_02_C	PASS	Use modified media metadata (artist, title,
+					album etc.) to be larger than 512 byte.
+TC_TG_RCR_BV_04_C	PASS	Use modified media metadata (artist, title,
+					album etc.) to be larger than 512 byte.
 TC_TG_VLH_BI_01_C	N/A
 TC_TG_VLH_BI_02_C	N/A
 TC_TG_VLH_BV_01_I	N/A
-- 
1.9.3

