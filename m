Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 11/17] health: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:13 +0200
Message-ID: <1348050139-27883-12-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes redundant references and function parameters for
DBusConnection object and uses btd_get_dbus_connection() call wherever
such object is needed instead.

Pointer returned by this call is guaranteed to be valid for entire
bluetoothd lifetime and thus do not need to be refcounted.
---
 profiles/health/hdp.c         | 167 ++++++++++++++++++++----------------------
 profiles/health/hdp.h         |   6 +-
 profiles/health/hdp_main.c    |  16 +---
 profiles/health/hdp_manager.c |  15 +---
 profiles/health/hdp_manager.h |   2 +-
 profiles/health/hdp_types.h   |   2 -
 profiles/health/hdp_util.c    |   6 +-
 7 files changed, 91 insertions(+), 123 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 489e1eb..d262a2a 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -46,8 +46,6 @@
 #define ECHO_TIMEOUT	1 /* second */
 #define HDP_ECHO_LEN	15
 
-static DBusConnection *connection = NULL;
-
 static GSList *applications = NULL;
 static GSList *devices = NULL;
 static uint8_t next_app_id = HDP_MDEP_INITIAL;
@@ -55,12 +53,10 @@ static uint8_t next_app_id = HDP_MDEP_INITIAL;
 static GSList *adapters;
 
 static gboolean update_adapter(struct hdp_adapter *adapter);
-static struct hdp_device *create_health_device(DBusConnection *conn,
-						struct btd_device *device);
+static struct hdp_device *create_health_device(struct btd_device *device);
 static void free_echo_data(struct hdp_echo_data *edata);
 
 struct hdp_create_dc {
-	DBusConnection			*conn;
 	DBusMessage			*msg;
 	struct hdp_application		*app;
 	struct hdp_device		*dev;
@@ -71,7 +67,6 @@ struct hdp_create_dc {
 };
 
 struct hdp_tmp_dc_data {
-	DBusConnection			*conn;
 	DBusMessage			*msg;
 	struct hdp_channel		*hdp_chann;
 	guint				ref;
@@ -126,7 +121,6 @@ static void hdp_channel_unref(struct hdp_channel *chan)
 static void free_hdp_create_dc(struct hdp_create_dc *dc_data)
 {
 	dbus_message_unref(dc_data->msg);
-	dbus_connection_unref(dc_data->conn);
 	hdp_application_unref(dc_data->app);
 	health_device_unref(dc_data->dev);
 
@@ -157,7 +151,6 @@ static void hdp_create_data_unref(struct hdp_create_dc *dc_data)
 static void free_hdp_conn_dc(struct hdp_tmp_dc_data *data)
 {
 	dbus_message_unref(data->msg);
-	dbus_connection_unref(data->conn);
 	hdp_channel_unref(data->hdp_chann);
 
 	g_free(data);
@@ -305,11 +298,6 @@ static void device_unref_mcl(struct hdp_device *hdp_device)
 
 static void free_health_device(struct hdp_device *device)
 {
-	if (device->conn != NULL) {
-		dbus_connection_unref(device->conn);
-		device->conn = NULL;
-	}
-
 	if (device->dev != NULL) {
 		btd_device_unref(device->dev);
 		device->dev = NULL;
@@ -370,12 +358,12 @@ static DBusMessage *manager_create_application(DBusConnection *conn,
 	}
 
 	app->oname = g_strdup(name);
-	app->conn = dbus_connection_ref(conn);
 
 	applications = g_slist_prepend(applications, app);
 
-	app->dbus_watcher = g_dbus_add_disconnect_watch(conn, name,
-						client_disconnected, app, NULL);
+	app->dbus_watcher =
+			g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
+					name, client_disconnected, app, NULL);
 	g_slist_foreach(adapters, (GFunc) update_adapter, NULL);
 
 	DBG("Health application created with id %s", app->path);
@@ -487,6 +475,7 @@ static void abort_mdl_cb(GError *err, gpointer data)
 
 static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct hdp_tmp_dc_data *dc_data = data;
 	DBusMessage *reply;
 	int fd;
@@ -499,7 +488,7 @@ static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 		reply = g_dbus_create_error(dc_data->msg,
 					ERROR_INTERFACE ".HealthError",
 					"Cannot reconnect: %s", err->message);
-		g_dbus_send_message(dc_data->conn, reply);
+		g_dbus_send_message(conn, reply);
 
 		/* Send abort request because remote side */
 		/* is now in PENDING state */
@@ -516,16 +505,15 @@ static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 		reply = g_dbus_create_error(dc_data->msg,
 						ERROR_INTERFACE ".HealthError",
 						"Cannot get file descriptor");
-		g_dbus_send_message(dc_data->conn, reply);
+		g_dbus_send_message(conn, reply);
 		return;
 	}
 
 	reply = g_dbus_create_reply(dc_data->msg, DBUS_TYPE_UNIX_FD,
 							&fd, DBUS_TYPE_INVALID);
-	g_dbus_send_message(dc_data->conn, reply);
+	g_dbus_send_message(conn, reply);
 
-	g_dbus_emit_signal(dc_data->conn,
-			device_get_path(dc_data->hdp_chann->dev->dev),
+	g_dbus_emit_signal(conn, device_get_path(dc_data->hdp_chann->dev->dev),
 			HEALTH_DEVICE, "ChannelConnected",
 			DBUS_TYPE_OBJECT_PATH, &dc_data->hdp_chann->path,
 			DBUS_TYPE_INVALID);
@@ -561,6 +549,7 @@ static void hdp_get_dcpsm_cb(uint16_t dcpsm, gpointer user_data, GError *err)
 static void device_reconnect_mdl_cb(struct mcap_mdl *mdl, GError *err,
 								gpointer data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct hdp_tmp_dc_data *dc_data = data;
 	GError *gerr = NULL;
 	DBusMessage *reply;
@@ -569,7 +558,7 @@ static void device_reconnect_mdl_cb(struct mcap_mdl *mdl, GError *err,
 		reply = g_dbus_create_error(dc_data->msg,
 					ERROR_INTERFACE ".HealthError",
 					"Cannot reconnect: %s", err->message);
-		g_dbus_send_message(dc_data->conn, reply);
+		g_dbus_send_message(conn, reply);
 		return;
 	}
 
@@ -585,7 +574,7 @@ static void device_reconnect_mdl_cb(struct mcap_mdl *mdl, GError *err,
 	reply = g_dbus_create_error(dc_data->msg,
 					ERROR_INTERFACE ".HealthError",
 					"Cannot reconnect: %s", gerr->message);
-	g_dbus_send_message(dc_data->conn, reply);
+	g_dbus_send_message(conn, reply);
 	hdp_tmp_dc_data_unref(dc_data);
 	g_error_free(gerr);
 
@@ -629,13 +618,12 @@ static DBusMessage *channel_acquire_continue(struct hdp_tmp_dc_data *data,
 
 static void channel_acquire_cb(gpointer data, GError *err)
 {
-	struct hdp_tmp_dc_data *dc_data = data;
 	DBusMessage *reply;
 
 	reply = channel_acquire_continue(data, err);
 
 	if (reply != NULL)
-		g_dbus_send_message(dc_data->conn, reply);
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
 }
 
 static DBusMessage *channel_acquire(DBusConnection *conn,
@@ -647,7 +635,6 @@ static DBusMessage *channel_acquire(DBusConnection *conn,
 	DBusMessage *reply;
 
 	dc_data = g_new0(struct hdp_tmp_dc_data, 1);
-	dc_data->conn = dbus_connection_ref(conn);
 	dc_data->msg = dbus_message_ref(msg);
 	dc_data->hdp_chann = hdp_channel_ref(chan);
 
@@ -719,7 +706,8 @@ static void health_channel_destroy(void *data)
 	dev->channels = g_slist_remove(dev->channels, hdp_chan);
 
 	if (hdp_chan->mdep != HDP_MDEP_ECHO)
-		g_dbus_emit_signal(dev->conn, device_get_path(dev->dev),
+		g_dbus_emit_signal(btd_get_dbus_connection(),
+					device_get_path(dev->dev),
 					HEALTH_DEVICE, "ChannelDeleted",
 					DBUS_TYPE_OBJECT_PATH, &hdp_chan->path,
 					DBUS_TYPE_INVALID);
@@ -780,8 +768,8 @@ static struct hdp_channel *create_channel(struct hdp_device *dev,
 	if (hdp_chann->mdep == HDP_MDEP_ECHO)
 		return hdp_channel_ref(hdp_chann);
 
-	if (!g_dbus_register_interface(dev->conn, hdp_chann->path,
-					HEALTH_CHANNEL,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					hdp_chann->path, HEALTH_CHANNEL,
 					health_channels_methods, NULL, NULL,
 					hdp_chann, health_channel_destroy)) {
 		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
@@ -802,8 +790,8 @@ static void remove_channels(struct hdp_device *dev)
 		chan = dev->channels->data;
 
 		path = g_strdup(chan->path);
-		if (!g_dbus_unregister_interface(dev->conn, path,
-								HEALTH_CHANNEL))
+		if (!g_dbus_unregister_interface(btd_get_dbus_connection(),
+							path, HEALTH_CHANNEL))
 			health_channel_destroy(chan);
 		g_free(path);
 	}
@@ -827,7 +815,8 @@ static void close_device_con(struct hdp_device *dev, gboolean cache)
 		const char *path;
 
 		path = device_get_path(dev->dev);
-		g_dbus_unregister_interface(dev->conn, path, HEALTH_DEVICE);
+		g_dbus_unregister_interface(btd_get_dbus_connection(),
+							path, HEALTH_DEVICE);
 	}
 }
 
@@ -967,10 +956,10 @@ static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 		goto end;
 	}
 
-	g_dbus_emit_signal(dev->conn, device_get_path(dev->dev), HEALTH_DEVICE,
-					"ChannelConnected",
-					DBUS_TYPE_OBJECT_PATH, &chan->path,
-					DBUS_TYPE_INVALID);
+	g_dbus_emit_signal(btd_get_dbus_connection(), device_get_path(dev->dev),
+				HEALTH_DEVICE, "ChannelConnected",
+				DBUS_TYPE_OBJECT_PATH, &chan->path,
+				DBUS_TYPE_INVALID);
 
 	if (dev->fr != NULL)
 		goto end;
@@ -1010,7 +999,8 @@ static void hdp_mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 	chan = l->data;
 
 	path = g_strdup(chan->path);
-	if (!g_dbus_unregister_interface(dev->conn, path, HEALTH_CHANNEL))
+	if (!g_dbus_unregister_interface(btd_get_dbus_connection(),
+							path, HEALTH_CHANNEL))
 		health_channel_destroy(chan);
 	g_free(path);
 }
@@ -1030,7 +1020,8 @@ static void hdp_mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 						hdp_channel_ref(dev->ndc));
 
 	if (dev->ndc->mdep != HDP_MDEP_ECHO)
-		g_dbus_emit_signal(dev->conn, device_get_path(dev->dev),
+		g_dbus_emit_signal(btd_get_dbus_connection(),
+					device_get_path(dev->dev),
 					HEALTH_DEVICE, "ChannelConnected",
 					DBUS_TYPE_OBJECT_PATH, &dev->ndc->path,
 					DBUS_TYPE_INVALID);
@@ -1123,7 +1114,8 @@ static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 		char *path;
 
 		path = g_strdup(chan->path);
-		g_dbus_unregister_interface(dev->conn, path, HEALTH_CHANNEL);
+		g_dbus_unregister_interface(btd_get_dbus_connection(),
+							path, HEALTH_CHANNEL);
 		g_free(path);
 	}
 
@@ -1212,7 +1204,7 @@ static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 		device = adapter_get_device(hdp_adapter->btd_adapter, str);
 		if (!device)
 			return;
-		hdp_device = create_health_device(connection, device);
+		hdp_device = create_health_device(device);
 		if (!hdp_device)
 			return;
 		devices = g_slist_append(devices, hdp_device);
@@ -1280,7 +1272,8 @@ static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
 	/* be removed. Then we have to remove the HealthDevice */
 	/* interface manually */
 	path = device_get_path(hdp_device->dev);
-	g_dbus_unregister_interface(hdp_device->conn, path, HEALTH_DEVICE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+							path, HEALTH_DEVICE);
 	DBG("Mcl uncached %s", path);
 }
 
@@ -1303,7 +1296,8 @@ static void check_devices_mcl(void)
 		const char *path;
 
 		path = device_get_path(dev->dev);
-		g_dbus_unregister_interface(dev->conn, path, HEALTH_DEVICE);
+		g_dbus_unregister_interface(btd_get_dbus_connection(),
+							path, HEALTH_DEVICE);
 	}
 
 	g_slist_free(to_delete);
@@ -1371,7 +1365,7 @@ fail:
 	return FALSE;
 }
 
-int hdp_adapter_register(DBusConnection *conn, struct btd_adapter *adapter)
+int hdp_adapter_register(struct btd_adapter *adapter)
 {
 	struct hdp_adapter *hdp_adapter;
 
@@ -1511,7 +1505,7 @@ static gboolean check_echo(GIOChannel *io_chan, GIOCondition cond,
 end:
 	reply = g_dbus_create_reply(hdp_conn->msg, DBUS_TYPE_BOOLEAN, &value,
 							DBUS_TYPE_INVALID);
-	g_dbus_send_message(hdp_conn->conn, reply);
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 	g_source_remove(edata->tid);
 	edata->tid = 0;
 	g_free(edata->buf);
@@ -1548,6 +1542,7 @@ static gboolean echo_timeout(gpointer data)
 static void hdp_echo_connect_cb(struct mcap_mdl *mdl, GError *err,
 								gpointer data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct hdp_tmp_dc_data *hdp_conn =  data;
 	struct hdp_echo_data *edata;
 	GError *gerr = NULL;
@@ -1559,7 +1554,7 @@ static void hdp_echo_connect_cb(struct mcap_mdl *mdl, GError *err,
 		reply = g_dbus_create_error(hdp_conn->msg,
 						ERROR_INTERFACE ".HealthError",
 						"%s", err->message);
-		g_dbus_send_message(hdp_conn->conn, reply);
+		g_dbus_send_message(conn, reply);
 
 		/* Send abort request because remote */
 		/* side is now in PENDING state. */
@@ -1580,7 +1575,7 @@ static void hdp_echo_connect_cb(struct mcap_mdl *mdl, GError *err,
 		reply = g_dbus_create_error(hdp_conn->msg,
 						ERROR_INTERFACE ".HealthError",
 						"Can't write in echo channel");
-		g_dbus_send_message(hdp_conn->conn, reply);
+		g_dbus_send_message(conn, reply);
 		delete_echo_channel(hdp_conn->hdp_chann);
 		return;
 	}
@@ -1638,16 +1633,16 @@ static void abort_mdl_connection_cb(GError *err, gpointer data)
 	/* Connection operation has failed but we have to */
 	/* notify the channel created at MCAP level */
 	if (hdp_chann->mdep != HDP_MDEP_ECHO)
-		g_dbus_emit_signal(hdp_conn->conn,
+		g_dbus_emit_signal(btd_get_dbus_connection(),
 					device_get_path(hdp_chann->dev->dev),
-					HEALTH_DEVICE,
-					"ChannelConnected",
+					HEALTH_DEVICE, "ChannelConnected",
 					DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
 					DBUS_TYPE_INVALID);
 }
 
 static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct hdp_tmp_dc_data *hdp_conn =  data;
 	struct hdp_channel *hdp_chann = hdp_conn->hdp_chann;
 	struct hdp_device *dev = hdp_chann->dev;
@@ -1659,7 +1654,7 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 		reply = g_dbus_create_reply(hdp_conn->msg,
 					DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
 					DBUS_TYPE_INVALID);
-		g_dbus_send_message(hdp_conn->conn, reply);
+		g_dbus_send_message(conn, reply);
 
 		/* Send abort request because remote side */
 		/* is now in PENDING state */
@@ -1676,14 +1671,12 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 	reply = g_dbus_create_reply(hdp_conn->msg,
 					DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
 					DBUS_TYPE_INVALID);
-	g_dbus_send_message(hdp_conn->conn, reply);
+	g_dbus_send_message(conn, reply);
 
-	g_dbus_emit_signal(hdp_conn->conn,
-					device_get_path(hdp_chann->dev->dev),
-					HEALTH_DEVICE,
-					"ChannelConnected",
-					DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
-					DBUS_TYPE_INVALID);
+	g_dbus_emit_signal(conn, device_get_path(hdp_chann->dev->dev),
+				HEALTH_DEVICE, "ChannelConnected",
+				DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
+				DBUS_TYPE_INVALID);
 
 	if (!check_channel_conf(hdp_chann)) {
 		close_mdl(hdp_chann);
@@ -1703,6 +1696,7 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
 						GError *err, gpointer data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct hdp_create_dc *user_data = data;
 	struct hdp_tmp_dc_data *hdp_conn;
 	struct hdp_channel *hdp_chan;
@@ -1713,7 +1707,7 @@ static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
 		reply = g_dbus_create_error(user_data->msg,
 					ERROR_INTERFACE ".HealthError",
 					"%s", err->message);
-		g_dbus_send_message(user_data->conn, reply);
+		g_dbus_send_message(conn, reply);
 		return;
 	}
 
@@ -1741,7 +1735,6 @@ static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
 
 	hdp_conn = g_new0(struct hdp_tmp_dc_data, 1);
 	hdp_conn->msg = dbus_message_ref(user_data->msg);
-	hdp_conn->conn = dbus_connection_ref(user_data->conn);
 	hdp_conn->hdp_chann = hdp_chan;
 	hdp_conn->cb = user_data->cb;
 	hdp_chan->mdep = user_data->mdep;
@@ -1757,7 +1750,7 @@ static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
 	reply = g_dbus_create_reply(hdp_conn->msg,
 					DBUS_TYPE_OBJECT_PATH, &hdp_chan->path,
 					DBUS_TYPE_INVALID);
-	g_dbus_send_message(hdp_conn->conn, reply);
+	g_dbus_send_message(conn, reply);
 	hdp_tmp_dc_data_unref(hdp_conn);
 
 	/* Send abort request because remote side is now in PENDING state */
@@ -1775,7 +1768,7 @@ fail:
 	reply = g_dbus_create_error(user_data->msg,
 						ERROR_INTERFACE ".HealthError",
 						"%s", gerr->message);
-	g_dbus_send_message(user_data->conn, reply);
+	g_dbus_send_message(conn, reply);
 	g_error_free(gerr);
 
 	/* Send abort request because remote side is now in PENDING */
@@ -1791,6 +1784,7 @@ fail:
 
 static void device_create_dc_cb(gpointer user_data, GError *err)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct hdp_create_dc *data = user_data;
 	DBusMessage *reply;
 	GError *gerr = NULL;
@@ -1799,7 +1793,7 @@ static void device_create_dc_cb(gpointer user_data, GError *err)
 		reply = g_dbus_create_error(data->msg,
 					ERROR_INTERFACE ".HealthError",
 					"%s", err->message);
-		g_dbus_send_message(data->conn, reply);
+		g_dbus_send_message(conn, reply);
 		return;
 	}
 
@@ -1821,7 +1815,7 @@ fail:
 	reply = g_dbus_create_error(data->msg, ERROR_INTERFACE ".HealthError",
 							"%s", gerr->message);
 	g_error_free(gerr);
-	g_dbus_send_message(data->conn, reply);
+	g_dbus_send_message(conn, reply);
 }
 
 static DBusMessage *device_echo(DBusConnection *conn,
@@ -1837,7 +1831,6 @@ static DBusMessage *device_echo(DBusConnection *conn,
 	data->mdep = HDP_MDEP_ECHO;
 	data->config = HDP_RELIABLE_DC;
 	data->msg = dbus_message_ref(msg);
-	data->conn = dbus_connection_ref(conn);
 	data->cb = hdp_echo_connect_cb;
 	hdp_create_data_ref(data);
 
@@ -1863,6 +1856,7 @@ fail:
 
 static void device_get_mdep_cb(uint8_t mdep, gpointer data, GError *err)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct hdp_create_dc *dc_data, *user_data = data;
 	DBusMessage *reply;
 	GError *gerr = NULL;
@@ -1871,7 +1865,7 @@ static void device_get_mdep_cb(uint8_t mdep, gpointer data, GError *err)
 		reply = g_dbus_create_error(user_data->msg,
 						ERROR_INTERFACE ".HealthError",
 						"%s", err->message);
-		g_dbus_send_message(user_data->conn, reply);
+		g_dbus_send_message(conn, reply);
 		return;
 	}
 
@@ -1893,7 +1887,7 @@ static void device_get_mdep_cb(uint8_t mdep, gpointer data, GError *err)
 						"%s", gerr->message);
 	hdp_create_data_unref(dc_data);
 	g_error_free(gerr);
-	g_dbus_send_message(user_data->conn, reply);
+	g_dbus_send_message(conn, reply);
 }
 
 static DBusMessage *device_create_channel(DBusConnection *conn,
@@ -1942,7 +1936,6 @@ static DBusMessage *device_create_channel(DBusConnection *conn,
 	data->config = config;
 	data->app = hdp_application_ref(app);
 	data->msg = dbus_message_ref(msg);
-	data->conn = dbus_connection_ref(conn);
 	data->cb = hdp_mdl_conn_cb;
 
 	if (hdp_get_mdep(device, l->data, device_get_mdep_cb,
@@ -1959,6 +1952,7 @@ static DBusMessage *device_create_channel(DBusConnection *conn,
 
 static void hdp_mdl_delete_cb(GError *err, gpointer data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct hdp_tmp_dc_data *del_data = data;
 	DBusMessage *reply;
 	char *path;
@@ -1967,20 +1961,21 @@ static void hdp_mdl_delete_cb(GError *err, gpointer data)
 		reply = g_dbus_create_error(del_data->msg,
 						ERROR_INTERFACE ".HealthError",
 						"%s", err->message);
-		g_dbus_send_message(del_data->conn, reply);
+		g_dbus_send_message(conn, reply);
 		return;
 	}
 
 	path = g_strdup(del_data->hdp_chann->path);
-	g_dbus_unregister_interface(del_data->conn, path, HEALTH_CHANNEL);
+	g_dbus_unregister_interface(conn, path, HEALTH_CHANNEL);
 	g_free(path);
 
 	reply = g_dbus_create_reply(del_data->msg, DBUS_TYPE_INVALID);
-	g_dbus_send_message(del_data->conn, reply);
+	g_dbus_send_message(conn, reply);
 }
 
 static void hdp_continue_del_cb(gpointer user_data, GError *err)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct hdp_tmp_dc_data *del_data = user_data;
 	GError *gerr = NULL;
 	DBusMessage *reply;
@@ -1989,7 +1984,7 @@ static void hdp_continue_del_cb(gpointer user_data, GError *err)
 		reply = g_dbus_create_error(del_data->msg,
 					ERROR_INTERFACE ".HealthError",
 					"%s", err->message);
-		g_dbus_send_message(del_data->conn, reply);
+		g_dbus_send_message(conn, reply);
 		return;
 	}
 
@@ -2003,7 +1998,7 @@ static void hdp_continue_del_cb(gpointer user_data, GError *err)
 						"%s", gerr->message);
 	hdp_tmp_dc_data_unref(del_data);
 	g_error_free(gerr);
-	g_dbus_send_message(del_data->conn, reply);
+	g_dbus_send_message(conn, reply);
 }
 
 static DBusMessage *device_destroy_channel(DBusConnection *conn,
@@ -2029,7 +2024,6 @@ static DBusMessage *device_destroy_channel(DBusConnection *conn,
 	hdp_chan = l->data;
 	del_data = g_new0(struct hdp_tmp_dc_data, 1);
 	del_data->msg = dbus_message_ref(msg);
-	del_data->conn = dbus_connection_ref(conn);
 	del_data->hdp_chann = hdp_channel_ref(hdp_chan);
 
 	if (device->mcl_conn) {
@@ -2124,8 +2118,7 @@ static const GDBusSignalTable health_device_signals[] = {
 	{ }
 };
 
-static struct hdp_device *create_health_device(DBusConnection *conn,
-						struct btd_device *device)
+static struct hdp_device *create_health_device(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	const gchar *path = device_get_path(device);
@@ -2136,7 +2129,6 @@ static struct hdp_device *create_health_device(DBusConnection *conn,
 		return NULL;
 
 	dev = g_new0(struct hdp_device, 1);
-	dev->conn = dbus_connection_ref(conn);
 	dev->dev = btd_device_ref(device);
 	health_device_ref(dev);
 
@@ -2146,8 +2138,8 @@ static struct hdp_device *create_health_device(DBusConnection *conn,
 
 	dev->hdp_adapter = l->data;
 
-	if (!g_dbus_register_interface(conn, path,
-					HEALTH_DEVICE,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					path, HEALTH_DEVICE,
 					health_device_methods,
 					health_device_signals, NULL,
 					dev, health_device_destroy)) {
@@ -2163,7 +2155,7 @@ fail:
 	return NULL;
 }
 
-int hdp_device_register(DBusConnection *conn, struct btd_device *device)
+int hdp_device_register(struct btd_device *device)
 {
 	struct hdp_device *hdev;
 	GSList *l;
@@ -2175,7 +2167,7 @@ int hdp_device_register(DBusConnection *conn, struct btd_device *device)
 		return 0;
 	}
 
-	hdev = create_health_device(conn, device);
+	hdev = create_health_device(device);
 	if (hdev == NULL)
 		return -1;
 
@@ -2197,31 +2189,30 @@ void hdp_device_unregister(struct btd_device *device)
 
 	hdp_dev = l->data;
 	path = device_get_path(hdp_dev->dev);
-	g_dbus_unregister_interface(hdp_dev->conn, path, HEALTH_DEVICE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+							path, HEALTH_DEVICE);
 }
 
-int hdp_manager_start(DBusConnection *conn)
+int hdp_manager_start(void)
 {
 	DBG("Starting Health manager");
 
-	if (!g_dbus_register_interface(conn, MANAGER_PATH,
-					HEALTH_MANAGER,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					MANAGER_PATH, HEALTH_MANAGER,
 					health_manager_methods, NULL, NULL,
 					NULL, manager_path_unregister)) {
 		error("D-Bus failed to register %s interface", HEALTH_MANAGER);
 		return -1;
 	}
 
-	connection = dbus_connection_ref(conn);
-
 	return 0;
 }
 
 void hdp_manager_stop(void)
 {
-	g_dbus_unregister_interface(connection, MANAGER_PATH, HEALTH_MANAGER);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						MANAGER_PATH, HEALTH_MANAGER);
 
-	dbus_connection_unref(connection);
 	DBG("Stopped Health manager");
 }
 
diff --git a/profiles/health/hdp.h b/profiles/health/hdp.h
index 39f0441..6e78b09 100644
--- a/profiles/health/hdp.h
+++ b/profiles/health/hdp.h
@@ -20,13 +20,13 @@
  *
  */
 
-int hdp_adapter_register(DBusConnection *conn, struct btd_adapter *btd_adapter);
+int hdp_adapter_register(struct btd_adapter *btd_adapter);
 void hdp_adapter_unregister(struct btd_adapter *btd_adapter);
 
-int hdp_device_register(DBusConnection *conn, struct btd_device *device);
+int hdp_device_register(struct btd_device *device);
 void hdp_device_unregister(struct btd_device *device);
 
-int hdp_manager_start(DBusConnection *conn);
+int hdp_manager_start(void);
 void hdp_manager_stop(void);
 
 gboolean hdp_set_mcl_cb(struct hdp_device *device, GError **err);
diff --git a/profiles/health/hdp_main.c b/profiles/health/hdp_main.c
index 9367e73..1d38bea 100644
--- a/profiles/health/hdp_main.c
+++ b/profiles/health/hdp_main.c
@@ -31,28 +31,14 @@
 #include "plugin.h"
 #include "hdp_manager.h"
 
-static DBusConnection *connection = NULL;
-
 static int hdp_init(void)
 {
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
-		return -EIO;
-
-	if (hdp_manager_init(connection) < 0) {
-		dbus_connection_unref(connection);
-		return -EIO;
-	}
-
-	return 0;
+	return hdp_manager_init();
 }
 
 static void hdp_exit(void)
 {
 	hdp_manager_exit();
-
-	dbus_connection_unref(connection);
-	connection = NULL;
 }
 
 BLUETOOTH_PLUGIN_DEFINE(health, VERSION,
diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.c
index 1f899dc..740fe3a 100644
--- a/profiles/health/hdp_manager.c
+++ b/profiles/health/hdp_manager.c
@@ -42,11 +42,9 @@
 #include "hdp_manager.h"
 #include "hdp.h"
 
-static DBusConnection *connection = NULL;
-
 static int hdp_adapter_probe(struct btd_adapter *adapter)
 {
-	return hdp_adapter_register(connection, adapter);
+	return hdp_adapter_register(adapter);
 }
 
 static void hdp_adapter_remove(struct btd_adapter *adapter)
@@ -56,7 +54,7 @@ static void hdp_adapter_remove(struct btd_adapter *adapter)
 
 static int hdp_driver_probe(struct btd_device *device, GSList *uuids)
 {
-	return hdp_device_register(connection, device);
+	return hdp_device_register(device);
 }
 
 static void hdp_driver_remove(struct btd_device *device)
@@ -75,13 +73,11 @@ static struct btd_profile hdp_profile = {
 	.adapter_remove	= hdp_adapter_remove,
 };
 
-int hdp_manager_init(DBusConnection *conn)
+int hdp_manager_init(void)
 {
-	if (hdp_manager_start(conn) < 0)
+	if (hdp_manager_start() < 0)
 		return -1;
 
-	connection = dbus_connection_ref(conn);
-
 	btd_profile_register(&hdp_profile);
 
 	return 0;
@@ -92,7 +88,4 @@ void hdp_manager_exit(void)
 	btd_profile_unregister(&hdp_profile);
 
 	hdp_manager_stop();
-
-	dbus_connection_unref(connection);
-	connection = NULL;
 }
diff --git a/profiles/health/hdp_manager.h b/profiles/health/hdp_manager.h
index d39f190..1cab4d0 100644
--- a/profiles/health/hdp_manager.h
+++ b/profiles/health/hdp_manager.h
@@ -20,5 +20,5 @@
  *
  */
 
-int hdp_manager_init(DBusConnection *conn);
+int hdp_manager_init(void);
 void hdp_manager_exit(void);
diff --git a/profiles/health/hdp_types.h b/profiles/health/hdp_types.h
index 7f8b015..7e4d00f 100644
--- a/profiles/health/hdp_types.h
+++ b/profiles/health/hdp_types.h
@@ -66,7 +66,6 @@ enum data_specs {
 };
 
 struct hdp_application {
-	DBusConnection		*conn;		/* For dbus watcher */
 	char			*path;		/* The path of the application */
 	uint16_t		data_type;	/* Data type handled for this application */
 	gboolean		data_type_set;	/* Flag for dictionary parsing */
@@ -91,7 +90,6 @@ struct hdp_adapter {
 };
 
 struct hdp_device {
-	DBusConnection		*conn;		/* For name listener handling */
 	struct btd_device	*dev;		/* Device reference */
 	struct hdp_adapter	*hdp_adapter;	/* hdp_adapater */
 	struct mcap_mcl		*mcl;		/* The mcap control channel */
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 761e07d..3afd715 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -44,6 +44,7 @@
 
 #include <log.h>
 
+#include "dbus-common.h"
 #include "mcap.h"
 #include "mcap_lib.h"
 #include "hdp_types.h"
@@ -1183,10 +1184,9 @@ gboolean hdp_get_dcpsm(struct hdp_device *device, hdp_continue_dcpsm_f func,
 static void hdp_free_application(struct hdp_application *app)
 {
 	if (app->dbus_watcher > 0)
-		g_dbus_remove_watch(app->conn, app->dbus_watcher);
+		g_dbus_remove_watch(btd_get_dbus_connection(),
+							app->dbus_watcher);
 
-	if (app->conn != NULL)
-		dbus_connection_unref(app->conn);
 	g_free(app->oname);
 	g_free(app->description);
 	g_free(app->path);
-- 
1.7.11.3

