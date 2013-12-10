Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/7] android/tester: Start emulator in new process
Date: Tue, 10 Dec 2013 11:45:40 +0100
Message-Id: <1386672344-13438-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1386672344-13438-1-git-send-email-marcin.kraglak@tieto.com>
References: <1386672344-13438-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed because bluetooth->init call is blocking,
and we have to emulate normal behaviour of android environment.
That process will exit if it won't receive any message in 2 sec
or when bluetoothd will exit. Main tester thread will wait for
this process in teardown method.
---
 android/android-tester.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 48e408d..6af7bd4 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -15,9 +15,14 @@
  *
  */
 
+#include <stdlib.h>
 #include <unistd.h>
 
 #include <glib.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/un.h>
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
@@ -26,12 +31,16 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/hciemu.h"
 
+#define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
+#define EMULATOR_SIGNAL "emulator_started"
+
 struct test_data {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	void *test_data;
+	pid_t bluetoothd_pid;
 };
 
 static void read_info_callback(uint8_t status, uint16_t length,
@@ -162,6 +171,126 @@ static void test_post_teardown(const void *test_data)
 	data->hciemu = NULL;
 }
 
+static void bluetoothd_start(int hci_index)
+{
+	char prg_name[PATH_MAX + 1];
+	char index[8];
+	char *prg_argv[4];
+
+	snprintf(prg_name, sizeof(prg_name), "%s/%s", "android", "bluetoothd");
+	snprintf(index, sizeof(index), "%d", hci_index);
+
+	prg_argv[0] = prg_name;
+	prg_argv[1] = "-i";
+	prg_argv[2] = index;
+	prg_argv[3] = NULL;
+
+	if (!tester_use_debug())
+		fclose(stderr);
+
+	execve(prg_argv[0], prg_argv, NULL);
+}
+
+static void emulator(int pipe, int hci_index)
+{
+	static const char SYSTEM_SOCKET_PATH[] = "\0android_system";
+	char buf[1024];
+	struct sockaddr_un addr;
+	struct timeval tv;
+	int fd;
+	ssize_t len;
+
+	fd = socket(PF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		goto failed;
+
+	tv.tv_sec = WAIT_FOR_SIGNAL_TIME;
+	tv.tv_usec = 0;
+	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (char *)&tv, sizeof(tv));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	memcpy(addr.sun_path, SYSTEM_SOCKET_PATH, sizeof(SYSTEM_SOCKET_PATH));
+
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("Failed to bind system socket");
+		goto failed;
+	}
+
+	len = write(pipe, EMULATOR_SIGNAL, sizeof(EMULATOR_SIGNAL));
+
+	if (len != sizeof(EMULATOR_SIGNAL))
+		goto failed;
+
+	memset(buf, 0, sizeof(buf));
+
+	len = read(fd, buf, sizeof(buf));
+	if (len <= 0 || (strcmp(buf, "ctl.start=bluetoothd")))
+		goto failed;
+
+	close(pipe);
+	close(fd);
+	bluetoothd_start(hci_index);
+
+failed:
+	close(pipe);
+	close(fd);
+}
+
+static void setup(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	int signal_fd[2];
+	char buf[1024];
+	pid_t pid;
+	int len;
+
+	if (pipe(signal_fd)) {
+		tester_setup_failed();
+		return;
+	}
+
+	pid = fork();
+
+	if (pid < 0) {
+		close(signal_fd[0]);
+		close(signal_fd[1]);
+		tester_setup_failed();
+		return;
+	}
+
+	if (pid == 0) {
+		if (!tester_use_debug())
+			fclose(stderr);
+
+		close(signal_fd[0]);
+		emulator(signal_fd[1], data->mgmt_index);
+		exit(0);
+	}
+
+	close(signal_fd[1]);
+	data->bluetoothd_pid = pid;
+
+	len = read(signal_fd[0], buf, sizeof(buf));
+	if (len <= 0 || (strcmp(buf, EMULATOR_SIGNAL))) {
+		close(signal_fd[0]);
+		tester_setup_failed();
+		return;
+	}
+
+	tester_setup_complete();
+}
+
+static void teardown(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	if (data->bluetoothd_pid)
+		waitpid(data->bluetoothd_pid, NULL, 0);
+
+	tester_teardown_complete();
+}
+
 static void pass_test(const void *test_data)
 {
 	tester_test_passed();
@@ -184,7 +313,7 @@ int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
 
-	test_bredrle("test", NULL, NULL, pass_test, NULL);
+	test_bredrle("test", NULL, setup, pass_test, teardown);
 
 	return tester_run();
 }
-- 
1.8.3.1

