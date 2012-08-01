Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v16 11/14] audio: Add DUN GW to org.bluez.Telephony
Date: Wed,  1 Aug 2012 11:08:47 +0200
Message-Id: <1343812131-19395-12-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
References: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony.c |  302 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 295 insertions(+), 7 deletions(-)

diff --git a/audio/telephony.c b/audio/telephony.c
index dc76d60..f80986b 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -39,6 +39,7 @@
 
 #include "btio.h"
 #include "../src/adapter.h"
+#include "../src/manager.h"
 #include "../src/device.h"
 
 #include "log.h"
@@ -56,6 +57,7 @@
 #define AUDIO_TELEPHONY_INTERFACE "org.bluez.Telephony"
 #define AUDIO_TELEPHONY_AGENT_INTERFACE "org.bluez.TelephonyAgent"
 
+#define DEFAULT_DUN_GW_CHANNEL 1
 #define DEFAULT_HS_HS_CHANNEL 6
 #define DEFAULT_HS_AG_CHANNEL 12
 #define DEFAULT_HF_HS_CHANNEL 7
@@ -123,7 +125,8 @@ struct telephony_device {
 	struct profile_config	*config;	/* default configuration */
 	char			*name;		/* agent DBus bus id */
 	char			*path;		/* agent object path */
-	struct audio_device	*au_dev;	/* Audio device for HSP/HFP */
+	struct audio_device	*au_dev;	/* Audio device for HSP/HFP
+						 * or NULL for DUN/SAP */
 	uint16_t		version;	/* remote profile version */
 	uint16_t		features;	/* remote supported features */
 	GIOChannel		*rfcomm;	/* connected RFCOMM channel */
@@ -132,6 +135,21 @@ struct telephony_device {
 	DBusPendingCall		*call;		/* D-Bus pending call */
 };
 
+/*
+ * Connecting device
+ *
+ * Used for DUN and SAP gateway profiles in place of the audio device structure
+ * to store informations during connection phase, from device connection up to
+ * authentication completion.
+ */
+struct connecting_device {
+	const char		*uuid;
+	struct btd_device	*btd_dev;
+	bdaddr_t		src, dst;
+	GIOChannel		*tmp_rfcomm;
+	guint			preauth_id;
+};
+
 static DBusConnection *connection = NULL;
 
 static GSList *agents = NULL;	/* server list */
@@ -298,6 +316,201 @@ static gboolean agent_sendfd(struct telephony_device *tel_dev, int fd,
 	return TRUE;
 }
 
+static void rfcomm_channel_close(GIOChannel *chan)
+{
+	int sock;
+
+	sock = g_io_channel_unix_get_fd(chan);
+	shutdown(sock, SHUT_RDWR);
+
+	g_io_channel_shutdown(chan, TRUE, NULL);
+	g_io_channel_unref(chan);
+}
+
+static gboolean client_dev_disconnect_cb(GIOChannel *chan, GIOCondition cond,
+						gpointer data)
+{
+	struct telephony_device *tel_dev = data;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	rfcomm_channel_close(tel_dev->rfcomm);
+	tel_dev->rfcomm = NULL;
+	telephony_device_disconnect(tel_dev);
+
+	return FALSE;
+}
+
+static void client_newconnection_reply(DBusPendingCall *call,
+					void *user_data)
+{
+	struct telephony_device *tel_dev = user_data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Agent reply: %s", derr.message);
+		dbus_error_free(&derr);
+		rfcomm_channel_close(tel_dev->rfcomm);
+		tel_dev->rfcomm = NULL;
+		telephony_device_disconnect(tel_dev);
+		goto done;
+	}
+
+	DBG("Agent reply: file descriptor passed successfully");
+	g_io_add_watch(tel_dev->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			client_dev_disconnect_cb, tel_dev);
+
+done:
+	dbus_pending_call_unref(tel_dev->call);
+	tel_dev->call = NULL;
+	dbus_message_unref(reply);
+}
+
+static void client_connect_cb(GIOChannel *chan, GError *err,
+				gpointer user_data)
+{
+	struct connecting_device *client = user_data;
+	struct telephony_device *tel_dev;
+	char hs_address[18];
+
+	if (err) {
+		error("%s", err->message);
+		rfcomm_channel_close(client->tmp_rfcomm);
+		goto done;
+	}
+
+	ba2str(&client->dst, hs_address);
+
+	tel_dev = telephony_device_connecting(chan, client->btd_dev, NULL,
+						client->uuid);
+	if (tel_dev == NULL) {
+		rfcomm_channel_close(client->tmp_rfcomm);
+		goto done;
+	}
+
+	g_io_channel_unref(client->tmp_rfcomm);
+	client->tmp_rfcomm = NULL;
+
+	DBG("%s: Connected to %s", device_get_path(client->btd_dev),
+								hs_address);
+
+done:
+	g_free(client);
+
+	return;
+}
+
+static void client_auth_cb(DBusError *derr, void *user_data)
+{
+	struct connecting_device *client = user_data;
+	GError *err = NULL;
+
+	if (client->preauth_id) {
+		g_source_remove(client->preauth_id);
+		client->preauth_id = 0;
+	}
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		goto failed;
+	}
+
+	if (!bt_io_accept(client->tmp_rfcomm, client_connect_cb, client, NULL,
+			  &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
+		goto failed;
+	}
+
+	return;
+
+failed:
+	rfcomm_channel_close(client->tmp_rfcomm);
+	g_free(client);
+}
+
+static gboolean client_preauth_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	struct connecting_device *client = user_data;
+
+	DBG("Client for %s disconnected during authorization", client->uuid);
+
+	btd_cancel_authorization(&client->src, &client->dst);
+
+	rfcomm_channel_close(client->tmp_rfcomm);
+	g_free(client);
+
+	return FALSE;
+}
+
+static void client_confirm(GIOChannel *chan, gpointer data)
+{
+	struct telephony_agent *agent = data;
+	struct connecting_device *client;
+	struct btd_adapter *adapter;
+	struct btd_device *btd_dev;
+	char addr[18];
+	int perr;
+	GError *err = NULL;
+	uint8_t ch;
+
+	client = g_new0(struct connecting_device, 1);
+	client->tmp_rfcomm = g_io_channel_ref(chan);
+
+	bt_io_get(chan, BT_IO_RFCOMM, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &client->src,
+			BT_IO_OPT_DEST_BDADDR, &client->dst,
+			BT_IO_OPT_CHANNEL, &ch,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	ba2str(&client->src, addr);
+
+	adapter = manager_find_adapter(&client->src);
+	if (!adapter) {
+		error("Unable to get a btd_adapter object for %s", addr);
+		goto drop;
+	}
+
+	ba2str(&client->dst, addr);
+
+	btd_dev = adapter_get_device(connection, adapter, addr);
+	if (!btd_dev) {
+		error("Unable to get btd_device object for %s", addr);
+		goto drop;
+	}
+
+	client->uuid = agent->config->uuid;
+	client->btd_dev = btd_dev;
+
+	perr = btd_request_authorization(&client->src, &client->dst,
+						agent->config->uuid,
+						client_auth_cb, client);
+	if (perr < 0) {
+		DBG("Authorization denied: %s", strerror(-perr));
+		goto drop;
+	}
+
+	client->preauth_id = g_io_add_watch(chan,
+					G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+					client_preauth_cb, client);
+
+	return;
+
+drop:
+	rfcomm_channel_close(client->tmp_rfcomm);
+
+	g_free(client);
+}
+
 static gboolean hs_dev_disconnect_cb(GIOChannel *chan, GIOCondition cond,
 					gpointer data)
 {
@@ -445,7 +658,8 @@ struct telephony_device *telephony_device_connecting(GIOChannel *io,
 	struct telephony_agent *agent;
 	struct telephony_device *tel_dev;
 	uuid_t r_uuid;
-	int err;
+	int sk;
+	int err = 0;
 
 	adapter = device_get_adapter(btd_dev);
 	agent = find_agent(adapter, NULL, NULL, uuid);
@@ -461,17 +675,29 @@ struct telephony_device *telephony_device_connecting(GIOChannel *io,
 	tel_dev->rfcomm = g_io_channel_ref(io);
 	tel_dev->features = 0xFFFF;
 
-	sdp_uuid16_create(&r_uuid, tel_dev->config->r_class);
+	if (tel_dev->config->r_class == 0) {
+		sk = g_io_channel_unix_get_fd(tel_dev->rfcomm);
+
+		if (agent_sendfd(tel_dev, sk, tel_dev->config->connection_reply)
+								== FALSE) {
+			error("Failed to send RFComm socket to agent %s," \
+				" path %s", tel_dev->name, tel_dev->path);
+			err = -1;
+		}
+	} else {
+		sdp_uuid16_create(&r_uuid, tel_dev->config->r_class);
+
+		err = bt_search_service(&au_dev->src, &au_dev->dst, &r_uuid,
+						get_record_cb, tel_dev, NULL);
+		if (!err)
+			tel_dev->pending_sdp = TRUE;
+	}
 
-	err = bt_search_service(&au_dev->src, &au_dev->dst, &r_uuid,
-				get_record_cb, tel_dev, NULL);
 	if (err < 0) {
 		telephony_device_disconnect(tel_dev);
 		return NULL;
 	}
 
-	tel_dev->pending_sdp = TRUE;
-
 	return tel_dev;
 }
 
@@ -511,6 +737,60 @@ const char *telephony_get_agent_name(struct telephony_device *device)
 	return device->name;
 }
 
+static sdp_record_t *dun_gw_record(struct telephony_agent *agent)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, svclass_uuid;
+	uuid_t l2cap_uuid, rfcomm_uuid;
+	sdp_profile_desc_t profile;
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t *record;
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
+	sdp_uuid16_create(&svclass_uuid, DIALUP_NET_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &svclass_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, DIALUP_NET_PROFILE_ID);
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
+	sdp_set_info_attr(record, "Dial-up Networking", 0, 0);
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
 static sdp_record_t *hfp_hs_record(struct telephony_agent *agent)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -927,6 +1207,14 @@ drop:
 }
 
 static struct profile_config default_configs[] = {
+	{ DUN_GW_UUID,
+		DEFAULT_DUN_GW_CHANNEL,
+		NULL,
+		0,
+		0,
+		dun_gw_record,
+		client_confirm,
+		client_newconnection_reply },
 	{ HSP_AG_UUID,
 		DEFAULT_HS_AG_CHANNEL,
 		HSP_HS_UUID,
-- 
1.7.9.5

