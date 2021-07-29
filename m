Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916DBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AD560F59
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhG2DOa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhG2DOY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:14:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE44C061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:14:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v71-20020a252f4a0000b029055b51419c7dso5313476ybv.23
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vUFqiGTTzobujkg+ZjOO5W+WdGYy2L9ThiyHBO9sSN4=;
        b=NKb/dPRKDzuqEz0xScMAbWVYMZkyXaX5vXrcShOuGi3oRwc8zWOGQp+H3v62cyUDSf
         AX8LUoWQsURN+zRczz6/mh9MIqq/MTbu3yMnnyzNfP5VysIU33ZQpOlmrOZ8ioB7sPnQ
         Lynb7qSbe7OLYryvB/P5uCqSKzcMZ8mnXD9upJ+sPeBe+Dju/x07osOtKPfvJikmkaA0
         CegTnf1J0mclW8f7ZUl0XkPTZQv1Fa+2sUVuzf5yUMXE7xfeuvyF+bnPz6NDv8bG+kqk
         rqUoRUZIzrN+TvG90uoQ3ssxlF7K26pKX3LrFskShZv4/hZlNuBiTL20WOWx2Y8HyX/4
         PYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vUFqiGTTzobujkg+ZjOO5W+WdGYy2L9ThiyHBO9sSN4=;
        b=Ajzkal777hJPh1X/F6fGoOVtC2QUiLQhJSj0sfzBa3oE3J+B+ZVtpIb1+jcphFL/uG
         d05lR1sKy1N+Iy93CsESbYHXt3Y0wtJr4Z6/gs7Fg3FAenKLDWX6G5e9dUozxntliZTM
         gprQcbsPUhkq17XAlw5haEe+pL1jPjZ9RDIfLjc1xXm262A8cfiGvTxZ4QUryJXfwtZH
         pWzjy6LlWpBkyCcqMjDLFAVRYv0TmrGRA8WgM6QESqVNlHQJjnQcAXTNE3oEuPeTIK01
         O90FG6c2umtxVt8H0DW/47Z0whl0s867z22afAFwzL2Yr6rkRHJGQbra3j/LrKFsh2cc
         eoEg==
X-Gm-Message-State: AOAM53343q/ga6OKkE5Pb+7YoVrmmcVhLKAfFW07cC7UsY/myNQ86d1l
        kVmZOUt1SjrGgkxY8PdE7HD9mc0gXsWOWIrhlMEj+5BxeaI40xdu4zzjKR2yYPp35XEK5b586Z2
        phxIItyCn1jy1idUl59pYwbb3QfkPV5di2gsDBTwlIpYvAp+ZbQmcsD9hT5tAy3JS/D7tpN3gfc
        fMhldUsJ3o+ug=
X-Google-Smtp-Source: ABdhPJwDRkYeLmGytqUGTJ8+O0yg0l2leVcxqI0BmccpzJDJ4tP1lYituR53LX+QFUpo6eUfd1o4SlzTH9Pv+v/siw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a05:6902:1106:: with SMTP id
 o6mr3614110ybu.263.1627528460323; Wed, 28 Jul 2021 20:14:20 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:12:57 +0800
In-Reply-To: <20210729031258.3391756-1-howardchung@google.com>
Message-Id: <20210729110956.Bluez.v4.11.I570c860f59c8ed66ddb31aa54584ee08080aa10c@changeid>
Mime-Version: 1.0
References: <20210729031258.3391756-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v4 11/13] plugins/admin: add AffectedByPolicy property
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds property to indicate if a device has any service that is being
blocked by admin policy.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
The following test steps were performed:
1. Set ServiceAllowList to []
2. Verify AffectedByPolicy of K830 is False
3. Set ServiceAllowList to
   ["1800"]
4. Verify AffectedByPolicy of K830 is False
5. Set ServiceAllowList to ["1800","1801","180A","180F","1812"]
6. Verify AffectedByPolicy of K830 is True

(no changes since v1)

 plugins/admin.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 37dae77ac448..2ad60f2fde2a 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -46,6 +46,7 @@ static struct btd_admin_policy {
 struct device_data {
 	struct btd_device *device;
 	char *path;
+	bool affected;
 };
 
 static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
@@ -139,6 +140,27 @@ static bool service_allowlist_set(struct btd_admin_policy *admin_policy,
 	return true;
 }
 
+static void update_device_affected(void *data, void *user_data)
+{
+	struct device_data *dev_data = data;
+	bool affected;
+
+	if (!dev_data) {
+		error("Unexpected NULL device_data when updating device");
+		return;
+	}
+
+	affected = !btd_device_all_services_allowed(dev_data->device);
+
+	if (affected == dev_data->affected)
+		return;
+
+	dev_data->affected = affected;
+
+	g_dbus_emit_property_changed(dbus_conn, dev_data->path,
+			ADMIN_POLICY_STATUS_INTERFACE, "AffectedByPolicy");
+}
+
 static DBusMessage *set_service_allowlist(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -167,6 +189,8 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 					ADMIN_POLICY_STATUS_INTERFACE,
 					"ServiceAllowList");
 
+	queue_foreach(devices, update_device_affected, NULL);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -226,6 +250,29 @@ static bool device_data_match(const void *a, const void *b)
 	return data->device == dev;
 }
 
+static gboolean property_get_affected_by_policy(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct device_data *data = user_data;
+	dbus_bool_t affected;
+
+	if (!data) {
+		error("Unexpected error: device_data is NULL");
+		return FALSE;
+	}
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&data->affected);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable admin_policy_device_properties[] = {
+	{ "AffectedByPolicy", "b", property_get_affected_by_policy },
+	{ }
+};
+
 static void free_device_data(void *data)
 {
 	struct device_data *device_data = data;
@@ -308,11 +355,33 @@ static void admin_policy_device_added(struct btd_adapter *adapter,
 
 	data->device = device;
 	data->path = g_strdup(device_get_path(device));
+	data->affected = !btd_device_all_services_allowed(data->device);
+
+	if (!g_dbus_register_interface(dbus_conn, data->path,
+					ADMIN_POLICY_STATUS_INTERFACE,
+					NULL, NULL,
+					admin_policy_device_properties,
+					data, remove_device_data)) {
+		btd_error(btd_adapter_get_index(adapter),
+			"Admin Policy Status interface init failed on path %s",
+						device_get_path(device));
+		free_device_data(data);
+		return;
+	}
+
 	queue_push_tail(devices, data);
 
 	DBG("device_data for %s added", data->path);
 }
 
+static void unregister_device_data(void *data, void *user_data)
+{
+	struct device_data *dev_data = data;
+
+	g_dbus_unregister_interface(dbus_conn, dev_data->path,
+						ADMIN_POLICY_STATUS_INTERFACE);
+}
+
 static void admin_policy_device_removed(struct btd_adapter *adapter,
 						struct btd_device *device)
 {
@@ -321,7 +390,7 @@ static void admin_policy_device_removed(struct btd_adapter *adapter,
 	data = queue_find(devices, device_data_match, device);
 
 	if (data)
-		remove_device_data(data);
+		unregister_device_data(data, NULL);
 }
 
 static struct btd_adapter_driver admin_policy_driver = {
@@ -347,7 +416,8 @@ static void admin_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
-	queue_destroy(devices, free_device_data);
+	queue_foreach(devices, unregister_device_data, NULL);
+	queue_destroy(devices, g_free);
 
 	if (policy_data)
 		admin_policy_free(policy_data);
-- 
2.32.0.554.ge1b32706d8-goog

