Return-Path: <cyrus@holtmann.org>
From: ilia.kolominsky@gmail.com
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Cc: Ilia Kolomisnky <iliak@ti.com>
Subject: [PATCH Bluez v2] Add retries for BNEP connection setup.
Date: Sun,  5 Feb 2012 16:58:58 +0200
Message-Id: <1328453938-18458-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ilia Kolomisnky <iliak@ti.com>

According to BNEP spec. v1.0, section 2.6.3, the
BNEP_SETUP_CONNECTION_REQUEST_MSG should be retransmited if the
response is not recieved for a period between 1 to 30 sec.
Current implementation uses SO_RCVTIMEO socket option to sense
reply time-out, which is incorrect because it does not have effect
on g_io_add_watch monitored descriptors. This patch allows
passing of TP/BNEP/CTRL/BV-02-C certification test.
---
 network/connection.c |   59 ++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/network/connection.c b/network/connection.c
index f864972..0a606d5 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -49,6 +49,8 @@
 #include "connection.h"
 
 #define NETWORK_PEER_INTERFACE "org.bluez.Network"
+#define CON_SETUP_RETRIES      3
+#define CON_SETUP_TO           9
 
 typedef enum {
 	CONNECTED,
@@ -73,6 +75,8 @@ struct network_conn {
 	guint		watch;		/* Disconnect watch */
 	guint		dc_id;
 	struct network_peer *peer;
+	guint		attempt_cnt;
+	guint 		timeout_source;
 };
 
 struct __service_16 {
@@ -146,6 +150,11 @@ static void cancel_connection(struct network_conn *nc, const char *err_msg)
 {
 	DBusMessage *reply;
 
+	if (nc->timeout_source) {
+		g_source_remove(nc->timeout_source);
+		nc->timeout_source = 0;
+	}
+
 	if (nc->watch) {
 		g_dbus_remove_watch(connection, nc->watch);
 		nc->watch = 0;
@@ -199,6 +208,9 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	if (cond & G_IO_NVAL)
 		return FALSE;
 
+	g_source_remove(nc->timeout_source);
+	nc->timeout_source = 0;
+
 	if (cond & (G_IO_HUP | G_IO_ERR)) {
 		error("Hangup or error on l2cap server socket");
 		goto failed;
@@ -289,11 +301,10 @@ failed:
 	return FALSE;
 }
 
-static int bnep_connect(struct network_conn *nc)
+static int bnep_send_conn_req(struct network_conn *nc)
 {
 	struct bnep_setup_conn_req *req;
 	struct __service_16 *s;
-	struct timeval timeo;
 	unsigned char pkt[BNEP_MTU];
 	int fd;
 
@@ -306,18 +317,48 @@ static int bnep_connect(struct network_conn *nc)
 	s->dst = htons(nc->id);
 	s->src = htons(BNEP_SVC_PANU);
 
-	memset(&timeo, 0, sizeof(timeo));
-	timeo.tv_sec = 30;
-
 	fd = g_io_channel_unix_get_fd(nc->io);
-	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
-
-	if (send(fd, pkt, sizeof(*req) + sizeof(*s), 0) < 0)
+	if (write(fd, pkt, sizeof(*req) + sizeof(*s)) < 0) {
+		error("bnep connection setup send failed");
 		return -errno;
+	}
+
+	nc->attempt_cnt++;
+
+	return 0;
+}
+
+static gboolean bnep_conn_req_to(gpointer user_data)
+{
+	struct network_conn *nc;
+
+	nc = user_data;
+	if (nc->attempt_cnt == CON_SETUP_RETRIES) {
+		error("Too many bnep connection attempts");
+	} else {
+		error("bnep connection setup TO, retrying...");
+		if (!bnep_send_conn_req(nc))
+			return TRUE;
+	}
+
+	cancel_connection(nc, "bnep setup failed");
+
+	return FALSE;
+}
+
+static int bnep_connect(struct network_conn *nc)
+{
+	int err;
+
+	nc->attempt_cnt = 0;
+	if ((err = bnep_send_conn_req(nc)))
+		return err;
+
+	nc->timeout_source = g_timeout_add_seconds(CON_SETUP_TO,
+		bnep_conn_req_to, nc);
 
 	g_io_add_watch(nc->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 			(GIOFunc) bnep_setup_cb, nc);
-
 	return 0;
 }
 
-- 
1.7.4.1

