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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1974BC63798
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F402F60551
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhGVGn4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhGVGnv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:43:51 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FDFC06179E
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:59 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p9-20020a170902e749b029012b7acb0e05so2223655plf.23
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aHuuA3aXJk87AqDOW0EsHYsn/rLGQfcJ7MKOCIl3a4E=;
        b=llJZeIX2BqU58SpYL2dmOrcdOxd9jjxgVC7YB9GJ87R3LKi6Msiz7lm8iRftihs4j6
         nKGt25U4Fwv7B6RQGT3lcejK6BRVDoCGEeAu5FgyUcGB4vhOH1P88m9wqLfGhigJ1Au5
         TMcHaaPNl5XGMZj8XHrkHwSG/WbsAoW+m7Oi66x6vdAoRfCZ8b3O1YbIJhHmEaL57DZM
         ODeCgFI0DHuH+8YwLkl1vaoZhTjfk44i9cRsaLXK9OoxP+7Sq9xGhyphmL6N4ft9f5hB
         JZZNiU12IVxxUHLTYlBE9aWp/BkFMwOVqbtVjdAs8bWHMwgWrM1BdWcwTBkAGk+q5xhG
         tU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aHuuA3aXJk87AqDOW0EsHYsn/rLGQfcJ7MKOCIl3a4E=;
        b=aiz6THmBewy9F2FmwH6e1XorlYPgMpJcCmGUycStiARku0AIXfxmUVblTW8CiDiOJ2
         s9RICpE2W8kUFmwOm33fJvQuSbvONf7PNNfXuKkXrARCP3mRcTfpatwsqACDnMuy22jm
         SsXpjtPQwL8T4e/772WOEHqSsghO/djFR66iyjdh8VKy8H3VUGUutKjyG27/vOycaHW7
         7AMZk59bIPm4vPDxlAadm2dnIIsjA3PfUA3wO7sajbMBSSaM74q8JtoZsgi5qRHP4eiI
         KPTvNGMVpFAlurPWBhGEaJxBOB3nhSN6TpenZDzqCm/bDVn9l+EaWnnvLJZXduYotfqS
         6P6Q==
X-Gm-Message-State: AOAM533m3EEv0R9nqULYjJ3YmaDYW0tOS4TXt/j9k0yCrzsirDks6Mt9
        DMeerkp4rNVbq7wrVv30lPMdQBqtfyRZDhh4PC/cQJQJ+EBT26oVfmKVudLj9k+me1DqNBPsF7/
        vf/Ho/nPcIYf5MoTZ3lnux301QZnbk2i3DnGtHm97LS195me9lXufj6JeGyduxmSoDZbfwxeYKd
        kSwKHOCTrvbro=
X-Google-Smtp-Source: ABdhPJw5plFXApemPbapEI6YbHuKQ07g9YQoGdrsSXtCMAuXeOYe5ZlZI+2FWynsMaoJDa/Mh4pn3KcPDMnSS9yWVw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:69a3:595f:8267:f7e0])
 (user=howardchung job=sendgmr) by 2002:a62:160a:0:b029:328:56b9:b1ee with
 SMTP id 10-20020a62160a0000b029032856b9b1eemr40640871pfw.52.1626938638650;
 Thu, 22 Jul 2021 00:23:58 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:23:19 +0800
In-Reply-To: <20210722072321.1225119-1-howardchung@google.com>
Message-Id: <20210722152159.Bluez.v2.9.I570c860f59c8ed66ddb31aa54584ee08080aa10c@changeid>
Mime-Version: 1.0
References: <20210722072321.1225119-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [Bluez PATCH v2 09/11] plugins/admin_policy: add AffectedByPolicy property
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

 plugins/admin_policy.c | 74 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index 73d695ef976b..3ce72b56b529 100644
--- a/plugins/admin_policy.c
+++ b/plugins/admin_policy.c
@@ -47,6 +47,7 @@ static struct btd_admin_policy {
 struct device_data {
 	struct btd_device *device;
 	char *path;
+	bool affected;
 };
 
 static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
@@ -140,6 +141,27 @@ static bool service_allowlist_set(struct btd_admin_policy *admin_policy,
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
@@ -168,6 +190,8 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 					ADMIN_POLICY_STATUS_INTERFACE,
 					"ServiceAllowList");
 
+	queue_foreach(devices, update_device_affected, NULL);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -240,6 +264,29 @@ static bool device_data_match_by_path(const void *a, const void *b)
 	return strcmp(data->path, b) == 0;
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
@@ -275,11 +322,33 @@ static void add_device_data(struct btd_device *device)
 
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
 static struct btd_device *find_device_by_proxy(GDBusProxy *proxy)
 {
 	const char *path = g_dbus_proxy_get_path(proxy);
@@ -323,7 +392,7 @@ static void object_removed_cb(GDBusProxy *proxy, void *user_data)
 	data = queue_find(devices, device_data_match_by_path, path);
 
 	if (data)
-		remove_device_data(data);
+		unregister_device_data(data, NULL);
 }
 
 static int admin_policy_adapter_probe(struct btd_adapter *adapter)
@@ -402,7 +471,8 @@ static void admin_policy_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
-	queue_destroy(devices, free_device_data);
+	queue_foreach(devices, unregister_device_data, NULL);
+	queue_destroy(devices, g_free);
 
 	if (policy_data)
 		admin_policy_free(policy_data);
-- 
2.32.0.402.g57bb445576-goog

