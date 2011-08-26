Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 6/8] Use int instead of GError into callbacks
Date: Fri, 26 Aug 2011 17:39:36 +0200
Message-Id: <1314373178-11337-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c   |   20 ++++++++++----------
 audio/gateway.h   |    4 ++--
 audio/transport.c |    4 ++--
 audio/unix.c      |    8 ++++----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 353473b..93ff4b9 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -208,7 +208,7 @@ static unsigned int connect_cb_new(struct gateway *gw,
 	return cb->id;
 }
 
-static void run_connect_cb(struct audio_device *dev, GError *err)
+static void run_connect_cb(struct audio_device *dev, int err)
 {
 	struct gateway *gw = dev->gateway;
 	GSList *l;
@@ -248,11 +248,6 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	gw->sco = g_io_channel_ref(chan);
 
-	if (gw->sco_start_cb)
-		gw->sco_start_cb(dev, err, gw->sco_start_cb_data);
-
-	run_connect_cb(dev, err);
-
 	if (err) {
 		error("sco_connect_cb(): %s", err->message);
 		gateway_close(dev);
@@ -263,6 +258,11 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 				(GIOFunc) sco_io_cb, dev);
 
 	change_state(dev, GATEWAY_STATE_PLAYING);
+
+	if (gw->sco_start_cb)
+		gw->sco_start_cb(dev, 0, gw->sco_start_cb_data);
+
+	run_connect_cb(dev, 0);
 }
 
 static gboolean rfcomm_disconnect_cb(GIOChannel *chan, GIOCondition cond,
@@ -317,7 +317,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 	if (err) {
 		error("connect(): %s", err->message);
 		if (gw->sco_start_cb)
-			gw->sco_start_cb(dev, err, gw->sco_start_cb_data);
+			gw->sco_start_cb(dev, err->code, gw->sco_start_cb_data);
 		goto fail;
 	}
 
@@ -519,7 +519,7 @@ fail:
 				"connect: %s (%d)", strerror(-err), -err);
 
 	if (gw->sco_start_cb)
-		gw->sco_start_cb(dev, gerr, gw->sco_start_cb_data);
+		gw->sco_start_cb(dev, -err, gw->sco_start_cb_data);
 
 	g_error_free(gerr);
 }
@@ -806,7 +806,7 @@ void gateway_start_service(struct audio_device *dev)
 
 static gboolean request_stream_cb(gpointer data)
 {
-	run_connect_cb(data, NULL);
+	run_connect_cb(data, 0);
 	return FALSE;
 }
 
@@ -853,7 +853,7 @@ int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t sco_cb,
 	}
 
 	if (sco_cb)
-		sco_cb(dev, NULL, user_data);
+		sco_cb(dev, 0, user_data);
 
 	return 0;
 }
diff --git a/audio/gateway.h b/audio/gateway.h
index 7012fc5..20f90bd 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -42,8 +42,8 @@ typedef void (*gateway_state_cb) (struct audio_device *dev,
 					gateway_state_t old_state,
 					gateway_state_t new_state,
 					void *user_data);
-typedef void (*gateway_stream_cb_t) (struct audio_device *dev, GError *err,
-		void *user_data);
+typedef void (*gateway_stream_cb_t) (struct audio_device *dev, int err,
+					void *user_data);
 
 void gateway_set_state(struct audio_device *dev, gateway_state_t new_state);
 void gateway_unregister(struct audio_device *dev);
diff --git a/audio/transport.c b/audio/transport.c
index 2739199..54dabb6 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -437,7 +437,7 @@ static void cancel_headset(struct media_transport *transport, guint id)
 	headset_cancel_stream(transport->device, id);
 }
 
-static void gateway_resume_complete(struct audio_device *dev, GError *err,
+static void gateway_resume_complete(struct audio_device *dev, int err,
 							void *user_data)
 {
 	struct media_owner *owner = user_data;
@@ -453,7 +453,7 @@ static void gateway_resume_complete(struct audio_device *dev, GError *err,
 		goto fail;
 
 	if (err) {
-		error("Failed to resume gateway: error %s", err->message);
+		error("Failed to resume gateway: error %s", strerror(-err));
 		goto fail;
 	}
 
diff --git a/audio/unix.c b/audio/unix.c
index 678d097..111fc57 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -339,14 +339,14 @@ failed:
 	unix_ipc_error(client, BT_SET_CONFIGURATION, EIO);
 }
 
-static void gateway_setup_complete(struct audio_device *dev, GError *err, void *user_data)
+static void gateway_setup_complete(struct audio_device *dev, int err, void *user_data)
 {
 	struct unix_client *client = user_data;
 	char buf[BT_SUGGESTED_BUFFER_SIZE];
 	struct bt_set_configuration_rsp *rsp = (void *) buf;
 
 	if (err) {
-		unix_ipc_error(client, BT_SET_CONFIGURATION, err->code);
+		unix_ipc_error(client, BT_SET_CONFIGURATION, -err);
 		return;
 	}
 
@@ -409,7 +409,7 @@ failed:
 	unix_ipc_error(client, BT_START_STREAM, EIO);
 }
 
-static void gateway_resume_complete(struct audio_device *dev, GError *err, void *user_data)
+static void gateway_resume_complete(struct audio_device *dev, int err, void *user_data)
 {
 	struct unix_client *client = user_data;
 	char buf[BT_SUGGESTED_BUFFER_SIZE];
@@ -417,7 +417,7 @@ static void gateway_resume_complete(struct audio_device *dev, GError *err, void
 	struct bt_new_stream_ind *ind = (void *) buf;
 
 	if (err) {
-		unix_ipc_error(client, BT_START_STREAM, err->code);
+		unix_ipc_error(client, BT_START_STREAM, -err);
 		return;
 	}
 
-- 
1.7.1

