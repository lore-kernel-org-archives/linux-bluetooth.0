Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194CBC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC94323730
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAOLxC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 06:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbhAOLxB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 06:53:01 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167E3C061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:52:21 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x12so5352089plr.21
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uDx22S7e9joL0PJbtxtYhItXcvmuDuR1QrV7+m5uHUE=;
        b=CYWt8vdZDwTsR/A4vu2qNjXv/H530FE6+J8I+ORPSsqZMkdfSwrryQWXsUrEHzQ0NH
         bJ35BYEwjiqsABgG5cUA7FVkXcSWFvnTGYpw8YnqcBMLcvbMyXYOMfExkG5yNrqHfqeK
         3cL6Bx1Wao1Bhjx3J17wlrSURoa4oQlnaZncDnnSaH+HuCorvMQqfKvtveEAzmywYWmD
         eobwhe9QdTvaxLkjiEjLtyE1PdWDvBkrBBgtFT5raoulWbyr9rQ1HtiTGIjLZBLSys9a
         Rb0aekKOCcyqdSZpXuynpSb8Thl53OGEm5nuFRmvXET/QSNa1eTb3uKl02EWJy/lm9uo
         PpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uDx22S7e9joL0PJbtxtYhItXcvmuDuR1QrV7+m5uHUE=;
        b=Y934n56nZgPRDQJ/S44SCg7f9KVUj/I4Ogs3Ct8x62vbwGLkAWvbaSAzYB3zDmnjEn
         ZfIbkRO8LnDIiI6dEvf59184GZl9fOpVAVFTC20q14DEXAwuH/U47hqXIkKW1isZplZV
         S2hgcfbpGl016v0Mw4XlyHbOIRMWZu93BndfvnyQMkUocNQpbIyPSuHy5pB0ObQDF8MC
         njJbTGCOccPfbuGV7MTDz70xMskuV9LaQ5ibDbpR5+RW2lYtJhemAfSlticG//InYCdH
         DayVrvabnFctcipuNvi6glNMl6SbsGcmS69Bb79KRExdp3KIS2+0I5k3rhJy+wCj1b3j
         /CWA==
X-Gm-Message-State: AOAM531N6Q1Kf5NiAlnG/jHjcrfzh2jR6Q4D5wMj6lTODkqh88xUIx0C
        7QoQNTfzTVIG+6KAXQHpIjYJYm86FaGTzikTc03CoeNQfYBmNwP1jrvWRpU3OxZ6R8QUurKmLMW
        t+AUt/AvdaW/+B5znvj3URcypu5NAJscRygEBnfFERC1Ayq/6pPoanIYOZ30okFvjgJwFAF2kgF
        D5
X-Google-Smtp-Source: ABdhPJzGJJhgnOMyFkdPnOxEUi9z8ZCIaZVimlM6YUiQT3a0nHvonYiMdZIhCC1RDiWMgAyXb6XI51b4IjEl
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90a:aa8d:: with SMTP id
 l13mr1113908pjq.0.1610711540110; Fri, 15 Jan 2021 03:52:20 -0800 (PST)
Date:   Fri, 15 Jan 2021 19:50:43 +0800
In-Reply-To: <20210115115036.3973761-1-apusaka@google.com>
Message-Id: <20210115194853.Bluez.v4.5.I20391efb1b5a40cd2b0cb6069d88b7fb9f7ed66b@changeid>
Mime-Version: 1.0
References: <20210115115036.3973761-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [Bluez PATCH v4 5/6] bluetoothctl: advmon rssi support for mgmt
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Using the new opcode MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI to
monitor advertisement according to some RSSI criteria.
---

Changes in v4:
* split the add-or-pattern-rssi command

Changes in v3:
* split the struct RSSIThresholdsAndTimers

 client/adv_monitor.c | 258 ++++++++++++++++++++++++++++---------------
 client/adv_monitor.h |  11 +-
 client/main.c        |  72 ++++++------
 3 files changed, 210 insertions(+), 131 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index f62e9f4442..792379fc40 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -28,11 +28,16 @@
 #define ADV_MONITOR_APP_PATH	"/org/bluez/adv_monitor_app"
 #define ADV_MONITOR_INTERFACE	"org.bluez.AdvertisementMonitor1"
 
+#define RSSI_UNSET_THRESHOLD		127
+#define RSSI_UNSET_TIMEOUT		0
+#define RSSI_UNSET_SAMPLING_PERIOD	256
+
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
@@ -59,6 +64,7 @@ static struct adv_monitor_manager {
 
 static uint8_t adv_mon_idx;
 static GSList *adv_mons;
+static struct rssi_setting *current_rssi;
 
 static void remove_adv_monitor(void *data, void *user_data);
 
@@ -131,32 +137,105 @@ static gboolean get_type(const GDBusPropertyTable *property,
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
 	return TRUE;
 }
 
-static gboolean rssi_exists(const GDBusPropertyTable *property, void *data)
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
+	return TRUE;
+}
+
+static gboolean low_threshold_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct adv_monitor *adv_monitor = data;
+
+	return adv_monitor->rssi != NULL &&
+		adv_monitor->rssi->low_threshold != RSSI_UNSET_THRESHOLD;
+}
+
+static gboolean high_threshold_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct adv_monitor *adv_monitor = data;
+
+	return adv_monitor->rssi != NULL &&
+		adv_monitor->rssi->high_threshold != RSSI_UNSET_THRESHOLD;
+}
+
+static gboolean low_timeout_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct adv_monitor *adv_monitor = data;
+
+	return adv_monitor->rssi != NULL &&
+		adv_monitor->rssi->low_timeout != RSSI_UNSET_TIMEOUT;
+}
+
+static gboolean high_timeout_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct adv_monitor *adv_monitor = data;
+
+	return adv_monitor->rssi != NULL &&
+		adv_monitor->rssi->high_timeout != RSSI_UNSET_TIMEOUT;
+}
+
+static gboolean sampling_period_exists(const GDBusPropertyTable *property,
+								void *data)
 {
 	struct adv_monitor *adv_monitor = data;
 
-	return adv_monitor->rssi != NULL;
+	return adv_monitor->rssi != NULL &&
+		adv_monitor->rssi->sampling_period !=
+						RSSI_UNSET_SAMPLING_PERIOD;
 }
 
 static void append_pattern_content_to_dbus(DBusMessageIter *iter,
@@ -212,7 +291,14 @@ static gboolean pattern_exists(const GDBusPropertyTable *property, void *data)
 
 static const GDBusPropertyTable adv_monitor_props[] = {
 	{ "Type", "s", get_type },
-	{ "RSSIThresholdsAndTimers", "(nqnq)", get_rssi, NULL, rssi_exists },
+	{ "RSSILowThreshold", "n", get_low_threshold, NULL,
+						low_threshold_exists },
+	{ "RSSIHighThreshold", "n", get_high_threshold, NULL,
+						high_threshold_exists },
+	{ "RSSILowTimeout", "q", get_low_timeout, NULL, low_timeout_exists },
+	{ "RSSIHighTimeout", "q", get_high_timeout, NULL, high_timeout_exists },
+	{ "RSSISamplingPeriod", "q", get_sampling_period, NULL,
+						sampling_period_exists },
 	{ "Patterns", "a(yyay)", get_patterns, NULL, pattern_exists },
 	{ }
 };
@@ -266,6 +352,9 @@ void adv_monitor_remove_manager(DBusConnection *conn)
 
 	manager.proxy = NULL;
 	manager.app_registered = FALSE;
+
+	g_free(current_rssi);
+	current_rssi = NULL;
 }
 
 static void register_setup(DBusMessageIter *iter, void *user_data)
@@ -376,58 +465,6 @@ static uint8_t str2bytearray(char *str, uint8_t *arr)
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
-{
-	struct rssi_setting *rssi;
-	int high_threshold, low_threshold, high_timer, low_timer;
-
-	high_threshold = RSSI_DEFAULT_HIGH_THRESHOLD;
-	low_threshold = RSSI_DEFAULT_LOW_THRESHOLD;
-	high_timer = RSSI_DEFAULT_HIGH_TIMEOUT;
-	low_timer = RSSI_DEFAULT_LOW_TIMEOUT;
-
-	parse_rssi_value_pair(range, &low_threshold, &high_threshold);
-	parse_rssi_value_pair(timeout, &low_timer, &high_timer);
-
-	rssi = g_malloc0(sizeof(struct rssi_setting));
-
-	if (!rssi) {
-		bt_shell_printf("Failed to allocate rssi_setting");
-		bt_shell_noninteractive_quit(EXIT_FAILURE);
-		return NULL;
-	}
-
-	rssi->high_threshold = high_threshold;
-	rssi->high_timer = high_timer;
-	rssi->low_threshold = low_threshold;
-	rssi->low_timer = low_timer;
-
-	return rssi;
-}
-
 static struct pattern *parse_pattern(char *parameter_list[])
 {
 	struct pattern *pat;
@@ -435,7 +472,7 @@ static struct pattern *parse_pattern(char *parameter_list[])
 	pat = g_malloc0(sizeof(struct pattern));
 
 	if (!pat) {
-		bt_shell_printf("Failed to allocate pattern");
+		bt_shell_printf("Failed to allocate pattern\n");
 		bt_shell_noninteractive_quit(EXIT_FAILURE);
 		return NULL;
 	}
@@ -531,12 +568,14 @@ static void print_adv_monitor(struct adv_monitor *adv_monitor)
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
@@ -556,11 +595,62 @@ static void print_adv_monitor(struct adv_monitor *adv_monitor)
 	}
 }
 
+static struct rssi_setting *get_current_rssi(void)
+{
+	if (current_rssi)
+		return current_rssi;
+
+	current_rssi = g_malloc0(sizeof(struct rssi_setting));
+
+	if (!current_rssi)
+		bt_shell_printf("Failed to allocate rssi setting");
+
+	current_rssi->low_threshold = RSSI_UNSET_THRESHOLD;
+	current_rssi->high_threshold = RSSI_UNSET_THRESHOLD;
+	current_rssi->low_timeout = RSSI_UNSET_TIMEOUT;
+	current_rssi->high_timeout = RSSI_UNSET_TIMEOUT;
+	current_rssi->sampling_period = RSSI_UNSET_SAMPLING_PERIOD;
+
+	return current_rssi;
+}
+
+void adv_monitor_set_rssi_threshold(int16_t low_threshold,
+							int16_t high_threshold)
+{
+	struct rssi_setting *rssi = get_current_rssi();
+
+	if (!rssi)
+		return;
+
+	rssi->low_threshold = low_threshold;
+	rssi->high_threshold = high_threshold;
+}
+
+void adv_monitor_set_rssi_timeout(uint16_t low_timeout, uint16_t high_timeout)
+{
+	struct rssi_setting *rssi = get_current_rssi();
+
+	if (!rssi)
+		return;
+
+	rssi->low_timeout = low_timeout;
+	rssi->high_timeout = high_timeout;
+}
+
+void adv_monitor_set_rssi_sampling_period(uint16_t sampling)
+{
+	struct rssi_setting *rssi = get_current_rssi();
+
+	if (!rssi)
+		return;
+
+	rssi->sampling_period = sampling;
+}
+
 void adv_monitor_add_monitor(DBusConnection *conn, char *type,
-				gboolean rssi_enabled, int argc, char *argv[])
+							int argc, char *argv[])
 {
 	struct adv_monitor *adv_monitor;
-	struct rssi_setting *rssi;
 	GSList *patterns = NULL;
 
 	if (g_slist_length(adv_mons) >= UINT8_MAX) {
@@ -572,17 +662,6 @@ void adv_monitor_add_monitor(DBusConnection *conn, char *type,
 	while (find_adv_monitor_with_idx(adv_mon_idx))
 		adv_mon_idx += 1;
 
-	if (rssi_enabled == FALSE)
-		rssi = NULL;
-	else {
-		rssi = parse_rssi(argv[1], argv[2]);
-		if (rssi == NULL)
-			return;
-
-		argv += 2;
-		argc -= 2;
-	}
-
 	patterns = parse_patterns(argv+1, argc-1);
 	if (patterns == NULL) {
 		bt_shell_printf("pattern-list malformed\n");
@@ -598,16 +677,19 @@ void adv_monitor_add_monitor(DBusConnection *conn, char *type,
 
 	adv_monitor->idx = adv_mon_idx;
 	adv_monitor->type = g_strdup(type);
-	adv_monitor->rssi = rssi;
+	adv_monitor->rssi = current_rssi;
 	adv_monitor->patterns = patterns;
 	adv_monitor->path = g_strdup_printf("%s/%hhu", ADV_MONITOR_APP_PATH,
 								adv_mon_idx);
+	current_rssi = NULL;
+
 	if (g_dbus_register_interface(conn, adv_monitor->path,
 					ADV_MONITOR_INTERFACE,
 					adv_monitor_methods, NULL,
 					adv_monitor_props, adv_monitor,
 					free_adv_monitor) == FALSE) {
 		bt_shell_printf("Failed to register advertisement monitor\n");
+		free_adv_monitor(adv_monitor);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
diff --git a/client/adv_monitor.h b/client/adv_monitor.h
index dd6f615799..2c25af3339 100644
--- a/client/adv_monitor.h
+++ b/client/adv_monitor.h
@@ -8,17 +8,16 @@
  *
  */
 
-#define RSSI_DEFAULT_HIGH_THRESHOLD -50
-#define RSSI_DEFAULT_LOW_THRESHOLD -70
-#define RSSI_DEFAULT_HIGH_TIMEOUT 10
-#define RSSI_DEFAULT_LOW_TIMEOUT 5
-
 void adv_monitor_add_manager(DBusConnection *conn, GDBusProxy *proxy);
 void adv_monitor_remove_manager(DBusConnection *conn);
 void adv_monitor_register_app(DBusConnection *conn);
 void adv_monitor_unregister_app(DBusConnection *conn);
+void adv_monitor_set_rssi_threshold(int16_t low_threshold,
+							int16_t high_threshold);
+void adv_monitor_set_rssi_timeout(uint16_t low_timeout, uint16_t high_timeout);
+void adv_monitor_set_rssi_sampling_period(uint16_t sampling);
 void adv_monitor_add_monitor(DBusConnection *conn, char *type,
-				gboolean rssi_enabled, int argc, char *argv[]);
+							int argc, char *argv[]);
 void adv_monitor_print_monitor(DBusConnection *conn, int monitor_idx);
 void adv_monitor_remove_monitor(DBusConnection *conn, int monitor_idx);
 void adv_monitor_get_supported_info(void);
diff --git a/client/main.c b/client/main.c
index 9403f1af6e..79658a463f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2707,30 +2707,6 @@ static void cmd_ad_clear(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
-static void print_add_or_pattern_with_rssi_usage(void)
-{
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
-						RSSI_DEFAULT_HIGH_TIMEOUT);
-	bt_shell_printf("pattern format:\n"
-			"\t<start_position> <ad_data_type> <content_of_pattern>\n");
-	bt_shell_printf("e.g.\n"
-			"\tadd-or-pattern-rssi -10, ,10 1 2 01ab55\n");
-	bt_shell_printf("or\n"
-			"\tadd-or-pattern-rssi -50,-30 , 1 2 01ab55 3 4 23cd66\n");
-}
-
 static void print_add_or_pattern_usage(void)
 {
 	bt_shell_printf("pattern format:\n"
@@ -2743,20 +2719,38 @@ static void cmd_adv_monitor_print_usage(int argc, char *argv[])
 {
 	if (strcmp(argv[1], "add-or-pattern") == 0)
 		print_add_or_pattern_usage();
-	else if (strcmp(argv[1], "add-or-pattern-rssi") == 0)
-		print_add_or_pattern_with_rssi_usage();
 	else
 		bt_shell_printf("Invalid argument %s", argv[1]);
 }
 
-static void cmd_adv_monitor_add_or_monitor_with_rssi(int argc, char *argv[])
+static void cmd_adv_monitor_set_rssi_threshold(int argc, char *argv[])
+{
+	int low_threshold, high_threshold;
+
+	low_threshold = atoi(argv[1]);
+	high_threshold = atoi(argv[2]);
+	adv_monitor_set_rssi_threshold(low_threshold, high_threshold);
+}
+
+static void cmd_adv_monitor_set_rssi_timeout(int argc, char *argv[])
 {
-	adv_monitor_add_monitor(dbus_conn, "or_patterns", TRUE, argc, argv);
+	int low_timeout, high_timeout;
+
+	low_timeout = atoi(argv[1]);
+	high_timeout = atoi(argv[2]);
+	adv_monitor_set_rssi_timeout(low_timeout, high_timeout);
+}
+
+static void cmd_adv_monitor_set_rssi_sampling_period(int argc, char *argv[])
+{
+	int sampling = atoi(argv[1]);
+
+	adv_monitor_set_rssi_sampling_period(sampling);
 }
 
 static void cmd_adv_monitor_add_or_monitor(int argc, char *argv[])
 {
-	adv_monitor_add_monitor(dbus_conn, "or_patterns", FALSE, argc, argv);
+	adv_monitor_add_monitor(dbus_conn, "or_patterns", argc, argv);
 }
 
 static void cmd_adv_monitor_print_monitor(int argc, char *argv[])
@@ -2826,15 +2820,19 @@ static const struct bt_shell_menu advertise_monitor_menu = {
 	.name = "monitor",
 	.desc = "Advertisement Monitor Options Submenu",
 	.entries = {
-	{ "add-or-pattern-rssi", "<rssi-range=low,high> <timeout=low,high> "
-				"[patterns=pattern1 pattern2 ...]",
-				cmd_adv_monitor_add_or_monitor_with_rssi,
-				"Add 'or pattern' type monitor with RSSI "
-				"filter" },
+	{ "set-rssi-threshold", "<low_threshold> <high_threshold>",
+				cmd_adv_monitor_set_rssi_threshold,
+				"Set RSSI threshold parameter" },
+	{ "set-rssi-timeout", "<low_timeout> <high_timeout>",
+				cmd_adv_monitor_set_rssi_timeout,
+				"Set RSSI timeout parameter" },
+	{ "set-rssi-sampling-period", "<sampling_period>",
+				cmd_adv_monitor_set_rssi_sampling_period,
+				"Set RSSI sampling period parameter" },
 	{ "add-or-pattern", "[patterns=pattern1 pattern2 ...]",
 				cmd_adv_monitor_add_or_monitor,
-				"Add 'or pattern' type monitor without RSSI "
-				"filter" },
+				"Register 'or pattern' type monitor with the "
+				"specified RSSI parameters" },
 	{ "get-pattern", "<monitor-id/all>",
 				cmd_adv_monitor_print_monitor,
 				"Get advertisement monitor" },
@@ -2845,7 +2843,7 @@ static const struct bt_shell_menu advertise_monitor_menu = {
 				cmd_adv_monitor_get_supported_info,
 				"Get advertisement manager supported "
 				"features and supported monitor types" },
-	{ "print-usage", "<add-or-pattern/add-or-pattern-rssi>",
+	{ "print-usage", "<add-or-pattern>",
 				cmd_adv_monitor_print_usage,
 				"Print the command usage"},
 	{ } },
-- 
2.30.0.296.g2bfb1c46d8-goog

