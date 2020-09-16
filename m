Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DF0C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 07:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778022076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 07:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="itClPvXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIPHRM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPHRI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 03:17:08 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D55C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 00:17:07 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id u6so5360292qte.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 00:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/sZaUwkMRhy5nGDqEj/npb5gumg8a9ZMAwv0bXjQQfY=;
        b=itClPvXihlayARe++RPVG8CSXs69gWYE2L3+mgHIq1X7FQgMCfvACy2YL02SCbFMpe
         VCp2ZFLHujKhbT0ddlq0PyaJZXhVT4oDfd/pqiKM9/Ic40YAk/jDcw/zDQ7dBBYxtUvU
         oqDKdxLr6QjN1ZVO/JPsT6THzU9SwAVwY5TSU3mE0IT1odVLqm9kG/migWkfolzz94eq
         mYOFZJTf9w1zpMHV3T/NX10uuUllbaV4SJCYmd6bUCLmcA73Z1SnpUeh6VjQffB4Vhaq
         dbaocYkcr7kr2s9IL7/5hMMLCwBOVhWrQR86tsNdz4t8r9gwcurwA5qoyQurHM30qaBB
         6BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/sZaUwkMRhy5nGDqEj/npb5gumg8a9ZMAwv0bXjQQfY=;
        b=s+hP33AoOsAFloIHaOJRR4PyLfRMAlrfwohywqZGjz9NnZgQiQOnC1lV9+CYPZpdHm
         FFykgVQYXXsW28AXQ0rJkR2C00WUOyN8IEAdosNm8w1Rsdo7J4gkETLfGMDFz1mchpMK
         Mf6CRKv6xE0tycWUt8BHbjZqaeJzuj+WeyTi9tWbMQA9O4MA0K+u75+fsM1XivSMAADL
         T4sIG5eA0iPXI8hclpUKvIHI1fdL4Oiegd5dr8tYUrXDEDI+WNxHsH894Na3mp4+2CvZ
         b2WjPk/FXG2z/pioa89o2XNHxGzRggkImwUIwiYgarTLCX30c8ZLeB+tiUAwtbDYQ4g0
         pwxg==
X-Gm-Message-State: AOAM530FH82GE2Cw0kkq5+6OhiBCPck4aCbS0vklK9celF1FFOzF5mIk
        bYYDQL3JNC1U4pnr/dNiT50GOd3w3clonblT+kPYErkpBgesD+4lFXu8MKxU5rcfXPH7FpoDcht
        zb/eaHzqnsJEXVsCJ29eEoO9KYesRMrFv34yMxycqyRgJsBuqYEAadmF4tF16SaC9RzeGprEaec
        ig7e8GOZOIi8k=
X-Google-Smtp-Source: ABdhPJxrkoph8jzWjPDbb2/sxrKWgQVECfA7gaDehYfzSyRzx5/7w/AMJaG5xkAcTHmJ5HHogEQCq0GfneaOwKwFMA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:5387:: with SMTP id
 i7mr5454479qvv.43.1600240625860; Wed, 16 Sep 2020 00:17:05 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:16:50 +0800
In-Reply-To: <20200916151617.BlueZ.v5.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
Message-Id: <20200916151617.BlueZ.v5.2.Iec6b15e23f4228b80f9b364eb76515d146d592d5@changeid>
Mime-Version: 1.0
References: <20200916151617.BlueZ.v5.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v5 2/4] client: Implement more interfaces of ADV monitor
 in bluetoothctl
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, mmandlik@chromium.org,
        mcchou@chromium.org, alainm@chromium.org,
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

Changes in v5:
- Move a change regarding checking the status of app registered to patch 1/4

Changes in v4:
- Remove PRE-UPSTREAM in commit title

Changes in v2:
- Update the add-pattern usage

 client/adv_monitor.c | 341 +++++++++++++++++++++++++++++++++++++++++++
 client/adv_monitor.h |  10 ++
 client/main.c        | 109 ++++++++++++++
 3 files changed, 460 insertions(+)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index dda0eaf90..d4914b7b1 100644
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
@@ -163,3 +188,319 @@ void adv_monitor_unregister_app(DBusConnection *conn)
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

