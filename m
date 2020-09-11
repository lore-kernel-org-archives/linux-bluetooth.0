Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C859C433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 12:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5DFF221ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 12:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="oIo5XJv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgIKMK6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIKMKT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 08:10:19 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98610C0613ED
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 05:09:46 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id o14so3870823qve.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qIId3xI6bPeFIzMnGT1Pmld70e1Pp7+xu29Zf+ONNsE=;
        b=oIo5XJv8pbo6JEiRClunbNoPo0YnjMnNG207G3Xf0vsX8AABDlxOiRUlewAdmG9zHI
         Osyq0KnAiyJ4qlD7HEeiz3PcD+VgJych6Ds7us3Or1233nKoBn34AKtJbz1xgYXEiz2d
         3CrTT7ELsOX9g/Sus6DcRci1nQ9kRpcFA5hNBCUOGf5P+w4cPzgUOs+8UO6kwyqv7uLN
         +S26++P8LSwnALBnqL1cbvSMTy3CXCZr22gjFDOXASvC+/Sp1ISt4AK4HkIKVI2lnUkT
         L8WX3PIlsuyAD6093qM/cBmmDMKVjK1iQPbPymbLVUwmu6EXowvxGFqtBwgimQZsgHpL
         CJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qIId3xI6bPeFIzMnGT1Pmld70e1Pp7+xu29Zf+ONNsE=;
        b=YCWo+iyLp9pKHsE6kz8ltrSKzI8HM4RgZJWhrFVav2Ih7k7jOINuYv2yFYk7A8FkbG
         6ttn4NOLOIwJdV45OKXrJHqJKAfyIjCDaZP52AonXsMSc59Dsg0CCiaiC9rNg0eZOVur
         a6Lo7a0zHIR7cDGss/dn7sNv4ddIsvGitH9U8gFenRGFDZZByvLAlFj+E2K41pamwXfF
         qfVKXK6EfvlwHujM3p9m1W+qweouCNf5WTBSYbJ0mj5MZzwQgTWx0ZfQzu2hxj9HGhn4
         bOM2jVqq4k9UHvAjFwa3gxdLIEAGokv2HeoXc1FQSUTdWrlfrMprEKvRNiM6H7U8BBI2
         EFmA==
X-Gm-Message-State: AOAM530JjkUbCE1v0/l4RWY52MWsBboHB2iE9qnKfNLki/a52LLkPU42
        Y9/tVLr6+jakYMfSaBHTdOprVVxEPC2jSal5yi0SyY36mxhh4kaaEQRt5iG2NsLxa4mklwabV4M
        T4cmdzqGHbmzCVPd3TJjuv4UHh9kjQit9we5mQQFTp2YsGJj+PXa1SZz9WMumz/tilE0/TsvVZ+
        2VW/6WDbZ6L0M=
X-Google-Smtp-Source: ABdhPJzmKUMKxEWNeUHzuwkis0sb+EWR/ibfD/Kd70xVhwuSDYkbElUUGqDiq6ZgMr2Zk3d2aoC97iuTHelPmZfgEA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:f44e:: with SMTP id
 h14mr1587919qvm.4.1599826185384; Fri, 11 Sep 2020 05:09:45 -0700 (PDT)
Date:   Fri, 11 Sep 2020 20:09:28 +0800
In-Reply-To: <20200911200839.BlueZ.v3.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
Message-Id: <20200911200839.BlueZ.v3.3.I680cda25cec9c45ca2b2c5ac3a8e437772ea76d9@changeid>
Mime-Version: 1.0
References: <20200911200839.BlueZ.v3.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v3 3/4] PRE-UPSTREAM: client: Expose ADV monitor objects
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

This adds logic to expose user-defined advertisement monitor to dbus and
also implements methods for exposed objects.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

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

