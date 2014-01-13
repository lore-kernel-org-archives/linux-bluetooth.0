Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] android/ipc-tester: Run daemon in separate process
Date: Mon, 13 Jan 2014 11:36:57 +0100
Message-Id: <1389609422-21200-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389609422-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389609422-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds new process waiting to run daemon when needed.

---
 android/ipc-negative-tester.c | 124 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/android/ipc-negative-tester.c b/android/ipc-negative-tester.c
index 0c2edda..78ca104 100644
--- a/android/ipc-negative-tester.c
+++ b/android/ipc-negative-tester.c
@@ -15,8 +15,14 @@
  *
  */
 
+#include <stdlib.h>
 #include <unistd.h>
 
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/un.h>
+#include <libgen.h>
 #include <glib.h>
 
 #include "lib/bluetooth.h"
@@ -27,13 +33,19 @@
 #include "src/shared/hciemu.h"
 
 
+#define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
+#define EMULATOR_SIGNAL "emulator_started"
+
 struct test_data {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
+	pid_t bluetoothd_pid;
 };
 
+static char exec_dir[PATH_MAX + 1];
+
 static void read_info_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -162,13 +174,121 @@ static void test_post_teardown(const void *data)
 	test_data->hciemu = NULL;
 }
 
+static void bluetoothd_start(int hci_index)
+{
+	char prg_name[PATH_MAX + 1];
+	char index[8];
+	char *prg_argv[4];
+
+	snprintf(prg_name, sizeof(prg_name), "%s/%s", exec_dir, "bluetoothd");
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
 static void setup(const void *data)
 {
-	tester_setup_failed();
+	struct test_data *test_data = tester_get_data();
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
+		emulator(signal_fd[1], test_data->mgmt_index);
+		exit(0);
+	}
+
+	close(signal_fd[1]);
+	test_data->bluetoothd_pid = pid;
+
+	len = read(signal_fd[0], buf, sizeof(buf));
+	if (len <= 0 || (strcmp(buf, EMULATOR_SIGNAL))) {
+		close(signal_fd[0]);
+		tester_setup_failed();
+		return;
+	}
 }
 
 static void teardown(const void *data)
 {
+	struct test_data *test_data = tester_get_data();
+
+	if (test_data->bluetoothd_pid)
+		waitpid(test_data->bluetoothd_pid, NULL, 0);
+
 	tester_teardown_complete();
 }
 
@@ -190,6 +310,8 @@ static void ipc_send_tc(const void *data)
 
 int main(int argc, char *argv[])
 {
+	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
+
 	tester_init(&argc, &argv);
 
 	test_bredrle("Test Dummy", NULL, setup, ipc_send_tc, teardown);
-- 
1.8.5

