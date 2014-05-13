Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 3/6] android: Add functions for getting configuration options
Date: Tue, 13 May 2014 19:09:18 +0200
Message-Id: <1400000961-24376-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com>
References: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/main.c  | 30 ++++++++++++++++++++++++++++++
 android/utils.h |  5 +++++
 2 files changed, 35 insertions(+)

diff --git a/android/main.c b/android/main.c
index e85f696..bf4235a 100644
--- a/android/main.c
+++ b/android/main.c
@@ -61,6 +61,10 @@
 #include "handsfree.h"
 #include "gatt.h"
 #include "health.h"
+#include "utils.h"
+
+#define DEFAULT_MANUFACTURER_NAME "BlueZ"
+#define DEFAULT_SYSTEM_ID "BlueZ for Android"
 
 #define STARTUP_GRACE_SECONDS 5
 #define SHUTDOWN_GRACE_SECONDS 10
@@ -80,6 +84,32 @@ static struct ipc *hal_ipc = NULL;
 
 static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
 
+const char *bt_config_get_manufacturer(void)
+{
+	if (config_manufacturer)
+		return config_manufacturer;
+
+	return DEFAULT_MANUFACTURER_NAME;
+}
+
+const char *bt_config_get_system_id(void)
+{
+	if (config_system_id)
+		return config_system_id;
+
+	return DEFAULT_SYSTEM_ID;
+}
+
+const char *bt_config_get_model(void)
+{
+	return config_model;
+}
+
+const char *bt_config_get_serial(void)
+{
+	return config_serial;
+}
+
 static void service_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_register_module *m = buf;
diff --git a/android/utils.h b/android/utils.h
index 560e991..e1e791a 100644
--- a/android/utils.h
+++ b/android/utils.h
@@ -30,3 +30,8 @@ static inline void bdaddr2android(const bdaddr_t *src, void *buf)
 {
 	baswap(buf, src);
 }
+
+const char *bt_config_get_manufacturer(void);
+const char *bt_config_get_system_id(void);
+const char *bt_config_get_model(void);
+const char *bt_config_get_serial(void);
-- 
1.9.1

