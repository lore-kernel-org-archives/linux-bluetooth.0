Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 08/17] client: Remove D-Bus agent
Date: Tue, 29 May 2012 11:23:13 +0200
Message-Id: <1338283402-11085-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338283402-11085-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338283402-11085-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The authorization mechanism is entirely removed from the session, and
thus transfers are automatically started (once popped from the queue)
without confirmation and without any name/filename change.
---
 Makefile.am      |    1 -
 client/agent.c   |  252 ------------------------------------------------------
 client/agent.h   |   43 ---------
 client/session.c |  218 +----------------------------------------------
 client/session.h |    4 -
 5 files changed, 2 insertions(+), 516 deletions(-)
 delete mode 100644 client/agent.c
 delete mode 100644 client/agent.h

diff --git a/Makefile.am b/Makefile.am
index 86f9ad1..5cc0603 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -124,7 +124,6 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/opp.h client/opp.c \
 				client/map.h client/map.c \
 				client/transfer.h client/transfer.c \
-				client/agent.h client/agent.c \
 				client/transport.h client/transport.c \
 				client/dbus.h client/dbus.c \
 				client/driver.h client/driver.c \
diff --git a/client/agent.c b/client/agent.c
deleted file mode 100644
index 929a05f..0000000
--- a/client/agent.c
+++ /dev/null
@@ -1,252 +0,0 @@
-/*
- *
- *  OBEX Client
- *
- *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-
-#include "log.h"
-#include "agent.h"
-
-#define AGENT_INTERFACE  "org.openobex.Agent"
-
-struct pending_request {
-	DBusPendingCall *call;
-	DBusPendingCallNotifyFunction function;
-	void *data;
-	DBusFreeFunction destroy;
-};
-
-struct obc_agent {
-	DBusConnection *conn;
-	char *name;
-	char *path;
-	guint watch;
-	GFunc destroy;
-	void *data;
-	struct pending_request *pending;
-};
-
-static void pending_request_free(struct pending_request *req)
-{
-	if (req->call)
-		dbus_pending_call_unref(req->call);
-
-	if (req->destroy)
-		req->destroy(req->data);
-
-	g_free(req);
-}
-
-void obc_agent_free(struct obc_agent *agent)
-{
-	if (agent->watch)
-		g_dbus_remove_watch(agent->conn, agent->watch);
-
-	if (agent->pending) {
-		if (agent->pending->call)
-			dbus_pending_call_cancel(agent->pending->call);
-		pending_request_free(agent->pending);
-	}
-
-	dbus_connection_unref(agent->conn);
-	g_free(agent->name);
-	g_free(agent->path);
-	g_free(agent);
-}
-
-static void agent_disconnected(DBusConnection *connection, void *user_data)
-{
-	struct obc_agent *agent = user_data;
-
-	agent->watch = 0;
-
-	if (agent->destroy)
-		agent->destroy(agent, agent->data);
-
-	obc_agent_free(agent);
-}
-
-struct obc_agent *obc_agent_create(DBusConnection *conn, const char *name,
-					const char *path, GFunc destroy,
-					void *user_data)
-{
-	struct obc_agent *agent;
-
-	agent = g_new0(struct obc_agent, 1);
-	agent->conn = dbus_connection_ref(conn);
-	agent->name = g_strdup(name);
-	agent->path = g_strdup(path);
-	agent->destroy = destroy;
-	agent->data = user_data;
-
-	agent->watch = g_dbus_add_disconnect_watch(conn, name,
-							agent_disconnected,
-							agent, NULL);
-
-	return agent;
-}
-
-static void agent_request_reply(DBusPendingCall *call, void *user_data)
-{
-	struct obc_agent *agent = user_data;
-	struct pending_request *req = agent->pending;
-
-	agent->pending = NULL;
-
-	if (req->function)
-		req->function(call, req->data);
-
-	pending_request_free(req);
-}
-
-int obc_agent_request(struct obc_agent *agent, const char *path,
-				DBusPendingCallNotifyFunction function,
-				void *user_data, DBusFreeFunction destroy)
-{
-	struct pending_request *req;
-	DBusMessage *message;
-
-	if (agent->pending)
-		return -EBUSY;
-
-	DBG("%s", path);
-
-	message = dbus_message_new_method_call(agent->name,
-			agent->path, AGENT_INTERFACE, "Request");
-
-	dbus_message_append_args(message,
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_INVALID);
-
-	req = g_new0(struct pending_request, 1);
-	req->function = function;
-	req->destroy = destroy;
-	req->data = user_data;
-
-	if (!dbus_connection_send_with_reply(agent->conn, message,
-						&req->call, -1)) {
-		g_free(req);
-		dbus_message_unref(message);
-		return -ENOMEM;
-	}
-
-	agent->pending = req;
-
-	dbus_message_unref(message);
-
-	dbus_pending_call_set_notify(req->call, agent_request_reply,
-					agent, NULL);
-
-	return 0;
-}
-
-void obc_agent_notify_progress(struct obc_agent *agent, const char *path,
-							guint64 transferred)
-{
-	DBusMessage *message;
-
-	DBG("%s", path);
-
-	message = dbus_message_new_method_call(agent->name,
-			agent->path, AGENT_INTERFACE, "Progress");
-	if (message == NULL)
-		return;
-
-	dbus_message_set_no_reply(message, TRUE);
-
-	dbus_message_append_args(message,
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_UINT64, &transferred,
-			DBUS_TYPE_INVALID);
-
-	g_dbus_send_message(agent->conn, message);
-}
-
-void obc_agent_notify_complete(struct obc_agent *agent, const char *path)
-{
-	DBusMessage *message;
-
-	DBG("%s", path);
-
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
-	g_dbus_send_message(agent->conn, message);
-}
-
-void obc_agent_notify_error(struct obc_agent *agent, const char *path,
-							const char *err)
-{
-	DBusMessage *message;
-
-	DBG("%s", path);
-
-	message = dbus_message_new_method_call(agent->name,
-			agent->path, AGENT_INTERFACE, "Error");
-	if (message == NULL)
-		return;
-
-	dbus_message_set_no_reply(message, TRUE);
-
-	dbus_message_append_args(message,
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_STRING, &err,
-			DBUS_TYPE_INVALID);
-
-	g_dbus_send_message(agent->conn, message);
-}
-
-void obc_agent_release(struct obc_agent *agent)
-{
-	DBusMessage *message;
-
-	DBG("");
-
-	message = dbus_message_new_method_call(agent->name,
-			agent->path, AGENT_INTERFACE, "Release");
-
-	dbus_message_set_no_reply(message, TRUE);
-
-	g_dbus_send_message(agent->conn, message);
-}
-
-const char *obc_agent_get_name(struct obc_agent *agent)
-{
-	return agent->name;
-}
-
-const char *obc_agent_get_path(struct obc_agent *agent)
-{
-	return agent->path;
-}
diff --git a/client/agent.h b/client/agent.h
deleted file mode 100644
index 69f2ffe..0000000
--- a/client/agent.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- *
- *  OBEX Client
- *
- *  Copyright (C) 2007-2010  Intel Corporation
- *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#include <gdbus.h>
-
-struct obc_agent;
-
-struct obc_agent *obc_agent_create(DBusConnection *conn, const char *name,
-					const char *path, GFunc destroy,
-					void *user_data);
-void obc_agent_free(struct obc_agent *agent);
-const char *obc_agent_get_name(struct obc_agent *agent);
-const char *obc_agent_get_path(struct obc_agent *agent);
-int obc_agent_request(struct obc_agent *agent, const char *path,
-				DBusPendingCallNotifyFunction function,
-				void *user_data, DBusFreeFunction destroy);
-void obc_agent_notify_progress(struct obc_agent *agent, const char *path,
-							guint64 transferred);
-void obc_agent_notify_complete(struct obc_agent *agent, const char *path);
-void obc_agent_notify_error(struct obc_agent *agent, const char *path,
-							const char *err);
-void obc_agent_release(struct obc_agent *agent);
diff --git a/client/session.c b/client/session.c
index 9c4c9f0..989439c 100644
--- a/client/session.c
+++ b/client/session.c
@@ -41,7 +41,6 @@
 #include "log.h"
 #include "transfer.h"
 #include "session.h"
-#include "agent.h"
 #include "driver.h"
 #include "transport.h"
 
@@ -92,7 +91,6 @@ struct obc_session {
 	gchar *path;		/* Session path */
 	DBusConnection *conn;
 	GObex *obex;
-	struct obc_agent *agent;
 	struct pending_request *p;
 	gchar *owner;		/* Session owner */
 	guint watch;
@@ -175,11 +173,6 @@ static void session_free(struct obc_session *session)
 {
 	DBG("%p", session);
 
-	if (session->agent) {
-		obc_agent_release(session->agent);
-		obc_agent_free(session->agent);
-	}
-
 	if (session->queue) {
 		g_queue_foreach(session->queue, (GFunc) pending_request_free,
 									NULL);
@@ -529,60 +522,6 @@ void obc_session_shutdown(struct obc_session *session)
 	obc_session_unref(session);
 }
 
-static DBusMessage *assign_agent(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	struct obc_session *session = user_data;
-	const gchar *sender, *path;
-
-	if (dbus_message_get_args(message, NULL,
-					DBUS_TYPE_OBJECT_PATH, &path,
-					DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments",
-				"Invalid arguments in method call");
-
-	sender = dbus_message_get_sender(message);
-
-	if (obc_session_set_agent(session, sender, path) < 0)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.AlreadyExists",
-				"Already exists");
-
-	return dbus_message_new_method_return(message);
-}
-
-static DBusMessage *release_agent(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	struct obc_session *session = user_data;
-	struct obc_agent *agent = session->agent;
-	const gchar *sender;
-	gchar *path;
-
-	if (dbus_message_get_args(message, NULL,
-					DBUS_TYPE_OBJECT_PATH, &path,
-					DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments",
-				"Invalid arguments in method call");
-
-	sender = dbus_message_get_sender(message);
-
-	if (agent == NULL)
-		return dbus_message_new_method_return(message);
-
-	if (g_str_equal(sender, obc_agent_get_name(agent)) == FALSE ||
-			g_str_equal(path, obc_agent_get_path(agent)) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.NotAuthorized",
-				"Not Authorized");
-
-	obc_agent_free(agent);
-
-	return dbus_message_new_method_return(message);
-}
-
 static DBusMessage *session_get_properties(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
@@ -685,79 +624,12 @@ static const GDBusMethodTable session_methods[] = {
 	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				session_get_properties) },
-	{ GDBUS_METHOD("AssignAgent",
-				GDBUS_ARGS({ "agent", "o" }), NULL,
-				assign_agent) },
-	{ GDBUS_METHOD("ReleaseAgent",
-				GDBUS_ARGS({ "agent", "o" }), NULL,
-				release_agent) },
 	{ GDBUS_ASYNC_METHOD("GetCapabilities",
 				NULL, GDBUS_ARGS({ "capabilities", "s" }),
 				get_capabilities) },
 	{ }
 };
 
-static void session_request_reply(DBusPendingCall *call, gpointer user_data)
-{
-	struct obc_session *session = user_data;
-	struct pending_request *p = session->p;
-	struct obc_transfer *transfer = p->transfer;
-	DBusMessage *reply = dbus_pending_call_steal_reply(call);
-	const char *name;
-	DBusError derr;
-	int err;
-
-	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		GError *gerr = NULL;
-
-		error("Replied with an error: %s, %s",
-				derr.name, derr.message);
-		dbus_error_free(&derr);
-		dbus_message_unref(reply);
-
-		g_set_error(&gerr, OBEX_IO_ERROR, -ECANCELED, "%s",
-								derr.message);
-		session_terminate_transfer(session, transfer, gerr);
-		g_clear_error(&gerr);
-
-		return;
-	}
-
-	dbus_message_get_args(reply, NULL,
-			DBUS_TYPE_STRING, &name,
-			DBUS_TYPE_INVALID);
-
-	DBG("Agent.Request() reply: %s", name);
-
-	if (strlen(name) == 0)
-		goto done;
-
-	if (obc_transfer_get_operation(transfer) == G_OBEX_OP_PUT) {
-		obc_transfer_set_name(transfer, name);
-		goto done;
-	}
-
-	err = obc_transfer_set_filename(transfer, name);
-	if (err < 0) {
-		GError *gerr = NULL;
-
-		g_set_error(&gerr, OBEX_IO_ERROR, err,
-						"Unable to set filename");
-		session_terminate_transfer(session, transfer, gerr);
-		g_clear_error(&gerr);
-		return;
-	}
-
-done:
-	if (p->auth_complete)
-		p->auth_complete(session, transfer);
-
-	dbus_message_unref(reply);
-
-	return;
-}
-
 static gboolean session_request_proceed(gpointer data)
 {
 	struct obc_session *session = data;
@@ -772,19 +644,8 @@ static gboolean session_request_proceed(gpointer data)
 
 static int pending_request_auth(struct pending_request *p)
 {
-	struct obc_session *session = p->session;
-	struct obc_agent *agent = session->agent;
-	const char *path;
-
-	path = obc_transfer_get_path(p->transfer);
-
-	if (agent == NULL || path == NULL) {
-		g_idle_add(session_request_proceed, session);
-		return 0;
-	}
-
-	return obc_agent_request(agent, path, session_request_reply, session,
-									NULL);
+	g_idle_add(session_request_proceed, p->session);
+	return 0;
 }
 
 guint obc_session_queue(struct obc_session *session,
@@ -911,18 +772,6 @@ static void session_terminate_transfer(struct obc_session *session,
 static void session_notify_complete(struct obc_session *session,
 				struct obc_transfer *transfer)
 {
-	struct obc_agent *agent = session->agent;
-	const char *path;
-
-	path = obc_transfer_get_path(transfer);
-
-	if (agent == NULL || path == NULL)
-		goto done;
-
-	obc_agent_notify_complete(agent, path);
-
-done:
-
 	DBG("Transfer(%p) complete", transfer);
 
 	session_terminate_transfer(session, transfer, NULL);
@@ -932,16 +781,6 @@ static void session_notify_error(struct obc_session *session,
 				struct obc_transfer *transfer,
 				GError *err)
 {
-	struct obc_agent *agent = session->agent;
-	const char *path;
-
-	path = obc_transfer_get_path(transfer);
-	if (agent == NULL || path == NULL)
-		goto done;
-
-	obc_agent_notify_error(agent, path, err->message);
-
-done:
 	error("Transfer(%p) Error: %s", transfer, err->message);
 
 	session_terminate_transfer(session, transfer, err);
@@ -951,16 +790,6 @@ static void session_notify_progress(struct obc_session *session,
 					struct obc_transfer *transfer,
 					gint64 transferred)
 {
-	struct obc_agent *agent = session->agent;
-	const char *path;
-
-	path = obc_transfer_get_path(transfer);
-	if (agent == NULL || path == NULL)
-		goto done;
-
-	obc_agent_notify_progress(agent, path, transferred);
-
-done:
 	DBG("Transfer(%p) progress: %ld bytes", transfer,
 			(long int ) transferred);
 
@@ -1030,49 +859,6 @@ fail:
 	return NULL;
 }
 
-static void agent_destroy(gpointer data, gpointer user_data)
-{
-	struct obc_session *session = user_data;
-
-	session->agent = NULL;
-}
-
-int obc_session_set_agent(struct obc_session *session, const char *name,
-							const char *path)
-{
-	struct obc_agent *agent;
-
-	if (session == NULL)
-		return -EINVAL;
-
-	if (session->agent)
-		return -EALREADY;
-
-	agent = obc_agent_create(session->conn, name, path, agent_destroy,
-								session);
-
-	if (session->watch == 0)
-		obc_session_set_owner(session, name, owner_disconnected);
-
-	session->agent = agent;
-
-	return 0;
-}
-
-const char *obc_session_get_agent(struct obc_session *session)
-{
-	struct obc_agent *agent;
-
-	if (session == NULL)
-		return NULL;
-
-	agent = session->agent;
-	if (agent == NULL)
-		return NULL;
-
-	return obc_agent_get_name(session->agent);
-}
-
 const char *obc_session_get_owner(struct obc_session *session)
 {
 	if (session == NULL)
diff --git a/client/session.h b/client/session.h
index 2cac032..7f37d29 100644
--- a/client/session.h
+++ b/client/session.h
@@ -47,10 +47,6 @@ int obc_session_set_owner(struct obc_session *session, const char *name,
 			GDBusWatchFunction func);
 const char *obc_session_get_owner(struct obc_session *session);
 
-int obc_session_set_agent(struct obc_session *session, const char *name,
-							const char *path);
-const char *obc_session_get_agent(struct obc_session *session);
-
 const char *obc_session_get_path(struct obc_session *session);
 const char *obc_session_get_target(struct obc_session *session);
 
-- 
1.7.7.6

