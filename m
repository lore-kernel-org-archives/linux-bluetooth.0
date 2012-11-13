Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/13] audio: Remove HFP and HSP headset role support
Date: Tue, 13 Nov 2012 15:21:05 +0200
Message-Id: <1352812880-7306-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
References: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The support for these profiles are intended to be external, probably directly
integrated in the telephony stack of the platform in use e.g. oFono.
---
 audio/manager.c | 502 --------------------------------------------------------
 1 file changed, 502 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 4ea61bf..26dde60 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -91,7 +91,6 @@ static GSList *devices = NULL;
 
 static struct enabled_interfaces enabled = {
 	.hfp		= TRUE,
-	.headset	= TRUE,
 	.gateway	= FALSE,
 	.sink		= TRUE,
 	.source		= FALSE,
@@ -111,62 +110,6 @@ static struct audio_adapter *find_adapter(GSList *list,
 	return NULL;
 }
 
-static sdp_record_t *hsp_ag_record(uint8_t ch)
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
-	sdp_uuid16_create(&svclass_uuid, HEADSET_AGW_SVCLASS_ID);
-	svclass_id = sdp_list_append(0, &svclass_uuid);
-	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
-	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
-	sdp_set_service_classes(record, svclass_id);
-
-	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
-	profile.version = 0x0102;
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
-	sdp_set_info_attr(record, "Headset Audio Gateway", 0, 0);
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
 static sdp_record_t *hfp_hs_record(uint8_t ch)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -223,206 +166,6 @@ static sdp_record_t *hfp_hs_record(uint8_t ch)
 	return record;
 }
 
-static sdp_record_t *hfp_ag_record(uint8_t ch, uint32_t feat)
-{
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
-	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
-	uuid_t l2cap_uuid, rfcomm_uuid;
-	sdp_profile_desc_t profile;
-	sdp_list_t *aproto, *proto[2];
-	sdp_record_t *record;
-	sdp_data_t *channel, *features;
-	uint8_t netid = 0x01;
-	uint16_t sdpfeat;
-	sdp_data_t *network;
-
-	record = sdp_record_alloc();
-	if (!record)
-		return NULL;
-
-	network = sdp_data_alloc(SDP_UINT8, &netid);
-	if (!network) {
-		sdp_record_free(record);
-		return NULL;
-	}
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(0, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	sdp_uuid16_create(&svclass_uuid, HANDSFREE_AGW_SVCLASS_ID);
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
-	sdpfeat = (uint16_t) feat & 0xF;
-	features = sdp_data_alloc(SDP_UINT16, &sdpfeat);
-	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
-
-	aproto = sdp_list_append(0, apseq);
-	sdp_set_access_protos(record, aproto);
-
-	sdp_set_info_attr(record, "Hands-Free Audio Gateway", 0, 0);
-
-	sdp_attr_add(record, SDP_ATTR_EXTERNAL_NETWORK, network);
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
-static void headset_auth_cb(DBusError *derr, void *user_data)
-{
-	struct audio_device *device = user_data;
-	GError *err = NULL;
-	GIOChannel *io;
-
-	device->hs_auth_id = 0;
-
-	if (device->hs_preauth_id) {
-		g_source_remove(device->hs_preauth_id);
-		device->hs_preauth_id = 0;
-	}
-
-	if (derr && dbus_error_is_set(derr)) {
-		error("Access denied: %s", derr->message);
-		headset_set_state(device, HEADSET_STATE_DISCONNECTED);
-		return;
-	}
-
-	io = headset_get_rfcomm(device);
-
-	if (!bt_io_accept(io, headset_connect_cb, device, NULL, &err)) {
-		error("bt_io_accept: %s", err->message);
-		g_error_free(err);
-		headset_set_state(device, HEADSET_STATE_DISCONNECTED);
-		return;
-	}
-}
-
-static gboolean hs_preauth_cb(GIOChannel *chan, GIOCondition cond,
-							gpointer user_data)
-{
-	struct audio_device *device = user_data;
-
-	DBG("Headset disconnected during authorization");
-
-	btd_cancel_authorization(device->hs_auth_id);
-	device->hs_auth_id = 0;
-
-	headset_set_state(device, HEADSET_STATE_DISCONNECTED);
-
-	device->hs_preauth_id = 0;
-
-	return FALSE;
-}
-
-static void ag_confirm(GIOChannel *chan, gpointer data)
-{
-	const char *server_uuid, *remote_uuid;
-	struct audio_device *device;
-	gboolean hfp_active;
-	bdaddr_t src, dst;
-	GError *err = NULL;
-	uint8_t ch;
-
-	bt_io_get(chan, &err,
-			BT_IO_OPT_SOURCE_BDADDR, &src,
-			BT_IO_OPT_DEST_BDADDR, &dst,
-			BT_IO_OPT_CHANNEL, &ch,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		goto drop;
-	}
-
-	if (ch == DEFAULT_HS_AG_CHANNEL) {
-		hfp_active = FALSE;
-		server_uuid = HSP_AG_UUID;
-		remote_uuid = HSP_HS_UUID;
-	} else {
-		hfp_active = TRUE;
-		server_uuid = HFP_AG_UUID;
-		remote_uuid = HFP_HS_UUID;
-	}
-
-	device = manager_get_device(&src, &dst, TRUE);
-	if (!device)
-		goto drop;
-
-	if (!manager_allow_headset_connection(device)) {
-		DBG("Refusing headset: too many existing connections");
-		goto drop;
-	}
-
-	if (!device->headset) {
-		btd_device_add_uuid(device->btd_dev, remote_uuid);
-		if (!device->headset)
-			goto drop;
-	}
-
-	if (headset_get_state(device) > HEADSET_STATE_DISCONNECTED) {
-		DBG("Refusing new connection since one already exists");
-		goto drop;
-	}
-
-	headset_set_hfp_active(device, hfp_active);
-	headset_set_rfcomm_initiator(device, TRUE);
-
-	if (headset_connect_rfcomm(device, chan) < 0) {
-		error("headset_connect_rfcomm failed");
-		goto drop;
-	}
-
-	headset_set_state(device, HEADSET_STATE_CONNECTING);
-
-	device->hs_auth_id = btd_request_authorization(&device->src,
-							&device->dst,
-							server_uuid,
-							headset_auth_cb,
-							device);
-	if (device->hs_auth_id == 0) {
-		DBG("Authorization denied");
-		headset_set_state(device, HEADSET_STATE_DISCONNECTED);
-		return;
-	}
-
-	device->hs_preauth_id = g_io_add_watch(chan,
-					G_IO_NVAL | G_IO_HUP | G_IO_ERR,
-					hs_preauth_cb, device);
-
-	device->auto_connect = auto_connect;
-
-	return;
-
-drop:
-	g_io_channel_shutdown(chan, TRUE, NULL);
-}
-
 static void gateway_auth_cb(DBusError *derr, void *user_data)
 {
 	struct audio_device *device = user_data;
@@ -499,108 +242,6 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
-static int headset_server_init(struct audio_adapter *adapter)
-{
-	uint8_t chan = DEFAULT_HS_AG_CHANNEL;
-	sdp_record_t *record;
-	gboolean master = TRUE;
-	GError *err = NULL;
-	uint32_t features;
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
-	io =  bt_io_listen(NULL, ag_confirm, adapter, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_CHANNEL, chan,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, master,
-				BT_IO_OPT_INVALID);
-	if (!io)
-		goto failed;
-
-	adapter->hsp_ag_server = io;
-
-	record = hsp_ag_record(chan);
-	if (!record) {
-		error("Unable to allocate new service record");
-		goto failed;
-	}
-
-	if (add_record_to_server(src, record) < 0) {
-		error("Unable to register HS AG service record");
-		sdp_record_free(record);
-		goto failed;
-	}
-	adapter->hsp_ag_record_id = record->handle;
-
-	features = headset_config_init(config);
-
-	if (!enabled.hfp)
-		return 0;
-
-	chan = DEFAULT_HF_AG_CHANNEL;
-
-	io = bt_io_listen(NULL, ag_confirm, adapter, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_CHANNEL, chan,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, master,
-				BT_IO_OPT_INVALID);
-	if (!io)
-		goto failed;
-
-	adapter->hfp_ag_server = io;
-
-	record = hfp_ag_record(chan, features);
-	if (!record) {
-		error("Unable to allocate new service record");
-		goto failed;
-	}
-
-	if (add_record_to_server(src, record) < 0) {
-		error("Unable to register HF AG service record");
-		sdp_record_free(record);
-		goto failed;
-	}
-	adapter->hfp_ag_record_id = record->handle;
-
-	return 0;
-
-failed:
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-	}
-
-	if (adapter->hsp_ag_server) {
-		g_io_channel_shutdown(adapter->hsp_ag_server, TRUE, NULL);
-		g_io_channel_unref(adapter->hsp_ag_server);
-		adapter->hsp_ag_server = NULL;
-	}
-
-	if (adapter->hfp_ag_server) {
-		g_io_channel_shutdown(adapter->hfp_ag_server, TRUE, NULL);
-		g_io_channel_unref(adapter->hfp_ag_server);
-		adapter->hfp_ag_server = NULL;
-	}
-
-	return -1;
-}
-
 static int gateway_server_init(struct audio_adapter *adapter)
 {
 	uint8_t chan = DEFAULT_HFP_HS_CHANNEL;
@@ -683,26 +324,6 @@ static void audio_remove(struct btd_profile *p, struct btd_device *device)
 	audio_device_unregister(dev);
 }
 
-static int hs_probe(struct btd_profile *p, struct btd_device *device,
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
-	if (audio_dev->headset)
-		headset_update(audio_dev, audio_dev->headset, uuids);
-	else
-		audio_dev->headset = headset_init(audio_dev, uuids,
-								enabled.hfp);
-
-	return 0;
-}
-
 static int ag_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids)
 {
@@ -813,112 +434,6 @@ static struct audio_adapter *audio_adapter_get(struct btd_adapter *adapter)
 	return adp;
 }
 
-static void state_changed(struct btd_adapter *adapter, gboolean powered)
-{
-	struct audio_adapter *adp;
-	static gboolean telephony = FALSE;
-	GSList *l;
-
-	DBG("%s powered %s", adapter_get_path(adapter),
-						powered ? "on" : "off");
-
-	/* ignore powered change, adapter is powering down */
-	if (powered && adapter_powering_down(adapter))
-		return;
-
-	adp = find_adapter(adapters, adapter);
-	if (!adp)
-		return;
-
-	adp->powered = powered;
-
-	if (powered) {
-		/* telephony driver already initialized*/
-		if (telephony == TRUE)
-			return;
-		telephony_init();
-		telephony = TRUE;
-		return;
-	}
-
-	/* telephony not initialized just ignore power down */
-	if (telephony == FALSE)
-		return;
-
-	for (l = adapters; l; l = l->next) {
-		adp = l->data;
-
-		if (adp->powered == TRUE)
-			return;
-	}
-
-	telephony_exit();
-	telephony = FALSE;
-}
-
-static int headset_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
-	int err;
-
-	DBG("path %s", path);
-
-	adp = audio_adapter_get(adapter);
-	if (!adp)
-		return -EINVAL;
-
-	err = headset_server_init(adp);
-	if (err < 0) {
-		audio_adapter_unref(adp);
-		return err;
-	}
-
-	btd_adapter_register_powered_callback(adapter, state_changed);
-
-	return 0;
-}
-
-static void headset_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	btd_adapter_unregister_powered_callback(adapter, state_changed);
-
-	adp = find_adapter(adapters, adapter);
-	if (!adp)
-		return;
-
-	if (adp->hsp_ag_record_id) {
-		remove_record_from_server(adp->hsp_ag_record_id);
-		adp->hsp_ag_record_id = 0;
-	}
-
-	if (adp->hsp_ag_server) {
-		g_io_channel_shutdown(adp->hsp_ag_server, TRUE, NULL);
-		g_io_channel_unref(adp->hsp_ag_server);
-		adp->hsp_ag_server = NULL;
-	}
-
-	if (adp->hfp_ag_record_id) {
-		remove_record_from_server(adp->hfp_ag_record_id);
-		adp->hfp_ag_record_id = 0;
-	}
-
-	if (adp->hfp_ag_server) {
-		g_io_channel_shutdown(adp->hfp_ag_server, TRUE, NULL);
-		g_io_channel_unref(adp->hfp_ag_server);
-		adp->hfp_ag_server = NULL;
-	}
-
-	audio_adapter_unref(adp);
-}
-
 static int gateway_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
@@ -1068,17 +583,6 @@ static void media_server_remove(struct btd_adapter *adapter)
 	audio_adapter_unref(adp);
 }
 
-static struct btd_profile headset_profile = {
-	.name		= "audio-headset",
-
-	.remote_uuids	= BTD_UUIDS(HSP_HS_UUID, HFP_HS_UUID),
-	.device_probe	= hs_probe,
-	.device_remove	= audio_remove,
-
-	.adapter_probe	= headset_server_probe,
-	.adapter_remove = headset_server_remove,
-};
-
 static struct btd_profile gateway_profile = {
 	.name		= "audio-gateway",
 
@@ -1187,9 +691,6 @@ int audio_manager_init(GKeyFile *conf, gboolean *enable_sco)
 		max_connected_headsets = i;
 
 proceed:
-	if (enabled.headset)
-		btd_profile_register(&headset_profile);
-
 	if (enabled.gateway)
 		btd_profile_register(&gateway_profile);
 
@@ -1213,9 +714,6 @@ void audio_manager_exit(void)
 		config = NULL;
 	}
 
-	if (enabled.headset)
-		btd_profile_unregister(&headset_profile);
-
 	if (enabled.gateway)
 		btd_profile_unregister(&gateway_profile);
 
-- 
1.7.11.7

