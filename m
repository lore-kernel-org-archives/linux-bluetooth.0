Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 04/14] android: Start Android Bluetooth daemon
Date: Thu,  3 Oct 2013 17:38:10 +0300
Message-Id: <1380811100-30144-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380811100-30144-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380811100-30144-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Start Android Bluetooth daemon from HAL init(). Make sure
that daemon is in "running" state.
---
 android/hal_bluetooth.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
index 00f3e8d..f8139a7 100644
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
 
+#define ANDROID_BLUEZ "btd"
+
 bt_callbacks_t *bt_hal_cbacks = NULL;
 
 static bool interface_ready(void)
@@ -35,6 +40,49 @@ static bool interface_ready(void)
 	return bt_hal_cbacks != NULL;
 }
 
+static bool is_running(const char *service_name)
+{
+	char val[PROPERTY_VALUE_MAX];
+	char name[PROPERTY_KEY_MAX];
+	int ret;
+
+	ALOGI(__func__);
+
+	ret = snprintf(name, sizeof(name), "init.svc.%s", service_name);
+	if (ret > PROPERTY_KEY_MAX - 1) {
+		ALOGD("Service name '%s' is too long", service_name);
+		return false;
+	}
+
+	if (property_get(name, val, NULL)) {
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
+	ALOGI(__func__);
+
+	/* Start Android Bluetooth daemon service */
+	property_set("ctl.start", ANDROID_BLUEZ);
+
+	while (tries-- > 0) {
+		if (is_running(ANDROID_BLUEZ) == true) {
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
@@ -50,7 +98,11 @@ static int init(bt_callbacks_t *callbacks)
 	/* store reference to user callbacks */
 	bt_hal_cbacks = callbacks;
 
-	/* TODO: Init here bluezd task */
+	if (start_bt_daemon() == true) {
+		/* TODO: open channel */
+
+		return BT_STATUS_SUCCESS;
+	}
 
 	return BT_STATUS_UNSUPPORTED;
 }
-- 
1.7.10.4

