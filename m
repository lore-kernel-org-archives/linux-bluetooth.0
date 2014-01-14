Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/8] android/ipc-tester: Add daemon shutdown handler
Date: Tue, 14 Jan 2014 13:14:41 +0100
Message-Id: <1389701685-1861-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389701685-1861-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389701685-1861-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle daemon shutdown asynchronously.
---
 android/ipc-negative-tester.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/android/ipc-negative-tester.c b/android/ipc-negative-tester.c
index 1736794..bbe4ce6 100644
--- a/android/ipc-negative-tester.c
+++ b/android/ipc-negative-tester.c
@@ -46,6 +46,7 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	pid_t bluetoothd_pid;
+	bool setup_done;
 };
 
 #define CONNECT_TIMEOUT (5 * 1000)
@@ -353,6 +354,44 @@ static void cleanup_ipc(void)
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
+	if (WIFEXITED(status)) {
+		tester_test_passed();
+	} else if (WIFSIGNALED(status)) {
+		switch (WTERMSIG(status)) {
+		case SIGTERM:
+			if (data->setup_done)
+				tester_test_passed();
+			else
+				tester_setup_failed();
+			break;
+		case SIGSEGV:
+			tester_warn("Daemon died with segmentation fault");
+			goto failed;
+		default:
+			tester_warn("Bad signal received %d", status);
+			goto failed;
+		}
+	}
+
+	return true;
+
+failed:
+	if (data->setup_done)
+		tester_test_failed();
+	else
+		tester_setup_failed();
+	return false;
+}
+
 static void setup(const void *data)
 {
 	struct test_data *test_data = tester_get_data();
@@ -393,6 +432,10 @@ static void setup(const void *data)
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
@@ -400,6 +443,8 @@ static void setup(const void *data)
 	}
 
 	/* TODO: register modules */
+
+	test_data->setup_done = true;
 }
 
 static void teardown(const void *data)
-- 
1.8.5.2

