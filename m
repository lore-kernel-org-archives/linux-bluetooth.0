Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v5 4/5] bnep: Refactored bnep connect and disconnect calls
Date: Thu, 19 Dec 2013 10:48:52 +0200
Message-Id: <1387442933-20681-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387442933-20681-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387442933-20681-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refactored bnep connect and disconnect calls to simplify and
keeping bnep related functionality behind curtains.
Provided bnep struct globally. bnep_connect calls takes
care of bnep_setup until interface up then connect callback
will be called. Provided bnep_set_watchdog. When interface is
up then only set watchdog. bnep_disconnect should be called
only when iface is up/connected.
---
 android/pan.c                 | 50 ++++++++++++------------
 profiles/network/bnep.c       | 91 +++++++++++++++++++++++++++----------------
 profiles/network/bnep.h       |  8 ++--
 profiles/network/connection.c | 42 +++++++++++++-------
 4 files changed, 114 insertions(+), 77 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 187953b..2537114 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -55,6 +55,7 @@ struct pan_device {
 	uint8_t		role;
 	GIOChannel	*io;
 	guint		watch;
+	struct bnep	*bnep_conn;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -67,6 +68,8 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
 
 static void pan_device_free(struct pan_device *dev)
 {
+	DBG("");
+
 	if (dev->watch > 0) {
 		g_source_remove(dev->watch);
 		dev->watch = 0;
@@ -77,6 +80,7 @@ static void pan_device_free(struct pan_device *dev)
 		dev->io = NULL;
 	}
 
+	bnep_free(dev->bnep_conn);
 	devices = g_slist_remove(devices, dev);
 	g_free(dev);
 
@@ -92,7 +96,6 @@ static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
 	if (dev->conn_state == state)
 		return;
 
-	dev->conn_state = state;
 	ba2str(&dev->dst, addr);
 	DBG("device %s state %u", addr, state);
 
@@ -104,8 +107,16 @@ static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
 
 	ipc_send_notif(HAL_SERVICE_ID_PAN, HAL_EV_PAN_CONN_STATE, sizeof(ev),
 									&ev);
-	if (dev->conn_state == HAL_PAN_STATE_DISCONNECTED)
-		pan_device_free(dev);
+
+	if (dev->conn_state == HAL_PAN_STATE_CONNECTED)
+		bnep_disconnect(dev->bnep_conn);
+
+	dev->conn_state = state;
+
+	if (state != HAL_PAN_STATE_DISCONNECTED)
+		return;
+
+	pan_device_free(dev);
 }
 
 static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
@@ -131,14 +142,12 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 
 	DBG("%s disconnected", dev->iface);
 
-	bnep_if_down(dev->iface);
-	bnep_conndel(&dev->dst);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 
 	return FALSE;
 }
 
-static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
+static void bnep_conn_cb(char *iface, int err, void *data)
 {
 	struct pan_device *dev = data;
 
@@ -146,28 +155,22 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 
 	if (err < 0) {
 		error("bnep connect req failed: %s", strerror(-err));
-		bnep_conndel(&dev->dst);
 		bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 		return;
 	}
 
-	memcpy(dev->iface, iface, sizeof(dev->iface));
-
-	DBG("%s connected", dev->iface);
+	DBG("%s connected", iface);
 
+	memcpy(dev->iface, iface, sizeof(dev->iface));
 	bt_pan_notify_ctrl_state(dev, HAL_PAN_CTRL_ENABLED);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_CONNECTED);
-
-	dev->watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							bnep_watchdog_cb, dev);
-	g_io_channel_unref(dev->io);
-	dev->io = NULL;
+	dev->watch = bnep_set_watchdog(dev->bnep_conn, bnep_watchdog_cb, dev);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct pan_device *dev = data;
-	uint16_t src, dst;
+	uint16_t l_role, r_role;
 	int perr, sk;
 
 	DBG("");
@@ -177,11 +180,13 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 		goto fail;
 	}
 
-	src = (local_role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
-	dst = (dev->role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
-	sk = g_io_channel_unix_get_fd(dev->io);
+	l_role = (local_role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP :
+								BNEP_SVC_PANU;
+	r_role = (dev->role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
 
-	perr = bnep_connect(sk, src, dst, bnep_conn_cb, dev);
+	sk = g_io_channel_unix_get_fd(dev->io);
+	dev->bnep_conn = bnep_new(sk, l_role, r_role);
+	perr = bnep_connect(dev->bnep_conn, bnep_conn_cb, dev);
 	if (perr < 0) {
 		error("bnep connect req failed: %s", strerror(-perr));
 		goto fail;
@@ -288,11 +293,6 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 	if (dev->io)
 		g_io_channel_shutdown(dev->io, TRUE, NULL);
 
-	if (dev->conn_state == HAL_PAN_STATE_CONNECTED) {
-		bnep_if_down(dev->iface);
-		bnep_conndel(&dst);
-	}
-
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTING);
 	status = HAL_STATUS_SUCCESS;
 
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index f3ed63b..b7c3835 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -39,6 +39,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
 #include <bluetooth/bnep.h>
+#include <btio/btio.h>
 
 #include <glib.h>
 
@@ -71,25 +72,15 @@ struct bnep {
 	GIOChannel	*io;
 	uint16_t	src;
 	uint16_t	dst;
+	bdaddr_t	dst_addr;
+	char	iface[16];
 	guint	attempts;
 	guint	setup_to;
 	void	*data;
 	bnep_connect_cb	conn_cb;
+	guint watch;
 };
 
-static void free_bnep_connect(struct bnep *b)
-{
-	if (!b)
-		return;
-
-	if (b->io) {
-		g_io_channel_unref(b->io);
-		b->io = NULL;
-	}
-
-	g_free(b);
-}
-
 uint16_t bnep_service_id(const char *svc)
 {
 	int i;
@@ -278,12 +269,11 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	struct bnep_control_rsp *rsp;
 	struct timeval timeo;
 	char pkt[BNEP_MTU];
-	char iface[16];
 	ssize_t r;
 	int sk;
 
 	if (cond & G_IO_NVAL)
-		goto failed;
+		return FALSE;
 
 	if (b->setup_to > 0) {
 		g_source_remove(b->setup_to);
@@ -335,24 +325,23 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
 
 	sk = g_io_channel_unix_get_fd(b->io);
-	if (bnep_connadd(sk, b->src, iface)) {
+	if (bnep_connadd(sk, b->src, b->iface)) {
 		error("bnep conn could not be added");
 		goto failed;
 	}
 
-	if (bnep_if_up(iface)) {
-		error("could not up %s", iface);
+	if (bnep_if_up(b->iface)) {
+		error("could not up %s", b->iface);
+		bnep_conndel(&b->dst_addr);
 		goto failed;
 	}
 
-	b->conn_cb(chan, iface, 0, b->data);
-	free_bnep_connect(b);
+	b->conn_cb(b->iface, 0, b->data);
 
 	return FALSE;
 
 failed:
-	b->conn_cb(NULL, NULL, -EIO, b->data);
-	free_bnep_connect(b);
+	b->conn_cb(NULL, -EIO, b->data);
 
 	return FALSE;
 }
@@ -396,40 +385,76 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 			return TRUE;
 	}
 
-	b->conn_cb(NULL, NULL, -ETIMEDOUT, b->data);
-	free_bnep_connect(b);
+	b->conn_cb(NULL, -ETIMEDOUT, b->data);
 
 	return FALSE;
 }
 
-int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
-								void *data)
+int bnep_connect(struct bnep *b, bnep_connect_cb conn_cb, void *data)
 {
-	struct bnep *b;
+	GError *gerr = NULL;
 	int err;
 
-	if (!conn_cb)
+	if (!b || !conn_cb)
 		return -EINVAL;
 
-	b = g_new0(struct bnep, 1);
-	b->io = g_io_channel_unix_new(sk);
 	b->attempts = 0;
-	b->src = src;
-	b->dst = dst;
 	b->conn_cb = conn_cb;
 	b->data = data;
 
+	bt_io_get(b->io, &gerr, BT_IO_OPT_DEST_BDADDR, &b->dst_addr,
+							BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		return -EINVAL;
+	}
+
 	err = bnep_setup_conn_req(b);
 	if (err < 0)
 		return err;
 
 	b->setup_to = g_timeout_add_seconds(CON_SETUP_TO,
 							bnep_conn_req_to, b);
-	g_io_add_watch(b->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+	b->watch = g_io_add_watch(b->io,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 							bnep_setup_cb, b);
 	return 0;
 }
 
+void bnep_disconnect(struct bnep *b)
+{
+	if (!b)
+		return;
+
+	if (b->io) {
+		g_io_channel_unref(b->io);
+		b->io = NULL;
+	}
+
+	if (b->watch) {
+		g_source_remove(b->watch);
+		b->watch = 0;
+	}
+
+	bnep_if_down(b->iface);
+	bnep_conndel(&b->dst_addr);
+}
+
+guint bnep_set_watchdog(struct bnep *b, GIOFunc watchdog, void *data)
+{
+	guint ret = 0;
+
+	if (!b)
+		return ret;
+
+	if (b->io)
+		ret = g_io_add_watch(b->io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+								watchdog, data);
+
+	return ret;
+}
+
 int bnep_add_to_bridge(const char *devname, const char *bridge)
 {
 	int ifindex;
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 091a7f2..46199df 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -39,10 +39,10 @@ int bnep_if_down(const char *devname);
 int bnep_add_to_bridge(const char *devname, const char *bridge);
 int bnep_del_from_bridge(const char *devname, const char *bridge);
 
-typedef void (*bnep_connect_cb) (GIOChannel *chan, char *iface, int err,
-								void *data);
-int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
-								void *data);
+typedef void (*bnep_connect_cb) (char *iface, int err, void *data);
+int bnep_connect(struct bnep *b, bnep_connect_cb conn_cb, void *data);
+guint bnep_set_watchdog(struct bnep *b, GIOFunc watchdog, void *data);
+void bnep_disconnect(struct bnep *b);
 
 ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
 uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role);
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index fb3e1ce..f1a44e9 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -72,6 +72,8 @@ struct network_conn {
 	guint		dc_id;
 	struct network_peer *peer;
 	DBusMessage	*connect;
+	struct bnep	*bnep_conn;
+	guint		watch;
 };
 
 static GSList *peers = NULL;
@@ -126,11 +128,19 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 
 	info("%s disconnected", nc->dev);
 
-	bnep_if_down(nc->dev);
 	nc->state = DISCONNECTED;
 	memset(nc->dev, 0, sizeof(nc->dev));
 	strcpy(nc->dev, "bnep%d");
 
+	bnep_free(nc->bnep_conn);
+	nc->bnep_conn = NULL;
+
+	if (nc->io) {
+		g_io_channel_shutdown(nc->io, TRUE, NULL);
+		g_io_channel_unref(nc->io);
+		nc->io = NULL;
+	}
+
 	return FALSE;
 }
 
@@ -158,9 +168,17 @@ static void cancel_connection(struct network_conn *nc, int err)
 	if (nc->connect)
 		local_connect_cb(nc, err);
 
-	g_io_channel_shutdown(nc->io, TRUE, NULL);
-	g_io_channel_unref(nc->io);
-	nc->io = NULL;
+	if (nc->io) {
+		g_io_channel_shutdown(nc->io, TRUE, NULL);
+		g_io_channel_unref(nc->io);
+		nc->io = NULL;
+	}
+
+	if (nc->state == CONNECTED)
+		bnep_disconnect(nc->bnep_conn);
+
+	bnep_free(nc->bnep_conn);
+	nc->bnep_conn = NULL;
 
 	nc->state = DISCONNECTED;
 }
@@ -169,11 +187,7 @@ static void connection_destroy(DBusConnection *conn, void *user_data)
 {
 	struct network_conn *nc = user_data;
 
-	if (nc->state == CONNECTED) {
-		bnep_if_down(nc->dev);
-		bnep_conndel(device_get_address(nc->peer->device));
-	} else if (nc->io)
-		cancel_connection(nc, -EIO);
+	cancel_connection(nc, -EIO);
 }
 
 static void disconnect_cb(struct btd_device *device, gboolean removal,
@@ -186,7 +200,7 @@ static void disconnect_cb(struct btd_device *device, gboolean removal,
 	connection_destroy(NULL, user_data);
 }
 
-static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
+static void bnep_conn_cb(char *iface, int err, void *data)
 {
 	struct network_conn *nc = data;
 	const char *path;
@@ -220,10 +234,7 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 	nc->state = CONNECTED;
 	nc->dc_id = device_add_disconnect_watch(nc->peer->device, disconnect_cb,
 								nc, NULL);
-	g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							bnep_watchdog_cb, nc);
-	g_io_channel_unref(nc->io);
-	nc->io = NULL;
+	nc->watch = bnep_set_watchdog(nc->bnep_conn, bnep_watchdog_cb, nc);
 
 	return;
 
@@ -242,7 +253,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	}
 
 	sk = g_io_channel_unix_get_fd(nc->io);
-	perr = bnep_connect(sk, BNEP_SVC_PANU, nc->id, bnep_conn_cb, nc);
+	nc->bnep_conn = bnep_new(sk, BNEP_SVC_PANU, nc->id);
+	perr = bnep_connect(nc->bnep_conn, bnep_conn_cb, nc);
 	if (perr < 0) {
 		error("bnep connect(): %s (%d)", strerror(-perr), -perr);
 		goto failed;
-- 
1.8.3.2

