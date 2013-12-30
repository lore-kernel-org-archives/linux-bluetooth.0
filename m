Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 3/7] android: Add support for bluetoothd-snoop service in system-emulator
Date: Mon, 30 Dec 2013 23:43:37 +0100
Message-Id: <1388443421-6295-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
References: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to test bluetoothd-snoop service on Linux host.
---
 android/system-emulator.c | 61 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/android/system-emulator.c b/android/system-emulator.c
index 611e46e..2dc9ad8 100644
--- a/android/system-emulator.c
+++ b/android/system-emulator.c
@@ -45,6 +45,7 @@
 static char exec_dir[PATH_MAX + 1];
 
 static pid_t daemon_pid = -1;
+static pid_t snoop_pid = -1;
 
 static void ctl_start(void)
 {
@@ -81,6 +82,47 @@ static void ctl_start(void)
 	daemon_pid = pid;
 }
 
+static void snoop_start(void)
+{
+	char prg_name[PATH_MAX + 1];
+	char *prg_argv[3];
+	char *prg_envp[1];
+	pid_t pid;
+
+	snprintf(prg_name, sizeof(prg_name), "%s/%s", exec_dir,
+							"bluetoothd-snoop");
+
+	prg_argv[0] = prg_name;
+	prg_argv[1] = "/tmp/btsnoop_hci.log";
+	prg_argv[2] = NULL;
+
+	prg_envp[0] = NULL;
+
+	printf("Starting %s\n", prg_name);
+
+	pid = fork();
+	if (pid < 0) {
+		perror("Failed to fork new process");
+		return;
+	}
+
+	if (pid == 0) {
+		execve(prg_argv[0], prg_argv, prg_envp);
+		exit(0);
+	}
+
+	printf("New process %d created\n", pid);
+
+	snoop_pid = pid;
+}
+
+static void snoop_stop(void)
+{
+	printf("Stoping %s/%s\n", exec_dir, "bluetoothd-snoop");
+
+	kill(snoop_pid, SIGTERM);
+}
+
 static void system_socket_callback(int fd, uint32_t events, void *user_data)
 {
 	char buf[4096];
@@ -97,13 +139,20 @@ static void system_socket_callback(int fd, uint32_t events, void *user_data)
 
 	printf("Received %s\n", buf);
 
-	if (strcmp(buf, "ctl.start=bluetoothd"))
-		return;
+	if (!strcmp(buf, "ctl.start=bluetoothd")) {
+		if (daemon_pid > 0)
+			return;
 
-	if (daemon_pid > 0)
-		return;
+		ctl_start();
+	} else if (!strcmp(buf, "ctl.start=bluetoothd-snoop")) {
+		if (snoop_pid > 0)
+			return;
 
-	ctl_start();
+		snoop_start();
+	} else if (!strcmp(buf, "ctl.stop=bluetoothd-snoop")) {
+		if (snoop_pid > 0)
+			snoop_stop();
+	}
 }
 
 static void signal_callback(int signum, void *user_data)
@@ -127,6 +176,8 @@ static void signal_callback(int signum, void *user_data)
 
 			if (pid == daemon_pid)
 				daemon_pid = -1;
+			else if (pid == snoop_pid)
+				snoop_pid = -1;
 		}
 		break;
 	}
-- 
1.8.5.2

