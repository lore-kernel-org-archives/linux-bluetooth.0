Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 1/4] Fix headset disconnecting via device disconnect
Date: Wed, 22 Sep 2010 16:35:18 +0300
Message-Id: <1285162521-21997-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Headsets for proper disconnecting need to disconnect profiles in specified
order(by ex. disconnect a2dp, then sink and hfp at the end). Instead of
adding separate callbacks for disconnecting each profile, now adding only
one callback in audio/device.c for calling audio disconnect functions in
correct order.
Added disconnect_cb callback to audio/device.c
---
 audio/device.c |  119 ++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 82 insertions(+), 37 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index b30590e..8fe79d3 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -91,7 +91,9 @@ struct dev_priv {
 	guint control_timer;
 	guint avdtp_timer;
 	guint headset_timer;
+	guint dc_id;
 
+	gboolean disconnecting;
 	gboolean authorized;
 	guint auth_idle_id;
 };
@@ -123,6 +125,9 @@ static void device_free(struct audio_device *dev)
 			dbus_message_unref(priv->dc_req);
 		if (priv->conn_req)
 			dbus_message_unref(priv->conn_req);
+		if (priv->dc_id)
+			device_remove_disconnect_watch(dev->btd_dev,
+							priv->dc_id);
 		g_free(priv);
 	}
 
@@ -145,6 +150,70 @@ static const char *state2str(audio_state_t state)
 	}
 }
 
+static gboolean control_connect_timeout(gpointer user_data)
+{
+	struct audio_device *dev = user_data;
+
+	dev->priv->control_timer = 0;
+
+	if (dev->control)
+		avrcp_connect(dev);
+
+	return FALSE;
+}
+
+static gboolean device_set_control_timer(struct audio_device *dev)
+{
+	struct dev_priv *priv = dev->priv;
+
+	if (!dev->control)
+		return FALSE;
+
+	if (priv->control_timer)
+		return FALSE;
+
+	priv->control_timer = g_timeout_add_seconds(CONTROL_CONNECT_TIMEOUT,
+							control_connect_timeout,
+							dev);
+
+	return TRUE;
+}
+
+static void device_remove_control_timer(struct audio_device *dev)
+{
+	if (dev->priv->control_timer)
+		g_source_remove(dev->priv->control_timer);
+	dev->priv->control_timer = 0;
+}
+
+static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
+				void *user_data)
+{
+	struct audio_device *dev = user_data;
+	struct dev_priv *priv = dev->priv;
+
+	if (priv->state == AUDIO_STATE_DISCONNECTED)
+		return;
+
+	if (priv->disconnecting)
+		return;
+
+	priv->disconnecting = TRUE;
+
+	if (dev->control) {
+		device_remove_control_timer(dev);
+		avrcp_disconnect(dev);
+	}
+
+	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
+		sink_shutdown(dev->sink);
+
+	if (priv->hs_state != HEADSET_STATE_DISCONNECTED)
+		headset_shutdown(dev);
+
+	priv->disconnecting = FALSE;
+}
+
 static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 {
 	struct dev_priv *priv = dev->priv;
@@ -155,9 +224,21 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 	if (!state_str)
 		return;
 
-	if (new_state == AUDIO_STATE_DISCONNECTED)
+	if (new_state == AUDIO_STATE_DISCONNECTED) {
 		priv->authorized = FALSE;
 
+		if (priv->dc_id) {
+			device_remove_disconnect_watch(dev->btd_dev,
+							priv->dc_id);
+			priv->dc_id = 0;
+		}
+	}
+	else if (new_state == AUDIO_STATE_CONNECTED) {
+		priv->disconnecting = FALSE;
+		priv->dc_id = device_add_disconnect_watch(dev->btd_dev,
+						disconnect_cb, dev, NULL);
+	}
+
 	if (dev->priv->state == new_state) {
 		DBG("state change attempted from %s to %s",
 							state_str, state_str);
@@ -191,42 +272,6 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 				DBUS_TYPE_STRING, &state_str);
 }
 
-static gboolean control_connect_timeout(gpointer user_data)
-{
-	struct audio_device *dev = user_data;
-
-	dev->priv->control_timer = 0;
-
-	if (dev->control)
-		avrcp_connect(dev);
-
-	return FALSE;
-}
-
-static gboolean device_set_control_timer(struct audio_device *dev)
-{
-	struct dev_priv *priv = dev->priv;
-
-	if (!dev->control)
-		return FALSE;
-
-	if (priv->control_timer)
-		return FALSE;
-
-	priv->control_timer = g_timeout_add_seconds(CONTROL_CONNECT_TIMEOUT,
-							control_connect_timeout,
-							dev);
-
-	return TRUE;
-}
-
-static void device_remove_control_timer(struct audio_device *dev)
-{
-	if (dev->priv->control_timer)
-		g_source_remove(dev->priv->control_timer);
-	dev->priv->control_timer = 0;
-}
-
 static gboolean avdtp_connect_timeout(gpointer user_data)
 {
 	struct audio_device *dev = user_data;
-- 
1.7.0.4

