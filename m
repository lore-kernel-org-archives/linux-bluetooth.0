Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: forrest.zhao@gmail.com, Forrest Zhao <forrest.zhao@intel.com>
Subject: [PATCH] fix bugs in HFP HF role audio part
Date: Tue, 30 Jun 2009 15:16:21 +0800
Message-Id: <1246346181-25864-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |   20 ++++++++++++++------
 audio/unix.c    |   25 ++++++++++++++++++-------
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index a170bec..8725f8b 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -437,8 +437,11 @@ static gboolean rfcomm_ag_data_cb(GIOChannel *chan, GIOCondition cond,
 
 	gw = device->gateway;
 
-	if (cond & (G_IO_ERR | G_IO_HUP))
+	if (cond & (G_IO_ERR | G_IO_HUP)) {
+		debug("connection with remote BT is closed\n");
+		gateway_close(device);
 		return FALSE;
+	}
 
 	if (g_io_channel_read_chars(chan, buf, sizeof(buf) - 1, &read, NULL)
 			!= G_IO_STATUS_NORMAL)
@@ -492,8 +495,8 @@ static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
 		return FALSE;
 
 	if (cond & (G_IO_ERR | G_IO_HUP)) {
+		debug("sco connection is released\n");
 		GIOChannel *chan = gw->sco;
-		g_io_channel_unref(chan);
 		g_io_channel_close(chan);
 		gw->sco = NULL;
 		return FALSE;
@@ -514,6 +517,8 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		/* not sure, but from other point of view,
 		 * what is the reason to have headset which
 		 * cannot play audio? */
+		if (gw->sco_start_cb)
+			gw->sco_start_cb(NULL, gw->sco_start_cb_data);
 		gateway_close(dev);
 		return;
 	}
@@ -1084,6 +1089,8 @@ int gateway_connect_sco(struct audio_device *dev, GIOChannel *io)
 
 	gw->sco = g_io_channel_ref(io);
 
+	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+                                (GIOFunc) sco_io_cb, dev);
 	return 0;
 }
 
@@ -1108,13 +1115,11 @@ int gateway_close(struct audio_device *device)
 	g_slist_free(gw->indies);
 	if (rfcomm) {
 		g_io_channel_close(rfcomm);
-		g_io_channel_unref(rfcomm);
 		gw->rfcomm = NULL;
 	}
 
 	if (sco) {
 		g_io_channel_close(sco);
-		g_io_channel_unref(sco);
 		gw->sco = NULL;
 		gw->sco_start_cb = NULL;
 		gw->sco_start_cb_data = NULL;
@@ -1137,7 +1142,11 @@ gboolean gateway_request_stream(struct audio_device *dev,
 	GError *err = NULL;
 	GIOChannel *io;
 
-	if (!gw->sco) {
+	if (!gw->rfcomm) {
+		gw->sco_start_cb = cb;
+		gw->sco_start_cb_data = user_data;
+		get_records(dev);
+	} else if (!gw->sco) {
 		if (!gw->rfcomm)
 			return FALSE;
 		gw->sco_start_cb = cb;
@@ -1200,7 +1209,6 @@ void gateway_suspend_stream(struct audio_device *dev)
 		return;
 
 	g_io_channel_close(gw->sco);
-	g_io_channel_unref(gw->sco);
 	gw->sco = NULL;
 	gw->sco_start_cb = NULL;
 	gw->sco_start_cb_data = NULL;
diff --git a/audio/unix.c b/audio/unix.c
index bde9db4..dde7188 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -231,12 +231,18 @@ static uint8_t headset_generate_capability(struct audio_device *dev,
 
 	pcm = (void *) codec;
 	pcm->sampling_rate = 8000;
-	if (dev->headset && headset_get_nrec(dev))
+	if (dev->headset) {
+		if (headset_get_nrec(dev))
+			pcm->flags |= BT_PCM_FLAG_NREC;
+		if (!headset_get_sco_hci(dev))
+			pcm->flags |= BT_PCM_FLAG_PCM_ROUTING;
+		codec->configured = headset_is_active(dev);
+		codec->lock = headset_get_lock(dev);
+	} else {
 		pcm->flags |= BT_PCM_FLAG_NREC;
-	if (!headset_get_sco_hci(dev))
-		pcm->flags |= BT_PCM_FLAG_PCM_ROUTING;
-	codec->configured = headset_is_active(dev);
-	codec->lock = headset_get_lock(dev);
+		codec->configured = TRUE;
+		codec->lock = 0;
+	}
 
 	return codec->length;
 }
@@ -926,6 +932,8 @@ static void start_open(struct audio_device *dev, struct unix_client *client)
 		}
 		break;
 
+        case TYPE_GATEWAY:
+                break;
 	default:
 		error("No known services for device");
 		goto failed;
@@ -1175,6 +1183,8 @@ static void start_close(struct audio_device *dev, struct unix_client *client,
 			hs->locked = FALSE;
 		}
 		break;
+        case TYPE_GATEWAY:
+                break;
 	case TYPE_SOURCE:
 	case TYPE_SINK:
 		a2dp = &client->d.a2dp;
@@ -1275,7 +1285,8 @@ static int handle_sco_open(struct unix_client *client, struct bt_open_req *req)
 {
 	if (!client->interface)
 		client->interface = g_strdup(AUDIO_HEADSET_INTERFACE);
-	else if (!g_str_equal(client->interface, AUDIO_HEADSET_INTERFACE))
+	else if (!g_str_equal(client->interface, AUDIO_HEADSET_INTERFACE) &&
+		!g_str_equal(client->interface, AUDIO_GATEWAY_INTERFACE))
 		return -EIO;
 
 	debug("open sco - object=%s source=%s destination=%s lock=%s%s",
@@ -1354,7 +1365,7 @@ static void handle_open_req(struct unix_client *client, struct bt_open_req *req)
 	return;
 
 failed:
-	unix_ipc_error(client, BT_SET_CONFIGURATION, err ? : EIO);
+	unix_ipc_error(client, BT_OPEN, err ? : EIO);
 }
 
 static int handle_sco_transport(struct unix_client *client,
-- 
1.5.4.5

