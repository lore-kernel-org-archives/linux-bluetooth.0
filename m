Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] network: use btd_error_failed()
Date: Mon, 13 Dec 2010 19:33:03 -0200
Message-Id: <1292275987-13799-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292275987-13799-6-git-send-email-padovan@profusion.mobi>
References: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-2-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-3-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-4-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-5-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-6-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 network/connection.c |   30 ++----------------------------
 network/server.c     |   13 +++----------
 2 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/network/connection.c b/network/connection.c
index 89c38d8..09a4f3c 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -111,32 +111,6 @@ static struct network_conn *find_connection(GSList *list, uint16_t id)
 	return NULL;
 }
 
-static inline DBusMessage *not_supported(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"Not supported");
-}
-
-static inline DBusMessage *already_connected(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"Device already connected");
-}
-
-static inline DBusMessage *not_permited(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"Operation not permited");
-}
-
-static inline DBusMessage *connection_attempt_failed(DBusMessage *msg,
-							const char *err)
-{
-	return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".ConnectionAttemptFailed",
-				"%s", err ? err : "Connection attempt failed");
-}
-
 static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
@@ -182,7 +156,7 @@ static void cancel_connection(struct network_conn *nc, const char *err_msg)
 	}
 
 	if (nc->msg && err_msg) {
-		reply = connection_attempt_failed(nc->msg, err_msg);
+		reply = btd_error_failed(nc->msg, err_msg);
 		g_dbus_send_message(connection, reply);
 	}
 
@@ -409,7 +383,7 @@ static DBusMessage *connection_connect(DBusConnection *conn,
 	if (!nc->io) {
 		DBusMessage *reply;
 		error("%s", err->message);
-		reply = connection_attempt_failed(msg, err->message);
+		reply = btd_error_failed(msg, err->message);
 		g_error_free(err);
 		return reply;
 	}
diff --git a/network/server.c b/network/server.c
index 60e1a81..7c63c3e 100644
--- a/network/server.c
+++ b/network/server.c
@@ -566,13 +566,6 @@ static uint32_t register_server_record(struct network_server *ns)
 	return record->handle;
 }
 
-
-static inline DBusMessage *failed(DBusMessage *msg, const char *description)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"%s", description);
-}
-
 static void server_disconnect(DBusConnection *conn, void *user_data)
 {
 	struct network_server *ns = user_data;
@@ -600,7 +593,7 @@ static DBusMessage *register_server(DBusConnection *conn,
 		return NULL;
 
 	if (g_strcmp0(uuid, "nap"))
-		return failed(msg, "Invalid UUID");
+		return btd_error_failed(msg, "Invalid UUID");
 
 	if (ns->record_id)
 		return btd_error_already_exists(msg);
@@ -611,7 +604,7 @@ static DBusMessage *register_server(DBusConnection *conn,
 
 	ns->record_id = register_server_record(ns);
 	if (!ns->record_id)
-		return failed(msg, "SDP record registration failed");
+		return btd_error_failed(msg, "SDP record registration failed");
 
 	g_free(ns->bridge);
 	ns->bridge = g_strdup(bridge);
@@ -635,7 +628,7 @@ static DBusMessage *unregister_server(DBusConnection *conn,
 		return NULL;
 
 	if (g_strcmp0(uuid, "nap"))
-		return failed(msg, "Invalid UUID");
+		return btd_error_failed(msg, "Invalid UUID");
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
-- 
1.7.3.2

