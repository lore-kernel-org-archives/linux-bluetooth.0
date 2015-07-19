Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, Dohyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH BLUEZ 2/4] profiles/health: Implement connected property in HealthChannel
Date: Mon, 20 Jul 2015 00:31:09 +0900
Message-Id: <1437319871-3004-3-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
References: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the new connected property in HealthChannel,
which gets updated when a health channel is connected and disconnected.
This property will replace ChannelConnected and ChannelDeleted signals
in HealthDevice.

Change-Id: Ie1d2df12bcb9de1a55df3e5f08b664f0a5a61d95
---
 profiles/health/hdp.c       | 74 +++++++++++++++++++++++++++++++++++++++++++--
 profiles/health/hdp_types.h |  1 +
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index bc3b38a..9fd7bf6 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -464,6 +464,18 @@ static gboolean channel_property_get_type(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean channel_property_get_connected(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct hdp_channel *chan = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+					&chan->connected);
+
+	return TRUE;
+}
+
 static void hdp_tmp_dc_data_destroy(gpointer data)
 {
 	struct hdp_tmp_dc_data *hdp_conn = data;
@@ -521,6 +533,11 @@ static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 			HEALTH_DEVICE, "ChannelConnected",
 			DBUS_TYPE_OBJECT_PATH, &dc_data->hdp_chann->path,
 			DBUS_TYPE_INVALID);
+
+	dc_data->hdp_chann->connected = TRUE;
+
+	g_dbus_emit_property_changed(conn, dc_data->hdp_chann->path,
+				HEALTH_CHANNEL, "Connected");
 }
 
 static void hdp_get_dcpsm_cb(uint16_t dcpsm, gpointer user_data, GError *err)
@@ -737,6 +754,7 @@ static const GDBusPropertyTable health_channels_properties[] = {
 	{ "Device", "o",  channel_property_get_device },
 	{ "Application", "o", channel_property_get_application },
 	{ "Type", "s", channel_property_get_type },
+	{ "Connected", "b", channel_property_get_connected },
 	{ }
 };
 
@@ -800,6 +818,12 @@ static void remove_channels(struct hdp_device *dev)
 
 	while (dev->channels != NULL) {
 		chan = dev->channels->data;
+		chan->connected = FALSE;
+
+		if (chan->mdep != HDP_MDEP_ECHO)
+			g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						chan->path,
+						HEALTH_CHANNEL, "Connected");
 
 		path = g_strdup(chan->path);
 		if (!g_dbus_unregister_interface(btd_get_dbus_connection(),
@@ -977,6 +1001,11 @@ static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 				DBUS_TYPE_OBJECT_PATH, &chan->path,
 				DBUS_TYPE_INVALID);
 
+	chan->connected = TRUE;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), chan->path,
+				HEALTH_CHANNEL, "Connected");
+
 	if (dev->fr != NULL)
 		goto end;
 
@@ -1014,6 +1043,12 @@ static void hdp_mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 		return;
 
 	chan = l->data;
+	chan->connected = FALSE;
+
+	if (chan->mdep != HDP_MDEP_ECHO)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					chan->path,
+					HEALTH_CHANNEL, "Connected");
 
 	path = g_strdup(chan->path);
 	if (!g_dbus_unregister_interface(btd_get_dbus_connection(),
@@ -1037,13 +1072,20 @@ static void hdp_mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 		dev->channels = g_slist_prepend(dev->channels,
 						hdp_channel_ref(dev->ndc));
 
-	if (dev->ndc->mdep != HDP_MDEP_ECHO)
+	if (dev->ndc->mdep != HDP_MDEP_ECHO) {
 		g_dbus_emit_signal(btd_get_dbus_connection(),
 					device_get_path(dev->dev),
 					HEALTH_DEVICE, "ChannelConnected",
 					DBUS_TYPE_OBJECT_PATH, &dev->ndc->path,
 					DBUS_TYPE_INVALID);
 
+		dev->ndc->connected = TRUE;
+
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					dev->ndc->path,
+					HEALTH_CHANNEL, "Connected");
+	}
+
 	hdp_channel_unref(dev->ndc);
 	dev->ndc = NULL;
 }
@@ -1266,6 +1308,15 @@ static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
 	hdp_device = l->data;
 	hdp_device->mcl_conn = FALSE;
 
+	/* Set channel connected status to false */
+	if (hdp_device->fr) {
+		hdp_device->fr->connected = FALSE;
+
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					hdp_device->fr->path,
+					HEALTH_CHANNEL, "Connected");
+	}
+
 	DBG("Mcl disconnected %s", device_get_path(hdp_device->dev));
 }
 
@@ -1651,12 +1702,19 @@ static void abort_mdl_connection_cb(GError *err, gpointer data)
 
 	/* Connection operation has failed but we have to */
 	/* notify the channel created at MCAP level */
-	if (hdp_chann->mdep != HDP_MDEP_ECHO)
+	if (hdp_chann->mdep != HDP_MDEP_ECHO) {
 		g_dbus_emit_signal(btd_get_dbus_connection(),
 					device_get_path(hdp_chann->dev->dev),
 					HEALTH_DEVICE, "ChannelConnected",
 					DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
 					DBUS_TYPE_INVALID);
+
+		hdp_chann->connected = TRUE;
+
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					hdp_chann->path,
+					HEALTH_CHANNEL, "Connected");
+	}
 }
 
 static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
@@ -1697,6 +1755,11 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 				DBUS_TYPE_OBJECT_PATH, &hdp_chann->path,
 				DBUS_TYPE_INVALID);
 
+	hdp_chann->connected = TRUE;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), hdp_chann->path,
+					HEALTH_CHANNEL, "Connected");
+
 	if (!check_channel_conf(hdp_chann)) {
 		close_mdl(hdp_chann);
 		return;
@@ -1984,6 +2047,13 @@ static void hdp_mdl_delete_cb(GError *err, gpointer data)
 		return;
 	}
 
+	del_data->hdp_chann->connected = FALSE;
+
+	if (del_data->hdp_chann->mdep != HDP_MDEP_ECHO)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					del_data->hdp_chann->path,
+					HEALTH_CHANNEL, "Connected");
+
 	path = g_strdup(del_data->hdp_chann->path);
 	g_dbus_unregister_interface(conn, path, HEALTH_CHANNEL);
 	g_free(path);
diff --git a/profiles/health/hdp_types.h b/profiles/health/hdp_types.h
index b34b5e0..3db38bb 100644
--- a/profiles/health/hdp_types.h
+++ b/profiles/health/hdp_types.h
@@ -115,6 +115,7 @@ struct hdp_channel {
 	uint16_t		omtu;		/* Channel outgoing MTU */
 	struct hdp_echo_data	*edata;		/* private data used by echo channels */
 	int			ref;		/* Reference counter */
+	gboolean		connected;	/* Connected status */
 };
 
 #endif /* __HDP_TYPES_H__ */
-- 
1.8.1.2

