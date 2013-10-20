Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 5/6] android: Use hal-log.h for logging in socket HAL
Date: Sun, 20 Oct 2013 19:45:45 +0200
Message-Id: <1382291146-23518-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
References: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to log both on Android and Linux (in haltest)
---
 android/hal-sock.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/android/hal-sock.c b/android/hal-sock.c
index 31e6b59..dab3756 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -20,16 +20,14 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 
-#define LOG_TAG "BlueZ"
-#include <cutils/log.h>
-
+#include "hal-log.h"
 #include "hal.h"
 
 static bt_status_t btsock_listen_rfcomm(const char *service_name,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	return BT_STATUS_UNSUPPORTED;
 }
@@ -39,20 +37,20 @@ static bt_status_t listen(btsock_type_t type, const char *service_name,
 					int *sock, int flags)
 {
 	if ((!uuid && chan <= 0) || !sock) {
-		ALOGE("%s: invalid params: uuid %p, chan %d, sock %p",
+		error("%s: invalid params: uuid %p, chan %d, sock %p",
 						__func__, uuid, chan, sock);
 		return BT_STATUS_PARM_INVALID;
 	}
 
-	ALOGD("%s: uuid %p chan %d sock %p type %d service_name %s",
-			__func__, uuid, chan, sock, type, service_name);
+	DBG("uuid %p chan %d sock %p type %d service_name %s",
+					uuid, chan, sock, type, service_name);
 
 	switch (type) {
 	case BTSOCK_RFCOMM:
 		return btsock_listen_rfcomm(service_name, uuid, chan,
 								sock, flags);
 	default:
-		ALOGE("%s: Socket type %d not supported", __func__, type);
+		error("%s: Socket type %d not supported", __func__, type);
 		break;
 	}
 
@@ -64,13 +62,12 @@ static bt_status_t connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 					int *sock, int flags)
 {
 	if ((!uuid && chan <= 0) || !bdaddr || !sock) {
-		ALOGE("invalid params: bd_addr %p, uuid %p, chan %d, sock %p",
+		error("invalid params: bd_addr %p, uuid %p, chan %d, sock %p",
 					bdaddr, uuid, chan, sock);
 		return BT_STATUS_PARM_INVALID;
 	}
 
-	ALOGD("%s: uuid %p chan %d sock %p type %d", __func__, uuid, chan,
-								sock, type);
+	DBG("uuid %p chan %d sock %p type %d", uuid, chan, sock, type);
 
 	return BT_STATUS_UNSUPPORTED;
 }
-- 
1.8.4

