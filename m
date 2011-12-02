Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 5/5] hdp: Fix coding style issues
Date: Fri,  2 Dec 2011 11:56:36 +0100
Message-Id: <1322823396-5941-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1322823396-5941-5-git-send-email-sancane@gmail.com>
References: <1322823396-5941-1-git-send-email-sancane@gmail.com>
 <1322823396-5941-2-git-send-email-sancane@gmail.com>
 <1322823396-5941-3-git-send-email-sancane@gmail.com>
 <1322823396-5941-4-git-send-email-sancane@gmail.com>
 <1322823396-5941-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |  167 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 84 insertions(+), 83 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index d167ab0..7fda9b1 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -86,7 +86,7 @@ struct hdp_echo_data {
 
 static struct hdp_channel *hdp_channel_ref(struct hdp_channel *chan)
 {
-	if (!chan)
+	if (chan == NULL)
 		return NULL;
 
 	chan->ref++;
@@ -111,7 +111,7 @@ static void free_health_channel(struct hdp_channel *chan)
 
 static void hdp_channel_unref(struct hdp_channel *chan)
 {
-	if (!chan)
+	if (chan == NULL)
 		return;
 
 	chan->ref --;
@@ -264,7 +264,7 @@ static uint8_t get_app_id(void)
 	do {
 		GSList *l = g_slist_find_custom(applications, &id, cmp_app_id);
 
-		if (!l) {
+		if (l == NULL) {
 			next_app_id = (id % HDP_MDEP_FINAL) + 1;
 			return id;
 		} else
@@ -285,7 +285,7 @@ static int cmp_app(gconstpointer a, gconstpointer b)
 static gboolean set_app_path(struct hdp_application *app)
 {
 	app->id = get_app_id();
-	if (!app->id)
+	if (app->id == 0)
 		return FALSE;
 	app->path = g_strdup_printf(MANAGER_PATH "/health_app_%d", app->id);
 
@@ -294,7 +294,7 @@ static gboolean set_app_path(struct hdp_application *app)
 
 static void device_unref_mcl(struct hdp_device *hdp_device)
 {
-	if (!hdp_device->mcl)
+	if (hdp_device->mcl == NULL)
 		return;
 
 	mcap_close_mcl(hdp_device->mcl, FALSE);
@@ -305,12 +305,12 @@ static void device_unref_mcl(struct hdp_device *hdp_device)
 
 static void free_health_device(struct hdp_device *device)
 {
-	if (device->conn) {
+	if (device->conn != NULL) {
 		dbus_connection_unref(device->conn);
 		device->conn = NULL;
 	}
 
-	if (device->dev) {
+	if (device->dev != NULL) {
 		btd_device_unref(device->dev);
 		device->dev = NULL;
 	}
@@ -349,13 +349,13 @@ static DBusMessage *manager_create_application(DBusConnection *conn,
 
 	dbus_message_iter_init(msg, &iter);
 	app = hdp_get_app_config(&iter, &err);
-	if (err) {
+	if (err != NULL) {
 		g_error_free(err);
 		return btd_error_invalid_args(msg);
 	}
 
 	name = dbus_message_get_sender(msg);
-	if (!name) {
+	if (name == NULL) {
 		hdp_application_unref(app);
 		return g_dbus_create_error(msg,
 					ERROR_INTERFACE ".HealthError",
@@ -397,7 +397,7 @@ static DBusMessage *manager_destroy_application(DBusConnection *conn,
 
 	l = g_slist_find_custom(applications, path, cmp_app);
 
-	if (!l)
+	if (l == NULL)
 		return g_dbus_create_error(msg,
 					ERROR_INTERFACE ".InvalidArguments",
 					"Invalid arguments in method call, "
@@ -437,7 +437,7 @@ static DBusMessage *channel_get_properties(DBusConnection *conn,
 	char *type;
 
 	reply = dbus_message_new_method_return(msg);
-	if (!reply)
+	if (reply == NULL)
 		return NULL;
 
 	dbus_message_iter_init_append(reply, &iter);
@@ -476,7 +476,7 @@ static void hdp_tmp_dc_data_destroy(gpointer data)
 
 static void abort_mdl_cb(GError *err, gpointer data)
 {
-	if (err)
+	if (err != NULL)
 		error("Aborting error: %s", err->message);
 }
 
@@ -486,7 +486,7 @@ static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 	DBusMessage *reply;
 	int fd;
 
-	if (err) {
+	if (err != NULL) {
 		struct hdp_channel *chan = dc_data->hdp_chann;
 		GError *gerr = NULL;
 
@@ -533,7 +533,7 @@ static void hdp_get_dcpsm_cb(uint16_t dcpsm, gpointer user_data, GError *err)
 	GError *gerr = NULL;
 	uint8_t mode;
 
-	if (err) {
+	if (err != NULL) {
 		hdp_conn->cb(hdp_chann->mdl, err, hdp_conn);
 		return;
 	}
@@ -561,7 +561,7 @@ static void device_reconnect_mdl_cb(struct mcap_mdl *mdl, GError *err,
 	GError *gerr = NULL;
 	DBusMessage *reply;
 
-	if (err) {
+	if (err != NULL) {
 		reply = g_dbus_create_error(dc_data->msg,
 					ERROR_INTERFACE ".HealthError",
 					"Cannot reconnect: %s", err->message);
@@ -599,7 +599,7 @@ static DBusMessage *channel_acquire_continue(struct hdp_tmp_dc_data *data,
 	GError *gerr = NULL;
 	int fd;
 
-	if (err) {
+	if (err != NULL) {
 		return g_dbus_create_error(data->msg,
 						ERROR_INTERFACE ".HealthError",
 						"%s", err->message);
@@ -630,7 +630,7 @@ static void channel_acquire_cb(gpointer data, GError *err)
 
 	reply = channel_acquire_continue(data, err);
 
-	if (reply)
+	if (reply != NULL)
 		g_dbus_send_message(dc_data->conn, reply);
 }
 
@@ -690,13 +690,13 @@ static DBusMessage *channel_release(DBusConnection *conn,
 
 static void free_echo_data(struct hdp_echo_data *edata)
 {
-	if (!edata)
+	if (edata == NULL)
 		return;
 
-	if (edata->tid)
+	if (edata->tid > 0)
 		g_source_remove(edata->tid);
 
-	if (edata->buf)
+	if (edata->buf != NULL)
 		g_free(edata->buf);
 
 
@@ -709,7 +709,7 @@ static void health_channel_destroy(void *data)
 	struct hdp_device *dev = hdp_chan->dev;
 
 	DBG("Destroy Health Channel %s", hdp_chan->path);
-	if (!g_slist_find(dev->channels, hdp_chan))
+	if (g_slist_find(dev->channels, hdp_chan) == NULL)
 		goto end;
 
 	dev->channels = g_slist_remove(dev->channels, hdp_chan);
@@ -752,7 +752,7 @@ static struct hdp_channel *create_channel(struct hdp_device *dev,
 {
 	struct hdp_channel *hdp_chann;
 
-	if (!dev)
+	if (dev == NULL)
 		return NULL;
 
 	hdp_chann = g_new0(struct hdp_channel, 1);
@@ -760,10 +760,10 @@ static struct hdp_channel *create_channel(struct hdp_device *dev,
 	hdp_chann->dev = health_device_ref(dev);
 	hdp_chann->mdlid = mdlid;
 
-	if (mdl)
+	if (mdl != NULL)
 		hdp_chann->mdl = mcap_mdl_ref(mdl);
 
-	if (app) {
+	if (app != NULL) {
 		hdp_chann->mdep = app->id;
 		hdp_chann->app = hdp_application_ref(app);
 	} else
@@ -797,7 +797,7 @@ static void remove_channels(struct hdp_device *dev)
 	struct hdp_channel *chan;
 	char *path;
 
-	while (dev->channels) {
+	while (dev->channels != NULL) {
 		chan = dev->channels->data;
 
 		path = g_strdup(chan->path);
@@ -810,7 +810,7 @@ static void remove_channels(struct hdp_device *dev)
 
 static void close_device_con(struct hdp_device *dev, gboolean cache)
 {
-	if (!dev->mcl)
+	if (dev->mcl == NULL)
 		return;
 
 	mcap_close_mcl(dev->mcl, cache);
@@ -917,9 +917,9 @@ static gboolean check_channel_conf(struct hdp_channel *chan)
 	DBG("MDL imtu %d omtu %d Channel imtu %d omtu %d", imtu, omtu,
 						chan->imtu, chan->omtu);
 
-	if (!chan->imtu)
+	if (chan->imtu == 0)
 		chan->imtu = imtu;
-	if (!chan->omtu)
+	if (chan->omtu == 0)
 		chan->omtu = omtu;
 
 	if (chan->imtu != imtu || chan->omtu != omtu)
@@ -934,14 +934,14 @@ static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 	struct hdp_channel *chan;
 
 	DBG("hdp_mcap_mdl_connected_cb");
-	if (!dev->ndc)
+	if (dev->ndc == NULL)
 		return;
 
 	chan = dev->ndc;
-	if (!chan->mdl)
+	if (chan->mdl == NULL)
 		chan->mdl = mcap_mdl_ref(mdl);
 
-	if (!g_slist_find(dev->channels, chan))
+	if (g_slist_find(dev->channels, chan) == NULL)
 		dev->channels = g_slist_prepend(dev->channels,
 							hdp_channel_ref(chan));
 
@@ -971,7 +971,7 @@ static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 					DBUS_TYPE_OBJECT_PATH, &chan->path,
 					DBUS_TYPE_INVALID);
 
-	if (dev->fr)
+	if (dev->fr != NULL)
 		goto end;
 
 	dev->fr = hdp_channel_ref(chan);
@@ -1003,7 +1003,7 @@ static void hdp_mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 
 	DBG("hdp_mcap_mdl_deleted_cb");
 	l = g_slist_find_custom(dev->channels, mdl, cmp_chan_mdl);
-	if (!l)
+	if (l == NULL)
 		return;
 
 	chan = l->data;
@@ -1019,12 +1019,12 @@ static void hdp_mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 	struct hdp_device *dev = data;
 
 	DBG("hdp_mcap_mdl_aborted_cb");
-	if (!dev->ndc)
+	if (dev->ndc == NULL)
 		return;
 
 	dev->ndc->mdl = mcap_mdl_ref(mdl);
 
-	if (!g_slist_find(dev->channels, dev->ndc))
+	if (g_slist_find(dev->channels, dev->ndc) == NULL)
 		dev->channels = g_slist_prepend(dev->channels,
 						hdp_channel_ref(dev->ndc));
 
@@ -1078,14 +1078,14 @@ static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 		}
 
 		dev->ndc = create_channel(dev, *conf, NULL, mdlid, NULL, NULL);
-		if (!dev->ndc)
+		if (dev->ndc == NULL)
 			return MCAP_MDL_BUSY;
 
 		return MCAP_SUCCESS;
 	}
 
 	l = g_slist_find_custom(applications, &mdepid, cmp_app_id);
-	if (!l)
+	if (l == NULL)
 		return MCAP_INVALID_MDEP;
 
 	app = l->data;
@@ -1117,7 +1117,7 @@ static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 	}
 
 	l = g_slist_find_custom(dev->channels, &mdlid, cmp_chan_mdlid);
-	if (l) {
+	if (l != NULL) {
 		struct hdp_channel *chan = l->data;
 		char *path;
 
@@ -1134,7 +1134,7 @@ static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 	}
 
 	dev->ndc = create_channel(dev, *conf, NULL, mdlid, app, NULL);
-	if (!dev->ndc)
+	if (dev->ndc == NULL)
 		return MCAP_MDL_BUSY;
 
 	return MCAP_SUCCESS;
@@ -1148,13 +1148,13 @@ static uint8_t hdp_mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
 	GSList *l;
 
 	l = g_slist_find_custom(dev->channels, mdl, cmp_chan_mdl);
-	if (!l)
+	if (l == NULL)
 		return MCAP_INVALID_MDL;
 
 	chan = l->data;
 
-	if (!dev->fr && (chan->config != HDP_RELIABLE_DC) &&
-						(chan->mdep != HDP_MDEP_ECHO))
+	if (dev->fr == NULL && chan->config != HDP_RELIABLE_DC &&
+						chan->mdep != HDP_MDEP_ECHO)
 		return MCAP_UNSPECIFIED_ERROR;
 
 	if (!mcap_set_data_chan_mode(dev->hdp_adapter->mi,
@@ -1173,7 +1173,7 @@ gboolean hdp_set_mcl_cb(struct hdp_device *device, GError **err)
 {
 	gboolean ret;
 
-	if (!device->mcl)
+	if (device->mcl == NULL)
 		return FALSE;
 
 	ret = mcap_mcl_set_cb(device->mcl, device, err,
@@ -1202,7 +1202,7 @@ static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 
 	mcap_mcl_get_addr(mcl, &addr);
 	l = g_slist_find_custom(devices, &addr, cmp_dev_addr);
-	if (!l) {
+	if (l == NULL) {
 		struct hdp_adapter *hdp_adapter = data;
 		struct btd_device *device;
 		char str[18];
@@ -1233,7 +1233,7 @@ static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
 	GSList *l;
 
 	l = g_slist_find_custom(devices, mcl, cmp_dev_mcl);
-	if (!l)
+	if (l == NULL)
 		return;
 
 	hdp_device = l->data;
@@ -1250,7 +1250,7 @@ static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
 	GSList *l;
 
 	l = g_slist_find_custom(devices, mcl, cmp_dev_mcl);
-	if (!l)
+	if (l == NULL)
 		return;
 
 	hdp_device = l->data;
@@ -1266,7 +1266,7 @@ static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
 	GSList *l;
 
 	l = g_slist_find_custom(devices, mcl, cmp_dev_mcl);
-	if (!l)
+	if (l == NULL)
 		return;
 
 	hdp_device = l->data;
@@ -1311,7 +1311,7 @@ static void check_devices_mcl(void)
 
 static void release_adapter_instance(struct hdp_adapter *hdp_adapter)
 {
-	if (!hdp_adapter->mi)
+	if (hdp_adapter->mi == NULL)
 		return;
 
 	check_devices_mcl();
@@ -1325,12 +1325,12 @@ static gboolean update_adapter(struct hdp_adapter *hdp_adapter)
 	GError *err = NULL;
 	bdaddr_t addr;
 
-	if (!applications) {
+	if (applications == NULL) {
 		release_adapter_instance(hdp_adapter);
 		goto update;
 	}
 
-	if (hdp_adapter->mi)
+	if (hdp_adapter->mi != NULL)
 		goto update;
 
 	adapter_get_address(hdp_adapter->btd_adapter, &addr);
@@ -1340,20 +1340,20 @@ static gboolean update_adapter(struct hdp_adapter *hdp_adapter)
 					NULL, /* CSP is not used by now */
 					hdp_adapter, &err);
 
-	if (!hdp_adapter->mi) {
+	if (hdp_adapter->mi == NULL) {
 		error("Error creating the MCAP instance: %s", err->message);
 		g_error_free(err);
 		return FALSE;
 	}
 
 	hdp_adapter->ccpsm = mcap_get_ctrl_psm(hdp_adapter->mi, &err);
-	if (err) {
+	if (err != NULL) {
 		error("Error getting MCAP control PSM: %s", err->message);
 		goto fail;
 	}
 
 	hdp_adapter->dcpsm = mcap_get_data_psm(hdp_adapter->mi, &err);
-	if (err) {
+	if (err != NULL) {
 		error("Error getting MCAP data PSM: %s", err->message);
 		goto fail;
 	}
@@ -1365,8 +1365,9 @@ update:
 
 fail:
 	release_adapter_instance(hdp_adapter);
-	if (err)
+	if (err != NULL)
 		g_error_free(err);
+
 	return FALSE;
 }
 
@@ -1397,12 +1398,12 @@ void hdp_adapter_unregister(struct btd_adapter *adapter)
 
 	l = g_slist_find_custom(adapters, adapter, cmp_adapter);
 
-	if (!l)
+	if (l == NULL)
 		return;
 
 	hdp_adapter = l->data;
 	adapters = g_slist_remove(adapters, hdp_adapter);
-	if (hdp_adapter->sdp_handler)
+	if (hdp_adapter->sdp_handler > 0)
 		remove_record_from_server(hdp_adapter->sdp_handler);
 	release_adapter_instance(hdp_adapter);
 	btd_adapter_unref(hdp_adapter->btd_adapter);
@@ -1411,7 +1412,7 @@ void hdp_adapter_unregister(struct btd_adapter *adapter)
 
 static void delete_echo_channel_cb(GError *err, gpointer chan)
 {
-	if (err && err->code != MCAP_INVALID_MDL) {
+	if (err != NULL && err->code != MCAP_INVALID_MDL) {
 		/* TODO: Decide if more action is required here */
 		error("Error deleting echo channel: %s", err->message);
 		return;
@@ -1445,7 +1446,7 @@ static void abort_echo_channel_cb(GError *err, gpointer data)
 {
 	struct hdp_channel *chan = data;
 
-	if (err && err->code != MCAP_ERROR_INVALID_OPERATION) {
+	if (err != NULL && err->code != MCAP_ERROR_INVALID_OPERATION) {
 		error("Aborting error: %s", err->message);
 		if (err->code == MCAP_INVALID_MDL) {
 			/* MDL is removed from MCAP so we can */
@@ -1554,7 +1555,7 @@ static void hdp_echo_connect_cb(struct mcap_mdl *mdl, GError *err,
 	GIOChannel *io;
 	int fd;
 
-	if (err) {
+	if (err != NULL) {
 		reply = g_dbus_create_error(hdp_conn->msg,
 						ERROR_INTERFACE ".HealthError",
 						"%s", err->message);
@@ -1592,7 +1593,7 @@ static void hdp_echo_connect_cb(struct mcap_mdl *mdl, GError *err,
 	g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL | G_IO_IN,
 			check_echo, hdp_tmp_dc_data_ref(hdp_conn));
 
-	edata->tid  = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
+	edata->tid = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
 					ECHO_TIMEOUT, echo_timeout,
 					hdp_channel_ref(hdp_conn->hdp_chann),
 					(GDestroyNotify) hdp_channel_unref);
@@ -1602,7 +1603,7 @@ static void hdp_echo_connect_cb(struct mcap_mdl *mdl, GError *err,
 
 static void delete_mdl_cb(GError *err, gpointer data)
 {
-	if (err)
+	if (err != NULL)
 		error("Deleting error: %s", err->message);
 }
 
@@ -1611,7 +1612,7 @@ static void abort_and_del_mdl_cb(GError *err, gpointer data)
 	struct mcap_mdl *mdl = data;
 	GError *gerr = NULL;
 
-	if (err) {
+	if (err != NULL) {
 		error("%s", err->message);
 		if (err->code == MCAP_INVALID_MDL) {
 			/* MDL is removed from MCAP so we don't */
@@ -1634,7 +1635,7 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 	DBusMessage *reply;
 	GError *gerr = NULL;
 
-	if (err) {
+	if (err != NULL) {
 		error("%s", err->message);
 		reply = g_dbus_create_reply(hdp_conn->msg,
 					DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
@@ -1661,7 +1662,7 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 		return;
 	}
 
-	if (dev->fr)
+	if (dev->fr != NULL)
 		return;
 
 	dev->fr = hdp_channel_ref(hdp_chann);
@@ -1680,7 +1681,7 @@ static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
 	GError *gerr = NULL;
 	DBusMessage *reply;
 
-	if (err) {
+	if (err != NULL) {
 		reply = g_dbus_create_error(user_data->msg,
 					ERROR_INTERFACE ".HealthError",
 					"%s", err->message);
@@ -1690,7 +1691,7 @@ static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
 
 	if (user_data->mdep != HDP_MDEP_ECHO &&
 				user_data->config == HDP_NO_PREFERENCE_DC) {
-		if (!user_data->dev->fr && (conf != HDP_RELIABLE_DC)) {
+		if (user_data->dev->fr == NULL && conf != HDP_RELIABLE_DC) {
 			g_set_error(&gerr, HDP_ERROR, HDP_CONNECTION_ERROR,
 					"Data channel aborted, first data "
 					"channel should be reliable");
@@ -1707,7 +1708,7 @@ static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
 	hdp_chan = create_channel(user_data->dev, conf, mdl,
 							mcap_mdl_get_mdlid(mdl),
 							user_data->app, &gerr);
-	if (!hdp_chan)
+	if (hdp_chan == NULL)
 		goto fail;
 
 	if (user_data->mdep != HDP_MDEP_ECHO)
@@ -1771,7 +1772,7 @@ static void device_create_dc_cb(gpointer user_data, GError *err)
 	DBusMessage *reply;
 	GError *gerr = NULL;
 
-	if (err) {
+	if (err != NULL) {
 		reply = g_dbus_create_error(data->msg,
 					ERROR_INTERFACE ".HealthError",
 					"%s", err->message);
@@ -1779,7 +1780,7 @@ static void device_create_dc_cb(gpointer user_data, GError *err)
 		return;
 	}
 
-	if (!data->dev->mcl) {
+	if (data->dev->mcl == NULL) {
 		g_set_error(&gerr, HDP_ERROR, HDP_CONNECTION_ERROR,
 				"Mcl was closed");
 		goto fail;
@@ -1817,7 +1818,7 @@ static DBusMessage *device_echo(DBusConnection *conn,
 	data->cb = hdp_echo_connect_cb;
 	hdp_create_data_ref(data);
 
-	if (device->mcl_conn && device->mcl) {
+	if (device->mcl_conn && device->mcl != NULL) {
 		if (mcap_create_mdl(device->mcl, data->mdep, data->config,
 						device_create_mdl_cb, data,
 						destroy_create_dc_data, &err))
@@ -1843,7 +1844,7 @@ static void device_get_mdep_cb(uint8_t mdep, gpointer data, GError *err)
 	DBusMessage *reply;
 	GError *gerr = NULL;
 
-	if (err) {
+	if (err != NULL) {
 		reply = g_dbus_create_error(user_data->msg,
 						ERROR_INTERFACE ".HealthError",
 						"%s", err->message);
@@ -1890,7 +1891,7 @@ static DBusMessage *device_create_channel(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 
 	l = g_slist_find_custom(applications, app_path, cmp_app);
-	if (!l)
+	if (l == NULL)
 		return btd_error_invalid_args(msg);
 
 	app = l->data;
@@ -1939,7 +1940,7 @@ static void hdp_mdl_delete_cb(GError *err, gpointer data)
 	DBusMessage *reply;
 	char *path;
 
-	if (err && err->code != MCAP_INVALID_MDL) {
+	if (err != NULL && err->code != MCAP_INVALID_MDL) {
 		reply = g_dbus_create_error(del_data->msg,
 						ERROR_INTERFACE ".HealthError",
 						"%s", err->message);
@@ -1961,7 +1962,7 @@ static void hdp_continue_del_cb(gpointer user_data, GError *err)
 	GError *gerr = NULL;
 	DBusMessage *reply;
 
-	if (err) {
+	if (err != NULL) {
 		reply = g_dbus_create_error(del_data->msg,
 					ERROR_INTERFACE ".HealthError",
 					"%s", err->message);
@@ -1999,7 +2000,7 @@ static DBusMessage *device_destroy_channel(DBusConnection *conn,
 	}
 
 	l = g_slist_find_custom(device->channels, path, cmp_chan_path);
-	if (!l)
+	if (l == NULL)
 		return btd_error_invalid_args(msg);
 
 	hdp_chan = l->data;
@@ -2038,7 +2039,7 @@ static DBusMessage *device_get_properties(DBusConnection *conn,
 	char *path;
 
 	reply = dbus_message_new_method_return(msg);
-	if (!reply)
+	if (reply == NULL)
 		return NULL;
 
 	dbus_message_iter_init_append(reply, &iter);
@@ -2048,7 +2049,7 @@ static DBusMessage *device_get_properties(DBusConnection *conn,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	if (device->fr)
+	if (device->fr != NULL)
 		path = g_strdup(device->fr->path);
 	else
 		path = g_strdup("");
@@ -2067,7 +2068,7 @@ static void health_device_destroy(void *data)
 						device_get_path(device->dev));
 
 	remove_channels(device);
-	if (device->ndc) {
+	if (device->ndc != NULL) {
 		hdp_channel_unref(device->ndc);
 		device->ndc = NULL;
 	}
@@ -2102,7 +2103,7 @@ static struct hdp_device *create_health_device(DBusConnection *conn,
 	struct hdp_device *dev;
 	GSList *l;
 
-	if (!device)
+	if (device == NULL)
 		return NULL;
 
 	dev = g_new0(struct hdp_device, 1);
@@ -2111,7 +2112,7 @@ static struct hdp_device *create_health_device(DBusConnection *conn,
 	health_device_ref(dev);
 
 	l = g_slist_find_custom(adapters, adapter, cmp_adapter);
-	if (!l)
+	if (l == NULL)
 		goto fail;
 
 	dev->hdp_adapter = l->data;
@@ -2139,14 +2140,14 @@ int hdp_device_register(DBusConnection *conn, struct btd_device *device)
 	GSList *l;
 
 	l = g_slist_find_custom(devices, device, cmp_device);
-	if (l) {
+	if (l != NULL) {
 		hdev = l->data;
 		hdev->sdp_present = TRUE;
 		return 0;
 	}
 
 	hdev = create_health_device(conn, device);
-	if (!hdev)
+	if (hdev == NULL)
 		return -1;
 
 	hdev->sdp_present = TRUE;
@@ -2162,7 +2163,7 @@ void hdp_device_unregister(struct btd_device *device)
 	GSList *l;
 
 	l = g_slist_find_custom(devices, device, cmp_device);
-	if (!l)
+	if (l == NULL)
 		return;
 
 	hdp_dev = l->data;
-- 
1.7.7.4

