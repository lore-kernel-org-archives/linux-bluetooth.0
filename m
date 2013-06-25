Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 16/16] network: Use btd_server userdata for network_server
Date: Tue, 25 Jun 2013 18:24:49 +0200
Message-Id: <1372177489-6858-17-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Exploit the userdata pointer to avoid maintainig a list with instances
of struct network_server.
---
 profiles/network/server.c | 56 ++++++++++-------------------------------------
 1 file changed, 11 insertions(+), 45 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 77e2c7e..8ca9013 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -68,7 +68,6 @@ struct network_adapter {
 	struct btd_adapter *adapter;	/* Adapter pointer */
 	GIOChannel	*io;		/* Bnep socket */
 	struct network_session *setup;	/* Setup in progress */
-	GSList		*servers;	/* Server register to adapter */
 };
 
 /* Main server structure */
@@ -88,16 +87,13 @@ static gboolean security = TRUE;
 static struct network_server *find_server(struct network_adapter *na,
 								uint16_t id)
 {
-	GSList *list;
-
-	for (list = na->servers; list; list = list->next) {
-		struct network_server *ns = list->data;
+	const char *uuid = bnep_uuid(id);
+	struct btd_server *server = btd_adapter_get_server(na->adapter, uuid);
 
-		if (ns->id == id)
-			return ns;
-	}
+	if (server == NULL)
+		return NULL;
 
-	return NULL;
+	return btd_server_get_user_data(server);
 }
 
 static sdp_record_t *server_record_new(const char *name, uint16_t id)
@@ -676,10 +672,8 @@ static void adapter_free(struct network_adapter *na)
 	g_free(na);
 }
 
-static void server_free(void *data)
+static void server_free(struct network_server *ns)
 {
-	struct network_server *ns = data;
-
 	if (!ns)
 		return;
 
@@ -701,7 +695,6 @@ static void path_unregister(void *data)
 	DBG("Unregistered interface %s on path %s",
 		NETWORK_SERVER_INTERFACE, adapter_get_path(na->adapter));
 
-	g_slist_free_full(na->servers, server_free);
 	adapter_free(na);
 }
 
@@ -747,34 +740,23 @@ int network_server_probe(struct btd_server *server)
 {
 	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct btd_server *bnep_server;
-	struct network_adapter *na;
 	struct network_server *ns;
 	const char *uuid = btd_server_get_profile(server)->remote_uuid;
-	uint16_t id;
 
 	DBG("path %s uuid %s", adapter_get_path(adapter), uuid);
 
-	id = bnep_service_id(uuid);
-
 	bnep_server = btd_adapter_get_server(adapter, BNEP_SVC_UUID);
 	if (bnep_server == NULL)
 		return -EINVAL;
 
-	na = btd_server_get_user_data(bnep_server);
-
-	ns = find_server(na, id);
-	if (ns)
-		return 0;
-
 	ns = g_new0(struct network_server, 1);
-
 	ns->name = g_strdup("Network service");
-
 	bacpy(&ns->src, adapter_get_address(adapter));
-	ns->id = id;
-	ns->na = na;
+	ns->id = bnep_service_id(uuid);
+	ns->na = btd_server_get_user_data(bnep_server);
 	ns->record_id = 0;
-	na->servers = g_slist_append(na->servers, ns);
+
+	btd_server_set_user_data(server, ns);
 
 	return 0;
 }
@@ -782,27 +764,11 @@ int network_server_probe(struct btd_server *server)
 void network_server_remove(struct btd_server *server)
 {
 	struct btd_adapter *adapter = btd_server_get_adapter(server);
-	struct btd_server *bnep_server;
-	struct network_adapter *na;
-	struct network_server *ns;
+	struct network_server *ns = btd_server_get_user_data(server);
 	const char *uuid = btd_server_get_profile(server)->remote_uuid;
-	uint16_t id;
 
 	DBG("path %s uuid %s", adapter_get_path(adapter), uuid);
 
-	id = bnep_service_id(uuid);
-
-	bnep_server = btd_adapter_get_server(adapter, BNEP_SVC_UUID);
-	if (bnep_server == NULL)
-		return;
-
-	na = btd_server_get_user_data(bnep_server);
-
-	ns = find_server(na, id);
-	if (!ns)
-		return;
-
-	na->servers = g_slist_remove(na->servers, ns);
 	server_free(ns);
 }
 
-- 
1.8.1.4

