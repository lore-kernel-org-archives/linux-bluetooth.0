Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Update MAP PICS for Android 5.0
Date: Fri,  5 Dec 2014 15:43:54 +0100
Message-Id: <1417790634-11453-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-map.txt | 4 ++--
 android/pts-map.txt  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/pics-map.txt b/android/pics-map.txt
index 3f783a9..500f690 100644
--- a/android/pics-map.txt
+++ b/android/pics-map.txt
@@ -109,10 +109,10 @@ TSPC_MAP_3_4a	True		MSE: SetMessageStatus (M)
 TSPC_MAP_3_5	True		MSE: Notification Registration (M)
 TSPC_MAP_3_5a	True		MSE: SetNotificationRegistration (M)
 TSPC_MAP_3_6	False		MSE: Supported Message Types
-TSPC_MAP_3_6a	False		MSE: EMAIL (C1)
+TSPC_MAP_3_6a	True		MSE: EMAIL (C1)
 TSPC_MAP_3_6b	True		MSE: SMS_GSM (C1)
 TSPC_MAP_3_6c	False		MSE: SMS_CDMA (C1)
-TSPC_MAP_3_6d	False (*)	MSE: MMS (C1)
+TSPC_MAP_3_6d	True		MSE: MMS (C1)
 TSPC_MAP_3_7	False		MSE: Instance Information (Not Supported)
 TSPC_MAP_3_7a	False (*)	MSE: GetMASInstanceInformation (Not Supported)
 TSPC_MAP_3_8	False		MSE: Extended MAP-Event-Report (Not Supported)
diff --git a/android/pts-map.txt b/android/pts-map.txt
index e8092e2..ebb5ab8 100644
--- a/android/pts-map.txt
+++ b/android/pts-map.txt
@@ -64,8 +64,8 @@ TC_MSE_MMB_BV_09_I	PASS
 TC_MSE_MMB_BV_10_I	PASS
 TC_MSE_MMB_BV_11_I	PASS
 TC_MSE_MMB_BV_20_I	PASS
-TC_MSE_MMB_BV_12_I	N/A
-TC_MSE_MMB_BV_18_I	N/A
+TC_MSE_MMB_BV_12_I	NOT RUN (email)
+TC_MSE_MMB_BV_18_I	NOT RUN (mms)
 TC_MSE_MMB_BV_13_I	PASS
 TC_MSE_MMB_BV_14_I	PASS
 TC_MSE_MMB_BV_15_I	PASS
-- 
1.8.5.3

