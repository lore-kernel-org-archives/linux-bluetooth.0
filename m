Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA627C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BFC60F48
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhHCIXv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhHCIXv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 04:23:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACACC06175F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 01:23:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso22091502ybg.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NHnWpmnchr1M3qNJZS28mvOxF/U82MrGnXWxqqn/Vsc=;
        b=W4Xn8GMWR890bv6a1/mtOMH5Zo029YcspvHgioB23vvdXwsdzRKg1H9bCAuhRVN3dp
         AbfdIPS2CoPNODABPmzHDoi7b/Rde+p167sINssGBpXRguDszj4CNAmo7PTQqvftfG8/
         3/SUCkomW8/J9MIVi8NomMjdFD2k7XSfMWi/Q+6JPwJ+5Lw7ruFIzJ06BJESjTLAwXvo
         VxHco1OAEzwbMEhCUi54oKJ8K55VFe70gnjmw1LPG/jyE2CElKcfmCFB3F5ZBRE1lEe3
         nUeZ/WS09qaZQDlcqqk9ucq9Dc3caT+yhyF3WQdmo/B3waNQK7kf+iW/7CNIyOpHYkbg
         atiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NHnWpmnchr1M3qNJZS28mvOxF/U82MrGnXWxqqn/Vsc=;
        b=M6bhj33aK/LKDkaSYAov0qQsuRhWU3DyAVAQeSZkUUYP8LdeYiCHGD6lva3EC7+juK
         jYSNSYM7K5XsaTurTovjdPgrb/9CqZ7otgl3UvmSFj+mfuvBtb7O5qSPadayTAQjxdVi
         iRJy8EhDheXFVFE/zvIr/Fj1xjg6cro8yVIGnoVUrIDYzj0464Y4quQ9eNsAJppcctYc
         IZuDvim8Vd+aw1LUSR78Cw+7HBg396FDT9c634ppCXEiiqo1gnfw/aT4AYy0Ua8byYAA
         YRXSG2xgKMWoVFIwpzV+W9WQW94vzl68Ory5h609PaIAhZPHJmkoqHBJ7YAGioyL1K3i
         3PWw==
X-Gm-Message-State: AOAM530ueXTAtpO+9mKRImkGXd4tHzCfnQoyGWNF1yHqheszy8x6TpWh
        xR9PIu9KrYt5Wx4ONYXWfnxYKVz5p6mkjoqe9trrkJo2oDbQZA2bA7KGox6shKWz7pwaIUzNptJ
        +jc70fI9JgbZxJhrt0ys+fu2BDoYjlvibw/o1RG3RcRRLoQh06tjQytQsoAGACbPqOKj7bkHGUd
        KXlU4b5e/BkWg=
X-Google-Smtp-Source: ABdhPJyy+PZKzeJRErKCUfkPl8+fyIKqyYty3VAteD9CuMkDlanjibxig9zQx+e88BxNxmfZmAjorbUvJAD17iNbwA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a25:2985:: with SMTP id
 p127mr26828528ybp.386.1627979019514; Tue, 03 Aug 2021 01:23:39 -0700 (PDT)
Date:   Tue,  3 Aug 2021 16:22:34 +0800
In-Reply-To: <20210803082237.723766-1-howardchung@google.com>
Message-Id: <20210803161319.Bluez.v8.10.I570c860f59c8ed66ddb31aa54584ee08080aa10c@changeid>
Mime-Version: 1.0
References: <20210803082237.723766-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v8 10/13] plugins/admin: add AffectedByPolicy property
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

 plugins/admin.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 0a0d8a39ed37..7936f8c11475 100644
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
 
@@ -226,6 +250,28 @@ static bool device_data_match(const void *a, const void *b)
 	return data->device == dev;
 }
 
+static gboolean property_get_affected_by_policy(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct device_data *data = user_data;
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
@@ -308,11 +354,33 @@ static void admin_policy_device_added(struct btd_adapter *adapter,
 
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
@@ -321,7 +389,7 @@ static void admin_policy_device_removed(struct btd_adapter *adapter,
 	data = queue_find(devices, device_data_match, device);
 
 	if (data)
-		remove_device_data(data);
+		unregister_device_data(data, NULL);
 }
 
 static struct btd_adapter_driver admin_policy_driver = {
@@ -347,7 +415,8 @@ static void admin_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
-	queue_destroy(devices, free_device_data);
+	queue_foreach(devices, unregister_device_data, NULL);
+	queue_destroy(devices, g_free);
 
 	if (policy_data)
 		admin_policy_free(policy_data);
-- 
2.32.0.554.ge1b32706d8-goog

