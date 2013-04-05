Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 08/11] network: Hold a reference to btd_service
Date: Fri,  5 Apr 2013 13:45:45 +0200
Message-Id: <1365162348-25541-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1365162348-25541-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1365162348-25541-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Profile implementations are expected to hold a reference to probed
services, so update the network profiles accordingly.
---
 profiles/network/connection.c | 38 ++++++++++++++++++++++++++--------
 profiles/network/connection.h |  4 ++--
 profiles/network/manager.c    | 48 ++++++-------------------------------------
 3 files changed, 37 insertions(+), 53 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 3a913cf..1ecff4d 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -43,6 +43,8 @@
 #include "dbus-common.h"
 #include "adapter.h"
 #include "device.h"
+#include "profile.h"
+#include "service.h"
 
 #include "error.h"
 #include "common.h"
@@ -65,6 +67,7 @@ struct network_peer {
 };
 
 struct network_conn {
+	struct btd_service *service;
 	char		dev[16];	/* Interface name */
 	uint16_t	id;		/* Role: Service Class Identifier */
 	conn_state	state;
@@ -83,6 +86,13 @@ struct __service_16 {
 
 static GSList *peers = NULL;
 
+static uint16_t get_service_id(struct btd_service *service)
+{
+	struct btd_profile *p = btd_service_get_profile(service);
+
+	return bnep_service_id(p->remote_uuid);
+}
+
 static struct network_peer *find_peer(GSList *list, struct btd_device *device)
 {
 	for (; list; list = list->next) {
@@ -599,6 +609,7 @@ static void connection_free(void *data)
 	if (nc->connect)
 		dbus_message_unref(nc->connect);
 
+	btd_service_unref(nc->service);
 	g_free(nc);
 }
 
@@ -639,13 +650,14 @@ static const GDBusPropertyTable connection_properties[] = {
 	{ }
 };
 
-void connection_unregister(struct btd_device *device)
+void connection_unregister(struct btd_service *service)
 {
-	struct network_peer *peer;
+	struct btd_device *device = btd_service_get_device(service);
+	struct network_conn *conn = btd_service_get_user_data(service);
+	struct network_peer *peer = conn->peer;
+	uint16_t id = get_service_id(service);
 
-	peer = find_peer(peers, device);
-	if (!peer)
-		return;
+	DBG("%s id %u", device_get_path(device), id);
 
 	g_slist_free_full(peer->connections, connection_free);
 	peer->connections = NULL;
@@ -682,12 +694,14 @@ static struct network_peer *create_peer(struct btd_device *device)
 	return peer;
 }
 
-int connection_register(struct btd_device *device, uint16_t id)
+int connection_register(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct network_peer *peer;
 	struct network_conn *nc;
+	uint16_t id = get_service_id(service);
 
-	DBG("id %u", id);
+	DBG("%s id %u", device_get_path(device), id);
 
 	peer = find_peer(peers, device);
 	if (!peer) {
@@ -698,16 +712,22 @@ int connection_register(struct btd_device *device, uint16_t id)
 	}
 
 	nc = find_connection(peer->connections, id);
-	if (nc)
-		return 0;
+	if (nc) {
+		error("Device %s has multiple connection instances of %d",
+						device_get_path(device), id);
+		return -1;
+	}
 
 	nc = g_new0(struct network_conn, 1);
 	nc->id = id;
 	memset(nc->dev, 0, sizeof(nc->dev));
 	strcpy(nc->dev, "bnep%d");
+	nc->service = btd_service_ref(service);
 	nc->state = DISCONNECTED;
 	nc->peer = peer;
 
+	btd_service_set_user_data(service, nc);
+
 	DBG("id %u registered", id);
 
 	peer->connections = g_slist_append(peer->connections, nc);
diff --git a/profiles/network/connection.h b/profiles/network/connection.h
index 32356f9..1e7eedb 100644
--- a/profiles/network/connection.h
+++ b/profiles/network/connection.h
@@ -21,7 +21,7 @@
  *
  */
 
-int connection_register(struct btd_device *device, uint16_t id);
-void connection_unregister(struct btd_device *device);
+int connection_register(struct btd_service *service);
+void connection_unregister(struct btd_service *service);
 int connection_connect(struct btd_device *device, uint16_t id);
 int connection_disconnect(struct btd_device *device, uint16_t id);
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index d860cc0..f37954a 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -75,24 +75,6 @@ done:
 				conf_security ? "true" : "false");
 }
 
-static int panu_probe(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-
-	DBG("path %s", device_get_path(device));
-
-	return connection_register(device, BNEP_SVC_PANU);
-}
-
-static void network_remove(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-
-	DBG("path %s", device_get_path(device));
-
-	connection_unregister(device);
-}
-
 static int panu_connect(struct btd_device *dev, struct btd_profile *profile)
 {
 	return connection_connect(dev, BNEP_SVC_PANU);
@@ -122,15 +104,6 @@ static void panu_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_PANU);
 }
 
-static int gn_probe(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-
-	DBG("path %s", device_get_path(device));
-
-	return connection_register(device, BNEP_SVC_GN);
-}
-
 static int gn_connect(struct btd_device *dev, struct btd_profile *profile)
 {
 	return connection_connect(dev, BNEP_SVC_GN);
@@ -160,15 +133,6 @@ static void gn_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_GN);
 }
 
-static int nap_probe(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-
-	DBG("path %s", device_get_path(device));
-
-	return connection_register(device, BNEP_SVC_NAP);
-}
-
 static int nap_connect(struct btd_device *dev, struct btd_profile *profile)
 {
 	return connection_connect(dev, BNEP_SVC_NAP);
@@ -202,8 +166,8 @@ static struct btd_profile panu_profile = {
 	.name		= "network-panu",
 	.local_uuid	= NAP_UUID,
 	.remote_uuid	= PANU_UUID,
-	.device_probe	= panu_probe,
-	.device_remove	= network_remove,
+	.device_probe	= connection_register,
+	.device_remove	= connection_unregister,
 	.connect	= panu_connect,
 	.disconnect	= panu_disconnect,
 	.adapter_probe	= panu_server_probe,
@@ -214,8 +178,8 @@ static struct btd_profile gn_profile = {
 	.name		= "network-gn",
 	.local_uuid	= PANU_UUID,
 	.remote_uuid	= GN_UUID,
-	.device_probe	= gn_probe,
-	.device_remove	= network_remove,
+	.device_probe	= connection_register,
+	.device_remove	= connection_unregister,
 	.connect	= gn_connect,
 	.disconnect	= gn_disconnect,
 	.adapter_probe	= gn_server_probe,
@@ -226,8 +190,8 @@ static struct btd_profile nap_profile = {
 	.name		= "network-nap",
 	.local_uuid	= PANU_UUID,
 	.remote_uuid	= NAP_UUID,
-	.device_probe	= nap_probe,
-	.device_remove	= network_remove,
+	.device_probe	= connection_register,
+	.device_remove	= connection_unregister,
 	.connect	= nap_connect,
 	.disconnect	= nap_disconnect,
 	.adapter_probe	= nap_server_probe,
-- 
1.8.1.4

