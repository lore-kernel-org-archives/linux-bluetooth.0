Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9CBC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC10B64E86
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCPWRC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 18:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCPWRB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 18:17:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56097C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:17:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so4280818pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OVbapmwY4B/0U1WDV9D710e07acDTa4G+BS4+Ms443Q=;
        b=DlGT1m9H0hjmHSDwVISVfL8LS3BtoaPdlCINypB4CIhJBD1oPNIwMDHB/knIrok1UN
         TxK6hQkrE5cVbrljFiiHMsbc5RFU2Zcir7S9MDXrmR035hMvqMXNyBs3891bowCS7KhF
         3H6/JZcxw0tiV6ZWhANPbY6V0ROJywhHMaQOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OVbapmwY4B/0U1WDV9D710e07acDTa4G+BS4+Ms443Q=;
        b=IrnG3d8QglPlUGEqa2f5BDNyrnCMQaGIr48rw6lRELlK+vW2b1laYf3Dcwmb3zaH92
         yU1k8yCmBxk+i/FHQPq2Qm46fQ2YcT1Qc6Gs3AjUBnOOpoNZ2ABQ9hMZohiiQbdIGMUt
         Ai912n7HXBxbS17yncJib4OhPb0jjSDVyrJFwSaD1Lf+X68MZOrSHnA4r4AYBCxrQ6Nk
         0naEF4B5wrcmvIHbZUADgvTjRkJ5nxu4/cNDFn2TGD991HL9htZ82mveENIQXbMY/zXg
         wJK7ygajFPB2O0ud2ipk0kZXWsSshz4JAwvCzbr0WF0V+M3GIYMqn9+Lu+aQLdsG8PeF
         Xa3g==
X-Gm-Message-State: AOAM533NV1VOB7j5DtWxt1i0H1bIdJ+v3S9vAjjAmljhqrnOPQtVDN+c
        rVbzaZslakzLTC1SHzQ+HjFqpPb8Ud084Q==
X-Google-Smtp-Source: ABdhPJxRAkKAgpzrF1KBiFnEAjRERGYp4twnwklE/fi2Boh2if2bLp9OGExAy/MVImoLK4+L3RGgVg==
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr1141000pjt.120.1615933020358;
        Tue, 16 Mar 2021 15:17:00 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:a0ca:b6dd:8ba0:31fd])
        by smtp.gmail.com with ESMTPSA id 14sm17657582pfo.141.2021.03.16.15.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Mar 2021 15:16:59 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Subject: [PATCH BlueZ] monitor: Add option to force output color
Date:   Tue, 16 Mar 2021 15:16:48 -0700
Message-Id: <20210316221648.11839-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sometimes we want to force output color even when stdout is not a
terminal, for example when piping the output to a filter script and then
piping it further to a pager which can display colors.

This patch provides a general option to force whether color is on or off
(always and never), or leave btmon to decide (auto).

Reviewed-by: Daniel Winkler <danielwinkler@google.com>

---
 monitor/display.c | 12 +++++++++++-
 monitor/display.h |  3 +++
 monitor/main.c    | 17 ++++++++++++++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/monitor/display.c b/monitor/display.c
index 4e5693b04..d61a79a38 100644
--- a/monitor/display.c
+++ b/monitor/display.c
@@ -29,12 +29,22 @@
 
 static pid_t pager_pid = 0;
 int default_pager_num_columns = FALLBACK_TERMINAL_WIDTH;
+enum monitor_color setting_monitor_color = COLOR_AUTO;
+
+void set_monitor_color(enum monitor_color color)
+{
+	setting_monitor_color = color;
+}
 
 bool use_color(void)
 {
 	static int cached_use_color = -1;
 
-	if (__builtin_expect(!!(cached_use_color < 0), 0))
+	if (setting_monitor_color == COLOR_ALWAYS)
+		cached_use_color = 1;
+	else if (setting_monitor_color == COLOR_NEVER)
+		cached_use_color = 0;
+	else if (__builtin_expect(!!(cached_use_color < 0), 0))
 		cached_use_color = isatty(STDOUT_FILENO) > 0 || pager_pid > 0;
 
 	return cached_use_color;
diff --git a/monitor/display.h b/monitor/display.h
index cba39ec7f..be5739833 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -14,6 +14,9 @@
 
 bool use_color(void);
 
+enum monitor_color { COLOR_AUTO, COLOR_ALWAYS, COLOR_NEVER };
+void set_monitor_color(enum monitor_color);
+
 #define COLOR_OFF	"\x1B[0m"
 #define COLOR_BLACK	"\x1B[0;30m"
 #define COLOR_RED	"\x1B[0;31m"
diff --git a/monitor/main.c b/monitor/main.c
index 969c88103..3ec3a5f08 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -69,6 +69,7 @@ static void usage(void)
 		"\t-R  --rtt [<address>],[<area>],[<name>]\n"
 		"\t                       RTT control block parameters\n"
 		"\t-C, --columns [width]  Output width if not a terminal\n"
+		"\t-c, --color [mode]     Output color: auto/always/never\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -93,6 +94,7 @@ static const struct option main_options[] = {
 	{ "jlink",     required_argument, NULL, 'J' },
 	{ "rtt",       required_argument, NULL, 'R' },
 	{ "columns",   required_argument, NULL, 'C' },
+	{ "color",     required_argument, NULL, 'c' },
 	{ "todo",      no_argument,       NULL, '#' },
 	{ "version",   no_argument,       NULL, 'v' },
 	{ "help",      no_argument,       NULL, 'h' },
@@ -124,7 +126,7 @@ int main(int argc, char *argv[])
 		struct sockaddr_un addr;
 
 		opt = getopt_long(argc, argv,
-					"r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:C:vh",
+					"r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:C:c:vh",
 					main_options, NULL);
 		if (opt < 0)
 			break;
@@ -211,6 +213,19 @@ int main(int argc, char *argv[])
 		case 'C':
 			set_default_pager_num_columns(atoi(optarg));
 			break;
+		case 'c':
+			if (strcmp("always", optarg) == 0)
+				set_monitor_color(COLOR_ALWAYS);
+			else if (strcmp("never", optarg) == 0)
+				set_monitor_color(COLOR_NEVER);
+			else if (strcmp("auto", optarg) == 0)
+				set_monitor_color(COLOR_AUTO);
+			else {
+				fprintf(stderr, "Color option must be one of "
+						"auto/always/never\n");
+				return EXIT_FAILURE;
+			}
+			break;
 		case '#':
 			packet_todo();
 			lmp_todo();
-- 
2.29.2

