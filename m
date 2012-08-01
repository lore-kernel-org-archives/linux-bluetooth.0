Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v16 10/14] audio: Move HFP HF server to telephony.c
Date: Wed,  1 Aug 2012 11:08:46 +0200
Message-Id: <1343812131-19395-11-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
References: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move HandsFree HF RFComm server from audio/manager.c to
audio/telephony.c.
Update the HandsfreeGateway API to reflect this change (remove agent
related methods).
Doing this, RFComm server related to HandsfreeGateway is only started
when an agent registers for this role of HandsFree Profile.
---
 audio/device.h    |    1 +
 audio/gateway.c   |  436 +++++++++++++++--------------------------------------
 audio/gateway.h   |    8 +
 audio/manager.c   |  210 +-------------------------
 audio/media.c     |   17 +++
 audio/telephony.c |  217 +++++++++++++++++++++++++-
 audio/transport.c |    4 +
 doc/hfp-api.txt   |   46 ------
 8 files changed, 366 insertions(+), 573 deletions(-)

diff --git a/audio/device.h b/audio/device.h
index 75f1da9..1e260e3 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -48,6 +48,7 @@ struct audio_device {
 	struct target *target;
 
 	guint hs_preauth_id;
+	guint gw_preauth_id;
 
 	struct dev_priv *priv;
 };
diff --git a/audio/gateway.c b/audio/gateway.c
index 6162948..125cb02 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -41,21 +41,20 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
+
+#include "btio.h"
+#include "../src/adapter.h"
+#include "../src/device.h"
 
 #include "sdp-client.h"
 #include "device.h"
 #include "gateway.h"
+#include "telephony.h"
 #include "log.h"
 #include "error.h"
-#include "btio.h"
 #include "dbus-common.h"
 
-struct hf_agent {
-	char *name;	/* Bus id */
-	char *path;	/* D-Bus path */
-	guint watch;	/* Disconnect watch */
-};
-
 struct connect_cb {
 	unsigned int id;
 	gateway_stream_cb_t cb;
@@ -64,14 +63,14 @@ struct connect_cb {
 
 struct gateway {
 	gateway_state_t state;
-	GIOChannel *rfcomm;
+	GIOChannel *tmp_rfcomm;
 	GIOChannel *sco;
-	GIOChannel *incoming;
+	const char *connecting_uuid;
+	const char *connecting_transport_path;
 	GSList *callbacks;
-	struct hf_agent *agent;
 	DBusMessage *msg;
-	int version;
 	gateway_lock_t lock;
+	struct telephony_device *tel_dev;
 };
 
 struct gateway_state_callback {
@@ -105,16 +104,6 @@ static const char *state2str(gateway_state_t state)
 	}
 }
 
-static void agent_free(struct hf_agent *agent)
-{
-	if (!agent)
-		return;
-
-	g_free(agent->name);
-	g_free(agent->path);
-	g_free(agent);
-}
-
 static void change_state(struct audio_device *dev, gateway_state_t new_state)
 {
 	struct gateway *gw = dev->gateway;
@@ -141,8 +130,19 @@ static void change_state(struct audio_device *dev, gateway_state_t new_state)
 
 void gateway_set_state(struct audio_device *dev, gateway_state_t new_state)
 {
+	struct gateway *gw = dev->gateway;
+
 	switch (new_state) {
 	case GATEWAY_STATE_DISCONNECTED:
+		if (gw->msg) {
+			DBusMessage *reply;
+
+			reply = btd_error_failed(gw->msg, "Connect failed");
+			g_dbus_send_message(dev->conn, reply);
+			dbus_message_unref(gw->msg);
+			gw->msg = NULL;
+		}
+
 		gateway_close(dev);
 		break;
 	case GATEWAY_STATE_CONNECTING:
@@ -152,44 +152,6 @@ void gateway_set_state(struct audio_device *dev, gateway_state_t new_state)
 	}
 }
 
-static void agent_disconnect(struct audio_device *dev, struct hf_agent *agent)
-{
-	DBusMessage *msg;
-
-	msg = dbus_message_new_method_call(agent->name, agent->path,
-			"org.bluez.HandsfreeAgent", "Release");
-
-	g_dbus_send_message(dev->conn, msg);
-}
-
-static gboolean agent_sendfd(struct hf_agent *agent, int fd,
-		DBusPendingCallNotifyFunction notify, void *data)
-{
-	struct audio_device *dev = data;
-	struct gateway *gw = dev->gateway;
-	DBusMessage *msg;
-	DBusPendingCall *call;
-
-	msg = dbus_message_new_method_call(agent->name, agent->path,
-			"org.bluez.HandsfreeAgent", "NewConnection");
-
-	dbus_message_append_args(msg, DBUS_TYPE_UNIX_FD, &fd,
-					DBUS_TYPE_UINT16, &gw->version,
-					DBUS_TYPE_INVALID);
-
-	if (dbus_connection_send_with_reply(dev->conn, msg,
-							&call, -1) == FALSE) {
-		dbus_message_unref(msg);
-		return FALSE;
-	}
-
-	dbus_pending_call_set_notify(call, notify, dev, NULL);
-	dbus_pending_call_unref(call);
-	dbus_message_unref(msg);
-
-	return TRUE;
-}
-
 static unsigned int connect_cb_new(struct gateway *gw,
 					gateway_stream_cb_t func,
 					void *user_data)
@@ -264,175 +226,59 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	run_connect_cb(dev, NULL);
 }
 
-static gboolean rfcomm_disconnect_cb(GIOChannel *chan, GIOCondition cond,
-			struct audio_device *dev)
+void gateway_slc_complete(struct audio_device *dev)
 {
-	if (cond & G_IO_NVAL)
-		return FALSE;
-
-	gateway_close(dev);
-
-	return FALSE;
-}
-
-static void newconnection_reply(DBusPendingCall *call, void *data)
-{
-	struct audio_device *dev = data;
-	struct gateway *gw = dev->gateway;
-	DBusMessage *reply = dbus_pending_call_steal_reply(call);
-	DBusError derr;
-
-	if (!dev->gateway->rfcomm) {
-		DBG("RFCOMM disconnected from server before agent reply");
-		goto done;
-	}
-
-	dbus_error_init(&derr);
-	if (!dbus_set_error_from_message(&derr, reply)) {
-		DBG("Agent reply: file descriptor passed successfully");
-		g_io_add_watch(gw->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-					(GIOFunc) rfcomm_disconnect_cb, dev);
-		change_state(dev, GATEWAY_STATE_CONNECTED);
-		goto done;
-	}
-
-	DBG("Agent reply: %s", derr.message);
-
-	dbus_error_free(&derr);
-	gateway_close(dev);
-
-done:
-	dbus_message_unref(reply);
-}
-
-static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
-				gpointer user_data)
-{
-	struct audio_device *dev = user_data;
 	struct gateway *gw = dev->gateway;
 	DBusMessage *reply;
-	int sk, ret;
 
-	if (err) {
-		error("connect(): %s", err->message);
-		goto fail;
-	}
+	DBG("Service Level Connection established");
 
-	if (!gw->agent) {
-		error("Handsfree Agent not registered");
-		goto fail;
-	}
-
-	sk = g_io_channel_unix_get_fd(chan);
-
-	if (gw->rfcomm == NULL)
-		gw->rfcomm = g_io_channel_ref(chan);
-
-	ret = agent_sendfd(gw->agent, sk, newconnection_reply, dev);
+	change_state(dev, GATEWAY_STATE_CONNECTED);
 
 	if (!gw->msg)
 		return;
 
-	if (ret)
-		reply = dbus_message_new_method_return(gw->msg);
-	else
-		reply = btd_error_failed(gw->msg, "Can't pass file descriptor");
-
+	reply = dbus_message_new_method_return(gw->msg);
 	g_dbus_send_message(dev->conn, reply);
-
-	return;
-
-fail:
-	if (gw->msg) {
-		DBusMessage *reply;
-		reply = btd_error_failed(gw->msg, "Connect failed");
-		g_dbus_send_message(dev->conn, reply);
-	}
-
-	gateway_close(dev);
-}
-
-static int get_remote_profile_version(sdp_record_t *rec)
-{
-	uuid_t uuid;
-	sdp_list_t *profiles;
-	sdp_profile_desc_t *desc;
-	int ver = 0;
-
-	sdp_uuid16_create(&uuid, HANDSFREE_PROFILE_ID);
-
-	sdp_get_profile_descs(rec, &profiles);
-	if (profiles == NULL)
-		goto done;
-
-	desc = profiles->data;
-
-	if (sdp_uuid16_cmp(&desc->uuid, &uuid) == 0)
-		ver = desc->version;
-
-	sdp_list_free(profiles, free);
-
-done:
-	return ver;
+	dbus_message_unref(gw->msg);
+	gw->msg = NULL;
 }
 
-static void get_incoming_record_cb(sdp_list_t *recs, int err,
-					gpointer user_data)
+void gateway_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct audio_device *dev = user_data;
 	struct gateway *gw = dev->gateway;
-	GError *gerr = NULL;
+	char hs_address[18];
 
-	if (err < 0) {
-		error("Unable to get service record: %s (%d)", strerror(-err),
-					-err);
-		goto fail;
+	if (err) {
+		error("%s", err->message);
+		goto failed;
 	}
 
-	if (!recs || !recs->data) {
-		error("No records found");
-		goto fail;
-	}
+	ba2str(&dev->dst, hs_address);
 
-	gw->version = get_remote_profile_version(recs->data);
-	if (gw->version == 0)
-		goto fail;
+	if (!telephony_is_uuid_supported(device_get_adapter(dev->btd_dev),
+							gw->connecting_uuid))
+		goto failed;
 
-	rfcomm_connect_cb(gw->incoming, gerr, dev);
-	return;
+	gw->tel_dev = telephony_device_connecting(chan, dev->btd_dev, dev,
+							gw->connecting_uuid);
+	gw->connecting_uuid = NULL;
+	telephony_set_media_transport_path(gw->tel_dev,
+						gw->connecting_transport_path);
+	gw->connecting_transport_path = NULL;
 
-fail:
-	gateway_close(dev);
-}
-
-static void unregister_incoming(gpointer user_data)
-{
-	struct audio_device *dev = user_data;
-	struct gateway *gw = dev->gateway;
-
-	if (gw->incoming) {
-		g_io_channel_unref(gw->incoming);
-		gw->incoming = NULL;
+	if (gw->tmp_rfcomm) {
+		g_io_channel_unref(gw->tmp_rfcomm);
+		gw->tmp_rfcomm = NULL;
 	}
-}
 
-static void rfcomm_incoming_cb(GIOChannel *chan, GError *err,
-				gpointer user_data)
-{
-	struct audio_device *dev = user_data;
-	struct gateway *gw = dev->gateway;
-	uuid_t uuid;
-
-	gw->incoming = g_io_channel_ref(chan);
+	DBG("%s: Connected to %s", dev->path, hs_address);
 
-	sdp_uuid16_create(&uuid, HANDSFREE_AGW_SVCLASS_ID);
-	if (bt_search_service(&dev->src, &dev->dst, &uuid,
-						get_incoming_record_cb, dev,
-						unregister_incoming) == 0)
-		return;
+	return;
 
-	unregister_incoming(dev);
-	gateway_close(dev);
+failed:
+	gateway_set_state(dev, GATEWAY_STATE_DISCONNECTED);
 }
 
 static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
@@ -469,13 +315,6 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		goto fail;
 	}
 
-	gw->version = get_remote_profile_version(recs->data);
-	if (gw->version == 0) {
-		error("Unable to get profile version from record");
-		err = -EINVAL;
-		goto fail;
-	}
-
 	memcpy(&uuid, classes->data, sizeof(uuid));
 	sdp_list_free(classes, free);
 
@@ -496,7 +335,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		goto fail;
 	}
 
-	io = bt_io_connect(BT_IO_RFCOMM, rfcomm_connect_cb, dev, NULL, &gerr,
+	io = bt_io_connect(BT_IO_RFCOMM, gateway_connect_cb, dev, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 				BT_IO_OPT_DEST_BDADDR, &dev->dst,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
@@ -515,6 +354,8 @@ fail:
 		DBusMessage *reply = btd_error_failed(gw->msg,
 					gerr ? gerr->message : strerror(-err));
 		g_dbus_send_message(dev->conn, reply);
+		dbus_message_unref(gw->msg);
+		gw->msg = NULL;
 	}
 
 	gateway_close(dev);
@@ -540,12 +381,22 @@ static DBusMessage *ag_connect(DBusConnection *conn, DBusMessage *msg,
 	struct gateway *gw = au_dev->gateway;
 	int err;
 
-	if (!gw->agent)
+	if (gw->state == GATEWAY_STATE_CONNECTING)
+		return btd_error_in_progress(msg);
+	else if (gw->state > GATEWAY_STATE_CONNECTING)
+		return btd_error_already_connected(msg);
+
+	if (!telephony_is_uuid_supported(device_get_adapter(au_dev->btd_dev),
+								HFP_HS_UUID))
 		return btd_error_agent_not_available(msg);
 
+	gw->connecting_uuid = HFP_HS_UUID;
+
 	err = get_records(au_dev);
-	if (err < 0)
+	if (err < 0) {
+		gw->connecting_uuid = NULL;
 		return btd_error_failed(msg, strerror(-err));
+	}
 
 	gw->msg = dbus_message_ref(msg);
 
@@ -558,13 +409,13 @@ int gateway_close(struct audio_device *device)
 	struct gateway *gw = device->gateway;
 	int sock;
 
-	if (gw->rfcomm) {
-		sock = g_io_channel_unix_get_fd(gw->rfcomm);
+	if (gw->tmp_rfcomm) {
+		sock = g_io_channel_unix_get_fd(gw->tmp_rfcomm);
 		shutdown(sock, SHUT_RDWR);
 
-		g_io_channel_shutdown(gw->rfcomm, TRUE, NULL);
-		g_io_channel_unref(gw->rfcomm);
-		gw->rfcomm = NULL;
+		g_io_channel_shutdown(gw->tmp_rfcomm, TRUE, NULL);
+		g_io_channel_unref(gw->tmp_rfcomm);
+		gw->tmp_rfcomm = NULL;
 	}
 
 	if (gw->sco) {
@@ -573,6 +424,14 @@ int gateway_close(struct audio_device *device)
 		gw->sco = NULL;
 	}
 
+	if (gw->tel_dev) {
+		telephony_device_disconnect(gw->tel_dev);
+		gw->tel_dev = NULL;
+	}
+
+	gw->connecting_uuid = NULL;
+	gw->connecting_transport_path = NULL;
+
 	change_state(device, GATEWAY_STATE_DISCONNECTED);
 	g_set_error(&gerr, GATEWAY_ERROR,
 			GATEWAY_ERROR_DISCONNECTED, "Disconnected");
@@ -586,16 +445,12 @@ static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
 	struct audio_device *device = data;
-	struct gateway *gw = device->gateway;
 	DBusMessage *reply = NULL;
 	char gw_addr[18];
 
 	if (!device->conn)
 		return NULL;
 
-	if (!gw->rfcomm)
-		return btd_error_not_connected(msg);
-
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
@@ -607,17 +462,6 @@ static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
-static void agent_exited(DBusConnection *conn, void *data)
-{
-	struct gateway *gateway = data;
-	struct hf_agent *agent = gateway->agent;
-
-	DBG("Agent %s exited", agent->name);
-
-	agent_free(agent);
-	gateway->agent = NULL;
-}
-
 static DBusMessage *ag_get_properties(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -649,75 +493,12 @@ static DBusMessage *ag_get_properties(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
-static DBusMessage *register_agent(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct audio_device *device = data;
-	struct gateway *gw = device->gateway;
-	struct hf_agent *agent;
-	const char *path, *name;
-
-	if (gw->agent)
-		return btd_error_already_exists(msg);
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-						DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
-
-	name = dbus_message_get_sender(msg);
-	agent = g_new0(struct hf_agent, 1);
-
-	agent->name = g_strdup(name);
-	agent->path = g_strdup(path);
-
-	agent->watch = g_dbus_add_disconnect_watch(conn, name,
-						agent_exited, gw, NULL);
-
-	gw->agent = agent;
-
-	return dbus_message_new_method_return(msg);
-}
-
-static DBusMessage *unregister_agent(DBusConnection *conn,
-				DBusMessage *msg, void *data)
-{
-	struct audio_device *device = data;
-	struct gateway *gw = device->gateway;
-	const char *path;
-
-	if (!gw->agent)
-		goto done;
-
-	if (strcmp(gw->agent->name, dbus_message_get_sender(msg)) != 0)
-		return btd_error_not_authorized(msg);
-
-	if (!dbus_message_get_args(msg, NULL,
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
-
-	if (strcmp(gw->agent->path, path) != 0)
-		return btd_error_does_not_exist(msg);
-
-	g_dbus_remove_watch(device->conn, gw->agent->watch);
-
-	agent_free(gw->agent);
-	gw->agent = NULL;
-
-done:
-	return dbus_message_new_method_return(msg);
-}
-
 static const GDBusMethodTable gateway_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, ag_connect) },
 	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, ag_disconnect) },
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			ag_get_properties) },
-	{ GDBUS_METHOD("RegisterAgent",
-			GDBUS_ARGS({ "agent", "o" }), NULL, register_agent) },
-	{ GDBUS_METHOD("UnregisterAgent",
-			GDBUS_ARGS({ "agent", "o" }), NULL, unregister_agent) },
 	{ }
 };
 
@@ -742,9 +523,6 @@ static void path_unregister(void *data)
 
 void gateway_unregister(struct audio_device *dev)
 {
-	if (dev->gateway->agent)
-		agent_disconnect(dev, dev->gateway->agent);
-
 	g_dbus_unregister_interface(dev->conn, dev->path,
 						AUDIO_GATEWAY_INTERFACE);
 }
@@ -785,13 +563,52 @@ int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 	if (!io)
 		return -EINVAL;
 
-	dev->gateway->rfcomm = g_io_channel_ref(io);
+	dev->gateway->tmp_rfcomm = g_io_channel_ref(io);
 
 	change_state(dev, GATEWAY_STATE_CONNECTING);
 
 	return 0;
 }
 
+GIOChannel *gateway_get_rfcomm(struct audio_device *dev)
+{
+	struct gateway *gw = dev->gateway;
+
+	return gw->tmp_rfcomm;
+}
+
+void gateway_set_connecting_uuid(struct audio_device *dev, const char *uuid)
+{
+	struct gateway *gw = dev->gateway;
+
+	gw->connecting_uuid = uuid;
+}
+
+void gateway_set_media_transport_path(struct audio_device *dev,
+							const char *path)
+{
+	struct gateway *gw = dev->gateway;
+
+	DBG("MediaTransport path: %s", path);
+
+	if (gw->tel_dev == NULL) {
+		gw->connecting_transport_path = path;
+		return;
+	}
+
+	telephony_set_media_transport_path(gw->tel_dev, path);
+}
+
+const char *gateway_get_telephony_agent_name(struct audio_device *dev)
+{
+	struct gateway *gw = dev->gateway;
+
+	if (gw == NULL || gw->tel_dev == NULL)
+		return NULL;
+
+	return telephony_get_agent_name(gw->tel_dev);
+}
+
 int gateway_connect_sco(struct audio_device *dev, GIOChannel *io)
 {
 	struct gateway *gw = dev->gateway;
@@ -809,21 +626,6 @@ int gateway_connect_sco(struct audio_device *dev, GIOChannel *io)
 	return 0;
 }
 
-void gateway_start_service(struct audio_device *dev)
-{
-	struct gateway *gw = dev->gateway;
-	GError *err = NULL;
-
-	if (gw->rfcomm == NULL)
-		return;
-
-	if (!bt_io_accept(gw->rfcomm, rfcomm_incoming_cb, dev, NULL, &err)) {
-		error("bt_io_accept: %s", err->message);
-		g_error_free(err);
-		gateway_close(dev);
-	}
-}
-
 static gboolean request_stream_cb(gpointer data)
 {
 	run_connect_cb(data, NULL);
@@ -839,7 +641,7 @@ unsigned int gateway_request_stream(struct audio_device *dev,
 	GError *err = NULL;
 	GIOChannel *io;
 
-	if (!gw->rfcomm)
+	if (!gw->tel_dev)
 		get_records(dev);
 	else if (!gw->sco) {
 		io = bt_io_connect(BT_IO_SCO, sco_connect_cb, dev, NULL, &err,
@@ -866,7 +668,7 @@ int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t cb,
 
 	id = connect_cb_new(gw, cb, user_data);
 
-	if (!gw->rfcomm)
+	if (!gw->tel_dev)
 		get_records(dev);
 	else if (cb)
 		g_idle_add(request_stream_cb, dev);
diff --git a/audio/gateway.h b/audio/gateway.h
index 77f5787..b42fdf1 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -74,3 +74,11 @@ gboolean gateway_remove_state_cb(unsigned int id);
 gateway_lock_t gateway_get_lock(struct audio_device *dev);
 gboolean gateway_lock(struct audio_device *dev, gateway_lock_t lock);
 gboolean gateway_unlock(struct audio_device *dev, gateway_lock_t lock);
+
+void gateway_connect_cb(GIOChannel *chan, GError *err, gpointer user_data);
+void gateway_slc_complete(struct audio_device *dev);
+void gateway_set_connecting_uuid(struct audio_device *dev, const char *uuid);
+GIOChannel *gateway_get_rfcomm(struct audio_device *dev);
+void gateway_set_media_transport_path(struct audio_device *dev,
+							const char *path);
+const char *gateway_get_telephony_agent_name(struct audio_device *dev);
diff --git a/audio/manager.c b/audio/manager.c
index 4ab0186..5dcf52d 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -89,8 +89,6 @@ typedef enum {
 struct audio_adapter {
 	struct btd_adapter *btd_adapter;
 	gboolean powered;
-	uint32_t hfp_hs_record_id;
-	GIOChannel *hfp_hs_server;
 	gint ref;
 };
 
@@ -222,196 +220,6 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 	}
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
-			ag_address, device->path);
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
-	int perr;
-
-	bt_io_get(chan, BT_IO_RFCOMM, &err,
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
-	perr = audio_device_request_authorization(device, server_uuid,
-						gateway_auth_cb, device);
-	if (perr < 0) {
-		DBG("Authorization denied: %s", strerror(-perr));
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
-	io = bt_io_listen(BT_IO_RFCOMM, NULL, hf_io_cb, adapter, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
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
-	if (add_record_to_server(&src, record) < 0) {
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
 static int audio_probe(struct btd_device *device, GSList *uuids)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
@@ -579,17 +387,12 @@ static void headset_server_remove(struct btd_adapter *adapter)
 static int gateway_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
-	int err;
 
 	adp = audio_adapter_get(adapter);
 	if (!adp)
 		return -EINVAL;
 
-	err = gateway_server_init(adp);
-	if (err < 0)
-		audio_adapter_unref(adp);
-
-	return err;
+	return 0;
 }
 
 static void gateway_server_remove(struct btd_adapter *adapter)
@@ -603,17 +406,6 @@ static void gateway_server_remove(struct btd_adapter *adapter)
 	if (!adp)
 		return;
 
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
 	audio_adapter_unref(adp);
 }
 
diff --git a/audio/media.c b/audio/media.c
index c608c41..3e5d12d 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -647,6 +647,7 @@ static void gateway_state_changed(struct audio_device *dev,
 {
 	struct media_endpoint *endpoint = user_data;
 	struct media_transport *transport;
+	const char *path;
 
 	DBG("");
 
@@ -664,6 +665,13 @@ static void gateway_state_changed(struct audio_device *dev,
 	case GATEWAY_STATE_CONNECTING:
 		set_configuration(endpoint, dev, NULL, 0,
 					gateway_setconf_cb, dev, NULL);
+
+		transport = find_device_transport(endpoint, dev);
+		if (transport == NULL)
+			break;
+
+		path = media_transport_get_path(transport);
+		gateway_set_media_transport_path(dev, path);
 		break;
 	case GATEWAY_STATE_CONNECTED:
 		break;
@@ -743,9 +751,18 @@ static gboolean endpoint_init_hs(struct media_endpoint *endpoint, int *err)
 
 	for (l = list; l != NULL; l = l->next) {
 		struct audio_device *dev = l->data;
+		struct media_transport *transport;
+		const char *path;
 
 		set_configuration(endpoint, dev, NULL, 0,
 						gateway_setconf_cb, dev, NULL);
+
+		transport = find_device_transport(endpoint, dev);
+		if (transport == NULL)
+			break;
+
+		path = media_transport_get_path(transport);
+		gateway_set_media_transport_path(dev, path);
 	}
 
 	g_slist_free(list);
diff --git a/audio/telephony.c b/audio/telephony.c
index da1797f..dc76d60 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -48,6 +48,7 @@
 #include "glib-helper.h"
 #include "sdp-client.h"
 #include "headset.h"
+#include "gateway.h"
 #include "telephony.h"
 #include "dbus-common.h"
 #include "sdpd.h"
@@ -335,6 +336,44 @@ done:
 	dbus_message_unref(reply);
 }
 
+static gboolean ag_dev_disconnect_cb(GIOChannel *chan, GIOCondition cond,
+					gpointer data)
+{
+	struct telephony_device *tel_dev = data;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	gateway_set_state(tel_dev->au_dev, GATEWAY_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
+static void ag_newconnection_reply(DBusPendingCall *call, void *user_data)
+{
+	struct telephony_device *tel_dev = user_data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Agent reply: %s", derr.message);
+		dbus_error_free(&derr);
+		gateway_set_state(tel_dev->au_dev, GATEWAY_STATE_DISCONNECTED);
+		goto done;
+	}
+
+	DBG("Agent reply: file descriptor passed successfully");
+	g_io_add_watch(tel_dev->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			ag_dev_disconnect_cb, tel_dev);
+	gateway_slc_complete(tel_dev->au_dev);
+
+done:
+	dbus_pending_call_unref(tel_dev->call);
+	tel_dev->call = NULL;
+	dbus_message_unref(reply);
+}
+
 static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct telephony_device *tel_dev = user_data;
@@ -390,7 +429,11 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	return;
 
 failed:
-	headset_set_state(tel_dev->au_dev, HEADSET_STATE_DISCONNECTED);
+	if (g_strcmp0(tel_dev->config->uuid, HSP_AG_UUID) == 0 ||
+			g_strcmp0(tel_dev->config->uuid, HFP_AG_UUID) == 0)
+		headset_set_state(tel_dev->au_dev, HEADSET_STATE_DISCONNECTED);
+	else if (g_strcmp0(tel_dev->config->uuid, HFP_HS_UUID) == 0)
+		gateway_set_state(tel_dev->au_dev, GATEWAY_STATE_DISCONNECTED);
 }
 
 struct telephony_device *telephony_device_connecting(GIOChannel *io,
@@ -468,6 +511,170 @@ const char *telephony_get_agent_name(struct telephony_device *device)
 	return device->name;
 }
 
+static sdp_record_t *hfp_hs_record(struct telephony_agent *agent)
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
+static void gateway_auth_cb(DBusError *derr, void *user_data)
+{
+	struct audio_device *au_dev = user_data;
+	GError *err = NULL;
+	GIOChannel *io;
+
+	if (au_dev->gw_preauth_id) {
+		g_source_remove(au_dev->gw_preauth_id);
+		au_dev->gw_preauth_id = 0;
+	}
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		gateway_set_state(au_dev, GATEWAY_STATE_DISCONNECTED);
+		return;
+	}
+
+	io = gateway_get_rfcomm(au_dev);
+
+	if (!bt_io_accept(io, gateway_connect_cb, au_dev, NULL, &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
+		gateway_set_state(au_dev, GATEWAY_STATE_DISCONNECTED);
+		return;
+	}
+}
+
+static gboolean gateway_preauth_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	struct audio_device *au_dev = user_data;
+
+	DBG("Gateway disconnected during authorization");
+
+	audio_device_cancel_authorization(au_dev, gateway_auth_cb, au_dev);
+
+	gateway_set_state(au_dev, GATEWAY_STATE_DISCONNECTED);
+
+	au_dev->gw_preauth_id = 0;
+
+	return FALSE;
+}
+
+static void hf_confirm(GIOChannel *chan, gpointer data)
+{
+	struct telephony_agent *agent = data;
+	struct audio_device *au_dev;
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
+	au_dev = manager_get_device(&src, &dst, TRUE);
+	if (!au_dev)
+		goto drop;
+
+	if (!au_dev->gateway) {
+		btd_device_add_uuid(au_dev->btd_dev, agent->config->r_uuid);
+		if (!au_dev->gateway)
+			goto drop;
+	}
+
+	if (gateway_is_active(au_dev)) {
+		DBG("Refusing new connection since one already exists");
+		goto drop;
+	}
+
+	gateway_set_connecting_uuid(au_dev, agent->config->uuid);
+
+	if (gateway_connect_rfcomm(au_dev, chan) < 0) {
+		error("Allocating new GIOChannel failed!");
+		goto drop;
+	}
+
+	perr = audio_device_request_authorization(au_dev, agent->config->uuid,
+						gateway_auth_cb, au_dev);
+	if (perr < 0) {
+		DBG("Authorization denied: %s", strerror(-perr));
+		gateway_set_state(au_dev, GATEWAY_STATE_DISCONNECTED);
+		return;
+	}
+
+	au_dev->gw_preauth_id = g_io_add_watch(chan,
+					G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+					gateway_preauth_cb, au_dev);
+
+	return;
+
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+}
+
 static sdp_record_t *hsp_ag_record(struct telephony_agent *agent)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -728,6 +935,14 @@ static struct profile_config default_configs[] = {
 		hsp_ag_record,
 		ag_confirm,
 		hs_newconnection_reply },
+	{ HFP_HS_UUID,
+		DEFAULT_HF_HS_CHANNEL,
+		HFP_AG_UUID,
+		HANDSFREE_AGW_SVCLASS_ID,
+		HANDSFREE_PROFILE_ID,
+		hfp_hs_record,
+		hf_confirm,
+		ag_newconnection_reply },
 	{ HFP_AG_UUID,
 		DEFAULT_HF_AG_CHANNEL,
 		HFP_HS_UUID,
diff --git a/audio/transport.c b/audio/transport.c
index 7236e43..7a9b5ea 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -866,6 +866,10 @@ static gboolean check_telephony_agent_name(struct media_transport *transport,
 	if (tel_agent != NULL && g_strcmp0(tel_agent, sender) == 0)
 		return TRUE;
 
+	tel_agent = gateway_get_telephony_agent_name(transport->device);
+	if (tel_agent != NULL && g_strcmp0(tel_agent, sender) == 0)
+		return TRUE;
+
 	return FALSE;
 }
 
diff --git a/doc/hfp-api.txt b/doc/hfp-api.txt
index fad89ae..afc1277 100644
--- a/doc/hfp-api.txt
+++ b/doc/hfp-api.txt
@@ -22,24 +22,6 @@ Methods		void Connect()
 			Returns all properties for the interface. See the
 			properties section for available properties.
 
-		void RegisterAgent(object path)
-
-			The object path defines the path the of the agent
-			that will be called when a new Handsfree connection
-			is established.
-
-			If an application disconnects from the bus all of its
-			registered agents will be removed.
-
-		void UnregisterAgent(object path)
-
-			This unregisters the agent that has been previously
-			registered. The object path parameter must match the
-			same value that has been used on registration.
-
-			Possible Errors: org.bluez.Error.Failed
-					 org.bluez.Error.InvalidArguments
-
 
 Signals		PropertyChanged(string name, variant value)
 
@@ -54,31 +36,3 @@ Properties	string State [readonly]
 				"connecting"
 				"connected"
 				"playing"
-
-HandsfreeAgent hierarchy
-===============
-
-Service         unique name
-Interface       org.bluez.HandsfreeAgent
-Object path     freely definable
-
-Methods		void NewConnection(filedescriptor fd, uint16 version)
-
-			This method gets called whenever a new handsfree
-			connection has been established.  The objectpath
-			contains the object path of the remote device.
-
-			The agent should only return successfully once the
-			establishment of the service level connection (SLC)
-			has been completed.  In the case of Handsfree this
-			means that BRSF exchange has been performed and
-			necessary initialization has been done.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.Failed
-
-		void Release()
-
-			This method gets called whenever the service daemon
-			unregisters the agent or whenever the Adapter where
-			the HandsfreeAgent registers itself is removed.
-- 
1.7.9.5

