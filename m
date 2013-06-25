Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 12/16] network: Bypass manager for profile server
Date: Tue, 25 Jun 2013 18:24:45 +0200
Message-Id: <1372177489-6858-13-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Trivially adopt the btd_profile signature regarding adapter probe in
server.h in order to avoid boilerplate code in manager.c.
---
 profiles/network/manager.c | 72 ++++------------------------------------------
 profiles/network/server.c  | 32 ++++++++++++++-------
 profiles/network/server.h  |  4 +--
 3 files changed, 30 insertions(+), 78 deletions(-)

diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 1ec2db2..4f897dd 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -75,66 +75,6 @@ done:
 				conf_security ? "true" : "false");
 }
 
-static int panu_server_probe(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-	const char *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	return server_register(adapter, BNEP_SVC_PANU);
-}
-
-static void panu_server_remove(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-	const char *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	server_unregister(adapter, BNEP_SVC_PANU);
-}
-
-static int gn_server_probe(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-	const char *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	return server_register(adapter, BNEP_SVC_GN);
-}
-
-static void gn_server_remove(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-	const char *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	server_unregister(adapter, BNEP_SVC_GN);
-}
-
-static int nap_server_probe(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-	const char *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	return server_register(adapter, BNEP_SVC_NAP);
-}
-
-static void nap_server_remove(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-	const char *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	server_unregister(adapter, BNEP_SVC_NAP);
-}
-
 static struct btd_profile panu_profile = {
 	.name		= "network-panu",
 	.local_uuid	= NAP_UUID,
@@ -143,8 +83,8 @@ static struct btd_profile panu_profile = {
 	.device_remove	= connection_unregister,
 	.connect	= connection_connect,
 	.disconnect	= connection_disconnect,
-	.adapter_probe	= panu_server_probe,
-	.adapter_remove	= panu_server_remove,
+	.adapter_probe	= network_server_probe,
+	.adapter_remove	= network_server_remove,
 };
 
 static struct btd_profile gn_profile = {
@@ -155,8 +95,8 @@ static struct btd_profile gn_profile = {
 	.device_remove	= connection_unregister,
 	.connect	= connection_connect,
 	.disconnect	= connection_disconnect,
-	.adapter_probe	= gn_server_probe,
-	.adapter_remove	= gn_server_remove,
+	.adapter_probe	= network_server_probe,
+	.adapter_remove	= network_server_remove,
 };
 
 static struct btd_profile nap_profile = {
@@ -167,8 +107,8 @@ static struct btd_profile nap_profile = {
 	.device_remove	= connection_unregister,
 	.connect	= connection_connect,
 	.disconnect	= connection_disconnect,
-	.adapter_probe	= nap_server_probe,
-	.adapter_remove	= nap_server_remove,
+	.adapter_probe	= network_server_probe,
+	.adapter_remove	= network_server_remove,
 };
 
 static int network_init(void)
diff --git a/profiles/network/server.c b/profiles/network/server.c
index ace31c5..a0b7754 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -43,6 +43,8 @@
 #include "lib/uuid.h"
 #include "../src/dbus-common.h"
 #include "../src/adapter.h"
+#include "../src/profile.h"
+#include "../src/server.h"
 
 #include "log.h"
 #include "error.h"
@@ -786,11 +788,18 @@ static struct network_adapter *create_adapter(struct btd_adapter *adapter)
 	return na;
 }
 
-int server_register(struct btd_adapter *adapter, uint16_t id)
+int network_server_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct network_adapter *na;
 	struct network_server *ns;
-	const char *path;
+	const char *path = adapter_get_path(adapter);
+	const char *uuid = btd_server_get_profile(server)->remote_uuid;
+	uint16_t id;
+
+	DBG("path %s uuid %s", path, uuid);
+
+	id = bnep_service_id(uuid);
 
 	na = find_adapter(adapters, adapter);
 	if (!na) {
@@ -808,8 +817,6 @@ int server_register(struct btd_adapter *adapter, uint16_t id)
 
 	ns->name = g_strdup("Network service");
 
-	path = adapter_get_path(adapter);
-
 	if (g_slist_length(na->servers) > 0)
 		goto done;
 
@@ -836,28 +843,33 @@ done:
 	return 0;
 }
 
-int server_unregister(struct btd_adapter *adapter, uint16_t id)
+void network_server_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct network_adapter *na;
 	struct network_server *ns;
+	const char *uuid = btd_server_get_profile(server)->remote_uuid;
+	uint16_t id;
+
+	DBG("path %s uuid %s", adapter_get_path(adapter), uuid);
+
+	id = bnep_service_id(uuid);
 
 	na = find_adapter(adapters, adapter);
 	if (!na)
-		return -EINVAL;
+		return;
 
 	ns = find_server(na, id);
 	if (!ns)
-		return -EINVAL;
+		return;
 
 	na->servers = g_slist_remove(na->servers, ns);
 	server_free(ns);
 
 	if (g_slist_length(na->servers) > 0)
-		return 0;
+		return;
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 						adapter_get_path(adapter),
 						NETWORK_SERVER_INTERFACE);
-
-	return 0;
 }
diff --git a/profiles/network/server.h b/profiles/network/server.h
index 2edd342..2d8b41c 100644
--- a/profiles/network/server.h
+++ b/profiles/network/server.h
@@ -23,5 +23,5 @@
 
 int server_init(gboolean secure);
 void server_exit(void);
-int server_register(struct btd_adapter *adapter, uint16_t id);
-int server_unregister(struct btd_adapter *adapter, uint16_t id);
+int network_server_probe(struct btd_server *server);
+void network_server_remove(struct btd_server *server);
-- 
1.8.1.4

