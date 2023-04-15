Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D0FC77B70
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Apr 2023 14:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDOOjc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Apr 2023 10:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDOOjb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Apr 2023 10:39:31 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45461FF7
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Apr 2023 07:39:29 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4C6DB2401ED
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Apr 2023 16:39:28 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PzGDH5YxQz9rxG;
        Sat, 15 Apr 2023 16:39:27 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] tools/test-runner: add option to start Pipewire inside the VM
Date:   Sat, 15 Apr 2023 14:39:19 +0000
Message-Id: <48701651ef435518ac8432d80dfdc2dfe80f3703.1681569400.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add option for launching Pipewire inside the VM to serve Bluetooth
endpoints, which can be used in tests.

If daemon and emulator were also started, wait for the endpoints to
appear.
---

Notes:
    An example how you can launch Pipewire to serve Bluetooth endpoints.

 tools/test-runner.c | 247 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 5 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 6660ea8de..d416f80ed 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -51,6 +51,7 @@ static bool start_dbus_session;
 static bool start_daemon = false;
 static bool start_emulator = false;
 static bool start_monitor = false;
+static bool start_pipewire;
 static int num_devs = 0;
 static const char *qemu_binary = NULL;
 static const char *kernel_image = NULL;
@@ -252,13 +253,13 @@ static void start_qemu(void)
 				"acpi=off pci=noacpi noapic quiet ro init=%s "
 				"TESTHOME=%s TESTDBUS=%u TESTDAEMON=%u "
 				"TESTDBUSSESSION=%u XDG_RUNTIME_DIR=/run/user/0 "
-				"TESTAUDIO=%u "
+				"TESTAUDIO=%u TESTPIPEWIRE=%u "
 				"TESTMONITOR=%u TESTEMULATOR=%u TESTDEVS=%d "
 				"TESTAUTO=%u TESTARGS=\'%s\'",
 				initcmd, cwd, start_dbus, start_daemon,
 				start_dbus_session, audio_support,
-				start_monitor, start_emulator, num_devs,
-				run_auto, testargs);
+				start_pipewire, start_monitor, start_emulator,
+				num_devs, run_auto, testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
 				(audio_support ? 4 : 0) +
@@ -606,6 +607,207 @@ static pid_t start_bluetooth_daemon(const char *home)
 	return pid;
 }
 
+static char *get_command_stdout(char *command, size_t *size)
+{
+	char *buf = NULL;
+	ssize_t nread = 0;
+	size_t allocated = 0;
+	int ret;
+	FILE *f;
+
+	f = popen(command, "re");
+	if (!f)
+		return NULL;
+
+	while (1) {
+		size_t res;
+		void *p;
+
+		if (nread + 256 > allocated) {
+			allocated += allocated + 256;
+			p = realloc(buf, allocated);
+			if (!p) {
+				nread = -1;
+				break;
+			}
+			buf = p;
+		}
+
+		res = fread(buf + nread, 1, allocated - nread - 1, f);
+		if (!res)
+			break;
+		nread += res;
+	}
+
+	ret = pclose(f);
+	if (ret < 0 || !WIFEXITED(ret) || WEXITSTATUS(ret) != 0) {
+		printf("%s failed\n", command);
+		nread = -1;
+	}
+
+	if (nread >= 0) {
+		buf[nread] = 0;
+		if (size)
+			*size = nread;
+	} else {
+		free(buf);
+		buf = NULL;
+	}
+
+	return buf;
+}
+
+static void start_pipewire_daemons(pid_t *pipewire_pid, pid_t *wireplumber_pid)
+{
+	static const char *const daemons[2] = {
+		"/usr/bin/pipewire",
+		"/usr/bin/wireplumber"
+	};
+	static const char *const dirs[] = {
+		"/run/pw",
+		"/run/pw/state",
+		"/run/pw/wireplumber",
+		"/run/pw/wireplumber/bluetooth.lua.d",
+		"/run/pw/wireplumber/main.lua.d",
+		NULL
+	};
+	FILE *f;
+	pid_t *pids[2] = {pipewire_pid, wireplumber_pid};
+	char *envp[5];
+	int i;
+
+	for (i = 0; dirs[i]; ++i) {
+		if (mkdir(dirs[i], 0755) < 0) {
+			perror("Failed to create directory");
+			return;
+		}
+	}
+
+	/* Enable only Bluetooth part, disable whatever requires user DBus */
+	f = fopen("/run/pw/wireplumber/main.lua.d/51-custom.lua", "w");
+	if (!f) {
+		perror("Failed to create Pipewire main config");
+		return;
+	}
+	fprintf(f, "alsa_monitor.enabled = false\n"
+		"v4l2_monitor.enabled = false\n"
+		"libcamera_monitor.enabled = false\n"
+		"default_access.properties[\"enable-flatpak-portal\"]"
+		" = false\n");
+	fclose(f);
+
+	f = fopen("/run/pw/wireplumber/bluetooth.lua.d/51-custom.lua", "w");
+	if (!f) {
+		perror("Failed to create Pipewire bluetooth config");
+		return;
+	}
+	fprintf(f, "bluez_monitor.properties[\"with-logind\"] = false\n"
+		"bluez_midi_monitor.enabled = false\n");
+	fclose(f);
+
+	/* Launch daemons */
+	for (i = 0; i < 2; ++i)
+		*pids[i] = -1;
+
+	envp[0] = "DBUS_SYSTEM_BUS_ADDRESS=unix:"
+		  "path=/run/dbus/system_bus_socket";
+	envp[1] = "XDG_STATE_HOME=/run/pw/state";
+	envp[2] = "XDG_CONFIG_HOME=/run/pw";
+	envp[3] = "XDG_RUNTIME_DIR=/run/pw";
+	envp[4] = NULL;
+
+	for (i = 0; i < 2; ++i) {
+		const char *daemon = daemons[i];
+		char *argv[2];
+		pid_t pid;
+
+		printf("Starting Pipewire daemon %s\n", daemon);
+
+		argv[0] = (char *) daemon;
+		argv[1] = NULL;
+
+		pid = fork();
+		if (pid < 0) {
+			perror("Failed to fork new process");
+			return;
+		}
+
+		if (pid == 0) {
+			execve(argv[0], argv, envp);
+			exit(EXIT_SUCCESS);
+		}
+
+		*pids[i] = pid;
+
+		printf("Pipewire daemon process %d created\n", pid);
+	}
+
+	/* Tell pipewire clients where the socket is */
+	setenv("PIPEWIRE_RUNTIME_DIR", "/run/pw", 1);
+
+	/* Wait until daemons completely started */
+	for (i = 0; i < 6; ++i) {
+		char *buf;
+
+		if (i > 0) {
+			printf("Wait for Pipewire ready...\n");
+			usleep(500000);
+		}
+
+		buf = get_command_stdout("/usr/bin/pw-dump", NULL);
+		if (!buf)
+			continue;
+
+		if (strstr(buf, "WirePlumber")) {
+			printf("Pipewire ready\n");
+			free(buf);
+			break;
+		}
+
+		free(buf);
+	}
+	if (i == 6)
+		goto fail;
+
+	if (!start_emulator || !start_daemon)
+		return;
+
+	/* Wait for Bluetooth endpoints */
+	for (i = 0; i < 6; ++i) {
+		char *buf;
+
+		if (i > 0) {
+			printf("Wait for endpoints...\n");
+			usleep(500000);
+		}
+
+		buf = get_command_stdout("/usr/bin/bluetoothctl show", NULL);
+		if (!buf)
+			continue;
+
+		if (strstr(buf, "0000110b-0000-1000-8000-00805f9b34fb") ||
+		    strstr(buf, "00001850-0000-1000-8000-00805f9b34fb")) {
+			printf("Pipewire endpoints ready\n");
+			free(buf);
+			break;
+		}
+
+		free(buf);
+	}
+	if (i == 6)
+		goto fail;
+
+	return;
+
+fail:
+	for (i = 0; i < 2; ++i)
+		if (*pids[i] > 0)
+			kill(*pids[i], SIGTERM);
+
+	printf("Pipewire daemons not running properly\n");
+	return;
+}
+
 static const char *test_table[] = {
 	"mgmt-tester",
 	"smp-tester",
@@ -807,7 +1009,7 @@ static void run_command(char *cmdname, char *home)
 	int pos = 0, idx = 0;
 	int serial_fd;
 	pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
-	      dbus_session_pid, udevd_pid;
+	      dbus_session_pid, udevd_pid, pw_pid, wp_pid;
 
 	if (!home) {
 		perror("Invalid parameter: TESTHOME");
@@ -860,6 +1062,13 @@ static void run_command(char *cmdname, char *home)
 	else
 		emulator_pid = -1;
 
+	if (start_pipewire) {
+		start_pipewire_daemons(&pw_pid, &wp_pid);
+	} else {
+		pw_pid = -1;
+		wp_pid = -1;
+	}
+
 start_next:
 	if (run_auto) {
 		if (chdir(home + 5) < 0) {
@@ -966,6 +1175,16 @@ start_next:
 			udevd_pid = -1;
 		}
 
+		if (corpse == pw_pid) {
+			printf("pipewire terminated\n");
+			pw_pid = -1;
+		}
+
+		if (corpse == wp_pid) {
+			printf("wireplumber terminated\n");
+			wp_pid = -1;
+		}
+
 		if (corpse == pid)
 			break;
 	}
@@ -975,6 +1194,12 @@ start_next:
 		goto start_next;
 	}
 
+	if (wp_pid > 0)
+		kill(wp_pid, SIGTERM);
+
+	if (pw_pid > 0)
+		kill(pw_pid, SIGTERM);
+
 	if (daemon_pid > 0)
 		kill(daemon_pid, SIGTERM);
 
@@ -1079,6 +1304,12 @@ static void run_tests(void)
 		audio_support = true;
 	}
 
+	ptr = strstr(cmdline, "TESTPIPEWIRE=1");
+	if (ptr) {
+		printf("Pipewire requested\n");
+		start_pipewire = true;
+	}
+
 	ptr = strstr(cmdline, "TESTHOME=");
 	if (ptr) {
 		home = ptr + 4;
@@ -1106,6 +1337,7 @@ static void usage(void)
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-k, --kernel <image>   Kernel image (bzImage)\n"
 		"\t-A, --audio            Add audio support\n"
+		"\t-P, --pipewire         Start pipewire\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -1121,6 +1353,7 @@ static const struct option main_options[] = {
 	{ "qemu",    required_argument, NULL, 'q' },
 	{ "kernel",  required_argument, NULL, 'k' },
 	{ "audio",   no_argument,       NULL, 'A' },
+	{ "pipewire", no_argument,      NULL, 'P' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -1140,7 +1373,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "aubdslmq:k:Avh", main_options,
+		opt = getopt_long(argc, argv, "aubdslmq:k:APvh", main_options,
 								NULL);
 		if (opt < 0)
 			break;
@@ -1177,6 +1410,10 @@ int main(int argc, char *argv[])
 		case 'A':
 			audio_support = true;
 			break;
+		case 'P':
+			start_dbus = true;
+			start_pipewire = true;
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
-- 
2.39.2

