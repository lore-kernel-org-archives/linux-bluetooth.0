Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] android: Make HAL library wait for daemon to connect on init
Date: Sat, 19 Oct 2013 01:01:41 +0200
Message-Id: <1382137302-17237-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1382137302-17237-1-git-send-email-szymon.janc@gmail.com>
References: <1382137302-17237-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

After starting up, daemon is responsible for connecting to HAL library.
If this doesn't happen before timeout occured init will fail.
---
 android/hal-bluetooth.c | 127 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 104 insertions(+), 23 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 2c6c2eb..c91bc98 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -19,6 +19,10 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdbool.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <poll.h>
 
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
@@ -31,41 +35,119 @@
 #include <cutils/log.h>
 
 #include "hal.h"
+#include "hal-msg.h"
 
 #define SERVICE_NAME "bluetoothd"
+#define CONNECT_TIMEOUT (5 * 1000)
 
 bt_callbacks_t *bt_hal_cbacks = NULL;
 
+static int cmd_sk = -1;
+static int notif_sk = -1;
+
 static bool interface_ready(void)
 {
 	return bt_hal_cbacks != NULL;
 }
 
-static bool start_bt_daemon(void)
+static int accept_connection(int sk)
 {
-	int tries = 40; /* wait 4 seconds for completion */
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
+		ALOGE("Failed to poll: %d (%s)", err, strerror(err));
+		return -1;
+	}
 
-	ALOGD(__func__);
+	if (err == 0) {
+		ALOGE("bluetoothd connect timeout");
+		return -1;
+	}
+
+	new_sk = accept(sk, NULL, NULL);
+	if (new_sk < 0) {
+		err = errno;
+		ALOGE("Failed to accept socket: %d (%s)", err, strerror(err));
+		return -1;
+	}
+
+	return new_sk;
+}
+
+static bool start_daemon(void)
+{
+	struct sockaddr_un addr;
+	int sk;
+	int err;
+
+	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
+	if (sk < 0) {
+		err = errno;
+		ALOGE("Failed to create socket: %d (%s)", err,
+							strerror(err));
+		return false;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+
+	/* Use abstract sockets so first byte needs to be \0 */
+	strcpy(addr.sun_path + 1, BLUEZ_HAL_SK_PATH);
+
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		err = errno;
+		ALOGE("Failed to bind socket: %d (%s)", err, strerror(err));
+		close(sk);
+		return false;
+	}
+
+	if (listen(sk, 2) < 0) {
+		err = errno;
+		ALOGE("Failed to listen on socket: %d (%s)", err,
+								strerror(err));
+		close(sk);
+		return false;
+	}
 
 	/* Start Android Bluetooth daemon service */
 	property_set("ctl.start", SERVICE_NAME);
 
-	while (tries-- > 0) {
-		char val[PROPERTY_VALUE_MAX];
-
-		if (property_get("init.svc." SERVICE_NAME, val, NULL)) {
-			if (!strcmp(val, "running")) {
-				ALOGI("Android BlueZ daemon started");
-				return true;
-			}
-		} else {
-			return false;
-		}
+	cmd_sk = accept_connection(sk);
+	if (cmd_sk < 0) {
+		close(sk);
+		return false;
+	}
 
-		usleep(100000);
+	notif_sk = accept_connection(sk);
+	if (notif_sk < 0) {
+		close(sk);
+		close(cmd_sk);
+		cmd_sk = -1;
+		return false;
 	}
 
-	return false;
+	ALOGI("bluetoothd connected");
+
+	close(sk);
+
+	return true;
+}
+
+static void stop_daemon(void)
+{
+	close(cmd_sk);
+	cmd_sk = -1;
+
+	close(notif_sk);
+	notif_sk = 1;
 }
 
 static int init(bt_callbacks_t *callbacks)
@@ -75,15 +157,12 @@ static int init(bt_callbacks_t *callbacks)
 	if (interface_ready())
 		return BT_STATUS_SUCCESS;
 
-	if (start_bt_daemon()) {
-		/* TODO: open channel */
+	if (!start_daemon())
+		return BT_STATUS_FAIL;
 
-		bt_hal_cbacks = callbacks;
+	bt_hal_cbacks = callbacks;
 
-		return BT_STATUS_SUCCESS;
-	}
-
-	return BT_STATUS_UNSUPPORTED;
+	return BT_STATUS_SUCCESS;
 }
 
 static int enable(void)
@@ -110,6 +189,8 @@ static void cleanup(void)
 	if (!interface_ready())
 		return;
 
+	stop_daemon();
+
 	bt_hal_cbacks = NULL;
 }
 
-- 
1.8.4.rc3

