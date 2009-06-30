Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: forrest.zhao@gmail.com, Forrest Zhao <forrest.zhao@intel.com>
Subject: [PATCH] misc fixes for HFP HF role
Date: Tue, 30 Jun 2009 17:10:52 +0800
Message-Id: <1246353052-26175-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |   34 +++++++++++++++++++++-------------
 audio/manager.c |    2 +-
 audio/unix.c    |   25 ++++++++++++++++++-------
 3 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index a170bec..ed01c65 100644
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
@@ -492,9 +495,10 @@ static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
 		return FALSE;
 
 	if (cond & (G_IO_ERR | G_IO_HUP)) {
+		debug("sco connection is released\n");
 		GIOChannel *chan = gw->sco;
+		g_io_channel_shutdown(chan, TRUE, NULL);
 		g_io_channel_unref(chan);
-		g_io_channel_close(chan);
 		gw->sco = NULL;
 		return FALSE;
 	}
@@ -514,12 +518,13 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		/* not sure, but from other point of view,
 		 * what is the reason to have headset which
 		 * cannot play audio? */
+		if (gw->sco_start_cb)
+			gw->sco_start_cb(NULL, gw->sco_start_cb_data);
 		gateway_close(dev);
 		return;
 	}
 
-	gw->sco = chan;
-	g_io_channel_ref(chan);
+	gw->sco = g_io_channel_ref(chan);
 	if (gw->sco_start_cb)
 		gw->sco_start_cb(dev, gw->sco_start_cb_data);
 
@@ -554,9 +559,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 	g_io_channel_set_encoding(chan, NULL, NULL);
 	g_io_channel_set_buffered(chan, FALSE);
 	if (!gw->rfcomm)
-		g_io_channel_ref(chan);
-
-	gw->rfcomm = chan;
+		gw->rfcomm = g_io_channel_ref(chan);
 
 	if (establish_service_level_conn(dev->gateway)) {
 		gboolean value = TRUE;
@@ -639,6 +642,7 @@ static void get_record_cb(sdp_list_t *recs, int perr, gpointer user_data)
 					g_error_free(err);
 					gateway_close(dev);
 				}
+				g_io_channel_unref(io);
 				sdp_list_free(classes, free);
 				return;
 			}
@@ -1084,6 +1088,8 @@ int gateway_connect_sco(struct audio_device *dev, GIOChannel *io)
 
 	gw->sco = g_io_channel_ref(io);
 
+	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+                                (GIOFunc) sco_io_cb, dev);
 	return 0;
 }
 
@@ -1107,13 +1113,13 @@ int gateway_close(struct audio_device *device)
 	g_slist_foreach(gw->indies, (GFunc) indicator_slice_free, NULL);
 	g_slist_free(gw->indies);
 	if (rfcomm) {
-		g_io_channel_close(rfcomm);
+		g_io_channel_shutdown(rfcomm, TRUE, NULL);
 		g_io_channel_unref(rfcomm);
 		gw->rfcomm = NULL;
 	}
 
 	if (sco) {
-		g_io_channel_close(sco);
+		g_io_channel_shutdown(sco, TRUE, NULL);
 		g_io_channel_unref(sco);
 		gw->sco = NULL;
 		gw->sco_start_cb = NULL;
@@ -1137,9 +1143,11 @@ gboolean gateway_request_stream(struct audio_device *dev,
 	GError *err = NULL;
 	GIOChannel *io;
 
-	if (!gw->sco) {
-		if (!gw->rfcomm)
-			return FALSE;
+	if (!gw->rfcomm) {
+		gw->sco_start_cb = cb;
+		gw->sco_start_cb_data = user_data;
+		get_records(dev);
+	} else if (!gw->sco) {
 		gw->sco_start_cb = cb;
 		gw->sco_start_cb_data = user_data;
 		io = bt_io_connect(BT_IO_SCO, sco_connect_cb, dev, NULL, &err,
@@ -1199,7 +1207,7 @@ void gateway_suspend_stream(struct audio_device *dev)
 	if (!gw || !gw->sco)
 		return;
 
-	g_io_channel_close(gw->sco);
+	g_io_channel_shutdown(gw->sco, TRUE, NULL);
 	g_io_channel_unref(gw->sco);
 	gw->sco = NULL;
 	gw->sco_start_cb = NULL;
diff --git a/audio/manager.c b/audio/manager.c
index dc0f6a9..4999e21 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -571,7 +571,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 	return;
 
 drop:
-	g_io_channel_close(chan);
+	g_io_channel_shutdown(chan);
 	g_io_channel_unref(chan);
 	return;
 }
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

