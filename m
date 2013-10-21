Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 01/11] android/hal: Move IPC and sockets related code to separate file
Date: Mon, 21 Oct 2013 20:56:41 +0200
Message-Id: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hal-ipc will provide functionality related to IPC initialization and
sockets handling (including upcoming callbacks thread).

This allow to remove code from bluetooth HAL not related to adapter.
---
 Makefile.android        |   3 +-
 android/Android.mk      |   1 +
 android/hal-bluetooth.c | 118 ++---------------------------------------
 android/hal-ipc.c       | 137 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-ipc.h       |  19 +++++++
 5 files changed, 163 insertions(+), 115 deletions(-)
 create mode 100644 android/hal-ipc.c
 create mode 100644 android/hal-ipc.h

diff --git a/Makefile.android b/Makefile.android
index f5a5834..c2010b3 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -33,7 +33,8 @@ android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hardware/bt_sock.h \
 					android/hardware/hardware.h \
 					android/cutils/properties.h \
-					android/hal-log.h
+					android/hal-log.h \
+					android/hal-ipc.h android/hal-ipc.c
 
 android_libhal_internal_la_CPPFLAGS = -I$(srcdir)/android
 
diff --git a/android/Android.mk b/android/Android.mk
index 87445ed..bd3d48a 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -51,6 +51,7 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
+	hal-ipc.c \
 	hal-bluetooth.c \
 	hal-sock.c \
 	hal-hidhost.c \
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 589cb1b..b9a78b6 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -17,136 +17,26 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <stdbool.h>
-#include <errno.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <poll.h>
+#include <string.h>
 
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
 #include <hardware/bt_pan.h>
 
-#include <cutils/properties.h>
-
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
-
-#define SERVICE_NAME "bluetoothd"
-#define CONNECT_TIMEOUT (5 * 1000)
+#include "hal-ipc.h"
 
 bt_callbacks_t *bt_hal_cbacks = NULL;
 
-static int cmd_sk = -1;
-static int notif_sk = -1;
-
 static bool interface_ready(void)
 {
 	return bt_hal_cbacks != NULL;
 }
 
-static int accept_connection(int sk)
-{
-	int err;
-	struct pollfd pfd;
-	int new_sk;
-
-	memset(&pfd, 0 , sizeof(pfd));
-	pfd.fd = sk;
-	pfd.events = POLLIN;
-
-	err = poll(&pfd, 1, CONNECT_TIMEOUT);
-	if (err < 0) {
-		err = errno;
-		error("Failed to poll: %d (%s)", err, strerror(err));
-		return -1;
-	}
-
-	if (err == 0) {
-		error("bluetoothd connect timeout");
-		return -1;
-	}
-
-	new_sk = accept(sk, NULL, NULL);
-	if (new_sk < 0) {
-		err = errno;
-		error("Failed to accept socket: %d (%s)", err, strerror(err));
-		return -1;
-	}
-
-	return new_sk;
-}
-
-static bool start_daemon(void)
-{
-	struct sockaddr_un addr;
-	int sk;
-	int err;
-
-	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
-	if (sk < 0) {
-		err = errno;
-		error("Failed to create socket: %d (%s)", err,
-							strerror(err));
-		return false;
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sun_family = AF_UNIX;
-
-	memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
-
-	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = errno;
-		error("Failed to bind socket: %d (%s)", err, strerror(err));
-		close(sk);
-		return false;
-	}
-
-	if (listen(sk, 2) < 0) {
-		err = errno;
-		error("Failed to listen on socket: %d (%s)", err,
-								strerror(err));
-		close(sk);
-		return false;
-	}
-
-	/* Start Android Bluetooth daemon service */
-	property_set("ctl.start", SERVICE_NAME);
-
-	cmd_sk = accept_connection(sk);
-	if (cmd_sk < 0) {
-		close(sk);
-		return false;
-	}
-
-	notif_sk = accept_connection(sk);
-	if (notif_sk < 0) {
-		close(sk);
-		close(cmd_sk);
-		cmd_sk = -1;
-		return false;
-	}
-
-	info("bluetoothd connected");
-
-	close(sk);
-
-	return true;
-}
-
-static void stop_daemon(void)
-{
-	close(cmd_sk);
-	cmd_sk = -1;
-
-	close(notif_sk);
-	notif_sk = -1;
-}
-
 static int init(bt_callbacks_t *callbacks)
 {
 	DBG("");
@@ -154,7 +44,7 @@ static int init(bt_callbacks_t *callbacks)
 	if (interface_ready())
 		return BT_STATUS_SUCCESS;
 
-	if (!start_daemon())
+	if (!hal_ipc_init())
 		return BT_STATUS_FAIL;
 
 	bt_hal_cbacks = callbacks;
@@ -186,7 +76,7 @@ static void cleanup(void)
 	if (!interface_ready())
 		return;
 
-	stop_daemon();
+	hal_ipc_cleanup();
 
 	bt_hal_cbacks = NULL;
 }
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
new file mode 100644
index 0000000..6db67f2
--- /dev/null
+++ b/android/hal-ipc.c
@@ -0,0 +1,137 @@
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
+#include <pthread.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <poll.h>
+#include <unistd.h>
+#include <stdint.h>
+
+#include <cutils/properties.h>
+
+#include "hal-msg.h"
+#include "hal-log.h"
+#include "hal-ipc.h"
+
+#define CONNECT_TIMEOUT (5 * 1000)
+#define SERVICE_NAME "bluetoothd"
+
+static int cmd_sk = -1;
+static int notif_sk = -1;
+
+static int accept_connection(int sk)
+{
+	int err;
+	struct pollfd pfd;
+	int new_sk;
+
+	memset(&pfd, 0 , sizeof(pfd));
+	pfd.fd = sk;
+	pfd.events = POLLIN;
+
+	err = poll(&pfd, 1, CONNECT_TIMEOUT);
+	if (err < 0) {
+		err = errno;
+		error("Failed to poll: %d (%s)", err, strerror(err));
+		return -1;
+	}
+
+	if (err == 0) {
+		error("bluetoothd connect timeout");
+		return -1;
+	}
+
+	new_sk = accept(sk, NULL, NULL);
+	if (new_sk < 0) {
+		err = errno;
+		error("Failed to accept socket: %d (%s)", err, strerror(err));
+		return -1;
+	}
+
+	return new_sk;
+}
+
+bool hal_ipc_init(void)
+{
+	struct sockaddr_un addr;
+	int sk;
+	int err;
+
+	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
+	if (sk < 0) {
+		err = errno;
+		error("Failed to create socket: %d (%s)", err,
+							strerror(err));
+		return false;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+
+	memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
+
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		err = errno;
+		error("Failed to bind socket: %d (%s)", err, strerror(err));
+		close(sk);
+		return false;
+	}
+
+	if (listen(sk, 2) < 0) {
+		err = errno;
+		error("Failed to listen on socket: %d (%s)", err,
+								strerror(err));
+		close(sk);
+		return false;
+	}
+
+	/* Start Android Bluetooth daemon service */
+	property_set("ctl.start", SERVICE_NAME);
+
+	cmd_sk = accept_connection(sk);
+	if (cmd_sk < 0) {
+		close(sk);
+		return false;
+	}
+
+	notif_sk = accept_connection(sk);
+	if (notif_sk < 0) {
+		close(sk);
+		close(cmd_sk);
+		cmd_sk = -1;
+		return false;
+	}
+
+	info("bluetoothd connected");
+
+	close(sk);
+
+	return true;
+}
+
+void hal_ipc_cleanup(void)
+{
+	close(cmd_sk);
+	cmd_sk = -1;
+
+	close(notif_sk);
+	notif_sk = -1;
+}
diff --git a/android/hal-ipc.h b/android/hal-ipc.h
new file mode 100644
index 0000000..2f71668
--- /dev/null
+++ b/android/hal-ipc.h
@@ -0,0 +1,19 @@
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
+bool hal_ipc_init(void);
+void hal_ipc_cleanup(void);
-- 
1.8.4

