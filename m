Return-Path: <SRS0=rlJ7=OJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BF1C65BAE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4768B2145D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3mD9hd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4768B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeK3V3S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:29:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45445 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeK3V3R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Nov 2018 16:29:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so4481769ljd.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Nov 2018 02:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ptKp+kZ+Z0Rmg6walBQ1pATkHvqKDEgVNmkv1MTGcno=;
        b=i3mD9hd1cQlqJSD6m0HOSd0dTgNgqH7rre9S0biVr45mbkuhcJe/x0SSROqQxifRv5
         ILn4GQUVwJmu74/hOMi5+SAKsBGoYGM//F/pa13lj2Zbhu+3Rgriz8zhSqdGii2i5npX
         24/oL7wcaGd9J1XMzc4CAkCgyRUcsKuAToF9SQYX99X43/8vdPrv+pUuGpGHNC//s5uJ
         p6Leppl1W7y57/P/72PaFwJPbWmqEZU4hX5pod8V//BWZBw+PMlnJ+Px8IihWpSmIOjt
         wVMAMeyeG914O7cOQSSietkGoB60bCmOErFVWdptYKPVUTEdikyw802VKbMjl7w93CYt
         7W6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ptKp+kZ+Z0Rmg6walBQ1pATkHvqKDEgVNmkv1MTGcno=;
        b=bSt4kzOdhKW2GkcpRKXDge5oGhg+0+yQD7X0PbPW77vZI6+1MrBkfig/km86a9OuVT
         VjcRLaOF3PJx8MLVHsWeW6gNP2DEyOFWmZKoTlgkmiFX4uaDQH4bhKwAv1Fda7FI0Y25
         xZn/q5PuhbcvDEGtMpWPi6NBRdle+rE2fT1a8NWMyRy1KEIn8hVRn+IjliCVC4ar8q/I
         bRH3XmimdlxBS+ANuqg6BwGbtbkg4ksFhnTpOPlR7jYJYdd6knl9W6mS5edLaAdljOVo
         jIFdFUFdYeYjhdI9mYDPPmu96hHvTGlwVaCExRyKzuEbY00cuENQ2mwTiz99boXkhXHX
         XPUQ==
X-Gm-Message-State: AA+aEWbIJSBSp9Z18+7g2GSPO2llXvYPNLbBhrYuLRRaVsAU5rFnQeG7
        So/F+0uK4aw0uPWsHUlbEgmGkYTF+PA=
X-Google-Smtp-Source: AFSGD/W3ElMMVkHg/xoTashu1WO+9lpYgLUstSrjFEo1mvkcPYlXhwOrfbJdBknXnVJw9z3Z+ir85A==
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr3428918lja.24.1543573225504;
        Fri, 30 Nov 2018 02:20:25 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id i127-v6sm707708lji.3.2018.11.30.02.20.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 02:20:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 08/10] shared/mainloop: Remove mainloop_set_signal
Date:   Fri, 30 Nov 2018 12:20:11 +0200
Message-Id: <20181130102013.29023-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130102013.29023-1-luiz.dentz@gmail.com>
References: <20181130102013.29023-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes mainloop_set_signal and replaces it usage with
mainloop_run_with_signal.
---
 android/bluetoothd-snoop.c |  9 +----
 android/system-emulator.c  | 10 +----
 emulator/b1ee.c            |  9 +----
 emulator/hfp.c             | 10 +----
 emulator/main.c            |  9 +----
 monitor/main.c             |  9 +----
 peripheral/main.c          | 10 +----
 src/shared/mainloop.c      | 79 --------------------------------------
 src/shared/shell.c         | 54 ++------------------------
 tools/3dsp.c               |  9 +----
 tools/advtest.c            |  9 +----
 tools/bluemoon.c           |  9 +----
 tools/btattach.c           |  9 +----
 tools/btconfig.c           |  9 +----
 tools/btgatt-client.c      |  9 +----
 tools/btgatt-server.c      |  9 +----
 tools/btinfo.c             |  9 +----
 tools/btmon-logger.c       |  9 +----
 tools/btproxy.c            |  9 +----
 tools/eddystone.c          |  9 +----
 tools/ibeacon.c            |  9 +----
 tools/oobtest.c            |  9 +----
 22 files changed, 24 insertions(+), 292 deletions(-)

diff --git a/android/bluetoothd-snoop.c b/android/bluetoothd-snoop.c
index 8d9a2d087..25cddee34 100644
--- a/android/bluetoothd-snoop.c
+++ b/android/bluetoothd-snoop.c
@@ -219,7 +219,6 @@ static void set_capabilities(void)
 int main(int argc, char *argv[])
 {
 	const char *path;
-	sigset_t mask;
 
 	__btd_log_init(NULL, 0);
 
@@ -234,12 +233,6 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	if (!strcmp(DEFAULT_SNOOP_FILE, path))
 		rename(DEFAULT_SNOOP_FILE, DEFAULT_SNOOP_FILE ".old");
 
@@ -250,7 +243,7 @@ int main(int argc, char *argv[])
 
 	info("bluetoothd_snoop: started");
 
-	mainloop_run();
+	mainloop_run_with_signal(signal_callback, NULL);
 
 	close_monitor();
 
diff --git a/android/system-emulator.c b/android/system-emulator.c
index 1545dcea1..8bcf660e2 100644
--- a/android/system-emulator.c
+++ b/android/system-emulator.c
@@ -216,19 +216,11 @@ static void signal_callback(int signum, void *user_data)
 int main(int argc, char *argv[])
 {
 	const char SYSTEM_SOCKET_PATH[] = "\0android_system";
-	sigset_t mask;
 	struct sockaddr_un addr;
 	int fd;
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-	sigaddset(&mask, SIGCHLD);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	printf("Android system emulator ver %s\n", VERSION);
 
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
@@ -254,5 +246,5 @@ int main(int argc, char *argv[])
 	/* Make sure bluetoothd creates files with proper permissions */
 	umask(0177);
 
-	return mainloop_run();
+	return mainloop_run_with_signal(signal_callback, NULL);
 }
diff --git a/emulator/b1ee.c b/emulator/b1ee.c
index 1253a3dca..0d5226fcc 100644
--- a/emulator/b1ee.c
+++ b/emulator/b1ee.c
@@ -265,7 +265,6 @@ int main(int argc, char *argv[])
 	char *server_port = NULL, *sniffer_port = NULL;
 	int ret = EXIT_FAILURE;
 	ssize_t written;
-	sigset_t mask;
 
 	for (;;) {
 		int opt;
@@ -323,17 +322,11 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	mainloop_add_fd(sniffer_fd, EPOLLIN, sniffer_read_callback, NULL, NULL);
 	mainloop_add_fd(server_fd, EPOLLIN, server_read_callback, NULL, NULL);
 	mainloop_add_fd(vhci_fd, EPOLLIN, vhci_read_callback, NULL, NULL);
 
-	ret = mainloop_run();
+	ret = mainloop_run_with_signal(signal_callback, NULL);
 
 	goto done;
 
diff --git a/emulator/hfp.c b/emulator/hfp.c
index e70054adf..29ec63e7d 100644
--- a/emulator/hfp.c
+++ b/emulator/hfp.c
@@ -103,18 +103,10 @@ static void signal_callback(int signum, void *user_data)
 
 int main(int argc, char *argv[])
 {
-	sigset_t mask;
-
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	if (!open_connection())
 		return EXIT_FAILURE;
 
-	return mainloop_run();
+	return mainloop_run_with_signal(signal_callback, NULL);
 }
diff --git a/emulator/main.c b/emulator/main.c
index 56246a3de..68c53488e 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -90,7 +90,6 @@ int main(int argc, char *argv[])
 	int amptest_count = 0;
 	int vhci_count = 0;
 	enum vhci_type vhci_type = VHCI_TYPE_BREDRLE;
-	sigset_t mask;
 	int i;
 
 	mainloop_init();
@@ -154,12 +153,6 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	printf("Bluetooth emulator ver %s\n", VERSION);
 
 	for (i = 0; i < letest_count; i++) {
@@ -227,5 +220,5 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "Failed to open monitor server\n");
 	}
 
-	return mainloop_run();
+	return mainloop_run_with_signal(signal_callback, NULL);
 }
diff --git a/monitor/main.c b/monitor/main.c
index 5fa87ea3f..8640c023d 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -112,7 +112,6 @@ int main(int argc, char *argv[])
 	unsigned short ellisys_port = 0;
 	const char *str;
 	int exit_status;
-	sigset_t mask;
 
 	mainloop_init();
 
@@ -219,12 +218,6 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	printf("Bluetooth monitor ver %s\n", VERSION);
 
 	keys_setup();
@@ -258,7 +251,7 @@ int main(int argc, char *argv[])
 	if (tty && control_tty(tty, tty_speed) < 0)
 		return EXIT_FAILURE;
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 	keys_cleanup();
 
diff --git a/peripheral/main.c b/peripheral/main.c
index d7e10f3d3..93abe2042 100644
--- a/peripheral/main.c
+++ b/peripheral/main.c
@@ -184,7 +184,6 @@ static void signal_callback(int signum, void *user_data)
 
 int main(int argc, char *argv[])
 {
-	sigset_t mask;
 	int exit_status;
 
 	if (getpid() == 1 && getppid() == 0)
@@ -192,13 +191,6 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-	sigaddset(&mask, SIGCHLD);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	printf("Bluetooth periperhal ver %s\n", VERSION);
 
 	prepare_filesystem();
@@ -235,7 +227,7 @@ int main(int argc, char *argv[])
 	if (is_init)
 		attach_start();
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 	if (is_init)
 		attach_stop();
diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index e9ec6e8cd..6a65fa41d 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -67,16 +67,6 @@ struct timeout_data {
 	void *user_data;
 };
 
-struct signal_data {
-	int fd;
-	sigset_t mask;
-	mainloop_signal_func callback;
-	mainloop_destroy_func destroy;
-	void *user_data;
-};
-
-static struct signal_data *signal_data;
-
 void mainloop_init(void)
 {
 	unsigned int i;
@@ -110,45 +100,10 @@ void mainloop_exit_failure(void)
 	epoll_terminate = 1;
 }
 
-static void signal_callback(int fd, uint32_t events, void *user_data)
-{
-	struct signal_data *data = user_data;
-	struct signalfd_siginfo si;
-	ssize_t result;
-
-	if (events & (EPOLLERR | EPOLLHUP)) {
-		mainloop_quit();
-		return;
-	}
-
-	result = read(fd, &si, sizeof(si));
-	if (result != sizeof(si))
-		return;
-
-	if (data->callback)
-		data->callback(si.ssi_signo, data->user_data);
-}
-
 int mainloop_run(void)
 {
 	unsigned int i;
 
-	if (signal_data) {
-		if (sigprocmask(SIG_BLOCK, &signal_data->mask, NULL) < 0)
-			return EXIT_FAILURE;
-
-		signal_data->fd = signalfd(-1, &signal_data->mask,
-						SFD_NONBLOCK | SFD_CLOEXEC);
-		if (signal_data->fd < 0)
-			return EXIT_FAILURE;
-
-		if (mainloop_add_fd(signal_data->fd, EPOLLIN,
-				signal_callback, signal_data, NULL) < 0) {
-			close(signal_data->fd);
-			return EXIT_FAILURE;
-		}
-	}
-
 	while (!epoll_terminate) {
 		struct epoll_event events[MAX_EPOLL_EVENTS];
 		int n, nfds;
@@ -165,14 +120,6 @@ int mainloop_run(void)
 		}
 	}
 
-	if (signal_data) {
-		mainloop_remove_fd(signal_data->fd);
-		close(signal_data->fd);
-
-		if (signal_data->destroy)
-			signal_data->destroy(signal_data->user_data);
-	}
-
 	for (i = 0; i < MAX_MAINLOOP_ENTRIES; i++) {
 		struct mainloop_data *data = mainloop_list[i];
 
@@ -384,29 +331,3 @@ int mainloop_remove_timeout(int id)
 {
 	return mainloop_remove_fd(id);
 }
-
-int mainloop_set_signal(sigset_t *mask, mainloop_signal_func callback,
-				void *user_data, mainloop_destroy_func destroy)
-{
-	struct signal_data *data;
-
-	if (!mask || !callback)
-		return -EINVAL;
-
-	data = malloc(sizeof(*data));
-	if (!data)
-		return -ENOMEM;
-
-	memset(data, 0, sizeof(*data));
-	data->callback = callback;
-	data->destroy = destroy;
-	data->user_data = user_data;
-
-	data->fd = -1;
-	memcpy(&data->mask, mask, sizeof(sigset_t));
-
-	free(signal_data);
-	signal_data = data;
-
-	return 0;
-}
diff --git a/src/shared/shell.c b/src/shared/shell.c
index aabbc5d0e..8ccfe855e 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -864,27 +864,18 @@ static bool io_hup(struct io *io, void *user_data)
 	return false;
 }
 
-static bool signal_read(struct io *io, void *user_data)
+static void signal_callback(int signum, void *user_data)
 {
 	static bool terminated = false;
-	struct signalfd_siginfo si;
-	ssize_t result;
-	int fd;
 
-	fd = io_get_fd(io);
-
-	result = read(fd, &si, sizeof(si));
-	if (result != sizeof(si))
-		return false;
-
-	switch (si.ssi_signo) {
+	switch (signum) {
 	case SIGINT:
 		if (data.input && !data.mode) {
 			rl_replace_line("", 0);
 			rl_crlf();
 			rl_on_new_line();
 			rl_redisplay();
-			return true;
+			return;
 		}
 
 		/*
@@ -907,38 +898,6 @@ static bool signal_read(struct io *io, void *user_data)
 		terminated = true;
 		break;
 	}
-
-	return false;
-}
-
-static struct io *setup_signalfd(void)
-{
-	struct io *io;
-	sigset_t mask;
-	int fd;
-
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
-		perror("Failed to set signal mask");
-		return 0;
-	}
-
-	fd = signalfd(-1, &mask, 0);
-	if (fd < 0) {
-		perror("Failed to create signal descriptor");
-		return 0;
-	}
-
-	io = io_new(fd);
-
-	io_set_close_on_destroy(io, true);
-	io_set_read_handler(io, signal_read, NULL, NULL);
-	io_set_disconnect_handler(io, io_hup, NULL, NULL);
-
-	return io;
 }
 
 static void rl_init_history(void)
@@ -1132,14 +1091,9 @@ static void env_destroy(void *data)
 
 int bt_shell_run(void)
 {
-	struct io *signal;
 	int status;
 
-	signal = setup_signalfd();
-
-	status = mainloop_run();
-
-	io_destroy(signal);
+	status = mainloop_run_with_signal(signal_callback, NULL);
 
 	bt_shell_cleanup();
 
diff --git a/tools/3dsp.c b/tools/3dsp.c
index 686fe139d..77a70c037 100644
--- a/tools/3dsp.c
+++ b/tools/3dsp.c
@@ -570,7 +570,6 @@ int main(int argc, char *argv[])
 	uint16_t index = 0;
 	const char *str;
 	bool use_raw = false;
-	sigset_t mask;
 	int exit_status;
 
 	for (;;) {
@@ -624,12 +623,6 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	printf("3D Synchronization Profile testing ver %s\n", VERSION);
 
 	if (use_raw) {
@@ -654,7 +647,7 @@ int main(int argc, char *argv[])
 	else if (glasses_role)
 		start_glasses();
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 	bt_hci_unref(hci_dev);
 
diff --git a/tools/advtest.c b/tools/advtest.c
index b02301c39..050b570df 100644
--- a/tools/advtest.c
+++ b/tools/advtest.c
@@ -374,7 +374,6 @@ static const struct option main_options[] = {
 
 int main(int argc ,char *argv[])
 {
-	sigset_t mask;
 	int exit_status;
 
 	for (;;) {
@@ -403,12 +402,6 @@ int main(int argc ,char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	mgmt = mgmt_new_default();
 	if (!mgmt) {
 		fprintf(stderr, "Failed to open management socket\n");
@@ -423,7 +416,7 @@ int main(int argc ,char *argv[])
 		goto done;
 	}
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 	bt_hci_unref(adv_dev);
 	bt_hci_unref(scan_dev);
diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index 6051f3002..800541110 100644
--- a/tools/bluemoon.c
+++ b/tools/bluemoon.c
@@ -923,7 +923,6 @@ int main(int argc, char *argv[])
 {
 	const char *str;
 	bool use_raw = false;
-	sigset_t mask;
 	int exit_status;
 
 	for (;;) {
@@ -1000,12 +999,6 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	printf("Bluemoon configuration utility ver %s\n", VERSION);
 
 	if (check_firmware) {
@@ -1030,7 +1023,7 @@ int main(int argc, char *argv[])
 	bt_hci_send(hci_dev, CMD_READ_VERSION, NULL, 0,
 					read_version_complete, NULL, NULL);
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 	bt_hci_unref(hci_dev);
 
diff --git a/tools/btattach.c b/tools/btattach.c
index 5adbc8d83..6eb99bac3 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -231,7 +231,6 @@ int main(int argc, char *argv[])
 {
 	const char *bredr_path = NULL, *amp_path = NULL, *proto = NULL;
 	bool flowctl = true, raw_device = false;
-	sigset_t mask;
 	int exit_status, count = 0, proto_id = HCI_UART_H4;
 	unsigned int speed = B115200;
 
@@ -284,12 +283,6 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	if (proto) {
 		unsigned int i;
 
@@ -348,7 +341,7 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 	return exit_status;
 }
diff --git a/tools/btconfig.c b/tools/btconfig.c
index f171bfbc1..c1ef5834a 100644
--- a/tools/btconfig.c
+++ b/tools/btconfig.c
@@ -75,7 +75,6 @@ static const struct option main_options[] = {
 
 int main(int argc, char *argv[])
 {
-	sigset_t mask;
 	int exit_status;
 
 	for (;;) {
@@ -105,12 +104,6 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	mgmt = mgmt_new_default();
 	if (!mgmt) {
 		fprintf(stderr, "Unable to open mgmt_socket\n");
@@ -120,7 +113,7 @@ int main(int argc, char *argv[])
 	if (getenv("MGMT_DEBUG"))
 		mgmt_set_debug(mgmt, mgmt_debug, "mgmt: ", NULL);
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 	mgmt_cancel_all(mgmt);
 	mgmt_unregister_all(mgmt);
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 51bc3629d..31e849aae 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1518,7 +1518,6 @@ int main(int argc, char *argv[])
 	bdaddr_t src_addr, dst_addr;
 	int dev_id = -1;
 	int fd;
-	sigset_t mask;
 	struct client *cli;
 
 	while ((opt = getopt_long(argc, argv, "+hvs:m:t:d:i:",
@@ -1639,15 +1638,9 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_cb, NULL, NULL);
-
 	print_prompt();
 
-	mainloop_run();
+	mainloop_run_with_signal(signal_cb, NULL);
 
 	printf("\n\nShutting down...\n");
 
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 89812bd75..bc32789d9 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -1139,7 +1139,6 @@ int main(int argc, char *argv[])
 	int sec = BT_SECURITY_LOW;
 	uint8_t src_type = BDADDR_LE_PUBLIC;
 	uint16_t mtu = 0;
-	sigset_t mask;
 	bool hr_visible = false;
 	struct server *server;
 
@@ -1250,15 +1249,9 @@ int main(int argc, char *argv[])
 
 	printf("Running GATT server\n");
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_cb, NULL, NULL);
-
 	print_prompt();
 
-	mainloop_run();
+	mainloop_run_with_signal(signal_cb, NULL);
 
 	printf("\n\nShutting down...\n");
 
diff --git a/tools/btinfo.c b/tools/btinfo.c
index 8e36577d7..5e609739c 100644
--- a/tools/btinfo.c
+++ b/tools/btinfo.c
@@ -226,7 +226,6 @@ int main(int argc, char *argv[])
 	const char *str;
 	bool use_raw = false;
 	bool power_down = false;
-	sigset_t mask;
 	int fd, i, exit_status;
 
 	for (;;) {
@@ -284,12 +283,6 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	printf("Bluetooth information utility ver %s\n", VERSION);
 
 	fd = socket(AF_BLUETOOTH, SOCK_RAW | SOCK_CLOEXEC, BTPROTO_HCI);
@@ -345,7 +338,7 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 	bt_hci_unref(hci_dev);
 
diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
index 1a42824ee..65953d261 100644
--- a/tools/btmon-logger.c
+++ b/tools/btmon-logger.c
@@ -276,7 +276,6 @@ int main(int argc, char *argv[])
 	size_t size_limit = 0;
 	bool parents = false;
 	int exit_status;
-	sigset_t mask;
 	char *endptr;
 
 	mainloop_init();
@@ -365,18 +364,12 @@ int main(int argc, char *argv[])
 
 	drop_capabilities();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	printf("Bluetooth monitor logger ver %s\n", VERSION);
 
 	mainloop_sd_notify("STATUS=Running");
 	mainloop_sd_notify("READY=1");
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 	mainloop_sd_notify("STATUS=Quitting");
 
diff --git a/tools/btproxy.c b/tools/btproxy.c
index 58fa958e6..fd53ca264 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -780,7 +780,6 @@ int main(int argc, char *argv[])
 	bool use_redirect = false;
 	uint8_t type = HCI_PRIMARY;
 	const char *str;
-	sigset_t mask;
 
 	for (;;) {
 		int opt;
@@ -870,12 +869,6 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	if (connect_address || use_redirect) {
 		int host_fd, dev_fd;
 
@@ -930,5 +923,5 @@ int main(int argc, char *argv[])
 							NULL, NULL);
 	}
 
-	return mainloop_run();
+	return mainloop_run_with_signal(signal_callback, NULL);
 }
diff --git a/tools/eddystone.c b/tools/eddystone.c
index f412c90b0..4764c677c 100644
--- a/tools/eddystone.c
+++ b/tools/eddystone.c
@@ -244,7 +244,6 @@ int main(int argc, char *argv[])
 {
 	uint16_t index = 0;
 	const char *str;
-	sigset_t mask;
 	int exit_status;
 
 	for (;;) {
@@ -290,12 +289,6 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	printf("Low Energy Eddystone utility ver %s\n", VERSION);
 
 	hci_dev = bt_hci_new_user_channel(index);
@@ -307,7 +300,7 @@ int main(int argc, char *argv[])
 
 	start_eddystone();
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 	bt_hci_unref(hci_dev);
 
diff --git a/tools/ibeacon.c b/tools/ibeacon.c
index 4b358049c..40078d5ed 100644
--- a/tools/ibeacon.c
+++ b/tools/ibeacon.c
@@ -237,7 +237,6 @@ int main(int argc, char *argv[])
 {
 	uint16_t index = 0;
 	const char *str;
-	sigset_t mask;
 	int exit_status;
 
 	for (;;) {
@@ -283,12 +282,6 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	printf("Low Energy iBeacon utility ver %s\n", VERSION);
 
 	hci_dev = bt_hci_new_user_channel(index);
@@ -300,7 +293,7 @@ int main(int argc, char *argv[])
 
 	start_ibeacon();
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 	bt_hci_unref(hci_dev);
 
diff --git a/tools/oobtest.c b/tools/oobtest.c
index e77320bab..c228b65b1 100644
--- a/tools/oobtest.c
+++ b/tools/oobtest.c
@@ -1026,7 +1026,6 @@ static const struct option main_options[] = {
 
 int main(int argc ,char *argv[])
 {
-	sigset_t mask;
 	int exit_status;
 
 	for (;;) {
@@ -1128,12 +1127,6 @@ int main(int argc ,char *argv[])
 
 	mainloop_init();
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
 	mgmt = mgmt_new_default();
 	if (!mgmt) {
 		fprintf(stderr, "Failed to open management socket\n");
@@ -1148,7 +1141,7 @@ int main(int argc ,char *argv[])
 		goto done;
 	}
 
-	exit_status = mainloop_run();
+	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
 done:
 	mgmt_unref(mgmt);
-- 
2.17.2

