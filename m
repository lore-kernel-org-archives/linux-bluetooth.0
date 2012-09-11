Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 2/4] adapter: Use authorization id for cancelling
Date: Tue, 11 Sep 2012 15:55:28 +0200
Message-Id: <1347371730-14933-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347371730-14933-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347371730-14933-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Return a request id in btd_request_authorization() in order to be used
when the request needs to be cancelled. This id alone will be enough to
use btd_cancel_authorization().
---
 audio/device.c          |   12 +++++++--
 plugins/service.c       |   18 ++++++++-----
 profiles/input/server.c |    2 +-
 src/adapter.c           |   62 +++++++++++++++++++++++++++++++----------------
 src/adapter.h           |    2 +-
 5 files changed, 63 insertions(+), 33 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index 4952b57..ca64f14 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -83,6 +83,7 @@ struct dev_priv {
 	sink_state_t sink_state;
 	avctp_state_t avctp_state;
 	GSList *auths;
+	int auth_id;
 
 	DBusMessage *conn_req;
 	DBusMessage *dc_req;
@@ -741,6 +742,8 @@ static void auth_cb(DBusError *derr, void *user_data)
 	struct audio_device *dev = user_data;
 	struct dev_priv *priv = dev->priv;
 
+	priv->auth_id = 0;
+
 	if (derr == NULL)
 		priv->authorized = TRUE;
 
@@ -824,7 +827,8 @@ int audio_device_request_authorization(struct audio_device *dev,
 	if (err < 0) {
 		priv->auths = g_slist_remove(priv->auths, auth);
 		g_free(auth);
-	}
+	} else
+		priv->auth_id = err;
 
 	return err;
 }
@@ -854,8 +858,10 @@ int audio_device_cancel_authorization(struct audio_device *dev,
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
index f16abe7..506a0cd 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -67,6 +67,7 @@ struct pending_auth {
 	char *sender;
 	bdaddr_t dst;
 	char uuid[MAX_LEN_UUID_STR];
+	int auth_id;
 };
 
 struct service_adapter {
@@ -560,8 +561,9 @@ done:
 	else
 		bacpy(&src, BDADDR_ANY);
 
-	btd_request_authorization(&src, &auth->dst,
-					auth->uuid, auth_cb, serv_adapter);
+	auth->auth_id = btd_request_authorization(&src, &auth->dst,
+							auth->uuid, auth_cb,
+							serv_adapter);
 }
 
 static DBusMessage *request_authorization(DBusConnection *conn,
@@ -637,8 +639,9 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 	else
 		bacpy(&src, BDADDR_ANY);
 
-	if (btd_request_authorization(&src, &auth->dst, auth->uuid, auth_cb,
-							serv_adapter) < 0) {
+	auth->auth_id = btd_request_authorization(&src, &auth->dst, auth->uuid,
+							auth_cb, serv_adapter);
+	if (auth->auth_id < 0) {
 		serv_adapter->pending_list = g_slist_remove(serv_adapter->pending_list,
 									auth);
 		g_free(auth);
@@ -668,7 +671,7 @@ static DBusMessage *cancel_authorization(DBusConnection *conn,
 	else
 		bacpy(&src, BDADDR_ANY);
 
-	btd_cancel_authorization(&src, &auth->dst);
+	btd_cancel_authorization(auth->auth_id);
 
 	reply = btd_error_not_authorized(auth->msg);
 	dbus_message_unref(auth->msg);
@@ -689,8 +692,9 @@ static DBusMessage *cancel_authorization(DBusConnection *conn,
 	else
 		bacpy(&src, BDADDR_ANY);
 
-	btd_request_authorization(&src, &auth->dst,
-					auth->uuid, auth_cb, serv_adapter);
+	auth->auth_id = btd_request_authorization(&src, &auth->dst,
+							auth->uuid, auth_cb,
+							serv_adapter);
 
 done:
 	return dbus_message_new_method_return(msg);
diff --git a/profiles/input/server.c b/profiles/input/server.c
index 0464c4a..0385012 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -175,7 +175,7 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 
 	ret = btd_request_authorization(&src, &dst, HID_UUID,
 					auth_callback, server);
-	if (ret == 0)
+	if (ret >= 0)
 		return;
 
 	ba2str(&src, addr);
diff --git a/src/adapter.c b/src/adapter.c
index 14c5322..de5d1c9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -85,6 +85,8 @@
 
 static DBusConnection *connection = NULL;
 static GSList *adapter_drivers = NULL;
+static int service_auth_id = 0;
+static GHashTable *service_auths = NULL;
 
 struct session_req {
 	struct btd_adapter	*adapter;
@@ -98,6 +100,7 @@ struct session_req {
 };
 
 struct service_auth {
+	int id;
 	service_auth_cb cb;
 	void *user_data;
 	struct btd_device *device;
@@ -208,6 +211,15 @@ static uint8_t get_mode(const bdaddr_t *bdaddr, const char *mode)
 		return MODE_UNKNOWN;
 }
 
+static void service_auth_free(gpointer data)
+{
+	struct service_auth *auth = data;
+
+	g_hash_table_remove(service_auths, GUINT_TO_POINTER(auth->id));
+
+	g_free(auth);
+}
+
 static struct session_req *session_ref(struct session_req *req)
 {
 	req->refcount++;
@@ -2415,7 +2427,7 @@ static void adapter_free(gpointer user_data)
 		g_source_remove(adapter->auth_idle_id);
 
 	if (adapter->auth)
-		g_free(adapter->auth);
+		service_auth_free(adapter->auth);
 
 	if (adapter->off_timer)
 		off_timer_remove(adapter);
@@ -2429,6 +2441,8 @@ static void adapter_free(gpointer user_data)
 	g_free(adapter->path);
 	g_free(adapter->name);
 	g_free(adapter);
+
+	g_hash_table_unref(service_auths);
 }
 
 struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter)
@@ -2523,6 +2537,11 @@ struct btd_adapter *adapter_create(DBusConnection *conn, int id)
 		return NULL;
 	}
 
+	if (!service_auths)
+		service_auths = g_hash_table_new(g_direct_hash, g_direct_equal);
+	else
+		g_hash_table_ref(service_auths);
+
 	return btd_adapter_ref(adapter);
 }
 
@@ -3160,7 +3179,7 @@ static void agent_auth_cb(struct agent *agent, DBusError *derr,
 
 	auth->cb(derr, auth->user_data);
 
-	g_free(auth);
+	service_auth_free(auth);
 }
 
 static gboolean auth_idle_cb(gpointer user_data)
@@ -3207,6 +3226,9 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	auth->user_data = user_data;
 	auth->device = device;
 	auth->adapter = adapter;
+	auth->id = service_auth_id++;
+
+	g_hash_table_insert(service_auths, GUINT_TO_POINTER(auth->id), auth);
 
 	if (device_is_trusted(device) == TRUE) {
 		adapter->auth_idle_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
@@ -3218,7 +3240,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	agent = device_get_agent(device);
 	if (!agent) {
 		warn("Can't find device agent");
-		g_free(auth);
+		service_auth_free(auth);
 		return -EPERM;
 	}
 
@@ -3227,13 +3249,13 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	err = agent_authorize(agent, dev_path, uuid, agent_auth_cb, adapter,
 									NULL);
 	if (err < 0) {
-		g_free(auth);
+		service_auth_free(auth);
 		return err;
 	}
 
 done:
 	adapter->auth = auth;
-	return 0;
+	return auth->id;
 }
 
 int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
@@ -3252,49 +3274,47 @@ int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 	}
 
 	for (l = manager_get_adapters(); l != NULL; l = g_slist_next(l)) {
-		int err;
+		int auth_id;
 
 		adapter = l->data;
 
-		err = adapter_authorize(adapter, dst, uuid, cb, user_data);
-		if (err == 0)
-			return 0;
+		auth_id = adapter_authorize(adapter, dst, uuid, cb, user_data);
+		if (auth_id >= 0)
+			return auth_id;
 	}
 
 	return -EPERM;
 }
 
-int btd_cancel_authorization(const bdaddr_t *src, const bdaddr_t *dst)
+int btd_cancel_authorization(int auth_id)
 {
-	struct btd_adapter *adapter = manager_find_adapter(src);
-	struct btd_device *device;
+	struct service_auth *auth;
+	struct btd_adapter *adapter;
 	struct agent *agent;
-	char address[18];
 	int err;
 
-	if (!adapter)
+	if (!service_auths)
 		return -EPERM;
 
-	ba2str(dst, address);
-	device = adapter_find_device(adapter, address);
-	if (!device)
+	auth = g_hash_table_lookup(service_auths, GUINT_TO_POINTER(auth_id));
+	if (!auth)
 		return -EPERM;
 
+	adapter = auth->adapter;
+
 	if (adapter->auth_idle_id) {
 		g_source_remove(adapter->auth_idle_id);
 		adapter->auth_idle_id = 0;
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
+	agent = device_get_agent(auth->device);
 	if (!agent)
 		return -EPERM;
 
diff --git a/src/adapter.h b/src/adapter.h
index cd37b15..2993715 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -149,7 +149,7 @@ int btd_register_adapter_driver(struct btd_adapter_driver *driver);
 void btd_unregister_adapter_driver(struct btd_adapter_driver *driver);
 int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 		const char *uuid, service_auth_cb cb, void *user_data);
-int btd_cancel_authorization(const bdaddr_t *src, const bdaddr_t *dst);
+int btd_cancel_authorization(int auth_id);
 
 const char *adapter_any_get_path(void);
 
-- 
1.7.7.6

