Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] Add AutoRetry option to audio.conf
Date: Mon, 22 Aug 2011 16:25:51 +0300
Message-Id: <1314019551-3471-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
References: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some devices may try to connect all the profiles but some may fail, in
that case even if AutoConnect is set the code won't reattempt to connect.

Note that this should also helps if connection request collide e.g. AVDTP
signalling channel it will retry as many time as defined in AutoRetry.
---
 audio/audio.conf |    5 +++++
 audio/device.c   |   29 +++++++++++++++++++++++++----
 audio/device.h   |    1 +
 audio/manager.c  |    9 +++++++++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index 302e046..1eb7352 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -21,6 +21,11 @@
 # idea.
 #AutoConnect=true
 
+# Automatically retry to connect if AutoConnect is enabled and one of the
+# profile has failed to connect.
+# Defaults to 1
+#AutoRetry=1
+
 # Headset interface specific options (i.e. options which affect how the audio
 # service interacts with remote headset devices)
 [Headset]
diff --git a/audio/device.c b/audio/device.c
index 1d76a3f..691ac6b 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -90,6 +90,7 @@ struct dev_priv {
 	guint avdtp_timer;
 	guint headset_timer;
 	guint dc_id;
+	guint retries;
 
 	gboolean disconnecting;
 	gboolean authorized;
@@ -248,6 +249,8 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 	} else if (new_state == AUDIO_STATE_CONNECTING)
 		priv->dc_id = device_add_disconnect_watch(dev->btd_dev,
 						disconnect_cb, dev, NULL);
+	else
+		dev->priv->retries = 0;
 
 	if (dev->priv->state == new_state) {
 		DBG("state change attempted from %s to %s",
@@ -404,6 +407,12 @@ static void device_sink_cb(struct audio_device *dev,
 		if (priv->hs_state == HEADSET_STATE_DISCONNECTED)
 			device_set_state(dev, AUDIO_STATE_DISCONNECTED);
 		else if (old_state == SINK_STATE_CONNECTING) {
+			if (dev->priv->retries != dev->auto_retry &&
+							dev->auto_connect) {
+				dev->priv->retries++;
+				device_set_avdtp_timer(dev);
+				break;
+			}
 			switch (priv->hs_state) {
 			case HEADSET_STATE_CONNECTED:
 			case HEADSET_STATE_PLAY_IN_PROGRESS:
@@ -483,10 +492,22 @@ static void device_headset_cb(struct audio_device *dev,
 		}
 		if (priv->sink_state == SINK_STATE_DISCONNECTED)
 			device_set_state(dev, AUDIO_STATE_DISCONNECTED);
-		else if (old_state == HEADSET_STATE_CONNECTING &&
-				(priv->sink_state == SINK_STATE_CONNECTED ||
-				priv->sink_state == SINK_STATE_PLAYING))
-			device_set_state(dev, AUDIO_STATE_CONNECTED);
+		else if (old_state == HEADSET_STATE_CONNECTING) {
+			if (dev->priv->retries != dev->auto_retry &&
+							dev->auto_connect) {
+				dev->priv->retries++;
+				device_set_headset_timer(dev);
+				break;
+			}
+			switch (priv->sink_state) {
+			case SINK_STATE_CONNECTED:
+			case SINK_STATE_RESUMING:
+			case SINK_STATE_PLAYING:
+				device_set_state(dev, AUDIO_STATE_CONNECTED);
+			default:
+				break;
+			}
+		}
 		break;
 	case HEADSET_STATE_CONNECTING:
 		device_remove_headset_timer(dev);
diff --git a/audio/device.h b/audio/device.h
index 5117fca..5671f77 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -55,6 +55,7 @@ struct audio_device {
 	bdaddr_t dst;
 
 	gboolean auto_connect;
+	guint auto_retry;
 
 	struct headset *headset;
 	struct gateway *gateway;
diff --git a/audio/manager.c b/audio/manager.c
index 33b4f5f..880872f 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -103,6 +103,7 @@ struct audio_adapter {
 };
 
 static gboolean auto_connect = TRUE;
+static guint auto_retry = 1;
 static int max_connected_headsets = 1;
 static DBusConnection *connection = NULL;
 static GKeyFile *config = NULL;
@@ -1208,6 +1209,13 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 	} else
 		auto_connect = b;
 
+	i = g_key_file_get_integer(config, "General", "AutoRetry", &err);
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else
+		auto_retry = i;
+
 	b = g_key_file_get_boolean(config, "Headset", "HFP",
 					&err);
 	if (err)
@@ -1374,6 +1382,7 @@ struct audio_device *manager_get_device(const bdaddr_t *src,
 	if (!dev)
 		return NULL;
 
+	dev->auto_retry = auto_retry;
 	devices = g_slist_append(devices, dev);
 
 	return dev;
-- 
1.7.6

