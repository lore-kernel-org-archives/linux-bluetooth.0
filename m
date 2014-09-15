Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/11] android/hal: Add helper for quering config from Android properties
Date: Mon, 15 Sep 2014 16:49:12 +0200
Message-Id: <1410792555-24765-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
References: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Helper searches config in "persis.sys.bluetooth." and "ro.bluetooth."
namespaces and allows to fallback to custom property if none is
found.
---
 android/client/if-gatt.c    |  2 ++
 android/cutils/properties.h |  1 +
 android/hal-utils.c         | 32 ++++++++++++++++++++++++++++++++
 android/hal-utils.h         |  2 ++
 4 files changed, 37 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 0ceffa6..f021a8b 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -15,6 +15,8 @@
  *
  */
 
+#include <stdbool.h>
+
 #include <hardware/bluetooth.h>
 
 #include "../hal-utils.h"
diff --git a/android/cutils/properties.h b/android/cutils/properties.h
index 43f07f1..0163eb5 100644
--- a/android/cutils/properties.h
+++ b/android/cutils/properties.h
@@ -29,6 +29,7 @@
 #include <sys/un.h>
 
 #define PROPERTY_VALUE_MAX 32
+#define PROPERTY_KEY_MAX 32
 
 #define BLUETOOTH_MODE_PROPERTY_NAME "persist.sys.bluetooth.mode"
 #define BLUETOOTH_MODE_PROPERTY_HANDSFREE "persist.sys.bluetooth.handsfree"
diff --git a/android/hal-utils.c b/android/hal-utils.c
index ceefefc..5b1ebdf 100644
--- a/android/hal-utils.c
+++ b/android/hal-utils.c
@@ -18,6 +18,9 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdint.h>
+#include <stdbool.h>
+
+#include <cutils/properties.h>
 
 #include "hal-utils.h"
 
@@ -328,3 +331,32 @@ const char *btproperty2str(const bt_property_t *property)
 
 	return buf;
 }
+
+#define PROP_PREFIX "persist.sys.bluetooth."
+#define PROP_PREFIX_RO "ro.bluetooth."
+
+int get_config(const char *config_key, char *value, const char *fallback)
+{
+	char key[PROPERTY_KEY_MAX];
+	int ret;
+
+	if (strlen(config_key) + sizeof(PROP_PREFIX) >= sizeof(key))
+		return 0;
+
+	snprintf(key, sizeof(key), PROP_PREFIX"%s", config_key);
+
+	ret = property_get(key, value, "");
+	if (ret > 0)
+		return ret;
+
+	snprintf(key, sizeof(key), PROP_PREFIX_RO"%s", config_key);
+
+	ret = property_get(key, value, "");
+	if (ret > 0)
+		return ret;
+
+	if (!fallback)
+		return 0;
+
+	return property_get(fallback, value, "");
+}
diff --git a/android/hal-utils.h b/android/hal-utils.h
index a0aab57..a2ae0f4 100644
--- a/android/hal-utils.h
+++ b/android/hal-utils.h
@@ -36,6 +36,8 @@ void str2bt_uuid_t(const char *str, bt_uuid_t *uuid);
 const char *btproperty2str(const bt_property_t *property);
 const char *bdaddr2str(const bt_bdaddr_t *bd_addr);
 
+int get_config(const char *config_key, char *value, const char *fallback);
+
 /*
  * Begin mapping section
  *
-- 
1.9.3

