Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/2] android/tester: Init profiles in separate thread
Date: Fri,  5 Sep 2014 15:00:02 +0200
Message-Id: <1409922002-30751-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1409922002-30751-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409922002-30751-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed to not block mainloop while initializing stack.
In some cases, bluetooth->init blocks mainloop and bluetoothd
cannot properly initialize controller, because HCI frames are
not serviced in hciemu.
Because pthread_join() is blocking, it is added to mainloop
from thread right before pthread_exit() is called. Therefore
this time is extremely short.
---
 android/tester-main.c | 64 +++++++++++++++++++++++++++++++++++++++++++--------
 android/tester-main.h |  2 ++
 2 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 7e8621a..2e00f79 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -15,8 +15,10 @@
  *
  */
 #include <stdbool.h>
+#include <pthread.h>
 
 #include "emulator/bthost.h"
+#include "src/shared/util.h"
 #include "tester-main.h"
 
 #include "monitor/bt.h"
@@ -1336,27 +1338,71 @@ static bool setup_base(struct test_data *data)
 	return true;
 }
 
-static void setup_generic(const void *test_data)
+static gboolean join_init_thread(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
-	bt_status_t status;
+	int (*init_func)(void) = user_data;
+	int status;
+	void *ret;
 
-	if (!setup_base(data)) {
+	/*
+	 * Note that pthread_join is blocking mainloop,
+	 * therefore thread we want to join must
+	 * exit immediately. This is done in init_thread()
+	 */
+	status = pthread_join(data->thread, &ret);
+	if (status != 0) {
+		tester_warn("Failed to join init thread, status %d", status);
 		tester_setup_failed();
-		return;
+		return FALSE;
 	}
 
-	status = data->if_bluetooth->init(&bt_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
-		data->if_bluetooth = NULL;
+	if (PTR_TO_INT(ret) != BT_STATUS_SUCCESS) {
 		tester_setup_failed();
-		return;
+		return FALSE;
 	}
 
-	if (!data->init_routine || data->init_routine() == BT_STATUS_SUCCESS)
+	if (!init_func || init_func() == BT_STATUS_SUCCESS)
 		tester_setup_complete();
 	else
 		tester_setup_failed();
+
+	return FALSE;
+}
+
+static void *init_thread(void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	int status;
+
+	status = data->if_bluetooth->init(&bt_callbacks);
+
+	g_idle_add(join_init_thread, user_data);
+
+	pthread_exit(INT_TO_PTR(status));
+}
+
+static bool start_init_thread(int (*init)(void))
+{
+	struct test_data *data = tester_get_data();
+
+	if (pthread_create(&data->thread, NULL, init_thread, init) != 0)
+		return false;
+
+	return true;
+}
+
+static void setup_generic(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	if (!setup_base(data)) {
+		tester_setup_failed();
+		return;
+	}
+
+	if (!start_init_thread(data->init_routine))
+		tester_setup_failed();
 }
 
 static int init_socket(void)
diff --git a/android/tester-main.h b/android/tester-main.h
index 8247c5a..f804f78 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -334,6 +334,8 @@ struct test_data {
 	pid_t bluetoothd_pid;
 
 	struct queue *pdus;
+
+	pthread_t thread;
 };
 
 /*
-- 
1.9.3

