Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE77C433E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 04:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7773A20709
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 04:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JQZI77mW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgHSEMa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 00:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgHSEM2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 00:12:28 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2FEC061343
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 21:12:28 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id t11so14262507pfq.21
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 21:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KDMAZBNBq+Q66R2m1YuL2nFJAbD1yqbyI9MMCt4su+g=;
        b=JQZI77mWDWM37eOZ3zFvzpCFX+2Iw2mWJF5wHXiHpDcwyiTiXrVGo014SZ+3rl3LKv
         qm/PAxkbFu2VcqPsVBbTqHkdSqB80WOQ6I2r8yqW/Cqc+L/a0yk0nBk1b3d3aE+zsWs1
         1ObBl8AVf2amQwHwohT2X72+70P3sugB7lafxtFdh+XUyavyNaRE9K/+Oyl34bjmy5zw
         2yq7eUx1miAahD791zfR/bJHwtUiDwH2b0jkHTGV2LayT9NjenXDBWXqn177kmytk5Cm
         XPxoueAT98iNcPwRaDjN9V0nfQ7eCiEwkn0K69lOtVvpojBVDTtWhdMnuo954W5AllSb
         h9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KDMAZBNBq+Q66R2m1YuL2nFJAbD1yqbyI9MMCt4su+g=;
        b=haK/6GHV4MREd/8+rj9goOe9+WsE+3GG5mgultR2JhaxjYzhEu78zIkG7sexO3xxQx
         jO+6FOZY7E7ocggU8uRz6zjdYSWZUfkZsn15aV35/JQAHYoWSfWsLKzuOhduoTapFOiG
         L77Drep/UkX8QDaSvzelayoEBNGwVgQmqi6IVeKWA2nToHQW9KoeFlv9rQjJUSQTF0TK
         tU9tkLF4RuWnqXaidnPdtQBoRTkH+m6Qy1A1l8jyLVWFYyoiPvBCaNuY9bRu0A336C6J
         O1Nzfhvo3a7ryDA2ToZPhndVlgp/A49gL2/V2CyJc6oHxctgQ7eNl6lADt5YLWTpr36b
         fTJQ==
X-Gm-Message-State: AOAM531KrjjNl7aXE9uOnqxDLyKIgQkru9A8+T/KLSsMKub5j454YVPx
        ILOpRjVUMSvpv1br3tZ28Ouf0dCxwY/Mh6puHHBMGvfcodD7qU4o+wcvFObLbgU4uKJjG9OAQut
        90HSkdXPDY7N9diSYvBNA4cijn0mcO+aXX8MrU6IQTBM0zRb20RLeoH89TvDJxqxqSqG47b0lo8
        Mjo67+Zor43hM=
X-Google-Smtp-Source: ABdhPJymvd3pwUrerSqA+hpGEjWZTpKw/cQxbIU/abX2D3oPGRelPiv7w+dQTSsjOIoafJAhHQgAyd7SADzkXnvzBw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:90a:bd82:: with SMTP id
 z2mr477740pjr.1.1597810347418; Tue, 18 Aug 2020 21:12:27 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:11:04 +0800
In-Reply-To: <20200819121048.BlueZ.v1.1.I3a57ea1eb3e3f5b87abc44ea478fc83817627ffc@changeid>
Message-Id: <20200819121048.BlueZ.v1.3.I3037dbcd77b86f96f7f55350ad7ce5224208c20d@changeid>
Mime-Version: 1.0
References: <20200819121048.BlueZ.v1.1.I3a57ea1eb3e3f5b87abc44ea478fc83817627ffc@changeid>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [BlueZ PATCH v1 3/4] client: Expose ADV monitor objects
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, mcchou@chromium.org, mmandlik@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds logic to expose user-defined advertisement monitor to dbus and
also implements methods for exposed objects.

Signed-off-by: Howard Chung <howardchung@google.com>
---

 client/advertisement_monitor.c | 187 ++++++++++++++++++++++++++++++++-
 1 file changed, 183 insertions(+), 4 deletions(-)

diff --git a/client/advertisement_monitor.c b/client/advertisement_monitor.c
index ec8f23711..7ec5243e7 100644
--- a/client/advertisement_monitor.c
+++ b/client/advertisement_monitor.c
@@ -53,12 +53,13 @@ struct pattern {
 
 struct adv_monitor {
 	uint8_t idx;
+	char *path;
 	char *type;
 	struct rssi_setting *rssi;
 	GSList *patterns;
 };
 
-struct adv_monitor_manager {
+static struct adv_monitor_manager {
 	GSList *supported_types;
 	GSList *supported_features;
 	GDBusProxy *proxy;
@@ -68,6 +69,163 @@ struct adv_monitor_manager {
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
@@ -300,6 +459,16 @@ static GSList *parse_patterns(char *pattern_list[], int num)
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
@@ -335,6 +504,7 @@ static void print_adv_monitor(struct adv_monitor *adv_monitor)
 	GSList *l;
 
 	bt_shell_printf("Advertisement Monitor %d\n", adv_monitor->idx);
+	bt_shell_printf("\tpath: %s\n", adv_monitor->path);
 	bt_shell_printf("\ttype: %s\n", adv_monitor->type);
 	if (adv_monitor->rssi) {
 		bt_shell_printf("\trssi:\n");
@@ -410,6 +580,16 @@ void adv_monitor_add_monitor(DBusConnection *conn, int argc, char *argv[])
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
@@ -444,7 +624,7 @@ void adv_monitor_remove_monitor(DBusConnection *conn, int monitor_idx)
 	struct adv_monitor *adv_monitor;
 
 	if (monitor_idx < 0) {
-		g_slist_free_full(g_steal_pointer(&adv_mons), free_adv_monitor);
+		g_slist_foreach(adv_mons, remove_adv_monitor, conn);
 		return;
 	}
 
@@ -455,8 +635,7 @@ void adv_monitor_remove_monitor(DBusConnection *conn, int monitor_idx)
 		return;
 	}
 
-	adv_mons = g_slist_remove(adv_mons, adv_monitor);
-	free_adv_monitor(adv_monitor);
+	remove_adv_monitor(adv_monitor, conn);
 	bt_shell_printf("Monitor %d deleted\n", monitor_idx);
 }
 
-- 
2.28.0.220.ged08abb693-goog

