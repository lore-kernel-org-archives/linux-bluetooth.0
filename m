Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 26 Mar 2012 15:31:07 +0200
Subject: RFC:[PATCH Bluez 2/3] Browsing Channel creation for AVRCP 1.4
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B21A7973F2A@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch is for creation of browsing server socket and browsing session creation. 

>From 0a8c2327a90c7ea5ec8658b99a240f3ecbd2aecd Mon Sep 17 00:00:00 2001
From: Vani Patel <vani.patel@stericsson.com>
Date: Mon, 26 Mar 2012 14:44:23 +0530
Subject: [PATCH Bluez 2/3] Browsing Channel creation for AVRCP 1.4

---
 audio/avctp.c |  217 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/avctp.h |    3 +
 audio/avrcp.h |    4 +
 3 files changed, 224 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 audio/avctp.c
 mode change 100644 => 100755 audio/avctp.h
 mode change 100644 => 100755 audio/avrcp.h

diff --git a/audio/avctp.c b/audio/avctp.c
old mode 100644
new mode 100755
index dfad9fd..ff4aa30
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -40,6 +40,7 @@
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
+#include <bluetooth/l2cap.h>
 
 #include <glib.h>
 
@@ -118,6 +119,7 @@ struct avctp_state_callback {
 struct avctp_server {
 	bdaddr_t src;
 	GIOChannel *io;
+	GIOChannel *b_io;
 	GSList *sessions;
 };
 
@@ -130,9 +132,12 @@ struct avctp {
 	int uinput;
 
 	GIOChannel *io;
+	GIOChannel *b_io;
 	guint io_id;
+	guint b_io_id;
 
 	uint16_t mtu;
+	uint16_t b_mtu;
 
 	uint8_t key_quirks[256];
 };
@@ -144,6 +149,12 @@ struct avctp_pdu_handler {
 	unsigned int id;
 };
 
+struct avctp_browsing_pdu_handler {
+	avctp_browsing_pdu_cb cb;
+	void *user_data;
+	unsigned int id;
+};
+
 static struct {
 	const char *name;
 	uint8_t avc;
@@ -162,6 +173,7 @@ static struct {
 static GSList *callbacks = NULL;
 static GSList *servers = NULL;
 static GSList *handlers = NULL;
+static GSList *browsing_handlers = NULL;
 
 static void auth_cb(DBusError *derr, void *user_data);
 
@@ -307,6 +319,16 @@ static struct avctp_pdu_handler *find_handler(GSList *list, uint8_t opcode)
 	return NULL;
 }
 
+static struct avctp_browsing_pdu_handler *find_browsing_handler(GSList *list)
+{
+	for (; list; list = list->next) {
+		struct avctp_browsing_pdu_handler *handler = list->data;
+			return handler;
+	}
+
+	return NULL;
+}
+
 static void avctp_disconnected(struct avctp *session)
 {
 	struct avctp_server *server = session->server;
@@ -392,6 +414,47 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 		return;
 	}
 }
+static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
+				gpointer data)
+{
+	struct avctp *session = data;
+	uint8_t buf[1024], *operands;
+	struct avctp_header *avctp;
+	int ret = 0, packet_size = 0, operand_count = 0, sock;
+	struct avctp_browsing_pdu_handler *b_handler;
+
+	if (!(cond & G_IO_IN))
+		return FALSE;
+
+	sock = g_io_channel_unix_get_fd(session->b_io);
+	ret = read(sock, buf, sizeof(buf));
+
+	if (ret <= 0)
+		return FALSE;
+
+	if ((unsigned int) ret < sizeof(struct avctp_header)) {
+		error("session_browsing_cb Too small AVCTP packet");
+		return FALSE;
+	}
+
+	avctp = (struct avctp_header *) buf;
+	operands = buf + sizeof(struct avctp_header);
+	ret -= sizeof(struct avctp_header);
+	ret -= sizeof(struct avrcp_browsing_header);
+	operand_count = ret;
+
+	b_handler = find_browsing_handler(browsing_handlers);
+	if (b_handler->cb)
+		packet_size = b_handler->cb(session, avctp->transaction, operands, operand_count, b_handler->user_data);
+
+	if (packet_size != 0) {
+		ret = write(sock, buf, packet_size);
+		if (ret != packet_size)
+			return FALSE;
+	}
+	return TRUE;
+}
+
 
 static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
@@ -572,6 +635,46 @@ static void init_uinput(struct avctp *session)
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
+		error("%s", err->message);
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		g_io_channel_unref(chan);
+		session->b_io = NULL;
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
+		session->b_io = NULL;
+		error("%s", gerr->message);
+		g_error_free(gerr);
+
+		return;
+	}
+	if (!session->b_io)
+		session->b_io = g_io_channel_ref(chan);
+
+	session->b_mtu = imtu;
+
+	session->b_io_id = g_io_add_watch(chan,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) session_browsing_cb, session);
+}
 static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct avctp *session = data;
@@ -610,6 +713,27 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 				(GIOFunc) session_cb, session);
 }
 
+static void auth_browsing_cb(DBusError *derr, void *user_data)
+{
+	struct avctp *session = user_data;
+	GError *err = NULL;
+
+	if (session->b_io_id) {
+		g_source_remove(session->io_id);
+		session->b_io_id = 0;
+	}
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		return;
+	}
+	if (!bt_io_accept(session->b_io, avctp_connect_browsing_cb, session,
+								NULL, &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
+	}
+}
+
 static void auth_cb(DBusError *derr, void *user_data)
 {
 	struct avctp *session = user_data;
@@ -688,6 +812,70 @@ static struct avctp *avctp_get_internal(const bdaddr_t *src,
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
+			error("Unable to get audio device object for %s",
+					address);
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
+	if (!session->io) {
+		error("Refusing unexpected connect from %s", address);
+		goto drop;
+	}
+
+	if (session->b_io) {
+		error("%s: Refusing unexpected browsing connect from "
+			"Browsing channel already exist %s", __func__, address);
+		goto drop;
+	}
+
+	session->b_io = g_io_channel_ref(chan);
+
+	if (audio_device_request_authorization(dev, AVRCP_TARGET_UUID,
+						auth_browsing_cb, session) < 0)
+		goto drop;
+	return;
+
+drop:
+	if (!session || !session->io || !session->b_io)
+		g_io_channel_shutdown(chan, TRUE, NULL);
+	if (session && session->b_io)
+		g_io_channel_unref(session->b_io);
+}
+
 static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 {
 	struct avctp *session;
@@ -773,6 +961,27 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master)
 	return io;
 }
 
+static GIOChannel *avctp_server_browsing_socket(const bdaddr_t *src, gboolean master)
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
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
+	return b_io;
+}
+
 static unsigned int passthrough_id = 0;
 static unsigned int unit_id = 0;
 static unsigned int subunit_id = 0;
@@ -790,6 +999,11 @@ int avctp_register(const bdaddr_t *src, gboolean master)
 		g_free(server);
 		return -1;
 	}
+	server->b_io = avctp_server_browsing_socket(src, master);
+	if (!server->b_io) {
+		g_free(server);
+		return -1;
+	}
 
 	bacpy(&server->src, src);
 
@@ -822,6 +1036,9 @@ void avctp_unregister(const bdaddr_t *src)
 		avctp_disconnected(server->sessions->data);
 
 	servers = g_slist_remove(servers, server);
+	g_io_channel_shutdown(server->b_io, TRUE, NULL);
+	g_io_channel_unref(server->b_io);
+	server->b_io = NULL;
 
 	g_io_channel_shutdown(server->io, TRUE, NULL);
 	g_io_channel_unref(server->io);
diff --git a/audio/avctp.h b/audio/avctp.h
old mode 100644
new mode 100755
index fb6be2f..a97fec5
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -79,6 +79,9 @@ typedef size_t (*avctp_pdu_cb) (struct avctp *session, uint8_t transaction,
 					uint8_t *code, uint8_t *subunit,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
+typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session, uint8_t transaction,
+					uint8_t *operands, size_t operand_count,
+					void *user_data);
 
 unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data);
 gboolean avctp_remove_state_cb(unsigned int id);
diff --git a/audio/avrcp.h b/audio/avrcp.h
old mode 100644
new mode 100755
index 8a09546..2aeec7d
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -75,6 +75,10 @@
 #define AVRCP_EVENT_TRACK_REACHED_START	0x04
 #define AVRCP_EVENT_LAST		AVRCP_EVENT_TRACK_REACHED_START
 
+struct avrcp_browsing_header {
+	uint8_t pdu_id;
+	uint16_t param_len;
+} __attribute__ ((packed));
 struct avrcp_player_cb {
 	int (*get_setting) (uint8_t attr, void *user_data);
 	int (*set_setting) (uint8_t attr, uint8_t value, void *user_data);
-- 
1.7.5.4

- Vani Patel
