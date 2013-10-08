Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 05/15] android: Start Android Bluetooth daemon
Date: Tue,  8 Oct 2013 13:33:47 +0300
Message-Id: <1381228437-5553-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381228437-5553-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381228437-5553-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Start Android Bluetooth daemon from HAL init(). Make sure
that daemon is in "running" state.
---
 android/hal_bluetooth.c |   50 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
index 00f3e8d..f1e306f 100644
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
 
+#define ANDROID_BLUEZ "bluetoothd"
+
 bt_callbacks_t *bt_hal_cbacks = NULL;
 
 static bool interface_ready(void)
@@ -35,6 +40,42 @@ static bool interface_ready(void)
 	return bt_hal_cbacks != NULL;
 }
 
+static bool is_svc_running(void)
+{
+	char val[PROPERTY_VALUE_MAX];
+	int ret;
+
+	ALOGD(__func__);
+
+	if (property_get("init.svc." ANDROID_BLUEZ, val, NULL)) {
+		if (strcmp(val, "running") == 0)
+			return true;
+	}
+
+	return false;
+}
+
+static bool start_bt_daemon(void)
+{
+	int tries = 40; /* wait 4 seconds for completion */
+
+	ALOGD(__func__);
+
+	/* Start Android Bluetooth daemon service */
+	property_set("ctl.start", ANDROID_BLUEZ);
+
+	while (tries-- > 0) {
+		if (is_svc_running() == true) {
+			ALOGI("Android BlueZ daemon started");
+			return true;
+		}
+
+		usleep(100000);
+	}
+
+	return false;
+}
+
 static bool is_profile(const char *profile, const char *str)
 {
 	return strcmp(profile, str) == 0;
@@ -47,10 +88,13 @@ static int init(bt_callbacks_t *callbacks)
 	if (interface_ready() == true)
 		return BT_STATUS_SUCCESS;
 
-	/* store reference to user callbacks */
-	bt_hal_cbacks = callbacks;
+	if (start_bt_daemon() == true) {
+		/* TODO: open channel */
 
-	/* TODO: Init here bluezd task */
+		bt_hal_cbacks = callbacks;
+
+		return BT_STATUS_SUCCESS;
+	}
 
 	return BT_STATUS_UNSUPPORTED;
 }
-- 
1.7.10.4

