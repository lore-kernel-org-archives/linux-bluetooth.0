Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 6/6] android: Add Android HAL callback task
Date: Mon, 21 Oct 2013 14:28:37 +0300
Message-Id: <1382354917-8632-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1382354917-8632-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382354917-8632-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android HAL callback task listens for messages from BlueZ GPL daemon.
---
 android/Android.mk      |    6 ++++
 android/hal-cb-thread.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 android/hal-cb-thread.c

diff --git a/android/Android.mk b/android/Android.mk
index 786c9fb..c5c6e7b 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -58,9 +58,15 @@ LOCAL_SRC_FILES := \
 	hal-pan.c \
 	hal-msg-client.c \
 	bt-sock.c \
+	hal-cb-thread.c \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
+	libglib \
+
+LOCAL_C_INCLUDES := \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
 
 LOCAL_MODULE := bluetooth.default
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
diff --git a/android/hal-cb-thread.c b/android/hal-cb-thread.c
new file mode 100644
index 0000000..1b1e228
--- /dev/null
+++ b/android/hal-cb-thread.c
@@ -0,0 +1,86 @@
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
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/un.h>
+#include <errno.h>
+#include <sys/epoll.h>
+#include <hardware/bluetooth.h>
+#include <fcntl.h>
+
+#define LOG_TAG "BlueZ"
+#include <cutils/log.h>
+
+#include "hal-msg.h"
+
+#define HAL_CBACK(base, cb_function, ...)				\
+	do {								\
+		if (base && base->cb_function) {			\
+			ALOGI("CB %s->%s", #base, #cb_function);	\
+			base->cb_function(__VA_ARGS__);			\
+		} else {						\
+			ALOGE("%s: Callback is NULL", __func__);	\
+		}							\
+	} while (0)
+
+extern bt_callbacks_t *bt_hal_cbacks;
+
+static int epfd;
+
+static void bthal_thread_associate(void)
+{
+	ALOGI(__func__);
+
+	HAL_CBACK(bt_hal_cbacks, thread_evt_cb, ASSOCIATE_JVM);
+}
+
+static void bthal_thread_disassociate(void)
+{
+	ALOGI(__func__);
+
+	HAL_CBACK(bt_hal_cbacks, thread_evt_cb, DISASSOCIATE_JVM);
+
+	bt_hal_cbacks = NULL;
+}
+
+void process_msg(struct hal_msg_hdr *msg)
+{
+	ALOGI(__func__);
+
+	/* TODO: Process messages from daemon */
+}
+
+int mainloop(void)
+{
+	return EXIT_SUCCESS;
+}
+
+void *hal_cb_task(void *arg)
+{
+	int sock;
+
+	sock = open_hal_chan();
+
+	bthal_thread_associate();
+
+	bthal_thread_disassociate();
+
+	return NULL;
+}
-- 
1.7.10.4

