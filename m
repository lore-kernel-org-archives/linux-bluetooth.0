Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 2/2] android/client: Create separate file for AVRCP CTRL
Date: Tue, 18 Nov 2014 15:34:43 +0200
Message-Id: <1416317683-15258-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1416317683-15258-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1416317683-15258-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moving AVRCP CTRL interface client related code to if-rc-ctrl.c.
---
 android/Android.mk          |   3 +-
 android/Makefile.am         |   1 +
 android/client/haltest.c    |   2 +
 android/client/if-rc-ctrl.c | 112 ++++++++++++++++++++++++++++++++++++++++++++
 android/client/if-rc.c      |  88 ----------------------------------
 5 files changed, 117 insertions(+), 89 deletions(-)
 create mode 100644 android/client/if-rc-ctrl.c

diff --git a/android/Android.mk b/android/Android.mk
index 2d3403a..5495fd5 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -186,7 +186,8 @@ LOCAL_SRC_FILES := \
 ifeq ($(ANDROID_GE_5_0_0), 1)
 LOCAL_SRC_FILES += \
 	bluez/android/client/if-hf-client.c \
-	bluez/android/client/if-mce.c
+	bluez/android/client/if-mce.c \
+	bluez/android/client/if-rc-ctrl.c
 endif
 
 LOCAL_C_INCLUDES += \
diff --git a/android/Makefile.am b/android/Makefile.am
index d807aaa..3787489 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -116,6 +116,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/if-main.h \
 				android/client/if-av.c \
 				android/client/if-rc.c \
+				android/client/if-rc-ctrl.c \
 				android/client/if-bt.c \
 				android/client/if-gatt.c \
 				android/client/if-hf.c \
diff --git a/android/client/haltest.c b/android/client/haltest.c
index c8cfdc4..add1978 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -51,6 +51,7 @@ const struct interface *interfaces[] = {
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 	&hf_client_if,
 	&mce_if,
+	&ctrl_rc_if,
 #endif
 	NULL
 };
@@ -399,6 +400,7 @@ static void init(void)
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 		BT_PROFILE_HANDSFREE_CLIENT_ID,
 		BT_PROFILE_MAP_CLIENT_ID,
+		BT_PROFILE_AV_RC_CTRL_ID,
 #endif
 	};
 	const struct method *m;
diff --git a/android/client/if-rc-ctrl.c b/android/client/if-rc-ctrl.c
new file mode 100644
index 0000000..52573a0
--- /dev/null
+++ b/android/client/if-rc-ctrl.c
@@ -0,0 +1,112 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <stdio.h>
+#include <ctype.h>
+#include <string.h>
+
+#include <hardware/bluetooth.h>
+#include <hardware/bt_rc.h>
+
+#include "if-main.h"
+#include "pollhandler.h"
+#include "../hal-utils.h"
+
+const btrc_ctrl_interface_t *if_rc_ctrl = NULL;
+static char last_addr[MAX_ADDR_STR_LEN];
+
+static void passthrough_rsp_cb(int id, int key_state)
+{
+	haltest_info("%s: id=%d key_state=%d\n", __func__, id, key_state);
+}
+
+static void connection_state_cb(bool state, bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: state=%s bd_addr=%s\n", __func__,
+					state ? "true" : "false",
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+
+static btrc_ctrl_callbacks_t rc_ctrl_cbacks = {
+	.size = sizeof(rc_ctrl_cbacks),
+	.passthrough_rsp_cb = passthrough_rsp_cb,
+	.connection_state_cb = connection_state_cb,
+};
+
+/* init */
+
+static void init_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_rc_ctrl);
+
+	EXEC(if_rc_ctrl->init, &rc_ctrl_cbacks);
+}
+
+/* cleanup */
+
+static void cleanup_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_rc_ctrl);
+
+	EXECV(if_rc_ctrl->cleanup);
+	if_rc_ctrl = NULL;
+}
+
+/* send_pass_through_cmd */
+
+static void send_pass_through_cmd_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+}
+
+static void send_pass_through_cmd_p(int argc, const char **argv)
+{
+	bt_bdaddr_t addr;
+	uint8_t key_code, key_state;
+
+	RETURN_IF_NULL(if_rc);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	if (argc <= 4) {
+		haltest_error("No key code specified");
+		return;
+	}
+
+	key_code = (uint8_t) atoi(argv[3]);
+
+	if (argc <= 5) {
+		haltest_error("No key state specified");
+		return;
+	}
+
+	key_state = (uint8_t) atoi(argv[4]);
+
+	EXEC(if_rc_ctrl->send_pass_through_cmd, &addr, key_code, key_state);
+}
+
+static struct method methods[] = {
+	STD_METHOD(init),
+	STD_METHODCH(send_pass_through_cmd,
+					"<bd_addr> <key_code> <key_state>"),
+	STD_METHOD(cleanup),
+	END_METHOD
+};
+
+const struct interface ctrl_rc_if = {
+	.name = "rc-ctrl",
+	.methods = methods
+};
diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index b42b8c6..ed65600 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -28,10 +28,6 @@
 
 const btrc_interface_t *if_rc = NULL;
 
-#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
-const btrc_ctrl_interface_t *if_rc_ctrl = NULL;
-#endif
-
 SINTMAP(btrc_play_status_t, -1, "(unknown)")
 	DELEMENT(BTRC_PLAYSTATE_STOPPED),
 	DELEMENT(BTRC_PLAYSTATE_PLAYING),
@@ -402,87 +398,3 @@ const struct interface rc_if = {
 	.name = "rc",
 	.methods = methods
 };
-
-#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
-static void passthrough_rsp_cb(int id, int key_state)
-{
-	haltest_info("%s: id=%d key_state=%d\n", __func__, id, key_state);
-}
-
-static void connection_state_cb(bool state, bt_bdaddr_t *bd_addr)
-{
-	haltest_info("%s: state=%s bd_addr=%s\n", __func__,
-					state ? "true" : "false",
-					bt_bdaddr_t2str(bd_addr, last_addr));
-}
-
-static btrc_ctrl_callbacks_t rc_ctrl_cbacks = {
-	.size = sizeof(rc_ctrl_cbacks),
-	.passthrough_rsp_cb = passthrough_rsp_cb,
-	.connection_state_cb = connection_state_cb,
-};
-
-/* ctrl_init */
-
-static void ctrl_init_p(int argc, const char **argv)
-{
-	RETURN_IF_NULL(if_rc_ctrl);
-
-	EXEC(if_rc_ctrl->init, &rc_ctrl_cbacks);
-}
-
-/* ctrl_cleanup */
-
-static void ctrl_cleanup_p(int argc, const char **argv)
-{
-	RETURN_IF_NULL(if_rc_ctrl);
-
-	EXECV(if_rc_ctrl->cleanup);
-	if_rc_ctrl = NULL;
-}
-
-/* send_pass_through_cmd */
-
-static void send_pass_through_cmd_c(int argc, const char **argv,
-					enum_func *enum_func, void **user)
-{
-}
-
-static void send_pass_through_cmd_p(int argc, const char **argv)
-{
-	bt_bdaddr_t addr;
-	uint8_t key_code, key_state;
-
-	RETURN_IF_NULL(if_rc);
-	VERIFY_ADDR_ARG(2, &addr);
-
-	if (argc <= 4) {
-		haltest_error("No key code specified");
-		return;
-	}
-
-	key_code = (uint8_t) atoi(argv[3]);
-
-	if (argc <= 5) {
-		haltest_error("No key state specified");
-		return;
-	}
-
-	key_state = (uint8_t) atoi(argv[4]);
-
-	EXEC(if_rc_ctrl->send_pass_through_cmd, &addr, key_code, key_state);
-}
-
-static struct method ctrl_methods[] = {
-	STD_METHOD(ctrl_init),
-	STD_METHODCH(send_pass_through_cmd,
-					"<bd_addr> <key_code> <key_state>"),
-	STD_METHOD(ctrl_cleanup),
-	END_METHOD
-};
-
-const struct interface ctrl_rc_if = {
-	.name = "rc-ctrl",
-	.methods = ctrl_methods
-};
-#endif
-- 
2.1.0

