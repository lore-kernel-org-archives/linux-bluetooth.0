Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Aleksander Drewnicki <ext.aleksander.drewnicki@tieto.com>
Subject: [PATCH 07/10] android/client: Add skeleton for mce calls
Date: Thu,  9 Oct 2014 14:45:11 +0200
Message-Id: <1412858714-2845-8-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aleksander Drewnicki <ext.aleksander.drewnicki@tieto.com>

This patch adds skeleton for all methods of mce along with
all callbacks.
---
 android/Android.mk       |  4 +++-
 android/Makefile.am      |  1 +
 android/client/haltest.c |  2 ++
 android/client/if-bt.c   |  3 +++
 android/client/if-main.h |  3 +++
 android/client/if-mce.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 android/client/if-mce.c

diff --git a/android/Android.mk b/android/Android.mk
index a9e5d4b..aefe41c 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -184,7 +184,9 @@ LOCAL_SRC_FILES := \
 	bluez/android/hal-utils.c \
 
 ifeq ($(BLUEZ_EXTENSIONS), true)
-LOCAL_SRC_FILES += bluez/android/client/if-hf-client.c
+LOCAL_SRC_FILES += \
+	bluez/android/client/if-hf-client.c \
+	bluez/android/client/if-mce.c
 endif
 
 LOCAL_C_INCLUDES += \
diff --git a/android/Makefile.am b/android/Makefile.am
index 9279bbd..b3eb1c5 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -125,6 +125,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/if-sock.c \
 				android/client/if-audio.c \
 				android/client/if-sco.c \
+				android/client/if-mce.c \
 				android/hardware/hardware.c \
 				android/hal-utils.h android/hal-utils.c
 android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
diff --git a/android/client/haltest.c b/android/client/haltest.c
index 5e1633d..781e45c 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -50,6 +50,7 @@ const struct interface *interfaces[] = {
 	&sock_if,
 #ifdef BLUEZ_EXTENSIONS
 	&hf_client_if,
+	&mce_if,
 #endif
 	NULL
 };
@@ -397,6 +398,7 @@ static void init(void)
 		BT_PROFILE_SOCKETS_ID,
 #ifdef BLUEZ_EXTENSIONS
 		BT_PROFILE_HANDSFREE_CLIENT_ID,
+		BT_PROFILE_MAP_CLIENT_ID,
 #endif
 	};
 	const struct method *m;
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 8f98ef3..2d7ac79 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -736,6 +736,7 @@ static void get_profile_interface_c(int argc, const char **argv,
 		BT_PROFILE_AV_RC_ID,
 #ifdef BLUEZ_EXTENSIONS
 		BT_PROFILE_HANDSFREE_CLIENT_ID,
+		BT_PROFILE_MAP_CLIENT_ID,
 #endif
 		NULL
 	};
@@ -778,6 +779,8 @@ static void get_profile_interface_p(int argc, const char **argv)
 #ifdef BLUEZ_EXTENSIONS
 	else if (strcmp(BT_PROFILE_HANDSFREE_CLIENT_ID, id) == 0)
 		pif = (const void **) &if_hf_client;
+	else if (strcmp(BT_PROFILE_MAP_CLIENT_ID, id) == 0)
+		pif = (const void **) &if_mce;
 #endif
 	else
 		haltest_error("%s is not correct for get_profile_interface\n",
diff --git a/android/client/if-main.h b/android/client/if-main.h
index 8aac3e3..cb5f558 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -39,6 +39,7 @@
 
 #ifdef BLUEZ_EXTENSIONS
 #include <hardware/bt_hf_client.h>
+#include <hardware/bt_mce.h>
 #endif
 
 #include <hardware/bt_rc.h>
@@ -63,6 +64,7 @@ extern const btgatt_server_interface_t *if_gatt_server;
 extern const btgatt_client_interface_t *if_gatt_client;
 #ifdef BLUEZ_EXTENSIONS
 extern const bthf_client_interface_t *if_hf_client;
+extern const btmce_interface_t *if_mce;
 #endif
 
 /*
@@ -89,6 +91,7 @@ extern const struct interface hh_if;
 extern const struct interface hl_if;
 #ifdef BLUEZ_EXTENSIONS
 extern const struct interface hf_client_if;
+extern const struct interface mce_if;
 #endif
 
 /* Interfaces that will show up in tool (first part of command line) */
diff --git a/android/client/if-mce.c b/android/client/if-mce.c
new file mode 100644
index 0000000..f9ff5f1
--- /dev/null
+++ b/android/client/if-mce.c
@@ -0,0 +1,62 @@
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
+const btmce_interface_t *if_mce = NULL;
+
+/*
+ *  Callback for get_remote_mas_instances
+ */
+static void btmce_remote_mas_instances_cb(bt_status_t status,
+						bt_bdaddr_t *bd_addr,
+						int num_instances,
+						btmce_mas_instance_t *instances)
+{
+}
+
+static btmce_callbacks_t mce_cbacks = {
+	.size = sizeof(mce_cbacks),
+	.remote_mas_instances_cb = btmce_remote_mas_instances_cb,
+};
+
+/* init */
+
+static void init_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_mce);
+
+	EXEC(if_mce->init, &mce_cbacks);
+}
+
+/* search for MAS instances on remote device */
+
+static void get_remote_mas_instances_p(int argc, const char **argv)
+{
+}
+
+static struct method methods[] = {
+	STD_METHOD(init),
+	STD_METHODH(get_remote_mas_instances, "<addr>"),
+	END_METHOD
+};
+
+const struct interface mce_if = {
+	.name = "mce",
+	.methods = methods
+};
-- 
1.9.3

