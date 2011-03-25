Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Remove owner reference to request structure
Date: Fri, 25 Mar 2011 18:59:55 +0200
Message-Id: <1301072395-16787-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1301072395-16787-1-git-send-email-luiz.dentz@gmail.com>
References: <1301072395-16787-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This should avoid doing too much implicity and should improve the
readability of the code.
---
 audio/transport.c |  100 ++++++++++++++++++++++++++++++++--------------------
 1 files changed, 61 insertions(+), 39 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index e0390e5..3442e5f 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -52,7 +52,6 @@
 struct media_request {
 	DBusMessage		*msg;
 	guint			id;
-	struct media_owner	*owner;
 };
 
 struct media_owner {
@@ -107,48 +106,36 @@ void media_transport_destroy(struct media_transport *transport)
 	g_free(path);
 }
 
-static struct media_request *media_request_new(struct media_owner *owner,
-							DBusMessage *msg)
+static struct media_request *media_request_create(DBusMessage *msg, guint id)
 {
 	struct media_request *req;
 
 	req = g_new0(struct media_request, 1);
 	req->msg = dbus_message_ref(msg);
-	req->owner = owner;
-	owner->pending = req;
-
-	return req;
-}
-
-static void media_request_free(struct media_request *req)
-{
-	struct media_owner *owner = req->owner;
-	struct media_transport *transport = owner->transport;
+	req->id = id;
 
-	if (req->id)
-		transport->cancel(owner->transport, req->id);
-
-	if (req->msg)
-		dbus_message_unref(req->msg);
+	DBG("Request created: method=%s id=%u", dbus_message_get_member(msg),
+									id);
 
-	owner->pending = NULL;
-	g_free(req);
+	return req;
 }
 
-static void media_request_reply(struct media_request *req, int err)
+static void media_request_reply(struct media_request *req,
+						DBusConnection *conn, int err)
 {
-	struct media_owner *owner = req->owner;
-	struct media_transport *transport = owner->transport;
 	DBusMessage *reply;
 
+	DBG("Request %s Reply %s", dbus_message_get_member(req->msg),
+							strerror(err));
+
 	if (!err)
 		reply = g_dbus_create_reply(req->msg, DBUS_TYPE_INVALID);
 	else
-		reply = g_dbus_create_error(owner->pending->msg,
+		reply = g_dbus_create_error(req->msg,
 						ERROR_INTERFACE ".Failed",
 						"%s", strerror(err));
 
-	g_dbus_send_message(transport->conn, reply);
+	g_dbus_send_message(conn, reply);
 }
 
 static gboolean media_transport_release(struct media_transport *transport,
@@ -167,12 +154,30 @@ static gboolean media_transport_release(struct media_transport *transport,
 	return TRUE;
 }
 
+static void media_owner_remove(struct media_owner *owner,
+						struct media_request *req)
+{
+	struct media_transport *transport = owner->transport;
+
+	DBG("Owner %s Request %s", owner->name,
+					dbus_message_get_member(req->msg));
+
+	if (req->id)
+		transport->cancel(transport, req->id);
+
+	owner->pending = NULL;
+	if (req->msg)
+		dbus_message_unref(req->msg);
+
+	g_free(req);
+}
+
 static void media_owner_free(struct media_owner *owner)
 {
 	DBG("Owner %s", owner->name);
 
 	if (owner->pending)
-		media_request_free(owner->pending);
+		media_owner_remove(owner, owner->pending);
 
 	g_free(owner->name);
 	g_free(owner->accesstype);
@@ -263,7 +268,7 @@ static void a2dp_resume_complete(struct avdtp *session,
 	if (ret == FALSE)
 		goto fail;
 
-	media_request_free(req);
+	media_owner_remove(owner, req);
 
 	return;
 
@@ -307,7 +312,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 	/* Release always succeeds */
 	if (owner->pending) {
 		owner->pending->id = 0;
-		media_request_reply(owner->pending, 0);
+		media_request_reply(owner->pending, transport->conn, 0);
 	}
 
 	a2dp_sep_unlock(sep, transport->session);
@@ -373,7 +378,7 @@ static void headset_resume_complete(struct audio_device *dev, void *user_data)
 	if (ret == FALSE)
 		goto fail;
 
-	media_request_free(req);
+	media_owner_remove(owner, req);
 
 	return;
 
@@ -407,7 +412,7 @@ static void headset_suspend_complete(struct audio_device *dev, void *user_data)
 	/* Release always succeeds */
 	if (owner->pending) {
 		owner->pending->id = 0;
-		media_request_reply(owner->pending, 0);
+		media_request_reply(owner->pending, transport->conn, 0);
 	}
 
 	headset_unlock(dev, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
@@ -441,7 +446,7 @@ static void media_owner_exit(DBusConnection *connection, void *user_data)
 	owner->watch = 0;
 
 	if (owner->pending != NULL)
-		media_request_free(owner->pending);
+		media_owner_remove(owner, owner->pending);
 
 	media_transport_remove(owner->transport, owner);
 }
@@ -508,6 +513,15 @@ static struct media_owner *media_owner_create(DBusConnection *conn,
 	return owner;
 }
 
+static void media_owner_add(struct media_owner *owner,
+						struct media_request *req)
+{
+	DBG("Owner %s Request %s", owner->name,
+					dbus_message_get_member(req->msg));
+
+	owner->pending = req;
+}
+
 static struct media_owner *media_transport_find_owner(
 					struct media_transport *transport,
 					const char *name)
@@ -531,6 +545,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	struct media_owner *owner;
 	struct media_request *req;
 	const char *accesstype, *sender;
+	guint id;
 
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_STRING, &accesstype,
@@ -547,13 +562,14 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_not_authorized(msg);
 
 	owner = media_owner_create(conn, msg, accesstype);
-	req = media_request_new(owner, msg);
-	req->id = transport->resume(transport, owner);
-	if (req->id == 0) {
+	id = transport->resume(transport, owner);
+	if (id == 0) {
 		media_owner_free(owner);
-		return NULL;
+		return btd_error_not_authorized(msg);
 	}
 
+	req = media_request_create(msg, id);
+	media_owner_add(owner, req);
 	media_transport_add(transport, owner);
 
 	return NULL;
@@ -579,6 +595,8 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_not_authorized(msg);
 
 	if (g_strcmp0(owner->accesstype, accesstype) == 0) {
+		guint id;
+
 		/* Not the last owner, no need to suspend */
 		if (g_slist_length(transport->owners) != 1) {
 			media_transport_remove(transport, owner);
@@ -591,15 +609,19 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 			member = dbus_message_get_member(owner->pending->msg);
 			/* Cancel Acquire request if that exist */
 			if (g_str_equal(member, "Acquire"))
-				media_request_free(owner->pending);
+				media_owner_remove(owner, owner->pending);
 			else
 				return btd_error_in_progress(msg);
 		}
 
-		req = media_request_new(owner, msg);
-		req->id = transport->suspend(transport, owner);
-		if (req->id == 0)
+		id = transport->suspend(transport, owner);
+		if (id == 0) {
 			media_transport_remove(transport, owner);
+			return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+		}
+
+		req = media_request_create(msg, id);
+		media_owner_add(owner, req);
 
 		return NULL;
 	} else if (g_strstr_len(owner->accesstype, -1, accesstype) != NULL) {
-- 
1.7.1

