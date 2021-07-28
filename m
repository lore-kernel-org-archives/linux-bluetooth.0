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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF42FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C852860240
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhG1NQp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbhG1NQn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:16:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE6FC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v71-20020a252f4a0000b029055b51419c7dso2732685ybv.23
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9m5S22NXiUW+VjjEnZGAPl9V6e1p2/iWayg/BhZIEE8=;
        b=Ah4tx76FOQy0W5cNrdh5IRTy6/sWf8HHi1yFKrtI+gt2HS3xk/nkXRxkFyC9BHoo2T
         nMrX8fY7NgAEbv7XCDKrHrdFD6bg2JGKGX8fprbH7VY2ZNYi4EGdo4uqqHV9li91v1vK
         DbnwUf1Xrt7c0CQgMclHuzOgkabLBo6GOOi/MhKqBUEEsybhWkbF04vWRjifN/7l++Nw
         KC94SqpGeuS/9UHKr+0eoXJnvoQk0yGMqLpChlIVdBOGob/L+NmPm7mIxKAxvsP1zTrg
         +ojirhnP+bO3mogYTzlLTdFdqJPxzIhCBPh3FZA1bCe22cFVfE28R+J3QBGsAaucjSP3
         gKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9m5S22NXiUW+VjjEnZGAPl9V6e1p2/iWayg/BhZIEE8=;
        b=Qgbp+en+zPz3heNpgQoG9CR2nZsPtBLl9bhGpG6Iquj7trg66min4QhOcA99HYy4xk
         eF6NFz/byRvWQeDsa5OSZjuiUSsffRtYYHToFmnNgm1lSiJLDGuTaeZ2XJ+sceZj/123
         y+2FXhd6jyw4qosqtIp05BFSHtc/is8FmRv1ilmy80T6q7g9Kt2dfr1CfSj1n/oEXK/C
         udC0nVB4KuMqk/JWCIf5mioHOzZwHvdXxnHJJryrilgQYx/XyIWRzdi0zALlWVDb4rXN
         VjjVnN0d1WoCPjsbR6kDBc9PmJ9f4r/hN5/tYrU6cC/e62zsbRX+oJAF+HBwR0CKu+Dj
         ohtg==
X-Gm-Message-State: AOAM5306kaf03zSrpNoRDBQQNSLhZsv7EZNKmNcah/7FFL+TUuyGiv6X
        qpw5deru/LokwDd2mTcYfSSvD8k4nO+gDycRMozi7gvybHnK2Cm5XzCPBv121/Ro1wmkm91PsKL
        ox1m9giw2iqge5SNyfOKFfXQZzhD2WGmfHRbCDvzVqm82iDUYJuiiXrEpGISTrg5c49mMkkeOHQ
        gR62lGya0ASpw=
X-Google-Smtp-Source: ABdhPJwomGtYMpfKv1ujYoVuxxeV/LGwlwJ3Yz28zBXWT3OJlVVevH0VZOVfLLgVfccivrEucdnw6N0YwB8kR7Q6hA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a25:b9c7:: with SMTP id
 y7mr38677294ybj.78.1627478201331; Wed, 28 Jul 2021 06:16:41 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:28 +0800
In-Reply-To: <20210728131529.3310558-1-howardchung@google.com>
Message-Id: <20210728211405.Bluez.v3.12.Ib26c0abdbd417673a8b5788c175c06110726a68c@changeid>
Mime-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 12/13] plugins/admin_policy: persist policy settings
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds code to store the ServiceAllowlist to file
/var/lib/bluetooth/{MAC_ADDR}/admin_policy
The stored settings will be loaded upon admin_policy initialized.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
The following test steps were performed:
1. Set ServiceAllowlist to ["1124","180A","180F","1812", "1801"]
2. restart bluetoothd
3. Verify ServiceAllowlist is ["1124","180A","180F","1812","1801"] in
   UUID-128 form
4. Set ServiceAllowlist to []
5. restart bluetoothd
6. Verify ServiceAllowlist is []

(no changes since v1)

 plugins/admin.c        | 163 ++++++++++++++++++++++++++++++++++++++++-
 plugins/admin_policy.c | 163 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 324 insertions(+), 2 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 2ad60f2fd..82a8ae928 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -14,6 +14,8 @@
 
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
+#include <sys/file.h>
+#include <sys/stat.h>
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
@@ -24,11 +26,13 @@
 #include "src/error.h"
 #include "src/log.h"
 #include "src/plugin.h"
+#include "src/textfile.h"
 
 #include "src/shared/queue.h"
 
 #define ADMIN_POLICY_SET_INTERFACE	"org.bluez.AdminPolicySet1"
 #define ADMIN_POLICY_STATUS_INTERFACE	"org.bluez.AdminPolicyStatus1"
+#define ADMIN_POLICY_STORAGE		STORAGEDIR "/admin_policy_settings"
 
 #define DBUS_BLUEZ_SERVICE		"org.bluez"
 #define BTD_DEVICE_INTERFACE		"org.bluez.Device1"
@@ -161,6 +165,8 @@ static void update_device_affected(void *data, void *user_data)
 			ADMIN_POLICY_STATUS_INTERFACE, "AffectedByPolicy");
 }
 
+static void store_policy_settings(struct btd_admin_policy *admin_policy);
+
 static DBusMessage *set_service_allowlist(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -179,7 +185,9 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 	}
 
-	if (!service_allowlist_set(admin_policy, uuid_list)) {
+	if (service_allowlist_set(admin_policy, uuid_list)) {
+		store_policy_settings(admin_policy);
+	} else {
 		free_service_allowlist(uuid_list);
 		return btd_error_failed(msg, "service_allowlist_set failed");
 	}
@@ -237,6 +245,158 @@ static const GDBusPropertyTable admin_policy_adapter_properties[] = {
 	{ }
 };
 
+static void free_uuid_strings(char **uuid_strs, int num)
+{
+	gsize i;
+
+	for (i = 0; i < num; i++)
+		g_free(uuid_strs[i]);
+	g_free(uuid_strs);
+}
+
+static char **new_uuid_strings(struct queue *allowlist, gsize *num)
+{
+	const struct queue_entry *entry = NULL;
+	bt_uuid_t *uuid = NULL;
+	char **uuid_strs = NULL;
+	gsize i = 0, allowlist_num;
+
+	allowlist_num = queue_length(allowlist);
+	uuid_strs = g_try_malloc_n(allowlist_num, sizeof(char *));
+	if (!uuid_strs)
+		return NULL;
+
+	for (entry = queue_get_entries(allowlist); entry != NULL;
+							entry = entry->next) {
+		uuid = entry->data;
+		uuid_strs[i] = g_try_malloc0(MAX_LEN_UUID_STR * sizeof(char));
+
+		if (!uuid_strs[i])
+			goto failed;
+
+		bt_uuid_to_string(uuid, uuid_strs[i], MAX_LEN_UUID_STR);
+		i++;
+	}
+
+	*num = allowlist_num;
+	return uuid_strs;
+
+failed:
+	free_uuid_strings(uuid_strs, i);
+
+	return NULL;
+}
+
+static void store_policy_settings(struct btd_admin_policy *admin_policy)
+{
+	GKeyFile *key_file = NULL;
+	char *filename = ADMIN_POLICY_STORAGE;
+	char *key_file_data = NULL;
+	char **uuid_strs = NULL;
+	gsize length, num_uuids;
+
+	key_file = g_key_file_new();
+
+	if (num_uuids) {
+		uuid_strs = new_uuid_strings(admin_policy->service_allowlist,
+								&num_uuids);
+	}
+
+	if (!uuid_strs && num_uuids) {
+		btd_error(admin_policy->adapter_id,
+					"Failed to allocate uuid strings");
+		goto failed;
+	}
+
+	g_key_file_set_string_list(key_file, "General", "ServiceAllowlist",
+					(const gchar * const *)uuid_strs,
+					num_uuids);
+
+	if (create_file(ADMIN_POLICY_STORAGE, 0600) < 0) {
+		btd_error(admin_policy->adapter_id, "create %s failed, %s",
+						filename, strerror(errno));
+		goto failed;
+	}
+
+	key_file_data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(ADMIN_POLICY_STORAGE, key_file_data, length, NULL);
+
+	g_free(key_file_data);
+	free_uuid_strings(uuid_strs, num_uuids);
+
+failed:
+	g_key_file_free(key_file);
+}
+
+static void key_file_load_service_allowlist(GKeyFile *key_file,
+					struct btd_admin_policy *admin_policy)
+{
+	GError *gerr = NULL;
+	struct queue *uuid_list = NULL;
+	gchar **uuids = NULL;
+	gsize num, i;
+
+	uuids = g_key_file_get_string_list(key_file, "General",
+					"ServiceAllowlist", &num, &gerr);
+
+	if (gerr) {
+		btd_error(admin_policy->adapter_id,
+					"Failed to load ServiceAllowlist");
+		g_error_free(gerr);
+		return;
+	}
+
+	uuid_list = queue_new();
+	for (i = 0; i < num; i++) {
+		bt_uuid_t *uuid = g_try_malloc(sizeof(*uuid));
+
+		if (!uuid)
+			goto failed;
+
+		if (bt_string_to_uuid(uuid, *uuids)) {
+
+			btd_error(admin_policy->adapter_id,
+					"Failed to convert '%s' to uuid struct",
+					*uuids);
+
+			g_free(uuid);
+			goto failed;
+		}
+
+		queue_push_tail(uuid_list, uuid);
+		uuids++;
+	}
+
+	if (!service_allowlist_set(admin_policy, uuid_list))
+		goto failed;
+
+	return;
+failed:
+	free_service_allowlist(uuid_list);
+}
+
+static void load_policy_settings(struct btd_admin_policy *admin_policy)
+{
+	GKeyFile *key_file;
+	char *filename = ADMIN_POLICY_STORAGE;
+	struct stat st;
+
+	if (stat(filename, &st) < 0) {
+		btd_error(admin_policy->adapter_id,
+				"Failed to get file %s information",
+				filename);
+		return;
+	}
+
+	key_file = g_key_file_new();
+
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	key_file_load_service_allowlist(key_file, admin_policy);
+
+	g_key_file_free(key_file);
+}
+
 static bool device_data_match(const void *a, const void *b)
 {
 	const struct device_data *data = a;
@@ -306,6 +466,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	if (!policy_data)
 		return -ENOMEM;
 
+	load_policy_settings(policy_data);
 	adapter_path = adapter_get_path(adapter);
 
 	if (!g_dbus_register_interface(dbus_conn, adapter_path,
diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index 3ce72b56b..3a55d97b3 100644
--- a/plugins/admin_policy.c
+++ b/plugins/admin_policy.c
@@ -14,6 +14,8 @@
 
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
+#include <sys/file.h>
+#include <sys/stat.h>
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
@@ -24,11 +26,13 @@
 #include "src/error.h"
 #include "src/log.h"
 #include "src/plugin.h"
+#include "src/textfile.h"
 
 #include "src/shared/queue.h"
 
 #define ADMIN_POLICY_SET_INTERFACE	"org.bluez.AdminPolicySet1"
 #define ADMIN_POLICY_STATUS_INTERFACE	"org.bluez.AdminPolicyStatus1"
+#define ADMIN_POLICY_STORAGE		STORAGEDIR "/admin_policy_settings"
 
 #define DBUS_BLUEZ_SERVICE		"org.bluez"
 #define BTD_DEVICE_INTERFACE		"org.bluez.Device1"
@@ -162,6 +166,8 @@ static void update_device_affected(void *data, void *user_data)
 			ADMIN_POLICY_STATUS_INTERFACE, "AffectedByPolicy");
 }
 
+static void store_policy_settings(struct btd_admin_policy *admin_policy);
+
 static DBusMessage *set_service_allowlist(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -180,7 +186,9 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 	}
 
-	if (!service_allowlist_set(admin_policy, uuid_list)) {
+	if (service_allowlist_set(admin_policy, uuid_list)) {
+		store_policy_settings(admin_policy);
+	} else {
 		free_service_allowlist(uuid_list);
 		return btd_error_failed(msg, "service_allowlist_set failed");
 	}
@@ -238,6 +246,158 @@ static const GDBusPropertyTable admin_policy_adapter_properties[] = {
 	{ }
 };
 
+static void free_uuid_strings(char **uuid_strs, int num)
+{
+	gsize i;
+
+	for (i = 0; i < num; i++)
+		g_free(uuid_strs[i]);
+	g_free(uuid_strs);
+}
+
+static char **new_uuid_strings(struct queue *allowlist, gsize *num)
+{
+	const struct queue_entry *entry = NULL;
+	bt_uuid_t *uuid = NULL;
+	char **uuid_strs = NULL;
+	gsize i = 0, allowlist_num;
+
+	allowlist_num = queue_length(allowlist);
+	uuid_strs = g_try_malloc_n(allowlist_num, sizeof(char *));
+	if (!uuid_strs)
+		return NULL;
+
+	for (entry = queue_get_entries(allowlist); entry != NULL;
+							entry = entry->next) {
+		uuid = entry->data;
+		uuid_strs[i] = g_try_malloc0(MAX_LEN_UUID_STR * sizeof(char));
+
+		if (!uuid_strs[i])
+			goto failed;
+
+		bt_uuid_to_string(uuid, uuid_strs[i], MAX_LEN_UUID_STR);
+		i++;
+	}
+
+	*num = allowlist_num;
+	return uuid_strs;
+
+failed:
+	free_uuid_strings(uuid_strs, i);
+
+	return NULL;
+}
+
+static void store_policy_settings(struct btd_admin_policy *admin_policy)
+{
+	GKeyFile *key_file = NULL;
+	char *filename = ADMIN_POLICY_STORAGE;
+	char *key_file_data = NULL;
+	char **uuid_strs = NULL;
+	gsize length, num_uuids;
+
+	key_file = g_key_file_new();
+
+	if (num_uuids) {
+		uuid_strs = new_uuid_strings(admin_policy->service_allowlist,
+								&num_uuids);
+	}
+
+	if (!uuid_strs && num_uuids) {
+		btd_error(admin_policy->adapter_id,
+					"Failed to allocate uuid strings");
+		goto failed;
+	}
+
+	g_key_file_set_string_list(key_file, "General", "ServiceAllowlist",
+					(const gchar * const *)uuid_strs,
+					num_uuids);
+
+	if (create_file(ADMIN_POLICY_STORAGE, 0600) < 0) {
+		btd_error(admin_policy->adapter_id, "create %s failed, %s",
+						filename, strerror(errno));
+		goto failed;
+	}
+
+	key_file_data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(ADMIN_POLICY_STORAGE, key_file_data, length, NULL);
+
+	g_free(key_file_data);
+	free_uuid_strings(uuid_strs, num_uuids);
+
+failed:
+	g_key_file_free(key_file);
+}
+
+static void key_file_load_service_allowlist(GKeyFile *key_file,
+					struct btd_admin_policy *admin_policy)
+{
+	GError *gerr = NULL;
+	struct queue *uuid_list = NULL;
+	gchar **uuids = NULL;
+	gsize num, i;
+
+	uuids = g_key_file_get_string_list(key_file, "General",
+					"ServiceAllowlist", &num, &gerr);
+
+	if (gerr) {
+		btd_error(admin_policy->adapter_id,
+					"Failed to load ServiceAllowlist");
+		g_error_free(gerr);
+		return;
+	}
+
+	uuid_list = queue_new();
+	for (i = 0; i < num; i++) {
+		bt_uuid_t *uuid = g_try_malloc(sizeof(*uuid));
+
+		if (!uuid)
+			goto failed;
+
+		if (bt_string_to_uuid(uuid, *uuids)) {
+
+			btd_error(admin_policy->adapter_id,
+					"Failed to convert '%s' to uuid struct",
+					*uuids);
+
+			g_free(uuid);
+			goto failed;
+		}
+
+		queue_push_tail(uuid_list, uuid);
+		uuids++;
+	}
+
+	if (!service_allowlist_set(admin_policy, uuid_list))
+		goto failed;
+
+	return;
+failed:
+	free_service_allowlist(uuid_list);
+}
+
+static void load_policy_settings(struct btd_admin_policy *admin_policy)
+{
+	GKeyFile *key_file;
+	char *filename = ADMIN_POLICY_STORAGE;
+	struct stat st;
+
+	if (stat(filename, &st) < 0) {
+		btd_error(admin_policy->adapter_id,
+				"Failed to get file %s information",
+				filename);
+		return;
+	}
+
+	key_file = g_key_file_new();
+
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	key_file_load_service_allowlist(key_file, admin_policy);
+
+	g_key_file_free(key_file);
+}
+
 static bool device_data_match(const void *a, const void *b)
 {
 	const struct device_data *data = a;
@@ -410,6 +570,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	if (!policy_data)
 		return -ENOMEM;
 
+	load_policy_settings(policy_data);
 	adapter_path = adapter_get_path(adapter);
 
 	if (!g_dbus_register_interface(dbus_conn, adapter_path,
-- 
2.32.0.432.gabb21c7263-goog

