Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/13] audio: Remove code using headset
Date: Tue, 13 Nov 2012 15:21:09 +0200
Message-Id: <1352812880-7306-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
References: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is to be replaced with external profile support.
---
 audio/device.c    | 191 +-----------------------------------------------
 audio/headset.c   |   3 -
 audio/main.c      |  28 +------
 audio/manager.c   |  48 +-----------
 audio/manager.h   |   3 -
 audio/media.c     |  74 +------------------
 audio/transport.c | 215 ------------------------------------------------------
 7 files changed, 9 insertions(+), 553 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index aee4161..aaa666d 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -53,7 +53,6 @@
 #include "control.h"
 #include "avctp.h"
 #include "avrcp.h"
-#include "headset.h"
 #include "gateway.h"
 #include "sink.h"
 #include "source.h"
@@ -74,7 +73,6 @@ typedef enum {
 struct dev_priv {
 	audio_state_t state;
 
-	headset_state_t hs_state;
 	sink_state_t sink_state;
 	avctp_state_t avctp_state;
 
@@ -92,7 +90,6 @@ struct dev_priv {
 static unsigned int sink_callback_id = 0;
 static unsigned int avctp_callback_id = 0;
 static unsigned int avdtp_callback_id = 0;
-static unsigned int headset_callback_id = 0;
 
 static void device_free(struct audio_device *dev)
 {
@@ -208,8 +205,6 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 
 	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
 		sink_shutdown(dev->sink);
-	else if (priv->hs_state != HEADSET_STATE_DISCONNECTED)
-		headset_shutdown(dev);
 	else
 		priv->disconnecting = FALSE;
 }
@@ -270,84 +265,6 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 				DBUS_TYPE_STRING, &state_str);
 }
 
-static gboolean avdtp_connect_timeout(gpointer user_data)
-{
-	struct audio_device *dev = user_data;
-
-	dev->priv->avdtp_timer = 0;
-
-	if (dev->sink) {
-		struct avdtp *session = avdtp_get(&dev->src, &dev->dst);
-
-		if (!session)
-			return FALSE;
-
-		sink_setup_stream(dev->sink, session);
-		avdtp_unref(session);
-	}
-
-	return FALSE;
-}
-
-static gboolean device_set_avdtp_timer(struct audio_device *dev)
-{
-	struct dev_priv *priv = dev->priv;
-	guint timeout = AVDTP_CONNECT_TIMEOUT;
-
-	if (!dev->sink)
-		return FALSE;
-
-	if (priv->avdtp_timer)
-		return FALSE;
-
-	/* If the headset is the HSP/HFP RFCOMM initiator, give the headset
-	 * time to initiate AVDTP signalling (and avoid further racing) */
-	if (dev->headset && headset_get_rfcomm_initiator(dev))
-		timeout += AVDTP_CONNECT_TIMEOUT_BOOST;
-
-	priv->avdtp_timer = g_timeout_add_seconds(timeout,
-							avdtp_connect_timeout,
-							dev);
-
-	return TRUE;
-}
-
-static gboolean headset_connect_timeout(gpointer user_data)
-{
-	struct audio_device *dev = user_data;
-	struct dev_priv *priv = dev->priv;
-
-	dev->priv->headset_timer = 0;
-
-	if (dev->headset == NULL)
-		return FALSE;
-
-	if (headset_config_stream(dev, FALSE, NULL, NULL) == 0) {
-		if (priv->state != AUDIO_STATE_CONNECTED &&
-				(priv->sink_state == SINK_STATE_CONNECTED ||
-				priv->sink_state == SINK_STATE_PLAYING))
-			device_set_state(dev, AUDIO_STATE_CONNECTED);
-	}
-
-	return FALSE;
-}
-
-static gboolean device_set_headset_timer(struct audio_device *dev)
-{
-	struct dev_priv *priv = dev->priv;
-
-	if (!dev->headset)
-		return FALSE;
-
-	if (priv->headset_timer)
-		return FALSE;
-
-	priv->headset_timer = g_timeout_add_seconds(HEADSET_CONNECT_TIMEOUT,
-						headset_connect_timeout, dev);
-
-	return TRUE;
-}
-
 static void device_avdtp_cb(struct audio_device *dev, struct avdtp *session,
 				avdtp_session_state_t old_state,
 				avdtp_session_state_t new_state,
@@ -382,44 +299,17 @@ static void device_sink_cb(struct audio_device *dev,
 			device_remove_control_timer(dev);
 			avrcp_disconnect(dev);
 		}
-		if (priv->hs_state != HEADSET_STATE_DISCONNECTED &&
-				(priv->dc_req || priv->disconnecting)) {
-			headset_shutdown(dev);
-			break;
-		}
-		if (priv->hs_state == HEADSET_STATE_DISCONNECTED)
-			device_set_state(dev, AUDIO_STATE_DISCONNECTED);
-		else if (old_state == SINK_STATE_CONNECTING) {
-			switch (priv->hs_state) {
-			case HEADSET_STATE_CONNECTED:
-			case HEADSET_STATE_PLAY_IN_PROGRESS:
-			case HEADSET_STATE_PLAYING:
-				device_set_state(dev, AUDIO_STATE_CONNECTED);
-			default:
-				break;
-			}
-		}
+
+		device_set_state(dev, AUDIO_STATE_DISCONNECTED);
 		break;
 	case SINK_STATE_CONNECTING:
 		device_remove_avdtp_timer(dev);
-		if (priv->hs_state == HEADSET_STATE_DISCONNECTED)
-			device_set_state(dev, AUDIO_STATE_CONNECTING);
+		device_set_state(dev, AUDIO_STATE_CONNECTING);
 		break;
 	case SINK_STATE_CONNECTED:
 		if (old_state == SINK_STATE_PLAYING)
 			break;
-		if (dev->auto_connect) {
-			if (!dev->headset)
-				device_set_state(dev, AUDIO_STATE_CONNECTED);
-			else if (priv->hs_state == HEADSET_STATE_DISCONNECTED)
-				device_set_headset_timer(dev);
-			else if (priv->hs_state == HEADSET_STATE_CONNECTED ||
-					priv->hs_state == HEADSET_STATE_PLAY_IN_PROGRESS ||
-					priv->hs_state == HEADSET_STATE_PLAYING)
-				device_set_state(dev, AUDIO_STATE_CONNECTED);
-		} else if (priv->hs_state == HEADSET_STATE_DISCONNECTED ||
-				priv->hs_state == HEADSET_STATE_CONNECTING)
-			device_set_state(dev, AUDIO_STATE_CONNECTED);
+		device_set_state(dev, AUDIO_STATE_CONNECTED);
 		break;
 	case SINK_STATE_PLAYING:
 		break;
@@ -447,62 +337,6 @@ static void device_avctp_cb(struct audio_device *dev,
 	}
 }
 
-static void device_headset_cb(struct audio_device *dev,
-				headset_state_t old_state,
-				headset_state_t new_state,
-				void *user_data)
-{
-	struct dev_priv *priv = dev->priv;
-
-	if (!dev->headset)
-		return;
-
-	priv->hs_state = new_state;
-
-	switch (new_state) {
-	case HEADSET_STATE_DISCONNECTED:
-		device_remove_avdtp_timer(dev);
-		if (priv->sink_state != SINK_STATE_DISCONNECTED && dev->sink &&
-				(priv->dc_req || priv->disconnecting)) {
-			sink_shutdown(dev->sink);
-			break;
-		}
-		if (priv->sink_state == SINK_STATE_DISCONNECTED)
-			device_set_state(dev, AUDIO_STATE_DISCONNECTED);
-		else if (old_state == HEADSET_STATE_CONNECTING &&
-				(priv->sink_state == SINK_STATE_CONNECTED ||
-				priv->sink_state == SINK_STATE_PLAYING))
-			device_set_state(dev, AUDIO_STATE_CONNECTED);
-		break;
-	case HEADSET_STATE_CONNECTING:
-		device_remove_headset_timer(dev);
-		if (priv->sink_state == SINK_STATE_DISCONNECTED)
-			device_set_state(dev, AUDIO_STATE_CONNECTING);
-		break;
-	case HEADSET_STATE_CONNECTED:
-		if (old_state == HEADSET_STATE_CONNECTED ||
-				old_state == HEADSET_STATE_PLAY_IN_PROGRESS ||
-				old_state == HEADSET_STATE_PLAYING)
-			break;
-		if (dev->auto_connect) {
-			if (!dev->sink)
-				device_set_state(dev, AUDIO_STATE_CONNECTED);
-			else if (priv->sink_state == SINK_STATE_DISCONNECTED)
-				device_set_avdtp_timer(dev);
-			else if (priv->sink_state == SINK_STATE_CONNECTED ||
-					priv->sink_state == SINK_STATE_PLAYING)
-				device_set_state(dev, AUDIO_STATE_CONNECTED);
-		} else if (priv->sink_state == SINK_STATE_DISCONNECTED ||
-				priv->sink_state == SINK_STATE_CONNECTING)
-			device_set_state(dev, AUDIO_STATE_CONNECTED);
-		break;
-	case HEADSET_STATE_PLAY_IN_PROGRESS:
-		break;
-	case HEADSET_STATE_PLAYING:
-		break;
-	}
-}
-
 static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -516,9 +350,6 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 
 	dev->auto_connect = TRUE;
 
-	if (dev->headset)
-		headset_config_stream(dev, FALSE, NULL, NULL);
-
 	if (priv->state != AUDIO_STATE_CONNECTING && dev->sink) {
 		struct avdtp *session = avdtp_get(&dev->src, &dev->dst);
 
@@ -561,8 +392,6 @@ static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 
 	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
 		sink_shutdown(dev->sink);
-	else if (priv->hs_state != HEADSET_STATE_DISCONNECTED)
-		headset_shutdown(dev);
 	else {
 		dbus_message_unref(priv->dc_req);
 		priv->dc_req = NULL;
@@ -652,10 +481,6 @@ struct audio_device *audio_device_register(struct btd_device *device,
 	if (avctp_callback_id == 0)
 		avctp_callback_id = avctp_add_state_cb(device_avctp_cb, NULL);
 
-	if (headset_callback_id == 0)
-		headset_callback_id = headset_add_state_cb(device_headset_cb,
-									NULL);
-
 	return dev;
 }
 
@@ -666,17 +491,12 @@ gboolean audio_device_is_active(struct audio_device *dev,
 		if ((dev->sink || dev->source) &&
 				avdtp_is_connected(&dev->src, &dev->dst))
 			return TRUE;
-		if (dev->headset && headset_is_active(dev))
-			return TRUE;
 	} else if (!strcmp(interface, AUDIO_SINK_INTERFACE) && dev->sink &&
 				avdtp_is_connected(&dev->src, &dev->dst))
 		return TRUE;
 	else if (!strcmp(interface, AUDIO_SOURCE_INTERFACE) && dev->source &&
 				avdtp_is_connected(&dev->src, &dev->dst))
 		return TRUE;
-	else if (!strcmp(interface, AUDIO_HEADSET_INTERFACE) && dev->headset &&
-				headset_is_active(dev))
-		return TRUE;
 	else if (!strcmp(interface, AUDIO_CONTROL_INTERFACE) && dev->control &&
 				control_is_active(dev))
 		return TRUE;
@@ -694,9 +514,6 @@ void audio_device_unregister(struct audio_device *device)
 		device->hs_preauth_id = 0;
 	}
 
-	if (device->headset)
-		headset_unregister(device);
-
 	if (device->gateway)
 		gateway_unregister(device);
 
diff --git a/audio/headset.c b/audio/headset.c
index 5e42a61..fb660f5 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1614,9 +1614,6 @@ static int rfcomm_connect(struct audio_device *dev, headset_stream_cb_t cb,
 	char address[18];
 	GError *err = NULL;
 
-	if (!manager_allow_headset_connection(dev))
-		return -ECONNREFUSED;
-
 	if (hs->rfcomm_ch < 0)
 		return get_records(dev, cb, user_data, cb_id);
 
diff --git a/audio/main.c b/audio/main.c
index f7bb32a..a423b79 100644
--- a/audio/main.c
+++ b/audio/main.c
@@ -42,7 +42,6 @@
 #include "plugin.h"
 #include "log.h"
 #include "device.h"
-#include "headset.h"
 #include "manager.h"
 #include "gateway.h"
 
@@ -89,36 +88,12 @@ static void sco_server_cb(GIOChannel *chan, GError *err, gpointer data)
 		goto drop;
 	}
 
-	device = manager_find_device(NULL, &src, &dst, AUDIO_HEADSET_INTERFACE,
-					FALSE);
-	if (!device)
-		device = manager_find_device(NULL, &src, &dst,
+	device = manager_find_device(NULL, &src, &dst,
 						AUDIO_GATEWAY_INTERFACE,
 						FALSE);
-
 	if (!device)
 		goto drop;
 
-	if (device->headset) {
-		if (headset_get_state(device) < HEADSET_STATE_CONNECTED) {
-			DBG("Refusing SCO from non-connected headset");
-			goto gateway;
-		}
-
-		if (!headset_get_hfp_active(device)) {
-			error("Refusing non-HFP SCO connect attempt from %s",
-									addr);
-			goto drop;
-		}
-
-		if (headset_connect_sco(device, chan) < 0)
-			goto drop;
-
-		headset_set_state(device, HEADSET_STATE_PLAYING);
-		goto connect;
-	}
-
-gateway:
 	if (device->gateway) {
 		if (!gateway_is_connected(device)) {
 			DBG("Refusing SCO from non-connected AG");
@@ -130,7 +105,6 @@ gateway:
 	} else
 		goto drop;
 
-connect:
 	sk = g_io_channel_unix_get_fd(chan);
 	fcntl(sk, F_SETFL, 0);
 
diff --git a/audio/manager.c b/audio/manager.c
index e949509..d151f16 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -61,7 +61,6 @@
 #include "avdtp.h"
 #include "media.h"
 #include "a2dp.h"
-#include "headset.h"
 #include "gateway.h"
 #include "sink.h"
 #include "source.h"
@@ -637,9 +636,7 @@ int audio_manager_init(GKeyFile *conf, gboolean *enable_sco)
 	list = g_key_file_get_string_list(config, "General", "Enable",
 						NULL, NULL);
 	for (i = 0; list && list[i] != NULL; i++) {
-		if (g_str_equal(list[i], "Headset"))
-			enabled.headset = TRUE;
-		else if (g_str_equal(list[i], "Gateway"))
+		if (g_str_equal(list[i], "Gateway"))
 			enabled.gateway = TRUE;
 		else if (g_str_equal(list[i], "Sink"))
 			enabled.sink = TRUE;
@@ -653,9 +650,7 @@ int audio_manager_init(GKeyFile *conf, gboolean *enable_sco)
 	list = g_key_file_get_string_list(config, "General", "Disable",
 						NULL, NULL);
 	for (i = 0; list && list[i] != NULL; i++) {
-		if (g_str_equal(list[i], "Headset"))
-			enabled.headset = FALSE;
-		else if (g_str_equal(list[i], "Gateway"))
+		if (g_str_equal(list[i], "Gateway"))
 			enabled.gateway = FALSE;
 		else if (g_str_equal(list[i], "Sink"))
 			enabled.sink = FALSE;
@@ -694,7 +689,7 @@ proceed:
 
 	btd_register_adapter_driver(&media_driver);
 
-	*enable_sco = (enabled.gateway || enabled.headset);
+	*enable_sco = enabled.gateway;
 
 	return 0;
 }
@@ -740,10 +735,6 @@ GSList *manager_find_devices(const char *path,
 		if ((dst && bacmp(dst, BDADDR_ANY)) && bacmp(&dev->dst, dst))
 			continue;
 
-		if (interface && !strcmp(AUDIO_HEADSET_INTERFACE, interface)
-				&& !dev->headset)
-			continue;
-
 		if (interface && !strcmp(AUDIO_GATEWAY_INTERFACE, interface)
 				&& !dev->gateway)
 			continue;
@@ -829,43 +820,10 @@ struct audio_device *manager_get_device(const bdaddr_t *src,
 	return dev;
 }
 
-gboolean manager_allow_headset_connection(struct audio_device *device)
-{
-	GSList *l;
-	int connected = 0;
-
-	for (l = devices; l != NULL; l = l->next) {
-		struct audio_device *dev = l->data;
-		struct headset *hs = dev->headset;
-
-		if (dev == device)
-			continue;
-
-		if (device && bacmp(&dev->src, &device->src) != 0)
-			continue;
-
-		if (!hs)
-			continue;
-
-		if (headset_get_state(dev) > HEADSET_STATE_DISCONNECTED)
-			connected++;
-
-		if (connected >= max_connected_headsets)
-			return FALSE;
-	}
-
-	return TRUE;
-}
-
 void manager_set_fast_connectable(gboolean enable)
 {
 	GSList *l;
 
-	if (enable && !manager_allow_headset_connection(NULL)) {
-		DBG("Refusing enabling fast connectable");
-		return;
-	}
-
 	for (l = adapters; l != NULL; l = l->next) {
 		struct audio_adapter *adapter = l->data;
 
diff --git a/audio/manager.h b/audio/manager.h
index 8fb208c..d3b5692 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -23,7 +23,6 @@
  */
 
 struct enabled_interfaces {
-	gboolean headset;
 	gboolean gateway;
 	gboolean sink;
 	gboolean source;
@@ -50,8 +49,6 @@ struct audio_device *manager_get_device(const bdaddr_t *src,
 					const bdaddr_t *dst,
 					gboolean create);
 
-gboolean manager_allow_headset_connection(struct audio_device *device);
-
 /* TRUE to enable fast connectable and FALSE to disable fast connectable for all
  * audio adapters. */
 void manager_set_fast_connectable(gboolean enable);
diff --git a/audio/media.c b/audio/media.c
index cec938a..ea0b44e 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -46,7 +46,6 @@
 #include "transport.h"
 #include "a2dp.h"
 #include "avrcp.h"
-#include "headset.h"
 #include "gateway.h"
 #include "manager.h"
 
@@ -141,9 +140,6 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
 {
 	DBG("sender=%s path=%s", endpoint->sender, endpoint->path);
 
-	if (endpoint->hs_watch)
-		headset_remove_state_cb(endpoint->hs_watch);
-
 	if (endpoint->ag_watch)
 		gateway_remove_state_cb(endpoint->ag_watch);
 
@@ -185,17 +181,6 @@ static void media_endpoint_exit(DBusConnection *connection, void *user_data)
 	media_endpoint_remove(endpoint);
 }
 
-static void headset_setconf_cb(struct media_endpoint *endpoint, void *ret,
-						int size, void *user_data)
-{
-	struct audio_device *dev = user_data;
-
-	if (ret != NULL)
-		return;
-
-	headset_shutdown(dev);
-}
-
 static void clear_configuration(struct media_endpoint *endpoint,
 					struct media_transport *transport)
 {
@@ -449,41 +434,6 @@ done:
 	media_endpoint_remove(endpoint);
 }
 
-static void headset_state_changed(struct audio_device *dev,
-					headset_state_t old_state,
-					headset_state_t new_state,
-					void *user_data)
-{
-	struct media_endpoint *endpoint = user_data;
-	struct media_transport *transport;
-
-	DBG("");
-
-	if (bacmp(&endpoint->adapter->src, &dev->src) != 0)
-		return;
-
-	switch (new_state) {
-	case HEADSET_STATE_DISCONNECTED:
-		transport = find_device_transport(endpoint, dev);
-
-		if (transport != NULL) {
-			DBG("Clear endpoint %p", endpoint);
-			clear_configuration(endpoint, transport);
-		}
-		break;
-	case HEADSET_STATE_CONNECTING:
-		set_configuration(endpoint, dev, NULL, 0, headset_setconf_cb,
-								dev, NULL);
-		break;
-	case HEADSET_STATE_CONNECTED:
-		break;
-	case HEADSET_STATE_PLAY_IN_PROGRESS:
-		break;
-	case HEADSET_STATE_PLAYING:
-		break;
-	}
-}
-
 static const char *get_name(struct a2dp_sep *sep, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
@@ -671,28 +621,6 @@ static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
 	return TRUE;
 }
 
-static gboolean endpoint_init_ag(struct media_endpoint *endpoint, int *err)
-{
-	GSList *list;
-	GSList *l;
-
-	endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
-								endpoint);
-	list = manager_find_devices(NULL, &endpoint->adapter->src, BDADDR_ANY,
-						AUDIO_HEADSET_INTERFACE, TRUE);
-
-	for (l = list; l != NULL; l = l->next) {
-		struct audio_device *dev = l->data;
-
-		set_configuration(endpoint, dev, NULL, 0,
-						headset_setconf_cb, dev, NULL);
-	}
-
-	g_slist_free(list);
-
-	return TRUE;
-}
-
 static gboolean endpoint_init_hs(struct media_endpoint *endpoint, int *err)
 {
 	GSList *list;
@@ -750,7 +678,7 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 							delay_reporting, err);
 	else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
 					strcasecmp(uuid, HSP_AG_UUID) == 0)
-		succeeded = endpoint_init_ag(endpoint, err);
+		succeeded = TRUE;
 	else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
 					strcasecmp(uuid, HSP_HS_UUID) == 0)
 		succeeded = endpoint_init_hs(endpoint, err);
diff --git a/audio/transport.c b/audio/transport.c
index 7ad7033..74562ea 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -44,7 +44,6 @@
 #include "media.h"
 #include "transport.h"
 #include "a2dp.h"
-#include "headset.h"
 #include "gateway.h"
 #include "sink.h"
 #include "source.h"
@@ -212,9 +211,6 @@ void media_transport_destroy(struct media_transport *transport)
 {
 	char *path;
 
-	if (transport->hs_watch)
-		headset_remove_state_cb(transport->hs_watch);
-
 	if (transport->ag_watch)
 		gateway_remove_state_cb(transport->ag_watch);
 
@@ -465,116 +461,6 @@ static void cancel_a2dp(struct media_transport *transport, guint id)
 	a2dp_cancel(transport->device, id);
 }
 
-static void headset_resume_complete(struct audio_device *dev, void *user_data)
-{
-	struct media_owner *owner = user_data;
-	struct media_request *req = owner->pending;
-	struct media_transport *transport = owner->transport;
-	int fd;
-	uint16_t imtu, omtu;
-	gboolean ret;
-
-	req->id = 0;
-
-	if (dev == NULL)
-		goto fail;
-
-	fd = headset_get_sco_fd(dev);
-	if (fd < 0)
-		goto fail;
-
-	imtu = 48;
-	omtu = 48;
-
-	media_transport_set_fd(transport, fd, imtu, omtu);
-
-	if ((owner->lock & TRANSPORT_LOCK_READ) == 0)
-		imtu = 0;
-
-	if ((owner->lock & TRANSPORT_LOCK_WRITE) == 0)
-		omtu = 0;
-
-	ret = g_dbus_send_reply(btd_get_dbus_connection(), req->msg,
-						DBUS_TYPE_UNIX_FD, &fd,
-						DBUS_TYPE_UINT16, &imtu,
-						DBUS_TYPE_UINT16, &omtu,
-						DBUS_TYPE_INVALID);
-	if (ret == FALSE)
-		goto fail;
-
-	media_owner_remove(owner);
-
-	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
-
-	return;
-
-fail:
-	media_transport_remove(transport, owner);
-}
-
-static guint resume_headset(struct media_transport *transport,
-				struct media_owner *owner)
-{
-	struct audio_device *device = transport->device;
-
-	if (state_in_use(transport->state))
-		goto done;
-
-	if (headset_lock(device, HEADSET_LOCK_READ |
-						HEADSET_LOCK_WRITE) == FALSE)
-		return 0;
-
-	if (transport->state == TRANSPORT_STATE_IDLE)
-		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
-
-done:
-	return headset_request_stream(device, headset_resume_complete,
-					owner);
-}
-
-static void headset_suspend_complete(struct audio_device *dev, void *user_data)
-{
-	struct media_owner *owner = user_data;
-	struct media_transport *transport = owner->transport;
-
-	/* Release always succeeds */
-	if (owner->pending) {
-		owner->pending->id = 0;
-		media_request_reply(owner->pending, 0);
-		media_owner_remove(owner);
-	}
-
-	headset_unlock(dev, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
-	transport_set_state(transport, TRANSPORT_STATE_IDLE);
-	media_transport_remove(transport, owner);
-}
-
-static guint suspend_headset(struct media_transport *transport,
-						struct media_owner *owner)
-{
-	struct audio_device *device = transport->device;
-
-	if (!owner) {
-		headset_state_t state = headset_get_state(device);
-
-		headset_unlock(device, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
-
-		if (state == HEADSET_STATE_PLAYING)
-			transport_set_state(transport, TRANSPORT_STATE_PENDING);
-		else
-			transport_set_state(transport, TRANSPORT_STATE_IDLE);
-
-		return 0;
-	}
-
-	return headset_suspend_stream(device, headset_suspend_complete, owner);
-}
-
-static void cancel_headset(struct media_transport *transport, guint id)
-{
-	headset_cancel_stream(transport->device, id);
-}
-
 static void gateway_resume_complete(struct audio_device *dev, GError *err,
 							void *user_data)
 {
@@ -920,33 +806,6 @@ static int set_property_a2dp(struct media_transport *transport,
 	return -EINVAL;
 }
 
-static int set_property_headset(struct media_transport *transport,
-						const char *property,
-						DBusMessageIter *value)
-{
-	if (g_strcmp0(property, "NREC") == 0) {
-		gboolean nrec;
-
-		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
-			return -EINVAL;
-		dbus_message_iter_get_basic(value, &nrec);
-
-		/* FIXME: set new nrec */
-		return 0;
-	} else if (g_strcmp0(property, "InbandRingtone") == 0) {
-		gboolean inband;
-
-		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
-			return -EINVAL;
-		dbus_message_iter_get_basic(value, &inband);
-
-		/* FIXME: set new inband */
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 static int set_property_gateway(struct media_transport *transport,
 						const char *property,
 						DBusMessageIter *value)
@@ -1012,22 +871,6 @@ static void get_properties_a2dp(struct media_transport *transport,
 							&a2dp->volume);
 }
 
-static void get_properties_headset(struct media_transport *transport,
-						DBusMessageIter *dict)
-{
-	gboolean nrec, inband;
-	const char *routing;
-
-	nrec = headset_get_nrec(transport->device);
-	dict_append_entry(dict, "NREC", DBUS_TYPE_BOOLEAN, &nrec);
-
-	inband = headset_get_inband(transport->device);
-	dict_append_entry(dict, "InbandRingtone", DBUS_TYPE_BOOLEAN, &inband);
-
-	routing = headset_get_sco_hci(transport->device) ? "HCI" : "PCM";
-	dict_append_entry(dict, "Routing", DBUS_TYPE_STRING, &routing);
-}
-
 static void get_properties_gateway(struct media_transport *transport,
 						DBusMessageIter *dict)
 {
@@ -1123,16 +966,6 @@ static void destroy_a2dp(void *data)
 	g_free(a2dp);
 }
 
-static void destroy_headset(void *data)
-{
-	struct headset_transport *headset = data;
-
-	if (headset->nrec_id > 0)
-		headset_remove_nrec_cb(headset->device, headset->nrec_id);
-
-	g_free(headset);
-}
-
 static void media_transport_free(void *data)
 {
 	struct media_transport *transport = data;
@@ -1154,18 +987,6 @@ static void media_transport_free(void *data)
 	g_free(transport);
 }
 
-static void headset_nrec_changed(struct audio_device *dev, gboolean nrec,
-							void *user_data)
-{
-	struct media_transport *transport = user_data;
-
-	DBG("");
-
-	emit_property_changed(transport->path,
-				MEDIA_TRANSPORT_INTERFACE, "NREC",
-				DBUS_TYPE_BOOLEAN, &nrec);
-}
-
 static void transport_update_playing(struct media_transport *transport,
 							gboolean playing)
 {
@@ -1188,22 +1009,6 @@ static void transport_update_playing(struct media_transport *transport,
 		transport_set_state(transport, TRANSPORT_STATE_PENDING);
 }
 
-static void headset_state_changed(struct audio_device *dev,
-						headset_state_t old_state,
-						headset_state_t new_state,
-						void *user_data)
-{
-	struct media_transport *transport = user_data;
-
-	if (dev != transport->device)
-		return;
-
-	if (new_state == HEADSET_STATE_PLAYING)
-		transport_update_playing(transport, TRUE);
-	else
-		transport_update_playing(transport, FALSE);
-}
-
 static void gateway_state_changed(struct audio_device *dev,
 						gateway_state_t old_state,
 						gateway_state_t new_state,
@@ -1295,26 +1100,6 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 			transport->source_watch = source_add_state_cb(
 							source_state_changed,
 							transport);
-	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
-			strcasecmp(uuid, HSP_AG_UUID) == 0) {
-		struct headset_transport *headset;
-
-		headset = g_new0(struct headset_transport, 1);
-		headset->device = device;
-		headset->nrec_id = headset_add_nrec_cb(device,
-							headset_nrec_changed,
-							transport);
-
-		transport->resume = resume_headset;
-		transport->suspend = suspend_headset;
-		transport->cancel = cancel_headset;
-		transport->get_properties = get_properties_headset;
-		transport->set_property = set_property_headset;
-		transport->data = headset;
-		transport->destroy = destroy_headset;
-		transport->hs_watch = headset_add_state_cb(
-							headset_state_changed,
-							transport);
 	} else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
 			strcasecmp(uuid, HSP_HS_UUID) == 0) {
 		transport->resume = resume_gateway;
-- 
1.7.11.7

