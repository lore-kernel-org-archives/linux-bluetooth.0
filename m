Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 2 Apr 2009 17:25:04 +0800
Message-ID: <ac8af0be0904020225s8eb1971k5d1f623540df3fd@mail.gmail.com>
Subject: [PATCH 2/4] add the basic framework support for HFP Audio gateway --
	take 4 -- resend
From: Zhao Forrest <forrest.zhao@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/audio/device.c b/audio/device.c
index f66cd61..611bef3 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -53,6 +53,7 @@
 #include "avdtp.h"
 #include "control.h"
 #include "headset.h"
+#include "gateway.h"
 #include "sink.h"

 #define AUDIO_INTERFACE "org.bluez.Audio"
@@ -602,6 +603,9 @@ gboolean audio_device_is_connected(struct audio_device *dev,
 	else if (!strcmp(interface, AUDIO_CONTROL_INTERFACE) && dev->control &&
 			control_is_active(dev))
 		return TRUE;
+	else if (!strcmp(interface, AUDIO_GATEWAY_INTERFACE) && dev->gateway &&
+			gateway_is_connected(dev))
+		return TRUE;

 	return FALSE;
 }
diff --git a/audio/gateway.c b/audio/gateway.c
index edf38de..cf37e4b 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2006-2007  Nokia Corporation
  *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2008-2009  Leonid Movshovich <event.riga@gmail.org>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -27,8 +28,71 @@
 #endif

 #include <stdint.h>
+#include <errno.h>

 #include <glib.h>
 #include <dbus/dbus.h>
+#include <gdbus.h>

+#include <bluetooth/bluetooth.h>
+
+#include "device.h"
 #include "gateway.h"
+
+struct gateway {
+	GIOChannel *rfcomm;
+	guint rfcomm_watch_id;
+	GIOChannel *sco;
+	GIOChannel *sco_server;
+	gateway_stream_cb_t sco_start_cb;
+	void *sco_start_cb_data;
+	DBusMessage *connect_message;
+	guint ag_features;
+	guint hold_multiparty_features;
+	GSList *indies;
+	gboolean is_dialing;
+};
+
+static GDBusMethodTable gateway_methods[] = {
+	{ NULL, NULL, NULL, NULL }
+};
+
+static GDBusSignalTable gateway_signals[] = {
+	{ NULL, NULL }
+};
+
+struct gateway *gateway_init(struct audio_device *dev)
+{
+	struct gateway *gw;
+
+	if (!g_dbus_register_interface(dev->conn, dev->path,
+					AUDIO_GATEWAY_INTERFACE,
+					gateway_methods, gateway_signals,
+					NULL, dev, NULL))
+		return NULL;
+
+	gw = g_new0(struct gateway, 1);
+	gw->indies = NULL;
+	gw->is_dialing = FALSE;
+	return gw;
+
+}
+
+gboolean gateway_is_connected(struct audio_device *dev)
+{
+	return (dev && dev->gateway && dev->gateway->rfcomm);
+}
+
+int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
+{
+	if (!io)
+		return -EINVAL;
+
+	dev->gateway->rfcomm = io;
+
+	return 0;
+}
+
+void gateway_start_service(struct audio_device *device)
+{
+}
diff --git a/audio/gateway.h b/audio/gateway.h
index e93406b..78eef87 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -22,13 +22,13 @@
  *
  */

-#define AUDIO_GATEWAY_INTERFACE "org.bluez.Gateway"
+#define AUDIO_GATEWAY_INTERFACE "org.bluez.HeadsetGateway"

 #define DEFAULT_HSP_HS_CHANNEL 6
 #define DEFAULT_HFP_HS_CHANNEL 7

-int gateway_init(DBusConnection *conn, gboolean disable_hfp, gboolean sco_hci);
-
-void gateway_exit(void);
-
-gboolean gateway_is_enabled(uint16_t svc);
+typedef void (*gateway_stream_cb_t) (struct audio_device *dev, void
*user_data);
+struct gateway *gateway_init(struct audio_device *device);
+gboolean gateway_is_connected(struct audio_device *dev);
+int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *chan);
+void gateway_start_service(struct audio_device *device);
diff --git a/audio/manager.c b/audio/manager.c
index 3dec75a..12af8e5 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -92,10 +92,10 @@ struct audio_adapter {
 	char	*path;
 	uint32_t hsp_ag_record_id;
 	uint32_t hfp_ag_record_id;
-	uint32_t hsp_hs_record_id;
+	uint32_t hfp_hs_record_id;
 	GIOChannel *hsp_ag_server;
 	GIOChannel *hfp_ag_server;
-	GIOChannel *hsp_hs_server;
+	GIOChannel *hfp_hs_server;
 };

 static gboolean auto_connect = TRUE;
@@ -108,7 +108,7 @@ static GSList *devices = NULL;
 static struct enabled_interfaces enabled = {
 	.hfp		= TRUE,
 	.headset	= TRUE,
-	.gateway	= FALSE,
+	.gateway	= TRUE,
 	.sink		= TRUE,
 	.source		= FALSE,
 	.control	= TRUE,
@@ -134,11 +134,11 @@ gboolean server_is_enabled(bdaddr_t *src, uint16_t svc)
 	case HEADSET_SVCLASS_ID:
 		return enabled.headset;
 	case HEADSET_AGW_SVCLASS_ID:
-		return enabled.gateway;
+		return  FALSE;
 	case HANDSFREE_SVCLASS_ID:
 		return enabled.headset && enabled.hfp;
 	case HANDSFREE_AGW_SVCLASS_ID:
-		return  FALSE;
+		return enabled.gateway;
 	case AUDIO_SINK_SVCLASS_ID:
 		return enabled.sink;
 	case AV_REMOTE_TARGET_SVCLASS_ID:
@@ -194,6 +194,8 @@ static void handle_uuid(const char *uuidstr,
struct audio_device *device)
 		break;
 	case HANDSFREE_AGW_SVCLASS_ID:
 		debug("Found Handsfree AG record");
+		if (device->gateway == NULL)
+			device->gateway = gateway_init(device);
 		break;
 	case AUDIO_SINK_SVCLASS_ID:
 		debug("Found Audio Sink");
@@ -279,7 +281,7 @@ static sdp_record_t *hsp_ag_record(uint8_t ch)
 	return record;
 }

-static sdp_record_t *hsp_hs_record(uint8_t ch)
+static sdp_record_t *hfp_hs_record(uint8_t ch)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
 	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
@@ -297,13 +299,13 @@ static sdp_record_t *hsp_hs_record(uint8_t ch)
 	root = sdp_list_append(0, &root_uuid);
 	sdp_set_browse_groups(record, root);

-	sdp_uuid16_create(&svclass_uuid, HEADSET_SVCLASS_ID);
+	sdp_uuid16_create(&svclass_uuid, HANDSFREE_SVCLASS_ID);
 	svclass_id = sdp_list_append(0, &svclass_uuid);
 	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
 	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
 	sdp_set_service_classes(record, svclass_id);

-	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
+	sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
 	profile.version = 0x0100;
 	pfseq = sdp_list_append(0, &profile);
 	sdp_set_profile_descs(record, pfseq);
@@ -321,7 +323,7 @@ static sdp_record_t *hsp_hs_record(uint8_t ch)
 	aproto = sdp_list_append(0, apseq);
 	sdp_set_access_protos(record, aproto);

-	sdp_set_info_attr(record, "Headset", 0, 0);
+	sdp_set_info_attr(record, "Hands-Free", 0, 0);

 	sdp_data_free(channel);
 	sdp_list_free(proto[0], 0);
@@ -400,7 +402,7 @@ static sdp_record_t *hfp_ag_record(uint8_t ch,
uint32_t feat)
 	return record;
 }

-static void auth_cb(DBusError *derr, void *user_data)
+static void headset_auth_cb(DBusError *derr, void *user_data)
 {
 	struct audio_device *device = user_data;
 	GError *err = NULL;
@@ -483,7 +485,7 @@ static void ag_confirm(GIOChannel *chan, gpointer data)
 	headset_set_state(device, HEADSET_STATE_CONNECT_IN_PROGRESS);

 	perr = btd_request_authorization(&device->src, &device->dst,
-					server_uuid, auth_cb, device);
+					server_uuid, headset_auth_cb, device);
 	if (perr < 0) {
 		debug("Authorization denied: %s", strerror(-perr));
 		headset_set_state(device, HEADSET_STATE_DISCONNECTED);
@@ -498,9 +500,81 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }

-static void hs_io_cb(GIOChannel *chan, GError *err, void *data)
+static void gateway_auth_cb(DBusError *derr, void *user_data)
+{
+	struct audio_device *device = user_data;
+
+	if (derr && dbus_error_is_set(derr))
+		error("Access denied: %s", derr->message);
+	else {
+		char ag_address[18];
+
+		ba2str(&device->dst, ag_address);
+		debug("Accepted AG connection from %s for %s",
+			ag_address, device->path);
+
+		gateway_start_service(device);
+	}
+}
+
+static void hf_io_cb(GIOChannel *chan, gpointer data)
 {
-	/*Stub*/
+	bdaddr_t src, dst;
+	GError *err = NULL;
+	uint8_t ch;
+	const char *server_uuid, *remote_uuid;
+	uint16_t svclass;
+	struct audio_device *device;
+	int perr;
+
+	bt_io_get(chan, BT_IO_RFCOMM, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_CHANNEL, &ch,
+			BT_IO_OPT_INVALID);
+
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		return;
+	}
+
+	server_uuid = HFP_HS_UUID;
+	remote_uuid = HFP_AG_UUID;
+	svclass = HANDSFREE_AGW_SVCLASS_ID;
+
+	device = manager_get_device(&src, &dst);
+	if (!device)
+		goto drop;
+
+	if (!device->gateway) {
+		btd_device_add_uuid(device->btd_dev, remote_uuid);
+		if (!device->gateway)
+			goto drop;
+	}
+
+	if (gateway_is_connected(device)) {
+		debug("Refusing new connection since one already exists");
+		goto drop;
+	}
+
+	if (gateway_connect_rfcomm(device, chan) < 0) {
+		error("Allocating new GIOChannel failed!");
+		goto drop;
+	}
+
+	perr = btd_request_authorization(&device->src, &device->dst,
+				server_uuid, gateway_auth_cb, device);
+	if (perr < 0) {
+		debug("Authorization denied!");
+		goto drop;
+	}
+
+	return;
+
+drop:
+	g_io_channel_close(chan);
+	g_io_channel_unref(chan);
 	return;
 }

@@ -602,7 +676,7 @@ failed:

 static int gateway_server_init(struct audio_adapter *adapter)
 {
-	uint8_t chan = DEFAULT_HSP_HS_CHANNEL;
+	uint8_t chan = DEFAULT_HFP_HS_CHANNEL;
 	sdp_record_t *record;
 	gboolean master = TRUE;
 	GError *err = NULL;
@@ -620,7 +694,7 @@ static int gateway_server_init(struct
audio_adapter *adapter)
 			master = tmp;
 	}

-	io = bt_io_listen(BT_IO_RFCOMM, hs_io_cb, NULL, adapter, NULL, &err,
+	io = bt_io_listen(BT_IO_RFCOMM, NULL, hf_io_cb, adapter, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter->src,
 				BT_IO_OPT_CHANNEL, chan,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
@@ -632,23 +706,22 @@ static int gateway_server_init(struct
audio_adapter *adapter)
 		return -1;
 	}

-	adapter->hsp_hs_server = io;
-
-	record = hsp_hs_record(chan);
+	adapter->hfp_hs_server = io;
+	record = hfp_hs_record(chan);
 	if (!record) {
 		error("Unable to allocate new service record");
 		return -1;
 	}

 	if (add_record_to_server(&adapter->src, record) < 0) {
-		error("Unable to register HSP HS service record");
+		error("Unable to register HFP HS service record");
 		sdp_record_free(record);
-		g_io_channel_unref(adapter->hsp_hs_server);
-		adapter->hsp_hs_server = NULL;
+		g_io_channel_unref(adapter->hfp_hs_server);
+		adapter->hfp_hs_server = NULL;
 		return -1;
 	}

-	adapter->hsp_hs_record_id = record->handle;
+	adapter->hfp_hs_record_id = record->handle;

 	return 0;
 }
@@ -790,14 +863,14 @@ static void gateway_server_remove(struct
btd_adapter *adapter)
 	if (!adp)
 		return;

-	if (adp->hsp_hs_record_id) {
-		remove_record_from_server(adp->hsp_hs_record_id);
-		adp->hsp_hs_record_id = 0;
+	if (adp->hfp_hs_record_id) {
+		remove_record_from_server(adp->hfp_hs_record_id);
+		adp->hfp_hs_record_id = 0;
 	}

-	if (adp->hsp_hs_server) {
-		g_io_channel_unref(adp->hsp_hs_server);
-		adp->hsp_hs_server = NULL;
+	if (adp->hfp_hs_server) {
+		g_io_channel_unref(adp->hfp_hs_server);
+		adp->hfp_hs_server = NULL;
 	}
 }

@@ -1034,6 +1107,10 @@ struct audio_device *manager_find_device(const
char *path,
 				&& !dev->headset)
 			continue;

+		if (interface && !strcmp(AUDIO_GATEWAY_INTERFACE, interface)
+				&& !dev->gateway)
+			continue;
+
 		if (interface && !strcmp(AUDIO_SINK_INTERFACE, interface)
 				&& !dev->sink)
 			continue;
