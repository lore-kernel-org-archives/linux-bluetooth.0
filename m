Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 2/2] android: Add calls to pan methods to haltest
Date: Wed, 23 Oct 2013 10:34:58 +0200
Message-ID: <1382517298-28093-3-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382517298-28093-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382517298-28093-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows to call pan methods in haltest.
---
 Makefile.android         |    2 +
 android/Android.mk       |    1 +
 android/client/haltest.c |    1 +
 android/client/if-bt.c   |    2 +-
 android/client/if-main.h |    2 +
 android/client/if-pan.c  |  209 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 216 insertions(+), 1 deletion(-)
 create mode 100644 android/client/if-pan.c

diff --git a/Makefile.android b/Makefile.android
index 30e9110..0a05e9e 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -50,6 +50,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/tabcompletion.c \
 				android/client/if-bt.c \
 				android/client/if-hh.c \
+				android/client/if-pan.c \
 				android/client/if-sock.c \
 				android/client/hwmodule.c
 
@@ -79,6 +80,7 @@ EXTRA_DIST += android/client/terminal.c \
 		android/client/history.c \
 		android/client/if-bt.c \
 		android/client/if-hh.c \
+		android/client/if-pan.c \
 		android/client/if-sock.c \
 		android/client/textconv.c \
 		android/client/tabcompletion.c \
diff --git a/android/Android.mk b/android/Android.mk
index 7fdd70c..9f91576 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -97,6 +97,7 @@ LOCAL_SRC_FILES := \
 	client/tabcompletion.c \
 	client/if-bt.c \
 	client/if-hh.c \
+	client/if-pan.c \
 	client/if-sock.c \
 
 LOCAL_CFLAGS := -DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
diff --git a/android/client/haltest.c b/android/client/haltest.c
index 49c05e9..7168dfd 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -32,6 +32,7 @@
 const struct interface *interfaces[] = {
 	&bluetooth_if,
 	&hh_if,
+	&pan_if,
 	&sock_if,
 	NULL
 };
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index d90786a..2d9c0b5 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -811,7 +811,7 @@ static void get_profile_interface_p(int argc, const char **argv)
 	else if (strcmp(BT_PROFILE_HIDHOST_ID, id) == 0)
 		pif = (const void **)&if_hh;
 	else if (strcmp(BT_PROFILE_PAN_ID, id) == 0)
-		pif = &dummy; /* TODO: change when if_pan is there */
+		pif = (const void **)&if_pan;
 #if PLATFORM_SDK_VERSION > 17
 	else if (strcmp(BT_PROFILE_AV_RC_ID, id) == 0)
 		pif = &dummy; /* TODO: change when if_rc is there */
diff --git a/android/client/if-main.h b/android/client/if-main.h
index 9c732c1..e214ed0 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -45,6 +45,7 @@
 /* Interfaces from hal that can be populated during application lifetime */
 extern const bt_interface_t *if_bluetooth;
 extern const bthh_interface_t *if_hh;
+extern const btpan_interface_t *if_pan;
 extern const btsock_interface_t *if_sock;
 
 /*
@@ -57,6 +58,7 @@ struct interface {
 };
 
 extern const struct interface bluetooth_if;
+extern const struct interface pan_if;
 extern const struct interface sock_if;
 extern const struct interface hh_if;
 
diff --git a/android/client/if-pan.c b/android/client/if-pan.c
new file mode 100644
index 0000000..fc296a6
--- /dev/null
+++ b/android/client/if-pan.c
@@ -0,0 +1,209 @@
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
+#include <hardware/bluetooth.h>
+
+#include "if-main.h"
+
+const btpan_interface_t *if_pan = NULL;
+
+typedef int btpan_role_t;
+
+SINTMAP(btpan_role_t, -1, "(unknown)")
+	DELEMENT(BTPAN_ROLE_NONE),
+	DELEMENT(BTPAN_ROLE_PANNAP),
+	DELEMENT(BTPAN_ROLE_PANU),
+ENDMAP
+
+SINTMAP(btpan_connection_state_t, -1, "(unknown)")
+	DELEMENT(BTPAN_STATE_CONNECTED),
+	DELEMENT(BTPAN_STATE_CONNECTING),
+	DELEMENT(BTPAN_STATE_DISCONNECTED),
+	DELEMENT(BTPAN_STATE_DISCONNECTING),
+ENDMAP
+
+SINTMAP(btpan_control_state_t, -1, "(unknown)")
+	DELEMENT(BTPAN_STATE_ENABLED),
+	DELEMENT(BTPAN_STATE_DISABLED),
+ENDMAP
+
+static void control_state_cb(btpan_control_state_t state, bt_status_t error,
+					int local_role, const char *ifname)
+{
+	haltest_info("%s: state=%s error=%s local_role=%s ifname=%s\n",
+		       __func__, btpan_control_state_t2str(state),
+		       bt_status_t2str(error), btpan_role_t2str(local_role),
+								       ifname);
+}
+
+static char last_used_addr[18];
+
+static void connection_state_cb(btpan_connection_state_t state,
+				bt_status_t error, const bt_bdaddr_t *bd_addr,
+				int local_role, int remote_role)
+{
+	haltest_info("%s: state=%s error=%s bd_addr=%s local_role=%s remote_role=%s\n",
+			__func__, btpan_connection_state_t2str(state),
+			bt_status_t2str(error),
+			bt_bdaddr_t2str(bd_addr, last_used_addr),
+			btpan_role_t2str(local_role),
+			btpan_role_t2str(remote_role));
+}
+
+static btpan_callbacks_t pan_cbacks = {
+	.size = sizeof(pan_cbacks),
+	.control_state_cb = control_state_cb,
+	.connection_state_cb = connection_state_cb
+};
+
+static void init_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_pan);
+
+	EXEC(if_pan->init, &pan_cbacks);
+}
+
+/* enable */
+
+static void enable_c(int argc, const const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = TYPE_ENUM(btpan_role_t);
+		*penum_func = enum_defines;
+	}
+}
+
+static void enable_p(int argc, const char **argv)
+{
+	int local_role;
+
+	RETURN_IF_NULL(if_pan);
+
+	/* local role */
+	if (argc < 3) {
+		haltest_error("No local mode specified\n");
+		return;
+	}
+	local_role = str2btpan_role_t(argv[2]);
+	if (local_role == -1)
+		local_role = atoi(argv[2]);
+
+	EXEC(if_pan->enable, local_role);
+}
+
+/* get_local_role */
+
+static void get_local_role_p(int argc, const char **argv)
+{
+	int local_role;
+
+	RETURN_IF_NULL(if_pan);
+
+	local_role = if_pan->get_local_role();
+	haltest_info("local_role: %s\n", btpan_role_t2str(local_role));
+}
+
+/* connect */
+
+static void connect_c(int argc, const const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = NULL;
+		*penum_func = enum_devices;
+	} else if (argc == 4 || argc == 5) {
+		*puser = TYPE_ENUM(btpan_role_t);
+		*penum_func = enum_defines;
+	}
+}
+
+static void connect_p(int argc, const char **argv)
+{
+	bt_bdaddr_t addr;
+	int local_role;
+	int remote_role;
+
+	RETURN_IF_NULL(if_pan);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	/* local role */
+	if (argc < 4) {
+		haltest_error("No local mode specified\n");
+		return;
+	}
+	local_role = str2btpan_role_t(argv[3]);
+	if (local_role == -1)
+		local_role = atoi(argv[3]);
+
+	/* remote role */
+	if (argc < 5) {
+		haltest_error("No remote mode specified\n");
+		return;
+	}
+	remote_role = str2btpan_role_t(argv[4]);
+	if (remote_role == -1)
+		remote_role = atoi(argv[4]);
+
+	EXEC(if_pan->connect, &addr, local_role, remote_role);
+}
+
+/* disconnect */
+
+static void disconnect_c(int argc, const const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = last_used_addr;
+		*penum_func = enum_one_string;
+	}
+}
+
+static void disconnect_p(int argc, const char **argv)
+{
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_pan);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_pan->disconnect, &addr);
+}
+
+/* cleanup */
+
+static void cleanup_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_pan);
+
+	EXECV(if_pan->cleanup);
+	if_pan = NULL;
+}
+
+static struct method methods[] = {
+	STD_METHOD(init),
+	STD_METHODCH(connect, "<addr> <local_role> <remote_role>"),
+	STD_METHODCH(enable, "<local_role>"),
+	STD_METHOD(get_local_role),
+	STD_METHODCH(disconnect, "<addr>"),
+	STD_METHOD(cleanup),
+	END_METHOD
+};
+
+const struct interface pan_if = {
+	.name = "pan",
+	.methods = methods
+};
-- 
1.7.9.5

