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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA0CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F7260F02
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbhG2M3H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbhG2M3G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:29:06 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C97C061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:29:02 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c3-20020a05620a0ce3b02903b8eff05707so3129288qkj.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jBkhQ2uYe84K1xkjEXWDQaa9uaP7sg8rDmJHv7TS0ug=;
        b=pTbREdCA4x/sgZmVCc/H024z/drV4ehoyyXPndddzt9W6WIiShWMuKql+BWhvJk4kE
         fJ1gKfTzrBbZOtwjSZrdWSB5JEXFzj48a5NqStX3UIEeu5TXl81vH+Fapsvwm1c4jqfK
         KOyEXxYf3Dfcfq4GhbZNjCIWzBlnOmBxJwHVqWD3sMo36OsyqAQW1XrN+qYbDVbRjjGa
         5E2okDGcba5h7Mk04hHz0/ut+E1SE+LdJSCykn7CzdGHBIWkRdT778EN8aPe6NgNJBRr
         p72jQYsJBKphCfl26MwscbSPdudJtisY8iQywR3Oi0WYYq6hmvrRzBFllGj+fa8IgLbp
         z7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jBkhQ2uYe84K1xkjEXWDQaa9uaP7sg8rDmJHv7TS0ug=;
        b=l3VAH6jQo4Peb8hAos836As0YYfy8ryppMLvrse2nus9cXOHRNggOJBqBi7pf+Azgj
         T3DfEIR/FGBIJ0335a7i6fshhyK/916/d59ey3KTCQ4EggpPHdaZfDJhWNdkL6BAyTUh
         GSEwNrDDRFTUAWoo9gWEQJWUZSjbSlJeoQXybZbBLIacP3fX5TtmY8mWr0c0bIJGR7ih
         1uXPjqvhs/4/aa7gI09D3SaT2I5WgU24WiXa785kiVD6LL2WkKLQxZMI0eLmQtdVafXg
         vj9n5PYat3/tqO69KuMsD72t3z64ux2fWqXjzEPmE5UebiurJLKeNNCc+L//pCaS2zFx
         gqCw==
X-Gm-Message-State: AOAM5315iG1Wm0Rm6M4BxHOt3kbIK3ne9pZkXK3ECqfweaKRhmjVkOff
        dclA6L8pyNfX24uKSuscPa6KRINEM26FM4Hg6rYqjyIfWxFXaeMsOgsZRliZZPA4VWUhGVNB9VV
        ZOh8RPGEDgr08TNVz298ntX8kuCL5thuCKoinFdzcUXuS4jb/0GrxGy3ZfmkkXjhUud3+wAtjOr
        IW65F8ZMYc3B4=
X-Google-Smtp-Source: ABdhPJwR8IjR6IJYKEoDobiaoVVdpAU8wQ0FuawTF2iforRlGpmpZEsrNN+D5KM4B360tw55wDzifAZKYCJllPjuwA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a05:6214:29c7:: with SMTP id
 gh7mr4919513qvb.36.1627561742016; Thu, 29 Jul 2021 05:29:02 -0700 (PDT)
Date:   Thu, 29 Jul 2021 20:27:50 +0800
In-Reply-To: <20210729122751.3728885-1-howardchung@google.com>
Message-Id: <20210729202648.Bluez.v6.12.Ib26c0abdbd417673a8b5788c175c06110726a68c@changeid>
Mime-Version: 1.0
References: <20210729122751.3728885-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v6 12/13] plugins/admin: persist policy settings
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

 plugins/admin.c | 169 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 2 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 653195a0e20b..8e6549ea8020 100644
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
@@ -161,6 +166,8 @@ static void update_device_affected(void *data, void *user_data)
 			ADMIN_POLICY_STATUS_INTERFACE, "AffectedByPolicy");
 }
 
+static void store_policy_settings(struct btd_admin_policy *admin_policy);
+
 static DBusMessage *set_service_allowlist(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -179,7 +186,9 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 	}
 
-	if (!service_allowlist_set(admin_policy, uuid_list)) {
+	if (service_allowlist_set(admin_policy, uuid_list)) {
+		store_policy_settings(admin_policy);
+	} else {
 		free_service_allowlist(uuid_list);
 		return btd_error_failed(msg, "service_allowlist_set failed");
 	}
@@ -200,7 +209,7 @@ static const GDBusMethodTable admin_policy_adapter_methods[] = {
 	{ }
 };
 
-void append_service_uuid(void *data, void *user_data)
+static void append_service_uuid(void *data, void *user_data)
 {
 	bt_uuid_t *uuid = data;
 	DBusMessageIter *entry = user_data;
@@ -237,6 +246,161 @@ static const GDBusPropertyTable admin_policy_adapter_properties[] = {
 	{ }
 };
 
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
 static bool device_data_match(const void *a, const void *b)
 {
 	const struct device_data *data = a;
@@ -305,6 +469,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	if (!policy_data)
 		return -ENOMEM;
 
+	load_policy_settings(policy_data);
 	adapter_path = adapter_get_path(adapter);
 
 	if (!g_dbus_register_interface(dbus_conn, adapter_path,
-- 
2.32.0.554.ge1b32706d8-goog

