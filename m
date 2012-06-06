Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 12/17] SAP: Fix removing connection from server
Date: Wed, 6 Jun 2012 15:19:22 +0200
Message-ID: <1338988767-19467-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

NULL conn member of server structure passed to function instead of
static variable. This is to properly support multiple adapters.
Also rename sap_conn_remove to sap_server_remove_conn.
---
 sap/server.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index f259bb0..95f621b 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1081,8 +1081,10 @@ error_rsp:
 	return -EBADMSG;
 }
 
-static void sap_conn_remove(struct sap_connection *conn)
+static void sap_server_remove_conn(struct sap_server *server)
 {
+	struct sap_connection *conn = server->conn;
+
 	DBG("conn %p", conn);
 
 	if (!conn)
@@ -1093,9 +1095,8 @@ static void sap_conn_remove(struct sap_connection *conn)
 		g_io_channel_unref(conn->io);
 	}
 
-	conn->io = NULL;
 	g_free(conn);
-	sap_server->conn = NULL;
+	server->conn = NULL;
 }
 
 static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
@@ -1162,7 +1163,7 @@ static void sap_io_destroy(void *data)
 			conn->state == SAP_STATE_GRACEFUL_DISCONNECT)
 		sap_disconnect_req(server, 1);
 
-	sap_conn_remove(conn);
+	sap_server_remove_conn(server);
 }
 
 static void sap_connect_cb(GIOChannel *io, GError *gerr, gpointer data)
@@ -1197,14 +1198,14 @@ static void connect_auth_cb(DBusError *derr, void *data)
 
 	if (derr && dbus_error_is_set(derr)) {
 		error("Access has been denied (%s)", derr->message);
-		sap_conn_remove(conn);
+		sap_server_remove_conn(server);
 		return;
 	}
 
 	if (!bt_io_accept(conn->io, sap_connect_cb, server, NULL, &gerr)) {
 		error("bt_io_accept: %s", gerr->message);
 		g_error_free(gerr);
-		sap_conn_remove(conn);
+		sap_server_remove_conn(server);
 		return;
 	}
 
@@ -1252,7 +1253,7 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 	if (gerr) {
 		error("%s", gerr->message);
 		g_error_free(gerr);
-		sap_conn_remove(conn);
+		sap_server_remove_conn(server);
 		return;
 	}
 
@@ -1262,7 +1263,7 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 								server);
 	if (err < 0) {
 		error("Authorization failure (err %d)", err);
-		sap_conn_remove(conn);
+		sap_server_remove_conn(server);
 		return;
 	}
 
@@ -1347,7 +1348,7 @@ static void server_free(struct sap_server *server)
 	if (!server)
 		return;
 
-	sap_conn_remove(server->conn);
+	sap_server_remove_conn(server);
 	g_free(server->path);
 	g_free(server);
 	server = NULL;
@@ -1440,8 +1441,7 @@ int sap_server_unregister(const char *path)
 
 	remove_record_from_server(sap_server->record_id);
 
-	if (sap_server->conn)
-		sap_conn_remove(sap_server->conn);
+	sap_server_remove_conn(sap_server);
 
 	if (sap_server->listen_io) {
 		g_io_channel_shutdown(sap_server->listen_io, TRUE, NULL);
-- 
on behalf of ST-Ericsson

