Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0] audio: Always request agent authorization
Date: Thu, 19 Jul 2012 08:57:44 +0200
Message-Id: <1342681064-16794-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Remove any internal policy that would skip the authorization procedure
from the agent. Always making the request is simpler and more convenient
for IVI use-cases.
---
 audio/avctp.c  |    8 ------
 audio/device.c |   70 +------------------------------------------------------
 audio/device.h |    2 -
 3 files changed, 2 insertions(+), 78 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index e3e5275..2b074bf 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -385,15 +385,7 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 	switch (new_state) {
 	case AVCTP_STATE_DISCONNECTED:
 		DBG("AVCTP Disconnected");
-
 		avctp_disconnected(session);
-
-		if (old_state != AVCTP_STATE_CONNECTED)
-			break;
-
-		if (!audio_device_is_active(dev, NULL))
-			audio_device_set_authorized(dev, FALSE);
-
 		break;
 	case AVCTP_STATE_CONNECTING:
 		DBG("AVCTP Connecting");
diff --git a/audio/device.c b/audio/device.c
index 9507eac..128519c 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -92,8 +92,6 @@ struct dev_priv {
 	guint dc_id;
 
 	gboolean disconnecting;
-	gboolean authorized;
-	guint auth_idle_id;
 };
 
 static unsigned int sink_callback_id = 0;
@@ -238,8 +236,6 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 		return;
 
 	if (new_state == AUDIO_STATE_DISCONNECTED) {
-		priv->authorized = FALSE;
-
 		if (priv->dc_id) {
 			device_remove_disconnect_watch(dev->btd_dev,
 							priv->dc_id);
@@ -740,9 +736,6 @@ static void auth_cb(DBusError *derr, void *user_data)
 	struct audio_device *dev = user_data;
 	struct dev_priv *priv = dev->priv;
 
-	if (derr == NULL)
-		priv->authorized = TRUE;
-
 	while (priv->auths) {
 		struct service_auth *auth = priv->auths->data;
 
@@ -752,48 +745,6 @@ static void auth_cb(DBusError *derr, void *user_data)
 	}
 }
 
-static gboolean auth_idle_cb(gpointer user_data)
-{
-	struct audio_device *dev = user_data;
-	struct dev_priv *priv = dev->priv;
-
-	priv->auth_idle_id = 0;
-
-	auth_cb(NULL, dev);
-
-	return FALSE;
-}
-
-static gboolean audio_device_is_connected(struct audio_device *dev)
-{
-	if (dev->headset) {
-		headset_state_t state = headset_get_state(dev);
-
-		if (state == HEADSET_STATE_CONNECTED ||
-				state == HEADSET_STATE_PLAY_IN_PROGRESS ||
-				state == HEADSET_STATE_PLAYING)
-			return TRUE;
-	}
-
-	if (dev->sink) {
-		sink_state_t state = sink_get_state(dev);
-
-		if (state == SINK_STATE_CONNECTED ||
-				state == SINK_STATE_PLAYING)
-			return TRUE;
-	}
-
-	if (dev->source) {
-		source_state_t state = source_get_state(dev);
-
-		if (state == SOURCE_STATE_CONNECTED ||
-				state == SOURCE_STATE_PLAYING)
-			return TRUE;
-	}
-
-	return FALSE;
-}
-
 int audio_device_request_authorization(struct audio_device *dev,
 					const char *uuid, service_auth_cb cb,
 					void *user_data)
@@ -813,11 +764,6 @@ int audio_device_request_authorization(struct audio_device *dev,
 	if (g_slist_length(priv->auths) > 1)
 		return 0;
 
-	if (priv->authorized || audio_device_is_connected(dev)) {
-		priv->auth_idle_id = g_idle_add(auth_idle_cb, dev);
-		return 0;
-	}
-
 	err = btd_request_authorization(&dev->src, &dev->dst, uuid, auth_cb,
 					dev);
 	if (err < 0) {
@@ -849,20 +795,8 @@ int audio_device_cancel_authorization(struct audio_device *dev,
 		g_free(auth);
 	}
 
-	if (g_slist_length(priv->auths) == 0) {
-		if (priv->auth_idle_id > 0) {
-			g_source_remove(priv->auth_idle_id);
-			priv->auth_idle_id = 0;
-		} else
-			btd_cancel_authorization(&dev->src, &dev->dst);
-	}
+	if (g_slist_length(priv->auths) == 0)
+		btd_cancel_authorization(&dev->src, &dev->dst);
 
 	return 0;
 }
-
-void audio_device_set_authorized(struct audio_device *dev, gboolean auth)
-{
-	struct dev_priv *priv = dev->priv;
-
-	priv->authorized = auth;
-}
diff --git a/audio/device.h b/audio/device.h
index 75f1da9..ca4f209 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -70,5 +70,3 @@ int audio_device_cancel_authorization(struct audio_device *dev,
 int audio_device_request_authorization(struct audio_device *dev,
 					const char *uuid, authorization_cb cb,
 					void *user_data);
-
-void audio_device_set_authorized(struct audio_device *dev, gboolean auth);
-- 
1.7.7.6

