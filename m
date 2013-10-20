Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 4/6] android: Use hal-log.h for logging in pan HAL
Date: Sun, 20 Oct 2013 19:45:44 +0200
Message-Id: <1382291146-23518-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
References: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to log both on Android and Linux (in haltest)
---
 android/hal-pan.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index f63e83d..645fe8c 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -21,9 +21,7 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_pan.h>
 
-#define LOG_TAG "BlueZ"
-#include <cutils/log.h>
-
+#include "hal-log.h"
 #include "hal.h"
 
 const btpan_callbacks_t *bt_pan_cbacks = NULL;
@@ -35,7 +33,7 @@ static bool interface_ready(void)
 
 static bt_status_t bt_pan_enable(int local_role)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -45,7 +43,7 @@ static bt_status_t bt_pan_enable(int local_role)
 
 static int bt_pan_get_local_role(void)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BTPAN_ROLE_NONE;
@@ -56,7 +54,7 @@ static int bt_pan_get_local_role(void)
 static bt_status_t bt_pan_connect(const bt_bdaddr_t *bd_addr, int local_role,
 					int remote_role)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -69,7 +67,7 @@ static bt_status_t bt_pan_connect(const bt_bdaddr_t *bd_addr, int local_role,
 
 static bt_status_t bt_pan_disconnect(const bt_bdaddr_t *bd_addr)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -82,7 +80,7 @@ static bt_status_t bt_pan_disconnect(const bt_bdaddr_t *bd_addr)
 
 static bt_status_t bt_pan_init(const btpan_callbacks_t *callbacks)
 {
-	ALOGI(__func__);
+	DBG("");
 
 	bt_pan_cbacks = callbacks;
 
@@ -95,7 +93,7 @@ static bt_status_t bt_pan_init(const btpan_callbacks_t *callbacks)
 
 static void bt_pan_cleanup()
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return;
-- 
1.8.4

