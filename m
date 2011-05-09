Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] client: add support for reusing session for the same client
Date: Mon,  9 May 2011 11:21:38 +0300
Message-Id: <1304929298-1586-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1304929298-1586-1-git-send-email-luiz.dentz@gmail.com>
References: <1304929298-1586-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

If the a client owning a session attempt to send a new file just reuse
the same session instead of trying to connect again.
---
 client/session.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 client/session.h |    1 +
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/client/session.c b/client/session.c
index e8915cf..266d00c 100644
--- a/client/session.c
+++ b/client/session.c
@@ -87,6 +87,8 @@ struct agent_data {
 	struct pending_data *pending;
 };
 
+static GSList *sessions = NULL;
+
 static void session_prepare_put(struct session_data *session, GError *err,
 								void *data);
 static void session_terminate_transfer(struct session_data *session,
@@ -199,8 +201,11 @@ static void session_free(struct session_data *session)
 		dbus_connection_unref(session->conn);
 	}
 
+	sessions = g_slist_remove(sessions, session);
+
 	g_free(session->callback);
 	g_free(session->path);
+	g_free(session->service);
 	g_free(session->owner);
 	g_free(session);
 }
@@ -245,6 +250,8 @@ static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 
 	session->obex = obex;
 
+	sessions = g_slist_prepend(sessions, session);
+
 done:
 	callback->func(callback->session, err, callback->data);
 
@@ -446,6 +453,19 @@ static sdp_session_t *service_connect(const bdaddr_t *src, const bdaddr_t *dst,
 	return sdp;
 }
 
+static gboolean connection_complete(gpointer data)
+{
+	struct callback_data *cb = data;
+
+	cb->func(cb->session, 0, cb->data);
+
+	session_unref(cb->session);
+
+	g_free(cb);
+
+	return FALSE;
+}
+
 static void owner_disconnected(DBusConnection *connection, void *user_data)
 {
 	struct session_data *session = user_data;
@@ -474,6 +494,43 @@ int session_set_owner(struct session_data *session, const char *name,
 	return 0;
 }
 
+static struct session_data *session_find(const char *source,
+						const char *destination,
+						const char *service,
+						uint8_t channel,
+						const char *owner)
+{
+	GSList *l;
+
+	for (l = sessions; l; l = l->next) {
+		struct session_data *session = l->data;
+		bdaddr_t adr;
+
+		if (source) {
+			str2ba(source, &adr);
+			if (bacmp(&session->src, &adr))
+				continue;
+		}
+
+		str2ba(destination, &adr);
+		if (bacmp(&session->dst, &adr))
+			continue;
+
+		if (g_strcmp0(service, session->service))
+			continue;
+
+		if (channel && session->channel != channel)
+			continue;
+
+		if (g_strcmp0(owner, session->owner))
+			continue;
+
+		return session;
+	}
+
+	return NULL;
+}
+
 struct session_data *session_create(const char *source,
 						const char *destination,
 						const char *service,
@@ -489,6 +546,12 @@ struct session_data *session_create(const char *source,
 	if (destination == NULL)
 		return NULL;
 
+	session = session_find(source, destination, service, channel, owner);
+	if (session) {
+		session_ref(session);
+		goto proceed;
+	}
+
 	session = g_try_malloc0(sizeof(*session));
 	if (session == NULL)
 		return NULL;
@@ -508,6 +571,7 @@ struct session_data *session_create(const char *source,
 		str2ba(source, &session->src);
 
 	str2ba(destination, &session->dst);
+	session->service = g_strdup(service);
 
 	if (!g_ascii_strncasecmp(service, "OPP", 3)) {
 		sdp_uuid16_create(&session->uuid, OBEX_OBJPUSH_SVCLASS_ID);
@@ -529,9 +593,10 @@ struct session_data *session_create(const char *source,
 		return NULL;
 	}
 
+proceed:
 	callback = g_try_malloc0(sizeof(*callback));
 	if (callback == NULL) {
-		session_free(session);
+		session_unref(session);
 		return NULL;
 	}
 
@@ -539,7 +604,10 @@ struct session_data *session_create(const char *source,
 	callback->func = function;
 	callback->data = user_data;
 
-	if (session->channel > 0) {
+	if (session->obex) {
+		g_idle_add(connection_complete, callback);
+		err = 0;
+	} else if (session->channel > 0) {
 		session->io = rfcomm_connect(&session->src, &session->dst,
 							session->channel,
 							rfcomm_callback,
@@ -552,7 +620,7 @@ struct session_data *session_create(const char *source,
 	}
 
 	if (err < 0) {
-		session_free(session);
+		session_unref(session);
 		g_free(callback);
 		return NULL;
 	}
diff --git a/client/session.h b/client/session.h
index eee439f..6f8a434 100644
--- a/client/session.h
+++ b/client/session.h
@@ -36,6 +36,7 @@ struct session_data {
 	bdaddr_t src;
 	bdaddr_t dst;
 	uint8_t channel;
+	char *service;		/* Service friendly name */
 	const char *target;	/* OBEX Target UUID */
 	int target_len;
 	uuid_t uuid;		/* Bluetooth Service Class */
-- 
1.7.1

