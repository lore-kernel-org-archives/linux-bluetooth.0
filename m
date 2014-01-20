Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 04/11] android/ipc-tester: Add daemon shutdown handler
Date: Mon, 20 Jan 2014 10:36:03 +0100
Message-Id: <1390210570-28260-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle daemon shutdown asynchronously.
---
 android/ipc-tester.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index ff17ced..b6f8131 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -52,6 +52,7 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	pid_t bluetoothd_pid;
+	bool setup_done;
 };
 
 #define CONNECT_TIMEOUT (5 * 1000)
@@ -364,6 +365,31 @@ static void cleanup_ipc(void)
 	cmd_sk = -1;
 }
 
+static gboolean check_for_daemon(gpointer user_data)
+{
+	int status;
+	struct test_data *data = user_data;
+
+	if ((waitpid(data->bluetoothd_pid, &status, WNOHANG))
+							!= data->bluetoothd_pid)
+		return true;
+
+	if (data->setup_done) {
+		if (WIFEXITED(status) &&
+				(WEXITSTATUS(status) == EXIT_SUCCESS)) {
+			tester_test_passed();
+			return false;
+		}
+		tester_test_failed();
+	} else {
+		tester_setup_failed();
+		test_post_teardown(data);
+	}
+
+	tester_warn("Unexpected Daemon shutdown with status %d", status);
+	return false;
+}
+
 static void setup(const void *data)
 {
 	struct test_data *test_data = tester_get_data();
@@ -401,24 +427,29 @@ static void setup(const void *data)
 		goto failed;
 	}
 
+	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, check_for_daemon, test_data,
+									NULL);
+
 	if (!init_ipc()) {
 		tester_warn("Cannot initialize IPC mechanism!");
 		goto failed;
 	}
 	/* TODO: register modules */
 
+	test_data->setup_done = true;
 	return;
 
 failed:
+	g_idle_remove_by_data(test_data);
 	tester_setup_failed();
 	test_post_teardown(data);
 }
 
-
 static void teardown(const void *data)
 {
 	struct test_data *test_data = tester_get_data();
 
+	g_idle_remove_by_data(test_data);
 	cleanup_ipc();
 
 	if (test_data->bluetoothd_pid)
-- 
1.8.5.2

