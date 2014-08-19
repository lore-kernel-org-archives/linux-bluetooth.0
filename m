Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/11] android/test: Add HAL IPC thread callback test
Date: Tue, 19 Aug 2014 21:51:08 +0200
Message-Id: <1408477872-24160-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
References: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/test-hal-ipc.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/test-hal-ipc.c b/android/test-hal-ipc.c
index 3321367..b4cf071 100644
--- a/android/test-hal-ipc.c
+++ b/android/test-hal-ipc.c
@@ -92,6 +92,41 @@ static void test_accept(void)
 	wait(NULL);
 }
 
+static int thread_cb_cnt = 0;
+
+static void thread_cb(bool enable)
+{
+	g_assert((enable && !thread_cb_cnt) || (!enable && thread_cb_cnt));
+	thread_cb_cnt++;
+}
+
+static void test_thread_cb(void)
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
+	hal_ipc_set_thread_cb(thread_cb);
+
+	g_assert(hal_ipc_accept());
+
+	hal_ipc_cleanup();
+
+	wait(NULL);
+
+	g_assert(thread_cb_cnt == 2);
+	thread_cb_cnt = 0;
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -101,6 +136,7 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/android_hal_ipc/init", test_init);
 	g_test_add_func("/android_hal_ipc/accept", test_accept);
+	g_test_add_func("/android_hal_ipc/thread_cb", test_thread_cb);
 
 	return g_test_run();
 }
-- 
1.9.3

