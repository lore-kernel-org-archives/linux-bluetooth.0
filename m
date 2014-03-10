Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: AVRCP PTS tests results
Date: Mon, 10 Mar 2014 18:08:26 +0100
Message-Id: <1394471306-13826-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adding PTS tests results, mainly for Volume Level Handling section.
---
 android/pts-avrcp.txt | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
index a6d5222..b6f591b 100644
--- a/android/pts-avrcp.txt
+++ b/android/pts-avrcp.txt
@@ -77,12 +77,16 @@ TC_CT_PTT_BV_04_I	N/A
 TC_CT_PTT_BV_05_I	N/A
 TC_CT_RCR_BV_01_C	N/A
 TC_CT_RCR_BV_03_C	N/A
-TC_CT_VLH_BI_03_C	INC
-TC_CT_VLH_BI_04_C	INC
-TC_CT_VLH_BV_01_C	INC
-TC_CT_VLH_BV_01_I	INC
-TC_CT_VLH_BV_02_I	INC
-TC_CT_VLH_BV_03_C	INC
+TC_CT_VLH_BI_03_C	PASS	Send SetAbsolute Volume command by pressing
+				volume up or down buttons then adb logcat and
+				check VOLUME_CHANGED value
+TC_CT_VLH_BI_04_C	PASS	adb logcat: check VOLUME_CHANGED value
+TC_CT_VLH_BV_01_C	PASS	Send SetAbsolute Volume command by pressing
+				volume up or down buttons
+TC_CT_VLH_BV_01_I	PASS	adb logcat: check VOLUME_CHANGED value
+TC_CT_VLH_BV_02_I	PASS	Send SetAbsolute Volume command by pressing
+				volume up or down buttons
+TC_CT_VLH_BV_03_C	PASS
 -------------------------------------------------------------------------------
 
 
@@ -147,7 +151,7 @@ TC_TG_MCN_SRC_BV_04_C	N/A
 TC_TG_MCN_SRC_BV_04_I	N/A
 TC_TG_MCN_SRC_BV_06_C	N/A
 TC_TG_MDI_BV_02_C	PASS
-TC_TG_MDI_BV_04_C	FAIL
+TC_TG_MDI_BV_04_C	PASS
 TC_TG_MDI_BV_05_C	PASS
 TC_TG_MPS_BI_01_C	N/A
 TC_TG_MPS_BI_02_C	N/A
@@ -184,8 +188,8 @@ TC_TG_PTT_BV_02_I	PASS
 TC_TG_PTT_BV_03_I	N/A
 TC_TG_PTT_BV_04_I	N/A
 TC_TG_PTT_BV_05_I	N/A
-TC_TG_RCR_BV_02_C	INC
-TC_TG_RCR_BV_04_C	INC
+TC_TG_RCR_BV_02_C	PASS
+TC_TG_RCR_BV_04_C	PASS
 TC_TG_VLH_BI_01_C	N/A
 TC_TG_VLH_BI_02_C	N/A
 TC_TG_VLH_BV_01_I	N/A
-- 
1.8.5.3

