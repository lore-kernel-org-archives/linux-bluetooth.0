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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F357DC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DD860240
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbhG1NQj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbhG1NQi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:16:38 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61089C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:37 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id j13-20020a0cf30d0000b029032dd803a7edso1941417qvl.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ak/MLeitgxrnl9tWS1ibUYAvL7HQGK//m5OkSfh8Et0=;
        b=HllWjPmpRoM25oHc2ucNRRQjVYvJzTLAx7YwP9jadyz8rOZrltCN3e97ENKZhT5e2f
         IabWS8iLzTN0er66RbE32g4F/DDN1CNbdIwVegyycv3ConiGBY6IC05g2J/L4DeJbnbT
         pJM1XAMbePzercnP/3HazCDz/p3aE5kjd+9QkE61450NP9N4AeiS+ARd6824PLqANpJb
         dlOY6X+WdhZSOCM/3TmlZG2e+p0CTh34FrIJ/aaiLyPfILbqRLWZFVdbCF3P+vSWOTka
         DLA6UYhCTfjZMZ9n/ENndwUTHWKbluxyqc4vVhb/luPm5p75jg43cOb1YpWcxMcMgjRP
         MONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ak/MLeitgxrnl9tWS1ibUYAvL7HQGK//m5OkSfh8Et0=;
        b=SF4KrErSPRDfj4jRJaPyT6fbeFlhgpY4lTUM2i0BoPJWMb1uw4JfOC0056DWpSOMhd
         gXanlxp4dbkjjJcGWnBACb5Eeo8nxisAVerpraPSUVYkMpHzpP2kPRCmkPpugnh0XMJW
         vywq/nYB9uT2RjrXxMTE+dj9EZ9tDmghrWQ+8p2PFX9/zepUUqdjvPbcCUzn3RBufZsi
         FIEYY4nGnP82ak1yoQSbBqbIR41qwa3pw4b5eHcE/60uNetMIVoJNr6achpepGK+GgmC
         3/JY4HhFV4YdXaBgI+1N/oxwhokTlGO0EWuaqYVNnkMf+54ibYtZKyQeokwiM2MthlR8
         7Ikg==
X-Gm-Message-State: AOAM530jenYmTRKXS9fSQQ7CHe2cKvKz6p+NzmzlQWyGr90xKN3PE0wt
        3vTuD9uB3N7retKthKr7sYWvPGaEUBR8MFhTsKWMWuXjimAE+UfsANgB8hqQ7grvgbDQNYg0m9e
        jowxfIxq6iVHg1B81ZfEsF2WoVkRTZ+pJaVY0o8x7G1exrA0t7iDiFQomE8RUx6FmfZc5C882LZ
        QCNzFtfOqgc9s=
X-Google-Smtp-Source: ABdhPJyb3GaxDW1dcj6gRwMT5p39UBpkaId3i/Y5Ibzuj09/3vRwRdh6134fXJPEQ5DcoPaMP3b6/idXYcNYqs1XRA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a05:6214:1909:: with SMTP id
 er9mr20295872qvb.26.1627478196268; Wed, 28 Jul 2021 06:16:36 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:27 +0800
In-Reply-To: <20210728131529.3310558-1-howardchung@google.com>
Message-Id: <20210728211405.Bluez.v3.11.I570c860f59c8ed66ddb31aa54584ee08080aa10c@changeid>
Mime-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 11/13] plugins/admin_policy: add AffectedByPolicy property
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

 plugins/admin.c        | 74 ++++++++++++++++++++++++++++++++++++++++--
 plugins/admin_policy.c | 74 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 37dae77ac..2ad60f2fd 100644
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
diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index 73d695ef9..3ce72b56b 100644
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
2.32.0.432.gabb21c7263-goog

