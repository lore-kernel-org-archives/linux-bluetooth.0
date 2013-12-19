Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] android/AVDTP: Add avdtp_add_disconnect_cb and avdtp_remove_disconnect_cb
Date: Thu, 19 Dec 2013 17:15:53 +0200
Message-Id: <1387466156-14100-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With these functions the user application can detect when the AVDTP has
been disconnected and cleanup properly.
---
 android/avdtp.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 android/avdtp.h |  6 ++++++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 3a3380a..b2d77a4 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -336,6 +336,12 @@ struct discover_callback {
 	void *user_data;
 };
 
+struct disconnect_callback {
+	unsigned int id;
+	avdtp_disconnect_cb_t cb;
+	void *user_data;
+};
+
 struct avdtp_stream {
 	GIOChannel *io;
 	uint16_t imtu;
@@ -390,6 +396,8 @@ struct avdtp {
 
 	struct discover_callback *discover;
 	struct pending_req *req;
+
+	GSList *disconnect;
 };
 
 static GSList *lseps = NULL;
@@ -970,12 +978,22 @@ static void avdtp_free(void *data)
 	g_slist_free_full(session->req_queue, pending_req_free);
 	g_slist_free_full(session->prio_queue, pending_req_free);
 	g_slist_free_full(session->seps, sep_free);
+	g_slist_free_full(session->disconnect, g_free);
 
 	g_free(session->buf);
 
 	g_free(session);
 }
 
+static void process_disconnect(void *data)
+{
+	struct disconnect_callback *callback = data;
+
+	callback->cb(callback->user_data);
+
+	g_free(callback);
+}
+
 static void connection_lost(struct avdtp *session, int err)
 {
 	DBG("Disconnected: %s (%d)", strerror(err), err);
@@ -983,12 +1001,14 @@ static void connection_lost(struct avdtp *session, int err)
 	g_slist_foreach(session->streams, (GFunc) release_stream, session);
 	session->streams = NULL;
 
+	avdtp_ref(session);
+
 	finalize_discovery(session, err);
 
-	if (session->ref > 0)
-		return;
+	g_slist_free_full(session->disconnect, process_disconnect);
+	session->disconnect = NULL;
 
-	avdtp_free(session);
+	avdtp_unref(session);
 }
 
 void avdtp_unref(struct avdtp *session)
@@ -2047,6 +2067,41 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 	return avdtp_ref(session);
 }
 
+unsigned int avdtp_add_disconnect_cb(struct avdtp *session,
+						avdtp_disconnect_cb_t cb,
+						void *user_data)
+{
+	struct disconnect_callback *callback;
+	static unsigned int id = 0;
+
+	callback = g_new0(struct disconnect_callback, 1);
+	callback->id = ++id;
+	callback->cb = cb;
+	callback->user_data = user_data;
+	session->disconnect = g_slist_append(session->disconnect, callback);
+
+	return id;
+}
+
+gboolean avdtp_remove_disconnect_cb(struct avdtp *session, unsigned int id)
+{
+	GSList *l;
+
+	for (l = session->disconnect; l; l = g_slist_next(l)) {
+		struct disconnect_callback *callback = l->data;
+
+		if (callback->id != id)
+			continue;
+
+		session->disconnect = g_slist_remove(session->disconnect,
+								callback);
+		g_free(callback);
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 static void queue_request(struct avdtp *session, struct pending_req *req,
 			gboolean priority)
 {
diff --git a/android/avdtp.h b/android/avdtp.h
index 9760875..1619029 100644
--- a/android/avdtp.h
+++ b/android/avdtp.h
@@ -200,9 +200,15 @@ struct avdtp_sep_ind {
 
 typedef void (*avdtp_discover_cb_t) (struct avdtp *session, GSList *seps,
 					struct avdtp_error *err, void *user_data);
+typedef void (*avdtp_disconnect_cb_t) (void *user_data);
 
 struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
 
+unsigned int avdtp_add_disconnect_cb(struct avdtp *session,
+						avdtp_disconnect_cb_t cb,
+						void *user_data);
+gboolean avdtp_remove_disconnect_cb(struct avdtp *session, unsigned int id);
+
 void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
 
-- 
1.8.3.1

