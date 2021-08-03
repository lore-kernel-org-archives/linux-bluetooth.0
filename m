Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DDDC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4941F60F48
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhHCIXr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhHCIXn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 04:23:43 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD2C0613D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 01:23:32 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m2-20020ac807c20000b0290269bd8044e1so12524928qth.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 01:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AODxBjZj+nI2kbzDyMsrX+mfmhxGjROcT4no+1E+pG8=;
        b=L8TooUadBrv/7SHYQjxaR8IHQJ9/DF+vHPCgawyyb86/ejHZzkYT/z56ilkT0MfNm0
         KBtyS62lQ5ivnTolLvVBpiHG1Qa94yub7/aU0NpjlGbSuNdwxi4HsXvi/lC38YSaUhaT
         3NB05Uq1xW2jo3IfuMYA+fBSCVfqUzltjcel0Mwak7NlWhLOWKUEIQZumZD3OHlINJ5c
         FMo67FUqimPHpAC1woV3nSw3/0o2Lsab69pg35mgJGFZhNEksQZvXf/880VQRdXJR6Q0
         dXKBklhzvWDvk9i/eML3g7/HwLOI1qZk/08Xs8YY7iI53ueTfpiSX0bvwI2mWNiGgQjF
         LuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AODxBjZj+nI2kbzDyMsrX+mfmhxGjROcT4no+1E+pG8=;
        b=bGrs4iGppY79Mr1i80S8nhEvomia3IpVqRVbvUBKrNFS6rkLbNMfWwNVU/JCulux4k
         MSiZ+gevb6SGQzlky54nHB8FrK2w52c/k3RD4RprbYQT82v5OT0BhiD+Teaedj9wAdum
         gAhoe/6I6yWxNWz4h6nBXtbcptvYFG8dXDi4LiYLdhbb65Lup+uBj5mPACnENoBPpkVp
         4a5ycL7kmASSQ6Xfi4dDRB7oAIWYBNDegOtBmX+9YUxHsLeQsPsQsJK5GedfBY5OR3rb
         fQ7gYCWWmUnXHxezC++lj9ObF3EpuaXTK3xp0DM2Ax9BU+0YlCide7L2ctSFSCw09qDJ
         emmg==
X-Gm-Message-State: AOAM533d19k+fPewuBAkokPbzc5Fn/lWsCSFvfixSMZBfn2IvbNS26DD
        UdsfZoE3TZ230vbHdvQUEI3h1qpRRbU73EC3L2uxdhinZwCwFmP8vDtbPlRDXbJMuh72faGhRLj
        rfFo9DZVFFh6gl4nHzOT9dFZ6a3iEkFQgxBCjbAAAc/w+0sXhL9u1M35x/yZ8zn+203F7kW1Vct
        Nzc9tmV6iBkiU=
X-Google-Smtp-Source: ABdhPJy3pISrAr5cr+trtFIeRp6Gsg9PeU7xOwD9vNoLvf6eFKK3LzKBBwqAwgiIlRb2hnYSyND0m3CF3J/yPPKksA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a05:6214:1c47:: with SMTP id
 if7mr20231558qvb.6.1627979011923; Tue, 03 Aug 2021 01:23:31 -0700 (PDT)
Date:   Tue,  3 Aug 2021 16:22:32 +0800
In-Reply-To: <20210803082237.723766-1-howardchung@google.com>
Message-Id: <20210803161319.Bluez.v8.8.I00fd6c348e4c93501de6de0eae0d23436fd3895b@changeid>
Mime-Version: 1.0
References: <20210803082237.723766-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v8 08/13] plugins/admin: add ServiceAllowList property
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

