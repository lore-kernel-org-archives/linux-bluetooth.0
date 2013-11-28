Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v2 3/6] android: Start emulator in separate thread
Date: Thu, 28 Nov 2013 10:42:47 +0100
Message-Id: <1385631770-3858-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1385631770-3858-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1385631770-3858-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

This is needed because bluetooth->init call is blocking,
and we have to emulate normal behaviour of android environment.
That thread will exit if it won't receive any message in 2 sec
or when bluetoothd will exit. It will be joined in teardown.
---
 android/Makefile.am      |   2 +
 android/android-tester.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 905032d..b19ab4e 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -94,6 +94,8 @@ android_android_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
 
 android_android_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
+android_android_tester_LDFLAGS = -pthread
+
 endif
 
 EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
diff --git a/android/android-tester.c b/android/android-tester.c
index 48e408d..16e8ec0 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -15,9 +15,15 @@
  *
  */
 
+#include <stdlib.h>
 #include <unistd.h>
 
 #include <glib.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/un.h>
+#include <pthread.h>
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
@@ -26,12 +32,18 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/hciemu.h"
 
+#define WAIT_FOR_CONDITION_TIME 2 /* in seconds */
+
+static pthread_cond_t emulator_cond = PTHREAD_COND_INITIALIZER;
+static pthread_mutex_t emulator_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 struct test_data {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	void *test_data;
+	pthread_t emulator_thread;
 };
 
 static void read_info_callback(uint8_t status, uint16_t length,
@@ -162,6 +174,117 @@ static void test_post_teardown(const void *test_data)
 	data->hciemu = NULL;
 }
 
+static void bluetoothd_start(void)
+{
+	struct test_data *data = tester_get_data();
+	char prg_name[PATH_MAX + 1];
+	char index[8];
+	char *prg_argv[4];
+	pid_t pid;
+	int status;
+
+	snprintf(prg_name, sizeof(prg_name), "%s/%s", "android", "bluetoothd");
+	snprintf(index, sizeof(index), "%d", data->mgmt_index);
+
+	prg_argv[0] = prg_name;
+	prg_argv[1] = "-i";
+	prg_argv[2] = index;
+	prg_argv[3] = NULL;
+
+	pid = fork();
+	if (pid < 0) {
+		perror("Failed to fork new process");
+		return;
+	}
+
+	if (pid == 0) {
+		if (!tester_use_debug())
+			fclose(stderr);
+
+		execve(prg_argv[0], prg_argv, NULL);
+		exit(0);
+	}
+
+	pid = waitpid(-1, &status, 0);
+}
+
+static void *emulator(void *user_data)
+{
+	static const char SYSTEM_SOCKET_PATH[] = "\0android_system";
+	char buf[4096];
+	struct sockaddr_un addr;
+	struct timeval tv;
+	int fd;
+	ssize_t len;
+
+	fd = socket(PF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		return NULL;
+
+	tv.tv_sec = WAIT_FOR_CONDITION_TIME;
+	tv.tv_usec = 0;
+	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (char *)&tv, sizeof(tv));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	memcpy(addr.sun_path, SYSTEM_SOCKET_PATH, sizeof(SYSTEM_SOCKET_PATH));
+
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("Failed to bind system socket");
+		close(fd);
+		pthread_exit(NULL);
+		return NULL;
+	}
+
+	pthread_mutex_lock(&emulator_mutex);
+	pthread_cond_signal(&emulator_cond);
+	pthread_mutex_unlock(&emulator_mutex);
+
+	len = read(fd, buf, sizeof(buf));
+	if (len <= 0 || (strcmp(buf, "ctl.start=bluetoothd"))) {
+		close(fd);
+		pthread_exit(NULL);
+		return NULL;
+	}
+
+	close(fd);
+	bluetoothd_start();
+	pthread_exit(NULL);
+	return NULL;
+}
+
+static void setup(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct timespec ts;
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+	ts.tv_sec += WAIT_FOR_CONDITION_TIME;
+
+	pthread_mutex_lock(&emulator_mutex);
+
+	if (pthread_create(&data->emulator_thread, NULL, emulator, NULL)) {
+		tester_setup_failed();
+		return;
+	}
+
+	if (pthread_cond_timedwait(&emulator_cond, &emulator_mutex,
+								&ts))
+		tester_setup_failed();
+	else
+		tester_setup_complete();
+
+	pthread_mutex_unlock(&emulator_mutex);
+}
+
+static void teardown(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	pthread_join(data->emulator_thread, NULL);
+	tester_teardown_complete();
+}
+
 static void pass_test(const void *test_data)
 {
 	tester_test_passed();
@@ -184,7 +307,7 @@ int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
 
-	test_bredrle("test", NULL, NULL, pass_test, NULL);
+	test_bredrle("test", NULL, setup, pass_test, teardown);
 
 	return tester_run();
 }
-- 
1.8.4.2

