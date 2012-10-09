Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 5/8] adapter: Add session type to session_req
Date: Tue,  9 Oct 2012 04:59:53 -0300
Message-Id: <1349769596-6050-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

With this field we can differentiate requests that should have global
actions from the ones created with RequestSession(). The intention with
this is to allow to separate how we detect a global request on
set_mode_complete(), not tying to the name of the D-Bus method it came
from.
---
 src/adapter.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c9ae8ca..26016f6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -86,8 +86,14 @@
 
 static GSList *adapter_drivers = NULL;
 
+enum session_req_type {
+	SESSION_REQ_TYPE_GLOBAL = 0,
+	SESSION_REQ_TYPE_SESSION,
+};
+
 struct session_req {
 	struct btd_adapter	*adapter;
+	enum session_req_type	type;
 	DBusMessage		*msg;		/* Unreplied message ref */
 	char			*owner;		/* Bus name of the owner */
 	guint			id;		/* Listener id */
@@ -225,6 +231,7 @@ static struct session_req *session_ref(struct session_req *req)
 
 static struct session_req *create_session(struct btd_adapter *adapter,
 					DBusMessage *msg, uint8_t mode,
+					enum session_req_type type,
 					GDBusWatchFunction cb)
 {
 	const char *sender;
@@ -233,6 +240,7 @@ static struct session_req *create_session(struct btd_adapter *adapter,
 	req = g_new0(struct session_req, 1);
 	req->adapter = adapter;
 	req->mode = mode;
+	req->type = type;
 
 	if (msg == NULL)
 		return session_ref(req);
@@ -321,8 +329,8 @@ done:
 	return 0;
 }
 
-static void set_pending_mode(struct btd_adapter *adapter, uint8_t new_mode,
-							DBusMessage *msg)
+static void set_session_pending_mode(struct btd_adapter *adapter,
+					uint8_t new_mode, DBusMessage *msg)
 {
 	struct session_req *req;
 
@@ -336,7 +344,7 @@ static void set_pending_mode(struct btd_adapter *adapter, uint8_t new_mode,
 		session_ref(req);
 	} else
 		adapter->pending_mode = create_session(adapter, msg, new_mode,
-									NULL);
+					SESSION_REQ_TYPE_SESSION, NULL);
 }
 
 static DBusMessage *set_discoverable(DBusMessage *msg,
@@ -357,7 +365,8 @@ static DBusMessage *set_discoverable(DBusMessage *msg,
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
-	set_pending_mode(adapter, mode, msg);
+	adapter->pending_mode = create_session(adapter, msg, mode,
+						SESSION_REQ_TYPE_GLOBAL, NULL);
 
 	return NULL;
 }
@@ -384,7 +393,8 @@ static DBusMessage *set_powered(DBusMessage *msg, gboolean powered, void *data)
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
-	set_pending_mode(adapter, mode, msg);
+	adapter->pending_mode = create_session(adapter, msg, mode,
+						SESSION_REQ_TYPE_GLOBAL, NULL);
 
 	return NULL;
 }
@@ -535,8 +545,8 @@ static void session_remove(struct session_req *req)
 {
 	struct btd_adapter *adapter = req->adapter;
 
-	/* Ignore set_mode session */
-	if (req->owner == NULL && adapter->pending_mode)
+	/* Ignore global requests */
+	if (req->type == SESSION_REQ_TYPE_GLOBAL)
 		return;
 
 	DBG("%s session %p with %s deactivated",
@@ -628,7 +638,7 @@ static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
 
 	err = set_mode(req->adapter, req->mode);
 	if (err >= 0 && req->adapter->mode != req->mode) {
-		set_pending_mode(req->adapter, req->mode, req->msg);
+		set_session_pending_mode(req->adapter, req->mode, req->msg);
 		goto done;
 	}
 
@@ -1089,7 +1099,8 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 		return btd_error_failed(msg, strerror(-err));
 
 done:
-	req = create_session(adapter, msg, 0, session_owner_exit);
+	req = create_session(adapter, msg, 0, SESSION_REQ_TYPE_GLOBAL,
+							session_owner_exit);
 
 	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
 
@@ -1403,7 +1414,7 @@ static DBusMessage *request_session(DBusConnection *conn,
 		return dbus_message_new_method_return(msg);
 	} else {
 		req = create_session(adapter, msg, new_mode,
-							session_owner_exit);
+				SESSION_REQ_TYPE_SESSION, session_owner_exit);
 		adapter->mode_sessions = g_slist_append(adapter->mode_sessions,
 							req);
 	}
@@ -2401,7 +2412,7 @@ void adapter_connect_list_add(struct btd_adapter *adapter,
 	if (adapter->disc_sessions == NULL)
 		adapter->discov_id = g_idle_add(discovery_cb, adapter);
 
-	req = create_session(adapter, NULL, 0, NULL);
+	req = create_session(adapter, NULL, 0, SESSION_REQ_TYPE_GLOBAL, NULL);
 	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
 	adapter->scanning_session = req;
 }
@@ -2454,7 +2465,7 @@ void btd_adapter_start(struct btd_adapter *adapter)
 					adapter->disc_sessions != NULL)
 		return;
 
-	req = create_session(adapter, NULL, 0, NULL);
+	req = create_session(adapter, NULL, 0, SESSION_REQ_TYPE_GLOBAL, NULL);
 	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
 	adapter->scanning_session = req;
 
@@ -2538,8 +2549,7 @@ static void set_mode_complete(struct btd_adapter *adapter)
 		if (err < 0)
 			reply = btd_error_failed(msg, strerror(-err));
 		else {
-			if (strcmp(dbus_message_get_member(msg),
-						"SetProperty") == 0)
+			if (pending->type == SESSION_REQ_TYPE_GLOBAL)
 				adapter->global_mode = adapter->mode;
 			reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 		}
-- 
1.7.12.2

