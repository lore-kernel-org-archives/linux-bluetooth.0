Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 06/20] audio/avdtp: Refactor transport and control channels
Date: Fri, 27 Feb 2015 17:02:54 +0200
Message-Id: <1425049388-18333-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Refactor transport and signaling channels using
avdtp_stream_set_transport() and avdtp_set_control().
---
 profiles/audio/a2dp.c  | 104 ++++++++++++++++++++++++++++++++++++---
 profiles/audio/avdtp.c | 131 ++++++++++++++++++++++++++++++++++++++++---------
 profiles/audio/avdtp.h |   8 ++-
 3 files changed, 212 insertions(+), 31 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index e23455a..ef8ed5e 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -702,12 +702,95 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	return TRUE;
 }
 
+static void transport_connect_cb(GIOChannel *chan, GError *err,
+							gpointer user_data)
+{
+	struct avdtp *session = user_data;
+	uint16_t imtu, omtu;
+	GError *gerr = NULL;
+	char address[18];
+	int fd;
+
+	DBG("");
+
+	if (err) {
+		error("%s", err->message);
+		goto failed;
+	}
+
+	bt_io_get(chan, &gerr,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_OMTU, &omtu,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		goto failed;
+	}
+
+	ba2str(device_get_address(avdtp_get_device(session)), address);
+	DBG("AVDTP: connected transport channel to %s", address);
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	if (!avdtp_stream_set_transport(session, fd, imtu, omtu)) {
+		error("avdtp_stream_set_transport: failed");
+		goto failed;
+	}
+
+	return;
+
+failed:
+	avdtp_send_abort(session);
+}
+
+static void signaling_connect_cb(GIOChannel *chan, GError *err,
+							gpointer user_data)
+{
+	struct avdtp *session = user_data;
+	uint16_t imtu, omtu;
+	int err_no = -EIO;
+	GError *gerr = NULL;
+	char address[18];
+	int fd;
+
+	DBG("");
+
+	if (err) {
+		err_no = err->code;
+		error("%s", err->message);
+		goto failed;
+	}
+
+	bt_io_get(chan, &gerr,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_OMTU, &omtu,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		goto failed;
+	}
+
+	ba2str(device_get_address(avdtp_get_device(session)), address);
+	DBG("AVDTP: connected signaling channel to %s", address);
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	if (avdtp_set_control(session, fd, imtu, omtu))
+		return;
+
+failed:
+	connection_lost(session, err_no);
+}
+
 static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
 	struct a2dp_setup *setup;
+	GIOChannel *io;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Open_Cfm", sep);
@@ -728,9 +811,9 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			finalize_resume(setup);
 	}
 
-	finalize_config(setup);
-
-	return;
+	io = l2cap_connect(session, transport_connect_cb);
+	if (avdtp_stream_set_io(session, stream, sep, io))
+			finalize_config(setup);
 }
 
 static gboolean suspend_timeout(struct a2dp_sep *sep)
@@ -1271,6 +1354,8 @@ GIOChannel *l2cap_connect(struct avdtp *session, BtIOConnect cb)
 	GIOChannel *io;
 	const bdaddr_t *src;
 
+	DBG("session %p", session);
+
 	src = btd_adapter_get_address(avdtp_get_adapter(session));
 
 	io = bt_io_connect(cb, session, NULL, &err,
@@ -1323,13 +1408,15 @@ static void auth_cb(DBusError *derr, void *user_data)
 {
 	struct avdtp *session = user_data;
 
+	DBG("");
+
 	if (derr && dbus_error_is_set(derr)) {
 		error("Access denied: %s", derr->message);
 		connection_lost(session, EACCES);
 		return;
 	}
 
-	avdtp_accept(session);
+	avdtp_accept(session, signaling_connect_cb);
 }
 
 static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
@@ -1370,10 +1457,11 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 		goto drop;
 
 
-	if (avdtp_transport_connect(session, chan)) {
-		btd_device_add_uuid(device, ADVANCED_AUDIO_UUID);
-		avdtp_request_authorization(session, &src, &dst, auth_cb);
-	}
+	if (!avdtp_transport_connect(session, chan))
+		return;
+
+	btd_device_add_uuid(device, ADVANCED_AUDIO_UUID);
+	avdtp_request_authorization(session, &src, &dst, auth_cb);
 
 	return;
 
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 1ea9fe4..1bfbff7 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -799,6 +799,8 @@ static void handle_transport_connect(struct avdtp *session, GIOChannel *io,
 		stream->timer = 0;
 	}
 
+	DBG("session %p io %p", session, io);
+
 	if (io == NULL) {
 		if (!stream->open_acp && sep->cfm && sep->cfm->open) {
 			struct avdtp_error err;
@@ -841,9 +843,6 @@ static void handle_transport_connect(struct avdtp *session, GIOChannel *io,
 	}
 
 proceed:
-	if (!stream->open_acp && sep->cfm && sep->cfm->open)
-		sep->cfm->open(session, sep, stream, NULL, sep->user_data);
-
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_OPEN);
 
 	stream->io_id = g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
@@ -2255,6 +2254,21 @@ failed:
 	return FALSE;
 }
 
+static int set_priority(int fd, int priority)
+{
+	int err;
+
+	err = setsockopt(fd, SOL_SOCKET, SO_PRIORITY, &priority,
+							sizeof(priority));
+	if (err == 0 || errno == ENOTSOCK)
+		return 0;
+
+	err = -errno;
+	error("setsockopt(SO_PRIORITY): %s (%d)", strerror(-err), -err);
+
+	return err;
+}
+
 static bool match_by_device(const void *data, const void *user_data)
 {
 	const struct avdtp *session = data;
@@ -2296,6 +2310,58 @@ static uint16_t get_version(struct avdtp *session)
 	return ver;
 }
 
+bool avdtp_set_control(struct avdtp *session, int fd, size_t imtu, size_t omtu)
+{
+	GIOChannel *chan = g_io_channel_unix_new(fd);
+
+	session->imtu = imtu;
+	session->omtu = omtu;
+
+	DBG("AVDTP imtu=%u, omtu=%u", session->imtu, session->omtu);
+
+	session->buf = g_malloc0(MAX(imtu, omtu));
+	avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTED);
+
+	if (!session->io)
+		session->io = g_io_channel_ref(chan);
+
+	if (session->io_id)
+		g_source_remove(session->io_id);
+
+	/* This watch should be low priority since otherwise the
+	 * connect callback might be dispatched before the session
+	 * callback if the kernel wakes us up at the same time for
+	 * them. This could happen if a headset is very quick in
+	 * sending the Start command after connecting the stream
+	 * transport channel.
+	 */
+	session->io_id = g_io_add_watch_full(chan,
+						G_PRIORITY_LOW,
+						G_IO_IN | G_IO_ERR | G_IO_HUP
+						| G_IO_NVAL,
+						(GIOFunc) session_cb, session,
+						NULL);
+
+	if (session->stream_setup)
+		set_disconnect_timer(session);
+
+	process_queue(session);
+
+	return true;
+}
+
+bool avdtp_stream_set_io(struct avdtp *session, struct avdtp_stream *stream,
+				struct avdtp_local_sep *sep, GIOChannel *io)
+{
+	if (!io) {
+		avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
+		return false;
+	}
+
+	stream->io = io;
+	return true;
+}
+
 static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct avdtp *session = user_data;
@@ -2588,14 +2654,7 @@ static int send_req(struct avdtp *session, gboolean priority,
 	static int transaction = 0;
 	int err;
 
-	if (session->state == AVDTP_SESSION_STATE_DISCONNECTED) {
-		session->io = l2cap_connect(session, avdtp_connect_cb);
-		if (!session->io) {
-			err = -EIO;
-			goto failed;
-		}
-		avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTING);
-	}
+	DBG("session %p", session);
 
 	if (session->state < AVDTP_SESSION_STATE_CONNECTED ||
 			session->req != NULL) {
@@ -2766,19 +2825,17 @@ static gboolean avdtp_reconfigure_resp(struct avdtp *session,
 	return TRUE;
 }
 
-static gboolean avdtp_open_resp(struct avdtp *session, struct avdtp_stream *stream,
+static gboolean avdtp_open_resp(struct avdtp *session,
+				struct avdtp_stream *stream,
 				struct seid_rej *resp, int size)
 {
 	struct avdtp_local_sep *sep = stream->lsep;
 
-	stream->io = l2cap_connect(session, avdtp_connect_cb);
-	if (!stream->io) {
-		avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
-		return FALSE;
-	}
-
 	session->pending_open = stream;
 
+	if (!stream->open_acp && sep->cfm && sep->cfm->open)
+		sep->cfm->open(session, sep, stream, NULL, sep->user_data);
+
 	return TRUE;
 }
 
@@ -3135,6 +3192,24 @@ struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 	return NULL;
 }
 
+bool avdtp_stream_set_transport(struct avdtp *session, int fd, size_t imtu,
+								size_t omtu)
+{
+	GIOChannel *io;
+
+	if (set_priority(fd, 5) < 0)
+		return FALSE;
+
+	io = g_io_channel_unix_new(fd);
+
+	handle_transport_connect(session, io, imtu, omtu);
+
+	g_io_channel_unref(io);
+
+	return TRUE;
+
+}
+
 gboolean avdtp_stream_get_transport(struct avdtp_stream *stream, int *sock,
 					uint16_t *imtu, uint16_t *omtu,
 					GSList **caps)
@@ -3545,6 +3620,17 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 	return ret;
 }
 
+void avdtp_send_abort(struct avdtp *session)
+{
+	struct avdtp_stream *stream = session->pending_open;
+
+	handle_transport_connect(session, NULL, 0, 0);
+
+	if (avdtp_abort(session, stream) < 0)
+		avdtp_sep_set_state(session, stream->lsep,
+						AVDTP_STATE_IDLE);
+}
+
 int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							uint16_t delay)
 {
@@ -3570,19 +3656,20 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							&req, sizeof(req));
 }
 
-void avdtp_accept(struct avdtp *session)
+void avdtp_accept(struct avdtp *session, BtIOConnect cb)
 {
 	GError *err = NULL;
 
-	if (!bt_io_accept(session->io, avdtp_connect_cb, session, NULL,
-								&err)) {
+	DBG("session %p", session);
+
+	if (!bt_io_accept(session->io, cb, session, NULL, &err)) {
 		error("bt_io_accept: %s", err->message);
 		connection_lost(session, EACCES);
 		g_error_free(err);
 		return;
 	}
 
-	/* This is so that avdtp_connect_cb will know to do the right thing
+	/* This is so that connect_cb will know to do the right thing
 	 * with respect to the disconnect timer */
 	session->stream_setup = TRUE;
 }
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 28277cc..a68dc4d 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -264,6 +264,7 @@ int avdtp_suspend(struct avdtp *session, struct avdtp_stream *stream);
 int avdtp_close(struct avdtp *session, struct avdtp_stream *stream,
 		gboolean immediate);
 int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream);
+void avdtp_send_abort(struct avdtp *session);
 int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							uint16_t delay);
 
@@ -299,7 +300,12 @@ struct avdtp *avdtp_new(struct avdtp_server *server, struct queue *sessions,
 bool avdtp_transport_connect(struct avdtp *session, GIOChannel *chan);
 void avdtp_free(void *data);
 void connection_lost(struct avdtp *session, int err);
-void avdtp_accept(struct avdtp *session);
+void avdtp_accept(struct avdtp *session, BtIOConnect cb);
 bool avdtp_request_authorization(struct avdtp *session, const bdaddr_t *src,
 							const bdaddr_t *dst,
 							service_auth_cb cb);
+bool avdtp_set_control(struct avdtp *session, int fd, size_t imtu, size_t omtu);
+bool avdtp_stream_set_transport(struct avdtp *session, int fd, size_t imtu,
+								size_t omtu);
+bool avdtp_stream_set_io(struct avdtp *session, struct avdtp_stream *stream,
+				struct avdtp_local_sep *sep, GIOChannel *io);
-- 
2.1.0

