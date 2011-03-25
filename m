Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Make MediaTransport.Release asynchronous
Date: Fri, 25 Mar 2011 18:59:53 +0200
Message-Id: <1301072395-16787-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This make it possible for the owners to synchronize its state if the
transport is going to be suspended.

Note that client which don't want to wait for Release can just ignore/
not wait for its reply.
---
 audio/transport.c |  168 +++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 132 insertions(+), 36 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 9961684..9a8fc22 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -49,7 +49,7 @@
 
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport"
 
-struct acquire_request {
+struct media_request {
 	DBusMessage		*msg;
 	guint			id;
 	struct media_owner	*owner;
@@ -57,7 +57,7 @@ struct acquire_request {
 
 struct media_owner {
 	struct media_transport	*transport;
-	struct acquire_request *request;
+	struct media_request	*pending;
 	char			*name;
 	char			*accesstype;
 	guint			watch;
@@ -82,7 +82,8 @@ struct media_transport {
 	gboolean		in_use;
 	guint			(*resume) (struct media_transport *transport,
 					struct media_owner *owner);
-	void			(*suspend) (struct media_transport *transport);
+	guint			(*suspend) (struct media_transport *transport,
+					struct media_owner *owner);
 	void			(*cancel) (struct media_transport *transport,
 								guint id);
 	void			(*get_properties) (
@@ -106,7 +107,20 @@ void media_transport_remove(struct media_transport *transport)
 	g_free(path);
 }
 
-static void acquire_request_free(struct acquire_request *req)
+static struct media_request *media_request_new(struct media_owner *owner,
+							DBusMessage *msg)
+{
+	struct media_request *req;
+
+	req = g_new0(struct media_request, 1);
+	req->msg = dbus_message_ref(msg);
+	req->owner = owner;
+	owner->pending = req;
+
+	return req;
+}
+
+static void media_request_free(struct media_request *req)
 {
 	struct media_owner *owner = req->owner;
 	struct media_transport *transport = owner->transport;
@@ -117,10 +131,26 @@ static void acquire_request_free(struct acquire_request *req)
 	if (req->msg)
 		dbus_message_unref(req->msg);
 
-	owner->request = NULL;
+	owner->pending = NULL;
 	g_free(req);
 }
 
+static void media_request_reply(struct media_request *req, int err)
+{
+	struct media_owner *owner = req->owner;
+	struct media_transport *transport = owner->transport;
+	DBusMessage *reply;
+
+	if (!err)
+		reply = g_dbus_create_reply(req->msg, DBUS_TYPE_INVALID);
+	else
+		reply = g_dbus_create_error(owner->pending->msg,
+						ERROR_INTERFACE ".Failed",
+						"%s", strerror(err));
+
+	g_dbus_send_message(transport->conn, reply);
+}
+
 static gboolean media_transport_release(struct media_transport *transport,
 					const char *accesstype)
 {
@@ -146,21 +176,14 @@ static void media_owner_remove(struct media_owner *owner)
 	if (owner->watch)
 		g_dbus_remove_watch(transport->conn, owner->watch);
 
-	if (owner->request) {
-		DBusMessage *reply = g_dbus_create_error(owner->request->msg,
-						ERROR_INTERFACE ".Failed",
-						"%s", strerror(EIO));
-
-		g_dbus_send_message(transport->conn, reply);
-
-		acquire_request_free(owner->request);
-	}
+	if (owner->pending)
+		media_request_free(owner->pending);
 
 	transport->owners = g_slist_remove(transport->owners, owner);
 
-	/* Suspend if the is no longer any owner */
-	if (transport->owners == NULL)
-		transport->suspend(transport);
+	/* Suspend if there is no longer any owner */
+	if (transport->owners == NULL && transport->in_use)
+		transport->suspend(transport, NULL);
 
 	DBG("Owner removed: sender=%s accesstype=%s", owner->name,
 							owner->accesstype);
@@ -196,7 +219,7 @@ static void a2dp_resume_complete(struct avdtp *session,
 				struct avdtp_error *err, void *user_data)
 {
 	struct media_owner *owner = user_data;
-	struct acquire_request *req = owner->request;
+	struct media_request *req = owner->pending;
 	struct media_transport *transport = owner->transport;
 	struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);
 	struct avdtp_stream *stream;
@@ -233,6 +256,8 @@ static void a2dp_resume_complete(struct avdtp *session,
 	if (ret == FALSE)
 		goto fail;
 
+	media_request_free(req);
+
 	return;
 
 fail:
@@ -265,13 +290,38 @@ done:
 				owner);
 }
 
-static void suspend_a2dp(struct media_transport *transport)
+static void a2dp_suspend_complete(struct avdtp *session,
+				struct avdtp_error *err, void *user_data)
 {
-	struct media_endpoint *endpoint = transport->endpoint;
-	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
+	struct media_owner *owner = user_data;
+	struct media_transport *transport = owner->transport;
+	struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);
+
+	/* Release always succeeds */
+	if (owner->pending) {
+		owner->pending->id = 0;
+		media_request_reply(owner->pending, 0);
+	}
 
 	a2dp_sep_unlock(sep, transport->session);
 	transport->in_use = FALSE;
+	media_owner_remove(owner);
+}
+
+static guint suspend_a2dp(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	struct media_endpoint *endpoint = transport->endpoint;
+	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
+
+	if (!owner) {
+		a2dp_sep_unlock(sep, transport->session);
+		transport->in_use = FALSE;
+		return 0;
+	}
+
+	return a2dp_suspend(transport->session, sep, a2dp_suspend_complete,
+				owner);
 }
 
 static void cancel_a2dp(struct media_transport *transport, guint id)
@@ -282,7 +332,7 @@ static void cancel_a2dp(struct media_transport *transport, guint id)
 static void headset_resume_complete(struct audio_device *dev, void *user_data)
 {
 	struct media_owner *owner = user_data;
-	struct acquire_request *req = owner->request;
+	struct media_request *req = owner->pending;
 	struct media_transport *transport = owner->transport;
 	int fd;
 	uint16_t imtu, omtu;
@@ -316,6 +366,8 @@ static void headset_resume_complete(struct audio_device *dev, void *user_data)
 	if (ret == FALSE)
 		goto fail;
 
+	media_request_free(req);
+
 	return;
 
 fail:
@@ -340,12 +392,34 @@ done:
 					owner);
 }
 
-static void suspend_headset(struct media_transport *transport)
+static void headset_suspend_complete(struct audio_device *dev, void *user_data)
 {
-	struct audio_device *device = transport->device;
+	struct media_owner *owner = user_data;
+	struct media_transport *transport = owner->transport;
+
+	/* Release always succeeds */
+	if (owner->pending) {
+		owner->pending->id = 0;
+		media_request_reply(owner->pending, 0);
+	}
 
-	headset_unlock(device, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
+	headset_unlock(dev, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
 	transport->in_use = FALSE;
+	media_owner_remove(owner);
+}
+
+static guint suspend_headset(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	struct audio_device *device = transport->device;
+
+	if (!owner) {
+		headset_unlock(device, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
+		transport->in_use = FALSE;
+		return 0;
+	}
+
+	return headset_suspend_stream(device, headset_suspend_complete, owner);
 }
 
 static void cancel_headset(struct media_transport *transport, guint id)
@@ -358,8 +432,9 @@ static void media_owner_exit(DBusConnection *connection, void *user_data)
 	struct media_owner *owner = user_data;
 
 	owner->watch = 0;
-	if (owner->request != NULL)
-		acquire_request_free(owner->request);
+
+	if (owner->pending != NULL)
+		media_request_free(owner->pending);
 
 	media_owner_remove(owner);
 }
@@ -443,7 +518,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 {
 	struct media_transport *transport = data;
 	struct media_owner *owner;
-	struct acquire_request *req;
+	struct media_request *req;
 	const char *accesstype, *sender;
 
 	if (!dbus_message_get_args(msg, NULL,
@@ -461,11 +536,8 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_not_authorized(msg);
 
 	owner = media_owner_create(transport, msg, accesstype);
-	req = g_new0(struct acquire_request, 1);
-	req->msg = dbus_message_ref(msg);
-	req->owner = owner;
+	req = media_request_new(owner, msg);
 	req->id = transport->resume(transport, owner);
-	owner->request = req;
 	if (req->id == 0)
 		media_owner_remove(owner);
 
@@ -478,6 +550,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	struct media_transport *transport = data;
 	struct media_owner *owner;
 	const char *accesstype, *sender;
+	struct media_request *req;
 
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_STRING, &accesstype,
@@ -490,9 +563,31 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	if (owner == NULL)
 		return btd_error_not_authorized(msg);
 
-	if (g_strcmp0(owner->accesstype, accesstype) == 0)
-		media_owner_remove(owner);
-	else if (g_strstr_len(owner->accesstype, -1, accesstype) != NULL) {
+	if (g_strcmp0(owner->accesstype, accesstype) == 0) {
+		/* Not the last owner, no need to suspend */
+		if (g_slist_length(transport->owners) != 1) {
+			media_owner_remove(owner);
+			return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+		}
+
+		if (owner->pending) {
+			const char *member;
+
+			member = dbus_message_get_member(owner->pending->msg);
+			/* Cancel Acquire request if that exist */
+			if (g_str_equal(member, "Acquire"))
+				media_request_free(owner->pending);
+			else
+				return btd_error_in_progress(msg);
+		}
+
+		req = media_request_new(owner, msg);
+		req->id = transport->suspend(transport, owner);
+		if (req->id == 0)
+			media_owner_remove(owner);
+
+		return NULL;
+	} else if (g_strstr_len(owner->accesstype, -1, accesstype) != NULL) {
 		media_transport_release(transport, accesstype);
 		g_strdelimit(owner->accesstype, accesstype, ' ');
 	} else
@@ -665,7 +760,8 @@ static GDBusMethodTable transport_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",	get_properties },
 	{ "Acquire",		"s",	"h",		acquire,
 						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "Release",		"s",	"",		release },
+	{ "Release",		"s",	"",		release,
+						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "SetProperty",	"sv",	"",		set_property },
 	{ },
 };
-- 
1.7.1

