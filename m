Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/11] android/test: Add HAL IPC reconnect tests
Date: Tue, 19 Aug 2014 21:51:10 +0200
Message-Id: <1408477872-24160-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
References: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/test-hal-ipc.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/android/test-hal-ipc.c b/android/test-hal-ipc.c
index bc86a3e..44485c4 100644
--- a/android/test-hal-ipc.c
+++ b/android/test-hal-ipc.c
@@ -231,6 +231,82 @@ static void test_disconnect_stress(const void *data)
 		test_disconnect(data);
 }
 
+static bool reconnected = false;
+
+static void reconnect_cb(void *data)
+{
+	disconnected = true;
+
+	if (!reconnected) {
+		reconnected = true;
+		g_assert(hal_ipc_accept());
+		return;
+	}
+
+	pthread_mutex_lock(&cv_mutex);
+	pthread_cond_signal(&cv);
+	pthread_mutex_unlock(&cv_mutex);
+}
+
+static void test_reconnect(const void *data)
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
+		connect_hal();
+		disconnect_hal(cmd_first);
+		exit(0);
+	}
+
+	g_assert(pid > 0);
+
+	hal_ipc_set_disconnect_cb(reconnect_cb, NULL);
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
+
+	g_assert(reconnected);
+	reconnected = false;
+}
+
+static void test_reconnect_stress(const void *data)
+{
+	int i;
+
+	for (i = 0; i < 9999; i++)
+		test_reconnect(data);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -249,6 +325,14 @@ int main(int argc, char *argv[])
 							test_disconnect);
 	g_test_add_data_func("/android_hal_ipc/disconnect2_stress",
 					(void *) false, test_disconnect_stress);
+	g_test_add_data_func("/android_hal_ipc/reconnect1", (void *) true,
+							test_reconnect);
+	g_test_add_data_func("/android_hal_ipc/reconnect_stress",
+					(void *) true, test_reconnect_stress);
+	g_test_add_data_func("/android_hal_ipc/reconnect2", (void *) false,
+							test_reconnect);
+	g_test_add_data_func("/android_hal_ipc/reconnect2_stress",
+					(void *) false, test_reconnect_stress);
 
 	return g_test_run();
 }
-- 
1.9.3

