Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/12] profiles/network: Shortening service name argument to srv
Date: Thu, 26 Feb 2015 12:53:30 +0100
Message-Id: <1424951614-8527-8-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Current argument naming is long and it can be simplified to srv.
---
 profiles/network/connection.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index cc73989..19a0d8d 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -78,9 +78,9 @@ struct network_conn {
 
 static GSList *peers = NULL;
 
-static uint16_t get_service_id(struct btd_service *service)
+static uint16_t get_service_id(struct btd_service *srv)
 {
-	return bnep_service_id(btd_service_get_profile(service)->remote_uuid);
+	return bnep_service_id(btd_service_get_profile(srv)->remote_uuid);
 }
 
 static struct network_peer *find_peer(GSList *list, struct btd_device *device)
@@ -308,11 +308,11 @@ static DBusMessage *local_connect(DBusConnection *conn,
 }
 
 /* Connect and initiate BNEP session */
-int connection_connect(struct btd_service *service)
+int connection_connect(struct btd_service *srv)
 {
-	struct network_conn *nc = btd_service_get_user_data(service);
+	struct network_conn *nc = btd_service_get_user_data(srv);
 	struct network_peer *peer = nc->peer;
-	uint16_t id = get_service_id(service);
+	uint16_t id = get_service_id(srv);
 	GError *err = NULL;
 	const bdaddr_t *src;
 	const bdaddr_t *dst;
@@ -342,9 +342,9 @@ int connection_connect(struct btd_service *service)
 	return 0;
 }
 
-int connection_disconnect(struct btd_service *service)
+int connection_disconnect(struct btd_service *srv)
 {
-	struct network_conn *nc = btd_service_get_user_data(service);
+	struct network_conn *nc = btd_service_get_user_data(srv);
 
 	if (nc->state == DISCONNECTED)
 		return 0;
@@ -496,12 +496,12 @@ static const GDBusPropertyTable connection_properties[] = {
 	{ }
 };
 
-void connection_unregister(struct btd_service *service)
+void connection_unregister(struct btd_service *srv)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	struct network_conn *conn = btd_service_get_user_data(service);
+	struct btd_device *device = btd_service_get_device(srv);
+	struct network_conn *conn = btd_service_get_user_data(srv);
 	struct network_peer *peer = conn->peer;
-	uint16_t id = get_service_id(service);
+	uint16_t id = get_service_id(srv);
 
 	DBG("%s id %u", device_get_path(device), id);
 
@@ -543,12 +543,12 @@ static struct network_peer *create_peer(struct btd_device *device)
 	return peer;
 }
 
-int connection_register(struct btd_service *service)
+int connection_register(struct btd_service *srv)
 {
-	struct btd_device *device = btd_service_get_device(service);
+	struct btd_device *device = btd_service_get_device(srv);
 	struct network_peer *peer;
 	struct network_conn *nc;
-	uint16_t id = get_service_id(service);
+	uint16_t id = get_service_id(srv);
 
 	DBG("%s id %u", device_get_path(device), id);
 
@@ -562,11 +562,11 @@ int connection_register(struct btd_service *service)
 
 	nc = g_new0(struct network_conn, 1);
 	nc->id = id;
-	nc->service = btd_service_ref(service);
+	nc->service = btd_service_ref(srv);
 	nc->state = DISCONNECTED;
 	nc->peer = peer;
 
-	btd_service_set_user_data(service, nc);
+	btd_service_set_user_data(srv, nc);
 
 	DBG("id %u registered", id);
 
-- 
2.1.0

