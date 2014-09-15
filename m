Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/11] android: Add functions for getting configuration options
Date: Mon, 15 Sep 2014 16:49:08 +0200
Message-Id: <1410792555-24765-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
References: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/main.c  | 29 +++++++++++++++++++++++++++++
 android/utils.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/android/main.c b/android/main.c
index 005f24b..b0df011 100644
--- a/android/main.c
+++ b/android/main.c
@@ -61,6 +61,11 @@
 #include "handsfree.h"
 #include "gatt.h"
 #include "health.h"
+#include "utils.h"
+
+#define DEFAULT_VENDOR "BlueZ"
+#define DEFAULT_MODEL "BlueZ for Android"
+#define DEFAULT_NAME "BlueZ for Android"
 
 #define STARTUP_GRACE_SECONDS 5
 #define SHUTDOWN_GRACE_SECONDS 10
@@ -79,6 +84,30 @@ static struct ipc *hal_ipc = NULL;
 
 static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
 
+const char *bt_config_get_vendor(void)
+{
+	if (config_vendor)
+		return config_vendor;
+
+	return DEFAULT_VENDOR;
+}
+
+const char *bt_config_get_name(void)
+{
+	if (config_name)
+		return config_name;
+
+	return DEFAULT_NAME;
+}
+
+const char *bt_config_get_model(void)
+{
+	if (config_model)
+		return config_model;
+
+	return DEFAULT_MODEL;
+}
+
 static void service_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_register_module *m = buf;
diff --git a/android/utils.h b/android/utils.h
index 560e991..c70f8cb 100644
--- a/android/utils.h
+++ b/android/utils.h
@@ -30,3 +30,7 @@ static inline void bdaddr2android(const bdaddr_t *src, void *buf)
 {
 	baswap(buf, src);
 }
+
+const char *bt_config_get_vendor(void);
+const char *bt_config_get_model(void);
+const char *bt_config_get_name(void);
-- 
1.9.3

