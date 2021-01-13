Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20253C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDF22339F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbhAMJ04 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbhAMJ0z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 04:26:55 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA7C061795
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:26:15 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m8so979950qvt.14
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wekWR/WsOW5UaepZPls4XtdkOUBGJTm6QWTFHpbNnd0=;
        b=KDVs/ptTNfWTlqVTt86cG807k84/+SQMBj+r2eMaEUCdaImAcfWeeGCu6S62LP+fEe
         JdsQjUxjOARVE6nUg1rKmX005u5d660Rzx4hkI7lZX6zQ7rSmyMZBnzFnZQYUXGmyR5Q
         boySNSGh9NOQdoFqOHNU9BAOlvGtoi0qXtWG67KzE7qTr+e5Ta4sLr/eo3zYMxjM5pnq
         TER/SAmND/IBIS0hor26o8I0n9WEza+3m8DNt/m3EQ8GLdYeU9MHV8YR8keZadJ/WRIO
         LdDn2izeRAUKy/rbuTaVbgHmYWoFxexnguwjDP5YSuBJ9wY300F9nYVFkCV5z16KTw08
         d80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wekWR/WsOW5UaepZPls4XtdkOUBGJTm6QWTFHpbNnd0=;
        b=dhR+3VUj7Sv/3pyvg6GXdBv0RNDvLvZis2lvSktQuYSorlVE0p12KiGpF78LT3CuGz
         WWblwzHeIbtt/4OdPt+4Ox+GpwtCioTZg1dDR2wW54mutX6ghyNBvxkb+/sr1RRxJhex
         2g1l7XTowAaY5LNY3DePHzoNme4svg+YCxkaleTwCYjqdYBhCf0inABPq0iqsrzlaEQY
         XqCb35/Nb4XBXipgr96fVrQNn1yUxtA9L7hs5mAoSkbV+IOZlRUf/qsKjrRzAy4wKKrK
         aIOzgrAvflOErQHF6I608rIdmMJyGIV/YaWgoKqh4Nxwm/sVZ4LQq72gU6BpIq95ZocJ
         MmDg==
X-Gm-Message-State: AOAM530/tryupPWTymCYOxetN6bLR9iOHBlQ5A1UQZ0Pn3QLgHQ59Dq7
        JeB0QNBJ3fXTeS3lu4BHTPwie2KAdZ5HgRo2ntlZP0HhjcqrmplgQKsX45nooZojkW+LW7/cpT7
        VXmTqmwaSxdnHguqfmZH/DifEsGaSCrgNalCiNga1hYSQC7KKXZNIDgaFoOIHe+hzoTlNQUs69z
        FZ
X-Google-Smtp-Source: ABdhPJzM98+9D6x9r/sFKv9LA/+h2IbJ/yzBnG3nEU8CCBP/Y65GrfT6L5qYHUAjpi5T9gdW8QsB+qYZTgyo
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:83e1:: with SMTP id
 k88mr1211363qva.60.1610529974493; Wed, 13 Jan 2021 01:26:14 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:25:34 +0800
In-Reply-To: <20210113092534.2771034-1-apusaka@google.com>
Message-Id: <20210113172337.Bluez.v1.3.I16fa24fb791fe886f6723373772b644783b3ab92@changeid>
Mime-Version: 1.0
References: <20210113092534.2771034-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH v1 3/5] btmgmt: advmon add rssi support
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Using the new opcode MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI to
monitor advertisement according to some RSSI criteria.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
---

 tools/btmgmt.c | 160 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 134 insertions(+), 26 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index c0e55f58e6..383e7199e4 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4858,64 +4858,169 @@ static bool str2pattern(struct mgmt_adv_pattern *pattern, const char *str)
 	return true;
 }
 
-static void advmon_add_usage(void)
+static struct option add_monitor_rssi_options[] = {
+	{ "help",		0, 0, 'h' },
+	{ "high-threshold",	1, 0, 'R' },
+	{ "low-threshold",	1, 0, 'r' },
+	{ "high-timeout",	1, 0, 'T' },
+	{ "low-timeout",	1, 0, 't' },
+	{ "sampling",		1, 0, 's' },
+	{ 0, 0, 0, 0 }
+};
+
+static void advmon_add_pattern_usage(void)
+{
+	bt_shell_usage();
+	print("patterns format:\n"
+		"\t<ad_type:offset:pattern> [patterns]\n"
+		"e.g.:\n"
+		"\tadd-pattern 0:1:c504 ff:a:9a55beef");
+}
+
+static void advmon_add_pattern_rssi_usage(void)
 {
 	bt_shell_usage();
-	print("Monitor Types:\n\t-p <ad_type:offset:pattern>..."
-		"\tPattern Monitor\ne.g.:\n\tadd -p 0:1:c504 1:a:9a55beef");
+	print("RSSI options:\n"
+		"\t -R, --high-threshold <dBm>  "
+			"RSSI high threshold. Default: -70\n"
+		"\t -r, --low-threshold <dBm>   "
+			"RSSI low threshold. Default: -50\n"
+		"\t -T, --high-timeout <s>      "
+			"RSSI high threshold duration. Default: 0\n"
+		"\t -t, --low-timeout <s>       "
+			"RSSI low threshold duration. Default: 5\n"
+		"\t -s, --sampling <N * 100ms>  "
+			"RSSI sampling period. Default: 0\n"
+		"patterns format:\n"
+		"\t<ad_type:offset:pattern> [patterns]\n"
+		"e.g.:\n"
+		"\tadd-pattern-rssi -R 0xb2 -r -102 0:1:c504 ff:a:9a55beef");
 }
 
-static bool advmon_add_pattern(int argc, char **argv)
+static void cmd_advmon_add_pattern(int argc, char **argv)
 {
+	bool success = true;
 	uint16_t index;
 	int i, cp_len;
 	struct mgmt_cp_add_adv_monitor *cp = NULL;
-	bool success = false;
 
-	index = mgmt_index;
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
+	if (!strcmp(argv[1], "-h"))
+		goto done;
 
-	cp_len = sizeof(struct mgmt_cp_add_adv_monitor) +
-			argc * sizeof(struct mgmt_adv_pattern);
+	argc -= 1;
+	argv += 1;
 
+	cp_len = sizeof(*cp) + argc * sizeof(struct mgmt_adv_pattern);
 	cp = malloc0(cp_len);
 	cp->pattern_count = argc;
 
 	for (i = 0; i < argc; i++) {
 		if (!str2pattern(&cp->patterns[i], argv[i])) {
 			error("Failed to parse monitor patterns.");
+			success = false;
 			goto done;
 		}
 	}
 
-	if (!mgmt_send(mgmt, MGMT_OP_ADD_ADV_PATTERNS_MONITOR, index, cp_len,
-					cp, advmon_add_rsp, NULL, NULL)) {
-		error("Unable to send \"Add Advertising Monitor\" command");
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	if (!mgmt_send(mgmt, MGMT_OP_ADD_ADV_PATTERNS_MONITOR, index,
+				cp_len, cp, advmon_add_rsp, NULL, NULL)) {
+		error("Unable to send Add Advertising Monitor command");
+		success = false;
 		goto done;
 	}
 
-	success = true;
+	free(cp);
+	return;
 
 done:
 	free(cp);
-	return success;
+	advmon_add_pattern_usage();
+	bt_shell_noninteractive_quit(success ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
-static void cmd_advmon_add(int argc, char **argv)
+static void cmd_advmon_add_pattern_rssi(int argc, char **argv)
 {
-	bool success = false;
+	bool success = true;
+	int opt;
+	int8_t rssi_low = -70;
+	int8_t rssi_high = -50;
+	uint16_t rssi_low_timeout = 5;
+	uint16_t rssi_high_timeout = 0;
+	uint8_t rssi_sampling_period = 0;
+	uint16_t index;
+	int i, cp_len;
+	struct mgmt_cp_add_adv_patterns_monitor_rssi *cp = NULL;
 
-	if (strcasecmp(argv[1], "-p") == 0 && argc > 2) {
-		argc -= 2;
-		argv += 2;
-		success = advmon_add_pattern(argc, argv);
+	while ((opt = getopt_long(argc, argv, "+hr:R:t:T:s:",
+				add_monitor_rssi_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			goto done;
+		case 'r':
+			rssi_low = strtol(optarg, NULL, 0);
+			break;
+		case 'R':
+			rssi_high = strtol(optarg, NULL, 0);
+			break;
+		case 't':
+			rssi_low_timeout = strtol(optarg, NULL, 0);
+			break;
+		case 'T':
+			rssi_high_timeout = strtol(optarg, NULL, 0);
+			break;
+		case 's':
+			rssi_sampling_period = strtol(optarg, NULL, 0);
+			break;
+		default:
+			success = false;
+			goto done;
+		}
 	}
 
-	if (!success) {
-		advmon_add_usage();
-		bt_shell_noninteractive_quit(EXIT_FAILURE);
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	cp_len = sizeof(*cp) + argc * sizeof(struct mgmt_adv_pattern);
+	cp = malloc0(cp_len);
+	cp->pattern_count = argc;
+	cp->rssi.high_threshold = rssi_high;
+	cp->rssi.low_threshold = rssi_low;
+	cp->rssi.high_threshold_timeout = htobs(rssi_high_timeout);
+	cp->rssi.low_threshold_timeout = htobs(rssi_low_timeout);
+	cp->rssi.sampling_period = rssi_sampling_period;
+
+	for (i = 0; i < argc; i++) {
+		if (!str2pattern(&cp->patterns[i], argv[i])) {
+			error("Failed to parse monitor patterns.");
+			success = false;
+			goto done;
+		}
+	}
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	if (!mgmt_send(mgmt, MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, index,
+				cp_len, cp, advmon_add_rsp, NULL, NULL)) {
+		error("Unable to send Add Advertising Monitor RSSI command");
+		success = false;
+		goto done;
 	}
+
+	free(cp);
+	return;
+
+done:
+	free(cp);
+	optind = 0;
+	advmon_add_pattern_rssi_usage();
+	bt_shell_noninteractive_quit(success ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static void advmon_remove_rsp(uint8_t status, uint16_t len, const void *param,
@@ -5037,8 +5142,11 @@ static const struct bt_shell_menu monitor_menu = {
 					"features"			},
 	{ "remove",		"<handle>",
 		cmd_advmon_remove,	"Remove advertisement monitor "	},
-	{ "add",		"<-p|-h> [options...]",
-		cmd_advmon_add,		"Add advertisement monitor"	},
+	{ "add-pattern",	"[-h] <patterns>",
+		cmd_advmon_add_pattern,	"Add advertisement monitor pattern" },
+	{ "add-pattern-rssi",	"[options] <patterns>",
+		cmd_advmon_add_pattern_rssi,
+		"Add advertisement monitor pattern with RSSI options"    },
 	{ } },
 };
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

