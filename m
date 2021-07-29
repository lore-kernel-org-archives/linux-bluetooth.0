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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB5BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0EA61074
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhG2I5M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhG2I5L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 04:57:11 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA933C061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:08 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x12-20020a05620a14acb02903b8f9d28c19so3356947qkj.23
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lcgnPP5ww4lJRDXdTTx6Q4PYdYcLCGwV1/+vXOgA96w=;
        b=ix3d58KqOhMm19KW3TZ4/Y4h9T70xgIRXAdJbtUORaLNoo10cAVYEZdEQtd9A3LXLz
         UoDVKbk8Eo/HlsepzHpXIX8QA7HyYeksYAI7Lt1gMuSeD9IA2nrUVrqWyHvShmIpMcuY
         rL78PBaaJ0Nlajc78XYR99QdgXy/IS6foWq6FlDRD2XTA51BgNH3oGmd2R/1OcqCdVPV
         3kWV+C9pwSc79Bs+WDg0uFlCahsmn3/+BOpW+pvdneLB65JP7x7AGyQbeLXb00ji4NXe
         ZFJayEOXG7ZXO5BsnCSG/NTy/VaVoi2wOLLVpmG4kVEb+Mu9W/hv0FDcuranwlq8Q50f
         S3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lcgnPP5ww4lJRDXdTTx6Q4PYdYcLCGwV1/+vXOgA96w=;
        b=CLYpUU84pWiYF9/D6J7l9yiYBBih5UqiR+qDN10WyKyrCopjTOM8ZY7+eIFrAr77MF
         YRpl/CXcEXwxX6em9c4kYn4O+E6YPN4Cnn0upYnBYWPu1heUeRJxhMghaklLc2V1Hl1E
         A7hD6Q5ecjIow5pvp6nQlFAXT/ETSMuGx4VWJgpPV2HD+Nuv7lYAQi7XopNHuvlCPPO3
         ukTFF6WnZmGDfCrbU4OTTPPlCPKabQxjlbzpvrYXD9wr+WoUcG9L//a+tOz/cL8Tn2VO
         oaVte/LpP1WvLM6MBc2Fl50krNeqTii+NLqi+6upwFjljsAHFRG5vDKt6+mwdCn5q/RE
         nIfA==
X-Gm-Message-State: AOAM5306zWMWbWwsGn6w7iGPkZ0Vp+vXQfzDNNXga769PjY5G0lmcd2O
        0Va3yLZAOKq854Q2sSWovnFBMPXESTo3RC72N1GtXRWzBhcOwoj1q5FBdwLfRZR9z4+zApy8GRl
        +nAknLvD8ksCsrLr1lX/toa+hDkNCnhz13zTrGretrl4A3I+od+tRJV3vmGGr9s/itZX4iKNnZk
        oicGWyUP3ykmk=
X-Google-Smtp-Source: ABdhPJyWydZvEbE9HAPCgxpMeGMHXq6SlXflwlw69xlKOr/qdDlazgebiSBtbw5otn/hBLOH9gR+MaIriZBGjiWwlg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a0c:d644:: with SMTP id
 e4mr4177747qvj.45.1627549027948; Thu, 29 Jul 2021 01:57:07 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:56:40 +0800
In-Reply-To: <20210729085651.3600926-1-howardchung@google.com>
Message-Id: <20210729165211.Bluez.v5.2.Ibc0b5f02cb249f9aca9efe45e2dadc5e50b7d89e@changeid>
Mime-Version: 1.0
References: <20210729085651.3600926-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v5 02/13] core: add adapter and device allowed_uuid functions
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

(no changes since v1)

 src/adapter.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |  8 +++++
 src/device.c  | 64 +++++++++++++++++++++++++++++++++++-
 src/device.h  |  2 ++
 4 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 663b778e4a5d..c7fe27d19a5d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -260,6 +260,8 @@ struct btd_adapter {
 
 	struct btd_battery_provider_manager *battery_provider_manager;
 
+	GHashTable *allowed_uuid_set;	/* Set of allowed service UUIDs */
+
 	gboolean initialized;
 
 	GSList *pin_callbacks;
@@ -3489,6 +3491,93 @@ static DBusMessage *connect_device(DBusConnection *conn,
 	return NULL;
 }
 
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
+static guint bt_uuid_hash(gconstpointer key)
+{
+	const bt_uuid_t *uuid = key;
+	bt_uuid_t uuid_128;
+	uint64_t *val;
+
+	if (!uuid)
+		return 0;
+
+	bt_uuid_to_uuid128(uuid, &uuid_128);
+	val = (uint64_t *)&uuid_128.value.u128;
+
+	return g_int64_hash(val) ^ g_int64_hash(val+1);
+}
+
+static gboolean bt_uuid_equal(gconstpointer v1, gconstpointer v2)
+{
+	const bt_uuid_t *uuid1 = v1;
+	const bt_uuid_t *uuid2 = v2;
+
+	if (!uuid1 || !uuid2)
+		return !uuid1 && !uuid2;
+
+	return bt_uuid_cmp(uuid1, uuid2) == 0;
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
@@ -5404,6 +5493,7 @@ static void adapter_free(gpointer user_data)
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
index b29aa195d19b..c4a4497da01f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1929,6 +1929,56 @@ static int service_prio_cmp(gconstpointer a, gconstpointer b)
 	return p2->priority - p1->priority;
 }
 
+bool btd_device_all_services_allowed(struct btd_device *dev)
+{
+	GSList *l;
+	struct btd_adapter *adapter = dev->adapter;
+	struct btd_service *service;
+	struct btd_profile *profile;
+
+	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
+		service = l->data;
+		profile = btd_service_get_profile(service);
+
+		if (!profile || !profile->auto_connect)
+			continue;
+
+		if (!btd_adapter_is_uuid_allowed(adapter, profile->remote_uuid))
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
@@ -1937,9 +1987,14 @@ static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 
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
 
@@ -1950,6 +2005,11 @@ static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 		if (!p->auto_connect)
 			continue;
 
+		if (!btd_service_is_allowed(service)) {
+			info("service %s is blocked", p->remote_uuid);
+			continue;
+		}
+
 		if (g_slist_find(dev->pending, service))
 			continue;
 
@@ -2633,6 +2693,8 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
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
2.32.0.554.ge1b32706d8-goog

