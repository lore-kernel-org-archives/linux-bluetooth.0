Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v16 08/14] audio: Move HFP/HSP AG servers to telephony.c
Date: Wed,  1 Aug 2012 11:08:44 +0200
Message-Id: <1343812131-19395-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
References: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move HeadSet/HandsFree AudioGateway RFComm servers from audio/manager.c
to audio/telephony.c.
Doing this, each RfComm server is started (and the related SDP record
advertised) only when an agent registers for its specific profile.
---
 audio/headset.c   |   48 +++----
 audio/headset.h   |    5 +-
 audio/manager.c   |  386 +----------------------------------------------------
 audio/telephony.c |  315 ++++++++++++++++++++++++++++++++++++++++++-
 audio/telephony.h |    2 -
 5 files changed, 332 insertions(+), 424 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 0070953..ec4db59 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -389,7 +389,6 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	struct audio_device *dev = user_data;
 	struct headset *hs = dev->headset;
 	struct btd_device *btd_dev = dev->btd_dev;
-	struct btd_adapter *adapter;
 	struct pending_connect *p = hs->pending;
 	char hs_address[18];
 
@@ -398,15 +397,6 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
-	adapter = device_get_adapter(btd_dev);
-
-	/* For HFP telephony isn't ready just disconnect */
-	if (hs->hfp_active && !telephony_is_ready(adapter)) {
-		error("Unable to accept HFP connection since the telephony "
-				"subsystem isn't initialized");
-		goto failed;
-	}
-
 	hs->tel_dev = telephony_device_connecting(chan, btd_dev, dev,
 							hs->connecting_uuid);
 	if (hs->tel_dev == NULL)
@@ -561,20 +551,30 @@ static int get_records(struct audio_device *device, headset_stream_cb_t cb,
 			void *user_data, unsigned int *cb_id)
 {
 	struct headset *hs = device->headset;
-	uint16_t svclass;
+	struct btd_adapter *adapter;
+	gboolean hsp_ag_supported, hfp_ag_supported;
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
+	hsp_ag_supported = telephony_is_uuid_supported(adapter, HSP_AG_UUID);
+	hfp_ag_supported = telephony_is_uuid_supported(adapter, HFP_AG_UUID);
 
-	if (svclass == HANDSFREE_SVCLASS_ID)
+	if (hfp_ag_supported && hs->search_hfp && hs->pending == NULL) {
+		svclass = HANDSFREE_SVCLASS_ID;
 		hs->connecting_uuid = HFP_AG_UUID;
-	else
+	} else if (hsp_ag_supported) {
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
 
@@ -700,7 +700,6 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
-	struct btd_adapter *adapter;
 	int err;
 
 	if (hs->state == HEADSET_STATE_CONNECTING)
@@ -708,11 +707,6 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 	else if (hs->state > HEADSET_STATE_CONNECTING)
 		return btd_error_already_connected(msg);
 
-	adapter = device_get_adapter(device->btd_dev);
-
-	if (hs->hfp_handle && !telephony_is_ready(adapter))
-		return btd_error_not_ready(msg);
-
 	device->auto_connect = FALSE;
 
 	err = rfcomm_connect(device, NULL, NULL, NULL);
@@ -922,14 +916,14 @@ register_iface:
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
@@ -945,8 +939,6 @@ uint32_t headset_config_init(GKeyFile *config)
 			error("Invalid Headset Routing value: %s", str);
 		g_free(str);
 	}
-
-	return telephony_get_ag_features();
 }
 
 static gboolean hs_dc_timeout(struct audio_device *dev)
diff --git a/audio/headset.h b/audio/headset.h
index 61e63c8..2915495 100644
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
index 2b125a0..4ab0186 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -89,11 +89,7 @@ typedef enum {
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
@@ -226,62 +222,6 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
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
@@ -338,201 +278,6 @@ static sdp_record_t *hfp_hs_record(uint8_t ch)
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
@@ -608,108 +353,6 @@ drop:
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
@@ -903,7 +546,6 @@ static int headset_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
-	int err;
 
 	DBG("path %s", path);
 
@@ -911,11 +553,7 @@ static int headset_server_probe(struct btd_adapter *adapter)
 	if (!adp)
 		return -EINVAL;
 
-	err = headset_server_init(adp);
-	if (err < 0) {
-		audio_adapter_unref(adp);
-		return err;
-	}
+	headset_config_init(config);
 
 	btd_adapter_register_powered_callback(adapter, state_changed);
 
@@ -935,28 +573,6 @@ static void headset_server_remove(struct btd_adapter *adapter)
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
 	audio_adapter_unref(adp);
 }
 
diff --git a/audio/telephony.c b/audio/telephony.c
index 49ccafd..943c3aa 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -43,18 +43,24 @@
 
 #include "log.h"
 #include "device.h"
+#include "manager.h"
 #include "error.h"
 #include "glib-helper.h"
 #include "sdp-client.h"
 #include "headset.h"
 #include "telephony.h"
 #include "dbus-common.h"
+#include "sdpd.h"
 
 #define AUDIO_TELEPHONY_INTERFACE "org.bluez.Telephony"
 #define AUDIO_TELEPHONY_AGENT_INTERFACE "org.bluez.TelephonyAgent"
 
 #define DEFAULT_HS_HS_CHANNEL 6
+#define DEFAULT_HS_AG_CHANNEL 12
 #define DEFAULT_HF_HS_CHANNEL 7
+#define DEFAULT_HF_AG_CHANNEL 13
+
+struct telephony_agent;
 
 /*
  * Profile configuration
@@ -62,6 +68,8 @@
  * It describes for each supported profile:
  *  - UUID, RFCOMM channel and security level
  *  - remote UUID, service class and profile descriptor if they exist
+ *  - SDP record create function
+ *  - RFCOMM connection approval callback
  *  - profile connection complete callback called when agent replied to
  *    NewConnection method call
  */
@@ -71,13 +79,17 @@ struct profile_config {
 	const char		*r_uuid;
 	uint16_t		r_class;
 	uint16_t		r_profile;
+	sdp_record_t		*(*record_init)(struct telephony_agent *agent);
+	BtIOConfirm		confirm;
 	DBusPendingCallNotifyFunction connection_reply;
 };
 
 /*
  * Telephony agent
  *
- * It represents the telephony agent with provided version and features.
+ * It represents the telephony agent for which BlueZ will publish an
+ * SDP record (record_id) with provided version and features.
+ * BlueZ will also listen for incoming connection on io.
  *
  * This is done by adapter.
  */
@@ -89,6 +101,8 @@ struct telephony_agent {
 	uint16_t		version;	/* agent profile version */
 	uint16_t		features;	/* agent supported features */
 	guint			watch;		/* agent disconnect watcher */
+	GIOChannel		*io;		/* listener channel */
+	uint32_t		record_id;	/* SDP record id */
 };
 
 /*
@@ -149,6 +163,14 @@ static void free_agent(struct telephony_agent *agent)
 {
 	DBusMessage *msg;
 
+	if (agent->record_id)
+		remove_record_from_server(agent->record_id);
+
+	if (agent->io) {
+		g_io_channel_shutdown(agent->io, TRUE, NULL);
+		g_io_channel_unref(agent->io);
+	}
+
 	if (agent->watch) {
 		msg = dbus_message_new_method_call(agent->name, agent->path,
 				AUDIO_TELEPHONY_AGENT_INTERFACE, "Release");
@@ -428,14 +450,255 @@ void telephony_device_disconnect(struct telephony_device *device)
 	g_free(device);
 }
 
-gboolean telephony_is_ready(struct btd_adapter *adapter)
+static sdp_record_t *hsp_ag_record(struct telephony_agent *agent)
 {
-	return find_agent(adapter, NULL, NULL, HFP_AG_UUID) ? TRUE : FALSE;
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
+	channel = sdp_data_alloc(SDP_UINT8, &agent->config->channel);
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
 }
 
-uint32_t telephony_get_ag_features(void)
+static sdp_record_t *hfp_ag_record(struct telephony_agent *agent)
 {
-	return 0;
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
+	channel = sdp_data_alloc(SDP_UINT8, &agent->config->channel);
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
+	struct audio_device *au_dev = user_data;
+	GError *err = NULL;
+	GIOChannel *io;
+
+	if (au_dev->hs_preauth_id) {
+		g_source_remove(au_dev->hs_preauth_id);
+		au_dev->hs_preauth_id = 0;
+	}
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		headset_set_state(au_dev, HEADSET_STATE_DISCONNECTED);
+		return;
+	}
+
+	io = headset_get_rfcomm(au_dev);
+
+	if (!bt_io_accept(io, headset_connect_cb, au_dev, NULL, &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
+		headset_set_state(au_dev, HEADSET_STATE_DISCONNECTED);
+		return;
+	}
+}
+
+static gboolean hs_preauth_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	struct audio_device *au_dev = user_data;
+
+	DBG("Headset disconnected during authorization");
+
+	audio_device_cancel_authorization(au_dev, headset_auth_cb, au_dev);
+
+	headset_set_state(au_dev, HEADSET_STATE_DISCONNECTED);
+
+	au_dev->hs_preauth_id = 0;
+
+	return FALSE;
+}
+
+static void ag_confirm(GIOChannel *chan, gpointer data)
+{
+	struct telephony_agent *agent = data;
+	struct audio_device *au_dev;
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
+	au_dev = manager_get_device(&src, &dst, TRUE);
+	if (!au_dev)
+		goto drop;
+
+	if (!manager_allow_headset_connection(au_dev)) {
+		DBG("Refusing headset: too many existing connections");
+		goto drop;
+	}
+
+	if (!au_dev->headset) {
+		btd_device_add_uuid(au_dev->btd_dev, agent->config->r_uuid);
+		if (!au_dev->headset)
+			goto drop;
+	}
+
+	if (headset_get_state(au_dev) > HEADSET_STATE_DISCONNECTED) {
+		DBG("Refusing new connection since one already exists");
+		goto drop;
+	}
+
+	headset_set_hfp_active(au_dev, hfp_active);
+	headset_set_rfcomm_initiator(au_dev, TRUE);
+	headset_set_connecting_uuid(au_dev, agent->config->uuid);
+
+	if (headset_connect_rfcomm(au_dev, chan) < 0) {
+		error("headset_connect_rfcomm failed");
+		goto drop;
+	}
+
+	headset_set_state(au_dev, HEADSET_STATE_CONNECTING);
+
+	perr = audio_device_request_authorization(au_dev, agent->config->uuid,
+						headset_auth_cb, au_dev);
+	if (perr < 0) {
+		DBG("Authorization denied: %s", strerror(-perr));
+		headset_set_state(au_dev, HEADSET_STATE_DISCONNECTED);
+		return;
+	}
+
+	au_dev->hs_preauth_id = g_io_add_watch(chan,
+					G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+					hs_preauth_cb, au_dev);
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
 
 static struct profile_config default_configs[] = {
@@ -444,12 +707,16 @@ static struct profile_config default_configs[] = {
 		HSP_HS_UUID,
 		HEADSET_SVCLASS_ID,
 		HEADSET_PROFILE_ID,
+		hsp_ag_record,
+		ag_confirm,
 		hs_newconnection_reply },
 	{ HFP_AG_UUID,
 		DEFAULT_HF_AG_CHANNEL,
 		HFP_HS_UUID,
 		HANDSFREE_SVCLASS_ID,
 		HANDSFREE_PROFILE_ID,
+		hfp_ag_record,
+		ag_confirm,
 		hs_newconnection_reply },
 };
 
@@ -499,6 +766,10 @@ static DBusMessage *register_agent(DBusConnection *conn,
 	uint16_t version = 0;
 	uint16_t features = 0xFFFF;
 	struct telephony_agent *agent;
+	sdp_record_t *record;
+	bdaddr_t src;
+	gboolean master = TRUE;
+	GError *err = NULL;
 
 	sender = dbus_message_get_sender(msg);
 
@@ -529,9 +800,43 @@ static DBusMessage *register_agent(DBusConnection *conn,
 							agent_disconnect_cb,
 							agent, NULL);
 
+	record = agent->config->record_init(agent);
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
+	agent->io = bt_io_listen(BT_IO_RFCOMM, NULL, agent->config->confirm,
+				agent, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_CHANNEL, agent->config->channel,
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
index 1a4ab06..1e20087 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -53,8 +53,6 @@ struct telephony_device *telephony_device_connecting(GIOChannel *io,
 					const char *uuid);
 void telephony_device_disconnect(struct telephony_device *device);
 
-gboolean telephony_is_ready(struct btd_adapter *adapter);
-uint32_t telephony_get_ag_features(void);
 gboolean telephony_is_uuid_supported(struct btd_adapter *adapter,
 						const char *uuid);
 
-- 
1.7.9.5

