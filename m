Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F32C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 May 2023 13:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjEMNRK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 May 2023 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjEMNRI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 May 2023 09:17:08 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC303AB1
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 May 2023 06:17:06 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id D984C240103
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 May 2023 15:17:04 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QJR4J2FLXz6tmv;
        Sat, 13 May 2023 15:17:04 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] test-runner: revert udevd and audio support
Date:   Sat, 13 May 2023 13:17:00 +0000
Message-Id: <a8e734ecc8d9fce9c9b9681a9db74dd224ff3cc2.1683983569.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Tests running inside the VM don't need access to sound cards running on
the host.

This reverts commit 91a48af52efb0751fab396b2b9026c9186b10b88.
This reverts commit e20e7e0b05c7edb74255c9b092916ac5bb99c97f.
---
 tools/test-runner.c | 108 ++------------------------------------------
 1 file changed, 3 insertions(+), 105 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 6660ea8de..cd65c4cf0 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -54,7 +54,6 @@ static bool start_monitor = false;
 static int num_devs = 0;
 static const char *qemu_binary = NULL;
 static const char *kernel_image = NULL;
-static bool audio_support;
 
 static const char *qemu_table[] = {
 	"qemu-system-x86_64",
@@ -252,16 +251,14 @@ static void start_qemu(void)
 				"acpi=off pci=noacpi noapic quiet ro init=%s "
 				"TESTHOME=%s TESTDBUS=%u TESTDAEMON=%u "
 				"TESTDBUSSESSION=%u XDG_RUNTIME_DIR=/run/user/0 "
-				"TESTAUDIO=%u "
 				"TESTMONITOR=%u TESTEMULATOR=%u TESTDEVS=%d "
 				"TESTAUTO=%u TESTARGS=\'%s\'",
 				initcmd, cwd, start_dbus, start_daemon,
-				start_dbus_session, audio_support,
+				start_dbus_session,
 				start_monitor, start_emulator, num_devs,
 				run_auto, testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
-				(audio_support ? 4 : 0) +
 				(sizeof(char *) * (4 + (num_devs * 4))));
 	memcpy(argv, qemu_argv, sizeof(qemu_argv));
 
@@ -274,24 +271,6 @@ static void start_qemu(void)
 	}
 	argv[0] = (char *) qemu_binary;
 
-	if (audio_support) {
-		char *xdg_runtime_dir, *audiodev;
-
-		xdg_runtime_dir = getenv("XDG_RUNTIME_DIR");
-		if (!xdg_runtime_dir) {
-			fprintf(stderr, "XDG_RUNTIME_DIR not set\n");
-			exit(1);
-		}
-		audiodev = alloca(40 + strlen(xdg_runtime_dir));
-		sprintf(audiodev, "id=audio,driver=pa,server=%s/pulse/native",
-				xdg_runtime_dir);
-
-		argv[pos++] = "-audiodev";
-		argv[pos++] = audiodev;
-		argv[pos++] = "-device";
-		argv[pos++] = "AC97,audiodev=audio";
-	}
-
 	argv[pos++] = "-kernel";
 	argv[pos++] = (char *) kernel_image;
 	argv[pos++] = "-append";
@@ -744,70 +723,13 @@ static pid_t start_btvirt(const char *home)
 	return pid;
 }
 
-static void trigger_udev(void)
-{
-	char *argv[3], *envp[1];
-	pid_t pid;
-
-	argv[0] = "/bin/udevadm";
-	argv[1] = "trigger";
-	argv[2] = NULL;
-
-	envp[0] = NULL;
-
-	printf("Triggering udev events\n");
-
-	pid = fork();
-	if (pid < 0) {
-		perror("Failed to fork new process");
-		return;
-	}
-
-	if (pid == 0) {
-		execve(argv[0], argv, envp);
-		exit(EXIT_SUCCESS);
-	}
-
-	printf("udev trigger process %d created\n", pid);
-}
-
-static pid_t start_udevd(void)
-{
-	char *argv[2], *envp[1];
-	pid_t pid;
-
-	argv[0] = "/lib/systemd/systemd-udevd";
-	argv[1] = NULL;
-
-	envp[0] = NULL;
-
-	printf("Starting udevd daemon\n");
-
-	pid = fork();
-	if (pid < 0) {
-		perror("Failed to fork new process");
-		return -1;
-	}
-
-	if (pid == 0) {
-		execve(argv[0], argv, envp);
-		exit(EXIT_SUCCESS);
-	}
-
-	printf("udevd daemon process %d created\n", pid);
-
-	trigger_udev();
-
-	return pid;
-}
-
 static void run_command(char *cmdname, char *home)
 {
 	char *argv[9], *envp[3];
 	int pos = 0, idx = 0;
 	int serial_fd;
 	pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
-	      dbus_session_pid, udevd_pid;
+	      dbus_session_pid;
 
 	if (!home) {
 		perror("Invalid parameter: TESTHOME");
@@ -828,11 +750,6 @@ static void run_command(char *cmdname, char *home)
 	} else
 		serial_fd = -1;
 
-	if (audio_support)
-		udevd_pid = start_udevd();
-	else
-		udevd_pid = -1;
-
 	if (start_dbus) {
 		create_dbus_system_conf();
 		dbus_pid = start_dbus_daemon(false);
@@ -961,11 +878,6 @@ start_next:
 			monitor_pid = -1;
 		}
 
-		if (corpse == udevd_pid) {
-			printf("udevd terminated\n");
-			udevd_pid = -1;
-		}
-
 		if (corpse == pid)
 			break;
 	}
@@ -990,9 +902,6 @@ start_next:
 	if (monitor_pid > 0)
 		kill(monitor_pid, SIGTERM);
 
-	if (udevd_pid > 0)
-		kill(udevd_pid, SIGTERM);
-
 	if (serial_fd >= 0)
 		close(serial_fd);
 }
@@ -1073,12 +982,6 @@ static void run_tests(void)
 		start_emulator = true;
 	}
 
-	ptr = strstr(cmdline, "TESTAUDIO=1");
-	if (ptr) {
-		printf("Audio support requested\n");
-		audio_support = true;
-	}
-
 	ptr = strstr(cmdline, "TESTHOME=");
 	if (ptr) {
 		home = ptr + 4;
@@ -1105,7 +1008,6 @@ static void usage(void)
 		"\t-u, --unix [path]      Provide serial device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-k, --kernel <image>   Kernel image (bzImage)\n"
-		"\t-A, --audio            Add audio support\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -1120,7 +1022,6 @@ static const struct option main_options[] = {
 	{ "monitor", no_argument,       NULL, 'm' },
 	{ "qemu",    required_argument, NULL, 'q' },
 	{ "kernel",  required_argument, NULL, 'k' },
-	{ "audio",   no_argument,       NULL, 'A' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -1140,7 +1041,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "aubdslmq:k:Avh", main_options,
+		opt = getopt_long(argc, argv, "aubdslmq:k:vh", main_options,
 								NULL);
 		if (opt < 0)
 			break;
@@ -1174,9 +1075,6 @@ int main(int argc, char *argv[])
 		case 'k':
 			kernel_image = optarg;
 			break;
-		case 'A':
-			audio_support = true;
-			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
-- 
2.40.1

