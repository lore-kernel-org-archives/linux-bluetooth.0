Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] obexd: Add obc_session_get_current_path function
Date: Thu, 22 Aug 2013 18:00:22 +0200
Message-Id: <1377187223-3427-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This patch extends client session by the tracking of the current path.
The current path can be accessed by obc_session_get_current_path.

This allows drivers to add a folder property to browsed objects so that
the application doesn't have to keep track of the folder an object
belongs to.
---
 obexd/client/session.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 obexd/client/session.h |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 44e2bf8..293359b 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -110,6 +110,8 @@ struct obc_session {
 	guint watch;
 	GQueue *queue;
 	guint process_id;
+	GSList *cur_path_list;
+	char *cur_path;
 };
 
 static GSList *sessions = NULL;
@@ -242,6 +244,8 @@ static void session_free(struct obc_session *session)
 	g_free(session->owner);
 	g_free(session->source);
 	g_free(session->destination);
+	g_slist_free_full(session->cur_path_list, g_free);
+	g_free(session->cur_path);
 	g_free(session);
 }
 
@@ -500,6 +504,7 @@ struct obc_session *obc_session_create(const char *source,
 	session->destination = g_strdup(destination);
 	session->channel = channel;
 	session->queue = g_queue_new();
+	session->cur_path = g_strdup("/");
 
 	if (owner)
 		obc_session_set_owner(session, owner, owner_disconnected);
@@ -930,12 +935,33 @@ const char *obc_session_get_target(struct obc_session *session)
 	return session->driver->target;
 }
 
+const char *obc_session_get_current_path(struct obc_session *session)
+{
+	GSList *l;
+	GString *strbuf;
+
+	if (!session->cur_path) {
+		strbuf = g_string_new("/");
+		for (l = session->cur_path_list; l; l = l->next) {
+			g_string_append(strbuf, l->data);
+			if (l->next)
+				g_string_append_c(strbuf, '/');
+		}
+		session->cur_path = g_string_free(strbuf, FALSE);
+	}
+
+	return session->cur_path;
+}
+
 static void setpath_complete(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GError *err, void *user_data)
 {
 	struct pending_request *p = user_data;
 
+	g_free(session->cur_path);
+	session->cur_path = NULL;
+
 	if (p->func)
 		p->func(session, NULL, err, p->data);
 
@@ -962,7 +988,9 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 {
 	struct pending_request *p = user_data;
 	struct setpath_data *data = p->data;
+	char *prev;
 	char *next;
+	GSList *last;
 	guint8 code;
 
 	p->req_id = 0;
@@ -982,6 +1010,24 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 		return;
 	}
 
+	/* Track current folder in cur_folder_list */
+	if (strlen(data->remaining[data->index-1]) == 0) {
+		g_slist_free_full(p->session->cur_path_list, g_free);
+		p->session->cur_path_list = NULL;
+	} else {
+		prev = data->remaining[data->index-1];
+		if (strcmp(prev, "..") == 0) {
+			if (p->session->cur_path_list) {
+				last = g_slist_last(p->session->cur_path_list);
+				g_free(last->data);
+				p->session->cur_path_list = g_slist_delete_link(
+					p->session->cur_path_list, last);
+			}
+		} else
+			p->session->cur_path_list = g_slist_append(
+				p->session->cur_path_list, g_strdup(prev));
+	}
+
 	/* Ignore empty folder names to avoid resetting the current path */
 	while ((next = data->remaining[data->index]) && strlen(next) == 0)
 		data->index++;
diff --git a/obexd/client/session.h b/obexd/client/session.h
index 319d529..01034b5 100644
--- a/obexd/client/session.h
+++ b/obexd/client/session.h
@@ -58,6 +58,8 @@ const char *obc_session_register(struct obc_session *session,
 const void *obc_session_get_attribute(struct obc_session *session,
 							int attribute_id);
 
+const char *obc_session_get_current_path(struct obc_session *session);
+
 guint obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
-- 
1.8.3.4

