Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v5 2/5] bnep: Rename struct bnep_conn to struct bnep for better readability
Date: Thu, 19 Dec 2013 10:48:50 +0200
Message-Id: <1387442933-20681-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387442933-20681-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387442933-20681-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/network/bnep.c | 80 ++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 08037e6..02e2647 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -67,7 +67,7 @@ struct __service_16 {
 	uint16_t src;
 } __attribute__ ((packed));
 
-struct bnep_conn {
+struct bnep {
 	GIOChannel	*io;
 	uint16_t	src;
 	uint16_t	dst;
@@ -77,17 +77,17 @@ struct bnep_conn {
 	bnep_connect_cb	conn_cb;
 };
 
-static void free_bnep_connect(struct bnep_conn *bc)
+static void free_bnep_connect(struct bnep *b)
 {
-	if (!bc)
+	if (!b)
 		return;
 
-	if (bc->io) {
-		g_io_channel_unref(bc->io);
-		bc->io = NULL;
+	if (b->io) {
+		g_io_channel_unref(b->io);
+		b->io = NULL;
 	}
 
-	g_free(bc);
+	g_free(b);
 }
 
 uint16_t bnep_service_id(const char *svc)
@@ -249,7 +249,7 @@ int bnep_if_down(const char *devname)
 static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
-	struct bnep_conn *bc = data;
+	struct bnep *b = data;
 	struct bnep_control_rsp *rsp;
 	struct timeval timeo;
 	char pkt[BNEP_MTU];
@@ -260,9 +260,9 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	if (cond & G_IO_NVAL)
 		goto failed;
 
-	if (bc->setup_to > 0) {
-		g_source_remove(bc->setup_to);
-		bc->setup_to = 0;
+	if (b->setup_to > 0) {
+		g_source_remove(b->setup_to);
+		b->setup_to = 0;
 	}
 
 	if (cond & (G_IO_HUP | G_IO_ERR)) {
@@ -309,8 +309,8 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	timeo.tv_sec = 0;
 	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
 
-	sk = g_io_channel_unix_get_fd(bc->io);
-	if (bnep_connadd(sk, bc->src, iface)) {
+	sk = g_io_channel_unix_get_fd(b->io);
+	if (bnep_connadd(sk, b->src, iface)) {
 		error("bnep conn could not be added");
 		goto failed;
 	}
@@ -320,19 +320,19 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 	}
 
-	bc->conn_cb(chan, iface, 0, bc->data);
-	free_bnep_connect(bc);
+	b->conn_cb(chan, iface, 0, b->data);
+	free_bnep_connect(b);
 
 	return FALSE;
 
 failed:
-	bc->conn_cb(NULL, NULL, -EIO, bc->data);
-	free_bnep_connect(bc);
+	b->conn_cb(NULL, NULL, -EIO, b->data);
+	free_bnep_connect(b);
 
 	return FALSE;
 }
 
-static int bnep_setup_conn_req(struct bnep_conn *bc)
+static int bnep_setup_conn_req(struct bnep *b)
 {
 	struct bnep_setup_conn_req *req;
 	struct __service_16 *s;
@@ -345,34 +345,34 @@ static int bnep_setup_conn_req(struct bnep_conn *bc)
 	req->ctrl = BNEP_SETUP_CONN_REQ;
 	req->uuid_size = 2;     /* 16bit UUID */
 	s = (void *) req->service;
-	s->src = htons(bc->src);
-	s->dst = htons(bc->dst);
+	s->src = htons(b->src);
+	s->dst = htons(b->dst);
 
-	fd = g_io_channel_unix_get_fd(bc->io);
+	fd = g_io_channel_unix_get_fd(b->io);
 	if (write(fd, pkt, sizeof(*req) + sizeof(*s)) < 0) {
 		error("bnep connection req send failed: %s", strerror(errno));
 		return -errno;
 	}
 
-	bc->attempts++;
+	b->attempts++;
 
 	return 0;
 }
 
 static gboolean bnep_conn_req_to(gpointer user_data)
 {
-	struct bnep_conn *bc = user_data;
+	struct bnep *b = user_data;
 
-	if (bc->attempts == CON_SETUP_RETRIES) {
+	if (b->attempts == CON_SETUP_RETRIES) {
 		error("Too many bnep connection attempts");
 	} else {
 		error("bnep connection setup TO, retrying...");
-		if (bnep_setup_conn_req(bc) == 0)
+		if (bnep_setup_conn_req(b) == 0)
 			return TRUE;
 	}
 
-	bc->conn_cb(NULL, NULL, -ETIMEDOUT, bc->data);
-	free_bnep_connect(bc);
+	b->conn_cb(NULL, NULL, -ETIMEDOUT, b->data);
+	free_bnep_connect(b);
 
 	return FALSE;
 }
@@ -380,28 +380,28 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
 								void *data)
 {
-	struct bnep_conn *bc;
+	struct bnep *b;
 	int err;
 
 	if (!conn_cb)
 		return -EINVAL;
 
-	bc = g_new0(struct bnep_conn, 1);
-	bc->io = g_io_channel_unix_new(sk);
-	bc->attempts = 0;
-	bc->src = src;
-	bc->dst = dst;
-	bc->conn_cb = conn_cb;
-	bc->data = data;
+	b = g_new0(struct bnep, 1);
+	b->io = g_io_channel_unix_new(sk);
+	b->attempts = 0;
+	b->src = src;
+	b->dst = dst;
+	b->conn_cb = conn_cb;
+	b->data = data;
 
-	err = bnep_setup_conn_req(bc);
+	err = bnep_setup_conn_req(b);
 	if (err < 0)
 		return err;
 
-	bc->setup_to = g_timeout_add_seconds(CON_SETUP_TO,
-							bnep_conn_req_to, bc);
-	g_io_add_watch(bc->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							bnep_setup_cb, bc);
+	b->setup_to = g_timeout_add_seconds(CON_SETUP_TO,
+							bnep_conn_req_to, b);
+	g_io_add_watch(b->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							bnep_setup_cb, b);
 	return 0;
 }
 
-- 
1.8.3.2

