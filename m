Return-Path: <cyrus@holtmann.org>
From: Joohi RASTOGI <joohi.rastogi@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Joohi RASTOGI <joohi.rastogi@stericsson.com>
Date: Fri, 21 Sep 2012 07:22:30 +0200
Subject: [PATCH BlueZ V8 3/5] AVRCP: Add browsing channel support
Message-ID: <3176460F0F455A44B2E93431E34FC86C228F881F33@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 2439be8dc6289ad4e6461471c3cb0861d25c91e6 Mon Sep 17 00:00:00 2001
From: Joohi Rastogi <joohi.rastogi@stericsson.com>
Date: Fri, 21 Sep 2012 10:16:51 +0530
Subject: [PATCH BlueZ V8 3/5] Implements browsing channel creation and release

---
 audio/avctp.c |  265 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 235 insertions(+), 30 deletions(-)
 mode change 100755 => 100644 audio/avctp.c

diff --git a/audio/avctp.c b/audio/avctp.c
old mode 100755
new mode 100644
index 36133b3..daeb016
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -42,6 +42,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/uuid.h>
+#include <bluetooth/l2cap.h>
 
 #include <glib.h>
 
@@ -120,6 +121,7 @@ struct avctp_state_callback {
 struct avctp_server {
 	bdaddr_t src;
 	GIOChannel *control_io;
+	GIOChannel *browsing_io;
 	GSList *sessions;
 };
 
@@ -138,9 +140,12 @@ struct avctp {
 	int uinput;
 
 	GIOChannel *control_io;
+	GIOChannel *browsing_io;
 	guint control_io_id;
+	guint browsing_io_id;
 
 	uint16_t control_mtu;
+	uint16_t browsing_mtu;
 
 	uint8_t key_quirks[256];
 	GSList *handlers;
@@ -327,6 +332,17 @@ static void avctp_disconnected(struct avctp *session)
 	if (!session)
 		return;
 
+	if (session->browsing_io) {
+		g_io_channel_shutdown(session->browsing_io, TRUE, NULL);
+		g_io_channel_unref(session->browsing_io);
+		session->browsing_io = NULL;
+	}
+
+	if (session->browsing_io_id) {
+		g_source_remove(session->browsing_io_id);
+		session->browsing_io_id = 0;
+	}
+
 	if (session->control_io) {
 		g_io_channel_shutdown(session->control_io, TRUE, NULL);
 		g_io_channel_unref(session->control_io);
@@ -433,31 +449,76 @@ static void handle_response(struct avctp *session, struct avctp_header *avctp,
 	}
 }
 
+static uint8_t *avctp_read_data(int *data_read, int length, GIOChannel
+				*chan) {
+	uint8_t *buffer;
+	int sock;
+
+	buffer = g_new0(uint8_t, length);
+	sock = g_io_channel_unix_get_fd(chan);
+
+	*data_read = read(sock, buffer, length);
+	if (*data_read <= 0)
+		goto failed;
+
+	if (*data_read < AVCTP_HEADER_LENGTH) {
+		error("Too small AVCTP packet");
+		goto failed;
+	}
+	return buffer;
+
+failed:
+	return NULL;
+}
+
+static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
+				gpointer data)
+{
+	struct avctp *session = data;
+	uint8_t  *buf;
+	struct avctp_header *avctp;
+	int ret;
+
+	buf = avctp_read_data(&ret, session->browsing_mtu,
+						session->browsing_io);
+
+	if (buf == NULL)
+		goto failed;
+
+	if (!(cond & G_IO_IN))
+		goto failed;
+
+	avctp = (struct avctp_header *) buf;
+
+	if (avctp->packet_type != AVCTP_PACKET_SINGLE)
+		goto failed;
+
+	g_free(buf);
+	return TRUE;
+
+failed:
+	g_free(buf);
+	return FALSE;
+}
+
 static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
 	struct avctp *session = data;
-	uint8_t buf[1024], *operands, code, subunit;
+	uint8_t *buf, *operands, code, subunit;
 	struct avctp_header *avctp;
 	struct avc_header *avc;
 	int ret, packet_size, operand_count, sock;
 	struct avctp_pdu_handler *handler;
 
-	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
+	buf = avctp_read_data(&ret, session->control_mtu, session->control_io);
+	if (buf == NULL)
 		goto failed;
 
-	sock = g_io_channel_unix_get_fd(session->control_io);
-
-	ret = read(sock, buf, sizeof(buf));
-	if (ret <= 0)
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
 		goto failed;
 
-	DBG("Got %d bytes of data for AVCTP session %p", ret, session);
-
-	if ((unsigned int) ret < sizeof(struct avctp_header)) {
-		error("Too small AVCTP packet");
-		goto failed;
-	}
+	sock = g_io_channel_unix_get_fd(session->control_io);
 
 	avctp = (struct avctp_header *) buf;
 
@@ -487,6 +548,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 
 	if (avctp->cr == AVCTP_RESPONSE) {
 		handle_response(session, avctp, avc, operands, operand_count);
+		g_free(buf);
 		return TRUE;
 	}
 
@@ -526,11 +588,13 @@ done:
 	ret = write(sock, buf, packet_size);
 	if (ret != packet_size)
 		goto failed;
+	g_free(buf);
 
 	return TRUE;
 
 failed:
 	DBG("AVCTP session %p got disconnected", session);
+	g_free(buf);
 	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
 	return FALSE;
 }
@@ -614,6 +678,46 @@ static void init_uinput(struct avctp *session)
 		DBG("AVRCP: uinput initialized for %s", address);
 }
 
+static void avctp_connect_browsing_cb(GIOChannel *chan,
+					GError *err,
+					gpointer data)
+{
+	struct avctp *session = data;
+	char address[18];
+	uint16_t imtu;
+	GError *gerr = NULL;
+
+	if (err) {
+		error("Browsing: %s", err->message);
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		g_io_channel_unref(chan);
+		session->browsing_io = NULL;
+		return;
+	}
+
+	bt_io_get(chan, &gerr,
+			BT_IO_OPT_DEST, &address,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		g_io_channel_unref(chan);
+		session->browsing_io = NULL;
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		return;
+	}
+
+	if (!session->browsing_io)
+		session->browsing_io = g_io_channel_ref(chan);
+
+	session->browsing_mtu = imtu;
+
+	session->browsing_io_id = g_io_add_watch(chan,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) session_browsing_cb, session); }
+
 static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct avctp *session = data;
@@ -652,6 +756,31 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 				(GIOFunc) session_cb, session);
 }
 
+static void auth_browsing_cb(DBusError *derr, void *user_data) {
+	struct avctp *session = user_data;
+	GError *err = NULL;
+
+	if (session->browsing_io_id) {
+		g_source_remove(session->browsing_io_id);
+		session->browsing_io_id = 0;
+	}
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Browsing Access denied: %s", derr->message);
+		return;
+	}
+
+	if (!bt_io_accept(session->browsing_io, avctp_connect_browsing_cb,
+						session, NULL, &err)) {
+		error("Browsing bt_io_accept: %s", err->message);
+		if (session && session->browsing_io) {
+			g_io_channel_unref(session->browsing_io);
+			session->browsing_io = NULL;
+		}
+		g_error_free(err);
+	}
+}
+
 static void auth_cb(DBusError *derr, void *user_data)
 {
 	struct avctp *session = user_data;
@@ -730,6 +859,64 @@ static struct avctp *avctp_get_internal(const bdaddr_t *src,
 	return session;
 }
 
+static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
+						struct audio_device *dev)
+{
+	if (session->control_io) {
+		error("Refusing unexpected connect from");
+		goto drop;
+	}
+
+	avctp_set_state(session, AVCTP_STATE_CONNECTING);
+	session->control_io = g_io_channel_ref(chan);
+
+	if (audio_device_request_authorization(dev, AVRCP_TARGET_UUID,
+						auth_cb, session) < 0)
+		goto drop;
+
+	session->control_io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP |
+						G_IO_NVAL, session_cb, session);
+	return;
+
+drop:
+	if (!session || !session->control_io)
+		g_io_channel_shutdown(chan, TRUE, NULL);
+
+	if (session && session->control_io)
+		g_io_channel_unref(session->control_io);
+
+	if (session)
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED); }
+
+static void avctp_browsing_confirm(struct avctp *session, GIOChannel *chan,
+						struct audio_device *dev)
+{
+
+	if (!session->control_io) {
+		error("Browsing: Refusing unexpected connect from");
+		goto drop;
+	}
+
+	if (session->browsing_io) {
+		error("Browsing channel already exists");
+		goto drop;
+	}
+
+	session->browsing_io = g_io_channel_ref(chan);
+
+	if (audio_device_request_authorization(dev, AVRCP_TARGET_UUID,
+						auth_browsing_cb, session) < 0)
+		goto drop;
+	return;
+
+drop:
+	if (!session || !session->control_io || !session->browsing_io)
+		g_io_channel_shutdown(chan, TRUE, NULL);
+
+	if (session && session->browsing_io)
+		g_io_channel_unref(session->browsing_io);
+}
+
 static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 {
 	struct avctp *session;
@@ -737,11 +924,13 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	char address[18];
 	bdaddr_t src, dst;
 	GError *err = NULL;
+	uint16_t psm;
 
 	bt_io_get(chan, &err,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
 			BT_IO_OPT_DEST_BDADDR, &dst,
 			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_PSM, &psm,
 			BT_IO_OPT_INVALID);
 	if (err) {
 		error("%s", err->message);
@@ -772,30 +961,29 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 			goto drop;
 	}
 
-	if (session->control_io) {
-		error("Refusing unexpected connect from %s", address);
-		goto drop;
+	switch (psm) {
+	case AVCTP_CONTROL_PSM:
+		avctp_control_confirm(session, chan, dev);
+		break;
+	case AVCTP_BROWSING_PSM:
+		avctp_browsing_confirm(session, chan, dev);
+		break;
 	}
 
-	avctp_set_state(session, AVCTP_STATE_CONNECTING);
-	session->control_io = g_io_channel_ref(chan);
-
-	if (audio_device_request_authorization(dev, AVRCP_TARGET_UUID,
-						auth_cb, session) < 0)
-		goto drop;
-
-	session->control_io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							session_cb, session);
 	return;
 
 drop:
-	if (!session || !session->control_io)
-		g_io_channel_shutdown(chan, TRUE, NULL);
-	if (session)
+	if (session && session->browsing_io)
+		g_io_channel_unref(session->browsing_io);
+
+	if (session && session->control_io)
+		g_io_channel_unref(session->control_io);
+
+	if (session && psm == AVCTP_CONTROL_PSM)
 		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
 }
 
-static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master)
+static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master, uint8_t mode, uint16_t psm)
 {
 	GError *err = NULL;
 	GIOChannel *io;
@@ -803,9 +991,10 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master)
 	io = bt_io_listen(NULL, avctp_confirm_cb, NULL,
 				NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_PSM, AVCTP_CONTROL_PSM,
+				BT_IO_OPT_PSM, psm,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_MASTER, master,
+				BT_IO_OPT_MODE, mode,
 				BT_IO_OPT_INVALID);
 	if (!io) {
 		error("%s", err->message);
@@ -825,11 +1014,23 @@ int avctp_register(const bdaddr_t *src, gboolean master)
 
 	server = g_new0(struct avctp_server, 1);
 
-	server->control_io = avctp_server_socket(src, master);
+	server->control_io = avctp_server_socket(src, master, L2CAP_MODE_BASIC,
+							AVCTP_CONTROL_PSM);
 	if (!server->control_io) {
 		g_free(server);
 		return -1;
 	}
+	server->browsing_io = avctp_server_socket(src, master, L2CAP_MODE_ERTM,
+							AVCTP_BROWSING_PSM);
+	if (!server->browsing_io) {
+		if (server->control_io) {
+			g_io_channel_shutdown(server->control_io, TRUE, NULL);
+			g_io_channel_unref(server->control_io);
+			server->control_io = NULL;
+		}
+		g_free(server);
+		return -1;
+	}
 
 	bacpy(&server->src, src);
 
@@ -863,6 +1064,10 @@ void avctp_unregister(const bdaddr_t *src)
 
 	servers = g_slist_remove(servers, server);
 
+	g_io_channel_shutdown(server->browsing_io, TRUE, NULL);
+	g_io_channel_unref(server->browsing_io);
+	server->browsing_io = NULL;
+
 	g_io_channel_shutdown(server->control_io, TRUE, NULL);
 	g_io_channel_unref(server->control_io);
 	g_free(server);
-- 
1.7.5.4

Regards
Joohi
