Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-27.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DAEC07E99
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0857261C69
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhGHG0m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhGHG0m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:42 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC30C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:24:00 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f3-20020a6310030000b029022c3e789d78so196352pgl.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=diaiaBahWKD4SU9ie43Sk9OFBSaieqno3X9F2q/9zjo=;
        b=A4zk4KGWtXo2YVQ7ePib6VRMEY2sQKaPfnYg/6PMuo4viF+ydJUYiO6QppNx/9wOQH
         3dkFVdIfYIEVHDF5I+wDyRNKohYMYO/wwaILRZD1J/HjuC3wwmbaGBw0knrgDMbWmjT5
         3nmPt14uJbz61Udb7xUkPKgeuTDo+nonpqBrjaL9HK0MQvrjFPNJE7JxYX++CuA2MMl2
         rQjHT/NmXSZNf03s6W1+mrb0RyvnAQFvedJcIivCiKuqn2sm4faK7eOZDtmAvRvJww11
         U0fD20Nyq/+Qrfno2RLDsxVwIUA4DKZdt3+6J1XEY8wXmoiBbHjR/1X06kGHS8l5Uo2Z
         Gk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=diaiaBahWKD4SU9ie43Sk9OFBSaieqno3X9F2q/9zjo=;
        b=U0SziEXeaTR3C9GCATaU9KTvZENysjQt/G9WQrToB79Tb6t7XvcZJFv9qb9ybd27WJ
         TPmUQ3ccHYRby+wACYQ5mmJY1pWqr0xkaE7jhZAgvi1BKRZoCmSWcPKNd4KOnnWk8NoV
         NWvT7xbawMx6CYYfftaXqeStQzF8ovlRmTKxoidMcgRwJCoBHfotA7LSjTrlm1d9KttQ
         MTqyc3LHnsfUZhEWDBYJi9oEuoAgOGr4NUZKy8Yha87LHI4iM0dwHP2ADIfBNPUlLc1z
         lc+onil7osWQyYfWgSj70vCXZUDT7cPZy1PZVlAtoZ3D0BZ6anCZr0nKb8WY/8Cfi9Nt
         btNg==
X-Gm-Message-State: AOAM531suHE8oreM/BRnmMkoZIFRyMgD94SKlqpYMUltsHwuKpvjC7wF
        mNK93zcMeEhCPXYy6Y67S8TGkOb93mXJXMRV5dqW31ihA+wVY7RmZmi2cxtmX1UG5bB54UYvHfN
        fAUM/cMfUg5366YyD0Lbb8Kr+WPd5+m8Jhi2ScrQ0R9Qmm0dTZaurxElJUeLY2dKiR1oGCMRTbs
        b+vliHzu3nQ5s=
X-Google-Smtp-Source: ABdhPJyu3+mBL9U5pUveaIRBsk2SKUITaonEAL6Ix+hS87YJTF7CIaVqZN9zb7iOaBi9mnDMPyb/D6qT1zxdHWrhUA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a17:902:7e4d:b029:129:8fd3:b30f with
 SMTP id a13-20020a1709027e4db02901298fd3b30fmr16174810pln.85.1625725439655;
 Wed, 07 Jul 2021 23:23:59 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:10 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.10.I00fd6c348e4c93501de6de0eae0d23436fd3895b@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 10/14] plugins/admin_policy: add ServiceAllowList property
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

 plugins/admin_policy.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index 242b8d5dacb0..c5ad31f761d9 100644
--- a/plugins/admin_policy.c
+++ b/plugins/admin_policy.c
@@ -27,6 +27,7 @@
 #include "src/shared/queue.h"
 
 #define ADMIN_POLICY_SET_INTERFACE	"org.bluez.AdminPolicySet1"
+#define ADMIN_POLICY_STATUS_INTERFACE	"org.bluez.AdminPolicyStatus1"
 
 static DBusConnection *dbus_conn;
 
@@ -151,6 +152,10 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 		return btd_error_failed(msg, "service_allowlist_set failed");
 	}
 
+	g_dbus_emit_property_changed(dbus_conn,
+				adapter_get_path(policy_data->adapter),
+				ADMIN_POLICY_SET_INTERFACE, "ServiceAllowList");
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -160,6 +165,43 @@ static const GDBusMethodTable admin_policy_adapter_methods[] = {
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
@@ -185,6 +227,21 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 
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
2.32.0.93.g670b81a890-goog

