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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48E9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5AC560ED4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhG2M2u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbhG2M2t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:28:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1F4C0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y125-20020a2532830000b029058328f1b02eso6274159yby.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AODxBjZj+nI2kbzDyMsrX+mfmhxGjROcT4no+1E+pG8=;
        b=VWH7CRADMPgCYd1eTlSVCX8i2l0tWTzRkZf2+fI2vxESqJzDqts/2fcQMnoN+Ofyb/
         T+VTAvfkSblu/w2XRbnz2ODHngKMnBng89H4rTiuIMOT495gdDS+OXeTvfYsS8b5EI39
         dtSgzjjOdlqYDg8VL1uhGcd4lyh9W54hH6VpWvE9ZBG0rs6yVkeR9VUNj6eVUEExHTR5
         sOVrSemndEWV6gsO/kuAGkuglNDh/UtnWAjLTQnOJAYmUsBT0GoMiPv1yRnMjib70kxZ
         +NSctUAHvwrydJDC0Gtp4YijqssWacx4vFEn8ajX93fjNLXihlZDGuJw4gFQz8/L31Sg
         DdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AODxBjZj+nI2kbzDyMsrX+mfmhxGjROcT4no+1E+pG8=;
        b=IOUTk05QCM5yJvQb5aHpLhv8QaDiMMr2esWbxbgraVYmfXr3BHX4FgvuCIl4e4LPkN
         uhO5TE/84GDOOV93FHNMRTzdBrf7m9EkhuhYiRmNl80qBZBvrJoKDHRqA6jeMhP4eGlY
         1mEgk6uvZyNPqgcSrSm8fd8+TwVYLLh22mwQYttzYobUDgByRU/lA1pajSSxSuKEkl2J
         Qrx5CcGRNCdhVQY+IsKp7was+h2rff/Hkfi8XJOS/AnTJeLiaW7C7UUjELivB6U3wxpb
         X1qyUjdURTxzt1E9wXyZnSWZh6DU4E/IgJAKh1GI/04/C3g6/T+2VskjIwqaedKA7hnS
         dxuQ==
X-Gm-Message-State: AOAM5327f0/rdri+PzoWUz/n0UbNiWQRO0mIA0O/CZ8BV46awLt1TQp1
        rwPyqnaPl2CZdi80EaOaa0jlAH7UD9v4YFd4erap49cV+PmXZYA8cIlzQLlGqGcpOTaYIxOK6R/
        9X5VAfubG4bjPwGusqcLDDclSSwdZ28qJGxkLyXVmxM2z0QIaefFeiMsE+nLuVfweTHtSaBLnNx
        Vl64QXiKguS7Q=
X-Google-Smtp-Source: ABdhPJyON0qHuGAaHBbBkaUfjz3hjN317Se+/JQlBpuB2ffEaJLn0R1zRCp60cKdqnbEez+zZIYp9XTN3VmJncLjUg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:e910:: with SMTP id
 n16mr6293632ybd.226.1627561725835; Thu, 29 Jul 2021 05:28:45 -0700 (PDT)
Date:   Thu, 29 Jul 2021 20:27:47 +0800
In-Reply-To: <20210729122751.3728885-1-howardchung@google.com>
Message-Id: <20210729202648.Bluez.v6.9.I00fd6c348e4c93501de6de0eae0d23436fd3895b@changeid>
Mime-Version: 1.0
References: <20210729122751.3728885-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v6 09/13] plugins/admin: add ServiceAllowList property
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

 plugins/admin.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/plugins/admin.c b/plugins/admin.c
index 1fe2904d93d9..d89a77c8a123 100644
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
 
-- 
2.32.0.554.ge1b32706d8-goog

