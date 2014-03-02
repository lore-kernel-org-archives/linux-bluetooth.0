Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 8/8] android/handsfree: Add support for disabling HSP or HFP AGs
Date: Mon,  3 Mar 2014 00:50:49 +0100
Message-Id: <1393804249-12392-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
References: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to tune what profiles are supported by handsfree HAL.
---
 android/cutils/properties.h |  8 ++++++++
 android/hal-handsfree.c     | 15 ++++++++++++++-
 android/hal-msg.h           |  2 ++
 android/handsfree.c         |  4 ++--
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/android/cutils/properties.h b/android/cutils/properties.h
index dff812f..66a4a84 100644
--- a/android/cutils/properties.h
+++ b/android/cutils/properties.h
@@ -27,6 +27,14 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 
+#define PROPERTY_VALUE_MAX 32
+
+static inline int property_get(const char *key, char *value,
+						const char *default_value)
+{
+	return 0;
+}
+
 /* property_set: returns 0 on success, < 0 on failure
 */
 static inline int property_set(const char *key, const char *value)
diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 7a28e0f..4117ed0 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -20,6 +20,8 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include <cutils/properties.h>
+
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
@@ -196,6 +198,17 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	{handle_hsp_key_press, false, 0},
 };
 
+static uint8_t get_mode(void)
+{
+	char value[PROPERTY_VALUE_MAX];
+
+	if (property_get("bluetooth.handsfree_mode", value, "") > 0 &&
+					(!strcasecmp(value, "hsp_only")))
+		return HAL_MODE_HANDSFREE_HSP_ONLY;
+
+	return HAL_MODE_DEFAULT;
+}
+
 static bt_status_t init(bthf_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -212,7 +225,7 @@ static bt_status_t init(bthf_callbacks_t *callbacks)
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_HANDSFREE;
-	cmd.mode = HAL_MODE_DEFAULT;
+	cmd.mode = get_mode();
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8eb97c3..dd25f6e 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -385,6 +385,8 @@ struct hal_cmd_pan_disconnect {
 
 /* Handsfree HAL API */
 
+#define HAL_MODE_HANDSFREE_HSP_ONLY		0x01
+
 #define HAL_OP_HANDSFREE_CONNECT		0x01
 struct hal_cmd_handsfree_connect {
 	uint8_t bdaddr[6];
diff --git a/android/handsfree.c b/android/handsfree.c
index 6149c62..4f69e68 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -820,14 +820,14 @@ static void cleanup_hfp_ag(void)
 
 bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
-	DBG("");
+	DBG("mode 0x%x", mode);
 
 	bacpy(&adapter_addr, addr);
 
 	if (!enable_hsp_ag())
 		return false;
 
-	if (!enable_hfp_ag()) {
+	if (mode != HAL_MODE_HANDSFREE_HSP_ONLY && !enable_hfp_ag()) {
 		cleanup_hsp_ag();
 		return false;
 	}
-- 
1.8.5.3

