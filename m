Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] client: add support for reusing session for the same client
Date: Fri,  6 May 2011 13:43:59 +0300
Message-Id: <1304678639-31853-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1304678639-31853-1-git-send-email-luiz.dentz@gmail.com>
References: <1304678639-31853-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

If the a client owning a session attempt to send a new file just reuse
the same session instead of trying to connect again.
---
 client/session.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/client/session.c b/client/session.c
index 8c41858..9ff906c 100644
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
@@ -199,6 +201,8 @@ static void session_free(struct session_data *session)
 		dbus_connection_unref(session->conn);
 	}
 
+	sessions = g_slist_remove(sessions, session);
+
 	g_free(session->callback);
 	g_free(session->path);
 	g_free(session->owner);
@@ -246,6 +250,8 @@ static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 
 	session->obex = obex;
 
+	sessions = g_slist_prepend(sessions, session);
+
 done:
 	callback->func(callback->session, err, callback->data);
 
@@ -488,6 +494,43 @@ int session_set_owner(struct session_data *session, const char *name,
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
@@ -503,6 +546,12 @@ struct session_data *session_create(const char *source,
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
@@ -544,9 +593,10 @@ struct session_data *session_create(const char *source,
 		return NULL;
 	}
 
+proceed:
 	callback = g_try_malloc0(sizeof(*callback));
 	if (callback == NULL) {
-		session_free(session);
+		session_unref(session);
 		return NULL;
 	}
 
@@ -570,7 +620,7 @@ struct session_data *session_create(const char *source,
 	}
 
 	if (err < 0) {
-		session_free(session);
+		session_unref(session);
 		g_free(callback);
 		return NULL;
 	}
-- 
1.7.1

