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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB46C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2CD61C59
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhGHG0U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGHG0U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:20 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4566C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:23:38 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id h7-20020a0ceda70000b02902af042354f1so3315714qvr.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6P+E9E5SrdjwSPVgTtZ9bRRLdrfkNgtqlsaUuV2ebuw=;
        b=ZA0/5Lv3Va8CCAr7cssEfRj4SefClAh1vzwpEj0dHFsorE/OYVptQ/rPbIN5nlC67i
         kXyLEWTSoxXW5UIhRy5c7lkiuZ/OcJhUpeAI6duVb5JAdUGZ5qJ1HUGt1WSo70nptPpZ
         HYwgP7Bmqeypt8QF/FgajBKXbNwu1OtbAp49U64tKzRvADnOy2GXsdWQf7hNUiqwxyeK
         tHmaRAd2CTm1kDDBxa+H7R0fR+zG0WgT4noDfKxDjfAWtbrYFg96cYXlovAPKAVC2Cae
         2oY/zrVsFMzzNEKgso4nAdjKQhCEjS4YFr0E73r9bQG1gEzFWXIBEtx78WOmUAlu9Vj1
         53hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6P+E9E5SrdjwSPVgTtZ9bRRLdrfkNgtqlsaUuV2ebuw=;
        b=VyBtuKyD1IgnMAEsHBB8Vr/0MQpJPnmMLP8WX9nWKN7KhKXJ+dyIr9ChBOYIGOsgqE
         o+EhkMtYw8fE9Odu4N7yVZl3GAlHczB5K9pLBrRpi3fk7lXQOEnPJVvdjEEhdSXTSqdW
         0LGWaaFHLKMEQocB25+bpz36CS4aEe4FBzjmd3WxrXfbEQwNxk/O2jUCSUA6An5Ldg+x
         XdhqOQmavN66zz4PyaSeMZzKikgboj6D4APp5xBK4Tm31qObJ0Wk5pM9SZSqFDtalOhv
         4kWeGxepc7wO9LjgpyWGyv1elfhA8prikKNAe9SVXWP15EjWP/q6nEcB/Utn4CqZY/4v
         IWCA==
X-Gm-Message-State: AOAM533XOzNUgP49OazKSAfV6wvOQAWRcsB0x92+GP4M3uZEBUpKuQwB
        qdfTSeevRzG3t+yE/k2kEpxaDPTKqQoMTZdbdHIrccHPtezgIkFWJFhEf+tKfHFmrP/Xfgs1/y1
        NQwn6daAgOSNGBoATGXyVnzQUgcayb43bV2ETqnUQCbrEXWpfUhjlr7GepqhwSQalI3tRhXA1lD
        p/zrMB1vESuoM=
X-Google-Smtp-Source: ABdhPJztHK6A2LChZvQqrP8oRRMQsdtz6czxqEh61yM+6Iw5001pI7rYy49VJF2zWV0dmdZ1Kr8zaaz3fAToDUgSNg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a0c:a321:: with SMTP id
 u30mr20911139qvu.57.1625725418048; Wed, 07 Jul 2021 23:23:38 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:04 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.4.Ibc0b5f02cb249f9aca9efe45e2dadc5e50b7d89e@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 04/14] core: add adapter and device allowed_uuid functions
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This implements functions in src/adapter.c and src/device.c for
plugins setting a list of allowed services.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 src/adapter.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |  8 +++++
 src/device.c  | 59 ++++++++++++++++++++++++++++++++-
 src/device.h  |  2 ++
 4 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 84bc5a1b09eb..f75b8acf1ffb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -260,6 +260,8 @@ struct btd_adapter {
 
 	struct btd_battery_provider_manager *battery_provider_manager;
 
+	GHashTable *allowed_uuid_set;	/* Set of allowed service UUIDs */
+
 	gboolean initialized;
 
 	GSList *pin_callbacks;
@@ -3480,6 +3482,87 @@ static DBusMessage *connect_device(DBusConnection *conn,
 	return NULL;
 }
 
+static void update_adapter_profile(struct btd_profile *profile, void *data)
+{
+	struct btd_adapter *adapter = data;
+	bool is_allowed;
+
+	is_allowed = btd_adapter_is_uuid_allowed(adapter, profile->remote_uuid);
+
+	if (is_allowed && !g_slist_find(adapter->profiles, profile)) {
+		adapter_add_profile(adapter, profile);
+
+		info("service %s is allowed", profile->remote_uuid);
+
+	} else if (!is_allowed && g_slist_find(adapter->profiles, profile)) {
+		adapter_remove_profile(adapter, profile);
+
+		info("service %s is blocked", profile->remote_uuid);
+	}
+}
+
+static void update_device_allowed_services(void *data, void *user_data)
+{
+	struct btd_device *device = data;
+
+	btd_device_update_allowed_services(device);
+}
+
+static void add_uuid_to_uuid_set(void *data, void *user_data)
+{
+	bt_uuid_t *uuid = data;
+	GHashTable *uuid_set = user_data;
+
+	if (!uuid) {
+		error("Found NULL in UUID allowed list");
+		return;
+	}
+
+	g_hash_table_add(uuid_set, uuid);
+}
+
+bool btd_adapter_set_allowed_uuids(struct btd_adapter *adapter,
+							struct queue *uuids)
+{
+	if (!adapter)
+		return false;
+
+	if (adapter->allowed_uuid_set)
+		g_hash_table_destroy(adapter->allowed_uuid_set);
+
+	adapter->allowed_uuid_set = g_hash_table_new(bt_uuid_hash,
+								bt_uuid_equal);
+	if (!adapter->allowed_uuid_set) {
+		btd_error(adapter->dev_id,
+					"Failed to allocate allowed_uuid_set");
+		return false;
+	}
+
+	queue_foreach(uuids, add_uuid_to_uuid_set, adapter->allowed_uuid_set);
+	btd_profile_foreach(update_adapter_profile, adapter);
+	g_slist_foreach(adapter->devices, update_device_allowed_services, NULL);
+
+	return true;
+}
+
+bool btd_adapter_is_uuid_allowed(struct btd_adapter *adapter,
+							const char *uuid_str)
+{
+	bt_uuid_t uuid;
+
+	if (!adapter || !adapter->allowed_uuid_set)
+		return true;
+
+	if (bt_string_to_uuid(&uuid, uuid_str)) {
+		btd_error(adapter->dev_id,
+				"Failed to parse UUID string '%s'", uuid_str);
+		return false;
+	}
+
+	return !g_hash_table_size(adapter->allowed_uuid_set) ||
+		g_hash_table_contains(adapter->allowed_uuid_set, &uuid);
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
 	{ GDBUS_METHOD("SetDiscoveryFilter",
@@ -4691,6 +4774,12 @@ static void probe_profile(struct btd_profile *profile, void *data)
 	if (profile->adapter_probe == NULL)
 		return;
 
+	if (!btd_adapter_is_uuid_allowed(adapter, profile->remote_uuid)) {
+		info("service %s is not allowed to probe",
+							profile->remote_uuid);
+		return;
+	}
+
 	err = profile->adapter_probe(profile, adapter);
 	if (err < 0) {
 		btd_error(adapter->dev_id, "%s: %s (%d)", profile->name,
@@ -5395,6 +5484,7 @@ static void adapter_free(gpointer user_data)
 	g_free(adapter->stored_alias);
 	g_free(adapter->current_alias);
 	free(adapter->modalias);
+	g_hash_table_destroy(adapter->allowed_uuid_set);
 	g_free(adapter);
 }
 
diff --git a/src/adapter.h b/src/adapter.h
index 60b5e3bcca34..7cac51451249 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -25,6 +25,7 @@
 
 struct btd_adapter;
 struct btd_device;
+struct queue;
 
 struct btd_adapter *btd_adapter_get_default(void);
 bool btd_adapter_is_default(struct btd_adapter *adapter);
@@ -97,6 +98,8 @@ void adapter_service_remove(struct btd_adapter *adapter, uint32_t handle);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
 
+bool btd_adapter_uuid_is_allowed(struct btd_adapter *adapter, const char *uuid);
+
 struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
 void btd_adapter_unref(struct btd_adapter *adapter);
 
@@ -240,3 +243,8 @@ enum kernel_features {
 };
 
 bool btd_has_kernel_features(uint32_t feature);
+
+bool btd_adapter_set_allowed_uuids(struct btd_adapter *adapter,
+							struct queue *uuids);
+bool btd_adapter_is_uuid_allowed(struct btd_adapter *adapter,
+							const char *uuid_str);
diff --git a/src/device.c b/src/device.c
index faf07ba22270..e1d82eab0988 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1929,6 +1929,51 @@ static int service_prio_cmp(gconstpointer a, gconstpointer b)
 	return p2->priority - p1->priority;
 }
 
+bool btd_device_all_services_allowed(struct btd_device *dev)
+{
+	GSList *l;
+	struct btd_adapter *adapter = dev->adapter;
+	char *uuid;
+
+	for (l = dev->uuids; l != NULL; l = g_slist_next(l)) {
+		uuid = l->data;
+
+		if (!btd_adapter_is_uuid_allowed(adapter, uuid))
+			return false;
+	}
+
+	return true;
+}
+
+void btd_device_update_allowed_services(struct btd_device *dev)
+{
+	struct btd_adapter *adapter = dev->adapter;
+	struct btd_service *service;
+	struct btd_profile *profile;
+	GSList *l;
+	bool is_allowed;
+	char addr[18];
+
+	/* If service discovery is ongoing, let the service discovery complete
+	 * callback call this function.
+	 */
+	if (dev->browse) {
+		ba2str(&dev->bdaddr, addr);
+		DBG("service discovery of %s is ongoing. Skip updating allowed "
+							"services", addr);
+		return;
+	}
+
+	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
+		service = l->data;
+		profile = btd_service_get_profile(service);
+
+		is_allowed = btd_adapter_is_uuid_allowed(adapter,
+							profile->remote_uuid);
+		btd_service_set_allowed(service, is_allowed);
+	}
+}
+
 static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 {
 	struct btd_service *service;
@@ -1937,9 +1982,14 @@ static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 
 	if (uuid) {
 		service = find_connectable_service(dev, uuid);
-		if (service)
+
+		if (!service)
+			return dev->pending;
+
+		if (btd_service_is_allowed(service))
 			return g_slist_prepend(dev->pending, service);
 
+		info("service %s is blocked", uuid);
 		return dev->pending;
 	}
 
@@ -1950,6 +2000,11 @@ static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 		if (!p->auto_connect)
 			continue;
 
+		if (!btd_service_is_allowed(service)) {
+			info("service %s is blocked", p->remote_uuid);
+			continue;
+		}
+
 		if (g_slist_find(dev->pending, service))
 			continue;
 
@@ -2633,6 +2688,8 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 							dev->svc_callbacks);
 		g_free(cb);
 	}
+
+	btd_device_update_allowed_services(dev);
 }
 
 static struct bonding_req *bonding_request_new(DBusMessage *msg,
diff --git a/src/device.h b/src/device.h
index 4ae9abe0dbb4..5f615cb4b6b2 100644
--- a/src/device.h
+++ b/src/device.h
@@ -175,5 +175,7 @@ uint32_t btd_device_get_current_flags(struct btd_device *dev);
 void btd_device_flags_changed(struct btd_device *dev, uint32_t supported_flags,
 			      uint32_t current_flags);
 
+bool btd_device_all_services_allowed(struct btd_device *dev);
+void btd_device_update_allowed_services(struct btd_device *dev);
 void btd_device_init(void);
 void btd_device_cleanup(void);
-- 
2.32.0.93.g670b81a890-goog

