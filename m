Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B906C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 07:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD392076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 07:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pj27Jc1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIPHRN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 03:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIPHRL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 03:17:11 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33175C061788
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 00:17:10 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c19so5393391qkk.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jI/5VReMm0tTNSWTPn8NUEGnZNxUSUFoa3fJlfjTJJo=;
        b=pj27Jc1YVh47n8UPHdgaT/laL75+FvslrGhcq1J5HJnlAptYsh+OCt6nvfbezucZHO
         rkkb3c6sArikpmgJCH9UX+Aog6HhG7QFwEVc/od0yZ+i3RSjiQvy0KqOhVvFDP/NxGof
         P8iSKdMwD1KLc/kGOe60HabBTl3PIOCnvAnQamWbNz6I9HdRIPn9JULaQWsvhEgQL1eD
         1Ih0yGvfawU6qQer1bzVRQKp7cQyemZIa776Lb1U9ZLz2Fj8cBHQkL82B3N+6qy4Xu0P
         zPCprlWgQx2otjm2XG1zDwuZbS3GZxyaIsCkC+9QXE4O2faFXyfq6wEyIQQzkMAIlrjm
         TSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jI/5VReMm0tTNSWTPn8NUEGnZNxUSUFoa3fJlfjTJJo=;
        b=l/0KPm+kWUMJGGa2922jflGlNhjYMcSKmx+qrpzMSO6pNAQzZkGD4vbv7+2hVehmmC
         pxgsCSPKmpXIe/TegpX9uPeVN+cxFhESmNdCmbDbW14L0+zFa/uf7IfXI0PpvHJNzhv+
         wj0lsa+Jn2TXg5EUb2st0AaTC3XHZKPROgVOt/5VvJxMkZ3Y7TUyxjWQaCH6pJqNIYWO
         KyuWEbcky9Rv7Tnd49Tf5KShV0CY9U0PcHHs/ddJF9tRHVLhUzcrxa+G4q2lts0V/j7d
         CkoNoTSDc/t1feJhS+wRBPjnCZjD2e5/lt11cgaZ0h1SMnw7h/9PcCLM0HVgeTGFjMlP
         c2Yw==
X-Gm-Message-State: AOAM5313qV7Th5PprOJvzhbnBme5xQcY5rIX5OAaJ8uMXYJx8NDQyEF8
        rgnOxgEDiy2ne/Wam2mZ+1sBCELX4BKADcnkcv4e8vLRhoZHLGQezNByzvykp1JzPbGZ3mfY45C
        78Yuv91/6cS1LjaDvelPZMLC7AQPCka2zNfM7arwoACJ3ZDDyaLbQCoWhZJWh6WJ6UuUlJLHNlR
        ZLNmn09Fx3asM=
X-Google-Smtp-Source: ABdhPJxtKfd+ASL9Pkb1wuiVvivO2YSVOAYdi9KRT9dWnDfSn89fGSGfrPHK0JnU+wUgVa2D2ym2OY+x5axGSHPHUQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:4f30:: with SMTP id
 fc16mr21833088qvb.6.1600240629267; Wed, 16 Sep 2020 00:17:09 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:16:51 +0800
In-Reply-To: <20200916151617.BlueZ.v5.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
Message-Id: <20200916151617.BlueZ.v5.3.I680cda25cec9c45ca2b2c5ac3a8e437772ea76d9@changeid>
Mime-Version: 1.0
References: <20200916151617.BlueZ.v5.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v5 3/4] client: Expose ADV monitor objects
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

This adds logic to expose user-defined advertisement monitor to dbus and
also implements methods for exposed objects.

Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v4)

Changes in v4:
- Remove PRE-UPSTREAM in commit title
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

 client/adv_monitor.c | 185 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 3 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index d4914b7b1..22bb3c670 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -53,6 +53,7 @@ struct pattern {
 
 struct adv_monitor {
 	uint8_t idx;
+	char *path;
 	char *type;
 	struct rssi_setting *rssi;
 	GSList *patterns;
@@ -68,6 +69,163 @@ static struct adv_monitor_manager {
 static uint8_t adv_mon_idx;
 static GSList *adv_mons;
 
+static void remove_adv_monitor(void *data, void *user_data);
+
+static DBusMessage *release_adv_monitor(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+
+	bt_shell_printf("Advertisement monitor %d released\n",
+							adv_monitor->idx);
+	remove_adv_monitor(adv_monitor, conn);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *activate_adv_monitor(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+
+	bt_shell_printf("Advertisement monitor %d activated\n",
+							adv_monitor->idx);
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *device_found_adv_monitor(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+	const char *device;
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
+							DBUS_TYPE_INVALID);
+	bt_shell_printf("Advertisement monitor %d found device %s\n",
+						adv_monitor->idx, device);
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *device_lost_adv_monitor(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+	const char *device;
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
+							DBUS_TYPE_INVALID);
+	bt_shell_printf("Advertisement monitor %d lost device %s\n",
+						adv_monitor->idx, device);
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable adv_monitor_methods[] = {
+	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, release_adv_monitor) },
+	{ GDBUS_ASYNC_METHOD("Activate", NULL, NULL, activate_adv_monitor) },
+	{ GDBUS_ASYNC_METHOD("DeviceFound", GDBUS_ARGS({ "device", "o" }),
+			NULL, device_found_adv_monitor) },
+	{ GDBUS_ASYNC_METHOD("DeviceLost", GDBUS_ARGS({ "device", "o" }),
+			NULL, device_lost_adv_monitor) },
+	{ }
+};
+
+
+static gboolean get_type(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&adv_monitor->type);
+	return TRUE;
+}
+
+static gboolean get_rssi(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+	struct rssi_setting *rssi = adv_monitor->rssi;
+	DBusMessageIter data_iter;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_STRUCT,
+							NULL, &data_iter);
+	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_INT16,
+							&rssi->high_threshold);
+	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_UINT16,
+							&rssi->high_timer);
+	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_INT16,
+							&rssi->low_threshold);
+	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_UINT16,
+							&rssi->low_timer);
+	dbus_message_iter_close_container(iter, &data_iter);
+	return TRUE;
+}
+
+static gboolean rssi_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct adv_monitor *adv_monitor = data;
+
+	return adv_monitor->rssi != NULL;
+}
+
+static void append_pattern_content_to_dbus(DBusMessageIter *iter,
+							struct pattern *pattern)
+{
+	DBusMessageIter data_iter;
+	int idx;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &data_iter);
+	for (idx = 0; idx < pattern->content_len; idx++)
+		dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_BYTE,
+							&pattern->content[idx]);
+	dbus_message_iter_close_container(iter, &data_iter);
+}
+
+static void append_pattern_to_dbus(void *data, void *user_data)
+{
+	struct pattern *pattern = data;
+	DBusMessageIter *array_iter = user_data;
+	DBusMessageIter data_iter;
+
+	dbus_message_iter_open_container(array_iter, DBUS_TYPE_STRUCT,
+							NULL, &data_iter);
+	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_BYTE,
+							&pattern->start_pos);
+	dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_BYTE,
+							&pattern->ad_data_type);
+	append_pattern_content_to_dbus(&data_iter, pattern);
+	dbus_message_iter_close_container(array_iter, &data_iter);
+}
+
+static gboolean get_patterns(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	struct adv_monitor *adv_monitor = user_data;
+	DBusMessageIter array_iter;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "(yyay)",
+								&array_iter);
+	g_slist_foreach(adv_monitor->patterns, append_pattern_to_dbus,
+								&array_iter);
+	dbus_message_iter_close_container(iter, &array_iter);
+	return TRUE;
+}
+
+static gboolean pattern_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct adv_monitor *adv_monitor = data;
+
+	return adv_monitor->patterns != NULL;
+}
+
+static const GDBusPropertyTable adv_monitor_props[] = {
+	{ "Type", "s", get_type },
+	{ "RSSIThresholdsAndTimers", "(nqnq)", get_rssi, NULL, rssi_exists },
+	{ "Patterns", "a(yyay)", get_patterns, NULL, pattern_exists },
+	{ }
+};
+
 static void set_supported_list(GSList **list, DBusMessageIter *iter)
 {
 	char *str;
@@ -200,6 +358,7 @@ static void free_adv_monitor(void *user_data)
 {
 	struct adv_monitor *adv_monitor = user_data;
 
+	g_free(adv_monitor->path);
 	g_free(adv_monitor->type);
 	g_free(adv_monitor->rssi);
 	g_slist_free_full(adv_monitor->patterns, free_pattern);
@@ -324,6 +483,16 @@ static GSList *parse_patterns(char *pattern_list[], int num)
 	return patterns;
 }
 
+static void remove_adv_monitor(void *data, void *user_data)
+{
+	struct adv_monitor *adv_monitor = data;
+	DBusConnection *conn = user_data;
+
+	adv_mons = g_slist_remove(adv_mons, adv_monitor);
+	g_dbus_unregister_interface(conn, adv_monitor->path,
+							ADV_MONITOR_INTERFACE);
+}
+
 static gint cmp_adv_monitor_with_idx(gconstpointer a, gconstpointer b)
 {
 	const struct adv_monitor *adv_monitor = a;
@@ -359,6 +528,7 @@ static void print_adv_monitor(struct adv_monitor *adv_monitor)
 	GSList *l;
 
 	bt_shell_printf("Advertisement Monitor %d\n", adv_monitor->idx);
+	bt_shell_printf("\tpath: %s\n", adv_monitor->path);
 	bt_shell_printf("\ttype: %s\n", adv_monitor->type);
 	if (adv_monitor->rssi) {
 		bt_shell_printf("\trssi:\n");
@@ -433,6 +603,16 @@ void adv_monitor_add_monitor(DBusConnection *conn, char *type,
 	adv_monitor->type = g_strdup(type);
 	adv_monitor->rssi = rssi;
 	adv_monitor->patterns = patterns;
+	adv_monitor->path = g_strdup_printf("%s/%hhu", ADV_MONITOR_APP_PATH,
+								adv_mon_idx);
+	if (g_dbus_register_interface(conn, adv_monitor->path,
+					ADV_MONITOR_INTERFACE,
+					adv_monitor_methods, NULL,
+					adv_monitor_props, adv_monitor,
+					free_adv_monitor) == FALSE) {
+		bt_shell_printf("Failed to register advertisement monitor\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
 
 	adv_mons = g_slist_append(adv_mons, adv_monitor);
 	bt_shell_printf("Advertisement Monitor %d added\n", adv_monitor->idx);
@@ -467,7 +647,7 @@ void adv_monitor_remove_monitor(DBusConnection *conn, int monitor_idx)
 	struct adv_monitor *adv_monitor;
 
 	if (monitor_idx < 0) {
-		g_slist_free_full(g_steal_pointer(&adv_mons), free_adv_monitor);
+		g_slist_foreach(adv_mons, remove_adv_monitor, conn);
 		return;
 	}
 
@@ -478,8 +658,7 @@ void adv_monitor_remove_monitor(DBusConnection *conn, int monitor_idx)
 		return;
 	}
 
-	adv_mons = g_slist_remove(adv_mons, adv_monitor);
-	free_adv_monitor(adv_monitor);
+	remove_adv_monitor(adv_monitor, conn);
 	bt_shell_printf("Monitor %d deleted\n", monitor_idx);
 }
 
-- 
2.28.0.618.gf4bc123cb7-goog

