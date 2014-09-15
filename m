Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/11] android: Use helper for accesing Android properties
Date: Mon, 15 Sep 2014 16:49:13 +0200
Message-Id: <1410792555-24765-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
References: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk           |  3 ++-
 android/bluetoothd-wrapper.c | 13 +++++--------
 android/hal-bluetooth.c      | 24 +++++++++---------------
 android/hal-handsfree.c      | 15 +++++++--------
 4 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index b2b55f7..bce1019 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -627,7 +627,8 @@ ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	bluez/android/bluetoothd-wrapper.c
+	bluez/android/bluetoothd-wrapper.c \
+	bluez/android/hal-utils.c
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
diff --git a/android/bluetoothd-wrapper.c b/android/bluetoothd-wrapper.c
index 90ed292..5e15dd8 100644
--- a/android/bluetoothd-wrapper.c
+++ b/android/bluetoothd-wrapper.c
@@ -19,14 +19,11 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <stdbool.h>
 
 #include <cutils/properties.h>
 
-#define PROPERTY_VALGRIND_NAME "persist.sys.bluetooth.valgrind"
-
-#define PROPERTY_DEBUG_NAME "persist.sys.bluetooth.debug"
-
-#define PROPERTY_MGMT_DEBUG_NAME "persist.sys.bluetooth.mgmtdbg"
+#include "hal-utils.h"
 
 #define VALGRIND_BIN "/system/bin/valgrind"
 
@@ -73,17 +70,17 @@ int main(int argc, char *argv[])
 	int debug = 0;
 	int mgmt_dbg = 0;
 
-	if (property_get(PROPERTY_DEBUG_NAME, value, "") > 0 &&
+	if (get_config("debug", value, NULL) > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0))
 			debug = 1;
 
-	if (property_get(PROPERTY_MGMT_DEBUG_NAME, value, "") > 0 &&
+	if (get_config("mgmtdbg", value, NULL) > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0)) {
 			debug = 1;
 			mgmt_dbg = 1;
 	}
 
-	if (property_get(PROPERTY_VALGRIND_NAME, value, "") > 0 &&
+	if (get_config("valgrind", value, NULL) > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0))
 		run_valgrind(debug, mgmt_dbg);
 
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 275ea52..5eac39b 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -29,12 +29,6 @@
 #include "hal-ipc.h"
 #include "hal-utils.h"
 
-#define MODE_PROPERTY_NAME "persist.sys.bluetooth.mode"
-
-#define CONFIG_PROP_VENDOR "ro.product.manufacturer"
-#define CONFIG_PROP_NAME "ro.product.name"
-#define CONFIG_PROP_MODEL "ro.product.model"
-
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
 #define enum_prop_to_hal(prop, hal_prop, type) do { \
@@ -398,13 +392,13 @@ static uint8_t get_mode(void)
 {
 	char value[PROPERTY_VALUE_MAX];
 
-	if (property_get(MODE_PROPERTY_NAME, value, "") > 0 &&
-					(!strcasecmp(value, "bredr")))
-		return HAL_MODE_BREDR;
+	if (get_config("mode", value, NULL) > 0) {
+		if (!strcasecmp(value, "bredr"))
+			return HAL_MODE_BREDR;
 
-	if (property_get(MODE_PROPERTY_NAME, value, "") > 0 &&
-					(!strcasecmp(value, "le")))
-		return HAL_MODE_LE;
+		if (!strcasecmp(value, "le"))
+			return HAL_MODE_LE;
+	}
 
 	return HAL_MODE_DEFAULT;
 }
@@ -417,19 +411,19 @@ static int send_configuration(void)
 
 	cmd->num = 0;
 
-	if (property_get(CONFIG_PROP_VENDOR, prop, NULL) > 0) {
+	if (get_config("vendor", prop, "ro.product.manufacturer") > 0) {
 		strcpy((char *) cmd->props[cmd->num].val, prop);
 		cmd->props[cmd->num].type = HAL_CONFIG_VENDOR;
 		cmd->num++;
 	}
 
-	if (property_get(CONFIG_PROP_NAME, prop, NULL) > 0) {
+	if (get_config("name", prop, "ro.product.name") > 0) {
 		strcpy((char *) cmd->props[cmd->num].val, prop);
 		cmd->props[cmd->num].type = HAL_CONFIG_NAME;
 		cmd->num++;
 	}
 
-	if (property_get(CONFIG_PROP_MODEL, prop, NULL) > 0) {
+	if (get_config("model", prop, "ro.product.model") > 0) {
 		strcpy((char *) cmd->props[cmd->num].val, prop);
 		cmd->props[cmd->num].type = HAL_CONFIG_MODEL;
 		cmd->num++;
diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 986e745..0c51789 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -27,8 +27,7 @@
 #include "hal-msg.h"
 #include "ipc-common.h"
 #include "hal-ipc.h"
-
-#define MODE_PROPERTY_NAME "persist.sys.bluetooth.handsfree"
+#include "hal-utils.h"
 
 static const bthf_callbacks_t *cbs = NULL;
 
@@ -216,13 +215,13 @@ static uint8_t get_mode(void)
 {
 	char value[PROPERTY_VALUE_MAX];
 
-	if (property_get(MODE_PROPERTY_NAME, value, "") > 0 &&
-					(!strcasecmp(value, "hfp")))
-		return HAL_MODE_HANDSFREE_HFP;
+	if (get_config("handsfree", value, NULL) > 0) {
+		if (!strcasecmp(value, "hfp"))
+			return HAL_MODE_HANDSFREE_HFP;
 
-	if (property_get(MODE_PROPERTY_NAME, value, "") > 0 &&
-					(!strcasecmp(value, "hfp_wbs")))
-		return HAL_MODE_HANDSFREE_HFP_WBS;
+		if (!strcasecmp(value, "hfp_wbs"))
+			return HAL_MODE_HANDSFREE_HFP_WBS;
+	}
 
 	return HAL_MODE_HANDSFREE_HSP_ONLY;
 }
-- 
1.9.3

