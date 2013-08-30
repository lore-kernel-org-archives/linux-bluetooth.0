Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] obexd: Add obc_session_get_folder function
Date: Fri, 30 Aug 2013 14:45:11 +0200
Message-Id: <1377866712-5253-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This patch extends client session by the tracking of the current folder.
The current folder can be accessed by obc_session_get_current_folder.

This allows drivers to add a folder property to browsed objects so that
the application doesn't have to keep track of the folder an object
belongs to.
---
 obexd/client/session.c | 38 ++++++++++++++++++++++++++++++++++++++
 obexd/client/session.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 44e2bf8..632e114 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -110,6 +110,7 @@ struct obc_session {
 	guint watch;
 	GQueue *queue;
 	guint process_id;
+	char *folder;
 };
 
 static GSList *sessions = NULL;
@@ -242,6 +243,7 @@ static void session_free(struct obc_session *session)
 	g_free(session->owner);
 	g_free(session->source);
 	g_free(session->destination);
+	g_free(session->folder);
 	g_free(session);
 }
 
@@ -500,6 +502,7 @@ struct obc_session *obc_session_create(const char *source,
 	session->destination = g_strdup(destination);
 	session->channel = channel;
 	session->queue = g_queue_new();
+	session->folder = g_strdup("/");
 
 	if (owner)
 		obc_session_set_owner(session, owner, owner_disconnected);
@@ -930,6 +933,11 @@ const char *obc_session_get_target(struct obc_session *session)
 	return session->driver->target;
 }
 
+const char *obc_session_get_folder(struct obc_session *session)
+{
+	return session->folder;
+}
+
 static void setpath_complete(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GError *err, void *user_data)
@@ -957,12 +965,39 @@ static void setpath_op_complete(struct obc_session *session,
 		data->func(session, NULL, err, data->user_data);
 }
 
+static void setpath_set_folder(struct obc_session *session, const char *cur)
+{
+	char *folder = NULL;
+	const char *delim;
+
+	delim = strrchr(session->folder, '/');
+	if (strlen(cur) == 0 || delim == NULL ||
+			(strcmp(cur, "..") == 0 && delim == session->folder)) {
+		folder = g_strdup("/");
+	} else {
+		if (strcmp(cur, "..") == 0) {
+			folder = g_strndup(session->folder,
+						delim - session->folder);
+		} else {
+			if (g_str_has_suffix(session->folder, "/"))
+				folder = g_strconcat(session->folder,
+								cur, NULL);
+			else
+				folder = g_strconcat(session->folder, "/",
+								cur, NULL);
+		}
+	}
+	g_free(session->folder);
+	session->folder = folder;
+}
+
 static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data)
 {
 	struct pending_request *p = user_data;
 	struct setpath_data *data = p->data;
 	char *next;
+	char *current;
 	guint8 code;
 
 	p->req_id = 0;
@@ -982,6 +1017,9 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 		return;
 	}
 
+	current = data->remaining[data->index - 1];
+	setpath_set_folder(p->session, current);
+
 	/* Ignore empty folder names to avoid resetting the current path */
 	while ((next = data->remaining[data->index]) && strlen(next) == 0)
 		data->index++;
diff --git a/obexd/client/session.h b/obexd/client/session.h
index 319d529..35899bc 100644
--- a/obexd/client/session.h
+++ b/obexd/client/session.h
@@ -58,6 +58,8 @@ const char *obc_session_register(struct obc_session *session,
 const void *obc_session_get_attribute(struct obc_session *session,
 							int attribute_id);
 
+const char *obc_session_get_folder(struct obc_session *session);
+
 guint obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
-- 
1.8.3.4

