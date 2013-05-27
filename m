Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 3/6] network: Remove find_connection()
Date: Mon, 27 May 2013 14:04:06 +0200
Message-Id: <1369656249-27980-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The userdata pointer in btd_service provides the necessary information
to find which service should be connected. This makes possible to remove
the restriction of having one single UUID instance per profile.
---
 profiles/network/connection.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index bac3b69..960a1fe 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -102,18 +102,6 @@ static struct network_peer *find_peer(GSList *list, struct btd_device *device)
 	return NULL;
 }
 
-static struct network_conn *find_connection(GSList *list, uint16_t id)
-{
-	for (; list; list = list->next) {
-		struct network_conn *nc = list->data;
-
-		if (nc->id == id)
-			return nc;
-	}
-
-	return NULL;
-}
-
 static struct network_conn *find_connection_by_state(GSList *list,
 							conn_state state)
 {
@@ -414,8 +402,10 @@ static DBusMessage *local_connect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct network_peer *peer = data;
+	struct btd_service *service;
 	struct network_conn *nc;
 	const char *svc;
+	const char *uuid;
 	uint16_t id;
 	int err;
 
@@ -424,11 +414,17 @@ static DBusMessage *local_connect(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 
 	id = bnep_service_id(svc);
+	uuid = bnep_uuid(id);
 
-	nc = find_connection(peer->connections, id);
-	if (nc == NULL)
+	if (uuid == NULL)
 		return btd_error_invalid_args(msg);
 
+	service = btd_device_get_service(peer->device, uuid);
+	if (service == NULL)
+		return btd_error_not_supported(msg);
+
+	nc = btd_service_get_user_data(service);
+
 	if (nc->connect != NULL)
 		return btd_error_busy(msg);
 
@@ -694,13 +690,6 @@ int connection_register(struct btd_service *service)
 		peers = g_slist_append(peers, peer);
 	}
 
-	nc = find_connection(peer->connections, id);
-	if (nc) {
-		error("Device %s has multiple connection instances of %d",
-						device_get_path(device), id);
-		return -1;
-	}
-
 	nc = g_new0(struct network_conn, 1);
 	nc->id = id;
 	memset(nc->dev, 0, sizeof(nc->dev));
-- 
1.8.1.4

