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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD0EC63798
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D86261355
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhGVGn7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhGVGnv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:43:51 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC426C061798
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:51 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id p10-20020a17090a428ab0290175556801d5so3814021pjg.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H7qAJRqdqyfxprqmam5PyjQtsjrQGuynANBGFDFSws0=;
        b=hySnIV0nCtrp0H8HJ1UhmP+xVCooWVARg8fXjU4WQLg4nKIpAPLmk5AgVe3XmAuWVB
         6oQEVw4z+TpJYzIXP1vhGQsgEEuZmkXo+8A/boFJrOFLAvttUaNS0tmZluoojOk4aSkm
         9L57dnxQb0KRipZJfVcQErtdROCjRM5EkMfVRwi/swpdYVfyt/EF7Yyx2DnGfeSt4Vtd
         O1Sxi1YRV5kQGmHhp05mYcHBCeDwMFy+eNoc30tWsgWjq+vKMFcGELBD4KW6/AReamYx
         vTWZd8H4fLrU7Ne+13FvPn0u+1jIfLpEFFwKTECJQcvvsukIIG0JcjCV2Ab1DoUgheVF
         UrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H7qAJRqdqyfxprqmam5PyjQtsjrQGuynANBGFDFSws0=;
        b=WCzU37VdDjcUzHhSjbqSQ3zj5G1nk/+0jEf9yY0HToiWyX0qvYOJiOePj682rn30XC
         iiQYs0vSQKOxtUNrYKHWuQy+cJV8hmHTsq0g2ZlGtQp/1wAGJ2av2MAA9cr1dJj2znB6
         1oaoId04cw5qbBdFL5rmsmQBuMreH21k6B07Kbvl9+Gc2hvPfDe2DBU1bRhIMyFdNB+s
         fj0Cf/jQTTPtwTcKJruNFJZa6POhelzEXIXYObf+q3EvKO3yvxmBCqM0Ml7rZe2fgn7c
         nE/yhJjS7kP2jqiBTW9K3udFHg6TR5n4Ojj59f4MAbRJDmS+SBODLaG2RliIAoo/x5zh
         QwCg==
X-Gm-Message-State: AOAM531+yNkHSaj2cj4NlXqVjP1YPrFu54jYnrW0f8FfP487g8bXUFVy
        QvpsEzxWt/W2AO5Efeimu2ZeX9uOC1z1Bw8miRV1xEOBDzbztwCiSNTrQ2PXX1+6O6mFhue+9b7
        Aux1Bt4wpLGAhDJgPVOIQuSLO0MrSsFgW1Sh0cf0hk8JoWpYOI39eu/kiYa6bKhqRfn7JXnPVJh
        m7Yhmdap1xp+E=
X-Google-Smtp-Source: ABdhPJwSFz39VQ+t+5Q1HrcLWXFa7vwnrqsomIsx0HY7L4LQD0fXColD4gxOBwZIgQkG9eiX0nhn0OSTPaKn+Xtl4Q==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:69a3:595f:8267:f7e0])
 (user=howardchung job=sendgmr) by 2002:a62:ab0a:0:b029:33b:6d08:2a45 with
 SMTP id p10-20020a62ab0a0000b029033b6d082a45mr27788651pff.38.1626938631178;
 Thu, 22 Jul 2021 00:23:51 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:23:17 +0800
In-Reply-To: <20210722072321.1225119-1-howardchung@google.com>
Message-Id: <20210722152159.Bluez.v2.7.I00fd6c348e4c93501de6de0eae0d23436fd3895b@changeid>
Mime-Version: 1.0
References: <20210722072321.1225119-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [Bluez PATCH v2 07/11] plugins/admin_policy: add ServiceAllowList property
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

 plugins/admin_policy.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index 242b8d5dacb0..270d42366cd6 100644
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
2.32.0.402.g57bb445576-goog

