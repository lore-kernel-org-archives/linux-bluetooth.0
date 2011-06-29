Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] Make use of g_slist_free_full on network plugin
Date: Wed, 29 Jun 2011 11:52:51 +0300
Message-Id: <1309337573-8295-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
References: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 network/connection.c |    7 ++++---
 network/server.c     |    5 +----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/network/connection.c b/network/connection.c
index 181274a..ac27cf2 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -477,8 +477,10 @@ static DBusMessage *connection_get_properties(DBusConnection *conn,
 	return reply;
 }
 
-static void connection_free(struct network_conn *nc)
+static void connection_free(void *data)
 {
+	struct network_conn *nc = data;
+
 	if (nc->dc_id)
 		device_remove_disconnect_watch(nc->peer->device, nc->dc_id);
 
@@ -490,8 +492,7 @@ static void connection_free(struct network_conn *nc)
 
 static void peer_free(struct network_peer *peer)
 {
-	g_slist_foreach(peer->connections, (GFunc) connection_free, NULL);
-	g_slist_free(peer->connections);
+	g_slist_free_full(peer->connections, connection_free);
 	btd_device_unref(peer->device);
 	g_free(peer->path);
 	g_free(peer);
diff --git a/network/server.c b/network/server.c
index 5feb9d0..7865f39 100644
--- a/network/server.c
+++ b/network/server.c
@@ -677,10 +677,7 @@ static void server_free(struct network_server *ns)
 	g_free(ns->name);
 	g_free(ns->bridge);
 
-	if (ns->sessions) {
-		g_slist_foreach(ns->sessions, (GFunc) session_free, NULL);
-		g_slist_free(ns->sessions);
-	}
+	g_slist_free_full(ns->sessions, session_free);
 
 	g_free(ns);
 }
-- 
1.7.5.4

