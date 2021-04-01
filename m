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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523AAC43462
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2250961056
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhDAK2H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhDAK1u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:50 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7D5C061794
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Apr 2021 03:25:28 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id s16so3070759qvw.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Apr 2021 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sZxMhDh4PtQpDZAAlBmJ6imAFzM4bpWjjnSVavxASeE=;
        b=kcIAz15S1VRQY3Lv9eXJo3MkYSLniXTN9YNh2jw8Nq2SVVPoE2BxWZV12eUeVj3brz
         IVxSJfnq2ijne/JjOVl25Eku2xKcskrwNLBoFkailYuBg0uMYdewL5UZ9j+TgS/7WNdD
         RrxzS1faUSdcZLJlMsiFLFGNg0keWj6XcxJJbd/6RwkwFR3D3eVVJ8oRqeE2A3rkc2aF
         IuikG/Gif9IvaRZ4iX5OcyR9kWtUSfQKH90PkY8XOmQEr8JBERh6fXu+2fbQZRo3652P
         ZvFvVHlNbikMgjv1OGnYnOD9M8BOyGPR6Xw3+8UCZWBB8cBvClTzcc47SWlwswU+0zDb
         PgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sZxMhDh4PtQpDZAAlBmJ6imAFzM4bpWjjnSVavxASeE=;
        b=IMH01XnI0O0rEOskBALlnK3TEziC36Emga1XRTiZ1kDzF4EKZUN/CaHDrnIyHLW7J0
         TLJ0piyl/m7d6CzZEmuTowBfOTgGnjjSb+DtmQeR4jBNR9MyGiqJ3FVWDSLhFh3X547T
         VhXUH9r6D7rEDiMUTwHMzzGCOSmFe1Nq7NQJuIzh1xs0IcshQ+v6C3dsh9YwDWmDwSOd
         49R6GMLfHPeL7VYtxxs+LBSOWw7KhV2I4pTqh78luH4N3rTaoJ3q+83VggbQCgYhOEXu
         PfCShL39Uf9/Q3gcFmp1DPPysBiOWzdLEb0J6Mz8T6PMz2u+BVzDOlgItDvKI4VbpexI
         u5ow==
X-Gm-Message-State: AOAM530SKsyoSheJM+eSkG3a6jw8doUeL1xwNbZK5pIUjUfaVWBaNYVJ
        uPgQ6SwrwAbONE55lGXJ8QUKIXY9uV793paYbMrFmZO9aW9crtU0ZE3bA+5xh17q2uUt0JvZynb
        +d3onCdmRlA78vB/4fcXlUNLT0SeqijzvI4l/ydN0u4kGVi3cNq4UHdE/jPPX38W/CdvLT0nPKA
        RD62exW/uTB+A=
X-Google-Smtp-Source: ABdhPJzOI4B3faUyBrBSHshRchUlDa18ID+9UH1s7P+fDKeYB/xpP7bN9nFFdnbErV3aaanbxnGfKO+V4AuGPEpLdQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ad88:abe:9fd5:a5fc])
 (user=howardchung job=sendgmr) by 2002:ad4:5429:: with SMTP id
 g9mr7586296qvt.39.1617272727647; Thu, 01 Apr 2021 03:25:27 -0700 (PDT)
Date:   Thu,  1 Apr 2021 18:24:42 +0800
In-Reply-To: <20210401102447.3958224-1-howardchung@google.com>
Message-Id: <20210401182328.Bluez.3.Id809d31b709b20f4977977fb92d49db2d4a62067@changeid>
Mime-Version: 1.0
References: <20210401102447.3958224-1-howardchung@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Bluez PATCH 3/8] core: add AdminPolicy Interface
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a new interface org.bluez.AdminPolicy for Administrator
to have better control on Bluetooth behaviors.

This patch also adds a method SetServiceAllowlist under AdminPolicy
to only allow incoming and outgoing connections to the service in the
allowlist for all of the clients.

For existing connections, bluez will send disconnect request to all of
them in case some of them are not allowed by the policy.

For outgoing connections, services not in the allowlist would be removed
from its pending list when trying to connect.

For incoming connections, profiles not in the allowlist would be
unregistered when policy is set and would be re-registered when policy
is relaxed.

For GATT profiles, if it is a system defined profile, e.g. HoG, we
disallow the connection if any of its mandatory service is not in the
allowlist. Since each profile defines different mandatory
services, we'll handle it profile by profile in the future patches.
If this is not a system defined profile, we only accept its service
connection if it is in allowlist.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 Makefile.am        |   3 +-
 src/adapter.c      |  45 ++++++++-
 src/adapter.h      |   4 +
 src/admin_policy.c | 240 +++++++++++++++++++++++++++++++++++++++++++++
 src/admin_policy.h |  23 +++++
 src/device.c       |  51 +++++++++-
 src/device.h       |   1 +
 src/profile.c      |  39 ++++++++
 src/profile.h      |   5 +
 src/service.c      |  21 ++++
 src/service.h      |   1 +
 11 files changed, 428 insertions(+), 5 deletions(-)
 create mode 100644 src/admin_policy.c
 create mode 100644 src/admin_policy.h

diff --git a/Makefile.am b/Makefile.am
index 7fce2e7c04ad..5a2b65783591 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -297,7 +297,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/dbus-common.c src/dbus-common.h \
 			src/eir.h src/eir.c \
 			src/adv_monitor.h src/adv_monitor.c \
-			src/battery.h src/battery.c
+			src/battery.h src/battery.c \
+			src/admin_policy.h src/admin_policy.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			src/libshared-glib.la \
diff --git a/src/adapter.c b/src/adapter.c
index 2fa06b73c240..5531ed0e2246 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -66,6 +66,7 @@
 #include "gatt-database.h"
 #include "advertising.h"
 #include "adv_monitor.h"
+#include "admin_policy.h"
 #include "eir.h"
 #include "battery.h"
 
@@ -260,6 +261,8 @@ struct btd_adapter {
 
 	struct btd_battery_provider_manager *battery_provider_manager;
 
+	struct btd_admin_policy *admin_policy;
+
 	gboolean initialized;
 
 	GSList *pin_callbacks;
@@ -3480,6 +3483,32 @@ static DBusMessage *connect_device(DBusConnection *conn,
 	return NULL;
 }
 
+static void disconnect_device(gpointer data, gpointer user_data)
+{
+	struct btd_device *device = data;
+
+	if (btd_device_is_connected(device))
+		device_request_disconnect(device, NULL);
+}
+
+void btd_adapter_disconnect_all_devices(struct btd_adapter *adapter)
+{
+	g_slist_foreach(adapter->connections, disconnect_device, NULL);
+}
+
+static void update_device_is_blocked_by_policy(void *data, void *user_data)
+{
+	struct btd_device *device = data;
+
+	btd_device_update_is_blocked_by_policy(device);
+}
+
+void btd_adapter_refresh_is_blocked_by_policy(struct btd_adapter *adapter)
+{
+	g_slist_foreach(adapter->devices, update_device_is_blocked_by_policy,
+									NULL);
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
 	{ GDBUS_METHOD("SetDiscoveryFilter",
@@ -4688,7 +4717,7 @@ static void probe_profile(struct btd_profile *profile, void *data)
 	struct btd_adapter *adapter = data;
 	int err;
 
-	if (profile->adapter_probe == NULL)
+	if (profile->adapter_probe == NULL || profile->is_blocked_by_policy)
 		return;
 
 	err = profile->adapter_probe(profile, adapter);
@@ -6372,6 +6401,9 @@ static void adapter_remove(struct btd_adapter *adapter)
 	btd_battery_provider_manager_destroy(adapter->battery_provider_manager);
 	adapter->battery_provider_manager = NULL;
 
+	btd_admin_policy_destroy(adapter->admin_policy);
+	adapter->admin_policy = NULL;
+
 	g_slist_free(adapter->pin_callbacks);
 	adapter->pin_callbacks = NULL;
 
@@ -6873,6 +6905,14 @@ struct agent *adapter_get_agent(struct btd_adapter *adapter)
 	return agent_get(NULL);
 }
 
+bool btd_adapter_uuid_is_allowed(struct btd_adapter *adapter, const char *uuid)
+{
+	if (!adapter || !adapter->admin_policy)
+		return true;
+
+	return btd_admin_policy_uuid_is_allowed(adapter->admin_policy, uuid);
+}
+
 static void adapter_remove_connection(struct btd_adapter *adapter,
 						struct btd_device *device,
 						uint8_t bdaddr_type)
@@ -8660,6 +8700,9 @@ static int adapter_register(struct btd_adapter *adapter)
 		agent_unref(agent);
 	}
 
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)
+		adapter->admin_policy = btd_admin_policy_create(adapter);
+
 	/* Don't start GATT database and advertising managers on
 	 * non-LE controllers.
 	 */
diff --git a/src/adapter.h b/src/adapter.h
index 60b5e3bcca34..8e8c61b7bdf1 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -97,6 +97,8 @@ void adapter_service_remove(struct btd_adapter *adapter, uint32_t handle);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
 
+bool btd_adapter_uuid_is_allowed(struct btd_adapter *adapter, const char *uuid);
+
 struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
 void btd_adapter_unref(struct btd_adapter *adapter);
 
@@ -240,3 +242,5 @@ enum kernel_features {
 };
 
 bool btd_has_kernel_features(uint32_t feature);
+void btd_adapter_disconnect_all_devices(struct btd_adapter *adapter);
+void btd_adapter_refresh_is_blocked_by_policy(struct btd_adapter *adapter);
diff --git a/src/admin_policy.c b/src/admin_policy.c
new file mode 100644
index 000000000000..eeae2722cc0a
--- /dev/null
+++ b/src/admin_policy.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2021 Google LLC
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+#include <gdbus/gdbus.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+
+#include "adapter.h"
+#include "dbus-common.h"
+#include "log.h"
+#include "metrics.h"
+#include "src/error.h"
+
+#include "admin_policy.h"
+#include "profile.h"
+
+#define ADMIN_POLICY_INTERFACE		"org.bluez.AdminPolicy1"
+
+struct btd_admin_policy {
+	struct btd_adapter *adapter;
+	uint16_t adapter_id;
+	GHashTable *allowed_uuid_set;	/* Set of allowed service uuids*/
+};
+
+static GHashTable *uuid_set_create(void)
+{
+	return g_hash_table_new_full(bt_uuid_hash, bt_uuid_equal, g_free, NULL);
+}
+
+static bool parse_allow_service_list(struct btd_adapter *adapter,
+					GHashTable **uuids,
+					DBusMessage *msg)
+{
+	DBusMessageIter iter, arriter;
+
+	dbus_message_iter_init(msg, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	*uuids = uuid_set_create();
+
+	if (!*uuids) {
+		error("Failed to create UUID allowed set");
+		return false;
+	}
+
+	dbus_message_iter_recurse(&iter, &arriter);
+	do {
+		const int type = dbus_message_iter_get_arg_type(&arriter);
+		char *uuid_param;
+		bt_uuid_t *uuid;
+
+		if (type == DBUS_TYPE_INVALID)
+			break;
+
+		if (type != DBUS_TYPE_STRING)
+			goto failed;
+
+		dbus_message_iter_get_basic(&arriter, &uuid_param);
+		uuid = g_try_malloc(sizeof(*uuid));
+
+		if (!uuid)
+			goto failed;
+
+		if (bt_string_to_uuid(uuid, uuid_param)) {
+			g_free(uuid);
+			goto failed;
+		}
+
+		g_hash_table_add(*uuids, uuid);
+		dbus_message_iter_next(&arriter);
+	} while (true);
+
+	return true;
+
+failed:
+	g_hash_table_destroy(*uuids);
+	*uuids = NULL;
+	return false;
+}
+
+GHashTable *btd_admin_policy_allowlist_get(
+					struct btd_admin_policy *admin_policy)
+{
+	return admin_policy ? admin_policy->allowed_uuid_set : NULL;
+}
+
+void btd_admin_policy_allowlist_set(struct btd_admin_policy *admin_policy,
+							GHashTable *uuids)
+{
+	if (!admin_policy)
+		return;
+
+	admin_policy->allowed_uuid_set = uuids;
+
+	/* This would add/remove profiles to the adapter according to the new
+	 * policy.
+	 */
+	btd_profile_policy_update(admin_policy->adapter);
+
+	/* Update auto-connect status to all devices */
+	btd_adapter_refresh_is_blocked_by_policy(admin_policy->adapter);
+}
+
+static DBusMessage *set_service_allowlist(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_admin_policy *admin_policy = user_data;
+	struct btd_adapter *adapter = admin_policy->adapter;
+	GHashTable *uuid_set;
+	const char *sender = dbus_message_get_sender(msg);
+	bool connectable;
+
+	DBG("sender %s", sender);
+
+	/* Parse parameters */
+	if (!parse_allow_service_list(adapter, &uuid_set, msg)) {
+		btd_error(admin_policy->adapter_id,
+				"Failed on parsing allowed service list");
+		return btd_error_invalid_args(msg);
+	}
+
+	/* Diconnect all the existing connections in case some of them are not
+	 * allowed to use.
+	 */
+	btd_adapter_disconnect_all_devices(adapter);
+
+	/* Clear existing allowlist */
+	g_hash_table_destroy(admin_policy->allowed_uuid_set);
+
+	btd_admin_policy_allowlist_set(admin_policy, uuid_set);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable admin_policy_methods[] = {
+	{ GDBUS_EXPERIMENTAL_METHOD("SetServiceAllowList",
+					GDBUS_ARGS({ "UUIDs", "as" }),
+					NULL, set_service_allowlist) },
+	{ }
+};
+
+bool btd_admin_policy_uuid_is_allowed(struct btd_admin_policy *admin_policy,
+							const char *uuid_str)
+{
+	bt_uuid_t uuid;
+
+	if (!admin_policy)
+		return true;
+
+	if (bt_string_to_uuid(&uuid, uuid_str)) {
+		DBG("Failed to parse UUID string '%s'", uuid_str);
+		return false;
+	}
+
+	return !g_hash_table_size(admin_policy->allowed_uuid_set) ||
+		g_hash_table_contains(admin_policy->allowed_uuid_set, &uuid);
+}
+
+static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
+{
+	struct btd_admin_policy *admin_policy;
+
+	admin_policy = g_try_malloc(sizeof(*admin_policy));
+
+	if (!admin_policy) {
+		error("Failed to allocate memory for admin_policy");
+		return NULL;
+	}
+
+	admin_policy->adapter = adapter;
+	admin_policy->adapter_id = btd_adapter_get_index(adapter);
+	admin_policy->allowed_uuid_set = uuid_set_create();
+
+	if (!admin_policy->allowed_uuid_set) {
+		error("Failed to create UUID allowed set");
+		g_free(admin_policy);
+		return NULL;
+	}
+
+	return admin_policy;
+}
+
+struct btd_admin_policy *btd_admin_policy_create(struct btd_adapter *adapter)
+{
+	struct btd_admin_policy *admin_policy;
+
+	admin_policy = admin_policy_new(adapter);
+	if (!admin_policy)
+		return NULL;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					adapter_get_path(admin_policy->adapter),
+					ADMIN_POLICY_INTERFACE,
+					admin_policy_methods, NULL, NULL,
+					admin_policy, NULL)) {
+		btd_error(admin_policy->adapter_id,
+				"Failed to register "
+				ADMIN_POLICY_INTERFACE);
+		g_free(admin_policy);
+		return NULL;
+	}
+
+	DBG("register interface success!");
+	return admin_policy;
+}
+
+void btd_admin_policy_destroy(struct btd_admin_policy *admin_policy)
+{
+	if (!admin_policy)
+		return;
+
+	btd_info(admin_policy->adapter_id, "Destroy Admin Policy");
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					adapter_get_path(admin_policy->adapter),
+					ADMIN_POLICY_INTERFACE);
+	g_hash_table_destroy(admin_policy->allowed_uuid_set);
+	g_free(admin_policy);
+}
diff --git a/src/admin_policy.h b/src/admin_policy.h
new file mode 100644
index 000000000000..5cb97f7ec81e
--- /dev/null
+++ b/src/admin_policy.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2021  Google LLC
+ *
+ *
+ */
+
+#include <glib.h>
+
+struct btd_adapter;
+struct btd_admin_policy;
+
+struct btd_admin_policy *btd_admin_policy_create(struct btd_adapter *adapter);
+void btd_admin_policy_destroy(struct btd_admin_policy *admin_policy);
+GHashTable *btd_admin_policy_allowlist_get(
+					struct btd_admin_policy *admin_policy);
+void btd_admin_policy_allowlist_set(struct btd_admin_policy *admin_policy,
+							GHashTable *uuids);
+bool btd_admin_policy_uuid_is_allowed(struct btd_admin_policy *admin_policy,
+							const char *uuid_str);
diff --git a/src/device.c b/src/device.c
index 7a6f7643afec..2192346d5f8d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1929,16 +1929,51 @@ static int service_prio_cmp(gconstpointer a, gconstpointer b)
 	return p2->priority - p1->priority;
 }
 
+void btd_device_update_is_blocked_by_policy(struct btd_device *dev)
+{
+	struct btd_adapter *adapter = dev->adapter;
+	struct btd_service *service;
+	struct btd_profile *profile;
+	GSList *l;
+	bool auto_connect = false;
+
+	/* If service discover is ongoing, let the service discover complete
+	 * callback call this function.
+	 */
+	if (dev->browse)
+		return;
+
+	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
+		service = l->data;
+		profile = btd_service_get_profile(service);
+
+		if (!profile->auto_connect)
+			continue;
+
+		if (profile->accept &&
+			!btd_service_is_blocked_by_policy(service))
+			auto_connect = true;
+	}
+
+	if (!dev->disable_auto_connect)
+		device_set_auto_connect(dev, auto_connect);
+}
+
 static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 {
 	struct btd_service *service;
 	struct btd_profile *p;
 	GSList *l;
+	bool is_blocked;
 
 	if (uuid) {
 		service = find_connectable_service(dev, uuid);
-		if (service)
+		is_blocked = !btd_adapter_uuid_is_allowed(dev->adapter,	uuid);
+
+		if (service && !is_blocked)
 			return g_slist_prepend(dev->pending, service);
+		else if (is_blocked)
+			info("service %s is blocked by policy", uuid);
 
 		return dev->pending;
 	}
@@ -1946,10 +1981,17 @@ static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
 		service = l->data;
 		p = btd_service_get_profile(service);
+		is_blocked = !btd_adapter_uuid_is_allowed(dev->adapter,
+								p->remote_uuid);
 
 		if (!p->auto_connect)
 			continue;
 
+		if (is_blocked) {
+			info("service %s is blocked by policy", p->remote_uuid);
+			continue;
+		}
+
 		if (g_slist_find(dev->pending, service))
 			continue;
 
@@ -2633,6 +2675,8 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 							dev->svc_callbacks);
 		g_free(cb);
 	}
+
+	btd_device_update_is_blocked_by_policy(dev);
 }
 
 static struct bonding_req *bonding_request_new(DBusMessage *msg,
@@ -4627,9 +4671,10 @@ static struct btd_service *probe_service(struct btd_device *device,
 	}
 
 	/* Only set auto connect if profile has set the flag and can really
-	 * accept connections.
+	 * accept connections and is not blocked by policy.
 	 */
-	if (profile->auto_connect && profile->accept)
+	if (profile->auto_connect && profile->accept &&
+				!btd_service_is_blocked_by_policy(service))
 		device_set_auto_connect(device, TRUE);
 
 	return service;
diff --git a/src/device.h b/src/device.h
index 4ae9abe0dbb4..3ca4f2c56566 100644
--- a/src/device.h
+++ b/src/device.h
@@ -175,5 +175,6 @@ uint32_t btd_device_get_current_flags(struct btd_device *dev);
 void btd_device_flags_changed(struct btd_device *dev, uint32_t supported_flags,
 			      uint32_t current_flags);
 
+void btd_device_update_is_blocked_by_policy(struct btd_device *dev);
 void btd_device_init(void);
 void btd_device_cleanup(void);
diff --git a/src/profile.c b/src/profile.c
index 5e460b639c19..ae21a079a4e3 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -2559,6 +2559,45 @@ bool btd_profile_remove_custom_prop(const char *uuid, const char *name)
 	return false;
 }
 
+static void update_profile_policy(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	bool is_blocked;
+
+	is_blocked = !btd_adapter_uuid_is_allowed(adapter, p->remote_uuid);
+
+	if (!is_blocked && p->is_blocked_by_policy) {
+		p->is_blocked_by_policy = false;
+		adapter_add_profile(adapter, p);
+
+		info("service %s is allowed by policy", p->remote_uuid);
+
+	} else if (is_blocked && !p->is_blocked_by_policy) {
+		p->is_blocked_by_policy = true;
+		adapter_remove_profile(adapter, p);
+
+		info("service %s is blocked by policy", p->remote_uuid);
+	}
+}
+
+void btd_profile_policy_update(struct btd_adapter *adapter)
+{
+	GSList *l;
+
+	for (l = profiles; l; l = l->next) {
+		struct btd_profile *p = l->data;
+
+		update_profile_policy(p, adapter);
+	}
+
+	for (l = ext_profiles; l; l = l->next) {
+		struct ext_profile *ext_p = l->data;
+		struct btd_profile *p = &ext_p->p;
+
+		update_profile_policy(p, adapter);
+	}
+}
+
 void btd_profile_init(void)
 {
 	g_dbus_register_interface(btd_get_dbus_connection(),
diff --git a/src/profile.h b/src/profile.h
index 6827f848148c..ddd4c94ec943 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -28,6 +28,8 @@ struct btd_profile {
 	 */
 	bool external;
 
+	bool is_blocked_by_policy;
+
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
 
@@ -40,6 +42,8 @@ struct btd_profile {
 						struct btd_adapter *adapter);
 	void (*adapter_remove) (struct btd_profile *p,
 						struct btd_adapter *adapter);
+
+	bool (*mandatory_services_are_allowed)(struct btd_service *service);
 };
 
 void btd_profile_foreach(void (*func)(struct btd_profile *p, void *data),
@@ -63,6 +67,7 @@ bool btd_profile_add_custom_prop(const char *uuid, const char *type,
 					btd_profile_prop_get get,
 					void *user_data);
 bool btd_profile_remove_custom_prop(const char *uuid, const char *name);
+void btd_profile_policy_update(struct btd_adapter *adapter);
 
 void btd_profile_init(void);
 void btd_profile_cleanup(void);
diff --git a/src/service.c b/src/service.c
index 21a52762e637..75e71549ae41 100644
--- a/src/service.c
+++ b/src/service.c
@@ -166,6 +166,20 @@ void service_remove(struct btd_service *service)
 	btd_service_unref(service);
 }
 
+bool btd_service_is_blocked_by_policy(struct btd_service *service)
+{
+	struct btd_adapter *adapter;
+
+	if (!service->profile->mandatory_services_are_allowed) {
+		adapter = device_get_adapter(service->device);
+
+		return !btd_adapter_uuid_is_allowed(adapter,
+						service->profile->remote_uuid);
+	}
+
+	return !service->profile->mandatory_services_are_allowed(service);
+}
+
 int service_accept(struct btd_service *service)
 {
 	char addr[18];
@@ -186,6 +200,13 @@ int service_accept(struct btd_service *service)
 	if (!service->profile->accept)
 		return -ENOSYS;
 
+	if (btd_service_is_blocked_by_policy(service)) {
+		info("service %s is blocked by policy",
+						service->profile->remote_uuid);
+
+		return -ECONNABORTED;
+	}
+
 	err = service->profile->accept(service);
 	if (!err)
 		goto done;
diff --git a/src/service.h b/src/service.h
index 88530cc17d53..e2960164fb17 100644
--- a/src/service.h
+++ b/src/service.h
@@ -35,6 +35,7 @@ struct btd_service *service_create(struct btd_device *device,
 int service_probe(struct btd_service *service);
 void service_remove(struct btd_service *service);
 
+bool btd_service_is_blocked_by_policy(struct btd_service *service);
 int service_accept(struct btd_service *service);
 int service_set_connecting(struct btd_service *service);
 
-- 
2.31.0.291.g576ba9dcdaf-goog

