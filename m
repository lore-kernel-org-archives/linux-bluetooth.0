Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 02/16] adapter: Create btd_server instances when probing
Date: Tue, 25 Jun 2013 18:24:35 +0200
Message-Id: <1372177489-6858-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Instead of storing a list of probed btd_profile instances, maintain a
similar list but with btd_server instances instead. This makes use of
server_create() which guarantees that all existing instances of
btd_server represent a probed (adapter, profile) pair.
---
 src/adapter.c | 50 ++++++++++++++++++++++++++++----------------------
 src/adapter.h |  2 ++
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 17f5508..246b510 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -57,6 +57,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "server.h"
 #include "dbus-common.h"
 #include "error.h"
 #include "glib-helper.h"
@@ -177,7 +178,7 @@ struct btd_adapter {
 	GSList *pin_callbacks;
 
 	GSList *drivers;
-	GSList *profiles;
+	GSList *servers;
 
 	struct oob_handler *oob_handler;
 
@@ -2616,18 +2617,16 @@ static void load_drivers(struct btd_adapter *adapter)
 static void probe_profile(struct btd_profile *profile, void *data)
 {
 	struct btd_adapter *adapter = data;
-	int err;
+	struct btd_server *server;
 
 	if (profile->adapter_probe == NULL)
 		return;
 
-	err = profile->adapter_probe(profile, adapter);
-	if (err < 0) {
-		error("%s: %s (%d)", profile->name, strerror(-err), -err);
+	server = server_create(adapter, profile);
+	if (server == NULL)
 		return;
-	}
 
-	adapter->profiles = g_slist_prepend(adapter->profiles, profile);
+	adapter->servers = g_slist_prepend(adapter->servers, server);
 }
 
 void adapter_add_profile(struct btd_adapter *adapter, gpointer p)
@@ -2645,6 +2644,7 @@ void adapter_add_profile(struct btd_adapter *adapter, gpointer p)
 void adapter_remove_profile(struct btd_adapter *adapter, gpointer p)
 {
 	struct btd_profile *profile = p;
+	struct btd_server *server;
 
 	if (!adapter->initialized)
 		return;
@@ -2652,10 +2652,26 @@ void adapter_remove_profile(struct btd_adapter *adapter, gpointer p)
 	if (profile->device_remove)
 		g_slist_foreach(adapter->devices, device_remove_profile, p);
 
-	adapter->profiles = g_slist_remove(adapter->profiles, profile);
+	server = btd_adapter_get_server(adapter, profile->local_uuid);
+	adapter->servers = g_slist_remove(adapter->servers, server);
 
-	if (profile->adapter_remove)
-		profile->adapter_remove(profile, adapter);
+	server_destroy(server);
+}
+
+struct btd_server *btd_adapter_get_server(struct btd_adapter *adapter,
+							const char *local_uuid)
+{
+	GSList *l;
+
+	for (l = adapter->servers; l != NULL; l = g_slist_next(l)) {
+		struct btd_server *server = l->data;
+		struct btd_profile *p = btd_server_get_profile(server);
+
+		if (g_strcmp0(p->local_uuid, local_uuid) == 0)
+			return server;
+	}
+
+	return NULL;
 }
 
 static void adapter_add_connection(struct btd_adapter *adapter,
@@ -2868,24 +2884,14 @@ static void remove_driver(gpointer data, gpointer user_data)
 		driver->remove(adapter);
 }
 
-static void remove_profile(gpointer data, gpointer user_data)
-{
-	struct btd_profile *profile = data;
-	struct btd_adapter *adapter = user_data;
-
-	if (profile->adapter_remove)
-		profile->adapter_remove(profile, adapter);
-}
-
 static void unload_drivers(struct btd_adapter *adapter)
 {
 	g_slist_foreach(adapter->drivers, remove_driver, adapter);
 	g_slist_free(adapter->drivers);
 	adapter->drivers = NULL;
 
-	g_slist_foreach(adapter->profiles, remove_profile, adapter);
-	g_slist_free(adapter->profiles);
-	adapter->profiles = NULL;
+	g_slist_free_full(adapter->servers, (GDestroyNotify) server_destroy);
+	adapter->servers = NULL;
 }
 
 static void free_service_auth(gpointer data, gpointer user_data)
diff --git a/src/adapter.h b/src/adapter.h
index 32b12c0..7fdf055 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -123,6 +123,8 @@ typedef void (*service_auth_cb) (DBusError *derr, void *user_data);
 
 void adapter_add_profile(struct btd_adapter *adapter, gpointer p);
 void adapter_remove_profile(struct btd_adapter *adapter, gpointer p);
+struct btd_server *btd_adapter_get_server(struct btd_adapter *adapter,
+							const char *local_uuid);
 int btd_register_adapter_driver(struct btd_adapter_driver *driver);
 void btd_unregister_adapter_driver(struct btd_adapter_driver *driver);
 guint btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
-- 
1.8.1.4

