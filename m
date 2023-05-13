Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6F3C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 May 2023 16:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjEMQIq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 May 2023 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEMQIm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 May 2023 12:08:42 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261D51BFB
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 May 2023 09:08:40 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 473CB24002A
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 May 2023 18:08:39 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QJVtG6p7Cz6trm;
        Sat, 13 May 2023 18:08:38 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 2/2] tools/test-runner: add option to start Pipewire inside the VM
Date:   Sat, 13 May 2023 16:08:37 +0000
Message-Id: <b375afe8841f91c0aa530a459afae011487ea297.1683994090.git.pav@iki.fi>
In-Reply-To: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
References: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add option for launching Pipewire inside the VM to serve Bluetooth
endpoints, which can be used in tests.

Make the option to optionally take path to the audio daemon, so e.g.
Pulseaudio support can be added later.
---
 tools/test-runner.c | 149 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 145 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index cd65c4cf0..8b18f848a 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -54,6 +54,7 @@ static bool start_monitor = false;
 static int num_devs = 0;
 static const char *qemu_binary = NULL;
 static const char *kernel_image = NULL;
+static char *audio_server;
 
 static const char *qemu_table[] = {
 	"qemu-system-x86_64",
@@ -252,11 +253,11 @@ static void start_qemu(void)
 				"TESTHOME=%s TESTDBUS=%u TESTDAEMON=%u "
 				"TESTDBUSSESSION=%u XDG_RUNTIME_DIR=/run/user/0 "
 				"TESTMONITOR=%u TESTEMULATOR=%u TESTDEVS=%d "
-				"TESTAUTO=%u TESTARGS=\'%s\'",
+				"TESTAUTO=%u TESTAUDIO='%s' TESTARGS=\'%s\'",
 				initcmd, cwd, start_dbus, start_daemon,
 				start_dbus_session,
 				start_monitor, start_emulator, num_devs,
-				run_auto, testargs);
+				run_auto, audio_server, testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
 				(sizeof(char *) * (4 + (num_devs * 4))));
@@ -723,13 +724,120 @@ static pid_t start_btvirt(const char *home)
 	return pid;
 }
 
+static int create_pipewire_conf(void)
+{
+	static const char *const dirs[] = {
+		"/run/conf",
+		"/run/conf/wireplumber",
+		"/run/conf/wireplumber/bluetooth.lua.d",
+		"/run/conf/wireplumber/main.lua.d",
+		NULL
+	};
+	int i;
+	FILE *f;
+
+	for (i = 0; dirs[i]; ++i)
+		mkdir(dirs[i], 0755);
+
+	/* Enable only Bluetooth part, disable whatever requires user DBus */
+	f = fopen("/run/conf/wireplumber/main.lua.d/51-custom.lua", "w");
+	if (!f)
+		goto fail;
+
+	fprintf(f, "alsa_monitor.enabled = false\n"
+		"v4l2_monitor.enabled = false\n"
+		"libcamera_monitor.enabled = false\n"
+		"default_access.properties[\"enable-flatpak-portal\"]"
+		" = false\n");
+	fclose(f);
+
+	f = fopen("/run/conf/wireplumber/bluetooth.lua.d/51-custom.lua", "w");
+	if (!f)
+		goto fail;
+
+	fprintf(f, "bluez_monitor.properties[\"with-logind\"] = false\n"
+		"bluez_midi_monitor.enabled = false\n");
+	fclose(f);
+
+	return 0;
+
+fail:
+	perror("Failed to create Pipewire config");
+	return -1;
+}
+
+static int start_audio_server(pid_t pids[2])
+{
+	char *daemons[2] = {NULL, NULL};
+	char wp_exe[PATH_MAX];
+	char *ptr;
+	char *envp[5];
+	int i;
+
+	for (i = 0; i < 2; ++i)
+		pids[i] = -1;
+
+	daemons[0] = audio_server;
+
+	ptr = strrchr(audio_server, '/');
+	if (ptr && !strcmp(ptr, "/pipewire")) {
+		if (create_pipewire_conf())
+			return -1;
+
+		snprintf(wp_exe, sizeof(wp_exe), "%.*s/wireplumber",
+				(int)(ptr - audio_server), audio_server);
+		daemons[1] = wp_exe;
+
+		setenv("PIPEWIRE_RUNTIME_DIR", "/run", 1);
+	}
+
+	envp[0] = "DBUS_SYSTEM_BUS_ADDRESS=unix:"
+		"path=/run/dbus/system_bus_socket";
+	envp[1] = "XDG_CONFIG_HOME=/run/conf";
+	envp[2] = "XDG_STATE_HOME=/run";
+	envp[3] = "XDG_RUNTIME_DIR=/run";
+	envp[4] = NULL;
+
+	for (i = 0; i < 2; ++i) {
+		const char *daemon = daemons[i];
+		char *argv[2];
+		pid_t pid;
+
+		if (!daemon)
+			continue;
+
+		printf("Starting audio server %s\n", daemon);
+
+		argv[0] = (char *) daemon;
+		argv[1] = NULL;
+
+		pid = fork();
+		if (pid < 0) {
+			perror("Failed to fork new process");
+			return -1;
+		}
+
+		if (pid == 0) {
+			execve(argv[0], argv, envp);
+			exit(EXIT_SUCCESS);
+		}
+
+		pids[i] = pid;
+
+		printf("Audio server process %d created\n", pid);
+	}
+
+	return 0;
+}
+
 static void run_command(char *cmdname, char *home)
 {
 	char *argv[9], *envp[3];
 	int pos = 0, idx = 0;
 	int serial_fd;
 	pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
-	      dbus_session_pid;
+	      dbus_session_pid, audio_pid[2];
+	int i;
 
 	if (!home) {
 		perror("Invalid parameter: TESTHOME");
@@ -777,6 +885,11 @@ static void run_command(char *cmdname, char *home)
 	else
 		emulator_pid = -1;
 
+	if (audio_server)
+		start_audio_server(audio_pid);
+	else
+		audio_pid[0] = audio_pid[1] = -1;
+
 start_next:
 	if (run_auto) {
 		if (chdir(home + 5) < 0) {
@@ -878,6 +991,13 @@ start_next:
 			monitor_pid = -1;
 		}
 
+		for (i = 0; i < 2; ++i) {
+			if (corpse == audio_pid[i]) {
+				printf("Audio server %d terminated\n", i);
+				audio_pid[i] = -1;
+			}
+		}
+
 		if (corpse == pid)
 			break;
 	}
@@ -887,6 +1007,11 @@ start_next:
 		goto start_next;
 	}
 
+	for (i = 0; i < 2; ++i) {
+		if (audio_pid[i] > 0)
+			kill(audio_pid[i], SIGTERM);
+	}
+
 	if (daemon_pid > 0)
 		kill(daemon_pid, SIGTERM);
 
@@ -982,6 +1107,17 @@ static void run_tests(void)
 		start_emulator = true;
 	}
 
+	ptr = strstr(cmdline, "TESTAUDIO='");
+	if (ptr) {
+		const char *start = ptr + 11;
+		const char *end = strchr(start, '\'');
+
+		if (end) {
+			audio_server = strndup(start, end - start);
+			printf("Audio server %s requested\n", audio_server);
+		}
+	}
+
 	ptr = strstr(cmdline, "TESTHOME=");
 	if (ptr) {
 		home = ptr + 4;
@@ -1005,6 +1141,7 @@ static void usage(void)
 		"\t-d, --daemon           Start bluetoothd\n"
 		"\t-m, --monitor          Start btmon\n"
 		"\t-l, --emulator         Start btvirt\n"
+		"\t-A, --audio[=path]     Start audio server\n"
 		"\t-u, --unix [path]      Provide serial device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-k, --kernel <image>   Kernel image (bzImage)\n"
@@ -1022,6 +1159,7 @@ static const struct option main_options[] = {
 	{ "monitor", no_argument,       NULL, 'm' },
 	{ "qemu",    required_argument, NULL, 'q' },
 	{ "kernel",  required_argument, NULL, 'k' },
+	{ "audio",   optional_argument, NULL, 'A' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -1041,7 +1179,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "aubdslmq:k:vh", main_options,
+		opt = getopt_long(argc, argv, "aubdslmq:k:A::vh", main_options,
 								NULL);
 		if (opt < 0)
 			break;
@@ -1075,6 +1213,9 @@ int main(int argc, char *argv[])
 		case 'k':
 			kernel_image = optarg;
 			break;
+		case 'A':
+			audio_server = optarg ? optarg : "/usr/bin/pipewire";
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
-- 
2.40.1

