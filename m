Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/13] android/tester: Non-blocking check for daemon termination
Date: Fri, 21 Feb 2014 13:57:52 +0100
Message-Id: <1392987473-19994-13-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the main loop being blocked, waiting for daemon termination
while daemon waits for freezed emulator to respond.
---
 android/android-tester.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 36e3b7e..921204d 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -2172,6 +2172,27 @@ static void setup_enabled_adapter(const void *test_data)
 		tester_setup_failed();
 }
 
+static gboolean check_daemon_term(gpointer user_data)
+{
+	int status;
+	struct test_data *data = tester_get_data();
+
+	if (!data)
+		return FALSE;
+
+	if ((waitpid(data->bluetoothd_pid, &status, WNOHANG))
+							!= data->bluetoothd_pid)
+		return TRUE;
+
+	if (WIFEXITED(status) && (WEXITSTATUS(status) == EXIT_SUCCESS)) {
+		tester_teardown_complete();
+		return FALSE;
+	}
+
+	tester_warn("Unexpected Daemon shutdown with status %d", status);
+	return FALSE;
+}
+
 static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2191,10 +2212,7 @@ static void teardown(const void *test_data)
 
 	data->device->close(data->device);
 
-	if (data->bluetoothd_pid)
-		waitpid(data->bluetoothd_pid, NULL, 0);
-
-	tester_teardown_complete();
+	g_idle_add(check_daemon_term, NULL);
 }
 
 static void test_dummy(const void *test_data)
-- 
1.8.5.2

