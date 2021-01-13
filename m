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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFD0C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D242339F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbhAMJ07 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhAMJ07 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 04:26:59 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F09DC06179F
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:26:19 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id bg11so869444plb.16
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KCGlVM2ufeKYx50FLxqgp56NE4z5BDIFWYo/2BId2Ds=;
        b=tDvaAcgxLF3VD5xAiKR5pNFk6aLHiSr+j5kUzNuqshRLoR510bAUUy41g3wCRg3o9N
         ubph85D6nxaA+mAz9tiZhzgXg8jsMTpf3BVqJCHYdyqhsMOPQTbjCnFFzfp89HOKOVf0
         c6pBJGap2/B0vd++QGACC7MT8MxPfNE9Tib4tpSl3SHVBefGsYX6tbIBYDjQK8T7D/xW
         9y3f6qkNi9s3Gs9DFAJTZZefAIeCprKcphN5gS4gRGM01ijq4h9M9kMjzFIUBFK0bUaB
         FAZJNyxu9q6dZz0be2BAw9RXn8mdoLVSu3FEgn2Xb5yUFCbVHss5DNzi9EoNgbucdfyF
         fTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KCGlVM2ufeKYx50FLxqgp56NE4z5BDIFWYo/2BId2Ds=;
        b=PCxpDX71WGue7zkyQgOuUasnl7lIZdkd7omuPfELRQT1ehGLt75gxSAVyitrgDsoPk
         55oN+PAHFBRzFg3ea7CoijELPRChJABba0jdBgox62QFJ20cHlssDZCHuDAUjZynhGWU
         Fh1gB8PE7vQ784YkkmjcmXF2oWLvjGkuoNE13fTTDVshs0ogXdOYBAvNHndIr+zb2mSR
         pkNe+7MjBX5b1oyQVKdtdYxADZWDiIt5Jo5pkJGdRJmvc8kV/itaEQtaMfdf4OplO+Dv
         kVOq7oaymvY+JxloCd8m5ZnxvcEodgh4ItMBDrDoNEvfTPE+frSRxAJtIUcLes2NMoIJ
         dJbQ==
X-Gm-Message-State: AOAM530am441wKnPQG1X3slQQdJMGBQnqjlIW5hHqgkdtgNFCVgNSsx4
        vd4UY3k1iZNrpf4947AcM1vwxqdDKY1xNqEKs4svYiNDwTio4/ZHWrWKNfFrS80IuI2nbCbzf2s
        jGjnocCLLN5dl4IQoo7Cn0m8MDk20n4ywE4mDlzeK667tx6jjfKJlCNx8gkMT8X9w+qsANuVGgQ
        y0
X-Google-Smtp-Source: ABdhPJxnaBAWvgWkT3exXwacEntgBCXh3sbVGfZfiW35ilNbIpB8ZrUA/vMKmaEEHQsJLj2Feb8sVSWGtpnu
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90a:8b94:: with SMTP id
 z20mr1074484pjn.1.1610529978476; Wed, 13 Jan 2021 01:26:18 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:25:35 +0800
In-Reply-To: <20210113092534.2771034-1-apusaka@google.com>
Message-Id: <20210113172337.Bluez.v1.4.I20391efb1b5a40cd2b0cb6069d88b7fb9f7ed66b@changeid>
Mime-Version: 1.0
References: <20210113092534.2771034-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH v1 4/5] bluetoothctl: advmon rssi support for mgmt
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

 client/adv_monitor.c | 90 ++++++++++++++++++++++----------------------
 client/adv_monitor.h |  1 +
 client/main.c        | 29 +++++++-------
 3 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index f62e9f4442..74f7581776 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -33,6 +33,7 @@ struct rssi_setting {
 	uint16_t high_timer;
 	int16_t low_threshold;
 	uint16_t low_timer;
+	uint16_t sampling_period;
 };
 
 struct pattern {
@@ -148,6 +149,8 @@ static gboolean get_rssi(const GDBusPropertyTable *property,
 							&rssi->low_threshold);
 	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_UINT16,
 							&rssi->low_timer);
+	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_UINT16,
+							&rssi->sampling_period);
 	dbus_message_iter_close_container(iter, &data_iter);
 	return TRUE;
 }
@@ -212,7 +215,7 @@ static gboolean pattern_exists(const GDBusPropertyTable *property, void *data)
 
 static const GDBusPropertyTable adv_monitor_props[] = {
 	{ "Type", "s", get_type },
-	{ "RSSIThresholdsAndTimers", "(nqnq)", get_rssi, NULL, rssi_exists },
+	{ "RSSIThresholdsAndTimers", "(nqnqq)", get_rssi, NULL, rssi_exists },
 	{ "Patterns", "a(yyay)", get_patterns, NULL, pattern_exists },
 	{ }
 };
@@ -376,56 +379,51 @@ static uint8_t str2bytearray(char *str, uint8_t *arr)
 	return arr_len;
 }
 
-static void parse_rssi_value_pair(char *value_pair, int *low, int *high)
-{
-	char *val1, *val2;
-	bool flag = value_pair[0] == ',';
-
-	val1 = strtok(value_pair, ",");
-
-	if (!val1)
-		return;
-
-	val2 = strtok(NULL, ",");
-
-	if (!val2) {
-		if (!flag)
-			*low = atoi(val1);
-		else
-			*high = atoi(val1);
-	} else {
-		*low = atoi(val1);
-		*high = atoi(val2);
-	}
-}
-
-static struct rssi_setting *parse_rssi(char *range, char *timeout)
+static struct rssi_setting *parse_rssi(char *params)
 {
 	struct rssi_setting *rssi;
-	int high_threshold, low_threshold, high_timer, low_timer;
-
-	high_threshold = RSSI_DEFAULT_HIGH_THRESHOLD;
-	low_threshold = RSSI_DEFAULT_LOW_THRESHOLD;
-	high_timer = RSSI_DEFAULT_HIGH_TIMEOUT;
-	low_timer = RSSI_DEFAULT_LOW_TIMEOUT;
+	char *split, *endptr;
+	int i;
+	int values[5] = {RSSI_DEFAULT_LOW_THRESHOLD,
+			RSSI_DEFAULT_HIGH_THRESHOLD,
+			RSSI_DEFAULT_LOW_TIMEOUT,
+			RSSI_DEFAULT_HIGH_TIMEOUT,
+			RSSI_DEFAULT_SAMPLING_PERIOD};
+
+	for (i = 0; i < 5; i++) {
+		if (!params) /* Params too short */
+			goto bad_format;
+
+		split = strsep(&params, ",");
+		if (*split != '\0') {
+			values[i] = strtol(split, &endptr, 0);
+			if (*endptr != '\0') /* Conversion failed */
+				goto bad_format;
+		} /* Otherwise no parsing needed - use default */
+	}
 
-	parse_rssi_value_pair(range, &low_threshold, &high_threshold);
-	parse_rssi_value_pair(timeout, &low_timer, &high_timer);
+	if (params) /* There are trailing unused params */
+		goto bad_format;
 
 	rssi = g_malloc0(sizeof(struct rssi_setting));
-
 	if (!rssi) {
-		bt_shell_printf("Failed to allocate rssi_setting");
+		bt_shell_printf("Failed to allocate rssi_setting\n");
 		bt_shell_noninteractive_quit(EXIT_FAILURE);
 		return NULL;
 	}
 
-	rssi->high_threshold = high_threshold;
-	rssi->high_timer = high_timer;
-	rssi->low_threshold = low_threshold;
-	rssi->low_timer = low_timer;
+	rssi->low_threshold = values[0];
+	rssi->high_threshold = values[1];
+	rssi->low_timer = values[2];
+	rssi->high_timer = values[3];
+	rssi->sampling_period = values[4];
 
 	return rssi;
+
+bad_format:
+	bt_shell_printf("Failed to parse RSSI\n");
+	bt_shell_noninteractive_quit(EXIT_FAILURE);
+	return NULL;
 }
 
 static struct pattern *parse_pattern(char *parameter_list[])
@@ -435,7 +433,7 @@ static struct pattern *parse_pattern(char *parameter_list[])
 	pat = g_malloc0(sizeof(struct pattern));
 
 	if (!pat) {
-		bt_shell_printf("Failed to allocate pattern");
+		bt_shell_printf("Failed to allocate pattern\n");
 		bt_shell_noninteractive_quit(EXIT_FAILURE);
 		return NULL;
 	}
@@ -537,6 +535,8 @@ static void print_adv_monitor(struct adv_monitor *adv_monitor)
 					adv_monitor->rssi->low_threshold);
 		bt_shell_printf("\t\tlow threshold timer: %hu\n",
 					adv_monitor->rssi->low_timer);
+		bt_shell_printf("\t\tsampling period: %hu\n",
+					adv_monitor->rssi->sampling_period);
 	}
 
 	if (adv_monitor->patterns) {
@@ -572,15 +572,15 @@ void adv_monitor_add_monitor(DBusConnection *conn, char *type,
 	while (find_adv_monitor_with_idx(adv_mon_idx))
 		adv_mon_idx += 1;
 
-	if (rssi_enabled == FALSE)
+	if (rssi_enabled == FALSE) {
 		rssi = NULL;
-	else {
-		rssi = parse_rssi(argv[1], argv[2]);
+	} else {
+		rssi = parse_rssi(argv[1]);
 		if (rssi == NULL)
 			return;
 
-		argv += 2;
-		argc -= 2;
+		argv += 1;
+		argc -= 1;
 	}
 
 	patterns = parse_patterns(argv+1, argc-1);
diff --git a/client/adv_monitor.h b/client/adv_monitor.h
index dd6f615799..2bdc447265 100644
--- a/client/adv_monitor.h
+++ b/client/adv_monitor.h
@@ -12,6 +12,7 @@
 #define RSSI_DEFAULT_LOW_THRESHOLD -70
 #define RSSI_DEFAULT_HIGH_TIMEOUT 10
 #define RSSI_DEFAULT_LOW_TIMEOUT 5
+#define RSSI_DEFAULT_SAMPLING_PERIOD 0
 
 void adv_monitor_add_manager(DBusConnection *conn, GDBusProxy *proxy);
 void adv_monitor_remove_manager(DBusConnection *conn);
diff --git a/client/main.c b/client/main.c
index 9403f1af6e..5d84e7cd54 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2709,26 +2709,23 @@ static void cmd_ad_clear(int argc, char *argv[])
 
 static void print_add_or_pattern_with_rssi_usage(void)
 {
-	bt_shell_printf("rssi-range format:\n"
-			"\t<low-rssi>,<high-rssi>\n"
-			"\tBoth parameters can be skipped, in that case the\n"
-			"\tparamter will be set to its pre-defined value\n");
-	bt_shell_printf("\tPre-defined low-rssi,high-rssi: %d,%d\n",
-						RSSI_DEFAULT_LOW_THRESHOLD,
-						RSSI_DEFAULT_HIGH_THRESHOLD);
-	bt_shell_printf("timeout format:\n"
-			"\t<low-rssi>,<high-rssi>\n"
-			"\tBoth parameters can be skipped, in that case the\n"
-			"\tparamter will be set to its pre-defined value\n");
-	bt_shell_printf("\tPre-defined low-timeout,high-timeout: %d,%d\n",
-						RSSI_DEFAULT_LOW_TIMEOUT,
+	bt_shell_printf("rssi format:\n"
+			"\t<low-rssi>,<high-rssi>,<low-rssi-timeout>,"
+					"<high-rssi-timeout>,<sampling>\n"
+			"\tAll parameters can be skipped, in that case they\n"
+			"\twill be set to pre-defined values, which are:\n");
+	bt_shell_printf("\t\tlow-rssi: %d\n", RSSI_DEFAULT_LOW_THRESHOLD);
+	bt_shell_printf("\t\thigh-rssi: %d\n", RSSI_DEFAULT_HIGH_THRESHOLD);
+	bt_shell_printf("\t\tlow-rssi-timeout: %d\n", RSSI_DEFAULT_LOW_TIMEOUT);
+	bt_shell_printf("\t\thigh-rssi-timeout: %d\n",
 						RSSI_DEFAULT_HIGH_TIMEOUT);
+	bt_shell_printf("\t\tsampling: %d\n", RSSI_DEFAULT_SAMPLING_PERIOD);
 	bt_shell_printf("pattern format:\n"
 			"\t<start_position> <ad_data_type> <content_of_pattern>\n");
 	bt_shell_printf("e.g.\n"
-			"\tadd-or-pattern-rssi -10, ,10 1 2 01ab55\n");
+			"\tadd-or-pattern-rssi -10,,,10,0 1 2 01ab55\n");
 	bt_shell_printf("or\n"
-			"\tadd-or-pattern-rssi -50,-30 , 1 2 01ab55 3 4 23cd66\n");
+			"\tadd-or-pattern-rssi -50,-30,,, 1 2 01ab55 3 4 23cd66\n");
 }
 
 static void print_add_or_pattern_usage(void)
@@ -2826,7 +2823,7 @@ static const struct bt_shell_menu advertise_monitor_menu = {
 	.name = "monitor",
 	.desc = "Advertisement Monitor Options Submenu",
 	.entries = {
-	{ "add-or-pattern-rssi", "<rssi-range=low,high> <timeout=low,high> "
+	{ "add-or-pattern-rssi", "<rssi=low,high,low-time,high-time,sampling> "
 				"[patterns=pattern1 pattern2 ...]",
 				cmd_adv_monitor_add_or_monitor_with_rssi,
 				"Add 'or pattern' type monitor with RSSI "
-- 
2.30.0.284.gd98b1dd5eaa7-goog

