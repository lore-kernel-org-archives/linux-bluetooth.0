Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCD9C43461
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 12:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C31221F1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 12:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZzriICdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgIKMLB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgIKMJs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 08:09:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B660DC061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 05:09:41 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id q2so6837555pfc.17
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=p9sD2Axl5zUzpyNH9eTboePnANbrOFugW8nMQboWduY=;
        b=ZzriICdJz7t+dbDamYVtO1nX1qnu8DofWF7De5ZT+yV+AMG9iU05oWppiFHOnWhDMY
         KnNbQ3x/H9Xum0LLysUR5S1x2gdTL0oHyJFmkSauHVtmhIhR0seV1Oz/ANLLkq+bdQLt
         cyKusH4fxvDrfpWdziFh+7gTMROqIG6pNt50Ad3OsAOVqDBwxXA9T9R6kUP1fNhfvZsP
         CA5uJ99vp7yy08YXgtIB9300XSDpqHWtBucLadYRl3YyGE1bvsq7mOr4QDkrf9vaXDE1
         l8xuzVxT2uIp2lZcCLXnNhBt5wAxwB4k7CXYwKRkwtJr7cOA+p7l+qHSyZif5+1CZFJT
         rYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p9sD2Axl5zUzpyNH9eTboePnANbrOFugW8nMQboWduY=;
        b=qnz4cuLLP+d290IN1IAhpePN7G+GyfsCbpOrdPWOjlNg4oRzzZ0QGsI/H3FxKxrHKD
         kXOjZPocrEufmdSKzYjtzmDItn+NXQs46xH4LbVrJI55YirRSw2vr9Dswh44+F8e4Nq2
         BKhWtINHiv220d6mppa8qSuQ/c8e5HacrwDpFTtgEPrqHc0AfX6M1MHHh5x2jMalOVQx
         rMB/lf5SHTBaQ8cZ9Eal5yy347cdNuJvze7w1q2SVDSQT1i6oL0XgQ9wlqiESR0Oflw5
         1btK/+xQRtiUVXoKtWFpXNTsDZLhc+3I6kJXlsIYgYwba/E39S2tkv9m5EIlOG6mDc4w
         2Lng==
X-Gm-Message-State: AOAM530PRxf5WM7s1QuPU6A7h4tTzHk/tJm1FwBRCqWZHwBQiRItY/55
        D5pwwCmqM1ECBNzXDTSZey724AYgiV0d3dFyvmQds+svX6gDCl/QqJNuWNR+dAp0nTEQKiPkHKM
        cpsiWItvc5BYTIZGcRIGtd5Ci1eA/y/e3pLe7Mwqcy9LWPDhgFLs8E8V/wiDX10ZYtdHLPAitzt
        i9JFd5y9uSJwM=
X-Google-Smtp-Source: ABdhPJzyvBWEVkbAvRwLYboy8Lt8B0JHMTBkIvNgJxjZw5e6xNylVEWbLQWnJmvTrIUZbnY3G43Vu6iCOOOVJ5yYpw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:90b:15c6:: with SMTP id
 lh6mr24753pjb.0.1599826180765; Fri, 11 Sep 2020 05:09:40 -0700 (PDT)
Date:   Fri, 11 Sep 2020 20:09:27 +0800
In-Reply-To: <20200911200839.BlueZ.v3.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
Message-Id: <20200911200839.BlueZ.v3.2.Iec6b15e23f4228b80f9b364eb76515d146d592d5@changeid>
Mime-Version: 1.0
References: <20200911200839.BlueZ.v3.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v3 2/4] PRE-UPSTREAM: client: Implement more interfaces
 of ADV monitor in bluetoothctl
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mmandlik@chromium.org, mcchou@chromium.org,
        luiz.von.dentz@intel.com, alainm@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch creates a submenu in bluetoothctl and implements several
commands.

new commands:
[bluetooth]# menu monitor
[bluetooth]# add-or-pattern 1 2 ab0011
Advertisement Monitor 0 added
[bluetooth]# add-or-pattern-rssi -80, ,5 1 2 aa 3 4 ff
Advertisement Monitor 1 added
[bluetooth]# get-pattern all
Advertisement Monitor 0
	path: /org/bluez/adv_monitor_app/0
	type: or_patterns
	pattern 1:
		start position: 1
		AD data type: 2
		content: ab0011
Advertisement Monitor 1
	path: /org/bluez/adv_monitor_app/1
	type: or_patterns
	rssi:
		high threshold: -50
		high threshold timer: 5
		low threshold: -80
		low threshold timer: 5
	pattern 1:
		start position: 1
		AD data type: 2
		content: aa
	pattern 2:
		start position: 3
		AD data type: 4
		content: ff
[bluetooth]# get-supported-info
Supported Features:
Supported Moniter Types: or_patterns
[bluetooth]# remove-pattern 0
Monitor 0 deleted

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v2)

Changes in v2:
- Update the add-pattern usage

 client/adv_monitor.c | 352 ++++++++++++++++++++++++++++++++++++++++++-
 client/adv_monitor.h |  10 ++
 client/main.c        | 109 ++++++++++++++
 3 files changed, 468 insertions(+), 3 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index 2a62389d9..49c0dd01d 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -29,6 +29,7 @@
 #include <string.h>
 
 #include "gdbus/gdbus.h"
+#include "src/shared/ad.h"
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
 #include "adv_monitor.h"
@@ -36,6 +37,27 @@
 #define ADV_MONITOR_APP_PATH	"/org/bluez/adv_monitor_app"
 #define ADV_MONITOR_INTERFACE	"org.bluez.AdvertisementMonitor1"
 
+struct rssi_setting {
+	int16_t high_threshold;
+	uint16_t high_timer;
+	int16_t low_threshold;
+	uint16_t low_timer;
+};
+
+struct pattern {
+	uint8_t start_pos;
+	uint8_t ad_data_type;
+	uint8_t content_len;
+	uint8_t content[BT_AD_MAX_DATA_LEN];
+};
+
+struct adv_monitor {
+	uint8_t idx;
+	char *type;
+	struct rssi_setting *rssi;
+	GSList *patterns;
+};
+
 static struct adv_monitor_manager {
 	GSList *supported_types;
 	GSList *supported_features;
@@ -43,6 +65,9 @@ static struct adv_monitor_manager {
 	gboolean app_registered;
 } manager = { NULL, NULL, NULL, FALSE };
 
+static uint8_t adv_mon_idx;
+static GSList *adv_mons;
+
 static void set_supported_list(GSList **list, DBusMessageIter *iter)
 {
 	char *str;
@@ -138,7 +163,10 @@ static void unregister_reply(DBusMessage *message, void *user_data)
 
 void adv_monitor_register_app(DBusConnection *conn)
 {
-	if (manager.supported_types == NULL || manager.app_registered == TRUE ||
+	if (manager.app_registered == TRUE) {
+		bt_shell_printf("Advertisement Monitor already registered\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	} else if (manager.supported_types == NULL ||
 		g_dbus_proxy_method_call(manager.proxy, "RegisterMonitor",
 					register_setup, register_reply,
 					NULL, NULL) == FALSE) {
@@ -150,8 +178,10 @@ void adv_monitor_register_app(DBusConnection *conn)
 
 void adv_monitor_unregister_app(DBusConnection *conn)
 {
-	if (manager.app_registered == FALSE ||
-		g_dbus_proxy_method_call(manager.proxy, "UnregisterMonitor",
+	if (manager.app_registered == FALSE) {
+		bt_shell_printf("Advertisement Monitor not registered\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	} else if (g_dbus_proxy_method_call(manager.proxy, "UnregisterMonitor",
 					unregister_setup, unregister_reply,
 					NULL, NULL) == FALSE) {
 		bt_shell_printf("Failed to unregister Advertisement Monitor\n");
@@ -159,3 +189,319 @@ void adv_monitor_unregister_app(DBusConnection *conn)
 	}
 	manager.app_registered = FALSE;
 }
+
+static void free_pattern(void *user_data)
+{
+	struct pattern *p = user_data;
+
+	g_free(p);
+}
+
+static void free_adv_monitor(void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+
+	g_free(adv_monitor->type);
+	g_free(adv_monitor->rssi);
+	g_slist_free_full(adv_monitor->patterns, free_pattern);
+	g_free(adv_monitor);
+}
+
+static uint8_t str2bytearray(char *str, uint8_t *arr)
+{
+	int idx, len = strlen(str), arr_len = 0;
+
+	if (len%2 != 0)
+		return 0;
+
+	for (idx = 0; idx < len; idx += 2) {
+		if (sscanf(str+idx, "%2hhx", &arr[arr_len++]) < 1)
+			return 0;
+	}
+	return arr_len;
+}
+
+static void parse_rssi_value_pair(char *value_pair, int *low, int *high)
+{
+	char *val1, *val2;
+	bool flag = value_pair[0] == ',';
+
+	val1 = strtok(value_pair, ",");
+
+	if (!val1)
+		return;
+
+	val2 = strtok(NULL, ",");
+
+	if (!val2) {
+		if (!flag)
+			*low = atoi(val1);
+		else
+			*high = atoi(val1);
+	} else {
+		*low = atoi(val1);
+		*high = atoi(val2);
+	}
+}
+
+static struct rssi_setting *parse_rssi(char *range, char *timeout)
+{
+	struct rssi_setting *rssi;
+	int high_threshold, low_threshold, high_timer, low_timer;
+
+	high_threshold = RSSI_DEFAULT_HIGH_THRESHOLD;
+	low_threshold = RSSI_DEFAULT_LOW_THRESHOLD;
+	high_timer = RSSI_DEFAULT_HIGH_TIMEOUT;
+	low_timer = RSSI_DEFAULT_LOW_TIMEOUT;
+
+	parse_rssi_value_pair(range, &low_threshold, &high_threshold);
+	parse_rssi_value_pair(timeout, &low_timer, &high_timer);
+
+	rssi = g_malloc0(sizeof(struct rssi_setting));
+
+	if (!rssi) {
+		bt_shell_printf("Failed to allocate rssi_setting");
+		bt_shell_noninteractive_quit(EXIT_FAILURE);
+		return NULL;
+	}
+
+	rssi->high_threshold = high_threshold;
+	rssi->high_timer = high_timer;
+	rssi->low_threshold = low_threshold;
+	rssi->low_timer = low_timer;
+
+	return rssi;
+}
+
+static struct pattern *parse_pattern(char *parameter_list[])
+{
+	struct pattern *pat;
+
+	pat = g_malloc0(sizeof(struct pattern));
+
+	if (!pat) {
+		bt_shell_printf("Failed to allocate pattern");
+		bt_shell_noninteractive_quit(EXIT_FAILURE);
+		return NULL;
+	}
+
+	pat->start_pos = atoi(parameter_list[0]);
+	pat->ad_data_type = atoi(parameter_list[1]);
+	pat->content_len = str2bytearray(parameter_list[2], pat->content);
+	if (pat->content_len == 0) {
+		free_pattern(pat);
+		return NULL;
+	}
+
+	return pat;
+}
+
+static GSList *parse_patterns(char *pattern_list[], int num)
+{
+	GSList *patterns = NULL;
+	int cnt;
+
+	if (num == 0) {
+		bt_shell_printf("No pattern provided\n");
+		return NULL;
+	}
+
+	if (num%3) {
+		bt_shell_printf("Expected %d more arguments\n", 3 - num%3);
+		return NULL;
+	}
+
+	for (cnt = 0; cnt < num; cnt += 3) {
+		struct pattern *pattern;
+
+		pattern = parse_pattern(pattern_list+cnt);
+		if (pattern == NULL) {
+			g_slist_free_full(patterns, free_pattern);
+			return NULL;
+		}
+		patterns = g_slist_append(patterns, pattern);
+	}
+
+	return patterns;
+}
+
+static gint cmp_adv_monitor_with_idx(gconstpointer a, gconstpointer b)
+{
+	const struct adv_monitor *adv_monitor = a;
+	uint8_t idx = *(uint8_t *)b;
+
+	return adv_monitor->idx != idx;
+}
+
+static struct adv_monitor *find_adv_monitor_with_idx(uint8_t monitor_idx)
+{
+	GSList *list;
+
+	list = g_slist_find_custom(adv_mons, &monitor_idx,
+						cmp_adv_monitor_with_idx);
+
+	if (list)
+		return (struct adv_monitor *)list->data;
+	return NULL;
+}
+
+static void print_bytearray(char *prefix, uint8_t *arr, uint8_t len)
+{
+	int idx;
+
+	bt_shell_printf("%s", prefix);
+	for (idx = 0; idx < len; idx++)
+		bt_shell_printf("%02hhx", arr[idx]);
+	bt_shell_printf("\n");
+}
+
+static void print_adv_monitor(struct adv_monitor *adv_monitor)
+{
+	GSList *l;
+
+	bt_shell_printf("Advertisement Monitor %d\n", adv_monitor->idx);
+	bt_shell_printf("\ttype: %s\n", adv_monitor->type);
+	if (adv_monitor->rssi) {
+		bt_shell_printf("\trssi:\n");
+		bt_shell_printf("\t\thigh threshold: %hd\n",
+					adv_monitor->rssi->high_threshold);
+		bt_shell_printf("\t\thigh threshold timer: %hu\n",
+					adv_monitor->rssi->high_timer);
+		bt_shell_printf("\t\tlow threshold: %hd\n",
+					adv_monitor->rssi->low_threshold);
+		bt_shell_printf("\t\tlow threshold timer: %hu\n",
+					adv_monitor->rssi->low_timer);
+	}
+
+	if (adv_monitor->patterns) {
+		int idx = 1;
+
+		for (l = adv_monitor->patterns; l; l = g_slist_next(l), idx++) {
+			struct pattern *pattern = l->data;
+
+			bt_shell_printf("\tpattern %d:\n", idx);
+			bt_shell_printf("\t\tstart position: %hhu\n",
+							pattern->start_pos);
+			bt_shell_printf("\t\tAD data type: %hhu\n",
+							pattern->ad_data_type);
+			print_bytearray("\t\tcontent: ", pattern->content,
+							pattern->content_len);
+		}
+	}
+}
+
+void adv_monitor_add_monitor(DBusConnection *conn, char *type,
+				gboolean rssi_enabled, int argc, char *argv[])
+{
+	struct adv_monitor *adv_monitor;
+	struct rssi_setting *rssi;
+	GSList *patterns = NULL;
+
+	if (g_slist_length(adv_mons) >= UINT8_MAX) {
+		bt_shell_printf("Number of advertisement monitor exceeds "
+				"the limit");
+		return;
+	}
+
+	while (find_adv_monitor_with_idx(adv_mon_idx))
+		adv_mon_idx += 1;
+
+	if (rssi_enabled == FALSE)
+		rssi = NULL;
+	else {
+		rssi = parse_rssi(argv[1], argv[2]);
+		if (rssi == NULL)
+			return;
+
+		argv += 2;
+		argc -= 2;
+	}
+
+	patterns = parse_patterns(argv+1, argc-1);
+	if (patterns == NULL) {
+		bt_shell_printf("pattern-list malformed\n");
+		return;
+	}
+
+	adv_monitor = g_malloc0(sizeof(struct adv_monitor));
+
+	if (!adv_monitor) {
+		bt_shell_printf("Failed to allocate adv_monitor");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	adv_monitor->idx = adv_mon_idx;
+	adv_monitor->type = g_strdup(type);
+	adv_monitor->rssi = rssi;
+	adv_monitor->patterns = patterns;
+
+	adv_mons = g_slist_append(adv_mons, adv_monitor);
+	bt_shell_printf("Advertisement Monitor %d added\n", adv_monitor->idx);
+}
+
+void adv_monitor_print_monitor(DBusConnection *conn, int monitor_idx)
+{
+	struct adv_monitor *adv_monitor;
+	GSList *l;
+
+	if (monitor_idx < 0) {
+		for (l = adv_mons; l; l = g_slist_next(l)) {
+			adv_monitor = l->data;
+			print_adv_monitor(adv_monitor);
+		}
+		return;
+	}
+
+	adv_monitor = find_adv_monitor_with_idx(monitor_idx);
+
+	if (adv_monitor == NULL) {
+		bt_shell_printf("Can't find monitor with index %d\n",
+								monitor_idx);
+		return;
+	}
+
+	print_adv_monitor(adv_monitor);
+}
+
+void adv_monitor_remove_monitor(DBusConnection *conn, int monitor_idx)
+{
+	struct adv_monitor *adv_monitor;
+
+	if (monitor_idx < 0) {
+		g_slist_free_full(g_steal_pointer(&adv_mons), free_adv_monitor);
+		return;
+	}
+
+	adv_monitor = find_adv_monitor_with_idx(monitor_idx);
+	if (adv_monitor == NULL) {
+		bt_shell_printf("Can't find monitor with index %d\n",
+								monitor_idx);
+		return;
+	}
+
+	adv_mons = g_slist_remove(adv_mons, adv_monitor);
+	free_adv_monitor(adv_monitor);
+	bt_shell_printf("Monitor %d deleted\n", monitor_idx);
+}
+
+static void print_supported_list(GSList *list)
+{
+	GSList *iter;
+
+	for (iter = list; iter; iter = g_slist_next(iter)) {
+		char *data = iter->data;
+
+		printf(" %s", data);
+	}
+}
+
+void adv_monitor_get_supported_info(void)
+{
+	bt_shell_printf("Supported Features:");
+	print_supported_list(manager.supported_features);
+	bt_shell_printf("\n");
+
+	bt_shell_printf("Supported Moniter Types:");
+	print_supported_list(manager.supported_types);
+	bt_shell_printf("\n");
+}
diff --git a/client/adv_monitor.h b/client/adv_monitor.h
index 77b0b62c6..12c01bd3f 100644
--- a/client/adv_monitor.h
+++ b/client/adv_monitor.h
@@ -17,7 +17,17 @@
  *
  */
 
+#define RSSI_DEFAULT_HIGH_THRESHOLD -50
+#define RSSI_DEFAULT_LOW_THRESHOLD -70
+#define RSSI_DEFAULT_HIGH_TIMEOUT 10
+#define RSSI_DEFAULT_LOW_TIMEOUT 5
+
 void adv_monitor_add_manager(DBusConnection *conn, GDBusProxy *proxy);
 void adv_monitor_remove_manager(DBusConnection *conn);
 void adv_monitor_register_app(DBusConnection *conn);
 void adv_monitor_unregister_app(DBusConnection *conn);
+void adv_monitor_add_monitor(DBusConnection *conn, char *type,
+				gboolean rssi_enabled, int argc, char *argv[]);
+void adv_monitor_print_monitor(DBusConnection *conn, int monitor_idx);
+void adv_monitor_remove_monitor(DBusConnection *conn, int monitor_idx);
+void adv_monitor_get_supported_info(void);
diff --git a/client/main.c b/client/main.c
index 75f8bc462..2b0243308 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2719,6 +2719,85 @@ static void cmd_ad_clear(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void print_add_or_pattern_with_rssi_usage(void)
+{
+	bt_shell_printf("rssi-range format:\n"
+			"\t<low-rssi>,<high-rssi>\n"
+			"\tBoth parameters can be skipped, in that case the\n"
+			"\tparamter will be set to its pre-defined value\n");
+	bt_shell_printf("\tPre-defined low-rssi,high-rssi: %d,%d\n",
+						RSSI_DEFAULT_LOW_THRESHOLD,
+						RSSI_DEFAULT_HIGH_THRESHOLD);
+	bt_shell_printf("timeout format:\n"
+			"\t<low-rssi>,<high-rssi>\n"
+			"\tBoth parameters can be skipped, in that case the\n"
+			"\tparamter will be set to its pre-defined value\n");
+	bt_shell_printf("\tPre-defined low-timeout,high-timeout: %d,%d\n",
+						RSSI_DEFAULT_LOW_TIMEOUT,
+						RSSI_DEFAULT_HIGH_TIMEOUT);
+	bt_shell_printf("pattern format:\n"
+			"\t<start_position> <ad_data_type> <content_of_pattern>\n");
+	bt_shell_printf("e.g.\n"
+			"\tadd-or-pattern-rssi -10, ,10 1 2 01ab55\n");
+	bt_shell_printf("or\n"
+			"\tadd-or-pattern-rssi -50,-30 , 1 2 01ab55 3 4 23cd66\n");
+}
+
+static void print_add_or_pattern_usage(void)
+{
+	bt_shell_printf("pattern format:\n"
+			"\t<start_position> <ad_data_type> <content_of_pattern>\n");
+	bt_shell_printf("e.g.\n"
+			"\tadd-or-pattern 1 2 01ab55 3 4 23cd66\n");
+}
+
+static void cmd_adv_monitor_print_usage(int argc, char *argv[])
+{
+	if (strcmp(argv[1], "add-or-pattern") == 0)
+		print_add_or_pattern_usage();
+	else if (strcmp(argv[1], "add-or-pattern-rssi") == 0)
+		print_add_or_pattern_with_rssi_usage();
+	else
+		bt_shell_printf("Invalid argument %s", argv[1]);
+}
+
+static void cmd_adv_monitor_add_or_monitor_with_rssi(int argc, char *argv[])
+{
+	adv_monitor_add_monitor(dbus_conn, "or_patterns", TRUE, argc, argv);
+}
+
+static void cmd_adv_monitor_add_or_monitor(int argc, char *argv[])
+{
+	adv_monitor_add_monitor(dbus_conn, "or_patterns", FALSE, argc, argv);
+}
+
+static void cmd_adv_monitor_print_monitor(int argc, char *argv[])
+{
+	int monitor_idx;
+
+	if (strcmp(argv[1], "all") == 0)
+		monitor_idx = -1;
+	else
+		monitor_idx = atoi(argv[1]);
+	adv_monitor_print_monitor(dbus_conn, monitor_idx);
+}
+
+static void cmd_adv_monitor_remove_monitor(int argc, char *argv[])
+{
+	int monitor_idx;
+
+	if (strcmp(argv[1], "all") == 0)
+		monitor_idx = -1;
+	else
+		monitor_idx = atoi(argv[1]);
+	adv_monitor_remove_monitor(dbus_conn, monitor_idx);
+}
+
+static void cmd_adv_monitor_get_supported_info(int argc, char *argv[])
+{
+	adv_monitor_get_supported_info();
+}
+
 static const struct bt_shell_menu advertise_menu = {
 	.name = "advertise",
 	.desc = "Advertise Options Submenu",
@@ -2755,6 +2834,35 @@ static const struct bt_shell_menu advertise_menu = {
 	{ } },
 };
 
+static const struct bt_shell_menu advertise_monitor_menu = {
+	.name = "monitor",
+	.desc = "Advertisement Monitor Options Submenu",
+	.entries = {
+	{ "add-or-pattern-rssi", "<rssi-range=low,high> <timeout=low,high> "
+				"[patterns=pattern1 pattern2 ...]",
+				cmd_adv_monitor_add_or_monitor_with_rssi,
+				"Add 'or pattern' type monitor with RSSI "
+				"filter" },
+	{ "add-or-pattern", "[patterns=pattern1 pattern2 ...]",
+				cmd_adv_monitor_add_or_monitor,
+				"Add 'or pattern' type monitor without RSSI "
+				"filter" },
+	{ "get-pattern", "<monitor-id/all>",
+				cmd_adv_monitor_print_monitor,
+				"Get advertisement monitor" },
+	{ "remove-pattern", "<monitor-id/all>",
+				cmd_adv_monitor_remove_monitor,
+				"Remove advertisement monitor" },
+	{ "get-supported-info", NULL,
+				cmd_adv_monitor_get_supported_info,
+				"Get advertisement manager supported "
+				"features and supported monitor types" },
+	{ "print-usage", "<add-or-pattern/add-or-pattern-rssi>",
+				cmd_adv_monitor_print_usage,
+				"Print the command usage"},
+	{ } },
+};
+
 static const struct bt_shell_menu scan_menu = {
 	.name = "scan",
 	.desc = "Scan Options Submenu",
@@ -2932,6 +3040,7 @@ int main(int argc, char *argv[])
 	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_add_submenu(&advertise_menu);
+	bt_shell_add_submenu(&advertise_monitor_menu);
 	bt_shell_add_submenu(&scan_menu);
 	bt_shell_add_submenu(&gatt_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
-- 
2.28.0.618.gf4bc123cb7-goog

