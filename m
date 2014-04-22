Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 06/11] android/client: Add initial support for health profile
Date: Tue, 22 Apr 2014 15:06:05 +0300
Message-Id: <1398168371-29685-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am      |  1 +
 android/client/haltest.c |  1 +
 android/client/if-bt.c   |  3 +--
 android/client/if-hl.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/client/if-main.h |  2 ++
 5 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 android/client/if-hl.c

diff --git a/android/Makefile.am b/android/Makefile.am
index c51cce2..cf70fab 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -105,6 +105,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/if-hf.c \
 				android/client/if-hh.c \
 				android/client/if-pan.c \
+				android/client/if-hl.c \
 				android/client/if-sock.c \
 				android/client/if-audio.c \
 				android/hardware/hardware.c \
diff --git a/android/client/haltest.c b/android/client/haltest.c
index 114fe31..1bd84e6 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -41,6 +41,7 @@ const struct interface *interfaces[] = {
 	&hf_if,
 	&hh_if,
 	&pan_if,
+	&hl_if,
 	&sock_if,
 	NULL
 };
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 8dcffea..cef124f 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -737,7 +737,6 @@ static void get_profile_interface_p(int argc, const char **argv)
 {
 	const char *id;
 	const void **pif = NULL;
-	const void *dummy = NULL;
 
 	RETURN_IF_NULL(if_bluetooth);
 	if (argc <= 2) {
@@ -752,7 +751,7 @@ static void get_profile_interface_p(int argc, const char **argv)
 	else if (strcmp(BT_PROFILE_ADVANCED_AUDIO_ID, id) == 0)
 		pif = (const void **) &if_av;
 	else if (strcmp(BT_PROFILE_HEALTH_ID, id) == 0)
-		pif = &dummy; /* TODO: change when if_hl is there */
+		pif = (const void **) &if_hl;
 	else if (strcmp(BT_PROFILE_SOCKETS_ID, id) == 0)
 		pif = (const void **) &if_sock;
 	else if (strcmp(BT_PROFILE_HIDHOST_ID, id) == 0)
diff --git a/android/client/if-hl.c b/android/client/if-hl.c
new file mode 100644
index 0000000..5ea29f8
--- /dev/null
+++ b/android/client/if-hl.c
@@ -0,0 +1,64 @@
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
+#include<stdio.h>
+#include<ctype.h>
+
+#include<hardware/bluetooth.h>
+#include<hardware/bt_hl.h>
+
+#include "if-main.h"
+#include "pollhandler.h"
+#include "../hal-utils.h"
+
+const bthl_interface_t *if_hl = NULL;
+
+static bthl_callbacks_t hl_cbacks = {
+	.size = sizeof(hl_cbacks),
+	.app_reg_state_cb = NULL,
+	.channel_state_cb = NULL,
+};
+
+/* init */
+
+static void init_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_hl);
+
+	EXEC(if_hl->init, &hl_cbacks);
+}
+
+/* cleanup */
+
+static void cleanup_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_hl);
+
+	EXECV(if_hl->cleanup);
+	if_hl = NULL;
+}
+
+static struct method methods[] = {
+	STD_METHOD(init),
+	STD_METHOD(cleanup),
+	END_METHOD
+};
+
+const struct interface hl_if = {
+	.name = "hl",
+	.methods = methods
+};
diff --git a/android/client/if-main.h b/android/client/if-main.h
index b628464..8865ffc 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -52,6 +52,7 @@ extern const btrc_interface_t *if_rc;
 extern const bthf_interface_t *if_hf;
 extern const bthh_interface_t *if_hh;
 extern const btpan_interface_t *if_pan;
+extern const bthl_interface_t *if_hl;
 extern const btsock_interface_t *if_sock;
 extern const btgatt_interface_t *if_gatt;
 extern const btgatt_server_interface_t *if_gatt_server;
@@ -77,6 +78,7 @@ extern const struct interface pan_if;
 extern const struct interface sock_if;
 extern const struct interface hf_if;
 extern const struct interface hh_if;
+extern const struct interface hl_if;
 
 /* Interfaces that will show up in tool (first part of command line) */
 extern const struct interface *interfaces[];
-- 
1.8.3.2

