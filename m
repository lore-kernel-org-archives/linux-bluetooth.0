Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v7 4/5] bnep: Refactored bnep connect and disconnect calls
Date: Fri, 20 Dec 2013 13:40:52 +0200
Message-Id: <1387539653-7271-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387539653-7271-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387539653-7271-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refactored bnep connect and disconnect calls to simplify and
keeping bnep related functionality behind curtains.
bnep_connect calls takes care of bnep_setup until interface up
then connect callback will be called. Set disconnect callback
when connect call succeeds. bnep_disconnect should be
called only when iface is up/connected.
---
 android/pan.c                 | 54 +++++++++++++++----------------
 profiles/network/bnep.c       | 75 ++++++++++++++++++++++---------------------
 profiles/network/bnep.h       |  6 ++--
 profiles/network/connection.c | 48 ++++++++++++++++-----------
 4 files changed, 96 insertions(+), 87 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index b83f534..689c7ef 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -54,7 +54,7 @@ struct pan_device {
 	uint8_t		conn_state;
 	uint8_t		role;
 	GIOChannel	*io;
-	guint		watch;
+	struct bnep	*session;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -67,16 +67,13 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
 
 static void pan_device_free(struct pan_device *dev)
 {
-	if (dev->watch > 0) {
-		g_source_remove(dev->watch);
-		dev->watch = 0;
-	}
-
 	if (dev->io) {
+		g_io_channel_shutdown(dev->io, FALSE, NULL);
 		g_io_channel_unref(dev->io);
 		dev->io = NULL;
 	}
 
+	bnep_free(dev->session);
 	devices = g_slist_remove(devices, dev);
 	g_free(dev);
 
@@ -124,21 +121,16 @@ static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
 									&ev);
 }
 
-static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
-								gpointer data)
+static void bnep_disconn_cb(void *data)
 {
 	struct pan_device *dev = data;
 
 	DBG("%s disconnected", dev->iface);
 
-	bnep_if_down(dev->iface);
-	bnep_conndel(&dev->dst);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
-
-	return FALSE;
 }
 
-static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
+static void bnep_conn_cb(char *iface, int err, void *data)
 {
 	struct pan_device *dev = data;
 
@@ -146,7 +138,6 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 
 	if (err < 0) {
 		error("bnep connect req failed: %s", strerror(-err));
-		bnep_conndel(&dev->dst);
 		bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 		return;
 	}
@@ -157,17 +148,12 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 
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
@@ -177,16 +163,29 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 		goto fail;
 	}
 
-	src = (local_role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
-	dst = (dev->role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
+	l_role = (local_role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP :
+								BNEP_SVC_PANU;
+	r_role = (dev->role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
+
 	sk = g_io_channel_unix_get_fd(dev->io);
 
-	perr = bnep_connect(sk, src, dst, bnep_conn_cb, dev);
+	dev->session = bnep_new(sk, l_role, r_role);
+	if (!dev->session)
+		goto fail;
+
+	perr = bnep_connect(dev->session, bnep_conn_cb, dev);
 	if (perr < 0) {
 		error("bnep connect req failed: %s", strerror(-perr));
 		goto fail;
 	}
 
+	bnep_set_disconnect(dev->session, bnep_disconn_cb, dev);
+
+	if (dev->io) {
+		g_io_channel_unref(dev->io);
+		dev->io = NULL;
+	}
+
 	return;
 
 fail:
@@ -284,13 +283,10 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 	}
 
 	dev = l->data;
-	if (dev->watch) {
-		g_source_remove(dev->watch);
-		dev->watch = 0;
-	}
 
-	bnep_if_down(dev->iface);
-	bnep_conndel(&dst);
+	if (dev->conn_state == HAL_PAN_STATE_CONNECTED)
+		bnep_disconnect(dev->session);
+
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 	status = HAL_STATUS_SUCCESS;
 
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 4bc08d9..eace07a 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -39,6 +39,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
 #include <bluetooth/bnep.h>
+#include <btio/btio.h>
 
 #include <glib.h>
 
@@ -76,25 +77,12 @@ struct bnep {
 	guint	attempts;
 	guint	setup_to;
 	guint	watch;
-	void	*data;
 	bnep_connect_cb	conn_cb;
+	void	*conn_data;
 	bnep_disconnect_cb disconn_cb;
 	void	*disconn_data;
 };
 
-static void free_bnep_connect(struct bnep *session)
-{
-	if (!session)
-		return;
-
-	if (session->io) {
-		g_io_channel_unref(session->io);
-		session->io = NULL;
-	}
-
-	g_free(session);
-}
-
 uint16_t bnep_service_id(const char *svc)
 {
 	int i;
@@ -251,6 +239,17 @@ int bnep_if_down(const char *devname)
 	return 0;
 }
 
+static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct bnep *session = data;
+
+	if (session->disconn_cb)
+		session->disconn_cb(session->disconn_data);
+
+	return FALSE;
+}
+
 static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
@@ -258,12 +257,11 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	struct bnep_control_rsp *rsp;
 	struct timeval timeo;
 	char pkt[BNEP_MTU];
-	char iface[16];
 	ssize_t r;
 	int sk;
 
 	if (cond & G_IO_NVAL)
-		goto failed;
+		return FALSE;
 
 	if (session->setup_to > 0) {
 		g_source_remove(session->setup_to);
@@ -315,24 +313,29 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
 
 	sk = g_io_channel_unix_get_fd(session->io);
-	if (bnep_connadd(sk, session->src, iface)) {
+	if (bnep_connadd(sk, session->src, session->iface)) {
 		error("bnep conn could not be added");
 		goto failed;
 	}
 
-	if (bnep_if_up(iface)) {
-		error("could not up %s", iface);
+	if (bnep_if_up(session->iface)) {
+		error("could not up %s", session->iface);
+		bnep_conndel(&session->dst_addr);
 		goto failed;
 	}
 
-	session->conn_cb(chan, iface, 0, session->data);
-	free_bnep_connect(session);
+	session->watch = g_io_add_watch(session->io,
+					G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) bnep_watchdog_cb, session);
+	g_io_channel_unref(session->io);
+	session->io = NULL;
+
+	session->conn_cb(session->iface, 0, session->conn_data);
 
 	return FALSE;
 
 failed:
-	session->conn_cb(NULL, NULL, -EIO, session->data);
-	free_bnep_connect(session);
+	session->conn_cb(NULL, -EIO, session->conn_data);
 
 	return FALSE;
 }
@@ -376,8 +379,7 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 			return TRUE;
 	}
 
-	session->conn_cb(NULL, NULL, -ETIMEDOUT, session->data);
-	free_bnep_connect(session);
+	session->conn_cb(NULL, -ETIMEDOUT, session->conn_data);
 
 	return FALSE;
 }
@@ -423,22 +425,25 @@ void bnep_free(struct bnep *session)
 	g_free(session);
 }
 
-int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
-								void *data)
+int bnep_connect(struct bnep *session, bnep_connect_cb conn_cb, void *data)
 {
-	struct bnep *session;
+	GError *gerr = NULL;
 	int err;
 
-	if (!conn_cb)
+	if (!session || !conn_cb)
 		return -EINVAL;
 
-	session = g_new0(struct bnep, 1);
-	session->io = g_io_channel_unix_new(sk);
 	session->attempts = 0;
-	session->src = src;
-	session->dst = dst;
 	session->conn_cb = conn_cb;
-	session->data = data;
+	session->conn_data = data;
+
+	bt_io_get(session->io, &gerr, BT_IO_OPT_DEST_BDADDR, &session->dst_addr,
+							BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		return -EINVAL;
+	}
 
 	err = bnep_setup_conn_req(session);
 	if (err < 0)
@@ -446,8 +451,6 @@ int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
 
 	session->setup_to = g_timeout_add_seconds(CON_SETUP_TO,
 						bnep_conn_req_to, session);
-	g_io_add_watch(session->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							bnep_setup_cb, session);
 	return 0;
 }
 
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index d3c5c1b..c07cd77 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -40,10 +40,8 @@ int bnep_if_down(const char *devname);
 int bnep_add_to_bridge(const char *devname, const char *bridge);
 int bnep_del_from_bridge(const char *devname, const char *bridge);
 
-typedef void (*bnep_connect_cb) (GIOChannel *chan, char *iface, int err,
-								void *data);
-int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
-								void *data);
+typedef void (*bnep_connect_cb) (char *iface, int err, void *data);
+int bnep_connect(struct bnep *b, bnep_connect_cb conn_cb, void *data);
 typedef void (*bnep_disconnect_cb) (void *data);
 void bnep_set_disconnect(struct bnep *session, bnep_disconnect_cb disconn_cb,
 								void *data);
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index fb3e1ce..c66987d 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -72,6 +72,7 @@ struct network_conn {
 	guint		dc_id;
 	struct network_peer *peer;
 	DBusMessage	*connect;
+	struct bnep	*session;
 };
 
 static GSList *peers = NULL;
@@ -106,8 +107,7 @@ static struct network_conn *find_connection_by_state(GSList *list,
 	return NULL;
 }
 
-static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
-				gpointer data)
+static void bnep_disconn_cb(gpointer data)
 {
 	struct network_conn *nc = data;
 	DBusConnection *conn = btd_get_dbus_connection();
@@ -126,12 +126,12 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 
 	info("%s disconnected", nc->dev);
 
-	bnep_if_down(nc->dev);
 	nc->state = DISCONNECTED;
 	memset(nc->dev, 0, sizeof(nc->dev));
 	strcpy(nc->dev, "bnep%d");
 
-	return FALSE;
+	bnep_free(nc->session);
+	nc->session = NULL;
 }
 
 static void local_connect_cb(struct network_conn *nc, int err)
@@ -155,12 +155,21 @@ static void local_connect_cb(struct network_conn *nc, int err)
 static void cancel_connection(struct network_conn *nc, int err)
 {
 	btd_service_connecting_complete(nc->service, err);
+
 	if (nc->connect)
 		local_connect_cb(nc, err);
 
-	g_io_channel_shutdown(nc->io, TRUE, NULL);
-	g_io_channel_unref(nc->io);
-	nc->io = NULL;
+	if (nc->io) {
+		g_io_channel_shutdown(nc->io, FALSE, NULL);
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
@@ -169,11 +178,7 @@ static void connection_destroy(DBusConnection *conn, void *user_data)
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
@@ -186,7 +191,7 @@ static void disconnect_cb(struct btd_device *device, gboolean removal,
 	connection_destroy(NULL, user_data);
 }
 
-static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
+static void bnep_conn_cb(char *iface, int err, void *data)
 {
 	struct network_conn *nc = data;
 	const char *path;
@@ -220,10 +225,6 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 	nc->state = CONNECTED;
 	nc->dc_id = device_add_disconnect_watch(nc->peer->device, disconnect_cb,
 								nc, NULL);
-	g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							bnep_watchdog_cb, nc);
-	g_io_channel_unref(nc->io);
-	nc->io = NULL;
 
 	return;
 
@@ -242,12 +243,23 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	}
 
 	sk = g_io_channel_unix_get_fd(nc->io);
-	perr = bnep_connect(sk, BNEP_SVC_PANU, nc->id, bnep_conn_cb, nc);
+	nc->session = bnep_new(sk, BNEP_SVC_PANU, nc->id);
+	if (!nc->session)
+		goto failed;
+
+	perr = bnep_connect(nc->session, bnep_conn_cb, nc);
 	if (perr < 0) {
 		error("bnep connect(): %s (%d)", strerror(-perr), -perr);
 		goto failed;
 	}
 
+	bnep_set_disconnect(nc->session, bnep_disconn_cb, nc);
+
+	if (nc->io) {
+		g_io_channel_unref(nc->io);
+		nc->io = NULL;
+	}
+
 	return;
 
 failed:
-- 
1.8.3.2

