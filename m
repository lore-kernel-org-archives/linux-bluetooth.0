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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8518AC63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B02E60551
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhGVGn6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhGVGnx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:43:53 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5CC06179F
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:24:02 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o11-20020a17090ad24bb02901760a3c63a2so3602791pjw.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YqqvcKvjKRDjV+myUI56V8EaBEFO8mDpVdLV0MfyQso=;
        b=HfIO3WSIx+EaW4e+rtrkZIRwcise1UBZA72KB80MGRv4SzmbLYFnc6ZRJV6gEDyJkL
         fNJbeIRdC0CkvZWhReNpAwetzik+YaCYHYsh+lni7IzGaIaRZlza3U0oh10Wo8lGGej6
         nfXKixlujoxB3+woMtDaumi/4IsiaJHGXKRE9H4x8a+yM9r09Fb0ieAhzctjpGX8toyX
         5FDwgp0czAW0Q6E1wWwgfJcOtNSlfG7lQNMNdewX6/P50q/m/2Je0G30/z1R1CPFQUjX
         JdeHYd38nVximE3W1RBn7AXOGGTcJdz+vvIT0bgke7SU5uxhM28YBZIDwxVY+YV1guoi
         M5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YqqvcKvjKRDjV+myUI56V8EaBEFO8mDpVdLV0MfyQso=;
        b=Py2MAT8XVknOxqMFvMtWrdS8GF3wRuL52q3FJYYkdoiwj80u4AW/P9xTDXQtqPzWs6
         WKBvbZaqg4codIwaAjwFCjkBowhbseXSIMl0WXduRWBeSM3XOLhfT1bjGe5FmCv10n7b
         R1DdFpCMVNVWIg+uKHNR/Svw+cnlzrwbWOeIGhjpsuJT6TMvMUiS+9ZUqYOUm3GljTy7
         bQLXerHLxVwMvipspmKhZn97WquHO9iWYIsps9VzWTS8kuJSL5D5tJIdESdXLNIgzObD
         jxk22hJjowfI9ygqhkWYqhCRfxbDGgfQiOZc6/4SsxWqftKhnvBO2LGT89YEoV8ccKbU
         7w5g==
X-Gm-Message-State: AOAM5318R8IMR97CoTWdYlcq5RzkoheuRkVPs48kHD7TTMCDcNANbIfh
        kQcQ0OCG/Qay0NNMh+zqAhbuXcI9lUoz4vzZc2blWLXS/XdBFkosQDjvjJeYBEV7MnZCOmrc87c
        MTAos4TZz72MeohZ1Cr/olGrvjqnuQ7m+tPXtPrQQwHvC9E/UIZAvGMW0GnII/5kXGSZF0oLxQg
        GokeF6ERZvINs=
X-Google-Smtp-Source: ABdhPJzGsHR0TK+23onShcUmyQ6LNDz9L15QXBOGuyPWo5lsCrU0pjxIwbJNZwf2vqkJhdm92RzWVkNoQzJ8pKcTqw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:69a3:595f:8267:f7e0])
 (user=howardchung job=sendgmr) by 2002:a17:903:189:b029:12b:3fd7:d95d with
 SMTP id z9-20020a1709030189b029012b3fd7d95dmr30633812plg.24.1626938642393;
 Thu, 22 Jul 2021 00:24:02 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:23:20 +0800
In-Reply-To: <20210722072321.1225119-1-howardchung@google.com>
Message-Id: <20210722152159.Bluez.v2.10.Ib26c0abdbd417673a8b5788c175c06110726a68c@changeid>
Mime-Version: 1.0
References: <20210722072321.1225119-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [Bluez PATCH v2 10/11] plugins/admin_policy: persist policy settings
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

 plugins/admin_policy.c | 163 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 1 deletion(-)

diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index 3ce72b56b529..3a55d97b3b4d 100644
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
2.32.0.402.g57bb445576-goog

