Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 2/7] profiles/network: Refactor bnep connection setup functionality
Date: Fri, 29 Nov 2013 11:54:01 +0200
Message-Id: <1385718846-19070-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385718846-19070-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385718846-19070-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moving bnep connection setup related functionality to common.c.
Provided bnep_connect call with bnep_connect_cb for status and
bnep interface name. It will be simple if someone want to utilize
this call otherwise they have to reimplement similar functionality
with minimal changes (e.g. android/pan).
---
 profiles/network/common.c     | 178 ++++++++++++++++++++++++++++++++++++++++++
 profiles/network/common.h     |   5 ++
 profiles/network/connection.c | 167 +++------------------------------------
 3 files changed, 194 insertions(+), 156 deletions(-)

diff --git a/profiles/network/common.c b/profiles/network/common.c
index c2da925..fd25d96 100644
--- a/profiles/network/common.c
+++ b/profiles/network/common.c
@@ -46,6 +46,9 @@
 #include "common.h"
 #include "lib/uuid.h"
 
+#define CON_SETUP_RETRIES      3
+#define CON_SETUP_TO           9
+
 static int ctl;
 
 static struct {
@@ -59,6 +62,21 @@ static struct {
 	{ NULL }
 };
 
+struct __service_16 {
+	uint16_t dst;
+	uint16_t src;
+} __attribute__ ((packed));
+
+struct bnep_conn {
+	GIOChannel	*io;
+	uint16_t	src;
+	uint16_t	dst;
+	guint	attempts;
+	guint	setup_to;
+	void	*data;
+	bnep_connect_cb	conn_cb;
+};
+
 uint16_t bnep_service_id(const char *svc)
 {
 	int i;
@@ -215,6 +233,166 @@ int bnep_if_down(const char *devname)
 	return 0;
 }
 
+static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct bnep_conn *bc = data;
+	struct bnep_control_rsp *rsp;
+	struct timeval timeo;
+	char pkt[BNEP_MTU];
+	char iface[16];
+	ssize_t r;
+	int sk;
+
+	if (cond & G_IO_NVAL)
+		goto failed;
+
+	if (bc->setup_to > 0) {
+		g_source_remove(bc->setup_to);
+		bc->setup_to = 0;
+	}
+
+	if (cond & (G_IO_HUP | G_IO_ERR)) {
+		error("Hangup or error on l2cap server socket");
+		goto failed;
+	}
+
+	sk = g_io_channel_unix_get_fd(chan);
+	memset(pkt, 0, BNEP_MTU);
+	r = read(sk, pkt, sizeof(pkt) - 1);
+	if (r < 0) {
+		error("IO Channel read error");
+		goto failed;
+	}
+
+	if (r == 0) {
+		error("No packet received on l2cap socket");
+		goto failed;
+	}
+
+	errno = EPROTO;
+
+	if ((size_t) r < sizeof(*rsp)) {
+		error("Packet received is not bnep type");
+		goto failed;
+	}
+
+	rsp = (void *) pkt;
+	if (rsp->type != BNEP_CONTROL) {
+		error("Packet received is not bnep type");
+		goto failed;
+	}
+
+	if (rsp->ctrl != BNEP_SETUP_CONN_RSP)
+		return TRUE;
+
+	r = ntohs(rsp->resp);
+	if (r != BNEP_SUCCESS) {
+		error("bnep failed");
+		goto failed;
+	}
+
+	memset(&timeo, 0, sizeof(timeo));
+	timeo.tv_sec = 0;
+	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
+
+	sk = g_io_channel_unix_get_fd(bc->io);
+	if (bnep_connadd(sk, bc->src, iface)) {
+		error("bnep conn could not be added");
+		goto failed;
+	}
+
+	if (bnep_if_up(iface)) {
+		error("could not up %s", iface);
+		goto failed;
+	}
+
+	bc->conn_cb(chan, iface, 0, bc->data);
+	g_free(bc);
+
+	return FALSE;
+
+failed:
+	bc->conn_cb(NULL, NULL, -EIO, bc->data);
+	g_free(bc);
+
+	return FALSE;
+}
+
+
+static int bnep_setup_conn_req(struct bnep_conn *bc)
+{
+	struct bnep_setup_conn_req *req;
+	struct __service_16 *s;
+	unsigned char pkt[BNEP_MTU];
+	int fd;
+
+	/* Send request */
+	req = (void *) pkt;
+	req->type = BNEP_CONTROL;
+	req->ctrl = BNEP_SETUP_CONN_REQ;
+	req->uuid_size = 2;     /* 16bit UUID */
+	s = (void *) req->service;
+	s->src = htons(bc->src);
+	s->dst = htons(bc->dst);
+
+	fd = g_io_channel_unix_get_fd(bc->io);
+	if (write(fd, pkt, sizeof(*req) + sizeof(*s)) < 0) {
+		error("bnep connection req send failed: %s", strerror(errno));
+		return -errno;
+	}
+
+	bc->attempts++;
+
+	return 0;
+}
+
+static gboolean bnep_conn_req_to(gpointer user_data)
+{
+	struct bnep_conn *bc = user_data;
+
+	if (bc->attempts == CON_SETUP_RETRIES) {
+		error("Too many bnep connection attempts");
+	} else {
+		error("bnep connection setup TO, retrying...");
+		if (bnep_setup_conn_req(bc) == 0)
+			return TRUE;
+	}
+
+	bc->conn_cb(NULL, NULL, -ETIMEDOUT, bc->data);
+	g_free(bc);
+
+	return FALSE;
+}
+
+int bnep_connect(GIOChannel *io, uint16_t src, uint16_t dst,
+					bnep_connect_cb conn_cb, void *data)
+{
+	struct bnep_conn *bc;
+	int err;
+
+	if (!io || !conn_cb)
+		return -EINVAL;
+
+	bc = g_new0(struct bnep_conn, 1);
+	bc->io = io;
+	bc->attempts = 0;
+	bc->src = src;
+	bc->dst = dst;
+	bc->conn_cb = conn_cb;
+	bc->data = data;
+
+	err = bnep_setup_conn_req(bc);
+	if (err < 0)
+		return err;
+
+	bc->setup_to = g_timeout_add_seconds(CON_SETUP_TO,
+							bnep_conn_req_to, bc);
+	g_io_add_watch(bc->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							bnep_setup_cb, bc);
+	return 0;
+}
+
 int bnep_add_to_bridge(const char *devname, const char *bridge)
 {
 	int ifindex;
diff --git a/profiles/network/common.h b/profiles/network/common.h
index 9a8caac..11db828 100644
--- a/profiles/network/common.h
+++ b/profiles/network/common.h
@@ -35,3 +35,8 @@ int bnep_if_up(const char *devname);
 int bnep_if_down(const char *devname);
 int bnep_add_to_bridge(const char *devname, const char *bridge);
 int bnep_del_from_bridge(const char *devname, const char *bridge);
+
+typedef void (*bnep_connect_cb) (GIOChannel *chan, char *iface, int err,
+								void *data);
+int bnep_connect(GIOChannel *io, uint16_t src, uint16_t dst,
+					bnep_connect_cb conn_cb, void *data);
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 301f66d..5723afd 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -51,8 +51,6 @@
 #include "connection.h"
 
 #define NETWORK_PEER_INTERFACE "org.bluez.Network1"
-#define CON_SETUP_RETRIES      3
-#define CON_SETUP_TO           9
 
 typedef enum {
 	CONNECTED,
@@ -73,16 +71,9 @@ struct network_conn {
 	GIOChannel	*io;
 	guint		dc_id;
 	struct network_peer *peer;
-	guint		attempt_cnt;
-	guint		timeout_source;
 	DBusMessage	*connect;
 };
 
-struct __service_16 {
-	uint16_t dst;
-	uint16_t src;
-} __attribute__ ((packed));
-
 static GSList *peers = NULL;
 
 static uint16_t get_service_id(struct btd_service *service)
@@ -163,11 +154,6 @@ static void local_connect_cb(struct network_conn *nc, int err)
 
 static void cancel_connection(struct network_conn *nc, int err)
 {
-	if (nc->timeout_source > 0) {
-		g_source_remove(nc->timeout_source);
-		nc->timeout_source = 0;
-	}
-
 	btd_service_connecting_complete(nc->service, err);
 	if (nc->connect)
 		local_connect_cb(nc, err);
@@ -200,83 +186,24 @@ static void disconnect_cb(struct btd_device *device, gboolean removal,
 	connection_destroy(NULL, user_data);
 }
 
-static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
-							gpointer data)
+static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 {
 	struct network_conn *nc = data;
-	struct bnep_control_rsp *rsp;
-	struct timeval timeo;
-	char pkt[BNEP_MTU];
-	ssize_t r;
-	int sk;
 	const char *path;
 	DBusConnection *conn;
 
-	DBG("cond %u", cond);
-
-	if (cond & G_IO_NVAL)
-		return FALSE;
-
-	if (nc->timeout_source > 0) {
-		g_source_remove(nc->timeout_source);
-		nc->timeout_source = 0;
-	}
-
-	if (cond & (G_IO_HUP | G_IO_ERR)) {
-		error("Hangup or error on l2cap server socket");
-		goto failed;
-	}
-
-	sk = g_io_channel_unix_get_fd(chan);
-
-	memset(pkt, 0, BNEP_MTU);
-	r = read(sk, pkt, sizeof(pkt) -1);
-	if (r < 0) {
-		error("IO Channel read error");
-		goto failed;
-	}
-
-	if (r == 0) {
-		error("No packet received on l2cap socket");
-		goto failed;
-	}
-
-	errno = EPROTO;
-
-	if ((size_t) r < sizeof(*rsp)) {
-		error("Packet received is not bnep type");
-		goto failed;
-	}
-
-	rsp = (void *) pkt;
-	if (rsp->type != BNEP_CONTROL) {
-		error("Packet received is not bnep type");
-		goto failed;
-	}
-
-	if (rsp->ctrl != BNEP_SETUP_CONN_RSP)
-		return TRUE;
-
-	r = ntohs(rsp->resp);
-
-	if (r != BNEP_SUCCESS) {
-		error("bnep failed");
-		goto failed;
-	}
-
-	memset(&timeo, 0, sizeof(timeo));
-	timeo.tv_sec = 0;
-
-	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
+	DBG("");
 
-	if (bnep_connadd(sk, BNEP_SVC_PANU, nc->dev)) {
-		error("%s could not be added", nc->dev);
+	if (err < 0) {
+		error("connect failed %s", strerror(-err));
 		goto failed;
 	}
 
-	bnep_if_up(nc->dev);
+	info("%s connected", nc->dev);
 
+	memcpy(nc->dev, iface, sizeof(nc->dev));
 	btd_service_connecting_complete(nc->service, 0);
+
 	if (nc->connect)
 		local_connect_cb(nc, 0);
 
@@ -292,88 +219,16 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 
 	nc->state = CONNECTED;
 	nc->dc_id = device_add_disconnect_watch(nc->peer->device, disconnect_cb,
-						nc, NULL);
-
-	info("%s connected", nc->dev);
-	/* Start watchdog */
+								nc, NULL);
 	g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-			(GIOFunc) bnep_watchdog_cb, nc);
+							bnep_watchdog_cb, nc);
 	g_io_channel_unref(nc->io);
 	nc->io = NULL;
 
-	return FALSE;
+	return;
 
 failed:
 	cancel_connection(nc, -EIO);
-
-	return FALSE;
-}
-
-static int bnep_send_conn_req(struct network_conn *nc)
-{
-	struct bnep_setup_conn_req *req;
-	struct __service_16 *s;
-	unsigned char pkt[BNEP_MTU];
-	int fd;
-
-	DBG("");
-
-	/* Send request */
-	req = (void *) pkt;
-	req->type = BNEP_CONTROL;
-	req->ctrl = BNEP_SETUP_CONN_REQ;
-	req->uuid_size = 2;	/* 16bit UUID */
-	s = (void *) req->service;
-	s->dst = htons(nc->id);
-	s->src = htons(BNEP_SVC_PANU);
-
-	fd = g_io_channel_unix_get_fd(nc->io);
-	if (write(fd, pkt, sizeof(*req) + sizeof(*s)) < 0) {
-		int err = -errno;
-		error("bnep connection req send failed: %s", strerror(errno));
-		return err;
-	}
-
-	nc->attempt_cnt++;
-
-	return 0;
-}
-
-static gboolean bnep_conn_req_to(gpointer user_data)
-{
-	struct network_conn *nc;
-
-	nc = user_data;
-	if (nc->attempt_cnt == CON_SETUP_RETRIES) {
-		error("Too many bnep connection attempts");
-	} else {
-		error("bnep connection setup TO, retrying...");
-		if (bnep_send_conn_req(nc) == 0)
-			return TRUE;
-	}
-
-	cancel_connection(nc, -ETIMEDOUT);
-
-	return FALSE;
-}
-
-static int bnep_connect(struct network_conn *nc)
-{
-	int err;
-
-	nc->attempt_cnt = 0;
-
-	err = bnep_send_conn_req(nc);
-	if (err < 0)
-		return err;
-
-	nc->timeout_source = g_timeout_add_seconds(CON_SETUP_TO,
-							bnep_conn_req_to, nc);
-
-	g_io_add_watch(nc->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							bnep_setup_cb, nc);
-
-	return 0;
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
@@ -386,7 +241,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 		goto failed;
 	}
 
-	perr = bnep_connect(nc);
+	perr = bnep_connect(nc->io, BNEP_SVC_PANU, nc->id, bnep_conn_cb, nc);
 	if (perr < 0) {
 		error("bnep connect(): %s (%d)", strerror(-perr), -perr);
 		goto failed;
-- 
1.8.3.2

