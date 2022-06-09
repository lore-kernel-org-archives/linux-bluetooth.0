Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31678C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jun 2022 19:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbiFITFH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jun 2022 15:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbiFITFB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jun 2022 15:05:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1878E53C67
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 12:05:00 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D7185660172C
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 20:04:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654801499;
        bh=b5e000RGoFU2yaUdrCQX8UMkpAdNEdPcZrZDeZayO38=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GjH1FQ3UR+yjrzfhe+f0pfHlm9qmfN4qaObg/a9ewP8UzN8c6lniVz5TeM3V/H1Tw
         KVMCSVUeZAxLesmXf4ZWhgZPSIsEzE7TArB/NluYOXKzCl9CtNzyMA6Uxh0Vlv9dSQ
         c8tagjuYPCmMRo3Vloo9o9fmAra62RBfOyBz/mvRJciW+N9M4ayVEYs6aw6KstqZfI
         CI6y0O8b4QhW+DrKX01jZL3JktLGGelkwGds9AJ6j+QnbDocIhCDvIYD+0gv5I7cOU
         6E0kg7saiutKQALZn7/FtFh2+I5mzVTbo8lymYa4QkQ9oBb2aZUVEPr+2uiHr8RuoO
         UpALXt6pbYihQ==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] test-runner: Add DBus session support
Date:   Thu,  9 Jun 2022 21:04:40 +0200
Message-Id: <20220609190442.74325-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609190442.74325-1-frederic.danis@collabora.com>
References: <20220609190442.74325-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Audio daemons requests access to DBus session to start
---
 tools/test-runner.c | 97 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 12 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 945a16a77..8e0e2b42b 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -47,6 +47,7 @@ static int test_argc;
 
 static bool run_auto = false;
 static bool start_dbus = false;
+static bool start_dbus_session = false;
 static bool start_daemon = false;
 static bool start_emulator = false;
 static bool start_monitor = false;
@@ -251,9 +252,11 @@ static void start_qemu(void)
 				"acpi=off pci=noacpi noapic quiet ro init=%s "
 				"bluetooth.enable_ecred=1"
 				"TESTHOME=%s TESTDBUS=%u TESTDAEMON=%u "
+				"TESTDBUSSESSION=%u XDG_RUNTIME_DIR=/run/user/0 "
 				"TESTMONITOR=%u TESTEMULATOR=%u TESTDEVS=%d "
 				"TESTAUTO=%u TESTARGS=\'%s\'",
 				initcmd, cwd, start_dbus, start_daemon,
+				start_dbus_session,
 				start_monitor, start_emulator, num_devs,
 				run_auto, testargs);
 
@@ -420,19 +423,63 @@ static void create_dbus_system_conf(void)
 	mkdir("/run/dbus", 0755);
 }
 
-static pid_t start_dbus_daemon(void)
+static void create_dbus_session_conf(void)
+{
+	FILE *fp;
+
+	fp = fopen("/etc/dbus-1/session.conf", "we");
+	if (!fp)
+		return;
+
+	fputs("<!DOCTYPE busconfig PUBLIC "
+		"\"-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN\" "
+		"\"http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd\">\n", fp);
+	fputs("<busconfig>\n", fp);
+	fputs("<type>session</type>\n", fp);
+	fputs("<listen>unix:path=/run/user/0/bus</listen>\n", fp);
+	fputs("<policy context=\"default\">\n", fp);
+	fputs("<allow user=\"*\"/>\n", fp);
+	fputs("<allow own=\"*\"/>\n", fp);
+	fputs("<allow send_type=\"method_call\"/>\n", fp);
+	fputs("<allow send_type=\"signal\"/>\n", fp);
+	fputs("<allow send_type=\"method_return\"/>\n", fp);
+	fputs("<allow send_type=\"error\"/>\n", fp);
+	fputs("<allow receive_type=\"method_call\"/>\n", fp);
+	fputs("<allow receive_type=\"signal\"/>\n", fp);
+	fputs("<allow receive_type=\"method_return\"/>\n", fp);
+	fputs("<allow receive_type=\"error\"/>\n", fp);
+	fputs("</policy>\n", fp);
+	fputs("</busconfig>\n", fp);
+
+	fclose(fp);
+
+	if (symlink("/etc/dbus-1/session.conf",
+				"/usr/share/dbus-1/session.conf") < 0)
+		perror("Failed to create session.conf symlink");
+
+	mkdir("/run/user", 0755);
+	mkdir("/run/user/0", 0755);
+}
+
+static pid_t start_dbus_daemon(bool session)
 {
 	char *argv[3], *envp[1];
 	pid_t pid;
 	int i;
+	char *bus_type = session ? "session" : "system";
+	char *socket_path = session ?
+			"/run/user/0/bus" : "/run/dbus/system_bus_socket";
 
 	argv[0] = "/usr/bin/dbus-daemon";
-	argv[1] = "--system";
+	if (session)
+		argv[1] = "--session";
+	else
+		argv[1] = "--system";
 	argv[2] = NULL;
 
 	envp[0] = NULL;
 
-	printf("Starting D-Bus daemon\n");
+	printf("Starting D-Bus %s daemon\n", bus_type);
 
 	pid = fork();
 	if (pid < 0) {
@@ -445,13 +492,13 @@ static pid_t start_dbus_daemon(void)
 		exit(EXIT_SUCCESS);
 	}
 
-	printf("D-Bus daemon process %d created\n", pid);
+	printf("D-Bus %s daemon process %d created\n", bus_type, pid);
 
 	for (i = 0; i < 20; i++) {
 		struct stat st;
 
-		if (!stat("/run/dbus/system_bus_socket", &st)) {
-			printf("Found D-Bus daemon socket\n");
+		if (!stat(socket_path, &st)) {
+			printf("Found D-Bus %s daemon socket\n", bus_type);
 			return pid;
 		}
 
@@ -666,7 +713,8 @@ static void run_command(char *cmdname, char *home)
 	char *argv[9], *envp[3];
 	int pos = 0, idx = 0;
 	int serial_fd;
-	pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid;
+	pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
+	      dbus_session_pid;
 
 	if (num_devs) {
 		const char *node = "/dev/ttyS1";
@@ -684,10 +732,16 @@ static void run_command(char *cmdname, char *home)
 
 	if (start_dbus) {
 		create_dbus_system_conf();
-		dbus_pid = start_dbus_daemon();
+		dbus_pid = start_dbus_daemon(false);
 	} else
 		dbus_pid = -1;
 
+	if (start_dbus_session) {
+		create_dbus_session_conf();
+		dbus_session_pid = start_dbus_daemon(true);
+	} else
+		dbus_session_pid = -1;
+
 	if (start_daemon)
 		daemon_pid = start_bluetooth_daemon(home);
 	else
@@ -780,7 +834,12 @@ start_next:
 			printf("Process %d continued\n", corpse);
 
 		if (corpse == dbus_pid) {
-			printf("D-Bus daemon terminated\n");
+			printf("D-Bus system daemon terminated\n");
+			dbus_pid = -1;
+		}
+
+		if (corpse == dbus_session_pid) {
+			printf("D-Bus session daemon terminated\n");
 			dbus_pid = -1;
 		}
 
@@ -814,6 +873,9 @@ start_next:
 	if (dbus_pid > 0)
 		kill(dbus_pid, SIGTERM);
 
+	if (dbus_session_pid > 0)
+		kill(dbus_session_pid, SIGTERM);
+
 	if (emulator_pid > 0)
 		kill(dbus_pid, SIGTERM);
 
@@ -874,10 +936,16 @@ static void run_tests(void)
 
 	ptr = strstr(cmdline, "TESTDBUS=1");
 	if (ptr) {
-		printf("D-Bus daemon requested\n");
+		printf("D-Bus system daemon requested\n");
 		start_dbus = true;
 	}
 
+	ptr = strstr(cmdline, "TESTDBUSSESSION=1");
+	if (ptr) {
+		printf("D-Bus session daemon requested\n");
+		start_dbus_session = true;
+	}
+
 	ptr = strstr(cmdline, "TESTDAEMON=1");
 	if (ptr) {
 		printf("bluetoothd requested\n");
@@ -914,7 +982,8 @@ static void usage(void)
 	printf("\ttest-runner [options] [--] <command> [args]\n");
 	printf("Options:\n"
 		"\t-a, --auto             Find tests and run them\n"
-		"\t-b, --dbus             Start D-Bus daemon\n"
+		"\t-b, --dbus             Start D-Bus system daemon\n"
+		"\t-s, --dbus-session     Start D-Bus session daemon\n"
 		"\t-d, --daemon           Start bluetoothd\n"
 		"\t-m, --monitor          Start btmon\n"
 		"\t-l, --emulator         Start btvirt\n"
@@ -928,6 +997,7 @@ static const struct option main_options[] = {
 	{ "all",     no_argument,       NULL, 'a' },
 	{ "auto",    no_argument,       NULL, 'a' },
 	{ "dbus",    no_argument,       NULL, 'b' },
+	{ "dbus-session", no_argument,  NULL, 's' },
 	{ "unix",    no_argument,       NULL, 'u' },
 	{ "daemon",  no_argument,       NULL, 'd' },
 	{ "emulator", no_argument,      NULL, 'l' },
@@ -953,7 +1023,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "aubdlmq:k:vh", main_options,
+		opt = getopt_long(argc, argv, "aubdslmq:k:vh", main_options,
 								NULL);
 		if (opt < 0)
 			break;
@@ -968,6 +1038,9 @@ int main(int argc, char *argv[])
 		case 'b':
 			start_dbus = true;
 			break;
+		case 's':
+			start_dbus_session = true;
+			break;
 		case 'd':
 			start_dbus = true;
 			start_daemon = true;
-- 
2.25.1

