Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E93CC43461
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 03:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023D1208DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 03:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EcF2brSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgINDWy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Sep 2020 23:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgINDWw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Sep 2020 23:22:52 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4D8C061788
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2020 20:22:52 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b18so11063761qto.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2020 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YW+W6VPmCcUxZ0aKiaV5YI57Jl28Wn5E2tIC1a3e4wo=;
        b=EcF2brSmvrhgJqYWBuG++Nydgv5/jlTLD8CaRojWP1RYRkS69g9FxNYw1bUs4WtmhM
         zQ/QVQofVjzIxKmA2JU5nskcIFf4DgmjbLJYV2tCmYfXZtHCEbxrRHx/y2gKp2NkRbCk
         TK8cHpQOY4za9D+4ioF0ZTVBq80t8JzF+djygvGsPH6oYNTSioEq1gF0pU9udJaLVXaj
         54GrpLemd6/Rc+zNpwxlphtt8ZWyEZZBY17jealGoQoHElx81H4d3f+S+JNtnDQubtdu
         e8X1XUbpX3J9beFtbaRZFYrRjSP/OUzEsm/QCaaUTqYkLV84lVFgX9GsY13+guB+MC1P
         pTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YW+W6VPmCcUxZ0aKiaV5YI57Jl28Wn5E2tIC1a3e4wo=;
        b=IBxPjn7pzhDmKBUQ6r/miKePXlcSWVUOg5IHUWgC/legHr8ehcDxeihHPRoYerV7zo
         NPCs9WrwD3TPLluGdkkPdbIKnZ2jrhVGZkvkE6ynUpzIR+ppc8chp0KopBr2xe+fMFIL
         0p98A2gVR37Cwk8rDSqW2b9RrYXqnEJ4Qcg0dg37sNAIxYBJ/Kt1GWNSRW/ArF7rUI5u
         ehK4hZ/U2DPRzWFCp3Kk01Xjk3Iwjdnz+Bc+scHRr8oqr1Vc6EsRmh3FcRqRilDkt9vt
         YGylFk0P1TWU0Ihx19sXUKO/2Ti4tPUfwvrL215Ch5YcRqDoEghYsEj2RReGQxP9UQ4j
         ziHQ==
X-Gm-Message-State: AOAM530gA6WQW+K63RXZo/z2Qu+BQ+NUH1Hz2GRmHC9ASN3X8YWtaff3
        ChHldPHbrbo9v8/BpmhwIX/U9WHceZKkqEnV+ghiGmbKrchxIYkkKvG1hmLsg/kPe2MSjdGN2DI
        hol6S2uSL3NQl9rnvR92mPRbniNjxDrPgDT3n2u7lwCQOzIhLfcZRF84TLl0vstUaFGdpyMlo8P
        p98AU7Bq2Urns=
X-Google-Smtp-Source: ABdhPJxI9yOBiZfYsQy2CFlnXhGhirO09U6556yXKIyc1iodIPY5fap/fZYq0cb1y1M8gMAfVs3FsScAmqWtEacWFA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:8645:: with SMTP id
 p63mr11527589qva.21.1600053771128; Sun, 13 Sep 2020 20:22:51 -0700 (PDT)
Date:   Mon, 14 Sep 2020 11:22:32 +0800
In-Reply-To: <20200914112137.BlueZ.v4.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
Message-Id: <20200914112137.BlueZ.v4.3.I680cda25cec9c45ca2b2c5ac3a8e437772ea76d9@changeid>
Mime-Version: 1.0
References: <20200914112137.BlueZ.v4.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v4 3/4] client: Expose ADV monitor objects
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, luiz.von.dentz@intel.com,
        mmandlik@chromium.org, alainm@chromium.org,
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

Changes in v4:
- Remove PRE-UPSTREAM in commit title
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

 client/adv_monitor.c | 185 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 3 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index 49c0dd01d..bb833ffea 100644
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
@@ -201,6 +359,7 @@ static void free_adv_monitor(void *user_data)
 {
 	struct adv_monitor *adv_monitor = user_data;
 
+	g_free(adv_monitor->path);
 	g_free(adv_monitor->type);
 	g_free(adv_monitor->rssi);
 	g_slist_free_full(adv_monitor->patterns, free_pattern);
@@ -325,6 +484,16 @@ static GSList *parse_patterns(char *pattern_list[], int num)
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
@@ -360,6 +529,7 @@ static void print_adv_monitor(struct adv_monitor *adv_monitor)
 	GSList *l;
 
 	bt_shell_printf("Advertisement Monitor %d\n", adv_monitor->idx);
+	bt_shell_printf("\tpath: %s\n", adv_monitor->path);
 	bt_shell_printf("\ttype: %s\n", adv_monitor->type);
 	if (adv_monitor->rssi) {
 		bt_shell_printf("\trssi:\n");
@@ -434,6 +604,16 @@ void adv_monitor_add_monitor(DBusConnection *conn, char *type,
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
@@ -468,7 +648,7 @@ void adv_monitor_remove_monitor(DBusConnection *conn, int monitor_idx)
 	struct adv_monitor *adv_monitor;
 
 	if (monitor_idx < 0) {
-		g_slist_free_full(g_steal_pointer(&adv_mons), free_adv_monitor);
+		g_slist_foreach(adv_mons, remove_adv_monitor, conn);
 		return;
 	}
 
@@ -479,8 +659,7 @@ void adv_monitor_remove_monitor(DBusConnection *conn, int monitor_idx)
 		return;
 	}
 
-	adv_mons = g_slist_remove(adv_mons, adv_monitor);
-	free_adv_monitor(adv_monitor);
+	remove_adv_monitor(adv_monitor, conn);
 	bt_shell_printf("Monitor %d deleted\n", monitor_idx);
 }
 
-- 
2.28.0.618.gf4bc123cb7-goog

