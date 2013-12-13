Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/2] bnep: Refactored bnep connect and disconnect calls
Date: Fri, 13 Dec 2013 14:35:49 +0200
Message-Id: <1386938150-5683-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refactored bnep connect and disconnect calls to simply and
keeping bnep related functionality behind curtains.
Provided bnep_struct, bnep_new and bnep_free to intialize
and free the bnep_stuct with basic parameters. bnep_connect
calls takes care of bnep_setup until interface up then connect
callback will be called, disconnect_cb is registered as watchdog
and it will triggered by remote device on disconnect or any other
I/O error. bnep_disconnect should be called only when iface is
up/connected.
---
 android/pan.c                 |  97 ++++++++++++-------------------
 profiles/network/bnep.c       | 131 ++++++++++++++++++++++++++++++------------
 profiles/network/bnep.h       |  14 +++--
 profiles/network/connection.c |  50 ++++++++++------
 4 files changed, 173 insertions(+), 119 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index e410f54..0cae6ac 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -54,7 +54,7 @@ struct pan_device {
 	uint8_t		conn_state;
 	uint8_t		role;
 	GIOChannel	*io;
-	guint		watch;
+	struct bnep_conn *bnep;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -65,24 +65,6 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
 	return bacmp(&dev->dst, dst);
 }
 
-static void pan_device_free(struct pan_device *dev)
-{
-	local_role = HAL_PAN_ROLE_NONE;
-
-	if (dev->watch > 0) {
-		g_source_remove(dev->watch);
-		dev->watch = 0;
-	}
-
-	if (dev->io) {
-		g_io_channel_unref(dev->io);
-		dev->io = NULL;
-	}
-
-	devices = g_slist_remove(devices, dev);
-	g_free(dev);
-}
-
 static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
 {
 	struct hal_ev_pan_conn_state ev;
@@ -121,22 +103,33 @@ static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
 									&ev);
 }
 
-static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
-								gpointer data)
+static void destroy_pan_device(struct pan_device *dev)
 {
-	struct pan_device *dev = data;
+	if (dev->io) {
+		g_io_channel_shutdown(dev->io, TRUE, NULL);
+		g_io_channel_unref(dev->io);
+		dev->io = NULL;
+	}
 
-	DBG("%s disconnected", dev->iface);
+	if (dev->conn_state == HAL_PAN_STATE_CONNECTED)
+		bnep_disconnect(dev->bnep);
 
-	bnep_if_down(dev->iface);
-	bnep_conndel(&dev->dst);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
-	pan_device_free(dev);
+	bnep_free(dev->bnep);
+	devices = g_slist_remove(devices, dev);
+	g_free(dev);
+}
 
-	return FALSE;
+static void bnep_disconn_cb(void *data)
+{
+	struct pan_device *dev = data;
+
+	DBG("%s disconnected", dev->iface);
+
+	destroy_pan_device(dev);
 }
 
-static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
+static void bnep_conn_cb(char *iface, int err, void *data)
 {
 	struct pan_device *dev = data;
 
@@ -144,26 +137,18 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 
 	if (err < 0) {
 		error("bnep connect req failed: %s", strerror(-err));
-		bnep_conndel(&dev->dst);
-		bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
-		pan_device_free(dev);
+		destroy_pan_device(dev);
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
 
-static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
+static void bt_io_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct pan_device *dev = data;
 	uint16_t src, dst;
@@ -180,7 +165,13 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	dst = (dev->role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
 	sk = g_io_channel_unix_get_fd(dev->io);
 
-	perr = bnep_connect(sk, src, dst, bnep_conn_cb, dev);
+	dev->bnep = bnep_new(src, dst, &dev->dst);
+	if (!dev->bnep) {
+		error("unable to allocate memory for dev->bnep");
+		goto fail;
+	}
+
+	perr = bnep_connect(dev->bnep, sk, bnep_conn_cb, bnep_disconn_cb, dev);
 	if (perr < 0) {
 		error("bnep connect req failed: %s", strerror(-perr));
 		goto fail;
@@ -189,8 +180,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	return;
 
 fail:
-	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
-	pan_device_free(dev);
+	destroy_pan_device(dev);
 }
 
 static void bt_pan_connect(const void *buf, uint16_t len)
@@ -240,7 +230,7 @@ static void bt_pan_connect(const void *buf, uint16_t len)
 	ba2str(&dev->dst, addr);
 	DBG("connecting to %s %s", addr, dev->iface);
 
-	dev->io = bt_io_connect(connect_cb, dev, NULL, &gerr,
+	dev->io = bt_io_connect(bt_io_connect_cb, dev, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 					BT_IO_OPT_DEST_BDADDR, &dev->dst,
 					BT_IO_OPT_PSM, BNEP_PSM,
@@ -269,7 +259,7 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_pan_disconnect *cmd = buf;
 	struct pan_device *dev;
-	uint8_t status;
+	uint8_t status = HAL_STATUS_FAILED;
 	GSList *l;
 	bdaddr_t dst;
 
@@ -278,24 +268,11 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (!l) {
-		status = HAL_STATUS_FAILED;
+	if (!l)
 		goto failed;
-	}
 
 	dev = l->data;
-
-	if (dev->watch) {
-		g_source_remove(dev->watch);
-		dev->watch = 0;
-	}
-
-	bnep_if_down(dev->iface);
-	bnep_conndel(&dst);
-
-	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
-	pan_device_free(dev);
-
+	destroy_pan_device(dev);
 	status = HAL_STATUS_SUCCESS;
 
 failed:
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 08037e6..752e00e 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -71,25 +71,16 @@ struct bnep_conn {
 	GIOChannel	*io;
 	uint16_t	src;
 	uint16_t	dst;
+	bdaddr_t	dst_addr;
+	char	iface[16];
 	guint	attempts;
 	guint	setup_to;
 	void	*data;
-	bnep_connect_cb	conn_cb;
+	bnep_connect_cb conn_cb;
+	bnep_disconnect_cb disconn_cb;
+	int watch;
 };
 
-static void free_bnep_connect(struct bnep_conn *bc)
-{
-	if (!bc)
-		return;
-
-	if (bc->io) {
-		g_io_channel_unref(bc->io);
-		bc->io = NULL;
-	}
-
-	g_free(bc);
-}
-
 uint16_t bnep_service_id(const char *svc)
 {
 	int i;
@@ -246,6 +237,39 @@ int bnep_if_down(const char *devname)
 	return 0;
 }
 
+struct bnep_conn *bnep_new(uint16_t src, uint16_t dst,
+						const bdaddr_t *dst_addr)
+{
+	struct bnep_conn *bc;
+
+	DBG("");
+
+	if (!dst_addr)
+		return NULL;
+
+	bc = g_new0(struct bnep_conn, 1);
+	if (!bc)
+		return NULL;
+
+	bc->src = src;
+	bc->dst = dst;
+	bacpy(&bc->dst_addr, dst_addr);
+
+	return bc;
+}
+
+static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct bnep_conn *bc = data;
+
+	DBG("");
+
+	bc->disconn_cb(bc->data);
+
+	return FALSE;
+}
+
 static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
@@ -253,12 +277,11 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	struct bnep_control_rsp *rsp;
 	struct timeval timeo;
 	char pkt[BNEP_MTU];
-	char iface[16];
 	ssize_t r;
 	int sk;
 
 	if (cond & G_IO_NVAL)
-		goto failed;
+		return FALSE;
 
 	if (bc->setup_to > 0) {
 		g_source_remove(bc->setup_to);
@@ -310,24 +333,28 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
 
 	sk = g_io_channel_unix_get_fd(bc->io);
-	if (bnep_connadd(sk, bc->src, iface)) {
+	if (bnep_connadd(sk, bc->src, bc->iface)) {
 		error("bnep conn could not be added");
 		goto failed;
 	}
 
-	if (bnep_if_up(iface)) {
-		error("could not up %s", iface);
+	if (bnep_if_up(bc->iface)) {
+		error("could not up %s", bc->iface);
+		bnep_conndel(&bc->dst_addr);
 		goto failed;
 	}
 
-	bc->conn_cb(chan, iface, 0, bc->data);
-	free_bnep_connect(bc);
+	bc->watch = g_io_add_watch(bc->io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							bnep_watchdog_cb, bc);
+	g_io_channel_unref(bc->io);
+	bc->io = NULL;
+
+	bc->conn_cb(bc->iface, 0, bc->data);
 
 	return FALSE;
 
 failed:
-	bc->conn_cb(NULL, NULL, -EIO, bc->data);
-	free_bnep_connect(bc);
+	bc->conn_cb(NULL, -EIO, bc->data);
 
 	return FALSE;
 }
@@ -371,40 +398,72 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 			return TRUE;
 	}
 
-	bc->conn_cb(NULL, NULL, -ETIMEDOUT, bc->data);
-	free_bnep_connect(bc);
+	bc->conn_cb(NULL, -ETIMEDOUT, bc->data);
 
 	return FALSE;
 }
 
-int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
-								void *data)
+int bnep_connect(struct bnep_conn *bc, int sk, bnep_connect_cb conn_cb,
+				bnep_disconnect_cb disconn_cb, void *data)
 {
-	struct bnep_conn *bc;
 	int err;
 
-	if (!conn_cb)
+	if (!bc || !conn_cb || !disconn_cb)
 		return -EINVAL;
 
-	bc = g_new0(struct bnep_conn, 1);
 	bc->io = g_io_channel_unix_new(sk);
-	bc->attempts = 0;
-	bc->src = src;
-	bc->dst = dst;
-	bc->conn_cb = conn_cb;
 	bc->data = data;
+	bc->conn_cb = conn_cb;
+	bc->disconn_cb = disconn_cb;
 
 	err = bnep_setup_conn_req(bc);
 	if (err < 0)
 		return err;
 
 	bc->setup_to = g_timeout_add_seconds(CON_SETUP_TO,
-							bnep_conn_req_to, bc);
-	g_io_add_watch(bc->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						bnep_conn_req_to, bc);
+	bc->watch = g_io_add_watch(bc->io,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 							bnep_setup_cb, bc);
 	return 0;
 }
 
+void bnep_disconnect(struct bnep_conn *bc)
+{
+	DBG("");
+
+	if (!bc)
+		return;
+
+	if (bc->io) {
+		g_io_channel_unref(bc->io);
+		bc->io = NULL;
+	}
+
+	if (bc->watch) {
+		g_source_remove(bc->watch);
+		bc->watch = 0;
+	}
+
+	bnep_if_down(bc->iface);
+	bnep_conndel(&bc->dst_addr);
+}
+
+void bnep_free(struct bnep_conn *bc)
+{
+	DBG("");
+
+	if (!bc)
+		return;
+
+	if (bc->io) {
+		g_io_channel_unref(bc->io);
+		bc->io = NULL;
+	}
+
+	g_free(bc);
+}
+
 int bnep_add_to_bridge(const char *devname, const char *bridge)
 {
 	int ifindex;
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index dd22c40..fcb35f7 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -21,6 +21,8 @@
  *
  */
 
+struct bnep_conn;
+
 int bnep_init(void);
 int bnep_cleanup(void);
 
@@ -35,10 +37,14 @@ int bnep_if_down(const char *devname);
 int bnep_add_to_bridge(const char *devname, const char *bridge);
 int bnep_del_from_bridge(const char *devname, const char *bridge);
 
-typedef void (*bnep_connect_cb) (GIOChannel *chan, char *iface, int err,
-								void *data);
-int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
-								void *data);
+struct bnep_conn *bnep_new(uint16_t src, uint16_t dst,
+						const bdaddr_t *dst_addr);
+void bnep_free(struct bnep_conn *bnep);
+typedef void (*bnep_connect_cb) (char *iface, int err, void *data);
+typedef void (*bnep_disconnect_cb) (void *data);
+int bnep_connect(struct bnep_conn *bnep, int sk, bnep_connect_cb conn_cb,
+				bnep_disconnect_cb disconn_cb, void *data);
+void bnep_disconnect(struct bnep_conn *bnep);
 
 ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
 uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role);
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index fb3e1ce..c7cc99f 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -72,6 +72,7 @@ struct network_conn {
 	guint		dc_id;
 	struct network_peer *peer;
 	DBusMessage	*connect;
+	struct bnep_conn *bnep;
 };
 
 static GSList *peers = NULL;
@@ -106,8 +107,7 @@ static struct network_conn *find_connection_by_state(GSList *list,
 	return NULL;
 }
 
-static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
-				gpointer data)
+static void bnep_disconn_cb(void *data)
 {
 	struct network_conn *nc = data;
 	DBusConnection *conn = btd_get_dbus_connection();
@@ -126,12 +126,18 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 
 	info("%s disconnected", nc->dev);
 
-	bnep_if_down(nc->dev);
 	nc->state = DISCONNECTED;
 	memset(nc->dev, 0, sizeof(nc->dev));
 	strcpy(nc->dev, "bnep%d");
 
-	return FALSE;
+	bnep_free(nc->bnep);
+	nc->bnep = NULL;
+
+	if (nc->io) {
+		g_io_channel_shutdown(nc->io, TRUE, NULL);
+		g_io_channel_unref(nc->io);
+		nc->io = NULL;
+	}
 }
 
 static void local_connect_cb(struct network_conn *nc, int err)
@@ -158,9 +164,17 @@ static void cancel_connection(struct network_conn *nc, int err)
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
+		bnep_disconnect(nc->bnep);
+
+	bnep_free(nc->bnep);
+	nc->bnep = NULL;
 
 	nc->state = DISCONNECTED;
 }
@@ -169,11 +183,7 @@ static void connection_destroy(DBusConnection *conn, void *user_data)
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
@@ -186,7 +196,7 @@ static void disconnect_cb(struct btd_device *device, gboolean removal,
 	connection_destroy(NULL, user_data);
 }
 
-static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
+static void bnep_conn_cb(char *iface, int err, void *data)
 {
 	struct network_conn *nc = data;
 	const char *path;
@@ -220,11 +230,6 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
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
@@ -242,7 +247,14 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	}
 
 	sk = g_io_channel_unix_get_fd(nc->io);
-	perr = bnep_connect(sk, BNEP_SVC_PANU, nc->id, bnep_conn_cb, nc);
+	nc->bnep = bnep_new(BNEP_SVC_PANU, nc->id,
+					device_get_address(nc->peer->device));
+	if (!nc->bnep) {
+		error("unable to allocate memory for nc->bnep");
+		goto failed;
+	}
+
+	perr = bnep_connect(nc->bnep, sk, bnep_conn_cb, bnep_disconn_cb, nc);
 	if (perr < 0) {
 		error("bnep connect(): %s (%d)", strerror(-perr), -perr);
 		goto failed;
-- 
1.8.3.2

