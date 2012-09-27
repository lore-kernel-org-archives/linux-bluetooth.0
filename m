Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 3/5] adapter: Use authorization id for cancelling
Date: Thu, 27 Sep 2012 10:07:50 +0200
Message-Id: <1348733272-2117-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1348733272-2117-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1348733272-2117-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Return a request id in btd_request_authorization() in order to be used
when the request needs to be cancelled. This id alone will be enough to
use btd_cancel_authorization().
---
 audio/device.c          | 12 +++++++++---
 plugins/service.c       | 18 ++++++++++-------
 profiles/input/server.c |  2 +-
 src/adapter.c           | 51 +++++++++++++++++++++++++++++++------------------
 src/adapter.h           |  2 +-
 src/profile.c           | 24 +++++++++--------------
 6 files changed, 63 insertions(+), 46 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index 99d6512..454bbb9 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -83,6 +83,7 @@ struct dev_priv {
 	sink_state_t sink_state;
 	avctp_state_t avctp_state;
 	GSList *auths;
+	int auth_id;
 
 	DBusMessage *conn_req;
 	DBusMessage *dc_req;
@@ -737,6 +738,8 @@ static void auth_cb(DBusError *derr, void *user_data)
 	struct audio_device *dev = user_data;
 	struct dev_priv *priv = dev->priv;
 
+	priv->auth_id = 0;
+
 	if (derr == NULL)
 		priv->authorized = TRUE;
 
@@ -820,7 +823,8 @@ int audio_device_request_authorization(struct audio_device *dev,
 	if (err < 0) {
 		priv->auths = g_slist_remove(priv->auths, auth);
 		g_free(auth);
-	}
+	} else
+		priv->auth_id = err;
 
 	return err;
 }
@@ -850,8 +854,10 @@ int audio_device_cancel_authorization(struct audio_device *dev,
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
index e02a673..fca559d 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -65,6 +65,7 @@ struct pending_auth {
 	char *sender;
 	bdaddr_t dst;
 	char uuid[MAX_LEN_UUID_STR];
+	int id;
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
+	if (auth->id < 0) {
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
index f71fdc0..773e933 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -179,7 +179,7 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 
 	ret = btd_request_authorization(&src, &dst, HID_UUID,
 					auth_callback, server);
-	if (ret == 0)
+	if (ret >= 0)
 		return;
 
 	ba2str(&src, addr);
diff --git a/src/adapter.c b/src/adapter.c
index 0664d23..e77d305 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -85,6 +85,7 @@
 #define OFF_TIMER 3
 
 static GSList *adapter_drivers = NULL;
+static int service_auth_id = 0;
 
 struct session_req {
 	struct btd_adapter	*adapter;
@@ -97,6 +98,7 @@ struct session_req {
 };
 
 struct service_auth {
+	int id;
 	service_auth_cb cb;
 	void *user_data;
 	struct btd_device *device;
@@ -3217,6 +3219,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	auth->user_data = user_data;
 	auth->device = device;
 	auth->adapter = adapter;
+	auth->id = ++service_auth_id;
 
 	if (device_is_trusted(device) == TRUE) {
 		adapter->auth_idle_id = g_idle_add(auth_idle_cb, adapter);
@@ -3241,7 +3244,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 
 done:
 	adapter->auth = auth;
-	return 0;
+	return auth->id;
 }
 
 int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
@@ -3260,49 +3263,59 @@ int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 	}
 
 	for (l = manager_get_adapters(); l != NULL; l = g_slist_next(l)) {
-		int err;
+		int id;
 
 		adapter = l->data;
 
-		err = adapter_authorize(adapter, dst, uuid, cb, user_data);
-		if (err == 0)
-			return 0;
+		id = adapter_authorize(adapter, dst, uuid, cb, user_data);
+		if (id >= 0)
+			return id;
 	}
 
 	return -EPERM;
 }
 
-int btd_cancel_authorization(const bdaddr_t *src, const bdaddr_t *dst)
+static struct btd_adapter *find_authorization(int id)
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
+int btd_cancel_authorization(int id)
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
index 9f840e8..39add98 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -150,7 +150,7 @@ int btd_register_adapter_driver(struct btd_adapter_driver *driver);
 void btd_unregister_adapter_driver(struct btd_adapter_driver *driver);
 int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 		const char *uuid, service_auth_cb cb, void *user_data);
-int btd_cancel_authorization(const bdaddr_t *src, const bdaddr_t *dst);
+int btd_cancel_authorization(int id);
 
 const char *adapter_any_get_path(void);
 
diff --git a/src/profile.c b/src/profile.c
index ad2ad4a..c7fedef 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -72,7 +72,7 @@ struct ext_io {
 	GIOChannel *io;
 	guint io_id;
 
-	bool authorizing;
+	int service_auth_id;
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
+	if (ext_io->service_auth_id > 0)
+		btd_cancel_authorization(ext_io->service_auth_id);
 
 	if (ext_io->new_conn) {
 		dbus_pending_call_cancel(ext_io->new_conn);
@@ -318,7 +312,7 @@ static void ext_auth(DBusError *err, void *user_data)
 	GError *gerr = NULL;
 	char addr[18];
 
-	conn->authorizing = false;
+	conn->service_auth_id = 0;
 
 	bt_io_get(conn->io, &gerr, BT_IO_OPT_DEST, addr, BT_IO_OPT_INVALID);
 	if (gerr != NULL) {
@@ -372,7 +366,7 @@ static void ext_confirm(GIOChannel *io, gpointer user_data)
 	GError *gerr = NULL;
 	bdaddr_t src, dst;
 	char addr[18];
-	int err;
+	int ret;
 
 	bt_io_get(io, &gerr,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
@@ -390,15 +384,15 @@ static void ext_confirm(GIOChannel *io, gpointer user_data)
 
 	conn = create_conn(server, io);
 
-	err = btd_request_authorization(&src, &dst, ext->uuid, ext_auth, conn);
-	if (err < 0) {
+	ret = btd_request_authorization(&src, &dst, ext->uuid, ext_auth, conn);
+	if (ret < 0) {
 		error("%s authorization failure: %s", ext->name,
-							strerror(-err));
+							strerror(-ret));
 		ext_io_destroy(conn);
 		return;
 	}
 
-	conn->authorizing = true;
+	conn->service_auth_id = ret;
 
 	ext->conns = g_slist_append(ext->conns, conn);
 
-- 
1.7.11.4

