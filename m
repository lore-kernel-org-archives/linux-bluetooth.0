Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 2/8] Fix asynchronously run request stream cb
Date: Fri, 26 Aug 2011 17:39:32 +0200
Message-Id: <1314373178-11337-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++-------
 audio/gateway.h |    2 +-
 audio/unix.c    |    6 +---
 3 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 59c91dd..8cbaeb4 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -60,6 +60,12 @@ struct hf_agent {
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
@@ -67,6 +73,7 @@ struct gateway {
 	GIOChannel *incoming;
 	gateway_stream_cb_t sco_start_cb;
 	void *sco_start_cb_data;
+	GSList *callbacks;
 	struct hf_agent *agent;
 	DBusMessage *msg;
 	int version;
@@ -180,6 +187,41 @@ static gboolean agent_sendfd(struct hf_agent *agent, int fd,
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
@@ -209,6 +251,8 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	if (gw->sco_start_cb)
 		gw->sco_start_cb(dev, err, gw->sco_start_cb_data);
 
+	run_connect_cb(dev, err);
+
 	if (err) {
 		error("sco_connect_cb(): %s", err->message);
 		gateway_close(dev);
@@ -759,22 +803,27 @@ void gateway_start_service(struct audio_device *dev)
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
@@ -782,12 +831,13 @@ gboolean gateway_request_stream(struct audio_device *dev,
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
 
 int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t sco_cb,
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
index 1e0ab30..678d097 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -1118,10 +1118,8 @@ static void start_resume(struct audio_device *dev, struct unix_client *client)
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

