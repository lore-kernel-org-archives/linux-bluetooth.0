Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 3/6] android: Use hal-log.h for logging in hidhost HAL
Date: Sun, 20 Oct 2013 19:45:43 +0200
Message-Id: <1382291146-23518-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
References: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to log both on Android and Linux (in haltest)
---
 android/hal-hidhost.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 7436864..8c47e27 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -21,9 +21,7 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_hh.h>
 
-#define LOG_TAG "BlueZ"
-#include <cutils/log.h>
-
+#include "hal-log.h"
 #include "hal.h"
 
 bthh_callbacks_t *bt_hh_cbacks;
@@ -35,7 +33,7 @@ static bool interface_ready(void)
 
 static bt_status_t bt_hidhost_connect(bt_bdaddr_t *bd_addr)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -48,7 +46,7 @@ static bt_status_t bt_hidhost_connect(bt_bdaddr_t *bd_addr)
 
 static bt_status_t bt_hidhost_disconnect(bt_bdaddr_t *bd_addr)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -61,7 +59,7 @@ static bt_status_t bt_hidhost_disconnect(bt_bdaddr_t *bd_addr)
 
 static bt_status_t bt_hidhost_virtual_unplug(bt_bdaddr_t *bd_addr)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -75,7 +73,7 @@ static bt_status_t bt_hidhost_virtual_unplug(bt_bdaddr_t *bd_addr)
 static bt_status_t bt_hidhost_set_info(bt_bdaddr_t *bd_addr,
 						bthh_hid_info_t hid_info)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -89,7 +87,7 @@ static bt_status_t bt_hidhost_set_info(bt_bdaddr_t *bd_addr,
 static bt_status_t bt_hidhost_get_protocol(bt_bdaddr_t *bd_addr,
 					bthh_protocol_mode_t protocolMode)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -103,7 +101,7 @@ static bt_status_t bt_hidhost_get_protocol(bt_bdaddr_t *bd_addr,
 static bt_status_t bt_hidhost_set_protocol(bt_bdaddr_t *bd_addr,
 					bthh_protocol_mode_t protocolMode)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -119,7 +117,7 @@ static bt_status_t bt_hidhost_get_report(bt_bdaddr_t *bd_addr,
 						uint8_t reportId,
 						int bufferSize)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -134,7 +132,7 @@ static bt_status_t bt_hidhost_set_report(bt_bdaddr_t *bd_addr,
 						bthh_report_type_t reportType,
 						char *report)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -147,7 +145,7 @@ static bt_status_t bt_hidhost_set_report(bt_bdaddr_t *bd_addr,
 
 static bt_status_t bt_hidhost_send_data(bt_bdaddr_t *bd_addr, char *data)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -160,7 +158,7 @@ static bt_status_t bt_hidhost_send_data(bt_bdaddr_t *bd_addr, char *data)
 
 static bt_status_t bt_hidhost_init(bthh_callbacks_t *callbacks)
 {
-	ALOGI(__func__);
+	DBG("");
 
 	/* store reference to user callbacks */
 	bt_hh_cbacks = callbacks;
@@ -174,7 +172,7 @@ static bt_status_t bt_hidhost_init(bthh_callbacks_t *callbacks)
 
 static void bt_hidhost_cleanup(void)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return;
-- 
1.8.4

