Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 15/32] Implement connect MCL callback in health instances connection
Date: Wed,  2 Jun 2010 15:19:11 +0200
Message-Id: <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index a15667b..0d3265f 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -33,6 +33,8 @@
 
 #include "glib-helper.h"
 
+#include "../mcap/mcap.h"
+
 #include "../src/dbus-common.h"
 
 #define HEALTH_MANAGER_INTERFACE       "org.bluez.HealthAdapter"
@@ -305,12 +307,77 @@ static sdp_record_t *get_record(sdp_list_t *recs, uint32_t handle)
 	return NULL;
 }
 
+static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
+{
+	/* struct hdp_link *hdpl = data; */
+	debug("TODO: Incomplete callback, mdl connected");
+}
+
+static void hdp_mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
+{
+	/* struct hdp_link *hdpl = data; */
+	debug("TODO: Incomplete callback, mdl deleted");
+}
+
+static void hdp_mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
+{
+	/* struct hdp_link *hdpl = data; */
+	debug("TODO: Incomplete callback, mdl aborted");
+}
+
+static void hdp_mcap_mdl_closed_cb(struct mcap_mdl *mdl, void *data)
+{
+	/* struct hdp_link *hdpl = data; */
+	debug("TODO: Incomplete callback, mdl closed");
+}
+
+static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mdl *mdl, void *data)
+{
+	/* struct hdp_link *hdpl = data; */
+	debug("TODO: Incomplete callback, mdl connection request");
+	return MCAP_REQUEST_NOT_SUPPORTED;
+}
+
+static uint8_t hdp_mcap_mdl_reconn_req_cb(struct mcap_mcl *mcl,
+					  uint8_t mdepid, uint16_t mdlid,
+					  uint8_t *conf, void *data)
+{
+	debug("TODO: Incomplete callback, mdl reconnection request");
+	return MCAP_REQUEST_NOT_SUPPORTED;
+}
+
 static void hdp_mcl_connect_cb(struct mcap_mcl *mcl, GError *err, void *data)
 {
 	struct hdp_connection_cb *cb_data = data;
+	struct hdp_device *device = cb_data->device;
+	/* struct hdp_instance *hdpi = cb_data->hdpi; */
+	DBusMessage *msg = cb_data->msg;
+	GError *cberr = NULL;
+	DBusMessage *reply;
 
-	/* TODO */
 	g_free(cb_data);
+
+	if (err)
+		goto fail;
+
+	/* Create and Register HealthLink interface */
+	mcap_mcl_set_cb(mcl, &cberr, NULL /*health_link*/,
+		MCAP_MDL_CB_CONNECTED, hdp_mcap_mdl_connected_cb,
+		MCAP_MDL_CB_CLOSED, hdp_mcap_mdl_closed_cb,
+		MCAP_MDL_CB_DELETED, hdp_mcap_mdl_deleted_cb,
+		MCAP_MDL_CB_ABORTED, hdp_mcap_mdl_aborted_cb,
+		MCAP_MDL_CB_REMOTE_CONN_REQ, hdp_mcap_mdl_conn_req_cb,
+		MCAP_MDL_CB_REMOTE_RECONN_REQ, hdp_mcap_mdl_reconn_req_cb,
+		MCAP_MDL_CB_INVALID);
+	if (cberr)
+		goto fail;
+	return;
+fail:
+	reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HdpError",
+					(err ? err->message : cberr->message));
+	if (!cberr)
+		g_error_free(cberr);
+	g_dbus_send_message(device->conn, reply);
 }
 
 static void connect_health_instance(sdp_list_t *recs, int err, gpointer data)
@@ -383,7 +450,7 @@ static DBusMessage *hdp_connect(DBusConnection *conn,
 	if (!l)
 		return g_dbus_create_error(msg,
 					   ERROR_INTERFACE ".InvalidArguments",
-					   "Invalid local instance id");
+					   "Invalid local health instance id");
 
 	cb_data = g_new0(struct hdp_connection_cb, 1);
 	cb_data->device = device;
@@ -400,6 +467,7 @@ static DBusMessage *hdp_connect(DBusConnection *conn,
 							cb_data, NULL) == 0)
 		return NULL;
 
+	g_free(cb_data);
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
 				   "Error getting remote information");
 }
@@ -499,6 +567,7 @@ static DBusMessage *hdp_create_instance(DBusConnection *conn,
 		return g_dbus_create_error(msg,
 					ERROR_INTERFACE ".InvalidArguments",
 					"Invalid arguments in method call");
+
 	dbus_message_iter_get_basic(&iter, &path);
 	dbus_message_iter_next(&iter);
 	config = hdp_get_config(&iter, &err);
@@ -509,6 +578,7 @@ static DBusMessage *hdp_create_instance(DBusConnection *conn,
 		g_error_free(err);
 		return reply;
 	}
+
 	name = dbus_message_get_sender(msg);
 	if (!name) {
 		return g_dbus_create_error(msg,
@@ -552,7 +622,7 @@ static DBusMessage *hdp_create_instance(DBusConnection *conn,
 							DBUS_TYPE_INVALID);
 error:
 	reply = g_dbus_create_error(msg,ERROR_INTERFACE ".HealthError",
-					err->message);
+								err->message);
 	g_error_free(err);
 	hdp_instance_free(hdpi);
 	return reply;
-- 
1.6.3.3

