Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v7 7/8] audio: Move HFP/HSP AG servers to telephony.c
Date: Fri,  6 Jan 2012 16:07:54 +0100
Message-Id: <1325862475-11607-8-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1325862475-11607-1-git-send-email-frederic.danis@linux.intel.com>
References: <1325862475-11607-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move HeadSet/HandsFree AudioGateway RFComm servers from audio/manager.c
to audio/telephony.c.
Doing this, each RfComm server is started (and the related SDP record
advertised) only when an agent registers for its specific profile.
---
 audio/headset.c   |   50 +++----
 audio/headset.h   |    5 +-
 audio/manager.c   |  386 +----------------------------------------------
 audio/telephony.c |  442 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 audio/telephony.h |    3 +-
 5 files changed, 458 insertions(+), 428 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 89a1de0..6631de3 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -388,7 +388,6 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct audio_device *dev = user_data;
 	struct headset *hs = dev->headset;
-	struct btd_adapter *adapter;
 	struct pending_connect *p = hs->pending;
 	char hs_address[18];
 
@@ -397,15 +396,6 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
-	adapter = device_get_adapter(dev->btd_dev);
-
-	/* For HFP telephony isn't ready just disconnect */
-	if (hs->hfp_active && !telephony_get_ready_state(adapter)) {
-		error("Unable to accept HFP connection since the telephony "
-				"subsystem isn't initialized");
-		goto failed;
-	}
-
 	hs->rfcomm = hs->tmp_rfcomm;
 	hs->tmp_rfcomm = NULL;
 
@@ -557,20 +547,30 @@ static int get_records(struct audio_device *device, headset_stream_cb_t cb,
 			void *user_data, unsigned int *cb_id)
 {
 	struct headset *hs = device->headset;
-	uint16_t svclass;
+	struct btd_adapter *adapter;
+	void *hsp_ag_agent, *hfp_ag_agent;
+	uint16_t svclass = 0;
 	uuid_t uuid;
 	int err;
 
-	if (hs->pending && hs->pending->svclass == HANDSFREE_SVCLASS_ID)
-		svclass = HEADSET_SVCLASS_ID;
-	else
-		svclass = hs->search_hfp ? HANDSFREE_SVCLASS_ID :
-							HEADSET_SVCLASS_ID;
+	adapter = device_get_adapter(device->btd_dev);
+
+	hsp_ag_agent = telephony_agent_by_uuid(adapter, HSP_AG_UUID);
+	hfp_ag_agent = telephony_agent_by_uuid(adapter, HFP_AG_UUID);
 
-	if (svclass == HANDSFREE_SVCLASS_ID)
+	if (hfp_ag_agent && hs->search_hfp && hs->pending == NULL) {
+		svclass = HANDSFREE_SVCLASS_ID;
 		hs->connecting_uuid = HFP_AG_UUID;
-	else
+	} else if (hsp_ag_agent) {
+		svclass = HEADSET_SVCLASS_ID;
 		hs->connecting_uuid = HSP_AG_UUID;
+	} else {
+		if (hs->pending) {
+			pending_connect_finalize(device);
+			headset_set_state(device, HEADSET_STATE_DISCONNECTED);
+		}
+		return -1;
+	}
 
 	sdp_uuid16_create(&uuid, svclass);
 
@@ -733,7 +733,6 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
-	struct btd_adapter *adapter;
 	int err;
 
 	if (hs->state == HEADSET_STATE_CONNECTING)
@@ -741,11 +740,6 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 	else if (hs->state > HEADSET_STATE_CONNECTING)
 		return btd_error_already_connected(msg);
 
-	adapter = device_get_adapter(device->btd_dev);
-
-	if (hs->hfp_handle && !telephony_get_ready_state(adapter))
-		return btd_error_not_ready(msg);
-
 	device->auto_connect = FALSE;
 
 	err = rfcomm_connect(device, NULL, NULL, NULL);
@@ -1000,14 +994,14 @@ register_iface:
 	return hs;
 }
 
-uint32_t headset_config_init(GKeyFile *config)
+void headset_config_init(GKeyFile *config)
 {
 	GError *err = NULL;
 	char *str;
 
 	/* Use the default values if there is no config file */
 	if (config == NULL)
-		return telephony_get_ag_features();
+		return;
 
 	str = g_key_file_get_string(config, "General", "SCORouting",
 					&err);
@@ -1023,8 +1017,6 @@ uint32_t headset_config_init(GKeyFile *config)
 			error("Invalid Headset Routing value: %s", str);
 		g_free(str);
 	}
-
-	return telephony_get_ag_features();
 }
 
 static gboolean hs_dc_timeout(struct audio_device *dev)
@@ -1272,7 +1264,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		value = FALSE;
 		close_sco(dev);
 
-		if (dev->headset->slc)  {
+		if (dev->headset->slc) {
 			telephony_device_disconnect(dev->headset->slc);
 			dev->headset->slc = NULL;
 		}
diff --git a/audio/headset.h b/audio/headset.h
index 43e8135..f0051fd 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -24,9 +24,6 @@
 
 #define AUDIO_HEADSET_INTERFACE "org.bluez.Headset"
 
-#define DEFAULT_HS_AG_CHANNEL 12
-#define DEFAULT_HF_AG_CHANNEL 13
-
 typedef enum {
 	HEADSET_STATE_DISCONNECTED,
 	HEADSET_STATE_CONNECTING,
@@ -62,7 +59,7 @@ struct headset *headset_init(struct audio_device *dev, uint16_t svc,
 
 void headset_unregister(struct audio_device *dev);
 
-uint32_t headset_config_init(GKeyFile *config);
+void headset_config_init(GKeyFile *config);
 
 void headset_update(struct audio_device *dev, uint16_t svc,
 			const char *uuidstr);
diff --git a/audio/manager.c b/audio/manager.c
index 9ed1427..0329f07 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -94,11 +94,7 @@ typedef enum {
 struct audio_adapter {
 	struct btd_adapter *btd_adapter;
 	gboolean powered;
-	uint32_t hsp_ag_record_id;
-	uint32_t hfp_ag_record_id;
 	uint32_t hfp_hs_record_id;
-	GIOChannel *hsp_ag_server;
-	GIOChannel *hfp_ag_server;
 	GIOChannel *hfp_hs_server;
 	gint ref;
 };
@@ -232,62 +228,6 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 	}
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
@@ -344,201 +284,6 @@ static sdp_record_t *hfp_hs_record(uint8_t ch)
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
-	audio_device_cancel_authorization(device, headset_auth_cb, device);
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
-	int perr;
-	GError *err = NULL;
-	uint8_t ch;
-
-	bt_io_get(chan, BT_IO_RFCOMM, &err,
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
-	perr = audio_device_request_authorization(device, server_uuid,
-						headset_auth_cb, device);
-	if (perr < 0) {
-		DBG("Authorization denied: %s", strerror(-perr));
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
@@ -614,108 +359,6 @@ drop:
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
-	bdaddr_t src;
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
-	adapter_get_address(adapter->btd_adapter, &src);
-
-	io =  bt_io_listen(BT_IO_RFCOMM, NULL, ag_confirm, adapter, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
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
-	if (add_record_to_server(&src, record) < 0) {
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
-	io = bt_io_listen(BT_IO_RFCOMM, NULL, ag_confirm, adapter, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
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
-	if (add_record_to_server(&src, record) < 0) {
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
@@ -906,7 +549,6 @@ static int headset_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
-	int err;
 
 	DBG("path %s", path);
 
@@ -917,11 +559,7 @@ static int headset_server_probe(struct btd_adapter *adapter)
 	btd_adapter_register_powered_callback(adapter, state_changed);
 	state_changed(adapter, TRUE);
 
-	err = headset_server_init(adp);
-	if (err < 0) {
-		audio_adapter_unref(adp);
-		return err;
-	}
+	headset_config_init(config);
 
 	return 0;
 }
@@ -937,28 +575,6 @@ static void headset_server_remove(struct btd_adapter *adapter)
 	if (!adp)
 		return;
 
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
 	btd_adapter_unregister_powered_callback(adapter, state_changed);
 
 	audio_adapter_unref(adp);
diff --git a/audio/telephony.c b/audio/telephony.c
index 0e66af9..0f7a0f1 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -39,6 +39,7 @@
 #include "btio.h"
 #include "log.h"
 #include "device.h"
+#include "manager.h"
 #include "error.h"
 #include "glib-helper.h"
 #include "sdp-client.h"
@@ -47,11 +48,16 @@
 #include "dbus-common.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
+#include "sdpd.h"
 
 #define AUDIO_TELEPHONY_INTERFACE "org.bluez.Telephony"
 
 #define DEFAULT_HS_HS_CHANNEL 6
+#define DEFAULT_HS_AG_CHANNEL 12
 #define DEFAULT_HF_HS_CHANNEL 7
+#define DEFAULT_HF_AG_CHANNEL 13
+
+struct tel_agent;
 
 struct tel_device {
 	struct audio_device	*au_dev;
@@ -69,6 +75,7 @@ struct default_agent {
 	const char		*r_uuid;
 	uint16_t		r_class;
 	uint16_t		r_profile;
+	sdp_record_t		*(*record_init)(struct tel_agent *agent);
 };
 
 struct tel_agent {
@@ -78,6 +85,8 @@ struct tel_agent {
 	uint16_t		version;
 	uint16_t		features;
 	struct default_agent	*properties;
+	GIOChannel		*io;
+	uint32_t		record_id;
 };
 
 static DBusConnection *connection = NULL;
@@ -88,6 +97,15 @@ static void free_agent(struct tel_agent *agent)
 {
 	g_free(agent->name);
 	g_free(agent->path);
+
+	if (agent->io) {
+		g_io_channel_shutdown(agent->io, TRUE, NULL);
+		g_io_channel_unref(agent->io);
+	}
+
+	if (agent->record_id)
+		remove_record_from_server(agent->record_id);
+
 	g_free(agent);
 }
 
@@ -118,6 +136,11 @@ static struct tel_agent *find_agent(struct btd_adapter *adapter,
 	return NULL;
 }
 
+void *telephony_agent_by_uuid(void *adapter, const char *uuid)
+{
+	return find_agent(adapter, NULL, NULL, uuid);
+}
+
 static int parse_properties(DBusMessageIter *props, const char **uuid,
 				uint16_t *version, uint16_t *features)
 {
@@ -357,14 +380,376 @@ void telephony_device_disconnected(void *telephony_device)
 	DBG("telephony-dbus: device %p disconnected", telephony_device);
 }
 
-gboolean telephony_get_ready_state(void *adapter)
+static sdp_record_t *hsp_hs_record(struct tel_agent * agent)
 {
-	return find_agent(adapter, NULL, NULL, HFP_AG_UUID) ? TRUE : FALSE;
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
+	uuid_t l2cap_uuid, rfcomm_uuid;
+	sdp_profile_desc_t profile;
+	sdp_record_t *record;
+	sdp_list_t *aproto, *proto[2];
+	sdp_data_t *channel, *volume;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&svclass_uuid, HEADSET_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &svclass_uuid);
+	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
+	profile.version = agent->version;
+	pfseq = sdp_list_append(0, &profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[1] = sdp_list_append(0, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &agent->properties->channel);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	volume = sdp_data_alloc(SDP_BOOL, &agent->features);
+	sdp_attr_add(record, SDP_ATTR_REMOTE_AUDIO_VOLUME_CONTROL, volume);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "Headset", 0, 0);
+
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(pfseq, 0);
+	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
+
+	return record;
 }
 
-uint32_t telephony_get_ag_features(void)
+static sdp_record_t *hsp_ag_record(struct tel_agent * agent)
 {
-	return 0;
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
+	uuid_t l2cap_uuid, rfcomm_uuid;
+	sdp_profile_desc_t profile;
+	sdp_record_t *record;
+	sdp_list_t *aproto, *proto[2];
+	sdp_data_t *channel;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&svclass_uuid, HEADSET_AGW_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &svclass_uuid);
+	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
+	profile.version = agent->version;
+	pfseq = sdp_list_append(0, &profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[1] = sdp_list_append(0, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &agent->properties->channel);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "Headset Audio Gateway", 0, 0);
+
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(pfseq, 0);
+	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
+
+	return record;
+}
+
+static sdp_record_t *hfp_hs_record(struct tel_agent * agent)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
+	uuid_t l2cap_uuid, rfcomm_uuid;
+	sdp_profile_desc_t profile;
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t *record;
+	sdp_data_t *channel, *features;
+	uint16_t sdpfeat;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&svclass_uuid, HANDSFREE_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &svclass_uuid);
+	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
+	profile.version = agent->version;
+	pfseq = sdp_list_append(0, &profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[1] = sdp_list_append(0, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &agent->properties->channel);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	sdpfeat = agent->features & 0x1F;
+	features = sdp_data_alloc(SDP_UINT16, &sdpfeat);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "Hands-Free", 0, 0);
+
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(pfseq, 0);
+	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
+
+	return record;
+}
+
+static sdp_record_t *hfp_ag_record(struct tel_agent * agent)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
+	uuid_t l2cap_uuid, rfcomm_uuid;
+	sdp_profile_desc_t profile;
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t *record;
+	sdp_data_t *channel, *features;
+	uint8_t netid;
+	uint16_t sdpfeat;
+	sdp_data_t *network;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	netid = agent->features & AG_FEATURE_REJECT_A_CALL ? 1 : 0;
+	network = sdp_data_alloc(SDP_UINT8, &netid);
+	if (!network) {
+		sdp_record_free(record);
+		return NULL;
+	}
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&svclass_uuid, HANDSFREE_AGW_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &svclass_uuid);
+	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
+	profile.version = agent->version;
+	pfseq = sdp_list_append(0, &profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[1] = sdp_list_append(0, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &agent->properties->channel);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	sdpfeat = agent->features & 0x1F;
+	features = sdp_data_alloc(SDP_UINT16, &sdpfeat);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "Hands-Free Audio Gateway", 0, 0);
+
+	sdp_attr_add(record, SDP_ATTR_EXTERNAL_NETWORK, network);
+
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(pfseq, 0);
+	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
+
+	return record;
+}
+
+static void headset_auth_cb(DBusError *derr, void *user_data)
+{
+	struct audio_device *device = user_data;
+	GError *err = NULL;
+	GIOChannel *io;
+
+	if (device->hs_preauth_id) {
+		g_source_remove(device->hs_preauth_id);
+		device->hs_preauth_id = 0;
+	}
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		headset_set_state(device, HEADSET_STATE_DISCONNECTED);
+		return;
+	}
+
+	io = headset_get_rfcomm(device);
+
+	if (!bt_io_accept(io, headset_connect_cb, device, NULL, &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
+		headset_set_state(device, HEADSET_STATE_DISCONNECTED);
+		return;
+	}
+}
+
+static gboolean hs_preauth_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	struct audio_device *device = user_data;
+
+	DBG("Headset disconnected during authorization");
+
+	audio_device_cancel_authorization(device, headset_auth_cb, device);
+
+	headset_set_state(device, HEADSET_STATE_DISCONNECTED);
+
+	device->hs_preauth_id = 0;
+
+	return FALSE;
+}
+
+static void ag_confirm(GIOChannel *chan, gpointer data)
+{
+	struct tel_agent *agent = data;
+	struct audio_device *device;
+	gboolean hfp_active;
+	bdaddr_t src, dst;
+	int perr;
+	GError *err = NULL;
+	uint8_t ch;
+
+	bt_io_get(chan, BT_IO_RFCOMM, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_CHANNEL, &ch,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	/* TODO: to remove ? */
+	if (ch == DEFAULT_HS_AG_CHANNEL)
+		hfp_active = FALSE;
+	else
+		hfp_active = TRUE;
+
+	device = manager_get_device(&src, &dst, TRUE);
+	if (!device)
+		goto drop;
+
+	if (!manager_allow_headset_connection(device)) {
+		DBG("Refusing headset: too many existing connections");
+		goto drop;
+	}
+
+	if (!device->headset) {
+		btd_device_add_uuid(device->btd_dev, agent->properties->r_uuid);
+		if (!device->headset)
+			goto drop;
+	}
+
+	if (headset_get_state(device) > HEADSET_STATE_DISCONNECTED) {
+		DBG("Refusing new connection since one already exists");
+		goto drop;
+	}
+
+	headset_set_hfp_active(device, hfp_active);
+	headset_set_rfcomm_initiator(device, TRUE);
+	headset_set_connecting_uuid(device, agent->properties->uuid);
+
+	if (headset_connect_rfcomm(device, chan) < 0) {
+		error("headset_connect_rfcomm failed");
+		goto drop;
+	}
+
+	headset_set_state(device, HEADSET_STATE_CONNECTING);
+
+	perr = audio_device_request_authorization(device,
+						agent->properties->uuid,
+						headset_auth_cb, device);
+	if (perr < 0) {
+		DBG("Authorization denied: %s", strerror(-perr));
+		headset_set_state(device, HEADSET_STATE_DISCONNECTED);
+		return;
+	}
+
+	device->hs_preauth_id = g_io_add_watch(chan,
+					G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+					hs_preauth_cb, device);
+
+#if 0
+	device->auto_connect = auto_connect;
+#endif
+
+	return;
+
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
 static struct default_agent default_properties[] = {
@@ -372,22 +757,26 @@ static struct default_agent default_properties[] = {
 		DEFAULT_HS_HS_CHANNEL,
 		HSP_AG_UUID,
 		HEADSET_AGW_SVCLASS_ID,
-		HEADSET_PROFILE_ID },
+		HEADSET_PROFILE_ID,
+		hsp_hs_record },
 	{ HSP_AG_UUID,
 		DEFAULT_HS_AG_CHANNEL,
 		HSP_HS_UUID,
 		HEADSET_SVCLASS_ID,
-		HEADSET_PROFILE_ID },
+		HEADSET_PROFILE_ID,
+		hsp_ag_record },
 	{ HFP_HS_UUID,
 		DEFAULT_HF_HS_CHANNEL,
 		HFP_AG_UUID,
 		HANDSFREE_AGW_SVCLASS_ID,
-		HANDSFREE_PROFILE_ID },
+		HANDSFREE_PROFILE_ID,
+		hfp_hs_record },
 	{ HFP_AG_UUID,
 		DEFAULT_HF_AG_CHANNEL,
 		HFP_HS_UUID,
 		HANDSFREE_SVCLASS_ID,
-		HANDSFREE_PROFILE_ID }
+		HANDSFREE_PROFILE_ID,
+		hfp_ag_record }
 };
 
 static struct tel_agent *agent_new(struct btd_adapter *adapter,
@@ -424,6 +813,10 @@ static DBusMessage *register_agent(DBusConnection *conn,
 	uint16_t version = 0;
 	uint16_t features = 0xFFFF;
 	struct tel_agent *agent;
+	sdp_record_t *record;
+	bdaddr_t src;
+	gboolean master = TRUE;
+	GError *err = NULL;
 
 	sender = dbus_message_get_sender(msg);
 
@@ -450,9 +843,42 @@ static DBusMessage *register_agent(DBusConnection *conn,
 	if (agent == NULL)
 		return btd_error_invalid_args(msg);
 
+	record = agent->properties->record_init(agent);
+	if (!record) {
+		error("Unable to allocate new service record");
+		return btd_error_failed(msg, "Unable to allocate new service " \
+						"record");
+	}
+
 	DBG("Register agent : %s%s for %s version 0x%04X with features 0x%02X",
 					sender, path, uuid, version, features);
 
+	/* start RFComm agent server */
+	adapter_get_address(adapter, &src);
+
+	agent->io = bt_io_listen(BT_IO_RFCOMM, NULL, ag_confirm, agent, NULL,
+				&err, BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_CHANNEL, agent->properties->channel,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_MASTER, master,
+				BT_IO_OPT_INVALID);
+	if (agent->io == NULL) {
+		error("Unable to register server");
+		sdp_record_free(record);
+		free_agent(agent);
+		return btd_error_failed(msg, "Failed to register server");
+	}
+
+	/* advertise agent sdp record */
+	if (add_record_to_server(&src, record) < 0) {
+		error("Unable to register service record");
+		sdp_record_free(record);
+		free_agent(agent);
+		return btd_error_failed(msg, "Failed to register sdp record");
+	}
+
+	agent->record_id = record->handle;
+
 	agents = g_slist_append(agents, agent);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
diff --git a/audio/telephony.h b/audio/telephony.h
index 76d02dd..4632003 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -53,8 +53,7 @@ void telephony_device_connected(void *telephony_device);
 void telephony_device_disconnect(void *slc);
 void telephony_device_disconnected(void *telephony_device);
 
-gboolean telephony_get_ready_state(void *adapter);
-uint32_t telephony_get_ag_features(void);
+void *telephony_agent_by_uuid(void *adapter, const char *uuid);
 
 int telephony_adapter_init(void *adapter);
 void telephony_adapter_exit(void *adapter);
-- 
1.7.1

