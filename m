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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0ABC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B18360240
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhG1NQ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbhG1NQ1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:16:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67385C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a188-20020a25cac50000b029055d47682463so2859858ybg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=waFPu4k2vBWMdVfD1NhijACyWe0PqH5dsXXL6RGsLDg=;
        b=uEfscM+v9nCyLwhZRBHT8z9aKuHG4/75NDQsREeqCuhkasTCI8emg0G0TmmdRahFz0
         4BX4RtHnfSAO/f7eAiLFIEN0+Bebao07C4gr4C+fHU9jgVMHEY+isRsTfauOTECfIITA
         stWQP/BA4HzX8cqTurYCRJjuZxGAJ8gJ1koJywvaFWiTuFvyS114r4Gy1ioCsLayanDN
         ORArZi1tXfI+WjRbU78LKy779DADuN3qFbzg2gIWlpffK2kqacobOo4Bk+MsiK6dBGGl
         GFNyugzj79JDyxBcBnKUvClj6TPizHH+0BcJEk5mzjcvujg4rKJDh+tkt67qNMkRTrQ1
         +Ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=waFPu4k2vBWMdVfD1NhijACyWe0PqH5dsXXL6RGsLDg=;
        b=BPW48c0nXjcMWUcRE6h2oIpWKauokcmuDwHQPdd915RJ87V0Wf2eljN7knnvy0QT1b
         s7j3BxjcNoG26NyhgSDWFSsnvLWgvn+wdRzerxtfP48EckVabGpQ0SewGfsHWbIxcJAK
         Z30oHGS8Yc3+ZbyCvvYZnwxD7Y1YvPkZsrvcNfbWHXKW0m9eWpA5dfToq3MJGUxdSAUQ
         YtQgknEZCc0stJhZKFrGjacYrkfMx89syFB81pUTt0gxqwSHp+giAP9ZaCjpJm+9rW9p
         rLuu1Qf499TPD1CQYwPrJuhEauaUHIpvGZYi4CnVBxVYWe2z2+HtUC8TzATwE4q1UvzW
         79hQ==
X-Gm-Message-State: AOAM532DQVw6F5zwCUPZRgM0DNf/4kjmhQ2iMGPAZe+pxpdKnRveI7uE
        lnDREqLnjIQBrBQj4lqu8o2LGmrP8ogj9ZzVQ2H7NMBJH4Cel5/c8ppA6IzaT0Hg5sfVr2+ABPr
        3rGAAw27A9s5pBTV421MNBQ07Ih4CBr5skgPgivgI2ZpsrDmBR9Mdomk/HbhjxCIPUbJLMhOEJx
        U1IXY/NXCuT4k=
X-Google-Smtp-Source: ABdhPJyH7FYc8z7J+WtOSigY444CYZjXKmHmEwnvu1SGti7H4MHN2QKLJV4rQpauKHOgb12NZ4GvnYio9eFciwYIvg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a25:f503:: with SMTP id
 a3mr25898153ybe.501.1627478185545; Wed, 28 Jul 2021 06:16:25 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:25 +0800
In-Reply-To: <20210728131529.3310558-1-howardchung@google.com>
Message-Id: <20210728211405.Bluez.v3.9.I00fd6c348e4c93501de6de0eae0d23436fd3895b@changeid>
Mime-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 09/13] plugins/admin_policy: add ServiceAllowList property
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds code to register interface org.bluez.AdminPolicyStatus.
The interface will provide read-only properties to indicate the current
settings of admin policies. We separate this from AdminPolicySet so that
normal clients can check current policy settings while only a few
clients can change policies.

This patch also adds readonly property ServiceAllowlist to
AdminPolicyStatus1, which indicates the current setting of service
allowlist.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
The following test steps were performed:
1. Set ServiceAllowList to ["1124","180A","180F","1812"]
2. Verify ServiceAllowList is ["1124","180A","180F","1812"] in UUID-128
   form
3. Set ServiceAllowList to []
4. Verify ServiceAllowList is []

(no changes since v1)

 plugins/admin.c        | 58 ++++++++++++++++++++++++++++++++++++++++++
 plugins/admin_policy.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/plugins/admin.c b/plugins/admin.c
index 1fe2904d9..d89a77c8a 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -27,6 +27,7 @@
 #include "src/shared/queue.h"
 
 #define ADMIN_POLICY_SET_INTERFACE	"org.bluez.AdminPolicySet1"
+#define ADMIN_POLICY_STATUS_INTERFACE	"org.bluez.AdminPolicyStatus1"
 
 static DBusConnection *dbus_conn;
 
@@ -151,6 +152,11 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 		return btd_error_failed(msg, "service_allowlist_set failed");
 	}
 
+	g_dbus_emit_property_changed(dbus_conn,
+					adapter_get_path(policy_data->adapter),
+					ADMIN_POLICY_STATUS_INTERFACE,
+					"ServiceAllowList");
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -160,6 +166,43 @@ static const GDBusMethodTable admin_policy_adapter_methods[] = {
 	{ }
 };
 
+void append_service_uuid(void *data, void *user_data)
+{
+	bt_uuid_t *uuid = data;
+	DBusMessageIter *entry = user_data;
+	char uuid_str[MAX_LEN_UUID_STR];
+	const char *uuid_str_ptr = uuid_str;
+
+	if (!uuid) {
+		error("Unexpected NULL uuid data in service_allowlist");
+		return;
+	}
+
+	bt_uuid_to_string(uuid, uuid_str, MAX_LEN_UUID_STR);
+	dbus_message_iter_append_basic(entry, DBUS_TYPE_STRING, &uuid_str_ptr);
+}
+
+static gboolean property_get_service_allowlist(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_admin_policy *admin_policy = user_data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+	queue_foreach(admin_policy->service_allowlist, append_service_uuid,
+									&entry);
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable admin_policy_adapter_properties[] = {
+	{ "ServiceAllowList", "as", property_get_service_allowlist },
+	{ }
+};
+
 static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 {
 	const char *adapter_path;
@@ -189,6 +232,21 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 
 	btd_info(policy_data->adapter_id,
 				"Admin Policy Set interface registered");
+
+	if (!g_dbus_register_interface(dbus_conn, adapter_path,
+					ADMIN_POLICY_STATUS_INTERFACE,
+					NULL, NULL,
+					admin_policy_adapter_properties,
+					policy_data, admin_policy_free)) {
+		btd_error(policy_data->adapter_id,
+			"Admin Policy Status interface init failed on path %s",
+								adapter_path);
+		return -EINVAL;
+	}
+
+	btd_info(policy_data->adapter_id,
+				"Admin Policy Status interface registered");
+
 	return 0;
 }
 
diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index 242b8d5da..270d42366 100644
--- a/plugins/admin_policy.c
+++ b/plugins/admin_policy.c
@@ -27,6 +27,7 @@
 #include "src/shared/queue.h"
 
 #define ADMIN_POLICY_SET_INTERFACE	"org.bluez.AdminPolicySet1"
+#define ADMIN_POLICY_STATUS_INTERFACE	"org.bluez.AdminPolicyStatus1"
 
 static DBusConnection *dbus_conn;
 
@@ -151,6 +152,11 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 		return btd_error_failed(msg, "service_allowlist_set failed");
 	}
 
+	g_dbus_emit_property_changed(dbus_conn,
+					adapter_get_path(policy_data->adapter),
+					ADMIN_POLICY_STATUS_INTERFACE,
+					"ServiceAllowList");
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -160,6 +166,43 @@ static const GDBusMethodTable admin_policy_adapter_methods[] = {
 	{ }
 };
 
+void append_service_uuid(void *data, void *user_data)
+{
+	bt_uuid_t *uuid = data;
+	DBusMessageIter *entry = user_data;
+	char uuid_str[MAX_LEN_UUID_STR];
+	const char *uuid_str_ptr = uuid_str;
+
+	if (!uuid) {
+		error("Unexpected NULL uuid data in service_allowlist");
+		return;
+	}
+
+	bt_uuid_to_string(uuid, uuid_str, MAX_LEN_UUID_STR);
+	dbus_message_iter_append_basic(entry, DBUS_TYPE_STRING, &uuid_str_ptr);
+}
+
+static gboolean property_get_service_allowlist(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_admin_policy *admin_policy = user_data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+	queue_foreach(admin_policy->service_allowlist, append_service_uuid,
+									&entry);
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable admin_policy_adapter_properties[] = {
+	{ "ServiceAllowList", "as", property_get_service_allowlist },
+	{ }
+};
+
 static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 {
 	if (policy_data) {
@@ -185,6 +228,21 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 
 	btd_info(policy_data->adapter_id,
 				"Admin Policy Set interface registered");
+
+	if (!g_dbus_register_interface(dbus_conn, adapter_get_path(adapter),
+					ADMIN_POLICY_STATUS_INTERFACE,
+					NULL, NULL,
+					admin_policy_adapter_properties,
+					policy_data, admin_policy_free)) {
+		btd_error(policy_data->adapter_id,
+			"Admin Policy Status interface init failed on path %s",
+						adapter_get_path(adapter));
+		return -EINVAL;
+	}
+
+	btd_info(policy_data->adapter_id,
+				"Admin Policy Status interface registered");
+
 	return 0;
 }
 
-- 
2.32.0.432.gabb21c7263-goog

