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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2A8C4363F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4796112E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhDAK2N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbhDAK1w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD008C0617AA
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Apr 2021 03:25:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a19so5341983ybg.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Apr 2021 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MPWDjceOUyjW0spnVMJog1vfUjDskyKLBQb3CHEa5t0=;
        b=gITtlrMrA2el07ystbUzk4K1pWBWrOrgqh5OK1TaQ55PRHtdx0cJcEErk5uAtL7nLZ
         85GLCrJOUYglIPNZLKX6rVTJiFR8OvJZ1jTpYCAe6uSiNu62zu94pcRF1KXlVidHCa/P
         7hV1dAOcF8Kted63aNwyPsEAUZx/EAnitc3WUpMqyL1UUfJ4bIfSx2Amk139z5dm+Yrx
         qJvVMBkJVQeN0QEImjytsc8sOQvX3HTtZbxEisu225u95o1Jtv3/rI4odNi8gOMxl/Zg
         hSoYQfroEgrRszI/Wc2HROPlS9GUdItpf6Q41VqnGQyGILbbxsBbMBMj3sL6VDv3ANmQ
         A0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MPWDjceOUyjW0spnVMJog1vfUjDskyKLBQb3CHEa5t0=;
        b=QGB0cn2ovKPPiisFfaqgKzASw0/zu+clhrx45/4d2ZevAD/j06/qiKDn2Ct8uosORZ
         qwgbbAopimQu2khbj0WaiklH46hy3xZcjIY4VwxJW+3IhDW8psJPLX5EoKoZvR6R+/zU
         JHdgy6Zi7oQzqE7c4dIwrfPGbYGu+PJRiV4MZK5vcyFHwhZbxje+k6e+LyqamO4xty0R
         An+v6xjufiqAWPSlvIN4Ri/DoyMXfndWPS5X8lZCiT2cwetVigOqddM3GSu7j14ZDeut
         GWLz3HaGJBgPVwBa3BqxMIQfPKKSqBtCiTlRvdgp9lS/hqJOvzN3II5xvaoMU19R4wyN
         bBHw==
X-Gm-Message-State: AOAM530KMpQyWFUfYEAt7Rt0JvH9j8MZpt1cZ5jQ4vF6JuFYjyExZVXT
        qUzluAZBIiZCDZgL/FOqEXZq3csgdd62rDURzaz66GVuBsZjBqJSHrfCI+sOxi0oX9GtbfqXMaM
        DWiAl9808YreDJyWgATuTUNqIbjYgkvQp9Q/dFwO30GsgOzIWaBUT5h+rqZFVbxPymjL2vEcMXt
        eR0XEj/PZFj4M=
X-Google-Smtp-Source: ABdhPJyrNHtKm0+TxOeS3eZkgVMrtcEZMlDSPp1gvwPcJeSrAEy6AyOKV1uIOHpA76dz5qoVKgH7SL/I1suU1Skz6Q==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ad88:abe:9fd5:a5fc])
 (user=howardchung job=sendgmr) by 2002:a25:7bc2:: with SMTP id
 w185mr10907054ybc.255.1617272742942; Thu, 01 Apr 2021 03:25:42 -0700 (PDT)
Date:   Thu,  1 Apr 2021 18:24:46 +0800
In-Reply-To: <20210401102447.3958224-1-howardchung@google.com>
Message-Id: <20210401182328.Bluez.7.Ie9fee4e1b2bf0a661af4a4834cd73bf8438ca755@changeid>
Mime-Version: 1.0
References: <20210401102447.3958224-1-howardchung@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Bluez PATCH 7/8] core: store ServiceAllowList into settings
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements the logics of storing ServiceAllowList when the value
changed and restoring ServiceAllowList when adapter initialized.

The stored information would look like:
ServiceAllowList=$UUID128_STRING1;$UUID128_STRING2......

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 src/adapter.c      | 103 +++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h      |   1 +
 src/admin_policy.c |   1 +
 3 files changed, 105 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 5531ed0e2246..f03eda2abc17 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -473,13 +473,19 @@ uint8_t btd_adapter_get_address_type(struct btd_adapter *adapter)
 	return adapter->bdaddr_type;
 }
 
+static char **create_uuid_string_allowlist(GHashTable *allowed_uuid_set,
+							guint *num_of_uuid);
 static void store_adapter_info(struct btd_adapter *adapter)
 {
 	GKeyFile *key_file;
+	GHashTable *allowed_uuid_set;
 	char filename[PATH_MAX];
 	char *str;
 	gsize length = 0;
 	gboolean discoverable;
+	char **uuid_str_arr;
+	guint num_of_uuid = 0;
+	int i;
 
 	key_file = g_key_file_new();
 
@@ -508,15 +514,36 @@ static void store_adapter_info(struct btd_adapter *adapter)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings",
 					btd_adapter_get_storage_dir(adapter));
 
+	if (adapter->admin_policy) {
+		allowed_uuid_set = btd_admin_policy_allowlist_get(
+							adapter->admin_policy);
+		uuid_str_arr = create_uuid_string_allowlist(allowed_uuid_set,
+								&num_of_uuid);
+		g_key_file_set_string_list(key_file, "Policy",
+				"ServiceAllowList",
+				(const char *const*)uuid_str_arr, num_of_uuid);
+	}
 	create_file(filename, 0600);
 
+
 	str = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, str, length, NULL);
 	g_free(str);
 
+	for (i = 0; i < num_of_uuid; i++)
+		g_free(uuid_str_arr[i]);
+
+	g_free(uuid_str_arr);
+
 	g_key_file_free(key_file);
 }
 
+void btd_adapter_store_adapter_info(struct btd_adapter *adapter)
+{
+	if (adapter)
+		store_adapter_info(adapter);
+}
+
 static void trigger_pairable_timeout(struct btd_adapter *adapter);
 static void adapter_start(struct btd_adapter *adapter);
 static void adapter_stop(struct btd_adapter *adapter);
@@ -3509,6 +3536,32 @@ void btd_adapter_refresh_is_blocked_by_policy(struct btd_adapter *adapter)
 									NULL);
 }
 
+static char **create_uuid_string_allowlist(GHashTable *allowed_uuid_set,
+							guint *num_of_uuid)
+{
+	int i;
+	gpointer *uuids;
+	char **uuid_str_allowlist;
+	bt_uuid_t *uuid;
+
+	uuids = g_hash_table_get_keys_as_array(allowed_uuid_set, num_of_uuid);
+	uuid_str_allowlist = g_try_malloc_n(*num_of_uuid, sizeof(char *));
+
+	if (!uuid_str_allowlist && !num_of_uuid) {
+		error("Failed to allocate memory for uuid_str_allowlist");
+		return NULL;
+	}
+
+	for (i = 0; i < *num_of_uuid; i++) {
+		uuid = uuids[i];
+		uuid_str_allowlist[i] = g_try_malloc(MAX_LEN_UUID_STR);
+		bt_uuid_to_string(uuid, uuid_str_allowlist[i],
+							MAX_LEN_UUID_STR);
+	}
+
+	return uuid_str_allowlist;
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
 	{ GDBUS_METHOD("SetDiscoveryFilter",
@@ -6265,12 +6318,42 @@ static void fix_storage(struct btd_adapter *adapter)
 	textfile_del(filename, "converted");
 }
 
+static GHashTable *uuid_list_to_uuid_set(gchar **uuids, gsize num_of_uuid)
+{
+	int i;
+	bt_uuid_t *uuid;
+	GHashTable *uuid_set = g_hash_table_new_full(bt_uuid_hash,
+						bt_uuid_equal, g_free, NULL);
+
+	if (!uuid_set)
+		return NULL;
+
+	for (i = 0; i < num_of_uuid; i++) {
+		uuid = g_try_malloc(sizeof(*uuid));
+
+		if (!uuid || bt_string_to_uuid(uuid, *uuids))
+			goto failed;
+
+		g_hash_table_add(uuid_set, uuid);
+		uuids++;
+	}
+
+	return uuid_set;
+
+failed:
+	g_hash_table_destroy(uuid_set);
+	return NULL;
+}
+
 static void load_config(struct btd_adapter *adapter)
 {
 	GKeyFile *key_file;
 	char filename[PATH_MAX];
 	struct stat st;
+	GHashTable *uuid_set;
 	GError *gerr = NULL;
+	gchar **uuids = NULL;
+	gsize num_of_uuid;
 
 	key_file = g_key_file_new();
 
@@ -6320,6 +6403,23 @@ static void load_config(struct btd_adapter *adapter)
 		gerr = NULL;
 	}
 
+	if (adapter->admin_policy) {
+		uuids = g_key_file_get_string_list(key_file, "Policy",
+				"ServiceAllowList", &num_of_uuid, &gerr);
+
+		if (gerr) {
+			uuids = NULL;
+			num_of_uuid = 0;
+			g_error_free(gerr);
+			gerr = NULL;
+		}
+
+		uuid_set = uuid_list_to_uuid_set(uuids, num_of_uuid);
+		if (uuid_set)
+			btd_admin_policy_allowlist_set(adapter->admin_policy,
+								uuid_set);
+	}
+
 	g_key_file_free(key_file);
 }
 
@@ -8761,6 +8861,9 @@ load:
 	load_defaults(adapter);
 	load_devices(adapter);
 
+	/* Update IsBlockedByPolicy on devices */
+	g_slist_foreach(adapter->devices, update_device_is_blocked_by_policy,
+									NULL);
 	/* restore Service Changed CCC value for bonded devices */
 	btd_gatt_database_restore_svc_chng_ccc(adapter->database);
 
diff --git a/src/adapter.h b/src/adapter.h
index 8e8c61b7bdf1..038754b6d76c 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -90,6 +90,7 @@ const char *adapter_get_path(struct btd_adapter *adapter);
 const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter);
 uint8_t btd_adapter_get_address_type(struct btd_adapter *adapter);
 const char *btd_adapter_get_storage_dir(struct btd_adapter *adapter);
+void btd_adapter_store_adapter_info(struct btd_adapter *adapter);
 int adapter_set_name(struct btd_adapter *adapter, const char *name);
 
 int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec);
diff --git a/src/admin_policy.c b/src/admin_policy.c
index 6498dcf05319..0b51b379ed74 100644
--- a/src/admin_policy.c
+++ b/src/admin_policy.c
@@ -154,6 +154,7 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 	g_hash_table_destroy(admin_policy->allowed_uuid_set);
 
 	btd_admin_policy_allowlist_set(admin_policy, uuid_set);
+	btd_adapter_store_adapter_info(adapter);
 
 	return dbus_message_new_method_return(msg);
 }
-- 
2.31.0.291.g576ba9dcdaf-goog

