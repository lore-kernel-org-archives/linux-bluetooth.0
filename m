Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 18/32] Unify the creation of health links
Date: Wed,  2 Jun 2010 15:19:14 +0200
Message-Id: <1275484768-25838-19-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
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
 <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |   82 ++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 7f25144..0a98118 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -369,28 +369,17 @@ static GDBusMethodTable health_link_methods[] = {
 	{ NULL }
 };
 
-static void hdp_mcl_connect_cb(struct mcap_mcl *mcl, GError *err, void *data)
+static struct hdp_link *create_health_link(struct hdp_instance *hdpi,
+					struct mcap_mcl *mcl, GError **err)
 {
-	struct hdp_connection_cb *cb_data = data;
-	struct hdp_device *device = cb_data->device;
-	struct hdp_instance *hdpi = cb_data->hdpi;
-	DBusMessage *msg = cb_data->msg;
-	struct hdp_link *hdpl = NULL;
-	GError *cberr = NULL;
-	DBusMessage *reply;
-
-	g_free(cb_data);
-
-	if (err)
-		goto fail;
+	struct hdp_link *hdpl;
 
 	hdpl = g_new0(struct hdp_link, 1);
 	hdpl->hdpi = hdpi;
-	hdpl->dev = device;
 	hdpl->mcl = mcap_mcl_ref(mcl);
 	set_health_link_path(hdpl);
 
-	mcap_mcl_set_cb(mcl, &cberr, hdpl,
+	mcap_mcl_set_cb(mcl, err, hdpl,
 		MCAP_MDL_CB_CONNECTED, hdp_mcap_mdl_connected_cb,
 		MCAP_MDL_CB_CLOSED, hdp_mcap_mdl_closed_cb,
 		MCAP_MDL_CB_DELETED, hdp_mcap_mdl_deleted_cb,
@@ -399,16 +388,46 @@ static void hdp_mcl_connect_cb(struct mcap_mcl *mcl, GError *err, void *data)
 		MCAP_MDL_CB_REMOTE_RECONN_REQ, hdp_mcap_mdl_reconn_req_cb,
 		MCAP_MDL_CB_INVALID);
 
-	if (cberr)
-		goto fail;
+	if (*err)
+		return NULL;
 
-	if (!g_dbus_register_interface(hdpl->dev->conn, hdpl->path, HEALTH_LINK,
+	if (g_dbus_register_interface(hdpl->dev->conn, hdpl->path, HEALTH_LINK,
 					health_link_methods, NULL, NULL,
-					hdpl, health_link_path_unregister)) {
-		error("D-Bus failed to register %s interface to %s",
+					hdpl, health_link_path_unregister))
+		return hdpl;
+
+	g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
+				"Cant register the health link in the bus");
+
+	/* TODO create a function to free health link correctly */
+	/* MCAP will close the MCL and won't cache it if we didn't
+	* increase the MCL reference counter during the callback. */
+	mcap_mcl_unref(hdpl->mcl);
+	g_free(hdpl->path);
+	g_free(hdpl);
+	error("D-Bus failed to register %s interface to %s",
 						HEALTH_LINK, hdpl->path);
+	return NULL;
+}
+
+static void hdp_mcl_connect_cb(struct mcap_mcl *mcl, GError *err, void *data)
+{
+	struct hdp_connection_cb *cb_data = data;
+	struct hdp_device *device = cb_data->device;
+	struct hdp_instance *hdpi = cb_data->hdpi;
+	DBusMessage *msg = cb_data->msg;
+	struct hdp_link *hdpl = NULL;
+	GError *gerr = NULL;
+	DBusMessage *reply;
+
+	g_free(cb_data);
+
+	if (err)
+		goto fail;
+
+	hdpl = create_health_link(hdpi, mcl, &gerr);
+	if (gerr)
 		goto fail;
-	}
 
 	hdpi->hlink = g_slist_prepend(hdpi->hlink, hdpl);
 	reply = g_dbus_create_reply(msg, DBUS_TYPE_OBJECT_PATH, &hdpl->path,
@@ -417,14 +436,9 @@ static void hdp_mcl_connect_cb(struct mcap_mcl *mcl, GError *err, void *data)
 	return;
 fail:
 	reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HdpError",
-					(err ? err->message : cberr->message));
-	if (cberr) {
-		/* MCAP will close the MCL and won't cache it if we didn't
-		* increase the MCL reference counter during the callback. */
-		mcap_mcl_unref(hdpl->mcl);
-		g_free(hdpl->path);
-		g_free(hdpl);
-		g_error_free(cberr);
+					(err ? err->message : gerr->message));
+	if (gerr) {
+		g_error_free(gerr);
 	}
 
 	g_dbus_send_message(device->conn, reply);
@@ -578,8 +592,16 @@ static void client_disconnected(DBusConnection *connection, void *user_data)
 
 static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 {
-	/* struct hdp_instance *hdpi = data; */
+	struct hdp_instance *hdpi = data;
+	struct hdp_link *hdpl;
+	GError *err = NULL;
+
 	debug("TODO: implement mcl_connected");
+	hdpl = create_health_link(hdpi, mcl, &err);
+	if (err)
+		return;
+	/* TODO: Send the notification to the Agent */
+	hdpi->hlink = g_slist_prepend(hdpi->hlink, hdpl);
 }
 
 static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
-- 
1.6.3.3

