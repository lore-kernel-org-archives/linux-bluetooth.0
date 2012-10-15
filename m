Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/16] AVCTP: Simplify channel handling
Date: Mon, 15 Oct 2012 16:05:21 +0200
Message-Id: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make both control and browsing channels to use the same structure to
store its channel information.
---
 audio/avctp.c | 155 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 82 insertions(+), 73 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 53c28ec..092a5e2 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -131,6 +131,12 @@ struct avctp_rsp_handler {
 	void *user_data;
 };
 
+struct avctp_channel {
+	GIOChannel *io;
+	guint watch;
+	uint16_t mtu;
+};
+
 struct avctp {
 	struct avctp_server *server;
 	bdaddr_t dst;
@@ -139,14 +145,10 @@ struct avctp {
 
 	int uinput;
 
-	GIOChannel *control_io;
-	GIOChannel *browsing_io;
-	guint control_io_id;
-	guint browsing_io_id;
 	guint auth_id;
 
-	uint16_t control_mtu;
-	uint16_t browsing_mtu;
+	struct avctp_channel *control;
+	struct avctp_channel *browsing;
 
 	uint8_t key_quirks[256];
 	GSList *handlers;
@@ -333,6 +335,17 @@ static struct avctp_pdu_handler *find_handler(GSList *list, uint8_t opcode)
 	return NULL;
 }
 
+static void avctp_channel_destroy(struct avctp_channel *chan)
+{
+	g_io_channel_shutdown(chan->io, TRUE, NULL);
+	g_io_channel_unref(chan->io);
+
+	if (chan->watch)
+		g_source_remove(chan->watch);
+
+	g_free(chan);
+}
+
 static void avctp_disconnected(struct avctp *session)
 {
 	struct avctp_server *server;
@@ -340,31 +353,15 @@ static void avctp_disconnected(struct avctp *session)
 	if (!session)
 		return;
 
-	if (session->browsing_io) {
-		g_io_channel_shutdown(session->browsing_io, TRUE, NULL);
-		g_io_channel_unref(session->browsing_io);
-		session->browsing_io = NULL;
-	}
-
-	if (session->browsing_io_id) {
-		g_source_remove(session->browsing_io_id);
-		session->browsing_io_id = 0;
-	}
-
-	if (session->control_io) {
-		g_io_channel_shutdown(session->control_io, TRUE, NULL);
-		g_io_channel_unref(session->control_io);
-		session->control_io = NULL;
-	}
+	if (session->browsing)
+		avctp_channel_destroy(session->browsing);
 
-	if (session->control_io_id) {
-		g_source_remove(session->control_io_id);
-		session->control_io_id = 0;
+	if (session->control)
+		avctp_channel_destroy(session->control);
 
-		if (session->auth_id != 0) {
-			btd_cancel_authorization(session->auth_id);
-			session->auth_id = 0;
-		}
+	if (session->auth_id != 0) {
+		btd_cancel_authorization(session->auth_id);
+		session->auth_id = 0;
 	}
 
 	if (session->uinput >= 0) {
@@ -420,7 +417,7 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 	}
 }
 
-static void handle_response(struct avctp *session, struct avctp_header *avctp,
+static void control_response(struct avctp *session, struct avctp_header *avctp,
 				struct avc_header *avc, uint8_t *operands,
 				size_t operand_count)
 {
@@ -456,7 +453,7 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
 		goto failed;
 
-	sock = g_io_channel_unix_get_fd(session->browsing_io);
+	sock = g_io_channel_unix_get_fd(chan);
 
 	ret = read(sock, buf, sizeof(buf));
 	if (ret <= 0)
@@ -508,7 +505,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
 		goto failed;
 
-	sock = g_io_channel_unix_get_fd(session->control_io);
+	sock = g_io_channel_unix_get_fd(chan);
 
 	ret = read(sock, buf, sizeof(buf));
 	if (ret <= 0)
@@ -548,7 +545,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 			avc->opcode, operand_count);
 
 	if (avctp->cr == AVCTP_RESPONSE) {
-		handle_response(session, avctp, avc, operands, operand_count);
+		control_response(session, avctp, avc, operands, operand_count);
 		return TRUE;
 	}
 
@@ -676,6 +673,16 @@ static void init_uinput(struct avctp *session)
 		DBG("AVRCP: uinput initialized for %s", address);
 }
 
+static struct avctp_channel *avctp_channel_create(GIOChannel *io)
+{
+	struct avctp_channel *chan;
+
+	chan = g_new0(struct avctp_channel, 1);
+	chan->io = g_io_channel_ref(io);
+
+	return chan;
+}
+
 static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 							gpointer data)
 {
@@ -686,10 +693,7 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 
 	if (err) {
 		error("Browsing: %s", err->message);
-		g_io_channel_shutdown(chan, TRUE, NULL);
-		g_io_channel_unref(chan);
-		session->browsing_io = NULL;
-		return;
+		goto fail;
 	}
 
 	bt_io_get(chan, &gerr,
@@ -700,20 +704,28 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 		error("%s", gerr->message);
 		g_io_channel_shutdown(chan, TRUE, NULL);
 		g_io_channel_unref(chan);
-		session->browsing_io = NULL;
 		g_error_free(gerr);
-		return;
+		goto fail;
 	}
 
 	DBG("AVCTP Browsing: connected to %s", address);
 
-	if (!session->browsing_io)
-		session->browsing_io = g_io_channel_ref(chan);
+	if (session->browsing == NULL)
+		session->browsing = avctp_channel_create(chan);
 
-	session->browsing_mtu = imtu;
-	session->browsing_io_id = g_io_add_watch(chan,
+	session->browsing->mtu = imtu;
+	session->browsing->watch = g_io_add_watch(session->browsing->io,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				(GIOFunc) session_browsing_cb, session); }
+				(GIOFunc) session_browsing_cb, session);
+
+	return;
+
+fail:
+	if (session->browsing) {
+		avctp_channel_destroy(session->browsing);
+		session->browsing = NULL;
+	}
+}
 
 static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
@@ -741,16 +753,17 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 
 	DBG("AVCTP: connected to %s", address);
 
-	if (!session->control_io)
-		session->control_io = g_io_channel_ref(chan);
+	if (session->control == NULL)
+		session->control = avctp_channel_create(chan);
+
+	session->control->mtu = imtu;
+	session->control->watch = g_io_add_watch(session->control->io,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) session_cb, session);
 
 	init_uinput(session);
 
 	avctp_set_state(session, AVCTP_STATE_CONNECTED);
-	session->control_mtu = imtu;
-	session->control_io_id = g_io_add_watch(chan,
-				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				(GIOFunc) session_cb, session);
 }
 
 static void auth_cb(DBusError *derr, void *user_data)
@@ -760,9 +773,9 @@ static void auth_cb(DBusError *derr, void *user_data)
 
 	session->auth_id = 0;
 
-	if (session->control_io_id) {
-		g_source_remove(session->control_io_id);
-		session->control_io_id = 0;
+	if (session->control->watch > 0) {
+		g_source_remove(session->control->watch);
+		session->control->watch = 0;
 	}
 
 	if (derr && dbus_error_is_set(derr)) {
@@ -771,7 +784,7 @@ static void auth_cb(DBusError *derr, void *user_data)
 		return;
 	}
 
-	if (!bt_io_accept(session->control_io, avctp_connect_cb, session,
+	if (!bt_io_accept(session->control->io, avctp_connect_cb, session,
 								NULL, &err)) {
 		error("bt_io_accept: %s", err->message);
 		g_error_free(err);
@@ -836,14 +849,14 @@ static struct avctp *avctp_get_internal(const bdaddr_t *src,
 static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 						struct audio_device *dev)
 {
-	if (session->control_io) {
+	if (session->control != NULL) {
 		error("Control: Refusing unexpected connect");
 		g_io_channel_shutdown(chan, TRUE, NULL);
 		return;
 	}
 
 	avctp_set_state(session, AVCTP_STATE_CONNECTING);
-	session->control_io = g_io_channel_ref(chan);
+	session->control = avctp_channel_create(chan);
 
 	session->auth_id = btd_request_authorization(&dev->src, &dev->dst,
 							AVRCP_TARGET_UUID,
@@ -851,7 +864,7 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	if (session->auth_id == 0)
 		goto drop;
 
-	session->control_io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP |
+	session->control->watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP |
 						G_IO_NVAL, session_cb, session);
 	return;
 
@@ -864,7 +877,7 @@ static void avctp_browsing_confirm(struct avctp *session, GIOChannel *chan,
 {
 	GError *err = NULL;
 
-	if (session->control_io == NULL || session->browsing_io) {
+	if (session->control == NULL || session->browsing != NULL) {
 		error("Browsing: Refusing unexpected connect");
 		g_io_channel_shutdown(chan, TRUE, NULL);
 		return;
@@ -911,8 +924,8 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	DBG("AVCTP: incoming connect from %s", address);
 
 	session = avctp_get_internal(&src, &dst);
-	if (!session)
-		goto drop;
+	if (session == NULL)
+		return;
 
 	dev = manager_get_device(&src, &dst, FALSE);
 	if (!dev) {
@@ -942,13 +955,7 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	return;
 
 drop:
-	if (session && session->browsing_io)
-		g_io_channel_unref(session->browsing_io);
-
-	if (session && session->control_io)
-		g_io_channel_unref(session->control_io);
-
-	if (session && psm == AVCTP_CONTROL_PSM)
+	if (psm == AVCTP_CONTROL_PSM)
 		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
 }
 
@@ -1086,7 +1093,7 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op)
 	operands[0] = op & 0x7f;
 	operands[1] = 0;
 
-	sk = g_io_channel_unix_get_fd(session->control_io);
+	sk = g_io_channel_unix_get_fd(session->control->io);
 
 	if (write(sk, buf, sizeof(buf)) < 0)
 		return -errno;
@@ -1115,7 +1122,7 @@ static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
 	if (session->state != AVCTP_STATE_CONNECTED)
 		return -ENOTCONN;
 
-	sk = g_io_channel_unix_get_fd(session->control_io);
+	sk = g_io_channel_unix_get_fd(session->control->io);
 
 	memset(buf, 0, sizeof(buf));
 
@@ -1299,7 +1306,8 @@ struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
 		return NULL;
 	}
 
-	session->control_io = io;
+	session->control = avctp_channel_create(io);
+	g_io_channel_unref(io);
 
 	return session;
 }
@@ -1312,7 +1320,7 @@ int avctp_connect_browsing(struct avctp *session)
 	if (session->state != AVCTP_STATE_CONNECTED)
 		return -ENOTCONN;
 
-	if (session->browsing_io != NULL)
+	if (session->browsing != NULL)
 		return 0;
 
 	io = bt_io_connect(avctp_connect_browsing_cb, session, NULL, &err,
@@ -1327,14 +1335,15 @@ int avctp_connect_browsing(struct avctp *session)
 		return -EIO;
 	}
 
-	session->browsing_io = io;
+	session->browsing = avctp_channel_create(io);
+	g_io_channel_unref(io);
 
 	return 0;
 }
 
 void avctp_disconnect(struct avctp *session)
 {
-	if (!session->control_io)
+	if (session->state == AVCTP_STATE_DISCONNECTED)
 		return;
 
 	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
-- 
1.7.11.4

