Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, Dohyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH BLUEZ 4/4] profiles/health: Remove HealthDevice signals
Date: Mon, 20 Jul 2015 00:31:11 +0900
Message-Id: <1437319871-3004-5-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
References: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes ChannelConnected and ChannelDeleted signals in
HealthDevice interface. These signals are not currently generated
and can be replaced InterfaceAdded and PropertiesChanged signals.
---
 profiles/health/hdp.c | 44 +-------------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 9fd7bf6..b7b1693 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -529,11 +529,6 @@ static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 							&fd, DBUS_TYPE_INVALID);
 	g_dbus_send_message(conn, reply);
 
-	g_dbus_emit_signal(conn, device_get_path(dc_data->hdp_chann->dev->dev),
-			HEALTH_DEVICE, "ChannelConnected",
-			DBUS_TYPE_OBJECT_PATH, &dc_data->hdp_chann->path,
-			DBUS_TYPE_INVALID);
-
 	dc_data->hdp_chann->connected = TRUE;
 
 	g_dbus_emit_property_changed(conn, dc_data->hdp_chann->path,
@@ -726,13 +721,6 @@ static void health_channel_destroy(void *data)
 
 	dev->channels = g_slist_remove(dev->channels, hdp_chan);
 
-	if (hdp_chan->mdep != HDP_MDEP_ECHO)
-		g_dbus_emit_signal(btd_get_dbus_connection(),
-					device_get_path(dev->dev),
-					HEALTH_DEVICE, "ChannelDeleted",
-					DBUS_TYPE_OBJECT_PATH, &hdp_chan->path,
-					DBUS_TYPE_INVALID);
-
 	if (hdp_chan == dev->fr) {
 		hdp_channel_unref(dev->fr);
 		dev->fr = NULL;
@@ -996,11 +984,6 @@ static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 		goto end;
 	}
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), device_get_path(dev->dev),
-				HEALTH_DEVICE, "ChannelConnected",
-				DBUS_TYPE_OBJECT_PATH, &chan->path,
-				DBUS_TYPE_INVALID);
-
 	chan->connected = TRUE;
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), chan->path,
@@ -1073,12 +1056,6 @@ static void hdp_mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 						hdp_channel_ref(dev->ndc));
 
 	if (dev->ndc->mdep != HDP_MDEP_ECHO) {
-		g_dbus_emit_signal(btd_get_dbus_connection(),
-					device_get_path(dev->dev),
-					HEALTH_DEVICE, "ChannelConnected",
-					DBUS_TYPE_OBJECT_PATH, &dev->ndc->path,
-					DBUS_TYPE_INVALID);
-
 		dev->ndc->connected = TRUE;
 
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
@@ -1703,12 +1680,6 @@ static void abort_mdl_connection_cb(GError *err, gpointer data)
 	/* Connection operation has failed but we have to */
 	/* notify the channel created at MCAP level */
 	if (hdp_chann->mdep != HDP_MDEP_ECHO) {
-		g_dbus_emit_signal(btd_get_dbus_connection(),
-					device_get_path(hdp_chann->dev->dev),
-					HEALTH_DEVICE, "ChannelConnected",
-					DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
-					DBUS_TYPE_INVALID);
-
 		hdp_chann->connected = TRUE;
 
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
@@ -1750,11 +1721,6 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 					DBUS_TYPE_INVALID);
 	g_dbus_send_message(conn, reply);
 
-	g_dbus_emit_signal(conn, device_get_path(hdp_chann->dev->dev),
-				HEALTH_DEVICE, "ChannelConnected",
-				DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
-				DBUS_TYPE_INVALID);
-
 	hdp_chann->connected = TRUE;
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), hdp_chann->path,
@@ -2189,14 +2155,6 @@ static const GDBusMethodTable health_device_methods[] = {
 	{ }
 };
 
-static const GDBusSignalTable health_device_signals[] = {
-	{ GDBUS_SIGNAL("ChannelConnected",
-			GDBUS_ARGS({ "channel", "o" })) },
-	{ GDBUS_SIGNAL("ChannelDeleted",
-			GDBUS_ARGS({ "channel", "o" })) },
-	{ }
-};
-
 static const GDBusPropertyTable health_device_properties[] = {
 	{ "MainChannel", "o", dev_property_get_main_channel, NULL,
 					dev_property_exists_main_channel },
@@ -2226,7 +2184,7 @@ static struct hdp_device *create_health_device(struct btd_device *device)
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					path, HEALTH_DEVICE,
 					health_device_methods,
-					health_device_signals,
+					NULL,
 					health_device_properties,
 					dev, health_device_destroy)) {
 		error("D-Bus failed to register %s interface", HEALTH_DEVICE);
-- 
1.8.1.2

