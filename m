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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD240C4320A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C787E610A0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhHCLov (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbhHCLoT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 07:44:19 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E1C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 04:44:06 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id j12-20020a05620a146cb02903ad9c5e94baso16347996qkl.16
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HT6GZewuWl+DtJ4c8B9aj3YtUWlkueJmooALc8VEJgE=;
        b=MR8SDqqmRzObNxYFOq6kTmLHcaA4+1krGDnsxhAfmjR6jhjLANVfBDJMeLbqmX8KqT
         js6qeddYSkS7VfNykL/YOsYio6otclAa78ekavQEJmM9wpcBeqtfcdwGgzIq2AE7P5vg
         D/9P1AoNyl2QBlDtzIMqzhCGk6pRe81ycEb66lAnI/1u6Ad8+aVGd3yzamLBv+XE553Y
         2UESdmVT1wl5CAijZX3Z41+OIj0jcWiSZ8TuGuLA8KSpX6YXdnzpNh5aW4BbhqwOeU4X
         IZgnIBQZVRBzYoyZe6GH8NgW8C5c8eG6cYU2pkqtcxnYwyVYADdo/L5CkWrSaIM41NHo
         Nr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HT6GZewuWl+DtJ4c8B9aj3YtUWlkueJmooALc8VEJgE=;
        b=o3VWRuqATREIRp4osvimOhtZBBMKdghjhs/3g5ialsJrMzMFW4wItvdNWTH7vUYZcH
         nksAtF3kniZC6qqA2JEmWLTsTE+vV+o3FWtMrnOUxQXkV98ICkAIfftmjZnmQeDTTV5m
         2j9sTOC6BJKIe+HXA4oosw9auN2/vI/c10sHnvjVgHEJjrMwgQsQOgLb/eGSqd1aw86B
         65GsBLRXssQG8F1oAukPKOUXml192FMtWKcoOzlOdzr9VCXs3wsxCb7Nj2LaEP+Fbs5v
         kyDMLRNtlhNBn4qP/DLLtktLSSy7F9B4h4yiiG+zLAgHAliG/Kpp9W1bc823izWGOd1V
         UFng==
X-Gm-Message-State: AOAM5333WC0vcqEDo/FW8uXIqZeSg+jjJVlfxXJaWLkS6xjSGgQjbsfn
        snrsJ6peb//LPEDUPavSJcMPwPsEk79V5yN217Qy4O5JJhuTywsCFVFPdP41wRdhxGVukFswjZc
        lNCnb9keKTS/13D8hwBubtxUxX0K8QtrE4iszbyeLU90bwVpSSrmcndAsw5e74r++ospQR57btU
        /TWzPr/SUvOKE=
X-Google-Smtp-Source: ABdhPJz0sWlP5rAAraFZJvfCsCRKPDECBChm4ILI1mTtKUTKMhUsVK3P+UTwx4KHG9VKuDo//MBRXIudh3VP0ERqrw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a05:6214:1362:: with SMTP id
 c2mr21398056qvw.9.1627991045835; Tue, 03 Aug 2021 04:44:05 -0700 (PDT)
Date:   Tue,  3 Aug 2021 19:43:15 +0800
In-Reply-To: <20210803114317.801840-1-howardchung@google.com>
Message-Id: <20210803194127.Bluez.v9.11.Ib26c0abdbd417673a8b5788c175c06110726a68c@changeid>
Mime-Version: 1.0
References: <20210803114317.801840-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v9 11/13] plugins/admin: persist policy settings
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

(no changes since v8)

Changes in v8:
- Move store_policy_settings earlier to avoid forward declaration.

 plugins/admin.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 2 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 7936f8c11475..428a5528cc88 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -14,6 +14,9 @@
 
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
+#include <sys/file.h>
+#include <sys/stat.h>
+#include <errno.h>
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
@@ -24,11 +27,13 @@
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
@@ -161,6 +166,161 @@ static void update_device_affected(void *data, void *user_data)
 			ADMIN_POLICY_STATUS_INTERFACE, "AffectedByPolicy");
 }
 
+static void free_uuid_strings(char **uuid_strs, gsize num)
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
+	/* Set num to a non-zero number so that whoever call this could know if
+	 * this function success or not
+	 */
+	*num = 1;
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
+	uuid_strs = new_uuid_strings(admin_policy->service_allowlist,
+								&num_uuids);
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
 static DBusMessage *set_service_allowlist(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -179,7 +339,9 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 	}
 
-	if (!service_allowlist_set(admin_policy, uuid_list)) {
+	if (service_allowlist_set(admin_policy, uuid_list)) {
+		store_policy_settings(admin_policy);
+	} else {
 		free_service_allowlist(uuid_list);
 		return btd_error_failed(msg, "service_allowlist_set failed");
 	}
@@ -200,7 +362,7 @@ static const GDBusMethodTable admin_policy_adapter_methods[] = {
 	{ }
 };
 
-void append_service_uuid(void *data, void *user_data)
+static void append_service_uuid(void *data, void *user_data)
 {
 	bt_uuid_t *uuid = data;
 	DBusMessageIter *entry = user_data;
@@ -305,6 +467,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	if (!policy_data)
 		return -ENOMEM;
 
+	load_policy_settings(policy_data);
 	adapter_path = adapter_get_path(adapter);
 
 	if (!g_dbus_register_interface(dbus_conn, adapter_path,
-- 
2.32.0.554.ge1b32706d8-goog

