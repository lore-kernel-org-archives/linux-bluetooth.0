Return-Path: <SRS0=BOCR=WN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05D7C3A5A1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B668521743
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coCdn2Ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfHQGg1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:36:27 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:36513 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfHQGg1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Aug 2019 02:36:27 -0400
Received: by mail-pl1-f179.google.com with SMTP id g4so3349602plo.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 23:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h7J78+yYEVX/qg68EjqNRm2MvZOEsuNNwozKTRzm5X8=;
        b=coCdn2Ymo5DSO2nj1weeHEhO3gbTznKNJ/AuH80+AYXL+gm/dhru5i71Va5Iah6Un/
         rxswtqWJ7L+aXXkhnnMD3yFXJPGzzav4wrOG9Fm+XwuIaEIvIoMl6Ys2xh0YSCxOg7Rt
         eYskSn5UXiPkDJM3Ss6axI2GO2n0O58H3j2dVR3L2s/QSCoC+4NS5GzZfhc88hHAARUm
         ngOttPqkMulXT4wyFmvpVbsdMmku6vnrDMrvoYhPOpZGmxG+f02otLsP2ygv+FbAWSiZ
         PE4T7zhmsaFUkH1V/UGs0S5U7FiaPER1H0fSLwZE60dNVLCqtql/4Eo1UBXP6OnT9P+f
         CNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h7J78+yYEVX/qg68EjqNRm2MvZOEsuNNwozKTRzm5X8=;
        b=KzBGgj1h8sKuFsc6r1IxkIfSQQ1P0716+TaDJ6PbKuddssx5XC6YcYiwB1dG6OwNyv
         JttuY7ss13TkrrdZY5pqlJu2JKyG9RaDp/kELjXJfyR2tCDZ2PWNUTMeAEAIlOpA2ADE
         R7XGcdGi1DopykAkBrVMN9LhFQEbpFqjaHEpwOPteGYPhvFuoe7FO4zD7T2Br+VzniWQ
         yBJoNayJ46v7TkCdwHmnjrhVKXmclutL9sQ5DeyO0cvN44U89RDRW27y02yq6ZBLiWr7
         XAAZTdf2JogkVqCGLodYTyMfvdb/XB8USypXkNwLQq91/rQ2Zy16isbFKxyLwf8XkPNR
         pKFQ==
X-Gm-Message-State: APjAAAXsgMj0R/kGi0u77S5YFvCj1Gw9H8BD0ti1oGzKQMHfced04zl1
        B+Q6nHGwk3oLRutMvnZO0n4D+3g=
X-Google-Smtp-Source: APXvYqxIiCGAPXy08qNFR+7XlFL2ZEO41KO34rdZrcBekS0S6ISsusKRKJ5MMKvL2KRlVOFcV+pnMQ==
X-Received: by 2002:a17:902:760e:: with SMTP id k14mr12468091pll.161.1566023786267;
        Fri, 16 Aug 2019 23:36:26 -0700 (PDT)
Received: from rxps.home ([2600:8800:1e00:242:3550:edee:2708:4ad0])
        by smtp.gmail.com with ESMTPSA id y128sm6684095pgy.41.2019.08.16.23.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 23:36:25 -0700 (PDT)
From:   Ronan Pigott <rpigott314@gmail.com>
X-Google-Original-From: Ronan Pigott
To:     linux-bluetooth@vger.kernel.org
Cc:     Ronan Pigott <rpigott@berkeley.edu>
Subject: [PATCH BlueZ v2 2/4] shared/shell: add --zsh-complete option
Date:   Fri, 16 Aug 2019 23:34:50 -0700
Message-Id: <20190817063452.23273-3-rpigott@berkeley.edu>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817063452.23273-1-rpigott@berkeley.edu>
References: <20190817063452.23273-1-rpigott@berkeley.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ronan Pigott <rpigott@berkeley.edu>

This adds a new long form option --zsh-complete to provide all available
commands in an output format suitable for parsing by zsh or other shell
completion scripts.

Invoke like: `bluetoothctl --zsh-complete help`

There is no corresponding short form option.

---
 src/shared/shell.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index eac654f40..bbf9f9e7a 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -79,6 +79,7 @@ static struct {
 	int argc;
 	char **argv;
 	bool mode;
+	bool zsh;
 	bool monitor;
 	int timeout;
 	struct io *input;
@@ -98,6 +99,7 @@ static struct {
 } data;
 
 static void shell_print_menu(void);
+static void shell_print_menu_zsh_complete(void);
 
 static void cmd_version(int argc, char *argv[])
 {
@@ -288,6 +290,11 @@ static void shell_print_menu(void)
 	if (!data.menu)
 		return;
 
+	if (data.zsh) {
+		shell_print_menu_zsh_complete();
+		return;
+	}
+
 	print_text(COLOR_HIGHLIGHT, "Menu %s:", data.menu->name);
 	print_text(COLOR_HIGHLIGHT, "Available commands:");
 	print_text(COLOR_HIGHLIGHT, "-------------------");
@@ -314,6 +321,22 @@ static void shell_print_menu(void)
 	}
 }
 
+static void shell_print_menu_zsh_complete(void)
+{
+	const struct bt_shell_menu_entry *entry;
+
+	for (entry = data.menu->entries; entry->cmd; entry++) {
+		printf("%s:%s\n", entry->cmd, entry->desc ? : "");
+	}
+
+	for (entry = default_menu; entry->cmd; entry++) {
+		if (entry->exists && !entry->exists(data.menu))
+			continue;
+
+		printf("%s:%s\n", entry->cmd, entry->desc ? : "");
+	}
+}
+
 static int parse_args(char *arg, wordexp_t *w, char *del, int flags)
 {
 	char *str;
@@ -1015,6 +1038,7 @@ static const struct option main_options[] = {
 	{ "help",	no_argument, 0, 'h' },
 	{ "timeout",	required_argument, 0, 't' },
 	{ "monitor",	no_argument, 0, 'm' },
+	{ "zsh-complete",	no_argument, 0, 'z' },
 };
 
 static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
@@ -1075,6 +1099,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 		case 't':
 			data.timeout = atoi(optarg);
 			break;
+		case 'z':
+			data.zsh = 1;
+			break;
 		case 'm':
 			data.monitor = true;
 			if (bt_log_open() < 0) {
-- 
2.22.1

