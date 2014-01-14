Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/8] android/ipc-tester: Add IPC initialization
Date: Tue, 14 Jan 2014 13:14:40 +0100
Message-Id: <1389701685-1861-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389701685-1861-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389701685-1861-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds IPC mechanism initialization.
The deamon is being started and IPC socket connection is established.
---
 android/ipc-negative-tester.c | 122 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/android/ipc-negative-tester.c b/android/ipc-negative-tester.c
index 78ca104..1736794 100644
--- a/android/ipc-negative-tester.c
+++ b/android/ipc-negative-tester.c
@@ -17,6 +17,8 @@
 
 #include <stdlib.h>
 #include <unistd.h>
+#include <errno.h>
+#include <poll.h>
 
 #include <sys/socket.h>
 #include <sys/types.h>
@@ -32,6 +34,8 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/hciemu.h"
 
+#include "hal-msg.h"
+#include <cutils/properties.h>
 
 #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
@@ -44,8 +48,14 @@ struct test_data {
 	pid_t bluetoothd_pid;
 };
 
+#define CONNECT_TIMEOUT (5 * 1000)
+#define SERVICE_NAME "bluetoothd"
+
 static char exec_dir[PATH_MAX + 1];
 
+static int cmd_sk = -1;
+static int notif_sk = -1;
+
 static void read_info_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -240,6 +250,109 @@ failed:
 	close(fd);
 }
 
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
+		tester_warn("Failed to poll: %d (%s)", err, strerror(err));
+		return -errno;
+	}
+
+	if (err == 0) {
+		tester_warn("bluetoothd connect timeout");
+		return -errno;
+	}
+
+	new_sk = accept(sk, NULL, NULL);
+	if (new_sk < 0) {
+		err = errno;
+		tester_warn("Failed to accept socket: %d (%s)",
+							err, strerror(err));
+		return -errno;
+	}
+
+	return new_sk;
+}
+
+static bool init_ipc(void)
+{
+	struct sockaddr_un addr;
+
+	int sk;
+	int err;
+
+	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
+	if (sk < 0) {
+		err = errno;
+		tester_warn("Failed to create socket: %d (%s)", err,
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
+		tester_warn("Failed to bind socket: %d (%s)", err,
+								strerror(err));
+		close(sk);
+		return false;
+	}
+
+	if (listen(sk, 2) < 0) {
+		err = errno;
+		tester_warn("Failed to listen on socket: %d (%s)", err,
+								strerror(err));
+		close(sk);
+		return false;
+	}
+
+	/* Start Android Bluetooth daemon service */
+	if (property_set("ctl.start", SERVICE_NAME) < 0) {
+		tester_warn("Failed to start service %s", SERVICE_NAME);
+		close(sk);
+		return false;
+	}
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
+	tester_print("bluetoothd connected");
+
+	close(sk);
+
+	return true;
+}
+
+static void cleanup_ipc(void)
+{
+	close(cmd_sk);
+	cmd_sk = -1;
+}
+
 static void setup(const void *data)
 {
 	struct test_data *test_data = tester_get_data();
@@ -280,12 +393,21 @@ static void setup(const void *data)
 		tester_setup_failed();
 		return;
 	}
+	if (!init_ipc()) {
+		tester_warn("Cannot initialize IPC mechanism!");
+		tester_setup_failed();
+		return;
+	}
+
+	/* TODO: register modules */
 }
 
 static void teardown(const void *data)
 {
 	struct test_data *test_data = tester_get_data();
 
+	cleanup_ipc();
+
 	if (test_data->bluetoothd_pid)
 		waitpid(test_data->bluetoothd_pid, NULL, 0);
 
-- 
1.8.5.2

