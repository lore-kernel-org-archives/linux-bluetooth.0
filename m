Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/4] hdp.c: Delay ChannelConnected signal
Date: Wed, 14 Dec 2011 11:11:49 +0100
Message-Id: <1323857512-5626-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This signal is sent before channel is connected as soon as MCAP accepts
the data channel creation request. At this moment, applications that
try to get the fd before the connection finishes will fail. This problem
can be solved delaying the ChannelConnection signal until the connection
operation finishes.
---
 health/hdp.c |   45 ++++++++++++++++++++++++++++++++++-----------
 1 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 6d53439..bcb6ef4 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -1626,6 +1626,25 @@ static void abort_and_del_mdl_cb(GError *err, gpointer data)
 	}
 }
 
+static void abort_mdl_connection_cb(GError *err, gpointer data)
+{
+	struct hdp_tmp_dc_data *hdp_conn = data;
+	struct hdp_channel *hdp_chann = hdp_conn->hdp_chann;
+
+	if (err != NULL)
+		error("Aborting error: %s", err->message);
+
+	/* Connection operation has failed but we have to */
+	/* notify the channel created at MCAP level */
+	if (hdp_chann->mdep != HDP_MDEP_ECHO)
+		g_dbus_emit_signal(hdp_conn->conn,
+					device_get_path(hdp_chann->dev->dev),
+					HEALTH_DEVICE,
+					"ChannelConnected",
+					DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
+					DBUS_TYPE_INVALID);
+}
+
 static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 {
 	struct hdp_tmp_dc_data *hdp_conn =  data;
@@ -1643,8 +1662,10 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 
 		/* Send abort request because remote side */
 		/* is now in PENDING state */
-		if (!mcap_mdl_abort(hdp_chann->mdl, abort_mdl_cb, NULL,
-								NULL, &gerr)) {
+		if (!mcap_mdl_abort(hdp_chann->mdl, abort_mdl_connection_cb,
+					hdp_tmp_dc_data_ref(hdp_conn),
+					hdp_tmp_dc_data_destroy, &gerr)) {
+			hdp_tmp_dc_data_unref(hdp_conn);
 			error("%s", gerr->message);
 			g_error_free(gerr);
 		}
@@ -1656,6 +1677,13 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 					DBUS_TYPE_INVALID);
 	g_dbus_send_message(hdp_conn->conn, reply);
 
+	g_dbus_emit_signal(hdp_conn->conn,
+					device_get_path(hdp_chann->dev->dev),
+					HEALTH_DEVICE,
+					"ChannelConnected",
+					DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
+					DBUS_TYPE_INVALID);
+
 	if (!check_channel_conf(hdp_chann)) {
 		close_mdl(hdp_chann);
 		return;
@@ -1710,14 +1738,6 @@ static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
 	if (hdp_chan == NULL)
 		goto fail;
 
-	if (user_data->mdep != HDP_MDEP_ECHO)
-		g_dbus_emit_signal(user_data->conn,
-					device_get_path(hdp_chan->dev->dev),
-					HEALTH_DEVICE,
-					"ChannelConnected",
-					DBUS_TYPE_OBJECT_PATH, &hdp_chan->path,
-					DBUS_TYPE_INVALID);
-
 	hdp_conn = g_new0(struct hdp_tmp_dc_data, 1);
 	hdp_conn->msg = dbus_message_ref(user_data->msg);
 	hdp_conn->conn = dbus_connection_ref(user_data->conn);
@@ -1740,7 +1760,10 @@ static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
 	hdp_tmp_dc_data_unref(hdp_conn);
 
 	/* Send abort request because remote side is now in PENDING state */
-	if (!mcap_mdl_abort(mdl, abort_mdl_cb, NULL, NULL, &gerr)) {
+	if (!mcap_mdl_abort(hdp_chan->mdl, abort_mdl_connection_cb,
+					hdp_tmp_dc_data_ref(hdp_conn),
+					hdp_tmp_dc_data_destroy, &gerr)) {
+		hdp_tmp_dc_data_unref(hdp_conn);
 		error("%s", gerr->message);
 		g_error_free(gerr);
 	}
-- 
1.7.8

