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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7270C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 07:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A96B23A01
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 07:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbhANHqG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbhANHqF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jan 2021 02:46:05 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96CBC0617A2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 23:45:21 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 189so3858281qko.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 23:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OGW7rgUGsPRtCb6jnMzgjukWrsHDtKnOgPORzmMgErA=;
        b=U3eDCy3n6jeIM/URNUyNlrN7VvGtlrUzZ03i+DWc1Wu9rebqYZoiwsTRXo2meBxjeg
         43qcv3Q/LVYZi//FqqNeOYLOs03q1NCH2Vt+Xw1QlbwgEnur0eOFIRlP9sJZorEAlsDH
         b0QaxTk7mBuMgDdHlmMVlM4lqcdrsTTKE2RRcvOteauAui5hi4KOBRk1hi4F3WHeWfVZ
         privw3NFNCUGndStR3fr2r0Dy5m0qdxxUpEQmW3DT9seAQzKhQnhwt00o7KvztIt430L
         ojw5Y4gxYv5v+eGCx+TnHh8aaoWdDdw8kxc0DXYT2yOqdBarCNDegFsv3KWstODUTQBP
         bF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OGW7rgUGsPRtCb6jnMzgjukWrsHDtKnOgPORzmMgErA=;
        b=JG+A2aQNkn74LIBYGpZGpbkh5fi8tq2ga85VhX2h+sxnBOR6RDOAbX0/AJQJsPdBsf
         9Q/mSFPXMNxSEfmy2DcpAMjqCS1rXtpWGa0EkU3jLRY/oANXnSblQEBgkgBN74vlTi70
         OCKtYnCec6aR4yRrMfmAwZEg9uMvTdFPB6z8tUPSU6S/vHHssxG7C/owen0dDzZUMq9M
         LqzIDbyvJedN2FlP+qLR/d+DSYOigKyARDomJvyKJD0QDLXYENJOa3OcKfdTD+IOR7YA
         GbHFjnQUbGc5Xy/g7mRYqC7odt6T6GuJRD9z3ghbtKrK24Mj4nkfsZhAae6sF2ihYNxn
         D77Q==
X-Gm-Message-State: AOAM533aT6xFbtstVlpwh4QIWD0caXt1hk6R5f9YQVBoA/BES68gGM2P
        Ugbbfy6YhwLBsRqFDdgneu6Brqr5GFqAfisAlNolfDb6+6tVVhZSiWme/PKR1QBMueRErXJPxLr
        d9/2f4Ej4fRCTUvsh30X7DU0vongJgIeSl3AVq0tUnEIEviScAI14QmenHGRJtVMF/NiCoDSp2F
        ww
X-Google-Smtp-Source: ABdhPJx5dptIyX8uWilrWflL7+WDTEjw/PYj90vFSzhgZjsdpjBTLBsz0UcxfjfH3ktySks19sPhHIRffz3z
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a05:6214:1583:: with SMTP id
 m3mr5813421qvw.48.1610610320798; Wed, 13 Jan 2021 23:45:20 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:44:57 +0800
In-Reply-To: <20210114074458.3399055-1-apusaka@google.com>
Message-Id: <20210114154405.Bluez.v3.4.I20391efb1b5a40cd2b0cb6069d88b7fb9f7ed66b@changeid>
Mime-Version: 1.0
References: <20210114074458.3399055-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH v3 4/5] bluetoothctl: advmon rssi support for mgmt
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

Changes in v3:
* split the struct RSSIThresholdsAndTimers

 client/adv_monitor.c | 162 ++++++++++++++++++++++++++-----------------
 client/adv_monitor.h |   1 +
 client/main.c        |  29 ++++----
 3 files changed, 113 insertions(+), 79 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index f62e9f4442..37faf1edfa 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -30,9 +30,10 @@
 
 struct rssi_setting {
 	int16_t high_threshold;
-	uint16_t high_timer;
+	uint16_t high_timeout;
 	int16_t low_threshold;
-	uint16_t low_timer;
+	uint16_t low_timeout;
+	uint16_t sampling_period;
 };
 
 struct pattern {
@@ -131,24 +132,58 @@ static gboolean get_type(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean get_rssi(const GDBusPropertyTable *property,
+static gboolean get_low_threshold(const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *user_data)
 {
 	struct adv_monitor *adv_monitor = user_data;
 	struct rssi_setting *rssi = adv_monitor->rssi;
-	DBusMessageIter data_iter;
 
-	dbus_message_iter_open_container(iter, DBUS_TYPE_STRUCT,
-							NULL, &data_iter);
-	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_INT16,
-							&rssi->high_threshold);
-	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_UINT16,
-							&rssi->high_timer);
-	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_INT16,
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16,
 							&rssi->low_threshold);
-	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_UINT16,
-							&rssi->low_timer);
-	dbus_message_iter_close_container(iter, &data_iter);
+	return TRUE;
+}
+
+static gboolean get_high_threshold(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+	struct rssi_setting *rssi = adv_monitor->rssi;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16,
+							&rssi->high_threshold);
+	return TRUE;
+}
+
+static gboolean get_low_timeout(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+	struct rssi_setting *rssi = adv_monitor->rssi;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&rssi->low_timeout);
+	return TRUE;
+}
+
+static gboolean get_high_timeout(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+	struct rssi_setting *rssi = adv_monitor->rssi;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&rssi->high_timeout);
+	return TRUE;
+}
+
+static gboolean get_sampling_period(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+	struct rssi_setting *rssi = adv_monitor->rssi;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&rssi->sampling_period);
 	return TRUE;
 }
 
@@ -212,7 +247,11 @@ static gboolean pattern_exists(const GDBusPropertyTable *property, void *data)
 
 static const GDBusPropertyTable adv_monitor_props[] = {
 	{ "Type", "s", get_type },
-	{ "RSSIThresholdsAndTimers", "(nqnq)", get_rssi, NULL, rssi_exists },
+	{ "RSSILowThreshold", "n", get_low_threshold, NULL, rssi_exists },
+	{ "RSSIHighThreshold", "n", get_high_threshold, NULL, rssi_exists },
+	{ "RSSILowTimeout", "q", get_low_timeout, NULL, rssi_exists },
+	{ "RSSIHighTimeout", "q", get_high_timeout, NULL, rssi_exists },
+	{ "RSSISamplingPeriod", "q", get_sampling_period, NULL, rssi_exists },
 	{ "Patterns", "a(yyay)", get_patterns, NULL, pattern_exists },
 	{ }
 };
@@ -376,56 +415,51 @@ static uint8_t str2bytearray(char *str, uint8_t *arr)
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
+	rssi->low_timeout = values[2];
+	rssi->high_timeout = values[3];
+	rssi->sampling_period = values[4];
 
 	return rssi;
+
+bad_format:
+	bt_shell_printf("Failed to parse RSSI\n");
+	bt_shell_noninteractive_quit(EXIT_FAILURE);
+	return NULL;
 }
 
 static struct pattern *parse_pattern(char *parameter_list[])
@@ -435,7 +469,7 @@ static struct pattern *parse_pattern(char *parameter_list[])
 	pat = g_malloc0(sizeof(struct pattern));
 
 	if (!pat) {
-		bt_shell_printf("Failed to allocate pattern");
+		bt_shell_printf("Failed to allocate pattern\n");
 		bt_shell_noninteractive_quit(EXIT_FAILURE);
 		return NULL;
 	}
@@ -531,12 +565,14 @@ static void print_adv_monitor(struct adv_monitor *adv_monitor)
 		bt_shell_printf("\trssi:\n");
 		bt_shell_printf("\t\thigh threshold: %hd\n",
 					adv_monitor->rssi->high_threshold);
-		bt_shell_printf("\t\thigh threshold timer: %hu\n",
-					adv_monitor->rssi->high_timer);
+		bt_shell_printf("\t\thigh threshold timeout: %hu\n",
+					adv_monitor->rssi->high_timeout);
 		bt_shell_printf("\t\tlow threshold: %hd\n",
 					adv_monitor->rssi->low_threshold);
-		bt_shell_printf("\t\tlow threshold timer: %hu\n",
-					adv_monitor->rssi->low_timer);
+		bt_shell_printf("\t\tlow threshold timeout: %hu\n",
+					adv_monitor->rssi->low_timeout);
+		bt_shell_printf("\t\tsampling period: %hu\n",
+					adv_monitor->rssi->sampling_period);
 	}
 
 	if (adv_monitor->patterns) {
@@ -572,15 +608,15 @@ void adv_monitor_add_monitor(DBusConnection *conn, char *type,
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

