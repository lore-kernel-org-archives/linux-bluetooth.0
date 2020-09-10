Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AF4C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 10:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF942145D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 10:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hf/8jNuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgIJKep (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbgIJKeQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 06:34:16 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81252C061786
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 03:34:15 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id s33so3831003qth.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 03:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yqjMGeyvRPcaWoCHc/xHlQCmAUnozMo/7KYsVvNF8Rk=;
        b=hf/8jNuNyUdSLaIkwfuMpcGCCBuv4mR2r28rhCpUCaOtzaGoWpejmC5I+qR16qfuOB
         kdXZYruJvFdDZMotXMb//7mq1kE8p8MjFxl4Kr7ih5ArJRXnREFHh/oh+3o5XDDn7z/4
         jlsy+z9ms26eFlZmNdys/k36dAfJ7TnDwIWP8xhSMDXli9NObsZZmRXZ8VLe6kTuGSIk
         H+D8/Gjb8FyAFei2EC/tE9PQpHjg+6OWm5BmLQoSGh7YfyHtcHK6KCQPZs4DqkwDWbnZ
         bDF3urOmu6vU9976ZZTlYZo8T4vBv+k2tK85yVXedQExMTs0XBX/82QxObEOkBfvrqcj
         c//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yqjMGeyvRPcaWoCHc/xHlQCmAUnozMo/7KYsVvNF8Rk=;
        b=W4A4JKPVcOYgiRlsLKt56dCjWrBk65WM2a2L3iyhLmWI2/Jjg7a3vmS3tr+S7WMV+d
         b7JftzXfAu0JVcJuQA46ITh4IKwOqbUEfDniWpKxKAX+reEuRBYEgLo+rhBQW+RaUR+D
         S64vj7qvf6EEL6JJ7WmBYao7gEzIKBly04kO41AbBvTMecyY9Mc2Yl19ytgohrrl0SQ/
         FWbKx1cXqV1aoA54cKeX4jQfRQFp+YBCp8H4eXimWzeCNaraSaxR3odGRrfe5D20Dqn0
         e62PnPKG2Q8iqsDimc8vWH17HmHhLI0/N+fCoD85ucjyX4jNXYcik2qmf7iBjc30rCZX
         vqHw==
X-Gm-Message-State: AOAM532XmWzd9Z+Swr18H+uFobdPgc3vgu/NjbL2UOqeR4XQ9QAosUG5
        5+0KerZi7K+f1l7C4A/5LTSnOo0x3+71aMxCF8EQk90KZKs4sLMQopGUmsuOIgse3yBfmBTbYZ+
        MkxLMb9SLvk7jT0ljvsu70w6y5FK5UhrtmjEMXPMhPDJ++by4Gf/OH8cDGnflmjlhwRcznBwRli
        lNgjxBeD4kDic=
X-Google-Smtp-Source: ABdhPJxCdKWq9ZotVPwQg72/OSYpzXvq7fTImFLK2DSXv0+f8qjy0qnWvimCTIcAem1IPd1gdMKNEJIfTS0ILYrsuw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:42b3:: with SMTP id
 e19mr8349992qvr.6.1599734054647; Thu, 10 Sep 2020 03:34:14 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:34:01 +0800
In-Reply-To: <20200910183329.BlueZ.v2.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
Message-Id: <20200910183329.BlueZ.v2.3.I680cda25cec9c45ca2b2c5ac3a8e437772ea76d9@changeid>
Mime-Version: 1.0
References: <20200910183329.BlueZ.v2.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [BlueZ PATCH v2 3/4] PRE-UPSTREAM: client: Expose ADV monitor objects
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, mcchou@chromium.org,
        mmandlik@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds logic to expose user-defined advertisement monitor to dbus and
also implements methods for exposed objects.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

 client/advertisement_monitor.c | 185 ++++++++++++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 3 deletions(-)

diff --git a/client/advertisement_monitor.c b/client/advertisement_monitor.c
index 0b2f7f407..b83ec823b 100644
--- a/client/advertisement_monitor.c
+++ b/client/advertisement_monitor.c
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
2.28.0.526.ge36021eeef-goog

