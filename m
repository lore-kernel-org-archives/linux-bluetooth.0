Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A4C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 01:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCVBNz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 21:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCVBNy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 21:13:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC114FABB
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 18:13:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c18so17876559ple.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 18:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679447632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfMSXoLPK1i/zfpwk5vhXtK+ce/U14w+ObxW5GLjoCM=;
        b=jT8yY4rNAntDSynsovb9TnwkgOpTvaNTpSfGW5//u+XNoLCR2F+d2C1y5RC7gn3NGV
         1StJV27GJcYnb0WdWj867BZmvhqkNyiTsqDMjFMWaycRiyLDfbdDukigLbU08y3HovEi
         Nx7futLMc/UYlp/bcFfzpzTwwRgTvrH7iP9rdDmwcdM7/CUfoSeqVKzKv5SYLROTJ7mt
         H8pkepJ28EizULEySRS45tjjSE1aX+DYR/fKlwz3k6C9p/utNR4q1T9hIr46KEh1VX0n
         SbTADet5v2tuY7SYGgG9ESJ72d7YphbqkOeFUf5V6zHMsKZCVoDLwhQqoh0gfvgNXDn1
         gquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679447632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfMSXoLPK1i/zfpwk5vhXtK+ce/U14w+ObxW5GLjoCM=;
        b=d0K433/T1A+p+QFoS/RZuPK2EZSEkvgZM+g4vx/1GUn2vfBPdaWN3YpRpYECedll7L
         od+tDViihpSl9JRLSb7B07G3/tFnQDQcX0ykKwclgS3ZgVThU1D55AJ0AXCM6eL3mxsS
         3tcFIAmP1dE8kHXJXU3yAU7uCDS/MnIhxOgSQ7hSycxgTIbJPkKDFfJILYQDsWEEsWbr
         9YpweC6kn7qYkXrrMHSQFRSSDBTT0Jy84sXM+yadgujccvOI5ieFRfqCMdU+GQxHX4jB
         RzXnpx3xMS0sAeP8OdFuzepQ+G1E4tRaulbo6luNp+srDYvRPqv4t3zvUdszXow29guL
         sqeA==
X-Gm-Message-State: AO0yUKWxMmOZ4unXOCXA9bO4IoCAAcKHhYdDQtlPJLR4+tZFi3AkU3oK
        iWz35xyj7xhP0jKoiha2k7NBibnrHQk=
X-Google-Smtp-Source: AK7set8Qtv5IivzOuniNQg3+MzrZa/FTamOEqX9IPBewdFxw9YEoFP9HfM1L72Vrlg0UwvQnkfng9w==
X-Received: by 2002:a17:90b:4a46:b0:237:d2d8:3256 with SMTP id lb6-20020a17090b4a4600b00237d2d83256mr1641551pjb.20.1679447631525;
        Tue, 21 Mar 2023 18:13:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c11100b0019ee045a2b3sm9315720pli.308.2023.03.21.18.13.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:13:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] shared/shell: Add support for -i/--init-script
Date:   Tue, 21 Mar 2023 18:13:48 -0700
Message-Id: <20230322011349.2763404-1-luiz.dentz@gmail.com>
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
 src/shared/shell.c | 159 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 142 insertions(+), 17 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 3358b383e9e4..8ea4cb355f63 100644
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
+	char *line;
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
@@ -615,6 +621,32 @@ void bt_shell_usage()
 					data.exec->arg ? data.exec->arg : "");
 }
 
+static void bt_shell_dequeue_exec(void)
+{
+	int err;
+
+	if (!data.line)
+		return;
+
+	free(data.line);
+	data.line = NULL;
+
+	data.line = queue_pop_head(data.queue);
+	if (!data.line)
+		return;
+
+	bt_shell_printf("%s\n", data.line);
+
+	if (!bt_shell_release_prompt(data.line)) {
+		bt_shell_dequeue_exec();
+		return;
+	}
+
+	err = bt_shell_exec(data.line);
+	if (err)
+		bt_shell_dequeue_exec();
+}
+
 static void prompt_input(const char *str, bt_shell_prompt_input_func func,
 							void *user_data)
 {
@@ -988,6 +1020,11 @@ static char **shell_completion(const char *text, int start, int end)
 
 static bool io_hup(struct io *io, void *user_data)
 {
+	if (queue_remove(data.inputs, io)) {
+		if (!queue_isempty(data.inputs))
+			return false;
+	}
+
 	mainloop_quit();
 
 	return false;
@@ -999,7 +1036,7 @@ static void signal_callback(int signum, void *user_data)
 
 	switch (signum) {
 	case SIGINT:
-		if (data.input && !data.mode) {
+		if (!queue_isempty(data.inputs) && !data.mode) {
 			rl_replace_line("", 0);
 			rl_crlf();
 			rl_on_new_line();
@@ -1091,6 +1128,7 @@ static void rl_init(void)
 static const struct option main_options[] = {
 	{ "version",	no_argument, 0, 'v' },
 	{ "help",	no_argument, 0, 'h' },
+	{ "init-script",required_argument, 0, 'i' },
 	{ "timeout",	required_argument, 0, 't' },
 	{ "monitor",	no_argument, 0, 'm' },
 	{ "zsh-complete",	no_argument, 0, 'z' },
@@ -1112,6 +1150,7 @@ static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
 	printf("\t--monitor \tEnable monitor output\n"
 		"\t--timeout \tTimeout in seconds for non-interactive mode\n"
 		"\t--version \tDisplay version\n"
+		"\t--init-script \tInit script file\n"
 		"\t--help \t\tDisplay help\n");
 }
 
@@ -1130,9 +1169,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
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
@@ -1140,6 +1179,8 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	else
 		data.name = strdup(++data.name);
 
+	data.init_fd = -1;
+
 	while ((c = getopt_long(argc, argv, optstr, options, &index)) != -1) {
 		switch (c) {
 		case 'v':
@@ -1152,6 +1193,13 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 			data.argv = &cmplt;
 			data.mode = 1;
 			goto done;
+		case 'i':
+			if (optarg)
+				data.init_fd = open(optarg, O_RDONLY);
+			if (data.init_fd < 0)
+				printf("Unable to open %s: %s (%d)\n", optarg,
+						strerror(errno), errno);
+			break;
 		case 't':
 			if (optarg)
 				data.timeout = strtol(optarg, &endptr, 0);
@@ -1205,6 +1253,8 @@ done:
 	rl_init();
 
 	data.init = true;
+	data.inputs = queue_new();
+	data.queue = queue_new();
 	data.prompts = queue_new();
 }
 
@@ -1239,6 +1289,25 @@ int bt_shell_run(void)
 	return status;
 }
 
+static int bt_shell_queue_exec(char *line)
+{
+	int err;
+
+	/* Queue if already executing */
+	if (data.line) {
+		queue_push_tail(data.queue, strdup(line));
+		return 0;
+	}
+
+	bt_shell_printf("%s\n", line);
+
+	err = bt_shell_exec(line);
+	if (!err)
+		data.line = strdup(line);
+
+	return err;
+}
+
 int bt_shell_exec(const char *input)
 {
 	wordexp_t w;
@@ -1247,8 +1316,20 @@ int bt_shell_exec(const char *input)
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
@@ -1277,6 +1358,8 @@ void bt_shell_cleanup(void)
 
 	rl_cleanup();
 
+	queue_destroy(data.inputs, NULL);
+	queue_destroy(data.queue, free);
 	queue_destroy(data.prompts, prompt_free);
 	data.prompts = NULL;
 
@@ -1294,8 +1377,10 @@ void bt_shell_quit(int status)
 
 void bt_shell_noninteractive_quit(int status)
 {
-	if (!data.mode || data.timeout)
+	if (!data.mode || data.timeout) {
+		bt_shell_dequeue_exec();
 		return;
+	}
 
 	bt_shell_quit(status);
 }
@@ -1340,7 +1425,43 @@ void bt_shell_set_prompt(const char *string)
 
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
+		err = bt_shell_queue_exec(line);
+		if (err < 0)
+			printf("%s: %s (%d)\n", line, strerror(-err), -err);
+	} else {
+		fclose(data.f);
+		data.f = NULL;
+	}
+
+	free(line);
+
 	return true;
 }
 
@@ -1355,18 +1476,16 @@ bool bt_shell_attach(int fd)
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
@@ -1377,6 +1496,12 @@ bool bt_shell_attach(int fd)
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
@@ -1384,11 +1509,11 @@ bool bt_shell_attach(int fd)
 
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

