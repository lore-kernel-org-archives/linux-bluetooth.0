Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: ofono@ofono.org
Subject: [PATCH] Implement HandsfreeGateway Interface
Date: Thu,  4 Feb 2010 16:18:54 -0200
Message-Id: <1265307534-1250-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1265303486-10865-1-git-send-email-padovan@profusion.mobi>
References: <1265303486-10865-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Create a interface where a Handsfree agent can register and use BlueZ to
handle the rfcomm and sco links.

Many thanks to Zhenhua Zhang <zhenhua.zhang@intel.com> for his
prototype on this code.
---
 audio/device.c  |    3 +
 audio/gateway.c |  433 ++++++++++++++++++++++++++++++++++++++++++-------------
 audio/gateway.h |   14 ++-
 audio/manager.c |   19 +--
 audio/unix.c    |   13 ++-
 doc/hfp-api.txt |   82 +++++++++++
 6 files changed, 438 insertions(+), 126 deletions(-)
 create mode 100644 doc/hfp-api.txt

diff --git a/audio/device.c b/audio/device.c
index f7141e5..b8ea927 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -663,6 +663,9 @@ void audio_device_unregister(struct audio_device *device)
 	if (device->headset)
 		headset_unregister(device);
 
+	if (device->gateway)
+		gateway_unregister(device);
+
 	if (device->sink)
 		sink_unregister(device);
 
diff --git a/audio/gateway.c b/audio/gateway.c
index 3dc09ff..eaac8ab 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2008-2009  Leonid Movshovich <event.riga@gmail.org>
+ *  Copyright (C) 2010  ProFUSION embedded systems
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -52,20 +53,102 @@
 #include "btio.h"
 #include "dbus-common.h"
 
-#define RFCOMM_BUF_SIZE 256
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+struct hf_agent {
+	char *name;	/* Bus id */
+	char *path;	/* D-Bus path */
+	guint watch;	/* Disconnect watch */
+};
 
 struct gateway {
 	gateway_state_t state;
 	GIOChannel *rfcomm;
-	guint rfcomm_watch_id;
 	GIOChannel *sco;
 	gateway_stream_cb_t sco_start_cb;
 	void *sco_start_cb_data;
-	DBusMessage *connect_message;
+	struct hf_agent *agent;
+	DBusMessage *msg;
 };
 
 int gateway_close(struct audio_device *device);
 
+static const char *state2str(gateway_state_t state)
+{
+	switch (state) {
+	case GATEWAY_STATE_DISCONNECTED:
+		return "disconnected";
+	case GATEWAY_STATE_CONNECTING:
+		return "connecting";
+	case GATEWAY_STATE_CONNECTED:
+		return "connected";
+	case GATEWAY_STATE_PLAYING:
+		return "playing";
+	default:
+		return "";
+	}
+}
+
+static void agent_free(struct hf_agent *agent)
+{
+	if (!agent)
+		return;
+
+	g_free(agent->name);
+	g_free(agent->path);
+	g_free(agent);
+}
+
+static void change_state(struct audio_device *dev, gateway_state_t new_state)
+{
+	struct gateway *gw = dev->gateway;
+	const char *val;
+
+	if (gw->state == new_state)
+		return;
+
+	val = state2str(new_state);
+	gw->state = new_state;
+
+	emit_property_changed(dev->conn, dev->path,
+			AUDIO_GATEWAY_INTERFACE, "State",
+			DBUS_TYPE_STRING, &val);
+}
+
+static void agent_disconnect(struct audio_device *dev, struct hf_agent *agent)
+{
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(agent->name, agent->path,
+			"org.bluez.HandsfreeAgent", "Release");
+
+	g_dbus_send_message(dev->conn, msg);
+}
+
+static gboolean agent_sendfd(struct hf_agent *agent, int fd,
+		DBusPendingCallNotifyFunction notify, void *data)
+{
+	struct audio_device *dev = data;
+	DBusMessage *msg;
+	DBusPendingCall *call;
+
+	msg = dbus_message_new_method_call(agent->name, agent->path,
+			"org.bluez.HandsfreeAgent", "NewConnection");
+
+	dbus_message_append_args(msg, DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(dev->conn, msg, &call, -1) == FALSE)
+		return FALSE;
+
+	dbus_pending_call_set_notify(call, notify, dev, NULL);
+	dbus_pending_call_unref(call);
+
+	return TRUE;
+}
+
 static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
 			struct audio_device *dev)
 {
@@ -79,6 +162,7 @@ static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
 		g_io_channel_shutdown(gw->sco, TRUE, NULL);
 		g_io_channel_unref(gw->sco);
 		gw->sco = NULL;
+		change_state(dev, GATEWAY_STATE_CONNECTED);
 		return FALSE;
 	}
 
@@ -92,67 +176,99 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	debug("at the begin of sco_connect_cb() in gateway.c");
 
+	gw->sco = g_io_channel_ref(chan);
+
+	if (gw->sco_start_cb)
+		gw->sco_start_cb(dev, err, gw->sco_start_cb_data);
+
 	if (err) {
 		error("sco_connect_cb(): %s", err->message);
-		/* not sure, but from other point of view,
-		 * what is the reason to have headset which
-		 * cannot play audio? */
-		if (gw->sco_start_cb)
-			gw->sco_start_cb(NULL, gw->sco_start_cb_data);
 		gateway_close(dev);
 		return;
 	}
 
-	gw->sco = g_io_channel_ref(chan);
-	if (gw->sco_start_cb)
-		gw->sco_start_cb(dev, gw->sco_start_cb_data);
-
-	/* why is this here? */
-	fcntl(g_io_channel_unix_get_fd(chan), F_SETFL, 0);
 	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) sco_io_cb, dev);
 }
 
+static void newconnection_reply(DBusPendingCall *call, void *data)
+{
+	struct audio_device *dev = data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	if (!dev->gateway->rfcomm) {
+		debug("RFCOMM disconnected from server before agent reply");
+		goto done;
+	}
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply)) {
+		debug("Agent reply: file descriptor passed successfuly");
+		change_state(dev, GATEWAY_STATE_CONNECTED);
+		goto done;
+	}
+
+	debug("Agent reply: %s", derr.message);
+
+	dbus_error_free(&derr);
+	gateway_close(dev);
+
+done:
+	dbus_message_unref(reply);
+}
+
 static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 				gpointer user_data)
 {
 	struct audio_device *dev = user_data;
 	struct gateway *gw = dev->gateway;
-	gchar gw_addr[18];
-	GIOFlags flags;
+	DBusMessage *reply;
+	int sk;
 
 	if (err) {
 		error("connect(): %s", err->message);
 		if (gw->sco_start_cb)
-			gw->sco_start_cb(NULL, gw->sco_start_cb_data);
-		return;
+			gw->sco_start_cb(dev, err, gw->sco_start_cb_data);
+		goto fail;
 	}
 
-	ba2str(&dev->dst, gw_addr);
-	/* Blocking mode should be default, but just in case: */
-	flags = g_io_channel_get_flags(chan);
-	flags &= ~G_IO_FLAG_NONBLOCK;
-	flags &= G_IO_FLAG_MASK;
-	g_io_channel_set_flags(chan, flags, NULL);
-	g_io_channel_set_encoding(chan, NULL, NULL);
-	g_io_channel_set_buffered(chan, FALSE);
-	if (!gw->rfcomm)
-		gw->rfcomm = g_io_channel_ref(chan);
+	if (!gw->agent) {
+		error("Handfree Agent not registered");
+		goto fail;
+	}
 
-	if (NULL != gw->sco_start_cb)
-		gw->sco_start_cb(NULL, gw->sco_start_cb_data);
+	sk = g_io_channel_unix_get_fd(chan);
 
-	gateway_close(dev);
+	gw->rfcomm = g_io_channel_ref(chan);
+
+	if (!agent_sendfd(gw->agent, sk, newconnection_reply, dev))
+		reply = g_dbus_create_error(gw->msg, ERROR_INTERFACE ".Failed",
+					"Can not pass file descriptor");
+	else
+		reply = dbus_message_new_method_return(gw->msg);
+
+	g_dbus_send_message(dev->conn, reply);
+
+	return;
+
+fail:
+	if (gw->msg)
+		error_common_reply(dev->conn, gw->msg,
+						ERROR_INTERFACE ".Failed",
+						"Connection attempt failed");
+
+
+	change_state(dev, GATEWAY_STATE_DISCONNECTED);
 }
 
 static void get_record_cb(sdp_list_t *recs, int perr, gpointer user_data)
 {
 	struct audio_device *dev = user_data;
-	DBusMessage *msg = dev->gateway->connect_message;
-	int ch = -1;
+	struct gateway *gw = dev->gateway;
+	int ch;
 	sdp_list_t *protos, *classes;
 	uuid_t uuid;
-	gateway_stream_cb_t sco_cb;
 	GIOChannel *io;
 	GError *err = NULL;
 
@@ -164,16 +280,19 @@ static void get_record_cb(sdp_list_t *recs, int perr, gpointer user_data)
 
 	if (!recs || !recs->data) {
 		error("No records found");
+		perr = EIO;
 		goto fail;
 	}
 
 	if (sdp_get_service_classes(recs->data, &classes) < 0) {
 		error("Unable to get service classes from record");
+		perr = EINVAL;
 		goto fail;
 	}
 
 	if (sdp_get_access_protos(recs->data, &protos) < 0) {
 		error("Unable to get access protocols from record");
+		perr = ENODATA;
 		goto fail;
 	}
 
@@ -182,10 +301,9 @@ static void get_record_cb(sdp_list_t *recs, int perr, gpointer user_data)
 
 	if (!sdp_uuid128_to_uuid(&uuid) || uuid.type != SDP_UUID16 ||
 			uuid.value.uuid16 != HANDSFREE_AGW_SVCLASS_ID) {
-		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free,
-									NULL);
 		sdp_list_free(protos, NULL);
 		error("Invalid service record or not HFP");
+		perr = EIO;
 		goto fail;
 	}
 
@@ -194,6 +312,7 @@ static void get_record_cb(sdp_list_t *recs, int perr, gpointer user_data)
 	sdp_list_free(protos, NULL);
 	if (ch <= 0) {
 		error("Unable to extract RFCOMM channel from service record");
+		perr = EIO;
 		goto fail;
 	}
 
@@ -204,29 +323,31 @@ static void get_record_cb(sdp_list_t *recs, int perr, gpointer user_data)
 				BT_IO_OPT_INVALID);
 	if (!io) {
 		error("Unable to connect: %s", err->message);
-		if (msg) {
-			error_common_reply(dev->conn, msg, ERROR_INTERFACE
-						".ConnectionAttemptFailed",
-						err->message);
-			msg = NULL;
-		}
-		g_error_free(err);
 		gateway_close(dev);
+		goto fail;
 	}
 
 	g_io_channel_unref(io);
+
+	change_state(dev, GATEWAY_STATE_CONNECTING);
 	return;
 
 fail:
-	if (msg)
-		error_common_reply(dev->conn, msg, ERROR_INTERFACE
-					".NotSupported", "Not supported");
+	if (gw->msg)
+		error_common_reply(dev->conn, gw->msg,
+					ERROR_INTERFACE ".NotSupported",
+					"Not supported");
 
-	dev->gateway->connect_message = NULL;
+	change_state(dev, GATEWAY_STATE_DISCONNECTED);
 
-	sco_cb = dev->gateway->sco_start_cb;
-	if (sco_cb)
-		sco_cb(NULL, dev->gateway->sco_start_cb_data);
+	if (!err)
+		g_set_error(&err, BT_IO_ERROR, BT_IO_ERROR_FAILED,
+				"connect: %s (%d)", strerror(perr), perr);
+
+	if (gw->sco_start_cb)
+		gw->sco_start_cb(dev, err, gw->sco_start_cb_data);
+
+	g_error_free(err);
 }
 
 static int get_records(struct audio_device *device)
@@ -244,23 +365,47 @@ static DBusMessage *ag_connect(DBusConnection *conn, DBusMessage *msg,
 	struct audio_device *au_dev = (struct audio_device *) data;
 	struct gateway *gw = au_dev->gateway;
 
-	debug("at the begin of ag_connect()");
-	if (gw->rfcomm)
+	if (!gw->agent)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".AlreadyConnected",
-					"Already Connected");
+				".Failed", "Agent not assigned");
 
-	gw->connect_message = dbus_message_ref(msg);
-	if (get_records(au_dev) < 0) {
-		dbus_message_unref(gw->connect_message);
+	if (get_records(au_dev) < 0)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
 					".ConnectAttemptFailed",
 					"Connect Attempt Failed");
-	}
-	debug("at the end of ag_connect()");
+
+	gw->msg = dbus_message_ref(msg);
+
 	return NULL;
 }
 
+int gateway_close(struct audio_device *device)
+{
+	struct gateway *gw = device->gateway;
+	int sock;
+
+	if (gw->rfcomm) {
+		sock = g_io_channel_unix_get_fd(gw->rfcomm);
+		shutdown(sock, SHUT_RDWR);
+
+		g_io_channel_shutdown(gw->rfcomm, TRUE, NULL);
+		g_io_channel_unref(gw->rfcomm);
+		gw->rfcomm = NULL;
+	}
+
+	if (gw->sco) {
+		g_io_channel_shutdown(gw->sco, TRUE, NULL);
+		g_io_channel_unref(gw->sco);
+		gw->sco = NULL;
+		gw->sco_start_cb = NULL;
+		gw->sco_start_cb_data = NULL;
+	}
+
+	change_state(device, GATEWAY_STATE_DISCONNECTED);
+
+	return 0;
+}
+
 static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -269,6 +414,9 @@ static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 	DBusMessage *reply = NULL;
 	char gw_addr[18];
 
+	if (!device->conn)
+		return NULL;
+
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
@@ -285,16 +433,109 @@ static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
+static void agent_exited(DBusConnection *conn, void *data)
+{
+	struct gateway *gateway = data;
+	struct hf_agent *agent = gateway->agent;
+
+	debug("Agent %s exited", agent->name);
+
+	agent_free(agent);
+	gateway->agent = NULL;
+}
+
 static DBusMessage *ag_get_properties(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
-	return NULL;
+	struct audio_device *device = data;
+	struct gateway *gw = device->gateway;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *value;
+
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	value = state2str(gw->state);
+	dict_append_entry(&dict, "State",
+			DBUS_TYPE_STRING, &value);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct audio_device *device = data;
+	struct gateway *gw = device->gateway;
+	struct hf_agent *agent;
+	const char *path, *name;
+
+	if (gw->agent)
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".AlreadyExists",
+					"Agent already exists");
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID))
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid argument");
+
+	name = dbus_message_get_sender(msg);
+	agent = g_new0(struct hf_agent, 1);
+
+	agent->name = g_strdup(name);
+	agent->path = g_strdup(path);
+
+	agent->watch = g_dbus_add_disconnect_watch(conn, name,
+						agent_exited, gw, NULL);
+
+	gw->agent = agent;
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_agent(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct audio_device *device = data;
+	struct gateway *gw = device->gateway;
+
+	if (!gw->agent)
+		goto done;
+
+	if (strcmp(gw->agent->name, dbus_message_get_sender(msg)) != 0)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+							"Permission denied");
+
+	g_dbus_remove_watch(device->conn, gw->agent->watch);
+
+	agent_free(gw->agent);
+	gw->agent = NULL;
+
+done:
+	return dbus_message_new_method_return(msg);
 }
 
 static GDBusMethodTable gateway_methods[] = {
 	{ "Connect", "", "", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect", "", "", ag_disconnect },
+	{ "Disconnect", "", "", ag_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetProperties", "", "a{sv}", ag_get_properties },
+	{ "RegisterAgent", "o", "", register_agent },
+	{ "UnregisterAgent", "o", "", unregister_agent },
 	{ NULL, NULL, NULL, NULL }
 };
 
@@ -303,9 +544,19 @@ static GDBusSignalTable gateway_signals[] = {
 	{ NULL, NULL }
 };
 
+void gateway_unregister(struct audio_device *dev)
+{
+	if (dev->gateway->agent)
+		agent_disconnect(dev, dev->gateway->agent);
+
+	g_dbus_unregister_interface(dev->conn, dev->path,
+						AUDIO_GATEWAY_INTERFACE);
+}
+
 struct gateway *gateway_init(struct audio_device *dev)
 {
-	struct gateway *gw;
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return NULL;
 
 	if (!g_dbus_register_interface(dev->conn, dev->path,
 					AUDIO_GATEWAY_INTERFACE,
@@ -313,10 +564,7 @@ struct gateway *gateway_init(struct audio_device *dev)
 					NULL, dev, NULL))
 		return NULL;
 
-	debug("in gateway_init, dev is %p", dev);
-	gw = g_new0(struct gateway, 1);
-	gw->state = GATEWAY_STATE_DISCONNECTED;
-	return gw;
+	return g_new0(struct gateway, 1);
 
 }
 
@@ -331,8 +579,7 @@ int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 	if (!io)
 		return -EINVAL;
 
-	g_io_channel_ref(io);
-	dev->gateway->rfcomm = io;
+	dev->gateway->rfcomm = g_io_channel_ref(io);
 
 	return 0;
 }
@@ -347,42 +594,25 @@ int gateway_connect_sco(struct audio_device *dev, GIOChannel *io)
 	gw->sco = g_io_channel_ref(io);
 
 	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-                                (GIOFunc) sco_io_cb, dev);
-	return 0;
-}
+						(GIOFunc) sco_io_cb, dev);
 
-void gateway_start_service(struct audio_device *device)
-{
-	rfcomm_connect_cb(device->gateway->rfcomm, NULL, device);
+	change_state(dev, GATEWAY_STATE_PLAYING);
+
+	return 0;
 }
 
-int gateway_close(struct audio_device *device)
+void gateway_start_service(struct audio_device *dev)
 {
-	struct gateway *gw = device->gateway;
-	GIOChannel *rfcomm = gw->rfcomm;
-	GIOChannel *sco = gw->sco;
-	gboolean value = FALSE;
+	struct gateway *gw = dev->gateway;
+	GError *err = NULL;
 
-	if (rfcomm) {
-		g_io_channel_shutdown(rfcomm, TRUE, NULL);
-		g_io_channel_unref(rfcomm);
-		gw->rfcomm = NULL;
-	}
+	if (gw->rfcomm == NULL)
+		return;
 
-	if (sco) {
-		g_io_channel_shutdown(sco, TRUE, NULL);
-		g_io_channel_unref(sco);
-		gw->sco = NULL;
-		gw->sco_start_cb = NULL;
-		gw->sco_start_cb_data = NULL;
+	if (!bt_io_accept(gw->rfcomm, rfcomm_connect_cb, dev, NULL, &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
 	}
-
-	gw->state = GATEWAY_STATE_DISCONNECTED;
-
-	emit_property_changed(device->conn, device->path,
-				AUDIO_GATEWAY_INTERFACE,
-				"Connected", DBUS_TYPE_BOOLEAN, &value);
-	return 0;
 }
 
 /* These are functions to be called from unix.c for audio system
@@ -410,10 +640,8 @@ gboolean gateway_request_stream(struct audio_device *dev,
 			g_error_free(err);
 			return FALSE;
 		}
-	} else {
-		if (cb)
-			cb(dev, user_data);
-	}
+	} else if (cb)
+		cb(dev, err, user_data);
 
 	return TRUE;
 }
@@ -430,7 +658,7 @@ int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t sco_cb,
 	}
 
 	if (sco_cb)
-		sco_cb(dev, user_data);
+		sco_cb(dev, NULL, user_data);
 
 	return 0;
 }
@@ -464,4 +692,3 @@ void gateway_suspend_stream(struct audio_device *dev)
 	gw->sco_start_cb = NULL;
 	gw->sco_start_cb_data = NULL;
 }
-
diff --git a/audio/gateway.h b/audio/gateway.h
index 3b0457f..a45ef82 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -22,20 +22,24 @@
  *
  */
 
-#define AUDIO_GATEWAY_INTERFACE "org.bluez.HeadsetGateway"
+#define AUDIO_GATEWAY_INTERFACE "org.bluez.HandsfreeGateway"
 
-#define DEFAULT_HSP_HS_CHANNEL 6
 #define DEFAULT_HFP_HS_CHANNEL 7
 
 typedef enum {
 	GATEWAY_STATE_DISCONNECTED,
-	GATEWAY_STATE_CONNECTED
+	GATEWAY_STATE_CONNECTING,
+	GATEWAY_STATE_CONNECTED,
+	GATEWAY_STATE_PLAYING,
 } gateway_state_t;
 
-typedef void (*gateway_stream_cb_t) (struct audio_device *dev, void *user_data);
+typedef void (*gateway_stream_cb_t) (struct audio_device *dev, GError *err,
+		void *user_data);
+
+void gateway_unregister(struct audio_device *dev);
 struct gateway *gateway_init(struct audio_device *device);
 gboolean gateway_is_connected(struct audio_device *dev);
-int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *chan);
+int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io);
 int gateway_connect_sco(struct audio_device *dev, GIOChannel *chan);
 void gateway_start_service(struct audio_device *device);
 gboolean gateway_request_stream(struct audio_device *dev,
diff --git a/audio/manager.c b/audio/manager.c
index 413c1f3..06c7d78 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -198,7 +198,7 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 		break;
 	case HANDSFREE_AGW_SVCLASS_ID:
 		debug("Found Handsfree AG record");
-		if (device->gateway == NULL)
+		if (enabled.gateway && (device->gateway == NULL))
 			device->gateway = gateway_init(device);
 		break;
 	case AUDIO_SINK_SVCLASS_ID:
@@ -567,8 +567,8 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 		return;
 	}
 
-	server_uuid = HFP_HS_UUID;
-	remote_uuid = HFP_AG_UUID;
+	server_uuid = HFP_AG_UUID;
+	remote_uuid = HFP_HS_UUID;
 	svclass = HANDSFREE_AGW_SVCLASS_ID;
 
 	device = manager_get_device(&src, &dst, TRUE);
@@ -794,6 +794,7 @@ static void audio_remove(struct btd_device *device)
 	devices = g_slist_remove(devices, dev);
 
 	audio_device_unregister(dev);
+
 }
 
 static struct audio_adapter *audio_adapter_ref(struct audio_adapter *adp)
@@ -905,22 +906,12 @@ static void headset_server_remove(struct btd_adapter *adapter)
 static int gateway_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
-	int ret;
-
-	DBG("path %s", path);
 
 	adp = audio_adapter_get(adapter);
 	if (!adp)
 		return -EINVAL;
 
-	ret = gateway_server_init(adp);
-	if (ret < 0) {
-		audio_adapter_ref(adp);
-		return ret;
-	}
-
-	return 0;
+	return gateway_server_init(adp);
 }
 
 static void gateway_server_remove(struct btd_adapter *adapter)
diff --git a/audio/unix.c b/audio/unix.c
index 5cf4f94..c2d6623 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -318,14 +318,14 @@ failed:
 	unix_ipc_error(client, BT_SET_CONFIGURATION, EIO);
 }
 
-static void gateway_setup_complete(struct audio_device *dev, void *user_data)
+static void gateway_setup_complete(struct audio_device *dev, GError *err, void *user_data)
 {
 	struct unix_client *client = user_data;
 	char buf[BT_SUGGESTED_BUFFER_SIZE];
 	struct bt_set_configuration_rsp *rsp = (void *) buf;
 
-	if (!dev) {
-		unix_ipc_error(client, BT_SET_CONFIGURATION, EIO);
+	if (err) {
+		unix_ipc_error(client, BT_SET_CONFIGURATION, err->code);
 		return;
 	}
 
@@ -388,13 +388,18 @@ failed:
 	unix_ipc_error(client, BT_START_STREAM, EIO);
 }
 
-static void gateway_resume_complete(struct audio_device *dev, void *user_data)
+static void gateway_resume_complete(struct audio_device *dev, GError *err, void *user_data)
 {
 	struct unix_client *client = user_data;
 	char buf[BT_SUGGESTED_BUFFER_SIZE];
 	struct bt_start_stream_rsp *rsp = (void *) buf;
 	struct bt_new_stream_ind *ind = (void *) buf;
 
+	if (err) {
+		unix_ipc_error(client, BT_START_STREAM, err->code);
+		return;
+	}
+
 	memset(buf, 0, sizeof(buf));
 	rsp->h.type = BT_RESPONSE;
 	rsp->h.name = BT_START_STREAM;
diff --git a/doc/hfp-api.txt b/doc/hfp-api.txt
new file mode 100644
index 0000000..8180de0
--- /dev/null
+++ b/doc/hfp-api.txt
@@ -0,0 +1,82 @@
+Gateway hierarchy
+========================
+
+Service		org.bluez
+Interface	org.bluez.HandsfreeGateway
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+This interface is available for remote devices which can function in the Audio
+Gateway role of the HFP profiles.  It is intended to be used with external
+telephony stacks / handlers of the HFP protocol.
+
+Methods		void Connect()
+
+			Connect to the AG service on the remote device.
+
+		void Disconnect()
+
+			Disconnect from the AG service on the remote device
+
+		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+		void RegisterAgent(object path)
+
+			The object path defines the path the of the agent
+			that will be called when a new Handsfree connection
+			is established.
+
+			If an application disconnects from the bus all of its
+			registered agents will be removed.
+
+		void UnregisterAgent(object path)
+
+			This unregisters the agent that has been previously
+			registered. The object path parameter must match the
+			same value that has been used on registration.
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	string State [readonly]
+
+			Indicates the state of the connection.  Possible
+			values are:
+				"disconnected"
+				"connecting"
+				"connected"
+				"playing"
+
+HandsfreeAgent hierarchy
+===============
+
+Service         unique name
+Interface       org.bluez.HandsfreeAgent
+Object path     freely definable
+
+Methods		void NewConnection(filedescriptor fd)
+
+			This method gets called whenever a new handsfree
+			connection has been established.  The objectpath
+			contains the object path of the remote device.  This
+			method assumes that DBus daemon with file descriptor
+			passing capability is being used.
+
+			The agent should only return successfully once the
+			establishment of the service level connection (SLC)
+			has been completed.  In the case of Handsfree this
+			means that BRSF exchange has been performed and
+			necessary initialization has been done.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void Release()
+
+			This method gets called whenever the service daemon
+			unregisters the agent or whenever the Adapter where
+			the HandsfreeAgent registers itself is removed.
-- 
1.6.4.4

