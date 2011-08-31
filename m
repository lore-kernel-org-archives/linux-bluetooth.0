Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 2/4] Fix asynchronously run request stream cb
Date: Wed, 31 Aug 2011 17:48:50 +0200
Message-Id: <1314805732-30418-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314805732-30418-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314805732-30418-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Cancel pending callback if stream is canceled
Asynchronously run gateway_config_stream cb
Remove occurences of sco_start_cb
---
 audio/gateway.c |  138 +++++++++++++++++++++++++++++++++++++++---------------
 audio/gateway.h |    2 +-
 audio/unix.c    |   13 ++----
 3 files changed, 104 insertions(+), 49 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 59c91dd..ee33d79 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -60,13 +60,18 @@ struct hf_agent {
 	guint watch;	/* Disconnect watch */
 };
 
+struct connect_cb {
+	unsigned int id;
+	gateway_stream_cb_t cb;
+	void *cb_data;
+};
+
 struct gateway {
 	gateway_state_t state;
 	GIOChannel *rfcomm;
 	GIOChannel *sco;
 	GIOChannel *incoming;
-	gateway_stream_cb_t sco_start_cb;
-	void *sco_start_cb_data;
+	GSList *callbacks;
 	struct hf_agent *agent;
 	DBusMessage *msg;
 	int version;
@@ -180,6 +185,41 @@ static gboolean agent_sendfd(struct hf_agent *agent, int fd,
 	return TRUE;
 }
 
+static unsigned int connect_cb_new(struct gateway *gw,
+					gateway_stream_cb_t func,
+					void *user_data)
+{
+	struct connect_cb *cb;
+	static unsigned int free_cb_id = 1;
+
+	if (!func)
+		return 0;
+
+	cb = g_new(struct connect_cb, 1);
+
+	cb->cb = func;
+	cb->cb_data = user_data;
+	cb->id = free_cb_id++;
+
+	gw->callbacks = g_slist_append(gw->callbacks, cb);
+
+	return cb->id;
+}
+
+static void run_connect_cb(struct audio_device *dev, GError *err)
+{
+	struct gateway *gw = dev->gateway;
+	GSList *l;
+
+	for (l = gw->callbacks; l != NULL; l = l->next) {
+		struct connect_cb *cb = l->data;
+		cb->cb(dev, err, cb->cb_data);
+	}
+
+	g_slist_free_full(gw->callbacks, g_free);
+	gw->callbacks = NULL;
+}
+
 static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
 			struct audio_device *dev)
 {
@@ -206,9 +246,6 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	gw->sco = g_io_channel_ref(chan);
 
-	if (gw->sco_start_cb)
-		gw->sco_start_cb(dev, err, gw->sco_start_cb_data);
-
 	if (err) {
 		error("sco_connect_cb(): %s", err->message);
 		gateway_close(dev);
@@ -217,6 +254,8 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) sco_io_cb, dev);
+
+	run_connect_cb(dev, NULL);
 }
 
 static gboolean rfcomm_disconnect_cb(GIOChannel *chan, GIOCondition cond,
@@ -270,8 +309,6 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 
 	if (err) {
 		error("connect(): %s", err->message);
-		if (gw->sco_start_cb)
-			gw->sco_start_cb(dev, err, gw->sco_start_cb_data);
 		goto fail;
 	}
 
@@ -307,7 +344,7 @@ fail:
 		g_dbus_send_message(dev->conn, reply);
 	}
 
-	change_state(dev, GATEWAY_STATE_DISCONNECTED);
+	gateway_close(dev);
 }
 
 static int get_remote_profile_version(sdp_record_t *rec)
@@ -452,7 +489,6 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 				BT_IO_OPT_INVALID);
 	if (!io) {
 		error("Unable to connect: %s", gerr->message);
-		gateway_close(dev);
 		goto fail;
 	}
 
@@ -468,16 +504,10 @@ fail:
 		g_dbus_send_message(dev->conn, reply);
 	}
 
-	change_state(dev, GATEWAY_STATE_DISCONNECTED);
-
-	if (!gerr)
-		g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_FAILED,
-				"connect: %s (%d)", strerror(-err), -err);
-
-	if (gw->sco_start_cb)
-		gw->sco_start_cb(dev, gerr, gw->sco_start_cb_data);
+	gateway_close(dev);
 
-	g_error_free(gerr);
+	if (gerr)
+		g_error_free(gerr);
 }
 
 static int get_records(struct audio_device *device)
@@ -510,6 +540,7 @@ static DBusMessage *ag_connect(DBusConnection *conn, DBusMessage *msg,
 
 int gateway_close(struct audio_device *device)
 {
+	GError *gerr = NULL;
 	struct gateway *gw = device->gateway;
 	int sock;
 
@@ -526,11 +557,12 @@ int gateway_close(struct audio_device *device)
 		g_io_channel_shutdown(gw->sco, TRUE, NULL);
 		g_io_channel_unref(gw->sco);
 		gw->sco = NULL;
-		gw->sco_start_cb = NULL;
-		gw->sco_start_cb_data = NULL;
 	}
 
 	change_state(device, GATEWAY_STATE_DISCONNECTED);
+	g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_FAILED, "Closed");
+	run_connect_cb(device, gerr);
+	g_error_free(gerr);
 
 	return 0;
 }
@@ -759,22 +791,27 @@ void gateway_start_service(struct audio_device *dev)
 	}
 }
 
+static gboolean request_stream_cb(gpointer data)
+{
+	run_connect_cb(data, NULL);
+	return FALSE;
+}
+
 /* These are functions to be called from unix.c for audio system
  * ifaces (alsa, gstreamer, etc.) */
-gboolean gateway_request_stream(struct audio_device *dev,
+unsigned int gateway_request_stream(struct audio_device *dev,
 				gateway_stream_cb_t cb, void *user_data)
 {
 	struct gateway *gw = dev->gateway;
+	unsigned int id;
 	GError *err = NULL;
 	GIOChannel *io;
 
+	id = connect_cb_new(gw, cb, user_data);
+
 	if (!gw->rfcomm) {
-		gw->sco_start_cb = cb;
-		gw->sco_start_cb_data = user_data;
 		get_records(dev);
 	} else if (!gw->sco) {
-		gw->sco_start_cb = cb;
-		gw->sco_start_cb_data = user_data;
 		io = bt_io_connect(BT_IO_SCO, sco_connect_cb, dev, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 				BT_IO_OPT_DEST_BDADDR, &dev->dst,
@@ -782,34 +819,55 @@ gboolean gateway_request_stream(struct audio_device *dev,
 		if (!io) {
 			error("%s", err->message);
 			g_error_free(err);
-			return FALSE;
+			return 0;
 		}
-	} else if (cb)
-		cb(dev, err, user_data);
+	} else {
+		g_idle_add(request_stream_cb, dev);
+	}
 
-	return TRUE;
+	return id;
 }
 
-int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t sco_cb,
+int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t cb,
 				void *user_data)
 {
 	struct gateway *gw = dev->gateway;
+	unsigned int id;
+
+	id = connect_cb_new(gw, cb, user_data);
 
 	if (!gw->rfcomm) {
-		gw->sco_start_cb = sco_cb;
-		gw->sco_start_cb_data = user_data;
-		return get_records(dev);
+		get_records(dev);
+	} else if (cb) {
+		g_idle_add(request_stream_cb, dev);
 	}
 
-	if (sco_cb)
-		sco_cb(dev, NULL, user_data);
-
-	return 0;
+	return id;
 }
 
 gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id)
 {
+	struct gateway *gw = dev->gateway;
+	GSList *l;
+	struct connect_cb *cb = NULL;
+
+	for (l = gw->callbacks; l != NULL; l = l->next) {
+		struct connect_cb *tmp = l->data;
+
+		if (tmp->id == id) {
+			cb = tmp;
+			break;
+		}
+	}
+
+	if (!cb)
+		return FALSE;
+
+	gw->callbacks = g_slist_remove(gw->callbacks, cb);
+	g_free(cb);
+
 	gateway_suspend_stream(dev);
+
 	return TRUE;
 }
 
@@ -825,6 +883,7 @@ int gateway_get_sco_fd(struct audio_device *dev)
 
 void gateway_suspend_stream(struct audio_device *dev)
 {
+	GError *gerr = NULL;
 	struct gateway *gw = dev->gateway;
 
 	if (!gw || !gw->sco)
@@ -833,8 +892,9 @@ void gateway_suspend_stream(struct audio_device *dev)
 	g_io_channel_shutdown(gw->sco, TRUE, NULL);
 	g_io_channel_unref(gw->sco);
 	gw->sco = NULL;
-	gw->sco_start_cb = NULL;
-	gw->sco_start_cb_data = NULL;
+	g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_FAILED, "GW Suspended");
+	run_connect_cb(dev, gerr);
+	g_error_free(gerr);
 	change_state(dev, GATEWAY_STATE_CONNECTED);
 }
 
diff --git a/audio/gateway.h b/audio/gateway.h
index 2dca32a..7012fc5 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -52,7 +52,7 @@ gboolean gateway_is_connected(struct audio_device *dev);
 int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io);
 int gateway_connect_sco(struct audio_device *dev, GIOChannel *chan);
 void gateway_start_service(struct audio_device *device);
-gboolean gateway_request_stream(struct audio_device *dev,
+unsigned int gateway_request_stream(struct audio_device *dev,
 			gateway_stream_cb_t cb, void *user_data);
 int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t cb,
 			void *user_data);
diff --git a/audio/unix.c b/audio/unix.c
index 1e0ab30..c2d6d4a 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -1045,11 +1045,8 @@ static void start_config(struct audio_device *dev, struct unix_client *client)
 		client->cancel = headset_cancel_stream;
 		break;
 	case TYPE_GATEWAY:
-		if (gateway_config_stream(dev, gateway_setup_complete, client) >= 0) {
-			client->cancel = gateway_cancel_stream;
-			id = 1;
-		} else
-			id = 0;
+		id = gateway_config_stream(dev, gateway_setup_complete, client);
+		client->cancel = gateway_cancel_stream;
 		break;
 
 	default:
@@ -1118,10 +1115,8 @@ static void start_resume(struct audio_device *dev, struct unix_client *client)
 		break;
 
 	case TYPE_GATEWAY:
-		if (gateway_request_stream(dev, gateway_resume_complete, client))
-			id = 1;
-		else
-			id = 0;
+		id = gateway_request_stream(dev, gateway_resume_complete,
+						client);
 		client->cancel = gateway_cancel_stream;
 		break;
 
-- 
1.7.1

