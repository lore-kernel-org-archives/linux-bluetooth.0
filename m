Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/11] android/test: Add HAL IPC disconnect tests
Date: Tue, 19 Aug 2014 21:51:09 +0200
Message-Id: <1408477872-24160-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
References: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/test-hal-ipc.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 5 deletions(-)

diff --git a/android/test-hal-ipc.c b/android/test-hal-ipc.c
index b4cf071..bc86a3e 100644
--- a/android/test-hal-ipc.c
+++ b/android/test-hal-ipc.c
@@ -34,15 +34,51 @@
 #include <sys/un.h>
 #include <sys/wait.h>
 #include <errno.h>
+#include <pthread.h>
 
 #include <glib.h>
 #include "android/ipc-common.h"
 #include "android/hal-ipc.h"
 
 static const char HAL_SK_PATH[] = "\0test_hal_ipc_socket";
+static int cmd_sk = -1;
+static int notif_sk = -1;
+
+static void disconnect_hal(bool cmd_first)
+{
+	int sk1, sk2;
+
+	if (cmd_first) {
+		sk1 = cmd_sk;
+		sk2 = notif_sk;
+	} else {
+		sk1 = notif_sk;
+		sk2 = cmd_sk;
+	}
+
+	if (sk1 >= 0) {
+		shutdown(sk1, SHUT_RDWR);
+		close(sk1);
+	}
+
+	if (sk2 >= 0) {
+		shutdown(sk2, SHUT_RDWR);
+		close(sk2);
+	}
+
+	cmd_sk = -1;
+	notif_sk = -1;
+}
+
+static void cleanup_hal(void)
+{
+	disconnect_hal(true);
+}
 
 static void test_init(void)
 {
+	cleanup_hal();
+
 	g_assert(hal_ipc_init(HAL_SK_PATH, sizeof(HAL_SK_PATH)));
 
 	hal_ipc_cleanup();
@@ -55,25 +91,26 @@ static void test_init(void)
 static void connect_hal(void)
 {
 	struct sockaddr_un addr;
-	int sk;
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;
 
 	memcpy(addr.sun_path, HAL_SK_PATH, sizeof(HAL_SK_PATH));
 
-	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
+	cmd_sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
 
-	connect(sk, (struct sockaddr *) &addr, sizeof(addr));
+	connect(cmd_sk, (struct sockaddr *) &addr, sizeof(addr));
 
-	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
-	connect(sk, (struct sockaddr *) &addr, sizeof(addr));
+	notif_sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
+	connect(notif_sk, (struct sockaddr *) &addr, sizeof(addr));
 }
 
 static void test_accept(void)
 {
 	pid_t pid;
 
+	cleanup_hal();
+
 	g_assert(hal_ipc_init(HAL_SK_PATH, sizeof(HAL_SK_PATH)));
 
 	pid = fork();
@@ -127,6 +164,73 @@ static void test_thread_cb(void)
 	thread_cb_cnt = 0;
 }
 
+static pthread_mutex_t cv_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t cv = PTHREAD_COND_INITIALIZER;
+static bool disconnected = false;
+
+static void disconnect_cb(void *data)
+{
+	disconnected = true;
+
+	pthread_mutex_lock(&cv_mutex);
+	pthread_cond_signal(&cv);
+	pthread_mutex_unlock(&cv_mutex);
+}
+
+static void test_disconnect(const void *data)
+{
+	pid_t pid;
+	bool cmd_first = (bool) data;
+	struct timespec ts;
+
+	cleanup_hal();
+
+	g_assert(hal_ipc_init(HAL_SK_PATH, sizeof(HAL_SK_PATH)));
+
+	pid = fork();
+	if (pid == 0) {
+		connect_hal();
+		disconnect_hal(cmd_first);
+		exit(0);
+	}
+
+	g_assert(pid > 0);
+
+	hal_ipc_set_disconnect_cb(disconnect_cb, NULL);
+
+	pthread_mutex_lock(&cv_mutex);
+
+	g_assert(hal_ipc_accept());
+
+	wait(NULL);
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+	ts.tv_sec += 15;
+
+	/*
+	 * This is not needed in real usecase but here we want to test if
+	 * disconnect callback was properly called on socket shutdown so
+	 * we need to wait until it happen before calling cleanup (otherwise
+	 * we might have a race where cleanup is called before notif thread is
+	 * scheduled resulting in clean shutdown
+	 */
+	g_assert(pthread_cond_timedwait(&cv, &cv_mutex, &ts) == 0);
+	pthread_mutex_unlock(&cv_mutex);
+
+	hal_ipc_cleanup();
+
+	g_assert(disconnected);
+	disconnected = false;
+}
+
+static void test_disconnect_stress(const void *data)
+{
+	int i;
+
+	for (i = 0; i < 9999; i++)
+		test_disconnect(data);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -137,6 +241,14 @@ int main(int argc, char *argv[])
 	g_test_add_func("/android_hal_ipc/init", test_init);
 	g_test_add_func("/android_hal_ipc/accept", test_accept);
 	g_test_add_func("/android_hal_ipc/thread_cb", test_thread_cb);
+	g_test_add_data_func("/android_hal_ipc/disconnect1", (void *) true,
+							test_disconnect);
+	g_test_add_data_func("/android_hal_ipc/disconnect1_stress",
+					(void *) true, test_disconnect_stress);
+	g_test_add_data_func("/android_hal_ipc/disconnect2", (void *) false,
+							test_disconnect);
+	g_test_add_data_func("/android_hal_ipc/disconnect2_stress",
+					(void *) false, test_disconnect_stress);
 
 	return g_test_run();
 }
-- 
1.9.3

