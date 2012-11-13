Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/13] audio: Remove code HFP and HS gateway role
Date: Tue, 13 Nov 2012 15:21:17 +0200
Message-Id: <1352812880-7306-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
References: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is to be replaced with external profile support.
---
 audio/device.c    |   7 --
 audio/main.c      |  72 +-------------
 audio/manager.c   | 288 +-----------------------------------------------------
 audio/manager.h   |   3 +-
 audio/media.c     |  71 +-------------
 audio/transport.c | 165 -------------------------------
 6 files changed, 8 insertions(+), 598 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index aaa666d..df57d81 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -53,7 +53,6 @@
 #include "control.h"
 #include "avctp.h"
 #include "avrcp.h"
-#include "gateway.h"
 #include "sink.h"
 #include "source.h"
 
@@ -500,9 +499,6 @@ gboolean audio_device_is_active(struct audio_device *dev,
 	else if (!strcmp(interface, AUDIO_CONTROL_INTERFACE) && dev->control &&
 				control_is_active(dev))
 		return TRUE;
-	else if (!strcmp(interface, AUDIO_GATEWAY_INTERFACE) && dev->gateway &&
-				gateway_is_active(dev))
-		return TRUE;
 
 	return FALSE;
 }
@@ -514,9 +510,6 @@ void audio_device_unregister(struct audio_device *device)
 		device->hs_preauth_id = 0;
 	}
 
-	if (device->gateway)
-		gateway_unregister(device);
-
 	if (device->sink)
 		sink_unregister(device);
 
diff --git a/audio/main.c b/audio/main.c
index a423b79..ce060fc 100644
--- a/audio/main.c
+++ b/audio/main.c
@@ -43,7 +43,6 @@
 #include "log.h"
 #include "device.h"
 #include "manager.h"
-#include "gateway.h"
 
 static GIOChannel *sco_server = NULL;
 
@@ -66,83 +65,18 @@ static GKeyFile *load_config_file(const char *file)
 	return keyfile;
 }
 
-static void sco_server_cb(GIOChannel *chan, GError *err, gpointer data)
-{
-	int sk;
-	struct audio_device *device;
-	char addr[18];
-	bdaddr_t src, dst;
-
-	if (err) {
-		error("sco_server_cb: %s", err->message);
-		return;
-	}
-
-	bt_io_get(chan, &err,
-			BT_IO_OPT_SOURCE_BDADDR, &src,
-			BT_IO_OPT_DEST_BDADDR, &dst,
-			BT_IO_OPT_DEST, addr,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("bt_io_get: %s", err->message);
-		goto drop;
-	}
-
-	device = manager_find_device(NULL, &src, &dst,
-						AUDIO_GATEWAY_INTERFACE,
-						FALSE);
-	if (!device)
-		goto drop;
-
-	if (device->gateway) {
-		if (!gateway_is_connected(device)) {
-			DBG("Refusing SCO from non-connected AG");
-			goto drop;
-		}
-
-		if (gateway_connect_sco(device, chan) < 0)
-			goto drop;
-	} else
-		goto drop;
-
-	sk = g_io_channel_unix_get_fd(chan);
-	fcntl(sk, F_SETFL, 0);
-
-	DBG("Accepted SCO connection from %s", addr);
-
-	return;
-
-drop:
-	g_io_channel_shutdown(chan, TRUE, NULL);
-}
-
 static int audio_init(void)
 {
 	GKeyFile *config;
-	gboolean enable_sco;
 
 	config = load_config_file(CONFIGDIR "/audio.conf");
 
-	if (audio_manager_init(config, &enable_sco) < 0)
-		goto failed;
-
-	if (!enable_sco)
-		return 0;
-
-	sco_server = bt_io_listen(sco_server_cb, NULL, NULL,
-					NULL, NULL,
-					BT_IO_OPT_INVALID);
-	if (!sco_server) {
-		error("Unable to start SCO server socket");
-		goto failed;
+	if (audio_manager_init(config) < 0) {
+		audio_manager_exit();
+		return -EIO;
 	}
 
 	return 0;
-
-failed:
-	audio_manager_exit();
-
-	return -EIO;
 }
 
 static void audio_exit(void)
diff --git a/audio/manager.c b/audio/manager.c
index 0960d28..f59a2f3 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -61,7 +61,6 @@
 #include "avdtp.h"
 #include "media.h"
 #include "a2dp.h"
-#include "gateway.h"
 #include "sink.h"
 #include "source.h"
 #include "avrcp.h"
@@ -88,7 +87,6 @@ static GSList *adapters = NULL;
 static GSList *devices = NULL;
 
 static struct enabled_interfaces enabled = {
-	.gateway	= FALSE,
 	.sink		= TRUE,
 	.source		= FALSE,
 	.control	= TRUE,
@@ -107,197 +105,6 @@ static struct audio_adapter *find_adapter(GSList *list,
 	return NULL;
 }
 
-static sdp_record_t *hfp_hs_record(uint8_t ch)
-{
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
-	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
-	uuid_t l2cap_uuid, rfcomm_uuid;
-	sdp_profile_desc_t profile;
-	sdp_record_t *record;
-	sdp_list_t *aproto, *proto[2];
-	sdp_data_t *channel;
-
-	record = sdp_record_alloc();
-	if (!record)
-		return NULL;
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(0, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	sdp_uuid16_create(&svclass_uuid, HANDSFREE_SVCLASS_ID);
-	svclass_id = sdp_list_append(0, &svclass_uuid);
-	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
-	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
-	sdp_set_service_classes(record, svclass_id);
-
-	sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
-	profile.version = 0x0105;
-	pfseq = sdp_list_append(0, &profile);
-	sdp_set_profile_descs(record, pfseq);
-
-	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
-	proto[0] = sdp_list_append(0, &l2cap_uuid);
-	apseq = sdp_list_append(0, proto[0]);
-
-	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
-	proto[1] = sdp_list_append(0, &rfcomm_uuid);
-	channel = sdp_data_alloc(SDP_UINT8, &ch);
-	proto[1] = sdp_list_append(proto[1], channel);
-	apseq = sdp_list_append(apseq, proto[1]);
-
-	aproto = sdp_list_append(0, apseq);
-	sdp_set_access_protos(record, aproto);
-
-	sdp_set_info_attr(record, "Hands-Free", 0, 0);
-
-	sdp_data_free(channel);
-	sdp_list_free(proto[0], 0);
-	sdp_list_free(proto[1], 0);
-	sdp_list_free(apseq, 0);
-	sdp_list_free(pfseq, 0);
-	sdp_list_free(aproto, 0);
-	sdp_list_free(root, 0);
-	sdp_list_free(svclass_id, 0);
-
-	return record;
-}
-
-static void gateway_auth_cb(DBusError *derr, void *user_data)
-{
-	struct audio_device *device = user_data;
-
-	if (derr && dbus_error_is_set(derr)) {
-		error("Access denied: %s", derr->message);
-		gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
-	} else {
-		char ag_address[18];
-
-		ba2str(&device->dst, ag_address);
-		DBG("Accepted AG connection from %s for %s",
-			ag_address, device_get_path(device->btd_dev));
-
-		gateway_start_service(device);
-	}
-}
-
-static void hf_io_cb(GIOChannel *chan, gpointer data)
-{
-	bdaddr_t src, dst;
-	GError *err = NULL;
-	uint8_t ch;
-	const char *server_uuid, *remote_uuid;
-	struct audio_device *device;
-	guint auth_id;
-
-	bt_io_get(chan, &err,
-			BT_IO_OPT_SOURCE_BDADDR, &src,
-			BT_IO_OPT_DEST_BDADDR, &dst,
-			BT_IO_OPT_CHANNEL, &ch,
-			BT_IO_OPT_INVALID);
-
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		return;
-	}
-
-	server_uuid = HFP_HS_UUID;
-	remote_uuid = HFP_AG_UUID;
-
-	device = manager_get_device(&src, &dst, TRUE);
-	if (!device)
-		goto drop;
-
-	if (!device->gateway) {
-		btd_device_add_uuid(device->btd_dev, remote_uuid);
-		if (!device->gateway)
-			goto drop;
-	}
-
-	if (gateway_is_active(device)) {
-		DBG("Refusing new connection since one already exists");
-		goto drop;
-	}
-
-	if (gateway_connect_rfcomm(device, chan) < 0) {
-		error("Allocating new GIOChannel failed!");
-		goto drop;
-	}
-
-	auth_id = btd_request_authorization(&device->src, &device->dst,
-						server_uuid, gateway_auth_cb,
-						device);
-	if (auth_id == 0) {
-		DBG("Authorization denied");
-		gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
-	}
-
-	return;
-
-drop:
-	g_io_channel_shutdown(chan, TRUE, NULL);
-}
-
-static int gateway_server_init(struct audio_adapter *adapter)
-{
-	uint8_t chan = DEFAULT_HFP_HS_CHANNEL;
-	sdp_record_t *record;
-	gboolean master = TRUE;
-	GError *err = NULL;
-	GIOChannel *io;
-	const bdaddr_t *src;
-
-	if (config) {
-		gboolean tmp;
-
-		tmp = g_key_file_get_boolean(config, "General", "Master",
-						&err);
-		if (err) {
-			DBG("audio.conf: %s", err->message);
-			g_clear_error(&err);
-		} else
-			master = tmp;
-	}
-
-	src = adapter_get_address(adapter->btd_adapter);
-
-	io = bt_io_listen(NULL, hf_io_cb, adapter, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_CHANNEL, chan,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, master,
-				BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
-		g_error_free(err);
-		return -1;
-	}
-
-	adapter->hfp_hs_server = io;
-	record = hfp_hs_record(chan);
-	if (!record) {
-		error("Unable to allocate new service record");
-		goto failed;
-	}
-
-	if (add_record_to_server(src, record) < 0) {
-		error("Unable to register HFP HS service record");
-		sdp_record_free(record);
-		goto failed;
-	}
-
-	adapter->hfp_hs_record_id = record->handle;
-
-	return 0;
-
-failed:
-	g_io_channel_shutdown(adapter->hfp_hs_server, TRUE, NULL);
-	g_io_channel_unref(adapter->hfp_hs_server);
-	adapter->hfp_hs_server = NULL;
-	return -1;
-}
-
 static struct audio_device *get_audio_dev(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
@@ -321,25 +128,6 @@ static void audio_remove(struct btd_profile *p, struct btd_device *device)
 	audio_device_unregister(dev);
 }
 
-static int ag_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
-{
-	struct audio_device *audio_dev;
-
-	audio_dev = get_audio_dev(device);
-	if (!audio_dev) {
-		DBG("unable to get a device object");
-		return -1;
-	}
-
-	if (audio_dev->gateway)
-		return -EALREADY;
-
-	audio_dev->gateway = gateway_init(audio_dev);
-
-	return 0;
-}
-
 static int a2dp_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids)
 {
@@ -431,49 +219,6 @@ static struct audio_adapter *audio_adapter_get(struct btd_adapter *adapter)
 	return adp;
 }
 
-static int gateway_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	struct audio_adapter *adp;
-	int err;
-
-	adp = audio_adapter_get(adapter);
-	if (!adp)
-		return -EINVAL;
-
-	err = gateway_server_init(adp);
-	if (err < 0)
-		audio_adapter_unref(adp);
-
-	return err;
-}
-
-static void gateway_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	adp = find_adapter(adapters, adapter);
-	if (!adp)
-		return;
-
-	if (adp->hfp_hs_record_id) {
-		remove_record_from_server(adp->hfp_hs_record_id);
-		adp->hfp_hs_record_id = 0;
-	}
-
-	if (adp->hfp_hs_server) {
-		g_io_channel_shutdown(adp->hfp_hs_server, TRUE, NULL);
-		g_io_channel_unref(adp->hfp_hs_server);
-		adp->hfp_hs_server = NULL;
-	}
-
-	audio_adapter_unref(adp);
-}
-
 static int a2dp_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
@@ -580,17 +325,6 @@ static void media_server_remove(struct btd_adapter *adapter)
 	audio_adapter_unref(adp);
 }
 
-static struct btd_profile gateway_profile = {
-	.name		= "audio-gateway",
-
-	.remote_uuids	= BTD_UUIDS(HSP_AG_UUID, HFP_AG_UUID),
-	.device_probe	= ag_probe,
-	.device_remove	= audio_remove,
-
-	.adapter_probe	= gateway_server_probe,
-	.adapter_remove = gateway_server_remove,
-};
-
 static struct btd_profile a2dp_profile = {
 	.name		= "audio-a2dp",
 
@@ -620,7 +354,7 @@ static struct btd_adapter_driver media_driver = {
 	.remove	= media_server_remove,
 };
 
-int audio_manager_init(GKeyFile *conf, gboolean *enable_sco)
+int audio_manager_init(GKeyFile *conf)
 {
 	char **list;
 	int i;
@@ -635,9 +369,7 @@ int audio_manager_init(GKeyFile *conf, gboolean *enable_sco)
 	list = g_key_file_get_string_list(config, "General", "Enable",
 						NULL, NULL);
 	for (i = 0; list && list[i] != NULL; i++) {
-		if (g_str_equal(list[i], "Gateway"))
-			enabled.gateway = TRUE;
-		else if (g_str_equal(list[i], "Sink"))
+		if (g_str_equal(list[i], "Sink"))
 			enabled.sink = TRUE;
 		else if (g_str_equal(list[i], "Source"))
 			enabled.source = TRUE;
@@ -649,9 +381,7 @@ int audio_manager_init(GKeyFile *conf, gboolean *enable_sco)
 	list = g_key_file_get_string_list(config, "General", "Disable",
 						NULL, NULL);
 	for (i = 0; list && list[i] != NULL; i++) {
-		if (g_str_equal(list[i], "Gateway"))
-			enabled.gateway = FALSE;
-		else if (g_str_equal(list[i], "Sink"))
+		if (g_str_equal(list[i], "Sink"))
 			enabled.sink = FALSE;
 		else if (g_str_equal(list[i], "Source"))
 			enabled.source = FALSE;
@@ -677,9 +407,6 @@ int audio_manager_init(GKeyFile *conf, gboolean *enable_sco)
 		max_connected_headsets = i;
 
 proceed:
-	if (enabled.gateway)
-		btd_profile_register(&gateway_profile);
-
 	if (enabled.source || enabled.sink)
 		btd_profile_register(&a2dp_profile);
 
@@ -688,8 +415,6 @@ proceed:
 
 	btd_register_adapter_driver(&media_driver);
 
-	*enable_sco = enabled.gateway;
-
 	return 0;
 }
 
@@ -700,9 +425,6 @@ void audio_manager_exit(void)
 		config = NULL;
 	}
 
-	if (enabled.gateway)
-		btd_profile_unregister(&gateway_profile);
-
 	if (enabled.source || enabled.sink)
 		btd_profile_unregister(&a2dp_profile);
 
@@ -734,10 +456,6 @@ GSList *manager_find_devices(const char *path,
 		if ((dst && bacmp(dst, BDADDR_ANY)) && bacmp(&dev->dst, dst))
 			continue;
 
-		if (interface && !strcmp(AUDIO_GATEWAY_INTERFACE, interface)
-				&& !dev->gateway)
-			continue;
-
 		if (interface && !strcmp(AUDIO_SINK_INTERFACE, interface)
 				&& !dev->sink)
 			continue;
diff --git a/audio/manager.h b/audio/manager.h
index d3b5692..5691063 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -23,14 +23,13 @@
  */
 
 struct enabled_interfaces {
-	gboolean gateway;
 	gboolean sink;
 	gboolean source;
 	gboolean control;
 	gboolean media_player;
 };
 
-int audio_manager_init(GKeyFile *config, gboolean *enable_sco);
+int audio_manager_init(GKeyFile *config);
 void audio_manager_exit(void);
 
 struct audio_device *manager_find_device(const char *path,
diff --git a/audio/media.c b/audio/media.c
index ea0b44e..65037fe 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -46,7 +46,6 @@
 #include "transport.h"
 #include "a2dp.h"
 #include "avrcp.h"
-#include "gateway.h"
 #include "manager.h"
 
 #define MEDIA_INTERFACE "org.bluez.Media"
@@ -140,9 +139,6 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
 {
 	DBG("sender=%s path=%s", endpoint->sender, endpoint->path);
 
-	if (endpoint->ag_watch)
-		gateway_remove_state_cb(endpoint->ag_watch);
-
 	media_endpoint_cancel_all(endpoint);
 
 	g_slist_free_full(endpoint->transports,
@@ -550,49 +546,6 @@ static void a2dp_destroy_endpoint(void *user_data)
 	release_endpoint(endpoint);
 }
 
-static void gateway_setconf_cb(struct media_endpoint *endpoint, void *ret,
-						int size, void *user_data)
-{
-	struct audio_device *dev = user_data;
-
-	if (ret != NULL)
-		return;
-
-	gateway_set_state(dev, GATEWAY_STATE_DISCONNECTED);
-}
-
-static void gateway_state_changed(struct audio_device *dev,
-					gateway_state_t old_state,
-					gateway_state_t new_state,
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
-	case GATEWAY_STATE_DISCONNECTED:
-		transport = find_device_transport(endpoint, dev);
-		if (transport != NULL) {
-			DBG("Clear endpoint %p", endpoint);
-			clear_configuration(endpoint, transport);
-		}
-		break;
-	case GATEWAY_STATE_CONNECTING:
-		set_configuration(endpoint, dev, NULL, 0,
-					gateway_setconf_cb, dev, NULL);
-		break;
-	case GATEWAY_STATE_CONNECTED:
-		break;
-	case GATEWAY_STATE_PLAYING:
-		break;
-	}
-}
-
 static gboolean endpoint_init_a2dp_source(struct media_endpoint *endpoint,
 						gboolean delay_reporting,
 						int *err)
@@ -621,28 +574,6 @@ static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
 	return TRUE;
 }
 
-static gboolean endpoint_init_hs(struct media_endpoint *endpoint, int *err)
-{
-	GSList *list;
-	GSList *l;
-
-	endpoint->ag_watch = gateway_add_state_cb(gateway_state_changed,
-								endpoint);
-	list = manager_find_devices(NULL, &endpoint->adapter->src, BDADDR_ANY,
-						AUDIO_GATEWAY_INTERFACE, TRUE);
-
-	for (l = list; l != NULL; l = l->next) {
-		struct audio_device *dev = l->data;
-
-		set_configuration(endpoint, dev, NULL, 0,
-						gateway_setconf_cb, dev, NULL);
-	}
-
-	g_slist_free(list);
-
-	return TRUE;
-}
-
 static struct media_endpoint *media_endpoint_create(struct media_adapter *adapter,
 						const char *sender,
 						const char *path,
@@ -681,7 +612,7 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 		succeeded = TRUE;
 	else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
 					strcasecmp(uuid, HSP_HS_UUID) == 0)
-		succeeded = endpoint_init_hs(endpoint, err);
+		succeeded = TRUE;
 	else {
 		succeeded = FALSE;
 
diff --git a/audio/transport.c b/audio/transport.c
index 74562ea..994c423 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -44,7 +44,6 @@
 #include "media.h"
 #include "transport.h"
 #include "a2dp.h"
-#include "gateway.h"
 #include "sink.h"
 #include "source.h"
 #include "avrcp.h"
@@ -109,7 +108,6 @@ struct media_transport {
 	transport_lock_t	lock;
 	transport_state_t	state;
 	guint			hs_watch;
-	guint			ag_watch;
 	guint			source_watch;
 	guint			sink_watch;
 	guint			(*resume) (struct media_transport *transport,
@@ -211,9 +209,6 @@ void media_transport_destroy(struct media_transport *transport)
 {
 	char *path;
 
-	if (transport->ag_watch)
-		gateway_remove_state_cb(transport->ag_watch);
-
 	if (transport->sink_watch)
 		sink_remove_state_cb(transport->sink_watch);
 
@@ -461,127 +456,6 @@ static void cancel_a2dp(struct media_transport *transport, guint id)
 	a2dp_cancel(transport->device, id);
 }
 
-static void gateway_resume_complete(struct audio_device *dev, GError *err,
-							void *user_data)
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
-	if (err) {
-		error("Failed to resume gateway: error %s", err->message);
-		goto fail;
-	}
-
-	fd = gateway_get_sco_fd(dev);
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
-static guint resume_gateway(struct media_transport *transport,
-				struct media_owner *owner)
-{
-	struct audio_device *device = transport->device;
-
-	if (state_in_use(transport->state))
-		goto done;
-
-	if (gateway_lock(device, GATEWAY_LOCK_READ |
-						GATEWAY_LOCK_WRITE) == FALSE)
-		return 0;
-
-	if (transport->state == TRANSPORT_STATE_IDLE)
-		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
-
-done:
-	return gateway_request_stream(device, gateway_resume_complete,
-					owner);
-}
-
-static gboolean gateway_suspend_complete(gpointer user_data)
-{
-	struct media_owner *owner = user_data;
-	struct media_transport *transport = owner->transport;
-	struct audio_device *device = transport->device;
-
-	/* Release always succeeds */
-	if (owner->pending) {
-		owner->pending->id = 0;
-		media_request_reply(owner->pending, 0);
-		media_owner_remove(owner);
-	}
-
-	gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
-	transport_set_state(transport, TRANSPORT_STATE_IDLE);
-	media_transport_remove(transport, owner);
-	return FALSE;
-}
-
-static guint suspend_gateway(struct media_transport *transport,
-						struct media_owner *owner)
-{
-	struct audio_device *device = transport->device;
-	static int id = 1;
-
-	if (!owner) {
-		gateway_state_t state = gateway_get_state(device);
-
-		gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
-
-		if (state == GATEWAY_STATE_PLAYING)
-			transport_set_state(transport, TRANSPORT_STATE_PENDING);
-		else
-			transport_set_state(transport, TRANSPORT_STATE_IDLE);
-
-		return 0;
-	}
-
-	gateway_suspend_stream(device);
-	g_idle_add(gateway_suspend_complete, owner);
-	return id++;
-}
-
-static void cancel_gateway(struct media_transport *transport, guint id)
-{
-	gateway_cancel_stream(transport->device, id);
-}
-
 static void media_owner_exit(DBusConnection *connection, void *user_data)
 {
 	struct media_owner *owner = user_data;
@@ -806,13 +680,6 @@ static int set_property_a2dp(struct media_transport *transport,
 	return -EINVAL;
 }
 
-static int set_property_gateway(struct media_transport *transport,
-						const char *property,
-						DBusMessageIter *value)
-{
-	return -EINVAL;
-}
-
 static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -871,12 +738,6 @@ static void get_properties_a2dp(struct media_transport *transport,
 							&a2dp->volume);
 }
 
-static void get_properties_gateway(struct media_transport *transport,
-						DBusMessageIter *dict)
-{
-	/* None */
-}
-
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter)
 {
@@ -1009,22 +870,6 @@ static void transport_update_playing(struct media_transport *transport,
 		transport_set_state(transport, TRANSPORT_STATE_PENDING);
 }
 
-static void gateway_state_changed(struct audio_device *dev,
-						gateway_state_t old_state,
-						gateway_state_t new_state,
-						void *user_data)
-{
-	struct media_transport *transport = user_data;
-
-	if (dev != transport->device)
-		return;
-
-	if (new_state == GATEWAY_STATE_PLAYING)
-		transport_update_playing(transport, TRUE);
-	else
-		transport_update_playing(transport, FALSE);
-}
-
 static void sink_state_changed(struct audio_device *dev,
 						sink_state_t old_state,
 						sink_state_t new_state,
@@ -1100,16 +945,6 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 			transport->source_watch = source_add_state_cb(
 							source_state_changed,
 							transport);
-	} else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
-			strcasecmp(uuid, HSP_HS_UUID) == 0) {
-		transport->resume = resume_gateway;
-		transport->suspend = suspend_gateway;
-		transport->cancel = cancel_gateway;
-		transport->get_properties = get_properties_gateway;
-		transport->set_property = set_property_gateway;
-		transport->ag_watch = gateway_add_state_cb(
-							gateway_state_changed,
-							transport);
 	} else
 		goto fail;
 
-- 
1.7.11.7

