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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B71C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F7E60295
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhG1NQY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhG1NQX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:16:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4131DC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c63-20020a25e5420000b0290580b26e708aso2784824ybh.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EZHXHeW6QUwWIBUrI08wm0jQYSXNMjXwILb0+Abndl8=;
        b=M98rCl1OPcSkbJ1gJwDM2jIrlV0KgJU5jdQOawnB7XBXjiRrVUQ0SfIgdap6V+nr2n
         6MtaCeKLBe1jXxJvCXZirBfLTN87BVJKL8um79l5fxP0RCwe5zJO+BIykRHwbJkVAn7H
         GQCd35t1pATuQWp9+rA3Ypr/d+jnBTcruPTtY94mdgiUIGTRo4Gq2DwrPUOoGV2eqsim
         o5V7qU4WjD/d4pkHxpMm3R6ozFvlHu6jupYoUVQNv18GrMpVzZGuXMLaTEFvTxt0NHxk
         SGnAe++l7YBotDNrvr8dM5ilhc7/7aFK9JVHRM7ISfxcxihdhd6t4dgocdi/2Ba/1Ikk
         f++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EZHXHeW6QUwWIBUrI08wm0jQYSXNMjXwILb0+Abndl8=;
        b=N67Gk8dVr/UtupfgfJpkAlkv8JJkw/M6Ej9fDMfsL8ufpFNy+47CP4d9e8VC8614yi
         A4BFrXi7VdZyne5LvFd8aNUxSmNV+Lm1u2QbecL4fRGIErtk4Bc1P1qhRLZtM8YrJDMf
         SYHXCeUSwx0ztvBpuQ7pti/x2d0dgo65aGElIsC7O+SRcSsGI8EIVNKzrkKPrY/bwW3Y
         JrSHuHNPXEqPNlPb6+s70tTpIaiTDZ5Px8HPI8N9L5ViVzB3XYFNB0tquwNFXjQMPHkL
         xSoJ8pBYCJXu+dP2p00w3GXMD8Fn3hwgGy4M9BzlnSaK2lVTtR+whUrV8a8thJlTmlb9
         sVYw==
X-Gm-Message-State: AOAM530bpbCvXz01/239vFaiidP9BpWeoFhlQm7noPtMu9sv3lhahcFX
        9a8U05wmDX9MknYPfWtWc7mVwnZdC7ba5gmCzC6R4gHeZMb5Jo7XvD3L8q8ClahcRm6OwHFEkHY
        proosdpHXBli5+Z8CCkcSbtgv4ScDQSRm/WvgPB3Ho2sfHRYKabqaZIZfe77+fIRtv6d8xp5rPR
        hmOYWLsgiUL7E=
X-Google-Smtp-Source: ABdhPJxL5O/jVlLNyzwo6c30ziYA3j7F1YNqijnuS9JYVn1/dX+imBxlFLWX+tpJRrvJIzgMaq4KkdjW5asmMcp/kw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a5b:286:: with SMTP id
 x6mr3100471ybl.59.1627478180440; Wed, 28 Jul 2021 06:16:20 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:24 +0800
In-Reply-To: <20210728131529.3310558-1-howardchung@google.com>
Message-Id: <20210728211405.Bluez.v3.8.Ifbb69dd6e371da3a914049a94615064479b9024b@changeid>
Mime-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 08/13] plugins/admin_policy: add ServiceAllowList method
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds code to register interface org.bluez.AdminPolicySet1.
The interface will provide methods to limit users to operate certain
functions of bluez, such as allow/disallow user to taggle adapter power,
or only allow users to connect services in the specified list, etc.

This patch also implements ServiceAllowlist in
org.bluez.AdminPolicySet1.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
The following test steps were performed:
1. Set ServiceAllowList to
   ["1108","110A","110B","110C","110D","110E",
   "110F","1112","111E","111F","1203"]
   ( users are only allowed to connect headset )
2. Turn on paired WF1000XM3, and listen music on Youtube.
3. Turn on paired K830 (LE device), press any key on keyboard.
4. Turn on paired Samsung Bluetooth Keyboard EE-BT550 (BREDR device),
   press any key on keyboard.
5. Set ServiceAllowList to
   ["1124","180A","180F","1812"]
   ( users are only allowed to connect HID devices )
6. Turn on paired WF1000XM3, and listen music on Youtube.
7. Turn on paired K830 (LE device), press any key on keyboard.
8. Turn on paired Samsung Bluetooth Keyboard EE-BT550 (BREDR device),
   press any key on keyboard.
9. Set ServiceAllowList to []
   ( users are only allowed to connect any device. )
10. Turn on paired WF1000XM3, and listen music on Youtube.
11. Turn on paired K830 (LE device), press any key on keyboard.
12. Turn on paired Samsung Bluetooth Keyboard EE-BT550 (BREDR device),
   press any key on keyboard.

Expected results:
Step 2,7,8,9,10,11 should success, and step 3,4,6 should fail.

(no changes since v1)

 plugins/admin.c        | 127 ++++++++++++++++++++++++++++++++++++++++-
 plugins/admin_policy.c | 123 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 248 insertions(+), 2 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 923e08cb8..1fe2904d9 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -12,19 +12,29 @@
 #include <config.h>
 #endif
 
+#include <dbus/dbus.h>
+#include <gdbus/gdbus.h>
+
 #include "lib/bluetooth.h"
+#include "lib/uuid.h"
 
 #include "src/adapter.h"
+#include "src/dbus-common.h"
 #include "src/error.h"
 #include "src/log.h"
 #include "src/plugin.h"
 
 #include "src/shared/queue.h"
 
+#define ADMIN_POLICY_SET_INTERFACE	"org.bluez.AdminPolicySet1"
+
+static DBusConnection *dbus_conn;
+
 /* |policy_data| has the same life cycle as btd_adapter */
 static struct btd_admin_policy {
 	struct btd_adapter *adapter;
 	uint16_t adapter_id;
+	struct queue *service_allowlist;
 } *policy_data = NULL;
 
 static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
@@ -40,19 +50,120 @@ static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
 
 	admin_policy->adapter = adapter;
 	admin_policy->adapter_id = btd_adapter_get_index(adapter);
+	admin_policy->service_allowlist = NULL;
 
 	return admin_policy;
 }
 
+static void free_service_allowlist(struct queue *q)
+{
+	queue_destroy(q, g_free);
+}
+
 static void admin_policy_free(void *data)
 {
 	struct btd_admin_policy *admin_policy = data;
 
+	free_service_allowlist(admin_policy->service_allowlist);
 	g_free(admin_policy);
 }
 
+static struct queue *parse_allow_service_list(struct btd_adapter *adapter,
+							DBusMessage *msg)
+{
+	DBusMessageIter iter, arr_iter;
+	struct queue *uuid_list = NULL;
+
+	dbus_message_iter_init(msg, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return NULL;
+
+	uuid_list = queue_new();
+	dbus_message_iter_recurse(&iter, &arr_iter);
+	do {
+		const int type = dbus_message_iter_get_arg_type(&arr_iter);
+		char *uuid_param;
+		bt_uuid_t *uuid;
+
+		if (type == DBUS_TYPE_INVALID)
+			break;
+
+		if (type != DBUS_TYPE_STRING)
+			goto failed;
+
+		dbus_message_iter_get_basic(&arr_iter, &uuid_param);
+
+		uuid = g_try_malloc(sizeof(*uuid));
+		if (!uuid)
+			goto failed;
+
+		if (bt_string_to_uuid(uuid, uuid_param)) {
+			g_free(uuid);
+			goto failed;
+		}
+
+		queue_push_head(uuid_list, uuid);
+
+		dbus_message_iter_next(&arr_iter);
+	} while (true);
+
+	return uuid_list;
+
+failed:
+	queue_destroy(uuid_list, g_free);
+	return NULL;
+}
+
+static bool service_allowlist_set(struct btd_admin_policy *admin_policy,
+							struct queue *uuid_list)
+{
+	struct btd_adapter *adapter = admin_policy->adapter;
+
+	if (!btd_adapter_set_allowed_uuids(adapter, uuid_list))
+		return false;
+
+	free_service_allowlist(admin_policy->service_allowlist);
+	admin_policy->service_allowlist = uuid_list;
+
+	return true;
+}
+
+static DBusMessage *set_service_allowlist(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_admin_policy *admin_policy = user_data;
+	struct btd_adapter *adapter = admin_policy->adapter;
+	struct queue *uuid_list = NULL;
+	const char *sender = dbus_message_get_sender(msg);
+
+	DBG("sender %s", sender);
+
+	/* Parse parameters */
+	uuid_list = parse_allow_service_list(adapter, msg);
+	if (!uuid_list) {
+		btd_error(admin_policy->adapter_id,
+				"Failed on parsing allowed service list");
+		return btd_error_invalid_args(msg);
+	}
+
+	if (!service_allowlist_set(admin_policy, uuid_list)) {
+		free_service_allowlist(uuid_list);
+		return btd_error_failed(msg, "service_allowlist_set failed");
+	}
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable admin_policy_adapter_methods[] = {
+	{ GDBUS_METHOD("SetServiceAllowList", GDBUS_ARGS({ "UUIDs", "as" }),
+						NULL, set_service_allowlist) },
+	{ }
+};
+
 static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 {
+	const char *adapter_path;
+
 	if (policy_data) {
 		btd_warn(policy_data->adapter_id,
 						"Policy data already exists");
@@ -64,8 +175,20 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	if (!policy_data)
 		return -ENOMEM;
 
-	btd_info(policy_data->adapter_id, "Admin Policy has been enabled");
+	adapter_path = adapter_get_path(adapter);
 
+	if (!g_dbus_register_interface(dbus_conn, adapter_path,
+					ADMIN_POLICY_SET_INTERFACE,
+					admin_policy_adapter_methods, NULL,
+					NULL, policy_data, admin_policy_free)) {
+		btd_error(policy_data->adapter_id,
+			"Admin Policy Set interface init failed on path %s",
+								adapter_path);
+		return -EINVAL;
+	}
+
+	btd_info(policy_data->adapter_id,
+				"Admin Policy Set interface registered");
 	return 0;
 }
 
@@ -79,6 +202,8 @@ static int admin_init(void)
 {
 	DBG("");
 
+	dbus_conn = btd_get_dbus_connection();
+
 	return btd_register_adapter_driver(&admin_policy_driver);
 }
 
diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index 2ece87156..242b8d5da 100644
--- a/plugins/admin_policy.c
+++ b/plugins/admin_policy.c
@@ -12,19 +12,29 @@
 #include <config.h>
 #endif
 
+#include <dbus/dbus.h>
+#include <gdbus/gdbus.h>
+
 #include "lib/bluetooth.h"
+#include "lib/uuid.h"
 
 #include "src/adapter.h"
+#include "src/dbus-common.h"
 #include "src/error.h"
 #include "src/log.h"
 #include "src/plugin.h"
 
 #include "src/shared/queue.h"
 
+#define ADMIN_POLICY_SET_INTERFACE	"org.bluez.AdminPolicySet1"
+
+static DBusConnection *dbus_conn;
+
 /* |policy_data| has the same life cycle as btd_adapter */
 static struct btd_admin_policy {
 	struct btd_adapter *adapter;
 	uint16_t adapter_id;
+	struct queue *service_allowlist;
 } *policy_data = NULL;
 
 static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
@@ -40,17 +50,116 @@ static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
 
 	admin_policy->adapter = adapter;
 	admin_policy->adapter_id = btd_adapter_get_index(adapter);
+	admin_policy->service_allowlist = NULL;
 
 	return admin_policy;
 }
 
+static void free_service_allowlist(struct queue *q)
+{
+	queue_destroy(q, g_free);
+}
+
 static void admin_policy_free(void *data)
 {
 	struct btd_admin_policy *admin_policy = data;
 
+	free_service_allowlist(admin_policy->service_allowlist);
 	g_free(admin_policy);
 }
 
+static struct queue *parse_allow_service_list(struct btd_adapter *adapter,
+							DBusMessage *msg)
+{
+	DBusMessageIter iter, arr_iter;
+	struct queue *uuid_list = NULL;
+
+	dbus_message_iter_init(msg, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return NULL;
+
+	uuid_list = queue_new();
+	dbus_message_iter_recurse(&iter, &arr_iter);
+	do {
+		const int type = dbus_message_iter_get_arg_type(&arr_iter);
+		char *uuid_param;
+		bt_uuid_t *uuid;
+
+		if (type == DBUS_TYPE_INVALID)
+			break;
+
+		if (type != DBUS_TYPE_STRING)
+			goto failed;
+
+		dbus_message_iter_get_basic(&arr_iter, &uuid_param);
+
+		uuid = g_try_malloc(sizeof(*uuid));
+		if (!uuid)
+			goto failed;
+
+		if (bt_string_to_uuid(uuid, uuid_param)) {
+			g_free(uuid);
+			goto failed;
+		}
+
+		queue_push_head(uuid_list, uuid);
+
+		dbus_message_iter_next(&arr_iter);
+	} while (true);
+
+	return uuid_list;
+
+failed:
+	queue_destroy(uuid_list, g_free);
+	return NULL;
+}
+
+static bool service_allowlist_set(struct btd_admin_policy *admin_policy,
+							struct queue *uuid_list)
+{
+	struct btd_adapter *adapter = admin_policy->adapter;
+
+	if (!btd_adapter_set_allowed_uuids(adapter, uuid_list))
+		return false;
+
+	free_service_allowlist(admin_policy->service_allowlist);
+	admin_policy->service_allowlist = uuid_list;
+
+	return true;
+}
+
+static DBusMessage *set_service_allowlist(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_admin_policy *admin_policy = user_data;
+	struct btd_adapter *adapter = admin_policy->adapter;
+	struct queue *uuid_list = NULL;
+	const char *sender = dbus_message_get_sender(msg);
+
+	DBG("sender %s", sender);
+
+	/* Parse parameters */
+	uuid_list = parse_allow_service_list(adapter, msg);
+	if (!uuid_list) {
+		btd_error(admin_policy->adapter_id,
+				"Failed on parsing allowed service list");
+		return btd_error_invalid_args(msg);
+	}
+
+	if (!service_allowlist_set(admin_policy, uuid_list)) {
+		free_service_allowlist(uuid_list);
+		return btd_error_failed(msg, "service_allowlist_set failed");
+	}
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable admin_policy_adapter_methods[] = {
+	{ GDBUS_METHOD("SetServiceAllowList", GDBUS_ARGS({ "UUIDs", "as" }),
+						NULL, set_service_allowlist) },
+	{ }
+};
+
 static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 {
 	if (policy_data) {
@@ -64,8 +173,18 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	if (!policy_data)
 		return -ENOMEM;
 
-	btd_info(policy_data->adapter_id, "Admin Policy has been enabled");
+	if (!g_dbus_register_interface(dbus_conn, adapter_get_path(adapter),
+					ADMIN_POLICY_SET_INTERFACE,
+					admin_policy_adapter_methods, NULL,
+					NULL, policy_data, admin_policy_free)) {
+		btd_error(policy_data->adapter_id,
+			"Admin Policy Set interface init failed on path %s",
+						adapter_get_path(adapter));
+		return -EINVAL;
+	}
 
+	btd_info(policy_data->adapter_id,
+				"Admin Policy Set interface registered");
 	return 0;
 }
 
@@ -79,6 +198,8 @@ static int admin_policy_init(void)
 {
 	DBG("");
 
+	dbus_conn = btd_get_dbus_connection();
+
 	return btd_register_adapter_driver(&admin_policy_driver);
 }
 
-- 
2.32.0.432.gabb21c7263-goog

