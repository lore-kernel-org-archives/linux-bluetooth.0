Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v6 4/5] bnep: Refactored bnep connect and disconnect calls
Date: Thu, 19 Dec 2013 16:39:42 +0200
Message-Id: <1387463983-6373-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387463983-6373-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387463983-6373-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refactored bnep connect and disconnect calls to simplify and
keeping bnep related functionality behind curtains.
Provided bnep struct globally. bnep_connect calls takes
care of bnep_setup until interface up then connect callback
will be called. Provided bnep_set_disconnect. Set disconnect
when connect call succeeds. bnep_disconnect should be
called only when iface is up/connected.
---
 android/pan.c                 |  60 +++++++++++++-----------
 profiles/network/bnep.c       | 105 ++++++++++++++++++++++++++++--------------
 profiles/network/bnep.h       |   8 ++--
 profiles/network/connection.c |  60 ++++++++++++++++--------
 4 files changed, 152 insertions(+), 81 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 187953b..51a11dd 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -55,6 +55,7 @@ struct pan_device {
 	uint8_t		role;
 	GIOChannel	*io;
 	guint		watch;
+	struct bnep	*session;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -77,6 +78,7 @@ static void pan_device_free(struct pan_device *dev)
 		dev->io = NULL;
 	}
 
+	bnep_free(dev->session);
 	devices = g_slist_remove(devices, dev);
 	g_free(dev);
 
@@ -104,8 +106,10 @@ static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
 
 	ipc_send_notif(HAL_SERVICE_ID_PAN, HAL_EV_PAN_CONN_STATE, sizeof(ev),
 									&ev);
-	if (dev->conn_state == HAL_PAN_STATE_DISCONNECTED)
-		pan_device_free(dev);
+	if (state != HAL_PAN_STATE_DISCONNECTED)
+		return;
+
+	pan_device_free(dev);
 }
 
 static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
@@ -124,21 +128,27 @@ static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
 									&ev);
 }
 
-static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
-								gpointer data)
+static gboolean watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct pan_device *dev = data;
 
-	DBG("%s disconnected", dev->iface);
+	DBG("disconnected");
 
-	bnep_if_down(dev->iface);
-	bnep_conndel(&dev->dst);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 
 	return FALSE;
 }
 
-static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
+static void bnep_disconn_cb(void *data)
+{
+	struct pan_device *dev = data;
+
+	DBG("%s disconnected", dev->iface);
+
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+}
+
+static void bnep_conn_cb(char *iface, int err, void *data)
 {
 	struct pan_device *dev = data;
 
@@ -146,28 +156,21 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 
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
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct pan_device *dev = data;
-	uint16_t src, dst;
+	uint16_t l_role, r_role;
 	int perr, sk;
 
 	DBG("");
@@ -177,16 +180,23 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 		goto fail;
 	}
 
-	src = (local_role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
-	dst = (dev->role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
+	l_role = (local_role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP :
+								BNEP_SVC_PANU;
+	r_role = (dev->role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
 	sk = g_io_channel_unix_get_fd(dev->io);
-
-	perr = bnep_connect(sk, src, dst, bnep_conn_cb, dev);
+	dev->session = bnep_new(sk, l_role, r_role);
+	perr = bnep_connect(dev->session, bnep_conn_cb, dev);
 	if (perr < 0) {
 		error("bnep connect req failed: %s", strerror(-perr));
 		goto fail;
 	}
 
+	bnep_set_disconnect(dev->session, bnep_disconn_cb, dev);
+	dev->watch = g_io_add_watch(dev->io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+								watch_cb, dev);
+	g_io_channel_unref(dev->io);
+	dev->io = NULL;
+
 	return;
 
 fail:
@@ -288,10 +298,8 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 	if (dev->io)
 		g_io_channel_shutdown(dev->io, TRUE, NULL);
 
-	if (dev->conn_state == HAL_PAN_STATE_CONNECTED) {
-		bnep_if_down(dev->iface);
-		bnep_conndel(&dst);
-	}
+	if (dev->conn_state == HAL_PAN_STATE_CONNECTED)
+		bnep_disconnect(dev->session);
 
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTING);
 	status = HAL_STATUS_SUCCESS;
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index d09f369..a4b1670 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -39,6 +39,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
 #include <bluetooth/bnep.h>
+#include <btio/btio.h>
 
 #include <glib.h>
 
@@ -71,26 +72,18 @@ struct bnep {
 	GIOChannel	*io;
 	uint16_t	src;
 	uint16_t	dst;
+	bdaddr_t	dst_addr;
+	char	iface[16];
 	guint	attempts;
 	guint	setup_to;
 	guint	watch;
 	void	*data;
 	bnep_connect_cb	conn_cb;
+	void	*conn_data;
+	bnep_disconnect_cb disconn_cb;
+	void	*disconn_data;
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
@@ -247,6 +240,17 @@ int bnep_if_down(const char *devname)
 	return 0;
 }
 
+static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct bnep *b = data;
+
+	if (b->disconn_cb)
+		b->disconn_cb(b->disconn_data);
+
+	return FALSE;
+}
+
 static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
@@ -254,7 +258,6 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	struct bnep_control_rsp *rsp;
 	struct timeval timeo;
 	char pkt[BNEP_MTU];
-	char iface[16];
 	ssize_t r;
 	int sk;
 
@@ -311,24 +314,27 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
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
+	b->conn_cb(b->iface, 0, b->conn_data);
+	b->watch = g_io_add_watch(b->io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						(GIOFunc) bnep_watchdog_cb, b);
+	g_io_channel_unref(b->io);
+	b->io = NULL;
 
 	return FALSE;
 
 failed:
-	b->conn_cb(NULL, NULL, -EIO, b->data);
-	free_bnep_connect(b);
+	b->conn_cb(NULL, -EIO, b->conn_data);
 
 	return FALSE;
 }
@@ -372,8 +378,7 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 			return TRUE;
 	}
 
-	b->conn_cb(NULL, NULL, -ETIMEDOUT, b->data);
-	free_bnep_connect(b);
+	b->conn_cb(NULL, -ETIMEDOUT, b->conn_data);
 
 	return FALSE;
 }
@@ -412,22 +417,25 @@ void bnep_free(struct bnep *b)
 	g_free(b);
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
-	b->data = data;
+	b->conn_data = data;
+
+	bt_io_get(b->io, &gerr, BT_IO_OPT_DEST_BDADDR, &b->dst_addr,
+							BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		return -EINVAL;
+	}
 
 	err = bnep_setup_conn_req(b);
 	if (err < 0)
@@ -435,11 +443,40 @@ int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
 
 	b->setup_to = g_timeout_add_seconds(CON_SETUP_TO,
 							bnep_conn_req_to, b);
-	g_io_add_watch(b->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							bnep_setup_cb, b);
 	return 0;
 }
 
+void bnep_disconnect(struct bnep *b)
+{
+	if (!b)
+		return;
+
+	if (b->watch > 0) {
+		g_source_remove(b->watch);
+		b->watch = 0;
+	}
+
+	if (b->io) {
+		g_io_channel_unref(b->io);
+		b->io = NULL;
+	}
+
+	bnep_if_down(b->iface);
+	bnep_conndel(&b->dst_addr);
+}
+
+void bnep_set_disconnect(struct bnep *b, bnep_disconnect_cb disconn_cb,
+								void *data)
+{
+	if (!b || !disconn_cb)
+		return;
+
+	if (!b->disconn_cb && !b->disconn_data) {
+		b->disconn_cb = disconn_cb;
+		b->disconn_data = data;
+	}
+}
+
 int bnep_add_to_bridge(const char *devname, const char *bridge)
 {
 	int ifindex;
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 091a7f2..cff5c78 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -39,10 +39,12 @@ int bnep_if_down(const char *devname);
 int bnep_add_to_bridge(const char *devname, const char *bridge);
 int bnep_del_from_bridge(const char *devname, const char *bridge);
 
-typedef void (*bnep_connect_cb) (GIOChannel *chan, char *iface, int err,
-								void *data);
-int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
+typedef void (*bnep_connect_cb) (char *iface, int err, void *data);
+typedef void (*bnep_disconnect_cb) (void *data);
+int bnep_connect(struct bnep *b, bnep_connect_cb conn_cb, void *data);
+void bnep_set_disconnect(struct bnep *b, bnep_disconnect_cb disconn_cb,
 								void *data);
+void bnep_disconnect(struct bnep *b);
 
 ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
 uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role);
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index fb3e1ce..4539972 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -70,8 +70,10 @@ struct network_conn {
 	conn_state	state;
 	GIOChannel	*io;
 	guint		dc_id;
+	guint		watch;
 	struct network_peer *peer;
 	DBusMessage	*connect;
+	struct bnep	*session;
 };
 
 static GSList *peers = NULL;
@@ -106,8 +108,7 @@ static struct network_conn *find_connection_by_state(GSList *list,
 	return NULL;
 }
 
-static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
-				gpointer data)
+static void bnep_disconn_cb(gpointer data)
 {
 	struct network_conn *nc = data;
 	DBusConnection *conn = btd_get_dbus_connection();
@@ -126,11 +127,23 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 
 	info("%s disconnected", nc->dev);
 
-	bnep_if_down(nc->dev);
 	nc->state = DISCONNECTED;
 	memset(nc->dev, 0, sizeof(nc->dev));
 	strcpy(nc->dev, "bnep%d");
 
+	bnep_free(nc->session);
+	nc->session = NULL;
+
+	if (nc->io) {
+		g_io_channel_unref(nc->io);
+		nc->io = NULL;
+	}
+}
+
+static gboolean watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
+{
+	bnep_disconn_cb(data);
+
 	return FALSE;
 }
 
@@ -155,12 +168,25 @@ static void local_connect_cb(struct network_conn *nc, int err)
 static void cancel_connection(struct network_conn *nc, int err)
 {
 	btd_service_connecting_complete(nc->service, err);
+
 	if (nc->connect)
 		local_connect_cb(nc, err);
 
-	g_io_channel_shutdown(nc->io, TRUE, NULL);
-	g_io_channel_unref(nc->io);
-	nc->io = NULL;
+	if (nc->watch > 0) {
+		g_source_remove(nc->watch);
+		nc->watch = 0;
+	}
+
+	if (nc->io) {
+		g_io_channel_unref(nc->io);
+		nc->io = NULL;
+	}
+
+	if (nc->state == CONNECTED)
+		bnep_disconnect(nc->session);
+
+	bnep_free(nc->session);
+	nc->session = NULL;
 
 	nc->state = DISCONNECTED;
 }
@@ -169,11 +195,7 @@ static void connection_destroy(DBusConnection *conn, void *user_data)
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
@@ -186,7 +208,7 @@ static void disconnect_cb(struct btd_device *device, gboolean removal,
 	connection_destroy(NULL, user_data);
 }
 
-static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
+static void bnep_conn_cb(char *iface, int err, void *data)
 {
 	struct network_conn *nc = data;
 	const char *path;
@@ -220,11 +242,6 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 	nc->state = CONNECTED;
 	nc->dc_id = device_add_disconnect_watch(nc->peer->device, disconnect_cb,
 								nc, NULL);
-	g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							bnep_watchdog_cb, nc);
-	g_io_channel_unref(nc->io);
-	nc->io = NULL;
-
 	return;
 
 failed:
@@ -242,12 +259,19 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	}
 
 	sk = g_io_channel_unix_get_fd(nc->io);
-	perr = bnep_connect(sk, BNEP_SVC_PANU, nc->id, bnep_conn_cb, nc);
+	nc->session = bnep_new(sk, BNEP_SVC_PANU, nc->id);
+	perr = bnep_connect(nc->session, bnep_conn_cb, nc);
 	if (perr < 0) {
 		error("bnep connect(): %s (%d)", strerror(-perr), -perr);
 		goto failed;
 	}
 
+	bnep_set_disconnect(nc->session, bnep_disconn_cb, nc);
+	nc->watch = g_io_add_watch(nc->io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+								watch_cb, nc);
+	g_io_channel_unref(nc->io);
+	nc->io = NULL;
+
 	return;
 
 failed:
-- 
1.8.3.2

