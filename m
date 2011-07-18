Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 5/6] client: separate agent code from session
Date: Mon, 18 Jul 2011 13:35:15 +0300
Message-Id: <1310985316-2197-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
References: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This should improve modularization of code
---
 Makefile.am      |    3 +-
 client/agent.c   |  251 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/agent.h   |   43 +++++++++
 client/session.c |  174 +++++++-------------------------------
 4 files changed, 327 insertions(+), 144 deletions(-)
 create mode 100644 client/agent.c
 create mode 100644 client/agent.h

diff --git a/Makefile.am b/Makefile.am
index ab73539..8b80da3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -129,7 +129,8 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/pbap.h client/pbap.c \
 				client/sync.h client/sync.c \
 				client/ftp.h client/ftp.c \
-				client/transfer.h client/transfer.c
+				client/transfer.h client/transfer.c \
+				client/agent.h client/agent.c
 
 
 client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @OPENOBEX_LIBS@ @BLUEZ_LIBS@
diff --git a/client/agent.c b/client/agent.c
new file mode 100644
index 0000000..fe2f35d
--- /dev/null
+++ b/client/agent.c
@@ -0,0 +1,251 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+
+#include "log.h"
+#include "agent.h"
+
+#define AGENT_INTERFACE  "org.openobex.Agent"
+
+struct pending_request {
+	DBusPendingCall *call;
+	DBusPendingCallNotifyFunction function;
+	void *data;
+	DBusFreeFunction destroy;
+};
+
+struct agent_data {
+	DBusConnection *conn;
+	char *name;
+	char *path;
+	guint watch;
+	GFunc destroy;
+	void *data;
+	struct pending_request *pending;
+};
+
+static void pending_request_free(struct pending_request *req)
+{
+	if (req->call)
+		dbus_pending_call_unref(req->call);
+
+	if (req->destroy)
+		req->destroy(req->data);
+
+	g_free(req);
+}
+
+void agent_free(struct agent_data *agent)
+{
+	if (agent->watch)
+		g_dbus_remove_watch(agent->conn, agent->watch);
+
+	if (agent->pending) {
+		if (agent->pending->call)
+			dbus_pending_call_cancel(agent->pending->call);
+		pending_request_free(agent->pending);
+	}
+
+	dbus_connection_unref(agent->conn);
+	g_free(agent->name);
+	g_free(agent->path);
+	g_free(agent);
+}
+
+static void agent_disconnected(DBusConnection *connection, void *user_data)
+{
+	struct agent_data *agent = user_data;
+
+	agent->watch = 0;
+
+	if (agent->destroy)
+		agent->destroy(agent, agent->data);
+
+	agent_free(agent);
+}
+
+struct agent_data *agent_create(DBusConnection *conn, const char *name,
+					const char *path, GFunc destroy,
+					void *user_data)
+{
+	struct agent_data *agent;
+
+	agent = g_new0(struct agent_data, 1);
+	agent->conn = dbus_connection_ref(conn);
+	agent->name = g_strdup(name);
+	agent->path = g_strdup(path);
+	agent->destroy = destroy;
+	agent->data = user_data;
+
+	agent->watch = g_dbus_add_disconnect_watch(conn, name,
+							agent_disconnected,
+							agent, NULL);
+
+	return agent;
+}
+
+static void agent_request_reply(DBusPendingCall *call, void *user_data)
+{
+	struct agent_data *agent = user_data;
+	struct pending_request *req = agent->pending;
+
+	if (req->function)
+		req->function(call, req->data);
+
+	pending_request_free(req);
+	agent->pending = NULL;
+}
+
+int agent_request(struct agent_data *agent, const char *path,
+				DBusPendingCallNotifyFunction function,
+				void *user_data, DBusFreeFunction destroy)
+{
+	struct pending_request *req;
+	DBusMessage *message;
+
+	if (agent->pending)
+		return -EBUSY;
+
+	DBG("%s", path);
+
+	message = dbus_message_new_method_call(agent->name,
+			agent->path, AGENT_INTERFACE, "Request");
+
+	dbus_message_append_args(message,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID);
+
+	req = g_new0(struct pending_request, 1);
+	req->function = function;
+	req->destroy = destroy;
+	req->data = user_data;
+
+	if (!dbus_connection_send_with_reply(agent->conn, message,
+						&req->call, -1)) {
+		g_free(req);
+		dbus_message_unref(message);
+		return -ENOMEM;
+	}
+
+	agent->pending = req;
+
+	dbus_message_unref(message);
+
+	dbus_pending_call_set_notify(req->call, agent_request_reply,
+					agent, NULL);
+
+	return 0;
+}
+
+void agent_notify_progress(struct agent_data *agent, const char *path,
+							guint64 transferred)
+{
+	DBusMessage *message;
+
+	DBG("%s", path);
+
+	message = dbus_message_new_method_call(agent->name,
+			agent->path, AGENT_INTERFACE, "Progress");
+	if (message == NULL)
+		return;
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	dbus_message_append_args(message,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_UINT64, &transferred,
+			DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(agent->conn, message);
+}
+
+void agent_notify_complete(struct agent_data *agent, const char *path)
+{
+	DBusMessage *message;
+
+	DBG("%s", path);
+
+	message = dbus_message_new_method_call(agent->name,
+			agent->path, AGENT_INTERFACE, "Complete");
+	if (message == NULL)
+		return;
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	dbus_message_append_args(message,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(agent->conn, message);
+}
+
+void agent_notify_error(struct agent_data *agent, const char *path,
+							const char *err)
+{
+	DBusMessage *message;
+
+	DBG("%s", path);
+
+	message = dbus_message_new_method_call(agent->name,
+			agent->path, AGENT_INTERFACE, "Error");
+	if (message == NULL)
+		return;
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	dbus_message_append_args(message,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_STRING, &err,
+			DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(agent->conn, message);
+}
+
+void agent_release(struct agent_data *agent)
+{
+	DBusMessage *message;
+
+	DBG("");
+
+	message = dbus_message_new_method_call(agent->name,
+			agent->path, AGENT_INTERFACE, "Release");
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	g_dbus_send_message(agent->conn, message);
+}
+
+const char *agent_get_name(struct agent_data *agent)
+{
+	return agent->name;
+}
+
+const char *agent_get_path(struct agent_data *agent)
+{
+	return agent->path;
+}
diff --git a/client/agent.h b/client/agent.h
new file mode 100644
index 0000000..6fc3ffd
--- /dev/null
+++ b/client/agent.h
@@ -0,0 +1,43 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2007-2010  Intel Corporation
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <gdbus.h>
+
+struct agent_data;
+
+struct agent_data *agent_create(DBusConnection *conn, const char *name,
+					const char *path, GFunc destroy,
+					void *user_data);
+void agent_free(struct agent_data *agent);
+const char *agent_get_name(struct agent_data *agent);
+const char *agent_get_path(struct agent_data *agent);
+int agent_request(struct agent_data *agent, const char *path,
+				DBusPendingCallNotifyFunction function,
+				void *user_data, DBusFreeFunction destroy);
+void agent_notify_progress(struct agent_data *agent, const char *path,
+							guint64 transferred);
+void agent_notify_complete(struct agent_data *agent, const char *path);
+void agent_notify_error(struct agent_data *agent, const char *path,
+							const char *err);
+void agent_release(struct agent_data *agent);
diff --git a/client/session.c b/client/session.c
index f2168b4..a89c760 100644
--- a/client/session.c
+++ b/client/session.c
@@ -47,8 +47,7 @@
 #include "transfer.h"
 #include "session.h"
 #include "btio.h"
-
-#define AGENT_INTERFACE  "org.openobex.Agent"
+#include "agent.h"
 
 #define SESSION_INTERFACE  "org.openobex.Session"
 #define SESSION_BASEPATH   "/org/openobex"
@@ -79,19 +78,11 @@ struct session_callback {
 };
 
 struct pending_data {
-	DBusPendingCall *call;
 	session_callback_t cb;
 	struct session_data *session;
 	struct transfer_data *transfer;
 };
 
-struct agent_data {
-	char *name;
-	char *path;
-	guint watch;
-	struct pending_data *pending;
-};
-
 struct pending_req {
 	DBusPendingCall *call;
 	void *user_data;
@@ -144,48 +135,6 @@ struct session_data *session_ref(struct session_data *session)
 	return session;
 }
 
-static void free_pending(struct pending_data *pending)
-{
-	if (pending->call)
-		dbus_pending_call_unref(pending->call);
-
-	g_free(pending);
-}
-
-static void agent_free(struct session_data *session)
-{
-	struct agent_data *agent = session->agent;
-
-	if (agent->watch)
-		g_dbus_remove_watch(session->conn, agent->watch);
-
-	if (agent->pending) {
-		dbus_pending_call_cancel(agent->pending->call);
-		free_pending(agent->pending);
-	}
-
-	session->agent = NULL;
-
-	g_free(agent->name);
-	g_free(agent->path);
-	g_free(agent);
-}
-
-static void agent_release(struct session_data *session)
-{
-	struct agent_data *agent = session->agent;
-	DBusMessage *message;
-
-	message = dbus_message_new_method_call(agent->name,
-			agent->path, AGENT_INTERFACE, "Release");
-
-	dbus_message_set_no_reply(message, TRUE);
-
-	g_dbus_send_message(session->conn, message);
-
-	agent_free(session);
-}
-
 static void session_unregistered(struct session_data *session)
 {
 	char *path;
@@ -250,8 +199,10 @@ static void session_free(struct session_data *session)
 		pending_req_finalize(req);
 	}
 
-	if (session->agent)
-		agent_release(session);
+	if (session->agent) {
+		agent_release(session->agent);
+		agent_free(session->agent);
+	}
 
 	if (session->watch)
 		g_dbus_remove_watch(session->conn, session->watch);
@@ -898,15 +849,6 @@ void session_shutdown(struct session_data *session)
 	session_unref(session);
 }
 
-static void agent_disconnected(DBusConnection *connection, void *user_data)
-{
-	struct session_data *session = user_data;
-
-	session->agent->watch = 0;
-
-	agent_free(session);
-}
-
 static DBusMessage *assign_agent(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
@@ -947,13 +889,14 @@ static DBusMessage *release_agent(DBusConnection *connection,
 
 	sender = dbus_message_get_sender(message);
 
-	if (agent == NULL || g_str_equal(sender, agent->name) == FALSE ||
-				g_str_equal(path, agent->path) == FALSE)
+	if (agent == NULL ||
+			g_str_equal(sender, agent_get_name(agent)) == FALSE ||
+			g_str_equal(path, agent_get_path(agent)) == FALSE)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.NotAuthorized",
 				"Not Authorized");
 
-	agent_free(session);
+	agent_free(agent);
 
 	return dbus_message_new_method_return(message);
 }
@@ -1034,9 +977,8 @@ static GDBusMethodTable session_methods[] = {
 
 static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 {
-	struct session_data *session = user_data;
-	struct agent_data *agent = session->agent;
-	struct pending_data *pending = agent->pending;
+	struct pending_data *pending = user_data;
+	struct session_data *session = pending->session;
 	DBusMessage *reply = dbus_pending_call_steal_reply(call);
 	const char *name;
 	DBusError derr;
@@ -1067,11 +1009,8 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 	if (strlen(name))
 		transfer_set_name(pending->transfer, name);
 
-	agent->pending = NULL;
-
 	pending->cb(session, NULL, pending->transfer);
 	dbus_message_unref(reply);
-	free_pending(pending);
 
 	return;
 }
@@ -1082,7 +1021,7 @@ static gboolean session_request_proceed(gpointer data)
 	struct transfer_data *transfer = pending->transfer;
 
 	pending->cb(pending->session, NULL, transfer);
-	free_pending(pending);
+	g_free(pending);
 
 	return FALSE;
 }
@@ -1091,9 +1030,9 @@ static int session_request(struct session_data *session, session_callback_t cb,
 				struct transfer_data *transfer)
 {
 	struct agent_data *agent = session->agent;
-	DBusMessage *message;
 	struct pending_data *pending;
 	const char *path;
+	int err;
 
 	pending = g_new0(struct pending_data, 1);
 	pending->cb = cb;
@@ -1107,28 +1046,13 @@ static int session_request(struct session_data *session, session_callback_t cb,
 		return 0;
 	}
 
-	message = dbus_message_new_method_call(agent->name,
-			agent->path, AGENT_INTERFACE, "Request");
-
-	dbus_message_append_args(message,
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_INVALID);
-
-	if (!dbus_connection_send_with_reply(session->conn, message,
-						&pending->call, -1)) {
-		dbus_message_unref(message);
-		return -ENOMEM;
+	err = agent_request(agent, path, session_request_reply, pending,
+								g_free);
+	if (err < 0) {
+		g_free(pending);
+		return err;
 	}
 
-	agent->pending = pending;
-
-	dbus_message_unref(message);
-
-	dbus_pending_call_set_notify(pending->call, session_request_reply,
-					session, NULL);
-
-	DBG("Agent.Request(\"%s\")", path);
-
 	return 0;
 }
 
@@ -1158,7 +1082,6 @@ static void session_notify_complete(struct session_data *session,
 				struct transfer_data *transfer)
 {
 	struct agent_data *agent = session->agent;
-	DBusMessage *message;
 	const char *path;
 
 	path = transfer_get_path(transfer);
@@ -1166,18 +1089,7 @@ static void session_notify_complete(struct session_data *session,
 	if (agent == NULL || path == NULL)
 		goto done;
 
-	message = dbus_message_new_method_call(agent->name,
-			agent->path, AGENT_INTERFACE, "Complete");
-	if (message == NULL)
-		return;
-
-	dbus_message_set_no_reply(message, TRUE);
-
-	dbus_message_append_args(message,
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_INVALID);
-
-	g_dbus_send_message(session->conn, message);
+	agent_notify_complete(agent, path);
 
 done:
 
@@ -1191,26 +1103,13 @@ static void session_notify_error(struct session_data *session,
 				GError *err)
 {
 	struct agent_data *agent = session->agent;
-	DBusMessage *message;
 	const char *path;
 
 	path = transfer_get_path(transfer);
 	if (agent == NULL || path == NULL)
 		goto done;
 
-	message = dbus_message_new_method_call(agent->name,
-			agent->path, AGENT_INTERFACE, "Error");
-	if (message == NULL)
-		return;
-
-	dbus_message_set_no_reply(message, TRUE);
-
-	dbus_message_append_args(message,
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_STRING, &err->message,
-			DBUS_TYPE_INVALID);
-
-	g_dbus_send_message(session->conn, message);
+	agent_notify_error(agent, path, err->message);
 
 done:
 	error("Transfer(%p) Error: %s", transfer, err->message);
@@ -1223,26 +1122,13 @@ static void session_notify_progress(struct session_data *session,
 					gint64 transferred)
 {
 	struct agent_data *agent = session->agent;
-	DBusMessage *message;
 	const char *path;
 
 	path = transfer_get_path(transfer);
 	if (agent == NULL || path == NULL)
 		goto done;
 
-	message = dbus_message_new_method_call(agent->name,
-			agent->path, AGENT_INTERFACE, "Progress");
-	if (message == NULL)
-		goto done;
-
-	dbus_message_set_no_reply(message, TRUE);
-
-	dbus_message_append_args(message,
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_UINT64, &transferred,
-			DBUS_TYPE_INVALID);
-
-	g_dbus_send_message(session->conn, message);
+	agent_notify_progress(agent, path, transferred);
 
 done:
 	DBG("Transfer(%p) progress: %ld bytes", transfer,
@@ -1488,6 +1374,13 @@ int session_put(struct session_data *session, char *buf, const char *targetname)
 	return 0;
 }
 
+static void agent_destroy(gpointer data, gpointer user_data)
+{
+	struct session_data *session = user_data;
+
+	session->agent = NULL;
+}
+
 int session_set_agent(struct session_data *session, const char *name,
 							const char *path)
 {
@@ -1499,17 +1392,12 @@ int session_set_agent(struct session_data *session, const char *name,
 	if (session->agent)
 		return -EALREADY;
 
-	agent = g_new0(struct agent_data, 1);
-	agent->name = g_strdup(name);
-	agent->path = g_strdup(path);
+	agent = agent_create(session->conn, name, path, agent_destroy,
+								session);
 
 	if (session->watch == 0)
 		session_set_owner(session, name, owner_disconnected);
 
-	agent->watch = g_dbus_add_disconnect_watch(session->conn, name,
-							agent_disconnected,
-							session, NULL);
-
 	session->agent = agent;
 
 	return 0;
@@ -1526,7 +1414,7 @@ const char *session_get_agent(struct session_data *session)
 	if (agent == NULL)
 		return NULL;
 
-	return agent->name;
+	return agent_get_name(session->agent);
 }
 
 const char *session_get_owner(struct session_data *session)
-- 
1.7.6

