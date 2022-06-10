Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5912CC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 07:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346882AbiFJH3I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 03:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346811AbiFJH3G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 03:29:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD7454026
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 00:29:01 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E52816601761
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 08:28:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654846140;
        bh=82IgAWfLFNYPlguWJ7ZoflXqL3Yi81c7nu3MMQTh9QU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=T4wiv/qkIAbSo9jidqS/M+cqhJB99GMlnUMhcXyoe72Qny3bQSogPKGrboju1K8gU
         Iu4hc8jZ0fhZZyf+EXH+L4hIoZ0fsTHoa+e/nokx5CuZHT69E7TUXj2fmjcVf/xstM
         20/WzFjq+T/qfBYbhXsZTaqMJm5OWMeK9rdFrVdlf5K96shNEnyracpdsNZJzHIX4f
         44Qco/zb22F8UpGJ4PhJpetMffAKWfM3eR3EOsDRaZcRPZDIuTvLjBXNspfZ7tSVNt
         fMHFShyg3fTd+JQCzoW3gsp3GvoVutahTbTJvD+dfvWdHWYqgQj7jN7WCKNGB1EgB/
         ox5Wv58MPtIcw==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] test-runner: Add udevd and trigger events
Date:   Fri, 10 Jun 2022 09:28:50 +0200
Message-Id: <20220610072850.16593-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610072850.16593-1-frederic.danis@collabora.com>
References: <20220610072850.16593-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Kernel events should have been managed so the audio card is accessible
from PipeWire
---
 tools/test-runner.c | 83 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index bbbca5b5d..e79e3b6e9 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -251,13 +251,14 @@ static void start_qemu(void)
 				"rootfstype=9p "
 				"rootflags=trans=virtio,version=9p2000.L "
 				"acpi=off pci=noacpi noapic quiet ro init=%s "
-				"bluetooth.enable_ecred=1"
+				"bluetooth.enable_ecred=1 "
 				"TESTHOME=%s TESTDBUS=%u TESTDAEMON=%u "
 				"TESTDBUSSESSION=%u XDG_RUNTIME_DIR=/run/user/0 "
+				"AUDIO_SUPPORT=%u "
 				"TESTMONITOR=%u TESTEMULATOR=%u TESTDEVS=%d "
 				"TESTAUTO=%u TESTARGS=\'%s\'",
 				initcmd, cwd, start_dbus, start_daemon,
-				start_dbus_session,
+				start_dbus_session, audio_support,
 				start_monitor, start_emulator, num_devs,
 				run_auto, testargs);
 
@@ -724,13 +725,70 @@ static pid_t start_btvirt(const char *home)
 	return pid;
 }
 
+static void trigger_udev(void)
+{
+	char *argv[3], *envp[1];
+	pid_t pid;
+
+	argv[0] = "/bin/udevadm";
+	argv[1] = "trigger";
+	argv[2] = NULL;
+
+	envp[0] = NULL;
+
+	printf("Triggering udev events\n");
+
+	pid = fork();
+	if (pid < 0) {
+		perror("Failed to fork new process");
+		return;
+	}
+
+	if (pid == 0) {
+		execve(argv[0], argv, envp);
+		exit(EXIT_SUCCESS);
+	}
+
+	printf("udev trigger process %d created\n", pid);
+}
+
+static pid_t start_udevd(void)
+{
+	char *argv[2], *envp[1];
+	pid_t pid;
+
+	argv[0] = "/lib/systemd/systemd-udevd";
+	argv[1] = NULL;
+
+	envp[0] = NULL;
+
+	printf("Starting udevd daemon\n");
+
+	pid = fork();
+	if (pid < 0) {
+		perror("Failed to fork new process");
+		return -1;
+	}
+
+	if (pid == 0) {
+		execve(argv[0], argv, envp);
+		exit(EXIT_SUCCESS);
+	}
+
+	printf("udevd daemon process %d created\n", pid);
+
+	trigger_udev();
+
+	return pid;
+}
+
 static void run_command(char *cmdname, char *home)
 {
 	char *argv[9], *envp[3];
 	int pos = 0, idx = 0;
 	int serial_fd;
 	pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
-	      dbus_session_pid;
+	      dbus_session_pid, udevd_pid;
 
 	if (num_devs) {
 		const char *node = "/dev/ttyS1";
@@ -746,6 +804,11 @@ static void run_command(char *cmdname, char *home)
 	} else
 		serial_fd = -1;
 
+	if (audio_support)
+		udevd_pid = start_udevd();
+	else
+		udevd_pid = -1;
+
 	if (start_dbus) {
 		create_dbus_system_conf();
 		dbus_pid = start_dbus_daemon(false);
@@ -874,6 +937,11 @@ start_next:
 			monitor_pid = -1;
 		}
 
+		if (corpse == udevd_pid) {
+			printf("udevd terminated\n");
+			udevd_pid = -1;
+		}
+
 		if (corpse == pid)
 			break;
 	}
@@ -898,6 +966,9 @@ start_next:
 	if (monitor_pid > 0)
 		kill(monitor_pid, SIGTERM);
 
+	if (udevd_pid > 0)
+		kill(udevd_pid, SIGTERM);
+
 	if (serial_fd >= 0) {
 		close(serial_fd);
 		serial_fd = -1;
@@ -980,6 +1051,12 @@ static void run_tests(void)
 		start_emulator = true;
 	}
 
+	ptr = strstr(cmdline, "AUDIO_SUPPORT=1");
+	if (ptr) {
+		printf("Audio support requested\n");
+		audio_support = true;
+	}
+
 	ptr = strstr(cmdline, "TESTHOME=");
 	if (ptr) {
 		home = ptr + 4;
-- 
2.25.1

