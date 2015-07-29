Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <dh79.pyun@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, Dohyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH BLUEZ v2 2/2] profiles/health: Remove HealthDevice signals
Date: Wed, 29 Jul 2015 10:23:18 +0900
Message-id: <1438132998-13784-3-git-send-email-dh79.pyun@samsung.com>
In-reply-to: <1438132998-13784-1-git-send-email-dh79.pyun@samsung.com>
References: <1438132998-13784-1-git-send-email-dh79.pyun@samsung.com>
In-reply-to: <1437319871-3004-1-git-send-email-dh79.pyun () samsung ! com>
References: <1437319871-3004-1-git-send-email-dh79.pyun () samsung ! com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes ChannelConnected and ChannelDeleted signals in
HealthDevice interface. These signals are not currently generated
and can be replaced InterfaceAdded and InterfaceRemoved signals.
(org.bluez.HealthChannel1 interface)
---
 profiles/health/hdp.c | 48 +-----------------------------------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index bc3b38a..47f8517 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -516,11 +516,6 @@ static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 	reply = g_dbus_create_reply(dc_data->msg, DBUS_TYPE_UNIX_FD,
 							&fd, DBUS_TYPE_INVALID);
 	g_dbus_send_message(conn, reply);
-
-	g_dbus_emit_signal(conn, device_get_path(dc_data->hdp_chann->dev->dev),
-			HEALTH_DEVICE, "ChannelConnected",
-			DBUS_TYPE_OBJECT_PATH, &dc_data->hdp_chann->path,
-			DBUS_TYPE_INVALID);
 }
 
 static void hdp_get_dcpsm_cb(uint16_t dcpsm, gpointer user_data, GError *err)
@@ -709,13 +704,6 @@ static void health_channel_destroy(void *data)
 
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
@@ -972,11 +960,6 @@ static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 		goto end;
 	}
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), device_get_path(dev->dev),
-				HEALTH_DEVICE, "ChannelConnected",
-				DBUS_TYPE_OBJECT_PATH, &chan->path,
-				DBUS_TYPE_INVALID);
-
 	if (dev->fr != NULL)
 		goto end;
 
@@ -1037,13 +1020,6 @@ static void hdp_mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 		dev->channels = g_slist_prepend(dev->channels,
 						hdp_channel_ref(dev->ndc));
 
-	if (dev->ndc->mdep != HDP_MDEP_ECHO)
-		g_dbus_emit_signal(btd_get_dbus_connection(),
-					device_get_path(dev->dev),
-					HEALTH_DEVICE, "ChannelConnected",
-					DBUS_TYPE_OBJECT_PATH, &dev->ndc->path,
-					DBUS_TYPE_INVALID);
-
 	hdp_channel_unref(dev->ndc);
 	dev->ndc = NULL;
 }
@@ -1648,15 +1624,6 @@ static void abort_mdl_connection_cb(GError *err, gpointer data)
 
 	if (err != NULL)
 		error("Aborting error: %s", err->message);
-
-	/* Connection operation has failed but we have to */
-	/* notify the channel created at MCAP level */
-	if (hdp_chann->mdep != HDP_MDEP_ECHO)
-		g_dbus_emit_signal(btd_get_dbus_connection(),
-					device_get_path(hdp_chann->dev->dev),
-					HEALTH_DEVICE, "ChannelConnected",
-					DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
-					DBUS_TYPE_INVALID);
 }
 
 static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
@@ -1692,11 +1659,6 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 					DBUS_TYPE_INVALID);
 	g_dbus_send_message(conn, reply);
 
-	g_dbus_emit_signal(conn, device_get_path(hdp_chann->dev->dev),
-				HEALTH_DEVICE, "ChannelConnected",
-				DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
-				DBUS_TYPE_INVALID);
-
 	if (!check_channel_conf(hdp_chann)) {
 		close_mdl(hdp_chann);
 		return;
@@ -2119,14 +2081,6 @@ static const GDBusMethodTable health_device_methods[] = {
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
@@ -2156,7 +2110,7 @@ static struct hdp_device *create_health_device(struct btd_device *device)
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

