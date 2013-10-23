Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android: Add calls to av methods in haltest
Date: Wed, 23 Oct 2013 16:38:25 +0200
Message-ID: <1382539105-10811-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds calls to av interface in haltest.
---
 Makefile.android         |    2 +
 android/Android.mk       |    1 +
 android/client/haltest.c |    1 +
 android/client/if-av.c   |  130 ++++++++++++++++++++++++++++++++++++++++++++++
 android/client/if-main.h |    2 +
 5 files changed, 136 insertions(+)
 create mode 100644 android/client/if-av.c

diff --git a/Makefile.android b/Makefile.android
index a398537..8e09a78 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -49,6 +49,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/history.c \
 				android/client/textconv.c \
 				android/client/tabcompletion.c \
+				android/client/if-av.c \
 				android/client/if-bt.c \
 				android/client/if-hh.c \
 				android/client/if-pan.c \
@@ -79,6 +80,7 @@ EXTRA_DIST += android/client/terminal.c \
 		android/client/hwmodule.c \
 		android/client/pollhandler.c \
 		android/client/history.c \
+		android/client/if-av.c \
 		android/client/if-bt.c \
 		android/client/if-hh.c \
 		android/client/if-pan.c \
diff --git a/android/Android.mk b/android/Android.mk
index dd9c36d..6c73ecb 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -100,6 +100,7 @@ LOCAL_SRC_FILES := \
 	client/history.c \
 	client/textconv.c \
 	client/tabcompletion.c \
+	client/if-av.c \
 	client/if-bt.c \
 	client/if-hh.c \
 	client/if-pan.c \
diff --git a/android/client/haltest.c b/android/client/haltest.c
index 7168dfd..19e81b8 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -31,6 +31,7 @@
 
 const struct interface *interfaces[] = {
 	&bluetooth_if,
+	&av_if,
 	&hh_if,
 	&pan_if,
 	&sock_if,
diff --git a/android/client/if-av.c b/android/client/if-av.c
new file mode 100644
index 0000000..3f133eb
--- /dev/null
+++ b/android/client/if-av.c
@@ -0,0 +1,130 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
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
+#include "if-main.h"
+
+const btav_interface_t *if_av = NULL;
+
+SINTMAP(btav_connection_state_t, -1, "(unknown)")
+	DELEMENT(BTAV_CONNECTION_STATE_DISCONNECTED),
+	DELEMENT(BTAV_CONNECTION_STATE_CONNECTING),
+	DELEMENT(BTAV_CONNECTION_STATE_CONNECTED),
+	DELEMENT(BTAV_CONNECTION_STATE_DISCONNECTING),
+ENDMAP
+
+SINTMAP(btav_audio_state_t, -1, "(unknown)")
+	DELEMENT(BTAV_AUDIO_STATE_REMOTE_SUSPEND),
+	DELEMENT(BTAV_AUDIO_STATE_STOPPED),
+	DELEMENT(BTAV_AUDIO_STATE_STARTED),
+ENDMAP
+
+static char last_addr[MAX_ADDR_STR_LEN];
+
+static void connection_state(btav_connection_state_t state,
+							bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: connection_state=%s remote_bd_addr=%s\n", __func__,
+					btav_connection_state_t2str(state),
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+
+static void audio_state(btav_audio_state_t state, bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: audio_state=%s remote_bd_addr=%s\n", __func__,
+					btav_audio_state_t2str(state),
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+
+static btav_callbacks_t av_cbacks = {
+	.size = sizeof(av_cbacks),
+	.connection_state_cb = connection_state,
+	.audio_state_cb = audio_state
+};
+
+/* init */
+
+static void init_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_av);
+
+	EXEC(if_av->init, &av_cbacks);
+}
+
+/* connect */
+
+static void connect_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3) {
+		*user = NULL;
+		*enum_func = enum_devices;
+	}
+}
+
+static void connect_p(int argc, const char **argv)
+{
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_hh);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_av->connect, &addr);
+}
+
+/* disconnect */
+
+static void disconnect_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3) {
+		*user = last_addr;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void disconnect_p(int argc, const char **argv)
+{
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_hh);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_av->disconnect, &addr);
+}
+
+/* cleanup */
+
+static void cleanup_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_av);
+
+	EXECV(if_av->cleanup);
+	if_av = NULL;
+}
+
+static struct method methods[] = {
+	STD_METHOD(init),
+	STD_METHODCH(connect, "<addr>"),
+	STD_METHODCH(disconnect, "<addr>"),
+	STD_METHOD(cleanup),
+	END_METHOD
+};
+
+const struct interface av_if = {
+	.name = "av",
+	.methods = methods
+};
diff --git a/android/client/if-main.h b/android/client/if-main.h
index e214ed0..f2d35d9 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -44,6 +44,7 @@
 
 /* Interfaces from hal that can be populated during application lifetime */
 extern const bt_interface_t *if_bluetooth;
+extern const btav_interface_t *if_av;
 extern const bthh_interface_t *if_hh;
 extern const btpan_interface_t *if_pan;
 extern const btsock_interface_t *if_sock;
@@ -58,6 +59,7 @@ struct interface {
 };
 
 extern const struct interface bluetooth_if;
+extern const struct interface av_if;
 extern const struct interface pan_if;
 extern const struct interface sock_if;
 extern const struct interface hh_if;
-- 
1.7.9.5

