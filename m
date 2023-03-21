Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF17C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 01:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCUBEe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 21:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCUBER (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 21:04:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4766D37F1B
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 18:03:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id y2so14015441pjg.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 18:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679360615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hcly6uuIuDwgtZPqf7oitKPFtiG3urSGrcWCeUaYFUc=;
        b=E2KnwQ/hzFedGxbS30JeZg0zPPS3ehr1BRrmQP9KME9xr04dPBc29y4UU5xkRXBPYq
         zOqU4SKNEDOh62YGOytgpB+SEU8BMG8UczmyHaNVwNbxR0ieN2DFv9ZUJr9bd29jRg1t
         sP1KCd8+bWXPjXOytSi9H/gW9lRoPNdoPCfqK4SIWqXdlKD8xyyfWVjfOrEXnlD5qcjb
         i5cAPcFlxoDdGEALraO3QMmrPhCAKn/uQaPodfNhngLtQT0DIKUZ7KP7cSXv/3iQL2H0
         i71rb3SHm8c7CbOhR+/c+ux8eYGunw6JJg2HvNFHGdjCAoherTW8JjyhX9DZ7dinVUBm
         SVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679360615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcly6uuIuDwgtZPqf7oitKPFtiG3urSGrcWCeUaYFUc=;
        b=sElzAK9CmJunEOg9M9LhSk8yZn6/IvGiI/xYfXS5yFkW1h4FqwIqzP25zjgbd73kRw
         +vr57mm4CpTApmtsxa/9t6DjkZXBkMZMcVz7A3t0i/YsJ6HsCwZ4wS78d/lbRD6K6eDr
         unNShntsZgYSVPQVgJD5bxodKTTXiOFrh14hpR+x7996rt6VDYRhgpmkSqnwO4Z7KDZC
         hT1IIxAjTAZwNkOxjU0DkCABnmlFilueWnuUOzNqwwtc8qOt/K3cnrQjlxIB/YkO8/l2
         xIIVzwRAb4JOYVNzaE51f8gSVfGFAblhNvJTguEToQV++Mjsgr9DO6wQT1VKneN8lmiV
         7Xhg==
X-Gm-Message-State: AO0yUKVZNlqi3CaXRLQpV97xxobsO64MFdd4UVON2HfgSW9Y8u3kF1rh
        1JErujMCST2SFqAXeReA1jghOWVQndo=
X-Google-Smtp-Source: AK7set9drG9tJCdpPOA/TTqArTR7rQ+ALQs9ltNIcljZBGwJSTjvTrQpFAXckiOG91BmLXONvNhKcg==
X-Received: by 2002:a17:902:fb86:b0:1a0:6eb4:3871 with SMTP id lg6-20020a170902fb8600b001a06eb43871mr397073plb.20.1679360614822;
        Mon, 20 Mar 2023 18:03:34 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id jc7-20020a17090325c700b001a0667822c8sm7323648plb.94.2023.03.20.18.03.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 18:03:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/shell: Add support for -i/--init-script
Date:   Mon, 20 Mar 2023 18:03:32 -0700
Message-Id: <20230321010333.2361384-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for -i/--init-script which can be used to provide a
file with commands to be initialized, the commands are then run in
sequence after completing:

client/bluetoothctl -i client/power-on-off.bt
Agent registered
Changing power on succeeded
[CHG] Controller A8:7E:EA:56:87:D5 Pairable: yes
[CHG] Controller 98:8D:46:EE:6D:16 Pairable: yes
[CHG] Controller 98:8D:46:EE:6D:16 PowerState: on-disabling
AdvertisementMonitor path registered
---
 src/shared/shell.c | 163 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 145 insertions(+), 18 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 3358b383e9e4..58906870f152 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -24,6 +24,7 @@
 #include <sys/signalfd.h>
 #include <wordexp.h>
 #include <getopt.h>
+#include <fcntl.h>
 
 #include <readline/readline.h>
 #include <readline/history.h>
@@ -69,7 +70,12 @@ static struct {
 	bool zsh;
 	bool monitor;
 	int timeout;
-	struct io *input;
+	int init_fd;
+	FILE *f;
+	struct queue *inputs;
+
+	wordexp_t *w;
+	struct queue *queue;
 
 	bool saved_prompt;
 	bt_shell_prompt_input_func saved_func;
@@ -535,7 +541,7 @@ void bt_shell_printf(const char *fmt, ...)
 	char *saved_line;
 	int saved_point;
 
-	if (!data.input)
+	if (queue_isempty(data.inputs))
 		return;
 
 	if (data.mode) {
@@ -988,6 +994,11 @@ static char **shell_completion(const char *text, int start, int end)
 
 static bool io_hup(struct io *io, void *user_data)
 {
+	if (queue_remove(data.inputs, io)) {
+		if (!queue_isempty(data.inputs))
+			return false;
+	}
+
 	mainloop_quit();
 
 	return false;
@@ -999,7 +1010,7 @@ static void signal_callback(int signum, void *user_data)
 
 	switch (signum) {
 	case SIGINT:
-		if (data.input && !data.mode) {
+		if (!queue_isempty(data.inputs) && !data.mode) {
 			rl_replace_line("", 0);
 			rl_crlf();
 			rl_on_new_line();
@@ -1091,6 +1102,7 @@ static void rl_init(void)
 static const struct option main_options[] = {
 	{ "version",	no_argument, 0, 'v' },
 	{ "help",	no_argument, 0, 'h' },
+	{ "init-script",required_argument, 0, 'i' },
 	{ "timeout",	required_argument, 0, 't' },
 	{ "monitor",	no_argument, 0, 'm' },
 	{ "zsh-complete",	no_argument, 0, 'z' },
@@ -1112,6 +1124,7 @@ static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
 	printf("\t--monitor \tEnable monitor output\n"
 		"\t--timeout \tTimeout in seconds for non-interactive mode\n"
 		"\t--version \tDisplay version\n"
+		"\t--init-script \tInit script file\n"
 		"\t--help \t\tDisplay help\n");
 }
 
@@ -1130,9 +1143,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	if (opt) {
 		memcpy(options + offset, opt->options,
 				sizeof(struct option) * opt->optno);
-		snprintf(optstr, sizeof(optstr), "+mhvt:%s", opt->optstr);
+		snprintf(optstr, sizeof(optstr), "+mhvi:t:%s", opt->optstr);
 	} else
-		snprintf(optstr, sizeof(optstr), "+mhvt:");
+		snprintf(optstr, sizeof(optstr), "+mhvi:t:");
 
 	data.name = strrchr(argv[0], '/');
 	if (!data.name)
@@ -1140,6 +1153,8 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	else
 		data.name = strdup(++data.name);
 
+	data.init_fd = -1;
+
 	while ((c = getopt_long(argc, argv, optstr, options, &index)) != -1) {
 		switch (c) {
 		case 'v':
@@ -1152,6 +1167,12 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 			data.argv = &cmplt;
 			data.mode = 1;
 			goto done;
+		case 'i':
+			data.init_fd = open(optarg, O_RDONLY);
+			if (data.init_fd < 0)
+				printf("Unable to open %s: %s (%d)\n", optarg,
+						strerror(errno), errno);
+			break;
 		case 't':
 			if (optarg)
 				data.timeout = strtol(optarg, &endptr, 0);
@@ -1205,6 +1226,8 @@ done:
 	rl_init();
 
 	data.init = true;
+	data.inputs = queue_new();
+	data.queue = queue_new();
 	data.prompts = queue_new();
 }
 
@@ -1239,6 +1262,23 @@ int bt_shell_run(void)
 	return status;
 }
 
+static int shell_queue(const wordexp_t *w)
+{
+	int err;
+
+	/* Queue if already executing */
+	if (data.w) {
+		queue_push_tail(data.queue, util_memdup(w, sizeof(*w)));
+		return 0;
+	}
+
+	err = shell_exec(w->we_wordc, w->we_wordv);
+	if (!err)
+		data.w = util_memdup(w, sizeof(*w));
+
+	return err;
+}
+
 int bt_shell_exec(const char *input)
 {
 	wordexp_t w;
@@ -1247,21 +1287,44 @@ int bt_shell_exec(const char *input)
 	if (!input)
 		return 0;
 
-	if (wordexp(input, &w, WRDE_NOCMD))
-		return -ENOEXEC;
+	err = wordexp(input, &w, WRDE_NOCMD);
+	switch (err) {
+	case WRDE_BADCHAR:
+		return -EBADMSG;
+	case WRDE_BADVAL:
+	case WRDE_SYNTAX:
+		return -EINVAL;
+	case WRDE_NOSPACE:
+		return -ENOMEM;
+	case WRDE_CMDSUB:
+		if (wordexp(input, &w, 0))
+			return -ENOEXEC;
+		break;
+	};
 
 	if (w.we_wordc == 0) {
 		wordfree(&w);
 		return -ENOEXEC;
 	}
 
-	err = shell_exec(w.we_wordc, w.we_wordv);
+	if (data.f) {
+		err = shell_queue(&w);
+		if (!err)
+			return 0;
+	} else
+		err = shell_exec(w.we_wordc, w.we_wordv);
 
 	wordfree(&w);
 
 	return err;
 }
 
+static void shell_word_free(void *data)
+{
+	wordfree(data);
+	free(data);
+}
+
 void bt_shell_cleanup(void)
 {
 	bt_shell_release_prompt("");
@@ -1277,6 +1340,8 @@ void bt_shell_cleanup(void)
 
 	rl_cleanup();
 
+	queue_destroy(data.inputs, NULL);
+	queue_destroy(data.queue, shell_word_free);
 	queue_destroy(data.prompts, prompt_free);
 	data.prompts = NULL;
 
@@ -1292,10 +1357,31 @@ void bt_shell_quit(int status)
 		mainloop_exit_failure();
 }
 
+static void shell_dequeue(void)
+{
+	int err;
+
+	if (!data.w)
+		return;
+
+	shell_word_free(data.w);
+	data.w = NULL;
+
+	data.w = queue_pop_head(data.queue);
+	if (!data.w)
+		return;
+
+	err = shell_exec(data.w->we_wordc, data.w->we_wordv);
+	if (err)
+		shell_dequeue();
+}
+
 void bt_shell_noninteractive_quit(int status)
 {
-	if (!data.mode || data.timeout)
+	if (!data.mode || data.timeout) {
+		shell_dequeue();
 		return;
+	}
 
 	bt_shell_quit(status);
 }
@@ -1340,7 +1426,44 @@ void bt_shell_set_prompt(const char *string)
 
 static bool input_read(struct io *io, void *user_data)
 {
-	rl_callback_read_char();
+	int fd;
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+
+	fd = io_get_fd(io);
+
+	if (fd == STDIN_FILENO) {
+		rl_callback_read_char();
+		return true;
+	}
+
+	if (!data.f) {
+		data.f = fdopen(fd, "r");
+		if (!data.f) {
+			printf("fdopen: %s (%d)\n", strerror(errno), errno);
+			return false;
+		}
+	}
+
+	nread = getline(&line, &len, data.f);
+	if (nread > 0) {
+		int err;
+
+		if (line[nread - 1] == '\n')
+			line[nread - 1] = '\0';
+
+		err = bt_shell_exec(line);
+		if (err < 0)
+			printf("%s: %s (%d)\n", line, strerror(-err), -err);
+
+	} else {
+		fclose(data.f);
+		data.f = NULL;
+	}
+
+	free(line);
+
 	return true;
 }
 
@@ -1355,18 +1478,16 @@ bool bt_shell_attach(int fd)
 {
 	struct io *io;
 
-	/* TODO: Allow more than one input? */
-	if (data.input)
-		return false;
-
 	io = io_new(fd);
+	if (!io)
+		return false;
 
 	if (!data.mode) {
 		io_set_read_handler(io, input_read, NULL, NULL);
 		io_set_disconnect_handler(io, io_hup, NULL, NULL);
 	}
 
-	data.input = io;
+	queue_push_tail(data.inputs, io);
 
 	if (data.mode) {
 		if (shell_exec(data.argc, data.argv) < 0) {
@@ -1377,6 +1498,12 @@ bool bt_shell_attach(int fd)
 		if (data.timeout)
 			timeout_add(data.timeout * 1000, shell_quit, NULL,
 								NULL);
+	} else if (data.init_fd >= 0) {
+		int fd = data.init_fd;
+
+		data.init_fd = -1;
+		if (!bt_shell_attach(fd))
+			return false;
 	}
 
 	return true;
@@ -1384,11 +1511,11 @@ bool bt_shell_attach(int fd)
 
 bool bt_shell_detach(void)
 {
-	if (!data.input)
+	if (queue_isempty(data.inputs))
 		return false;
 
-	io_destroy(data.input);
-	data.input = NULL;
+	queue_remove_all(data.inputs, NULL, NULL,
+					(queue_destroy_func_t) io_destroy);
 
 	return true;
 }
-- 
2.39.2

