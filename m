Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859E4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 23:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiB1X2E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 18:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiB1X2D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 18:28:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2109DF4AA
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 15:27:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so517110pjb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 15:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ne7Kf6PBLqcfb0I7CSz2GmstTj6i8bK4u1NhmMQSSGA=;
        b=KEXddmpn87v2vkbqJk8WbyxFFDxlIckihqcdbjKRCo3R79sVL4wuSYeb0W8PON91cc
         BdvljqDmgf53TCBrzvGtIzJo0QO0RiY8nBlwyInKpOMS085U694gxke5BBDQgczfRMuz
         Z8zeSbgvklZJdoQGOPAOGniDzed8Y7UhJ3kHPpbmqkxHzQ3GvdMALvs3+LwkjcliRb0s
         QWVJy8yd3Phcei7MmtZYx1wl2xYrnpCQZo5u4PIgN5/dumUbgwR+voy+uy5BHbFU8Dc3
         26X0SsukSsd5cEEN0wkOZlN1ewaT+7X370dZkCZUsDDoSx4hJp+aI8/HH2ftNn1he7mU
         P2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ne7Kf6PBLqcfb0I7CSz2GmstTj6i8bK4u1NhmMQSSGA=;
        b=zDjCKi/zfaTFWyr2Xd6hkCl06DzzfhkzRX56MP9o36Pqct6i5MRy3WOeu3/74qyI7F
         qHSZKsWoYzk7u0LOsliy897m1X0S98U22JMSpL4SxWTmiIWv+GeViRlSZbIiuJbdkG0k
         EpbwtPpjDDxskPhk75Ej7MM3RpqwOItxLsfeQ1z4WsAE4axtcDTh5GyLTQQ93EjLpArB
         WTZDz/9UH9QAKGAslhHcLg/RLd3oTHSNuQRBC8q3PWQfuBqYQDqV1Sm73r6zBsvE1kHq
         9YBZmnS0qLdP+PP2Pg/jpUColeZbe2F8Cd89/jPwSsu+OufWJK6gQuzFpi/JLFdI+lBC
         ESmA==
X-Gm-Message-State: AOAM531cvBUZY8Q7bOzG9YNyaUHHwDTNJjDCD9xijetFEm++mal4rr2P
        nHHVAt6CXkcwd+gEo0mCAbdxWTjh2Lo=
X-Google-Smtp-Source: ABdhPJxJCe7fPQldzQknf/fG6/inQQ2rX9sE2sT2Dc5z6SC4WEDMez2S+lZVG/yTCoP4pQmWMfvT7Q==
X-Received: by 2002:a17:902:ba8c:b0:14f:d9b7:ab4 with SMTP id k12-20020a170902ba8c00b0014fd9b70ab4mr23130603pls.23.1646090841117;
        Mon, 28 Feb 2022 15:27:21 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y39-20020a056a00182700b004e19980d6cbsm14930874pfa.210.2022.02.28.15.27.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:27:20 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] test-runner: Add option to start emulator
Date:   Mon, 28 Feb 2022 15:27:20 -0800
Message-Id: <20220228232720.1614099-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds an option (-l/--emulator) to start btvirt before processing
the command which is convenient to runs tools like bluetoothctl:

  sudo tools/test-runner -l -d -k <pathto/bzImage> --
  client/bluetoothctl power on
---
 tools/test-runner.c | 86 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 71cc0d2df..e0e002dd6 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -47,6 +47,7 @@ static int test_argc;
 
 static bool run_auto = false;
 static bool start_dbus = false;
+static bool start_emulator = false;
 static bool start_monitor = false;
 static int num_devs = 0;
 static const char *qemu_binary = NULL;
@@ -249,9 +250,10 @@ static void start_qemu(void)
 				"acpi=off pci=noacpi noapic quiet ro init=%s "
 				"bluetooth.enable_ecred=1"
 				"TESTHOME=%s TESTDBUS=%u TESTMONITOR=%u "
-				"TESTDEVS=%d TESTAUTO=%u TESTARGS=\'%s\'",
+				"TESTEMULATOR=%u TESTDEVS=%d TESTAUTO=%u "
+				"TESTARGS=\'%s\'",
 				initcmd, cwd, start_dbus, start_monitor,
-				num_devs, run_auto, testargs);
+				start_emulator, num_devs, run_auto, testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
 				(sizeof(char *) * (4 + (num_devs * 4))));
@@ -600,12 +602,64 @@ static pid_t start_btmon(const char *home)
 	return pid;
 }
 
+static const char *btvirt_table[] = {
+	"btvirt",
+	"emulator/btvirt",
+	"/usr/sbin/btvirt",
+	NULL
+};
+
+static pid_t start_btvirt(void)
+{
+	const char *btvirt = NULL;
+	char *argv[3], *envp[2];
+	pid_t pid;
+	int i;
+
+	for (i = 0; btvirt_table[i]; i++) {
+		struct stat st;
+
+		if (!stat(btvirt_table[i], &st)) {
+			btvirt = btvirt_table[i];
+			break;
+		}
+	}
+
+	if (!btvirt) {
+		fprintf(stderr, "Failed to locate btvirt binary\n");
+		return -1;
+	}
+
+	printf("Using %s\n", btvirt);
+
+	argv[0] = (char *) btvirt;
+	argv[1] = "-l";
+	argv[2] = NULL;
+
+	printf("Starting Emulator\n");
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
+	printf("Emulator process %d created\n", pid);
+
+	return pid;
+}
+
 static void run_command(char *cmdname, char *home)
 {
 	char *argv[9], *envp[3];
 	int pos = 0, idx = 0;
 	int serial_fd;
-	pid_t pid, dbus_pid, daemon_pid, monitor_pid;
+	pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid;
 
 	if (num_devs) {
 		const char *node = "/dev/ttyS1";
@@ -635,6 +689,11 @@ static void run_command(char *cmdname, char *home)
 	else
 		monitor_pid = -1;
 
+	if (start_emulator)
+		emulator_pid = start_btvirt();
+	else
+		emulator_pid = -1;
+
 start_next:
 	if (run_auto) {
 		if (chdir(home + 5) < 0) {
@@ -735,6 +794,11 @@ start_next:
 			daemon_pid = -1;
 		}
 
+		if (corpse == emulator_pid) {
+			printf("Bluetooth emulator terminated\n");
+			emulator_pid = -1;
+		}
+
 		if (corpse == monitor_pid) {
 			printf("Bluetooth monitor terminated\n");
 			monitor_pid = -1;
@@ -755,6 +819,9 @@ start_next:
 	if (dbus_pid > 0)
 		kill(dbus_pid, SIGTERM);
 
+	if (emulator_pid > 0)
+		kill(dbus_pid, SIGTERM);
+
 	if (monitor_pid > 0)
 		kill(monitor_pid, SIGTERM);
 
@@ -822,6 +889,12 @@ static void run_tests(void)
 		start_monitor = true;
 	}
 
+	ptr = strstr(cmdline, "TESTEMULATOR=1");
+	if (ptr) {
+		printf("Emulator requested\n");
+		start_emulator = true;
+	}
+
 	ptr = strstr(cmdline, "TESTHOME=");
 	if (ptr) {
 		home = ptr + 4;
@@ -853,6 +926,7 @@ static const struct option main_options[] = {
 	{ "auto",    no_argument,       NULL, 'a' },
 	{ "unix",    no_argument,       NULL, 'u' },
 	{ "dbus",    no_argument,       NULL, 'd' },
+	{ "emulator", no_argument,      NULL, 'l' },
 	{ "monitor", no_argument,       NULL, 'm' },
 	{ "qemu",    required_argument, NULL, 'q' },
 	{ "kernel",  required_argument, NULL, 'k' },
@@ -875,7 +949,8 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "audmq:k:vh", main_options, NULL);
+		opt = getopt_long(argc, argv, "audlmq:k:vh", main_options,
+								NULL);
 		if (opt < 0)
 			break;
 
@@ -889,6 +964,9 @@ int main(int argc, char *argv[])
 		case 'd':
 			start_dbus = true;
 			break;
+		case 'l':
+			start_emulator = true;
+			break;
 		case 'm':
 			start_monitor = true;
 			break;
-- 
2.35.1

