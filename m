Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6119AC4161D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 13:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375622087E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 13:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI8geiXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375622087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeKUA1r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:27:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36211 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeKUA1r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 19:27:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so2011263edb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 05:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=AjEe3KODygyeikufoUCepvtVQ8cKXdlhue2u8i2G8oc=;
        b=OI8geiXwVxfkjhyi1Ku1U9x+z84NAi+UjOQ6HLCqBNjyrAaeIzdu/nwd8isLITNGC0
         H7dXvvbK9LmbxtzBPRXPpzVms4u5k9HtVG2PalwsX1rAEWvmJdsCj9LozK8G6BlojGoS
         GY0LLIeopAb0WY/2nYmQXI+Xw+jSFFyBTniWq0/Ox8rphw5EL4gyK7Fejl6dSJgNejTK
         hGAjVrwPJdBuggJZtGRhr9uHn3jJUlVUa6u9qCiFyKnuT99aubg/knRUrHdVcwie1VUr
         +XKHZIwQsqFhLPiYdEsiwrVA55vmEw/JvDdMZp3FfWyrmfvJxgHZiUa4k+AHf/rAwJCX
         LHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=AjEe3KODygyeikufoUCepvtVQ8cKXdlhue2u8i2G8oc=;
        b=iJJyu2Jct9Gqt5O2VnaTs3XDGQqEDfJcZAFTTri2wobvNkFU831mA5JhqdV4yzBapt
         DVtaGafIju8kdU2voocMy1AibRN/OtSx3fIlfYC5STouMQ7SV4jh102r2DGZhHCurCPF
         AZt+No3YLB743yCXj9/KRCdkg4YzMvmn6cUYGes150/7E3a9lXh2J0zPwGeCqIfcGEpd
         lFDKKTDYZTo8X2dQJ6vOlY4vO45A8RD348371+OBsK4UqtdLMy2lKDLUy4TqUNMpgf7D
         22FfXvd7CORYWZE0B1SJOoPc4+LS5rYEJZXS/Z6kmqkkPSRTniSm3rHaGb1GHj54rZRS
         hDdA==
X-Gm-Message-State: AGRZ1gLz31kvOZnX6Cg2hRNbt2TnJQGhIYttx0pEa/uBNCSxSeNrl/Yx
        VfI//0w1YDFd8o1cZ4g3cocMF119
X-Google-Smtp-Source: AJdET5e7L//AVUNN0Thn8I/2Hd6IyAehV442GvRNdLPBie/wth2VEv56IAT9qCOvh//PgZGF1eQPTg==
X-Received: by 2002:a17:906:9154:: with SMTP id y20-v6mr2073325ejw.8.1542722308297;
        Tue, 20 Nov 2018 05:58:28 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id c29sm7200768eda.75.2018.11.20.05.58.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 05:58:27 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] shared/shell: Add option to print to monitor
Date:   Tue, 20 Nov 2018 15:58:20 +0200
Message-Id: <20181120135821.18082-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181120135821.18082-1-luiz.dentz@gmail.com>
References: <20181120135821.18082-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds option -m/--monitor which send output to btmon using
libshared bt_log:

= bluetoothctl: power on
= bluetoothctl: Changing power on succeeded
---
 src/shared/shell.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 241046440..89a2e82bc 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <errno.h>
+#include <syslog.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdarg.h>
@@ -45,6 +46,7 @@
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/shell.h"
+#include "src/shared/log.h"
 
 #define CMD_LENGTH	48
 #define print_text(color, fmt, args...) \
@@ -70,6 +72,7 @@ static struct {
 	int argc;
 	char **argv;
 	bool mode;
+	bool monitor;
 	int timeout;
 	struct io *input;
 
@@ -521,6 +524,12 @@ void bt_shell_printf(const char *fmt, ...)
 	vprintf(fmt, args);
 	va_end(args);
 
+	if (data.monitor) {
+		va_start(args, fmt);
+		bt_log_vprintf(0xffff, data.name, LOG_INFO, fmt, args);
+		va_end(args);
+	}
+
 	if (save_input) {
 		if (!data.saved_prompt)
 			rl_restore_prompt();
@@ -613,6 +622,9 @@ static void rl_handler(char *input)
 	if (history_search(input, -1))
 		add_history(input);
 
+	if (data.monitor)
+		bt_log_printf(0xffff, data.name, LOG_INFO, "%s", input);
+
 	if (wordexp(input, &w, WRDE_NOCMD))
 		goto done;
 
@@ -988,6 +1000,7 @@ static const struct option main_options[] = {
 	{ "version",	no_argument, 0, 'v' },
 	{ "help",	no_argument, 0, 'h' },
 	{ "timeout",	required_argument, 0, 't' },
+	{ "monitor",	no_argument, 0, 'm' },
 };
 
 static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
@@ -1003,7 +1016,8 @@ static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
 	for (i = 0; opt && opt->options[i].name; i++)
 		printf("\t--%s \t%s\n", opt->options[i].name, opt->help[i]);
 
-	printf("\t--timeout \tTimeout in seconds for non-interactive mode\n"
+	printf("\t--monitor \tEnable monitor output\n"
+		"\t--timeout \tTimeout in seconds for non-interactive mode\n"
 		"\t--version \tDisplay version\n"
 		"\t--help \t\tDisplay help\n");
 }
@@ -1022,9 +1036,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	if (opt) {
 		memcpy(options + offset, opt->options,
 				sizeof(struct option) * opt->optno);
-		snprintf(optstr, sizeof(optstr), "+hvt:%s", opt->optstr);
+		snprintf(optstr, sizeof(optstr), "+mhvt:%s", opt->optstr);
 	} else
-		snprintf(optstr, sizeof(optstr), "+hvt:");
+		snprintf(optstr, sizeof(optstr), "+mhvt:");
 
 	data.name = strrchr(argv[0], '/');
 	if (!data.name)
@@ -1047,6 +1061,13 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 		case 't':
 			data.timeout = atoi(optarg);
 			break;
+		case 'm':
+			data.monitor = true;
+			if (bt_log_open() < 0) {
+				data.monitor = false;
+				printf("Unable to open logging channel\n");
+			}
+			break;
 		default:
 			if (index < 0) {
 				for (index = 0; options[index].val; index++) {
@@ -1131,6 +1152,9 @@ void bt_shell_cleanup(void)
 		data.envs = NULL;
 	}
 
+	if (data.monitor)
+		bt_log_close();
+
 	rl_cleanup();
 
 	data.init = false;
-- 
2.17.2

