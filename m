Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/11] android/test: Add HAL IPC accept test
Date: Tue, 19 Aug 2014 21:51:07 +0200
Message-Id: <1408477872-24160-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
References: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/test-hal-ipc.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/android/test-hal-ipc.c b/android/test-hal-ipc.c
index 22b6072..3321367 100644
--- a/android/test-hal-ipc.c
+++ b/android/test-hal-ipc.c
@@ -32,6 +32,8 @@
 #include <inttypes.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <sys/wait.h>
+#include <errno.h>
 
 #include <glib.h>
 #include "android/ipc-common.h"
@@ -50,6 +52,46 @@ static void test_init(void)
 	hal_ipc_cleanup();
 }
 
+static void connect_hal(void)
+{
+	struct sockaddr_un addr;
+	int sk;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+
+	memcpy(addr.sun_path, HAL_SK_PATH, sizeof(HAL_SK_PATH));
+
+	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
+
+	connect(sk, (struct sockaddr *) &addr, sizeof(addr));
+
+	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
+	connect(sk, (struct sockaddr *) &addr, sizeof(addr));
+}
+
+static void test_accept(void)
+{
+	pid_t pid;
+
+	g_assert(hal_ipc_init(HAL_SK_PATH, sizeof(HAL_SK_PATH)));
+
+	pid = fork();
+	if (pid == 0) {
+		connect_hal();
+
+		exit(0);
+	}
+
+	g_assert(pid > 0);
+
+	g_assert(hal_ipc_accept());
+
+	hal_ipc_cleanup();
+
+	wait(NULL);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -58,6 +100,7 @@ int main(int argc, char *argv[])
 		fclose(stderr);
 
 	g_test_add_func("/android_hal_ipc/init", test_init);
+	g_test_add_func("/android_hal_ipc/accept", test_accept);
 
 	return g_test_run();
 }
-- 
1.9.3

