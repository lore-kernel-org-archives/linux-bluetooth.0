Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383B0C55ABD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3ACC221F1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ifSjF+LV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbgKKBSC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 20:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732427AbgKKBR7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 20:17:59 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F120C0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:17:59 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c66so529018pfa.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6ulbDU/qHtPa8uOGjOuIGnHeKT1XK2hEQHAcI9dgwY=;
        b=ifSjF+LV+rovtO6Zrg4u8oSXG7pSSw27TSQ+HzEhgITC3vDDpmDPz9eQ/eOnKl699u
         /ZhGcyiaMAuJ98UYHOKjNUgizmOMf4hwS8V6H9EPmwDutBLVCPSXeDfiruZFnpiwXfTl
         JjdqnJzSmekz0gnXOe1LnVoUnQhKa5q47T4sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6ulbDU/qHtPa8uOGjOuIGnHeKT1XK2hEQHAcI9dgwY=;
        b=OJfklHVRWQpqsrGv9FJ4ZH7oxgxUcLg8g0r2x6j5tKfsrHGcni5ANIJVC5F7GTBmds
         URq4Watmkrms5rU+PWMCEJGnp8ztyxYxK6SWlCmVMAIc2ZzeiYnBzHoVYTRvZctcHAkt
         k3RUSMRMwR73dsppdqP6X5FmTipDkzBYPnf6EkOf36YsUENCStZYamEe3hv83+hrbfjS
         Gotgf1JHSMvy8pZJzXEC6hpL+gN4fx2ZPiYzcMwRwVB2RedwpFjwxgFhPy1RH+ODapa6
         3L6yBj4SeFdwAPS7dUAo94HZsMLm0jkwGZsieZUBabvoGxYWMrc7vPzOdeJhX/YwmfxQ
         kBUw==
X-Gm-Message-State: AOAM532hxZCkiiaS+TL292lcPKEgiO6wIpMG6Jd8YhldYzxdPUpgGuNa
        AlGqZTZ9S8wPLfMQEfnODBCIIPUEJ1iVKQ==
X-Google-Smtp-Source: ABdhPJy0F9w6Fw1d6jCn+Zdtb9hpfH56sWiI5tuIkcepm37/j3JTiSRSiRuSEDuejiAlNK2e43637w==
X-Received: by 2002:a63:1e64:: with SMTP id p36mr19120266pgm.126.1605057478769;
        Tue, 10 Nov 2020 17:17:58 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y19sm331695pfn.147.2020.11.10.17.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 17:17:58 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
Date:   Tue, 10 Nov 2020 17:17:45 -0800
Message-Id: <20201111011745.2016-7-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111011745.2016-1-sonnysasaka@chromium.org>
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements the BatteryProvider1 and BatteryProviderManager1
API. This is a means for external clients to feed battery information to
BlueZ if they handle some profile and can decode battery reporting.

The battery information is then exposed externally via the existing
Battery1 interface. UI components can consume this API to display
Bluetooth peripherals' battery via a unified BlueZ API.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
 profiles/battery/battery.c |   2 +-
 src/adapter.c              |  11 ++
 src/battery.c              | 371 ++++++++++++++++++++++++++++++++++++-
 src/battery.h              |  10 +-
 4 files changed, 389 insertions(+), 5 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 2478816a4..81f849d57 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -127,7 +127,7 @@ static void batt_io_ccc_written_cb(uint16_t att_ecode, void *user_data)
 	}
 
 	batt->battery = btd_battery_register(device_get_path(batt->device),
-					     "GATT Battery Service");
+					     "GATT Battery Service", NULL);
 
 	if (!batt->battery) {
 		batt_reset(batt);
diff --git a/src/adapter.c b/src/adapter.c
index d27faaaa3..b791cdad2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -66,6 +66,7 @@
 #include "advertising.h"
 #include "adv_monitor.h"
 #include "eir.h"
+#include "battery.h"
 
 #define MODE_OFF		0x00
 #define MODE_CONNECTABLE	0x01
@@ -254,6 +255,8 @@ struct btd_adapter {
 
 	struct btd_adv_monitor_manager *adv_monitor_manager;
 
+	struct btd_battery_provider_manager *battery_provider_manager;
+
 	gboolean initialized;
 
 	GSList *pin_callbacks;
@@ -6361,6 +6364,9 @@ static void adapter_remove(struct btd_adapter *adapter)
 	btd_adv_monitor_manager_destroy(adapter->adv_monitor_manager);
 	adapter->adv_monitor_manager = NULL;
 
+	btd_battery_provider_manager_destroy(adapter->battery_provider_manager);
+	adapter->battery_provider_manager = NULL;
+
 	g_slist_free(adapter->pin_callbacks);
 	adapter->pin_callbacks = NULL;
 
@@ -8651,6 +8657,11 @@ static int adapter_register(struct btd_adapter *adapter)
 		}
 	}
 
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+		adapter->battery_provider_manager =
+			btd_battery_provider_manager_create(adapter);
+	}
+
 	db = btd_gatt_database_get_db(adapter->database);
 	adapter->db_id = gatt_db_register(db, services_modified,
 							services_modified,
diff --git a/src/battery.c b/src/battery.c
index 8613d6e23..8594c8d77 100644
--- a/src/battery.c
+++ b/src/battery.c
@@ -25,8 +25,11 @@
 #include "dbus-common.h"
 #include "adapter.h"
 #include "log.h"
+#include "error.h"
 
 #define BATTERY_INTERFACE "org.bluez.Battery1"
+#define BATTERY_PROVIDER_INTERFACE "org.bluez.BatteryProvider1"
+#define BATTERY_PROVIDER_MANAGER_INTERFACE "org.bluez.BatteryProviderManager1"
 
 #define BATTERY_MAX_PERCENTAGE 100
 
@@ -34,10 +37,27 @@ struct btd_battery {
 	char *path; /* D-Bus object path */
 	uint8_t percentage; /* valid between 0 to 100 inclusively */
 	char *source; /* Descriptive source of the battery info */
+	char *provider_path; /* The provider root path, if any */
+};
+
+struct btd_battery_provider_manager {
+	struct btd_adapter *adapter; /* Does not own pointer */
+	struct queue *battery_providers;
+};
+
+struct battery_provider {
+	struct btd_battery_provider_manager *manager; /* Does not own pointer */
+
+	char *owner; /* Owner D-Bus address */
+	char *path; /* D-Bus object path */
+
+	GDBusClient *client;
 };
 
 static struct queue *batteries = NULL;
 
+static void provider_disconnect_cb(DBusConnection *conn, void *user_data);
+
 static void battery_add(struct btd_battery *battery)
 {
 	if (!batteries)
@@ -63,7 +83,8 @@ static bool match_path(const void *data, const void *user_data)
 	return g_strcmp0(battery->path, path) == 0;
 }
 
-static struct btd_battery *battery_new(const char *path, const char *source)
+static struct btd_battery *battery_new(const char *path, const char *source,
+				       const char *provider_path)
 {
 	struct btd_battery *battery;
 
@@ -72,6 +93,8 @@ static struct btd_battery *battery_new(const char *path, const char *source)
 	battery->percentage = UINT8_MAX;
 	if (source)
 		battery->source = g_strdup(source);
+	if (provider_path)
+		battery->provider_path = g_strdup(provider_path);
 
 	return battery;
 }
@@ -133,7 +156,8 @@ static const GDBusPropertyTable battery_properties[] = {
 	{}
 };
 
-struct btd_battery *btd_battery_register(const char *path, const char *source)
+struct btd_battery *btd_battery_register(const char *path, const char *source,
+					 const char *provider_path)
 {
 	struct btd_battery *battery;
 
@@ -149,7 +173,7 @@ struct btd_battery *btd_battery_register(const char *path, const char *source)
 		return NULL;
 	}
 
-	battery = battery_new(path, source);
+	battery = battery_new(path, source, provider_path);
 	battery_add(battery);
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(), battery->path,
@@ -216,3 +240,344 @@ bool btd_battery_update(struct btd_battery *battery, uint8_t percentage)
 
 	return true;
 }
+
+static struct btd_battery *find_battery_by_path(const char *path)
+{
+	return queue_find(batteries, match_path, path);
+}
+
+static void provided_battery_property_changed_cb(GDBusProxy *proxy,
+						 const char *name,
+						 DBusMessageIter *iter,
+						 void *user_data)
+{
+	uint8_t percentage;
+	struct battery_provider *provider = user_data;
+	const char *path = g_dbus_proxy_get_path(proxy);
+	const char *export_path;
+
+	export_path = &path[strlen(provider->path)];
+
+	if (strcmp(name, "Percentage") != 0)
+		return;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BYTE)
+		return;
+
+	dbus_message_iter_get_basic(iter, &percentage);
+
+	DBG("battery percentage changed on %s, percentage = %d",
+	    g_dbus_proxy_get_path(proxy), percentage);
+
+	btd_battery_update(find_battery_by_path(export_path), percentage);
+}
+
+static void provided_battery_added_cb(GDBusProxy *proxy, void *user_data)
+{
+	struct battery_provider *provider = user_data;
+	struct btd_battery *battery;
+	const char *path = g_dbus_proxy_get_path(proxy);
+	const char *export_path;
+	const char *source = NULL;
+	uint8_t percentage;
+	DBusMessageIter iter;
+
+	export_path = &path[strlen(provider->path)];
+
+	if (strcmp(g_dbus_proxy_get_interface(proxy),
+		   BATTERY_PROVIDER_INTERFACE) != 0)
+		return;
+
+	if (!btd_adapter_find_device_by_path(provider->manager->adapter,
+					     export_path)) {
+		warn("Ignoring non-existent device path for battery %s",
+		     export_path);
+		return;
+	}
+
+	if (find_battery_by_path(export_path))
+		return;
+
+	g_dbus_proxy_set_property_watch(
+		proxy, provided_battery_property_changed_cb, provider);
+
+	if (g_dbus_proxy_get_property(proxy, "Source", &iter) == TRUE)
+		dbus_message_iter_get_basic(&iter, &source);
+
+	battery = btd_battery_register(export_path, source, provider->path);
+
+	DBG("provided battery added %s", path);
+
+	/* Percentage property may not be immediately available, that's okay
+	 * since we monitor changes to this property.
+	 */
+	if (g_dbus_proxy_get_property(proxy, "Percentage", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &percentage);
+
+	btd_battery_update(battery, percentage);
+}
+
+static void provided_battery_removed_cb(GDBusProxy *proxy, void *user_data)
+{
+	struct battery_provider *provider = user_data;
+	struct btd_battery *battery;
+	const char *path = g_dbus_proxy_get_path(proxy);
+	const char *export_path;
+
+	export_path = &path[strlen(provider->path)];
+
+	if (strcmp(g_dbus_proxy_get_interface(proxy),
+		   BATTERY_PROVIDER_INTERFACE) != 0)
+		return;
+
+	DBG("provided battery removed %s", g_dbus_proxy_get_path(proxy));
+
+	battery = find_battery_by_path(export_path);
+	if (!battery)
+		return;
+
+	if (g_strcmp0(battery->provider_path, provider->path) != 0)
+		return;
+
+	g_dbus_proxy_set_property_watch(proxy, NULL, NULL);
+
+	btd_battery_unregister(battery);
+}
+
+static bool match_provider_path(const void *data, const void *user_data)
+{
+	const struct battery_provider *provider = data;
+	const char *path = user_data;
+
+	return strcmp(provider->path, path) == 0;
+}
+
+static void unregister_if_path_has_prefix(void *data, void *user_data)
+{
+	struct btd_battery *battery = data;
+	struct battery_provider *provider = user_data;
+
+	if (g_strcmp0(battery->provider_path, provider->path) == 0)
+		btd_battery_unregister(battery);
+}
+
+static void battery_provider_free(gpointer data)
+{
+	struct battery_provider *provider = data;
+
+	/* Unregister batteries under the root path of provider->path */
+	queue_foreach(batteries, unregister_if_path_has_prefix, provider);
+
+	if (provider->owner)
+		g_free(provider->owner);
+
+	if (provider->path)
+		g_free(provider->path);
+
+	if (provider->client) {
+		g_dbus_client_set_disconnect_watch(provider->client, NULL,
+						   NULL);
+		g_dbus_client_set_proxy_handlers(provider->client, NULL, NULL,
+						 NULL, NULL);
+		g_dbus_client_unref(provider->client);
+	}
+
+	free(provider);
+}
+
+static struct battery_provider *
+battery_provider_new(DBusConnection *conn,
+		     struct btd_battery_provider_manager *manager,
+		     const char *path, const char *sender)
+{
+	struct battery_provider *provider;
+
+	provider = new0(struct battery_provider, 1);
+	provider->manager = manager;
+	provider->owner = g_strdup(sender);
+	provider->path = g_strdup(path);
+
+	provider->client = g_dbus_client_new_full(conn, sender, path, path);
+
+	if (!provider->client) {
+		error("error creating D-Bus client %s", path);
+		battery_provider_free(provider);
+		return NULL;
+	}
+
+	g_dbus_client_set_disconnect_watch(provider->client,
+					   provider_disconnect_cb, provider);
+
+	g_dbus_client_set_proxy_handlers(provider->client,
+					 provided_battery_added_cb,
+					 provided_battery_removed_cb, NULL,
+					 provider);
+
+	return provider;
+}
+
+static void provider_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct battery_provider *provider = user_data;
+	struct btd_battery_provider_manager *manager = provider->manager;
+
+	DBG("battery provider client disconnected %s root path %s",
+	    provider->owner, provider->path);
+
+	if (!queue_find(manager->battery_providers, NULL, provider)) {
+		warn("Disconnection on a non-existing provider %s",
+		     provider->path);
+		return;
+	}
+
+	queue_remove(manager->battery_providers, provider);
+	battery_provider_free(provider);
+}
+
+static DBusMessage *register_battery_provider(DBusConnection *conn,
+					      DBusMessage *msg, void *user_data)
+{
+	struct btd_battery_provider_manager *manager = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	DBusMessageIter args;
+	const char *path;
+	struct battery_provider *provider;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	DBG("register battery provider path = %s", path);
+
+	if (!g_str_has_prefix(path, "/"))
+		return btd_error_invalid_args(msg);
+
+	if (queue_find(manager->battery_providers, match_provider_path, path)) {
+		return dbus_message_new_error(msg,
+					      ERROR_INTERFACE ".AlreadyExists",
+					      "Provider already exists");
+	}
+
+	provider = battery_provider_new(conn, manager, path, sender);
+	queue_push_head(manager->battery_providers, provider);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_battery_provider(DBusConnection *conn,
+						DBusMessage *msg,
+						void *user_data)
+{
+	struct btd_battery_provider_manager *manager = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	DBusMessageIter args;
+	const char *path;
+	struct battery_provider *provider;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	DBG("unregister battery provider path = %s", path);
+
+	provider = queue_find(manager->battery_providers, match_provider_path,
+			      path);
+	if (!provider || strcmp(provider->owner, sender) != 0) {
+		return dbus_message_new_error(msg,
+					      ERROR_INTERFACE ".DoesNotExist",
+					      "Provider does not exist");
+	}
+
+	queue_remove(manager->battery_providers, provider);
+	battery_provider_free(provider);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable methods[] = {
+	{ GDBUS_EXPERIMENTAL_METHOD("RegisterBatteryProvider",
+				    GDBUS_ARGS({ "provider", "o" }), NULL,
+				    register_battery_provider) },
+	{ GDBUS_EXPERIMENTAL_METHOD("UnregisterBatteryProvider",
+				    GDBUS_ARGS({ "provider", "o" }), NULL,
+				    unregister_battery_provider) },
+	{}
+};
+
+static struct btd_battery_provider_manager *
+manager_new(struct btd_adapter *adapter)
+{
+	struct btd_battery_provider_manager *manager;
+
+	DBG("");
+
+	manager = new0(struct btd_battery_provider_manager, 1);
+	manager->adapter = adapter;
+	manager->battery_providers = queue_new();
+
+	return manager;
+}
+
+static void manager_free(struct btd_battery_provider_manager *manager)
+{
+	if (!manager)
+		return;
+
+	DBG("");
+
+	queue_destroy(manager->battery_providers, battery_provider_free);
+
+	free(manager);
+}
+
+struct btd_battery_provider_manager *
+btd_battery_provider_manager_create(struct btd_adapter *adapter)
+{
+	struct btd_battery_provider_manager *manager;
+
+	if (!adapter)
+		return NULL;
+
+	manager = manager_new(adapter);
+	if (!manager)
+		return NULL;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+				       adapter_get_path(manager->adapter),
+				       BATTERY_PROVIDER_MANAGER_INTERFACE,
+				       methods, NULL, NULL, manager, NULL)) {
+		error("error registering " BATTERY_PROVIDER_MANAGER_INTERFACE
+		      " interface");
+		manager_free(manager);
+		return NULL;
+	}
+
+	info("Battery Provider Manager created");
+
+	return manager;
+}
+
+void btd_battery_provider_manager_destroy(
+	struct btd_battery_provider_manager *manager)
+{
+	if (!manager)
+		return;
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				    adapter_get_path(manager->adapter),
+				    BATTERY_PROVIDER_MANAGER_INTERFACE);
+
+	info("Battery Provider Manager destroyed");
+
+	manager_free(manager);
+}
diff --git a/src/battery.h b/src/battery.h
index ff63454cd..271659474 100644
--- a/src/battery.h
+++ b/src/battery.h
@@ -8,8 +8,16 @@
  *
  */
 
+struct btd_adapter;
 struct btd_battery;
+struct btd_battery_provider_manager;
 
-struct btd_battery *btd_battery_register(const char *path, const char *source);
+struct btd_battery *btd_battery_register(const char *path, const char *source,
+					 const char *provider_path);
 bool btd_battery_unregister(struct btd_battery *battery);
 bool btd_battery_update(struct btd_battery *battery, uint8_t percentage);
+
+struct btd_battery_provider_manager *
+btd_battery_provider_manager_create(struct btd_adapter *adapter);
+void btd_battery_provider_manager_destroy(
+	struct btd_battery_provider_manager *manager);
-- 
2.26.2

