Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v12 11/13] audio: Add DUN GW to org.bluez.Telephony
Date: Thu, 12 Jul 2012 12:53:56 +0200
Message-Id: <1342090438-20434-12-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1342090438-20434-1-git-send-email-frederic.danis@linux.intel.com>
References: <1342090438-20434-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony.c |  258 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 255 insertions(+), 3 deletions(-)

diff --git a/audio/telephony.c b/audio/telephony.c
index 7b9ab7f..1646c8a 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -49,12 +49,14 @@
 #include "telephony.h"
 #include "dbus-common.h"
 #include "../src/adapter.h"
+#include "../src/manager.h"
 #include "../src/device.h"
 #include "sdpd.h"
 
 #define AUDIO_TELEPHONY_INTERFACE "org.bluez.Telephony"
 #define AUDIO_TELEPHONY_AGENT_INTERFACE "org.bluez.TelephonyAgent"
 
+#define DEFAULT_DUN_GW_CHANNEL 1
 #define DEFAULT_HS_HS_CHANNEL 6
 #define DEFAULT_HS_AG_CHANNEL 12
 #define DEFAULT_HF_HS_CHANNEL 7
@@ -97,6 +99,14 @@ struct tel_agent {
 	uint32_t		record_id;
 };
 
+struct tel_client {
+	struct tel_agent *agent;
+	struct btd_device *btd_dev;
+	bdaddr_t src, dst;
+	GIOChannel *rfcomm;
+	int preauth_id;
+};
+
 static DBusConnection *connection = NULL;
 
 static GSList *agents = NULL;	/* server list */
@@ -258,6 +268,173 @@ static gboolean agent_sendfd(struct tel_device *dev, int fd,
 	return TRUE;
 }
 
+static gboolean client_dev_disconnect_cb(GIOChannel *chan,
+					GIOCondition cond,
+					struct tel_device *dev)
+{
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	telephony_device_disconnect(dev);
+
+	return FALSE;
+}
+
+static void client_newconnection_reply(DBusPendingCall *call,
+					void *user_data)
+{
+	struct tel_device *dev = user_data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	if (!dev->rfcomm) {
+		DBG("RFCOMM disconnected from server before agent reply");
+		goto done;
+	}
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply)) {
+		DBG("Agent reply: file descriptor passed successfully");
+		g_io_add_watch(dev->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) client_dev_disconnect_cb, dev);
+		goto done;
+	}
+
+	DBG("Agent reply: %s", derr.message);
+
+	dbus_error_free(&derr);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void client_connect_cb(GIOChannel *chan, GError *err,
+				gpointer user_data)
+{
+	struct tel_client *client = user_data;
+	char hs_address[18];
+
+	if (err) {
+		error("%s", err->message);
+		goto done;
+	}
+
+	ba2str(&client->dst, hs_address);
+
+	telephony_device_connecting(chan, client->btd_dev, client,
+				    client->agent);
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
+	struct tel_client *client = user_data;
+	GError *err = NULL;
+
+	if (client->preauth_id) {
+		g_source_remove(client->preauth_id);
+		client->preauth_id = 0;
+	}
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		g_free(client);
+		return;
+	}
+
+	if (!bt_io_accept(client->rfcomm, client_connect_cb, client, NULL,
+			  &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
+		g_free(client);
+		return;
+	}
+}
+
+static gboolean client_preauth_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	struct tel_client *client = user_data;
+
+	DBG("Client for %s disconnected during authorization",
+					client->agent->properties->uuid);
+
+	btd_cancel_authorization(&client->src, &client->dst);
+
+	g_free(client);
+
+	return FALSE;
+}
+
+static void client_confirm(GIOChannel *chan, gpointer data)
+{
+	struct tel_agent *agent = data;
+	struct tel_client *client;
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+	char addr[18];
+	int perr;
+	GError *err = NULL;
+	uint8_t ch;
+
+	client = g_new0(struct tel_client, 1);
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
+	device = adapter_get_device(connection, adapter, addr);
+	if (!device) {
+		error("Unable to get btd_device object for %s", addr);
+		goto drop;
+	}
+
+	client->agent = agent;
+	client->btd_dev = device;
+	client->rfcomm = g_io_channel_ref(chan);
+
+	perr = btd_request_authorization(&client->src, &client->dst,
+						agent->properties->uuid,
+						client_auth_cb, client);
+	if (perr < 0) {
+		DBG("Authorization denied: %s", strerror(-perr));
+		return;
+	}
+
+	client->preauth_id = g_io_add_watch(chan,
+					G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+					client_preauth_cb, client);
+
+	return;
+
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+}
+
 static gboolean hs_dev_disconnect_cb(GIOChannel *chan, GIOCondition cond,
 						struct tel_device *dev)
 {
@@ -400,7 +577,8 @@ void *telephony_device_connecting(GIOChannel *io, struct btd_device *btd_dev,
 	struct tel_device *dev;
 	struct tel_agent *ag = agent;
 	uuid_t uuid;
-	int err;
+	int sk;
+	int err = 0;
 
 	dev = g_new0(struct tel_device, 1);
 	dev->btd_dev = btd_dev;
@@ -411,10 +589,22 @@ void *telephony_device_connecting(GIOChannel *io, struct btd_device *btd_dev,
 	dev->rfcomm = io;
 	dev->features = 0xFFFF;
 
-	sdp_uuid16_create(&uuid, dev->properties->r_class);
+	if (dev->properties->r_class == 0) {
+		sk = g_io_channel_unix_get_fd(dev->rfcomm);
 
-	err = bt_search_service(&device->src, &device->dst, &uuid,
+		if (agent_sendfd(dev, sk, dev->properties->connection_reply)
+								== FALSE) {
+			error("Failed to send RFComm socket to agent %s," \
+					" path %s", dev->name, dev->path);
+			err = -1;
+		}
+	} else {
+		sdp_uuid16_create(&uuid, dev->properties->r_class);
+
+		err = bt_search_service(&device->src, &device->dst, &uuid,
 						get_record_cb, dev, NULL);
+	}
+
 	if (err < 0) {
 		g_free(dev->name);
 		g_free(dev->path);
@@ -460,6 +650,60 @@ const char *telephony_get_agent_name(void *slc)
 	return dev->name;
 }
 
+static sdp_record_t *dun_gw_record(struct tel_agent *agent)
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
+	channel = sdp_data_alloc(SDP_UINT8, &agent->properties->channel);
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
 #if 0
 static sdp_record_t *hsp_hs_record(struct tel_agent *agent)
 {
@@ -939,6 +1183,14 @@ drop:
 }
 
 static struct default_agent default_properties[] = {
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

