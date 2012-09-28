Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v4 3/5] adapter: Use authorization id for cancelling
Date: Fri, 28 Sep 2012 18:32:23 +0200
Message-Id: <1348849945-5762-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1348849945-5762-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1348849945-5762-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Return a request id in btd_request_authorization() in order to be used
when the request needs to be cancelled. This id alone will be enough to
use btd_cancel_authorization().
---
 audio/device.c            | 25 +++++++++++-------
 plugins/service.c         | 18 ++++++++-----
 profiles/input/server.c   |  7 +++--
 profiles/network/server.c |  9 +++----
 profiles/sap/server.c     |  8 +++---
 src/adapter.c             | 67 ++++++++++++++++++++++++++++-------------------
 src/adapter.h             |  4 +--
 src/profile.c             | 25 ++++++------------
 8 files changed, 87 insertions(+), 76 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index 99d6512..c6ae96a 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -83,6 +83,7 @@ struct dev_priv {
 	sink_state_t sink_state;
 	avctp_state_t avctp_state;
 	GSList *auths;
+	guint auth_id;
 
 	DBusMessage *conn_req;
 	DBusMessage *dc_req;
@@ -737,6 +738,8 @@ static void auth_cb(DBusError *derr, void *user_data)
 	struct audio_device *dev = user_data;
 	struct dev_priv *priv = dev->priv;
 
+	priv->auth_id = 0;
+
 	if (derr == NULL)
 		priv->authorized = TRUE;
 
@@ -797,7 +800,6 @@ int audio_device_request_authorization(struct audio_device *dev,
 {
 	struct dev_priv *priv = dev->priv;
 	struct service_auth *auth;
-	int err;
 
 	auth = g_try_new0(struct service_auth, 1);
 	if (!auth)
@@ -815,14 +817,15 @@ int audio_device_request_authorization(struct audio_device *dev,
 		return 0;
 	}
 
-	err = btd_request_authorization(&dev->src, &dev->dst, uuid, auth_cb,
-					dev);
-	if (err < 0) {
-		priv->auths = g_slist_remove(priv->auths, auth);
-		g_free(auth);
-	}
+	priv->auth_id = btd_request_authorization(&dev->src, &dev->dst, uuid,
+								auth_cb, dev);
+	if (priv->auth_id != 0)
+		return 0;
+
+	priv->auths = g_slist_remove(priv->auths, auth);
+	g_free(auth);
 
-	return err;
+	return -EPERM;
 }
 
 int audio_device_cancel_authorization(struct audio_device *dev,
@@ -850,8 +853,10 @@ int audio_device_cancel_authorization(struct audio_device *dev,
 		if (priv->auth_idle_id > 0) {
 			g_source_remove(priv->auth_idle_id);
 			priv->auth_idle_id = 0;
-		} else
-			btd_cancel_authorization(&dev->src, &dev->dst);
+		} else {
+			btd_cancel_authorization(priv->auth_id);
+			priv->auth_id = 0;
+		}
 	}
 
 	return 0;
diff --git a/plugins/service.c b/plugins/service.c
index e02a673..45886ac 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -65,6 +65,7 @@ struct pending_auth {
 	char *sender;
 	bdaddr_t dst;
 	char uuid[MAX_LEN_UUID_STR];
+	guint id;
 };
 
 struct service_adapter {
@@ -557,8 +558,9 @@ done:
 	else
 		bacpy(&src, BDADDR_ANY);
 
-	btd_request_authorization(&src, &auth->dst,
-					auth->uuid, auth_cb, serv_adapter);
+	auth->id = btd_request_authorization(&src, &auth->dst,
+							auth->uuid, auth_cb,
+							serv_adapter);
 }
 
 static DBusMessage *request_authorization(DBusConnection *conn,
@@ -633,8 +635,9 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 	else
 		bacpy(&src, BDADDR_ANY);
 
-	if (btd_request_authorization(&src, &auth->dst, auth->uuid, auth_cb,
-							serv_adapter) < 0) {
+	auth->id = btd_request_authorization(&src, &auth->dst, auth->uuid,
+							auth_cb, serv_adapter);
+	if (auth->id == 0) {
 		serv_adapter->pending_list = g_slist_remove(serv_adapter->pending_list,
 									auth);
 		g_free(auth);
@@ -664,7 +667,7 @@ static DBusMessage *cancel_authorization(DBusConnection *conn,
 	else
 		bacpy(&src, BDADDR_ANY);
 
-	btd_cancel_authorization(&src, &auth->dst);
+	btd_cancel_authorization(auth->id);
 
 	reply = btd_error_not_authorized(auth->msg);
 	dbus_message_unref(auth->msg);
@@ -683,8 +686,9 @@ static DBusMessage *cancel_authorization(DBusConnection *conn,
 	else
 		bacpy(&src, BDADDR_ANY);
 
-	btd_request_authorization(&src, &auth->dst,
-					auth->uuid, auth_cb, serv_adapter);
+	auth->id = btd_request_authorization(&src, &auth->dst,
+							auth->uuid, auth_cb,
+							serv_adapter);
 
 done:
 	return dbus_message_new_method_return(msg);
diff --git a/profiles/input/server.c b/profiles/input/server.c
index f71fdc0..eaf3b6a 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -154,7 +154,7 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 	bdaddr_t src, dst;
 	GError *err = NULL;
 	char addr[18];
-	int ret;
+	guint ret;
 
 	bt_io_get(chan, &err,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
@@ -179,12 +179,11 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 
 	ret = btd_request_authorization(&src, &dst, HID_UUID,
 					auth_callback, server);
-	if (ret == 0)
+	if (ret != 0)
 		return;
 
 	ba2str(&src, addr);
-	error("input: authorization for %s failed: %s (%d)",
-						addr, strerror(-ret), -ret);
+	error("input: authorization for %s failed", addr);
 
 	g_io_channel_unref(server->confirm);
 	server->confirm = NULL;
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 43ce9d9..6ee4770 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -500,10 +500,10 @@ static void confirm_event(GIOChannel *chan, gpointer user_data)
 {
 	struct network_adapter *na = user_data;
 	struct network_server *ns;
-	int perr;
 	bdaddr_t src, dst;
 	char address[18];
 	GError *err = NULL;
+	guint ret;
 
 	bt_io_get(chan, &err,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
@@ -537,11 +537,10 @@ static void confirm_event(GIOChannel *chan, gpointer user_data)
 	bacpy(&na->setup->dst, &dst);
 	na->setup->io = g_io_channel_ref(chan);
 
-	perr = btd_request_authorization(&src, &dst, BNEP_SVC_UUID,
+	ret = btd_request_authorization(&src, &dst, BNEP_SVC_UUID,
 					auth_cb, na);
-	if (perr < 0) {
-		error("Refusing connect from %s: %s (%d)", address,
-				strerror(-perr), -perr);
+	if (ret == 0) {
+		error("Refusing connect from %s", address);
 		setup_destroy(na);
 		goto drop;
 	}
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 6c5aa21..6072432 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1213,7 +1213,7 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 	GError *gerr = NULL;
 	bdaddr_t src, dst;
 	char dstaddr[18];
-	int err;
+	guint ret;
 
 	DBG("conn %p io %p", conn, io);
 
@@ -1253,10 +1253,10 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 
 	ba2str(&dst, dstaddr);
 
-	err = btd_request_authorization(&src, &dst, SAP_UUID, connect_auth_cb,
+	ret = btd_request_authorization(&src, &dst, SAP_UUID, connect_auth_cb,
 								server);
-	if (err < 0) {
-		error("Authorization failure (err %d)", err);
+	if (ret == 0) {
+		error("Authorization failure");
 		sap_server_remove_conn(server);
 		return;
 	}
diff --git a/src/adapter.c b/src/adapter.c
index 524885c..982fd8d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -97,6 +97,7 @@ struct session_req {
 };
 
 struct service_auth {
+	guint id;
 	service_auth_cb cb;
 	void *user_data;
 	struct btd_device *device;
@@ -3209,27 +3210,29 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	char address[18];
 	const gchar *dev_path;
 	int err;
+	static guint id = 0;
 
 	ba2str(dst, address);
 	device = adapter_find_device(adapter, address);
 	if (!device)
-		return -EPERM;
+		return 0;
 
 	/* Device connected? */
 	if (!g_slist_find(adapter->connections, device))
 		error("Authorization request for non-connected device!?");
 
 	if (adapter->auth != NULL)
-		return -EBUSY;
+		return 0;
 
 	auth = g_try_new0(struct service_auth, 1);
 	if (!auth)
-		return -ENOMEM;
+		return 0;
 
 	auth->cb = cb;
 	auth->user_data = user_data;
 	auth->device = device;
 	auth->adapter = adapter;
+	auth->id = ++id;
 
 	if (device_is_trusted(device) == TRUE) {
 		adapter->auth_idle_id = g_idle_add(auth_idle_cb, adapter);
@@ -3240,7 +3243,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	if (!agent) {
 		warn("Can't find device agent");
 		g_free(auth);
-		return -EPERM;
+		return 0;
 	}
 
 	dev_path = device_get_path(device);
@@ -3249,15 +3252,15 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 									NULL);
 	if (err < 0) {
 		g_free(auth);
-		return err;
+		return 0;
 	}
 
 done:
 	adapter->auth = auth;
-	return 0;
+	return auth->id;
 }
 
-int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
+guint btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 					const char *uuid, service_auth_cb cb,
 					void *user_data)
 {
@@ -3267,55 +3270,65 @@ int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 	if (bacmp(src, BDADDR_ANY) != 0) {
 		adapter = manager_find_adapter(src);
 		if (!adapter)
-			return -EPERM;
+			return 0;
 
 		return adapter_authorize(adapter, dst, uuid, cb, user_data);
 	}
 
 	for (l = manager_get_adapters(); l != NULL; l = g_slist_next(l)) {
-		int err;
+		guint id;
 
 		adapter = l->data;
 
-		err = adapter_authorize(adapter, dst, uuid, cb, user_data);
-		if (err == 0)
-			return 0;
+		id = adapter_authorize(adapter, dst, uuid, cb, user_data);
+		if (id != 0)
+			return id;
 	}
 
-	return -EPERM;
+	return 0;
 }
 
-int btd_cancel_authorization(const bdaddr_t *src, const bdaddr_t *dst)
+static struct btd_adapter *find_authorization(guint id)
 {
-	struct btd_adapter *adapter = manager_find_adapter(src);
-	struct btd_device *device;
+	GSList *l;
+
+	for (l = manager_get_adapters(); l != NULL; l = g_slist_next(l)) {
+		struct btd_adapter *adapter = l->data;
+
+		if (adapter->auth == NULL)
+			continue;
+
+		if (adapter->auth->id == id)
+			return adapter;
+	}
+
+	return NULL;
+}
+
+int btd_cancel_authorization(guint id)
+{
+	struct btd_adapter *adapter;
 	struct agent *agent;
-	char address[18];
 	int err;
 
-	if (!adapter)
-		return -EPERM;
-
-	ba2str(dst, address);
-	device = adapter_find_device(adapter, address);
-	if (!device)
+	adapter = find_authorization(id);
+	if (adapter == NULL)
 		return -EPERM;
 
 	if (adapter->auth_idle_id) {
 		g_source_remove(adapter->auth_idle_id);
 		adapter->auth_idle_id = 0;
+		g_free(adapter->auth);
+		adapter->auth = NULL;
 		return 0;
 	}
 
-	if (!adapter->auth || adapter->auth->device != device)
-		return -EPERM;
-
 	/*
 	 * FIXME: Cancel fails if authorization is requested to adapter's
 	 * agent and in the meanwhile CreatePairedDevice is called.
 	 */
 
-	agent = device_get_agent(device);
+	agent = device_get_agent(adapter->auth->device);
 	if (!agent)
 		return -EPERM;
 
diff --git a/src/adapter.h b/src/adapter.h
index f34763f..436f167 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -149,9 +149,9 @@ void adapter_add_profile(struct btd_adapter *adapter, gpointer p);
 void adapter_remove_profile(struct btd_adapter *adapter, gpointer p);
 int btd_register_adapter_driver(struct btd_adapter_driver *driver);
 void btd_unregister_adapter_driver(struct btd_adapter_driver *driver);
-int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
+guint btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 		const char *uuid, service_auth_cb cb, void *user_data);
-int btd_cancel_authorization(const bdaddr_t *src, const bdaddr_t *dst);
+int btd_cancel_authorization(guint id);
 
 const char *adapter_any_get_path(void);
 
diff --git a/src/profile.c b/src/profile.c
index 24f7b28..a051cf7 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -72,7 +72,7 @@ struct ext_io {
 	GIOChannel *io;
 	guint io_id;
 
-	bool authorizing;
+	guint auth_id;
 	DBusPendingCall *new_conn;
 };
 
@@ -151,14 +151,8 @@ static void ext_io_destroy(gpointer p)
 	g_io_channel_shutdown(ext_io->io, FALSE, NULL);
 	g_io_channel_unref(ext_io->io);
 
-	if (ext_io->authorizing) {
-		bdaddr_t src, dst;
-
-		if (bt_io_get(ext_io->io, NULL, BT_IO_OPT_SOURCE_BDADDR, &src,
-						BT_IO_OPT_DEST_BDADDR, &dst,
-						BT_IO_OPT_INVALID))
-			btd_cancel_authorization(&src, &dst);
-	}
+	if (ext_io->auth_id != 0)
+		btd_cancel_authorization(ext_io->auth_id);
 
 	if (ext_io->new_conn) {
 		dbus_pending_call_cancel(ext_io->new_conn);
@@ -318,7 +312,7 @@ static void ext_auth(DBusError *err, void *user_data)
 	GError *gerr = NULL;
 	char addr[18];
 
-	conn->authorizing = false;
+	conn->auth_id = 0;
 
 	bt_io_get(conn->io, &gerr, BT_IO_OPT_DEST, addr, BT_IO_OPT_INVALID);
 	if (gerr != NULL) {
@@ -372,7 +366,6 @@ static void ext_confirm(GIOChannel *io, gpointer user_data)
 	GError *gerr = NULL;
 	bdaddr_t src, dst;
 	char addr[18];
-	int err;
 
 	bt_io_get(io, &gerr,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
@@ -390,16 +383,14 @@ static void ext_confirm(GIOChannel *io, gpointer user_data)
 
 	conn = create_conn(server, io);
 
-	err = btd_request_authorization(&src, &dst, ext->uuid, ext_auth, conn);
-	if (err < 0) {
-		error("%s authorization failure: %s", ext->name,
-							strerror(-err));
+	conn->auth_id = btd_request_authorization(&src, &dst, ext->uuid,
+								ext_auth, conn);
+	if (conn->auth_id == 0) {
+		error("%s authorization failure", ext->name);
 		ext_io_destroy(conn);
 		return;
 	}
 
-	conn->authorizing = true;
-
 	ext->conns = g_slist_append(ext->conns, conn);
 
 	DBG("%s authorizing connection from %s", ext->name, addr);
-- 
1.7.11.4

