Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 3/6] media: Remove transport owner list
Date: Wed,  5 Dec 2012 17:15:31 +0100
Message-Id: <1354724134-7354-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354724134-7354-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354724134-7354-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Transports now have zero or one owners, so there is no need to maintain
a list any more.
---
 profiles/audio/transport.c | 79 ++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 58 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 4bb54f6..1064098 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -88,7 +88,7 @@ struct media_transport {
 	char			*path;		/* Transport object path */
 	struct audio_device	*device;	/* Transport device */
 	struct media_endpoint	*endpoint;	/* Transport endpoint */
-	GSList			*owners;	/* Transport owners */
+	struct media_owner	*owner;		/* Transport owner */
 	uint8_t			*configuration; /* Transport configuration */
 	int			size;		/* Transport configuration size */
 	int			fd;		/* Transport file descriptor */
@@ -241,24 +241,24 @@ static void media_owner_free(struct media_owner *owner)
 	g_free(owner);
 }
 
-static void media_transport_remove(struct media_transport *transport,
-						struct media_owner *owner)
+static void media_transport_remove_owner(struct media_transport *transport)
 {
+	struct media_owner *owner = transport->owner;
+
 	DBG("Transport %s Owner %s", transport->path, owner->name);
 
 	/* Reply if owner has a pending request */
 	if (owner->pending)
 		media_request_reply(owner->pending, EIO);
 
-	transport->owners = g_slist_remove(transport->owners, owner);
+	transport->owner = NULL;
 
 	if (owner->watch)
 		g_dbus_remove_watch(btd_get_dbus_connection(), owner->watch);
 
 	media_owner_free(owner);
 
-	/* Suspend if there is no longer any owner */
-	if (transport->owners == NULL && state_in_use(transport->state))
+	if (state_in_use(transport->state))
 		transport->suspend(transport, NULL);
 }
 
@@ -319,7 +319,7 @@ static void a2dp_resume_complete(struct avdtp *session,
 	return;
 
 fail:
-	media_transport_remove(transport, owner);
+	media_transport_remove_owner(transport);
 }
 
 static guint resume_a2dp(struct media_transport *transport,
@@ -366,7 +366,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 
 	a2dp_sep_unlock(sep, a2dp->session);
 	transport_set_state(transport, TRANSPORT_STATE_IDLE);
-	media_transport_remove(transport, owner);
+	media_transport_remove_owner(transport);
 }
 
 static guint suspend_a2dp(struct media_transport *transport,
@@ -399,14 +399,14 @@ static void media_owner_exit(DBusConnection *connection, void *user_data)
 
 	media_owner_remove(owner);
 
-	media_transport_remove(owner->transport, owner);
+	media_transport_remove_owner(owner->transport);
 }
 
-static void media_transport_add(struct media_transport *transport,
+static void media_transport_set_owner(struct media_transport *transport,
 					struct media_owner *owner)
 {
 	DBG("Transport %s Owner %s", transport->path, owner->name);
-	transport->owners = g_slist_append(transport->owners, owner);
+	transport->owner = owner;
 	owner->transport = transport;
 	owner->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
 							owner->name,
@@ -435,35 +435,15 @@ static void media_owner_add(struct media_owner *owner,
 	owner->pending = req;
 }
 
-static struct media_owner *media_transport_find_owner(
-					struct media_transport *transport,
-					const char *name)
-{
-	GSList *l;
-
-	for (l = transport->owners; l; l = l->next) {
-		struct media_owner *owner = l->data;
-
-		if (g_strcmp0(owner->name, name) == 0)
-			return owner;
-	}
-
-	return NULL;
-}
-
 static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
 	struct media_transport *transport = data;
 	struct media_owner *owner;
 	struct media_request *req;
-	const char *sender;
 	guint id;
 
-	sender = dbus_message_get_sender(msg);
-
-	owner = media_transport_find_owner(transport, sender);
-	if (owner != NULL)
+	if (transport->owner != NULL)
 		return btd_error_not_authorized(msg);
 
 	if (transport->state >= TRANSPORT_STATE_REQUESTING)
@@ -478,7 +458,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 
 	req = media_request_create(msg, id);
 	media_owner_add(owner, req);
-	media_transport_add(transport, owner);
+	media_transport_set_owner(transport, owner);
 
 	return NULL;
 }
@@ -487,23 +467,16 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
 	struct media_transport *transport = data;
-	struct media_owner *owner;
+	struct media_owner *owner = transport->owner;
 	const char *sender;
 	struct media_request *req;
 	guint id;
 
 	sender = dbus_message_get_sender(msg);
 
-	owner = media_transport_find_owner(transport, sender);
-	if (owner == NULL)
+	if (owner == NULL || g_strcmp0(owner->name, sender) != 0)
 		return btd_error_not_authorized(msg);
 
-	/* Not the last owner, no need to suspend */
-	if (g_slist_length(transport->owners) != 1) {
-		media_transport_remove(transport, owner);
-		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-	}
-
 	if (owner->pending) {
 		const char *member;
 
@@ -519,7 +492,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 
 	id = transport->suspend(transport, owner);
 	if (id == 0) {
-		media_transport_remove(transport, owner);
+		media_transport_remove_owner(transport);
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 	}
 
@@ -689,15 +662,9 @@ static void destroy_a2dp(void *data)
 static void media_transport_free(void *data)
 {
 	struct media_transport *transport = data;
-	GSList *l = transport->owners;
 
-	while (l) {
-		struct media_owner *owner = l->data;
-		l = l->next;
-		media_transport_remove(transport, owner);
-	}
-
-	g_slist_free(transport->owners);
+	if (transport->owner)
+		media_transport_remove_owner(transport);
 
 	if (transport->destroy != NULL)
 		transport->destroy(transport->data);
@@ -717,13 +684,9 @@ static void transport_update_playing(struct media_transport *transport,
 		if (transport->state == TRANSPORT_STATE_PENDING)
 			transport_set_state(transport, TRANSPORT_STATE_IDLE);
 		else if (transport->state == TRANSPORT_STATE_ACTIVE) {
-			/* Remove all owners */
-			while (transport->owners != NULL) {
-				struct media_owner *owner;
-
-				owner = transport->owners->data;
-				media_transport_remove(transport, owner);
-			}
+			/* Remove owner */
+			if (transport->owner != NULL)
+				media_transport_remove_owner(transport);
 		}
 	} else if (transport->state == TRANSPORT_STATE_IDLE)
 		transport_set_state(transport, TRANSPORT_STATE_PENDING);
-- 
1.7.11.7

