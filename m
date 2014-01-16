Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 4/8] android/ipc-tester: Add daemon shutdown handler
Date: Thu, 16 Jan 2014 09:38:28 +0100
Message-Id: <1389861512-2326-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389861512-2326-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389861512-2326-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle daemon shutdown asynchronously.
---
 android/ipc-tester.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index b76be32..6ba6e1f 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -52,6 +52,7 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	pid_t bluetoothd_pid;
+	bool setup_done;
 };
 
 #define CONNECT_TIMEOUT (5 * 1000)
@@ -359,6 +360,30 @@ static void cleanup_ipc(void)
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
+	}
+
+	tester_warn("Unexpected Daemon shutdown with status %d", status);
+	return false;
+}
+
 static void setup(const void *data)
 {
 	struct test_data *test_data = tester_get_data();
@@ -399,6 +424,10 @@ static void setup(const void *data)
 		tester_setup_failed();
 		return;
 	}
+
+	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, check_for_daemon, test_data,
+									NULL);
+
 	if (!init_ipc()) {
 		tester_warn("Cannot initialize IPC mechanism!");
 		tester_setup_failed();
@@ -406,6 +435,8 @@ static void setup(const void *data)
 	}
 
 	/* TODO: register modules */
+
+	test_data->setup_done = true;
 }
 
 static void teardown(const void *data)
-- 
1.8.5.2

