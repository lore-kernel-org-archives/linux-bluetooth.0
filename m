Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 22/27] network: Hold a reference to btd_service
Date: Fri, 26 Apr 2013 08:17:18 +0200
Message-Id: <1366957043-2383-23-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Profile implementations are allowed to hold a reference to probed
services and make use of the service's userdata pointer, so update the
network profiles accordingly.
---
 profiles/network/connection.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 16ee318..8fbde14 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -67,6 +67,7 @@ struct network_peer {
 };
 
 struct network_conn {
+	struct btd_service *service;
 	char		dev[16];	/* Interface name */
 	uint16_t	id;		/* Role: Service Class Identifier */
 	conn_state	state;
@@ -606,6 +607,7 @@ static void connection_free(void *data)
 	if (nc->connect)
 		dbus_message_unref(nc->connect);
 
+	btd_service_unref(nc->service);
 	g_free(nc);
 }
 
@@ -649,15 +651,12 @@ static const GDBusPropertyTable connection_properties[] = {
 void connection_unregister(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct network_peer *peer;
+	struct network_conn *conn = btd_service_get_user_data(service);
+	struct network_peer *peer = conn->peer;
 	uint16_t id = get_service_id(service);
 
 	DBG("%s id %u", device_get_path(device), id);
 
-	peer = find_peer(peers, device);
-	if (!peer)
-		return;
-
 	g_slist_free_full(peer->connections, connection_free);
 	peer->connections = NULL;
 
@@ -721,9 +720,12 @@ int connection_register(struct btd_service *service)
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
-- 
1.8.1.4

