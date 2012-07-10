Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto <luiz.dentz@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Vani <vani.patel@stericsson.com>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Subject: [PATCH BlueZ 3/5] AVRCP: Add browsing channel support
Date: Tue, 10 Jul 2012 15:06:01 +0530
Message-ID: <1341912961-24600-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

Implements browsing channel creation and release.
---
 audio/avctp.c |  213 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 213 insertions(+), 0 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 844a51f..42eb7df 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -41,6 +41,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/uuid.h>
+#include <bluetooth/l2cap.h>
 
 #include <glib.h>
 
@@ -68,6 +69,8 @@
 #define AVCTP_PACKET_CONTINUE	2
 #define AVCTP_PACKET_END	3
 
+#define AVRCP_BROWSING_HEADER_LENGTH 3
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 struct avctp_header {
@@ -119,6 +122,7 @@ struct avctp_state_callback {
 struct avctp_server {
 	bdaddr_t src;
 	GIOChannel *control_io;
+	GIOChannel *browsing_io;
 	GSList *sessions;
 };
 
@@ -137,9 +141,12 @@ struct avctp {
 	int uinput;
 
 	GIOChannel *control_io;
+	GIOChannel *browsing_io;
 	guint control_io_id;
+	guint browsing_io_id;
 
 	uint16_t control_mtu;
+	uint16_t browsing_mtu;
 
 	uint8_t key_quirks[256];
 	GSList *handlers;
@@ -326,6 +333,17 @@ static void avctp_disconnected(struct avctp *session)
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
@@ -432,6 +450,38 @@ static void handle_response(struct avctp *session, struct avctp_header *avctp,
 	}
 }
 
+static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
+				gpointer data)
+{
+	struct avctp *session = data;
+	uint8_t  *buf;
+	struct avctp_header *avctp;
+	int ret, sock;
+
+	buf = (uint8_t *)malloc(session->browsing_mtu);
+	if (!(cond & G_IO_IN))
+		return FALSE;
+
+	sock = g_io_channel_unix_get_fd(session->browsing_io);
+	ret = read(sock, buf, session->browsing_mtu);
+
+	if (ret <= 0)
+		return FALSE;
+
+	if ((unsigned int) ret < sizeof(struct avctp_header)) {
+		error("Too small AVRCP packet on browsing channel");
+		return FALSE;
+	}
+
+	avctp = (struct avctp_header *) buf;
+
+	if (avctp->packet_type != AVCTP_PACKET_SINGLE)
+		return FALSE;
+
+
+	return TRUE;
+}
+
 static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
@@ -613,6 +663,47 @@ static void init_uinput(struct avctp *session)
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
+	bt_io_get(chan, BT_IO_L2CAP, &gerr,
+			BT_IO_OPT_DEST, &address,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", err->message);
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
+				(GIOFunc) session_browsing_cb, session);
+}
+
 static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct avctp *session = data;
@@ -651,6 +742,28 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 				(GIOFunc) session_cb, session);
 }
 
+static void auth_browsing_cb(DBusError *derr, void *user_data)
+{
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
+		g_error_free(err);
+	}
+}
+
 static void auth_cb(DBusError *derr, void *user_data)
 {
 	struct avctp *session = user_data;
@@ -729,6 +842,70 @@ static struct avctp *avctp_get_internal(const bdaddr_t *src,
 	return session;
 }
 
+static void avctp_confirm_browsing_cb(GIOChannel *chan, gpointer data)
+{
+	struct avctp *session;
+	struct audio_device *dev;
+	char address[18];
+	bdaddr_t src, dst;
+	GError *err = NULL;
+
+	bt_io_get(chan, BT_IO_L2CAP, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		g_error_free(err);
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
+	session = avctp_get_internal(&src, &dst);
+	if (!session)
+		goto drop;
+
+	dev = manager_get_device(&src, &dst, FALSE);
+	if (!dev) {
+		dev = manager_get_device(&src, &dst, TRUE);
+		if (!dev) {
+			error("Browsing: Unable to get audio dev object for %s",
+								 address);
+			goto drop;
+		}
+	}
+
+	if (dev->control == NULL) {
+		btd_device_add_uuid(dev->btd_dev, AVRCP_REMOTE_UUID);
+		if (dev->control == NULL)
+			goto drop;
+	}
+
+	if (!session->control_io) {
+		error("Browsing: Refusing unexpected connect from %s", address);
+		goto drop;
+	}
+
+	if (session->browsing_io) {
+		error("Browsing channel already exist %s", address);
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
@@ -814,6 +991,28 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master)
 	return io;
 }
 
+static GIOChannel *avctp_server_browsing_socket(const bdaddr_t *src,
+							gboolean master)
+{
+	GError *err = NULL;
+	GIOChannel *b_io;
+
+	b_io = bt_io_listen(BT_IO_L2CAP, NULL, avctp_confirm_browsing_cb, NULL,
+				NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_PSM, AVCTP_BROWSING_PSM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_MASTER, master,
+				BT_IO_OPT_MODE, L2CAP_MODE_ERTM,
+				BT_IO_OPT_INVALID);
+	if (!b_io) {
+		error("Browsing: %s", err->message);
+		g_error_free(err);
+	}
+
+	return b_io;
+}
+
 static unsigned int passthrough_id = 0;
 static unsigned int unit_id = 0;
 static unsigned int subunit_id = 0;
@@ -832,6 +1031,17 @@ int avctp_register(const bdaddr_t *src, gboolean master)
 		return -1;
 	}
 
+	server->browsing_io = avctp_server_browsing_socket(src, master);
+	if (!server->browsing_io) {
+		if (server->control_io) {
+			g_io_channel_shutdown(server->control_io, TRUE, NULL);
+			g_io_channel_unref(server->control_io);
+			server->control_io = NULL;
+		}
+		g_free(server);
+		return -1;
+	}
+
 	bacpy(&server->src, src);
 
 	servers = g_slist_append(servers, server);
@@ -863,6 +1073,9 @@ void avctp_unregister(const bdaddr_t *src)
 		avctp_disconnected(server->sessions->data);
 
 	servers = g_slist_remove(servers, server);
+	g_io_channel_shutdown(server->browsing_io, TRUE, NULL);
+	g_io_channel_unref(server->browsing_io);
+	server->browsing_io = NULL;
 
 	g_io_channel_shutdown(server->control_io, TRUE, NULL);
 	g_io_channel_unref(server->control_io);
-- 
1.7.5.4

Regards,
Vani Patel

