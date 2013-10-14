Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Start Android Bluetooth daemon
Date: Mon, 14 Oct 2013 15:56:14 +0300
Message-Id: <1381755374-13510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381485723-15898-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381485723-15898-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Start Android Bluetooth daemon from HAL init(). Make sure
that daemon is in "running" state.
---
 android/hal_bluetooth.c |   41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
index 517f0b4..9bb9dcf 100644
--- a/android/hal_bluetooth.c
+++ b/android/hal_bluetooth.c
@@ -23,11 +23,16 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 
+#include <cutils/sockets.h>
+#include <cutils/properties.h>
+
 #define LOG_TAG "BlueZ"
 #include <cutils/log.h>
 
 #include "hal.h"
 
+#define SERVICE_NAME "bluetoothd"
+
 bt_callbacks_t *bt_hal_cbacks = NULL;
 
 static bool interface_ready(void)
@@ -35,6 +40,33 @@ static bool interface_ready(void)
 	return bt_hal_cbacks != NULL;
 }
 
+static bool start_bt_daemon(void)
+{
+	int tries = 40; /* wait 4 seconds for completion */
+
+	ALOGD(__func__);
+
+	/* Start Android Bluetooth daemon service */
+	property_set("ctl.start", SERVICE_NAME);
+
+	while (tries-- > 0) {
+		char val[PROPERTY_VALUE_MAX];
+
+		if (property_get("init.svc." SERVICE_NAME, val, NULL)) {
+			if (!strcmp(val, "running")) {
+				ALOGI("Android BlueZ daemon started");
+				return true;
+			}
+		} else {
+			return false;
+		}
+
+		usleep(100000);
+	}
+
+	return false;
+}
+
 static int init(bt_callbacks_t *callbacks)
 {
 	ALOGD(__func__);
@@ -42,10 +74,13 @@ static int init(bt_callbacks_t *callbacks)
 	if (interface_ready())
 		return BT_STATUS_SUCCESS;
 
-	/* store reference to user callbacks */
-	bt_hal_cbacks = callbacks;
+	if (start_bt_daemon()) {
+		/* TODO: open channel */
+
+		bt_hal_cbacks = callbacks;
 
-	/* TODO: Init here bluezd task */
+		return BT_STATUS_SUCCESS;
+	}
 
 	return BT_STATUS_UNSUPPORTED;
 }
-- 
1.7.10.4

