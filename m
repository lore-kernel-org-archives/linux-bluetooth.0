Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 12/20] audio/avdtp: Make use of disconnect callback
Date: Fri, 27 Feb 2015 17:03:00 +0200
Message-Id: <1425049388-18333-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

disconnect callback will be used for cancelling authorization request.
---
 profiles/audio/a2dp.c  |  8 ++++++
 profiles/audio/avdtp.c | 74 ++++++++++++++++++++++++++++++++++++++++++--------
 profiles/audio/avdtp.h |  7 +++++
 3 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index df2b2b8..ac7e985 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1448,6 +1448,13 @@ static void auth_cb(DBusError *derr, void *user_data)
 	avdtp_accept(session, signaling_connect_cb);
 }
 
+static void disconnect_cb(void *user_data)
+{
+	struct avdtp *session = user_data;
+
+	avdtp_cancel_authorization(session);
+}
+
 static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 {
 	struct avdtp *session;
@@ -1490,6 +1497,7 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 		return;
 
 	btd_device_add_uuid(device, ADVANCED_AUDIO_UUID);
+	avdtp_add_disconnect_cb(session, disconnect_cb, session);
 	avdtp_request_authorization(session, &src, &dst, auth_cb);
 
 	return;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index fb860ef..4361e23 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -343,16 +343,22 @@ struct stream_callback {
 	unsigned int id;
 };
 
-struct avdtp_state_callback {
-	avdtp_session_state_cb cb;
-	struct btd_device *dev;
+struct discover_callback {
 	unsigned int id;
+	avdtp_discover_cb_t cb;
 	void *user_data;
 };
 
-struct discover_callback {
+struct disconnect_callback {
+	unsigned int id;
+	avdtp_disconnect_cb_t cb;
+	void *user_data;
+};
+
+struct avdtp_state_callback {
+	avdtp_session_state_cb cb;
+	struct btd_device *dev;
 	unsigned int id;
-	avdtp_discover_cb_t cb;
 	void *user_data;
 };
 
@@ -415,6 +421,8 @@ struct avdtp {
 	struct discover_callback *discover;
 	struct pending_req *req;
 
+	GSList *disconnect;
+
 	guint dc_timer;
 
 	/* Attempt stream setup instead of disconnecting */
@@ -1060,7 +1068,7 @@ static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
 }
 
-static int avdtp_cancel_authorization(struct avdtp *session)
+int avdtp_cancel_authorization(struct avdtp *session)
 {
 	int err;
 
@@ -1121,6 +1129,7 @@ void avdtp_free(void *data)
 	g_slist_free_full(session->req_queue, pending_req_free);
 	g_slist_free_full(session->prio_queue, pending_req_free);
 	g_slist_free_full(session->seps, sep_free);
+	g_slist_free_full(session->disconnect, g_free);
 
 	g_free(session->buf);
 
@@ -1128,21 +1137,27 @@ void avdtp_free(void *data)
 	g_free(session);
 }
 
-void connection_lost(struct avdtp *session, int err)
+static void process_disconnect(void *data)
 {
-	char address[18];
+	struct disconnect_callback *callback = data;
 
-	ba2str(device_get_address(session->device), address);
-	DBG("Disconnected from %s", address);
+	callback->cb(callback->user_data);
 
-	if (err != EACCES)
-		avdtp_cancel_authorization(session);
+	g_free(callback);
+}
+
+void connection_lost(struct avdtp *session, int err)
+{
+	DBG("Disconnected: %s (%d)", strerror(err), err);
 
 	g_slist_foreach(session->streams, (GFunc) release_stream, session);
 	session->streams = NULL;
 
 	finalize_discovery(session, err);
 
+	g_slist_free_full(session->disconnect, process_disconnect);
+	session->disconnect = NULL;
+
 	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
 
 	if (session->ref > 0)
@@ -2507,6 +2522,41 @@ bool avdtp_request_authorization(struct avdtp *session, const bdaddr_t *src,
 	return true;
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
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 88e8cb4..af55f76 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -213,6 +213,12 @@ struct avdtp_sep_ind {
 
 typedef void (*avdtp_discover_cb_t) (struct avdtp *session, GSList *seps,
 					struct avdtp_error *err, void *user_data);
+typedef void (*avdtp_disconnect_cb_t) (void *user_data);
+
+unsigned int avdtp_add_disconnect_cb(struct avdtp *session,
+						avdtp_disconnect_cb_t cb,
+						void *user_data);
+gboolean avdtp_remove_disconnect_cb(struct avdtp *session, unsigned int id);
 
 void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
@@ -305,6 +311,7 @@ void avdtp_accept(struct avdtp *session, BtIOConnect cb);
 bool avdtp_request_authorization(struct avdtp *session, const bdaddr_t *src,
 							const bdaddr_t *dst,
 							service_auth_cb cb);
+int avdtp_cancel_authorization(struct avdtp *session);
 bool avdtp_set_control(struct avdtp *session, int fd, size_t imtu, size_t omtu);
 bool avdtp_stream_set_transport(struct avdtp *session, int fd, size_t imtu,
 								size_t omtu);
-- 
2.1.0

