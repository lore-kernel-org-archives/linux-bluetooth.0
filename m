Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 16/32] Register Health link int the bus when MCL is connected
Date: Wed,  2 Jun 2010 15:19:12 +0200
Message-Id: <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |   64 ++++++++++++++++++++++++++++++++++++++++++++++-----
 health/hdp_types.h |   12 +++++++++-
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 0d3265f..88e7235 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -37,8 +37,9 @@
 
 #include "../src/dbus-common.h"
 
-#define HEALTH_MANAGER_INTERFACE       "org.bluez.HealthAdapter"
-#define HEALTH_DEVICE                  "org.bluez.HealthDevice"
+#define HEALTH_MANAGER_INTERFACE	"org.bluez.HealthAdapter"
+#define HEALTH_DEVICE			"org.bluez.HealthDevice"
+#define HEALTH_LINK			"org.bluez.HealthLink"
 
 static GSList *adapters = NULL;
 static GSList *devices = NULL;
@@ -101,6 +102,18 @@ static int hdp_instance_idcmp(gconstpointer instance, gconstpointer p)
 	return -1;
 }
 
+static void set_health_link_path(struct hdp_link *hdpl)
+{
+	char path[MAX_PATH_LENGTH + 1];
+
+	hdpl->id = hdpl->hdpi->hlc++;
+	snprintf(path, MAX_PATH_LENGTH, "%s/health_link_%d_%d",
+		adapter_get_path(hdpl->hdpi->adapter->btd_adapter),
+		hdpl->hdpi->id, hdpl->id);
+
+	hdpl->path = g_strdup(path);
+}
+
 static void fill_up_one_spec(DBusMessageIter *dict, gpointer data)
 {
 	struct hdp_feature *feature = data;
@@ -346,12 +359,23 @@ static uint8_t hdp_mcap_mdl_reconn_req_cb(struct mcap_mcl *mcl,
 	return MCAP_REQUEST_NOT_SUPPORTED;
 }
 
+static void health_link_path_unregister(void *data)
+{
+	/* struct hdp_link *hdpl = data */
+	/* TODO: Unregister hdp_link*/
+}
+
+static GDBusMethodTable health_link_methods[] = {
+	{ NULL }
+};
+
 static void hdp_mcl_connect_cb(struct mcap_mcl *mcl, GError *err, void *data)
 {
 	struct hdp_connection_cb *cb_data = data;
 	struct hdp_device *device = cb_data->device;
-	/* struct hdp_instance *hdpi = cb_data->hdpi; */
+	struct hdp_instance *hdpi = cb_data->hdpi;
 	DBusMessage *msg = cb_data->msg;
+	struct hdp_link *hdpl = NULL;
 	GError *cberr = NULL;
 	DBusMessage *reply;
 
@@ -360,8 +384,13 @@ static void hdp_mcl_connect_cb(struct mcap_mcl *mcl, GError *err, void *data)
 	if (err)
 		goto fail;
 
-	/* Create and Register HealthLink interface */
-	mcap_mcl_set_cb(mcl, &cberr, NULL /*health_link*/,
+	hdpl = g_new0(struct hdp_link, 1);
+	hdpl->hdpi = hdpi;
+	hdpl->dev = device;
+	hdpl->mcl = mcap_mcl_ref(mcl);
+	set_health_link_path(hdpl);
+
+	mcap_mcl_set_cb(mcl, &cberr, hdpl,
 		MCAP_MDL_CB_CONNECTED, hdp_mcap_mdl_connected_cb,
 		MCAP_MDL_CB_CLOSED, hdp_mcap_mdl_closed_cb,
 		MCAP_MDL_CB_DELETED, hdp_mcap_mdl_deleted_cb,
@@ -369,14 +398,35 @@ static void hdp_mcl_connect_cb(struct mcap_mcl *mcl, GError *err, void *data)
 		MCAP_MDL_CB_REMOTE_CONN_REQ, hdp_mcap_mdl_conn_req_cb,
 		MCAP_MDL_CB_REMOTE_RECONN_REQ, hdp_mcap_mdl_reconn_req_cb,
 		MCAP_MDL_CB_INVALID);
+
 	if (cberr)
 		goto fail;
+
+	if (!g_dbus_register_interface(hdpl->dev->conn, hdpl->path, HEALTH_LINK,
+					health_link_methods, NULL, NULL,
+					hdpl, health_link_path_unregister)) {
+		error("D-Bus failed to register %s interface to %s",
+						HEALTH_LINK, hdpl->path);
+		goto fail;
+	}
+
+	hdpi->hlink = g_slist_prepend(hdpi->hlink, hdpl);
+	reply = g_dbus_create_reply(msg, DBUS_TYPE_OBJECT_PATH, &hdpl->path,
+							DBUS_TYPE_INVALID);
+	g_dbus_send_message(device->conn, reply);
 	return;
 fail:
 	reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HdpError",
 					(err ? err->message : cberr->message));
-	if (!cberr)
+	if (cberr) {
+		/* MCAP will close the MCL and won't cache it if we didn't
+		* increase the MCL reference counter during the callback. */
+		mcap_mcl_unref(hdpl->mcl);
+		g_free(hdpl->path);
+		g_free(hdpl);
 		g_error_free(cberr);
+	}
+
 	g_dbus_send_message(device->conn, reply);
 }
 
@@ -421,8 +471,8 @@ static void connect_health_instance(sdp_list_t *recs, int err, gpointer data)
 	reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
 			"Error getting remote protocol descriptor list");
 fail:
-	g_dbus_send_message(device->conn, reply);
 	g_free(cb_data);
+	g_dbus_send_message(device->conn, reply);
 }
 
 static DBusMessage *hdp_connect(DBusConnection *conn,
diff --git a/health/hdp_types.h b/health/hdp_types.h
index 3bab4ea..05bfbfe 100644
--- a/health/hdp_types.h
+++ b/health/hdp_types.h
@@ -99,10 +99,20 @@ struct hdp_instance {
 	struct hdp_config	*config;	/* Configuration */
 	uint32_t		sdp_handler;	/* SDP record handler */
 	guint			dbus_watcher;	/* Client D-Bus conn watcher */
+	uint16_t		hlc;		/* Health link id. counter */
+};
+
+struct hdp_link {
+	struct hdp_instance	*hdpi;		/* HDP session */
+	struct hdp_device	*dev;		/* Health Device */
+	struct mcap_mcl 	*mcl;		/* MCAP mcl */
+	GSList			*channels;	/* Data channels */
+	char			*path;		/* HDP link path */
+	uint32_t		id;		/* Health link id */
 };
 
 struct hdp_device {
-	DBusConnection		*conn;		/* for name listener handling */
+	DBusConnection		*conn;		/* For name listener handling */
 	struct btd_device	*dev;		/* Device reference */
 	struct hdp_adapter	*hdp_adapter;	/* hdp_adapater */
 };
-- 
1.6.3.3

