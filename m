Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 15/16] network: Create network_adapter during BNEP probe
Date: Tue, 25 Jun 2013 18:24:48 +0200
Message-Id: <1372177489-6858-16-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The network adapter creation along with the registration of the
corresponding D-Bus interface fit nicely into the newly created
btd_profile instance for BNEP.

As a nice side benefit, the struct network_adapter pointer is assigned
as userdata of the BNEP btd_server, so there is no need to keep a
dedicated adapter list.
---
 profiles/network/server.c | 87 ++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 51 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 0e52db0..77e2c7e 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -83,22 +83,8 @@ struct network_server {
 	guint		watch_id;	/* Client service watch */
 };
 
-static GSList *adapters = NULL;
 static gboolean security = TRUE;
 
-static struct network_adapter *find_adapter(GSList *list,
-					struct btd_adapter *adapter)
-{
-	for (; list; list = list->next) {
-		struct network_adapter *na = list->data;
-
-		if (na->adapter == adapter)
-			return na;
-	}
-
-	return NULL;
-}
-
 static struct network_server *find_server(struct network_adapter *na,
 								uint16_t id)
 {
@@ -716,8 +702,6 @@ static void path_unregister(void *data)
 		NETWORK_SERVER_INTERFACE, adapter_get_path(na->adapter));
 
 	g_slist_free_full(na->servers, server_free);
-
-	adapters = g_slist_remove(adapters, na);
 	adapter_free(na);
 }
 
@@ -762,23 +746,21 @@ static struct network_adapter *create_adapter(struct btd_adapter *adapter)
 int network_server_probe(struct btd_server *server)
 {
 	struct btd_adapter *adapter = btd_server_get_adapter(server);
+	struct btd_server *bnep_server;
 	struct network_adapter *na;
 	struct network_server *ns;
-	const char *path = adapter_get_path(adapter);
 	const char *uuid = btd_server_get_profile(server)->remote_uuid;
 	uint16_t id;
 
-	DBG("path %s uuid %s", path, uuid);
+	DBG("path %s uuid %s", adapter_get_path(adapter), uuid);
 
 	id = bnep_service_id(uuid);
 
-	na = find_adapter(adapters, adapter);
-	if (!na) {
-		na = create_adapter(adapter);
-		if (!na)
-			return -EINVAL;
-		adapters = g_slist_append(adapters, na);
-	}
+	bnep_server = btd_adapter_get_server(adapter, BNEP_SVC_UUID);
+	if (bnep_server == NULL)
+		return -EINVAL;
+
+	na = btd_server_get_user_data(bnep_server);
 
 	ns = find_server(na, id);
 	if (ns)
@@ -788,23 +770,6 @@ int network_server_probe(struct btd_server *server)
 
 	ns->name = g_strdup("Network service");
 
-	if (g_slist_length(na->servers) > 0)
-		goto done;
-
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					path, NETWORK_SERVER_INTERFACE,
-					server_methods, NULL, NULL,
-					na, path_unregister)) {
-		error("D-Bus failed to register %s interface",
-						NETWORK_SERVER_INTERFACE);
-		server_free(ns);
-		return -1;
-	}
-
-	DBG("Registered interface %s on path %s", NETWORK_SERVER_INTERFACE,
-									path);
-
-done:
 	bacpy(&ns->src, adapter_get_address(adapter));
 	ns->id = id;
 	ns->na = na;
@@ -817,6 +782,7 @@ done:
 void network_server_remove(struct btd_server *server)
 {
 	struct btd_adapter *adapter = btd_server_get_adapter(server);
+	struct btd_server *bnep_server;
 	struct network_adapter *na;
 	struct network_server *ns;
 	const char *uuid = btd_server_get_profile(server)->remote_uuid;
@@ -826,32 +792,47 @@ void network_server_remove(struct btd_server *server)
 
 	id = bnep_service_id(uuid);
 
-	na = find_adapter(adapters, adapter);
-	if (!na)
+	bnep_server = btd_adapter_get_server(adapter, BNEP_SVC_UUID);
+	if (bnep_server == NULL)
 		return;
 
+	na = btd_server_get_user_data(bnep_server);
+
 	ns = find_server(na, id);
 	if (!ns)
 		return;
 
 	na->servers = g_slist_remove(na->servers, ns);
 	server_free(ns);
-
-	if (g_slist_length(na->servers) > 0)
-		return;
-
-	g_dbus_unregister_interface(btd_get_dbus_connection(),
-						adapter_get_path(adapter),
-						NETWORK_SERVER_INTERFACE);
 }
 
 static int bnep_server_probe(struct btd_server *server)
 {
 	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	const char *path = adapter_get_path(adapter);
+	struct network_adapter *na;
 
 	DBG("path %s", path);
 
+	na = create_adapter(adapter);
+	if (na == NULL)
+		return -EINVAL;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+						path, NETWORK_SERVER_INTERFACE,
+						server_methods, NULL, NULL,
+						na, path_unregister)) {
+		error("D-Bus failed to register %s interface",
+						NETWORK_SERVER_INTERFACE);
+		adapter_free(na);
+		return -EIO;
+	}
+
+	DBG("Registered interface %s on path %s", NETWORK_SERVER_INTERFACE,
+									path);
+
+	btd_server_set_user_data(server, na);
+
 	return 0;
 }
 
@@ -860,6 +841,10 @@ static void bnep_server_remove(struct btd_server *server)
 	struct btd_adapter *adapter = btd_server_get_adapter(server);
 
 	DBG("path %s", adapter_get_path(adapter));
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						adapter_get_path(adapter),
+						NETWORK_SERVER_INTERFACE);
 }
 
 static struct btd_profile bnep_profile = {
-- 
1.8.1.4

