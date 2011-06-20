Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Nami <nami.li@atheros.com>
Subject: [PATCH obexd 12/14] Start L2CAP connnection.
Date: Mon, 20 Jun 2011 17:56:31 +0800
Message-ID: <1308563794-18964-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/session.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/session.h |    3 ++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index 0e21994..8119801 100755
--- a/client/session.c
+++ b/client/session.c
@@ -39,6 +39,7 @@
 #include <bluetooth/rfcomm.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/l2cap.h>

 #include "log.h"
 #include "pbap.h"
@@ -284,11 +285,66 @@ static GIOChannel *rfcomm_connect(const bdaddr_t *src, const bdaddr_t *dst,
 }
 static void l2cap_callback(GIOChannel *io, GError *err, gpointer user_data)
 {
+	struct callback_data *callback = user_data;
+	struct session_data *session = callback->session;
+	GwObex *obex;
+	int fd;
+
+	DBG("");
+
+	if (err != NULL) {
+		error("%s", err->message);
+		goto done;
+	}
+
+	/* do not close when gw_obex is using the fd */
+	g_io_channel_set_close_on_unref(session->io, FALSE);
+	g_io_channel_unref(session->io);
+	session->io = NULL;
+
+	fd = g_io_channel_unix_get_fd(io);
+
+
+	obex = gw_obex_setup_fd(fd, session->target,
+			session->target_len, NULL, NULL);
+
+	session->obex = obex;
+
+	sessions = g_slist_prepend(sessions, session);
+
+done:
+	callback->func(callback->session, err, callback->data);
+
+	session_unref(callback->session);
+
+	g_free(callback);
 }
+
+
+
+
 static GIOChannel *l2cap_connect(const bdaddr_t *src, const bdaddr_t *dst,
 					uint16_t psm, BtIOConnect function,
 					gpointer user_data)
 {
+	GIOChannel *io;
+	GError *err = NULL;
+	DBG("");
+
+	io = bt_io_connect(BT_IO_L2CAP, function, user_data, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_DEST_BDADDR, dst,
+				BT_IO_OPT_PSM, psm,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_MTU, DEFAULT_MTU,
+				BT_IO_OPT_MODE, L2CAP_MODE_ERTM,
+				BT_IO_OPT_INVALID);
+	if (io != NULL)
+		return io;
+
+	error("%s", err->message);
+	g_error_free(err);
+	return NULL;
 }

 static void search_callback(uint8_t type, uint16_t status,
diff --git a/client/session.h b/client/session.h
index 24b1ec5..0be97c7 100755
--- a/client/session.h
+++ b/client/session.h
@@ -58,6 +58,9 @@ struct session_data {
 #define SDP_ATTR_GOEP_L2CAP_PSM		0x0200
 #endif

+/* Default MTU's */
+#define DEFAULT_MTU 32767
+
 typedef void (*session_callback_t) (struct session_data *session,
 					GError *err, void *user_data);

--
1.7.1

