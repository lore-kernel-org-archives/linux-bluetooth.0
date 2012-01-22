Return-Path: <cyrus@holtmann.org>
From: ilia.kolominsky@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Ilia Kolomisnky <iliak@ti.com>
Subject: [PATCH] BlueZ: Added retries for BNEP connection setup.
Date: Sun, 22 Jan 2012 09:10:33 +0200
Message-Id: <1327216233-17629-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ilia Kolomisnky <iliak@ti.com>

According to BNEP spec. section 2.6.3 and
in order to pass TP/BNEP/CTRL/BV-02-C certification test.

Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
---
 network/connection.c |   53 ++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/network/connection.c b/network/connection.c
index ca1f4b2..5c3819a 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -49,6 +49,8 @@
 #include "connection.h"
 
 #define NETWORK_PEER_INTERFACE "org.bluez.Network"
+#define CON_SETUP_RETRIES      3
+#define CON_SETUP_TO_MS        9000
 
 typedef enum {
 	CONNECTED,
@@ -73,6 +75,8 @@ struct network_conn {
 	guint		watch;		/* Disconnect watch */
 	guint		dc_id;
 	struct network_peer *peer;
+	char		con_attempt;
+	guint 		con_to_src;
 };
 
 struct __service_16 {
@@ -218,6 +222,8 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 	}
 
+	g_source_remove(nc->con_to_src);
+
 	errno = EPROTO;
 
 	if ((size_t) r < sizeof(*rsp)) {
@@ -289,13 +295,11 @@ failed:
 	return FALSE;
 }
 
-static int bnep_connect(struct network_conn *nc)
-{
+static inline int bnep_send_conn_req(struct network_conn *nc) {
+
 	struct bnep_setup_conn_req *req;
 	struct __service_16 *s;
-	struct timeval timeo;
 	unsigned char pkt[BNEP_MTU];
-	int fd;
 
 	/* Send request */
 	req = (void *) pkt;
@@ -306,14 +310,43 @@ static int bnep_connect(struct network_conn *nc)
 	s->dst = htons(nc->id);
 	s->src = htons(BNEP_SVC_PANU);
 
-	memset(&timeo, 0, sizeof(timeo));
-	timeo.tv_sec = 30;
+	if (send(g_io_channel_unix_get_fd(nc->io), pkt, sizeof(*req) + sizeof(*s), 0) < 0) {
+		error("bnep connection setup send failed");
+		return -errno;
+	}
 
-	fd = g_io_channel_unix_get_fd(nc->io);
-	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
+	nc->con_attempt++;
 
-	if (send(fd, pkt, sizeof(*req) + sizeof(*s), 0) < 0)
-		return -errno;
+	return 0;
+}
+
+static gboolean bnep_conn_req_to(gpointer user_data)
+{
+	struct network_conn *nc;
+	int err;
+
+	nc = (struct network_conn *) user_data;
+	if (nc->con_attempt == CON_SETUP_RETRIES) {
+		error("Too many bnep connection attempts, aborting connection setup");
+	}
+	else {
+		error("bnep connection setup TO, retrying...");
+
+		if (!bnep_send_conn_req(nc))
+			return TRUE;
+	}
+
+	cancel_connection(nc, "bnep setup failed");
+	return FALSE;
+}
+
+static int bnep_connect(struct network_conn *nc)
+{
+	int err;
+
+	if (err = bnep_send_conn_req(nc))
+		return err;
+	nc->con_to_src = g_timeout_add(CON_SETUP_TO_MS, bnep_conn_req_to, nc);
 
 	g_io_add_watch(nc->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 			(GIOFunc) bnep_setup_cb, nc);
-- 
1.7.4.1

