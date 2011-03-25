Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Rework adding/removing owners to a transport
Date: Fri, 25 Mar 2011 18:59:54 +0200
Message-Id: <1301072395-16787-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1301072395-16787-1-git-send-email-luiz.dentz@gmail.com>
References: <1301072395-16787-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Instead of directly add/remove and owner to transport list do it in a
separate function.
---
 audio/media.c     |    4 +-
 audio/transport.c |   85 +++++++++++++++++++++++++++++++---------------------
 audio/transport.h |    2 +-
 3 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 4b389c6..0efb0a8 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -126,7 +126,7 @@ static void media_endpoint_remove(struct media_endpoint *endpoint)
 		media_endpoint_cancel(endpoint);
 
 	if (endpoint->transport)
-		media_transport_remove(endpoint->transport);
+		media_transport_destroy(endpoint->transport);
 
 	g_dbus_remove_watch(adapter->conn, endpoint->watch);
 	g_free(endpoint->capabilities);
@@ -665,7 +665,7 @@ void media_endpoint_clear_configuration(struct media_endpoint *endpoint)
 							DBUS_TYPE_INVALID);
 	g_dbus_send_message(conn, msg);
 done:
-	media_transport_remove(endpoint->transport);
+	media_transport_destroy(endpoint->transport);
 	endpoint->transport = NULL;
 }
 
diff --git a/audio/transport.c b/audio/transport.c
index 9a8fc22..e0390e5 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -95,7 +95,7 @@ struct media_transport {
 					DBusMessageIter *value);
 };
 
-void media_transport_remove(struct media_transport *transport)
+void media_transport_destroy(struct media_transport *transport)
 {
 	char *path;
 
@@ -167,30 +167,35 @@ static gboolean media_transport_release(struct media_transport *transport,
 	return TRUE;
 }
 
-static void media_owner_remove(struct media_owner *owner)
+static void media_owner_free(struct media_owner *owner)
 {
-	struct media_transport *transport = owner->transport;
+	DBG("Owner %s", owner->name);
+
+	if (owner->pending)
+		media_request_free(owner->pending);
+
+	g_free(owner->name);
+	g_free(owner->accesstype);
+	g_free(owner);
+}
+
+static void media_transport_remove(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	DBG("Transport %s Owner %s", transport->path, owner->name);
 
 	media_transport_release(transport, owner->accesstype);
 
+	transport->owners = g_slist_remove(transport->owners, owner);
+
 	if (owner->watch)
 		g_dbus_remove_watch(transport->conn, owner->watch);
 
-	if (owner->pending)
-		media_request_free(owner->pending);
-
-	transport->owners = g_slist_remove(transport->owners, owner);
+	media_owner_free(owner);
 
 	/* Suspend if there is no longer any owner */
 	if (transport->owners == NULL && transport->in_use)
 		transport->suspend(transport, NULL);
-
-	DBG("Owner removed: sender=%s accesstype=%s", owner->name,
-							owner->accesstype);
-
-	g_free(owner->name);
-	g_free(owner->accesstype);
-	g_free(owner);
 }
 
 static gboolean media_transport_set_fd(struct media_transport *transport,
@@ -210,7 +215,9 @@ static gboolean media_transport_set_fd(struct media_transport *transport,
 
 static gboolean remove_owner(gpointer data)
 {
-	media_owner_remove(data);
+	struct media_owner *owner = data;
+
+	media_transport_remove(owner->transport, owner);
 
 	return FALSE;
 }
@@ -305,7 +312,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 
 	a2dp_sep_unlock(sep, transport->session);
 	transport->in_use = FALSE;
-	media_owner_remove(owner);
+	media_transport_remove(transport, owner);
 }
 
 static guint suspend_a2dp(struct media_transport *transport,
@@ -371,7 +378,7 @@ static void headset_resume_complete(struct audio_device *dev, void *user_data)
 	return;
 
 fail:
-	media_owner_remove(owner);
+	media_transport_remove(transport, owner);
 }
 
 static guint resume_headset(struct media_transport *transport,
@@ -405,7 +412,7 @@ static void headset_suspend_complete(struct audio_device *dev, void *user_data)
 
 	headset_unlock(dev, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
 	transport->in_use = FALSE;
-	media_owner_remove(owner);
+	media_transport_remove(transport, owner);
 }
 
 static guint suspend_headset(struct media_transport *transport,
@@ -436,7 +443,7 @@ static void media_owner_exit(DBusConnection *connection, void *user_data)
 	if (owner->pending != NULL)
 		media_request_free(owner->pending);
 
-	media_owner_remove(owner);
+	media_transport_remove(owner->transport, owner);
 }
 
 static gboolean media_transport_acquire(struct media_transport *transport,
@@ -474,22 +481,26 @@ static gboolean media_transport_acquire(struct media_transport *transport,
 	return TRUE;
 }
 
-static struct media_owner *media_owner_create(
-					struct media_transport *transport,
-					DBusMessage *msg,
-					const char *accesstype)
+static void media_transport_add(struct media_transport *transport,
+					struct media_owner *owner)
+{
+	DBG("Transport %s Owner %s", transport->path, owner->name);
+	transport->owners = g_slist_append(transport->owners, owner);
+	owner->transport = transport;
+}
+
+static struct media_owner *media_owner_create(DBusConnection *conn,
+						DBusMessage *msg,
+						const char *accesstype)
 {
 	struct media_owner *owner;
 
 	owner = g_new0(struct media_owner, 1);
-	owner->transport = transport;
 	owner->name = g_strdup(dbus_message_get_sender(msg));
 	owner->accesstype = g_strdup(accesstype);
-	owner->watch = g_dbus_add_disconnect_watch(transport->conn,
-							owner->name,
+	owner->watch = g_dbus_add_disconnect_watch(conn, owner->name,
 							media_owner_exit,
 							owner, NULL);
-	transport->owners = g_slist_append(transport->owners, owner);
 
 	DBG("Owner created: sender=%s accesstype=%s", owner->name,
 			accesstype);
@@ -535,11 +546,15 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	if (media_transport_acquire(transport, accesstype) == FALSE)
 		return btd_error_not_authorized(msg);
 
-	owner = media_owner_create(transport, msg, accesstype);
+	owner = media_owner_create(conn, msg, accesstype);
 	req = media_request_new(owner, msg);
 	req->id = transport->resume(transport, owner);
-	if (req->id == 0)
-		media_owner_remove(owner);
+	if (req->id == 0) {
+		media_owner_free(owner);
+		return NULL;
+	}
+
+	media_transport_add(transport, owner);
 
 	return NULL;
 }
@@ -566,7 +581,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	if (g_strcmp0(owner->accesstype, accesstype) == 0) {
 		/* Not the last owner, no need to suspend */
 		if (g_slist_length(transport->owners) != 1) {
-			media_owner_remove(owner);
+			media_transport_remove(transport, owner);
 			return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 		}
 
@@ -584,7 +599,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 		req = media_request_new(owner, msg);
 		req->id = transport->suspend(transport, owner);
 		if (req->id == 0)
-			media_owner_remove(owner);
+			media_transport_remove(transport, owner);
 
 		return NULL;
 	} else if (g_strstr_len(owner->accesstype, -1, accesstype) != NULL) {
@@ -774,9 +789,11 @@ static GDBusSignalTable transport_signals[] = {
 static void media_transport_free(void *data)
 {
 	struct media_transport *transport = data;
+	GSList *l;
+
+	for (l = transport->owners; l; l = l->next)
+		media_transport_remove(transport, l->data);
 
-	g_slist_foreach(transport->owners, (GFunc) media_owner_remove,
-				NULL);
 	g_slist_free(transport->owners);
 
 	if (transport->session)
diff --git a/audio/transport.h b/audio/transport.h
index b6c27b9..be4d666 100644
--- a/audio/transport.h
+++ b/audio/transport.h
@@ -30,7 +30,7 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 						uint8_t *configuration,
 						size_t size);
 
-void media_transport_remove(struct media_transport *transport);
+void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
-- 
1.7.1

