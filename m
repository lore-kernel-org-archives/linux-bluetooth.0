Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/client: Add a2dp sink support
Date: Mon, 24 Nov 2014 09:46:47 +0100
Message-Id: <1416818807-24433-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416818807-24433-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416818807-24433-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for a2dp sink HAL, which is almost identical to source
role.
---
 android/Android.mk          |   1 +
 android/Makefile.am         |   1 +
 android/client/haltest.c    |   2 +
 android/client/if-av-sink.c | 139 ++++++++++++++++++++++++++++++++++++++++++++
 android/client/if-bt.c      |   3 +
 android/client/if-main.h    |   2 +
 6 files changed, 148 insertions(+)
 create mode 100644 android/client/if-av-sink.c

diff --git a/android/Android.mk b/android/Android.mk
index 1b7b8ef..c0e5fba 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -189,6 +189,7 @@ ifeq ($(ANDROID_GE_5_0_0), 1)
 LOCAL_SRC_FILES += \
 	bluez/android/client/if-hf-client.c \
 	bluez/android/client/if-mce.c \
+	bluez/android/client/if-av-sink.c \
 	bluez/android/client/if-rc-ctrl.c
 endif
 
diff --git a/android/Makefile.am b/android/Makefile.am
index e290740..4f27e03 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -117,6 +117,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/tabcompletion.c \
 				android/client/if-main.h \
 				android/client/if-av.c \
+				android/client/if-av-sink.c \
 				android/client/if-rc.c \
 				android/client/if-rc-ctrl.c \
 				android/client/if-bt.c \
diff --git a/android/client/haltest.c b/android/client/haltest.c
index add1978..72771b3 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -52,6 +52,7 @@ const struct interface *interfaces[] = {
 	&hf_client_if,
 	&mce_if,
 	&ctrl_rc_if,
+	&av_sink_if,
 #endif
 	NULL
 };
@@ -401,6 +402,7 @@ static void init(void)
 		BT_PROFILE_HANDSFREE_CLIENT_ID,
 		BT_PROFILE_MAP_CLIENT_ID,
 		BT_PROFILE_AV_RC_CTRL_ID,
+		BT_PROFILE_ADVANCED_AUDIO_SINK_ID,
 #endif
 	};
 	const struct method *m;
diff --git a/android/client/if-av-sink.c b/android/client/if-av-sink.c
new file mode 100644
index 0000000..3087dcf
--- /dev/null
+++ b/android/client/if-av-sink.c
@@ -0,0 +1,139 @@
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
+#include "if-main.h"
+#include "../hal-utils.h"
+
+const btav_interface_t *if_av_sink = NULL;
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
+	haltest_info("(sink) %s: connection_state=%s remote_bd_addr=%s\n",
+				__func__, btav_connection_state_t2str(state),
+				bt_bdaddr_t2str(bd_addr, last_addr));
+}
+
+static void audio_state(btav_audio_state_t state, bt_bdaddr_t *bd_addr)
+{
+	haltest_info("(sink) %s: audio_state=%s remote_bd_addr=%s\n", __func__,
+					btav_audio_state_t2str(state),
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+
+static void audio_config(bt_bdaddr_t *bd_addr, uint32_t sample_rate,
+							uint8_t channel_count) {
+	haltest_info("(sink) %s: addr=%s\n sample_rate=%d\n channel_count=%d\n",
+				__func__, bt_bdaddr_t2str(bd_addr, last_addr),
+				sample_rate, channel_count);
+}
+
+static btav_callbacks_t av_cbacks = {
+	.size = sizeof(av_cbacks),
+	.connection_state_cb = connection_state,
+	.audio_state_cb = audio_state,
+	.audio_config_cb = audio_config,
+};
+
+/* init */
+
+static void init_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_av_sink);
+
+	EXEC(if_av_sink->init, &av_cbacks);
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
+	RETURN_IF_NULL(if_av_sink);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_av_sink->connect, &addr);
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
+	RETURN_IF_NULL(if_av_sink);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_av_sink->disconnect, &addr);
+}
+
+/* cleanup */
+
+static void cleanup_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_av_sink);
+
+	EXECV(if_av_sink->cleanup);
+	if_av_sink = NULL;
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
+const struct interface av_sink_if = {
+	.name = "av-sink",
+	.methods = methods
+};
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 2b9c455..076482b 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -761,6 +761,7 @@ static void get_profile_interface_c(int argc, const char **argv,
 		BT_PROFILE_HANDSFREE_CLIENT_ID,
 		BT_PROFILE_MAP_CLIENT_ID,
 		BT_PROFILE_AV_RC_CTRL_ID,
+		BT_PROFILE_ADVANCED_AUDIO_SINK_ID,
 #endif
 		NULL
 	};
@@ -807,6 +808,8 @@ static void get_profile_interface_p(int argc, const char **argv)
 		pif = (const void **) &if_hf_client;
 	else if (strcmp(BT_PROFILE_MAP_CLIENT_ID, id) == 0)
 		pif = (const void **) &if_mce;
+	else if (strcmp(BT_PROFILE_ADVANCED_AUDIO_SINK_ID, id) == 0)
+		pif = (const void **) &if_av_sink;
 #endif
 	else
 		haltest_error("%s is not correct for get_profile_interface\n",
diff --git a/android/client/if-main.h b/android/client/if-main.h
index 96409aa..7fc8dad 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -68,6 +68,7 @@ extern const btgatt_client_interface_t *if_gatt_client;
 extern const btrc_ctrl_interface_t *if_rc_ctrl;
 extern const bthf_client_interface_t *if_hf_client;
 extern const btmce_interface_t *if_mce;
+extern const btav_interface_t *if_av_sink;
 #endif
 
 /*
@@ -96,6 +97,7 @@ extern const struct interface hl_if;
 extern const struct interface ctrl_rc_if;
 extern const struct interface hf_client_if;
 extern const struct interface mce_if;
+extern const struct interface av_sink_if;
 #endif
 
 /* Interfaces that will show up in tool (first part of command line) */
-- 
1.9.1

