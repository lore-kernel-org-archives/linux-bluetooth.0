Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/11] network: Fix trying to register NetworkServer interface multiple times
Date: Mon, 26 Nov 2012 15:09:20 +0200
Message-Id: <1353935362-8666-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
References: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This also removes the limitation of only accepting nap as UUID, now all
PAN UUID are supported including their friendly names.
---
 profiles/network/server.c | 64 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 1a485ca..2c3c72e 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -72,7 +72,6 @@ struct network_adapter {
 /* Main server structure */
 struct network_server {
 	bdaddr_t	src;		/* Bluetooth Local Address */
-	char		*iface;		/* DBus interface */
 	char		*name;		/* Server service name */
 	char		*bridge;	/* Bridge name */
 	uint32_t	record_id;	/* Service record id */
@@ -110,6 +109,22 @@ static struct network_server *find_server(GSList *list, uint16_t id)
 	return NULL;
 }
 
+static struct network_server *find_server_by_uuid(GSList *list,
+							const char *uuid)
+{
+	for (; list; list = list->next) {
+		struct network_server *ns = list->data;
+
+		if (strcasecmp(uuid, bnep_uuid(ns->id)) == 0)
+			return ns;
+
+		if (strcasecmp(uuid, bnep_name(ns->id)) == 0)
+			return ns;
+	}
+
+	return NULL;
+}
+
 static sdp_record_t *server_record_new(const char *name, uint16_t id)
 {
 	sdp_list_t *svclass, *pfseq, *apseq, *root, *aproto;
@@ -624,7 +639,8 @@ static void server_disconnect(DBusConnection *conn, void *user_data)
 static DBusMessage *register_server(DBusConnection *conn,
 				DBusMessage *msg, void *data)
 {
-	struct network_server *ns = data;
+	struct network_adapter *na = data;
+	struct network_server *ns;
 	DBusMessage *reply;
 	const char *uuid, *bridge;
 
@@ -632,7 +648,8 @@ static DBusMessage *register_server(DBusConnection *conn,
 				DBUS_TYPE_STRING, &bridge, DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	if (g_strcmp0(uuid, "nap"))
+	ns = find_server_by_uuid(na->servers, uuid);
+	if (ns == NULL)
 		return btd_error_failed(msg, "Invalid UUID");
 
 	if (ns->record_id)
@@ -693,8 +710,10 @@ static void adapter_free(struct network_adapter *na)
 	g_free(na);
 }
 
-static void server_free(struct network_server *ns)
+static void server_free(void *data)
 {
+	struct network_server *ns = data;
+
 	if (!ns)
 		return;
 
@@ -703,7 +722,6 @@ static void server_free(struct network_server *ns)
 	if (ns->record_id)
 		remove_record_from_server(ns->record_id);
 
-	g_free(ns->iface);
 	g_free(ns->name);
 	g_free(ns->bridge);
 
@@ -712,17 +730,12 @@ static void server_free(struct network_server *ns)
 
 static void path_unregister(void *data)
 {
-	struct network_server *ns = data;
-	struct network_adapter *na = ns->na;
+	struct network_adapter *na = data;
 
 	DBG("Unregistered interface %s on path %s",
-		ns->iface, adapter_get_path(na->adapter));
-
-	na->servers = g_slist_remove(na->servers, ns);
-	server_free(ns);
+		NETWORK_SERVER_INTERFACE, adapter_get_path(na->adapter));
 
-	if (na->servers)
-		return;
+	g_slist_free_full(na->servers, server_free);
 
 	adapters = g_slist_remove(adapters, na);
 	adapter_free(na);
@@ -786,29 +799,33 @@ int server_register(struct btd_adapter *adapter, uint16_t id)
 
 	ns = g_new0(struct network_server, 1);
 
-	ns->iface = g_strdup(NETWORK_SERVER_INTERFACE);
 	ns->name = g_strdup("Network service");
 
 	path = adapter_get_path(adapter);
 
+	if (g_slist_length(na->servers) > 0)
+		goto done;
+
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					path, ns->iface,
+					path, NETWORK_SERVER_INTERFACE,
 					server_methods, NULL, NULL,
-					ns, path_unregister)) {
+					na, path_unregister)) {
 		error("D-Bus failed to register %s interface",
-				ns->iface);
+						NETWORK_SERVER_INTERFACE);
 		server_free(ns);
 		return -1;
 	}
 
+	DBG("Registered interface %s on path %s", NETWORK_SERVER_INTERFACE,
+									path);
+
+done:
 	bacpy(&ns->src, adapter_get_address(adapter));
 	ns->id = id;
 	ns->na = na;
 	ns->record_id = 0;
 	na->servers = g_slist_append(na->servers, ns);
 
-	DBG("Registered interface %s on path %s", ns->iface, path);
-
 	return 0;
 }
 
@@ -825,8 +842,15 @@ int server_unregister(struct btd_adapter *adapter, uint16_t id)
 	if (!ns)
 		return -EINVAL;
 
+	na->servers = g_slist_remove(na->servers, ns);
+	server_free(ns);
+
+	if (g_slist_length(na->servers) > 0)
+		return 0;
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
-					adapter_get_path(adapter), ns->iface);
+						adapter_get_path(adapter),
+						NETWORK_SERVER_INTERFACE);
 
 	return 0;
 }
-- 
1.7.11.7

