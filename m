Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 4/4] audio: Drop audio-specific authorization mechanism
Date: Tue, 11 Sep 2012 15:55:30 +0200
Message-Id: <1347371730-14933-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347371730-14933-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347371730-14933-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Remove the audio-specific service authorization mechanism in favor of
using the conventional one.

The main difference is that audio profiles will be authorized
independently. Therefore a single connection might result in several
profile authorization requests to the agent (i.e. HFP, A2DP and AVRCP).

This removes any internal policy that would skip the authorization
procedure, making it simpler and more convenient for IVI use-cases.

Agents interested in simulating the old behavior are encouraged to
either set the device as trusted or just reply to the additional
authorization requests automatically without user intervention.
---
 audio/avctp.c   |   29 ++++------
 audio/avdtp.c   |   25 ++++++---
 audio/device.c  |  150 -------------------------------------------------------
 audio/device.h  |   12 +----
 audio/manager.c |   18 ++++---
 5 files changed, 40 insertions(+), 194 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 4e0e8dc..40e85ed 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -139,6 +139,7 @@ struct avctp {
 
 	GIOChannel *io;
 	guint io_id;
+	int service_auth_id;
 
 	uint16_t mtu;
 
@@ -337,13 +338,9 @@ static void avctp_disconnected(struct avctp *session)
 		g_source_remove(session->io_id);
 		session->io_id = 0;
 
-		if (session->state == AVCTP_STATE_CONNECTING) {
-			struct audio_device *dev;
-
-			dev = manager_get_device(&session->server->src,
-							&session->dst, FALSE);
-			audio_device_cancel_authorization(dev, auth_cb,
-								session);
+		if (session->service_auth_id > 0) {
+			btd_cancel_authorization(session->service_auth_id);
+			session->service_auth_id = 0;
 		}
 	}
 
@@ -386,15 +383,7 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
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
@@ -657,6 +646,8 @@ static void auth_cb(DBusError *derr, void *user_data)
 	struct avctp *session = user_data;
 	GError *err = NULL;
 
+	session->service_auth_id = 0;
+
 	if (session->io_id) {
 		g_source_remove(session->io_id);
 		session->io_id = 0;
@@ -736,6 +727,7 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	struct audio_device *dev;
 	char address[18];
 	bdaddr_t src, dst;
+	int auth_id;
 	GError *err = NULL;
 
 	bt_io_get(chan, &err,
@@ -780,12 +772,15 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	avctp_set_state(session, AVCTP_STATE_CONNECTING);
 	session->io = g_io_channel_ref(chan);
 
-	if (audio_device_request_authorization(dev, AVRCP_TARGET_UUID,
-						auth_cb, session) < 0)
+	auth_id = btd_request_authorization(&dev->src, &dev->dst,
+							AVRCP_TARGET_UUID,
+							auth_cb, session);
+	if (auth_id < 0)
 		goto drop;
 
 	session->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 							session_cb, session);
+	session->service_auth_id = auth_id;
 	return;
 
 drop:
diff --git a/audio/avdtp.c b/audio/avdtp.c
index d44c504..3137094 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -400,6 +400,8 @@ struct avdtp {
 	/* True if the entire device is being disconnected */
 	gboolean device_disconnect;
 
+	int service_auth_id;
+
 	GIOChannel *io;
 	guint io_id;
 
@@ -1129,16 +1131,21 @@ static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
 
 static int avdtp_cancel_authorization(struct avdtp *session)
 {
-	struct audio_device *dev;
+	int err;
 
 	if (session->state != AVDTP_SESSION_STATE_CONNECTING)
 		return 0;
 
-	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
-	if (dev == NULL)
-		return -ENODEV;
+	if (!session->service_auth_id)
+		return 0;
 
-	return audio_device_cancel_authorization(dev, auth_cb, session);
+	err = btd_cancel_authorization(session->service_auth_id);
+	if (err < 0)
+		return err;
+
+	session->service_auth_id = 0;
+
+	return 0;
 }
 
 static void connection_lost(struct avdtp *session, int err)
@@ -2507,7 +2514,7 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	struct audio_device *dev;
 	char address[18];
 	bdaddr_t src, dst;
-	int perr;
+	int auth_id;
 	GError *err = NULL;
 
 	bt_io_get(chan, &err,
@@ -2566,15 +2573,17 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	session->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					(GIOFunc) session_cb, session);
 
-	perr = audio_device_request_authorization(dev, ADVANCED_AUDIO_UUID,
+	auth_id = btd_request_authorization(&dev->src, &dev->dst,
+							ADVANCED_AUDIO_UUID,
 							auth_cb, session);
-	if (perr < 0) {
+	if (auth_id < 0) {
 		avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
 		avdtp_unref(session);
 		goto drop;
 	}
 
 	dev->auto_connect = auto_connect;
+	session->service_auth_id = auth_id;
 
 	return;
 
diff --git a/audio/device.c b/audio/device.c
index ca64f14..072b0ce 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -71,19 +71,12 @@ typedef enum {
 	AUDIO_STATE_CONNECTED,
 } audio_state_t;
 
-struct service_auth {
-	service_auth_cb cb;
-	void *user_data;
-};
-
 struct dev_priv {
 	audio_state_t state;
 
 	headset_state_t hs_state;
 	sink_state_t sink_state;
 	avctp_state_t avctp_state;
-	GSList *auths;
-	int auth_id;
 
 	DBusMessage *conn_req;
 	DBusMessage *dc_req;
@@ -94,8 +87,6 @@ struct dev_priv {
 	guint dc_id;
 
 	gboolean disconnecting;
-	gboolean authorized;
-	guint auth_idle_id;
 };
 
 static unsigned int sink_callback_id = 0;
@@ -113,8 +104,6 @@ static void device_free(struct audio_device *dev)
 	btd_device_unref(dev->btd_dev);
 
 	if (priv) {
-		if (priv->auths)
-			audio_device_cancel_authorization(dev, NULL, NULL);
 		if (priv->control_timer)
 			g_source_remove(priv->control_timer);
 		if (priv->avdtp_timer)
@@ -240,8 +229,6 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 		return;
 
 	if (new_state == AUDIO_STATE_DISCONNECTED) {
-		priv->authorized = FALSE;
-
 		if (priv->dc_id) {
 			device_remove_disconnect_watch(dev->btd_dev,
 							priv->dc_id);
@@ -736,140 +723,3 @@ void audio_device_unregister(struct audio_device *device)
 
 	device_free(device);
 }
-
-static void auth_cb(DBusError *derr, void *user_data)
-{
-	struct audio_device *dev = user_data;
-	struct dev_priv *priv = dev->priv;
-
-	priv->auth_id = 0;
-
-	if (derr == NULL)
-		priv->authorized = TRUE;
-
-	while (priv->auths) {
-		struct service_auth *auth = priv->auths->data;
-
-		auth->cb(derr, auth->user_data);
-		priv->auths = g_slist_remove(priv->auths, auth);
-		g_free(auth);
-	}
-}
-
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
-int audio_device_request_authorization(struct audio_device *dev,
-					const char *uuid, service_auth_cb cb,
-					void *user_data)
-{
-	struct dev_priv *priv = dev->priv;
-	struct service_auth *auth;
-	int err;
-
-	auth = g_try_new0(struct service_auth, 1);
-	if (!auth)
-		return -ENOMEM;
-
-	auth->cb = cb;
-	auth->user_data = user_data;
-
-	priv->auths = g_slist_append(priv->auths, auth);
-	if (g_slist_length(priv->auths) > 1)
-		return 0;
-
-	if (priv->authorized || audio_device_is_connected(dev)) {
-		priv->auth_idle_id = g_idle_add(auth_idle_cb, dev);
-		return 0;
-	}
-
-	err = btd_request_authorization(&dev->src, &dev->dst, uuid, auth_cb,
-					dev);
-	if (err < 0) {
-		priv->auths = g_slist_remove(priv->auths, auth);
-		g_free(auth);
-	} else
-		priv->auth_id = err;
-
-	return err;
-}
-
-int audio_device_cancel_authorization(struct audio_device *dev,
-					authorization_cb cb, void *user_data)
-{
-	struct dev_priv *priv = dev->priv;
-	GSList *l, *next;
-
-	for (l = priv->auths; l != NULL; l = next) {
-		struct service_auth *auth = l->data;
-
-		next = g_slist_next(l);
-
-		if (cb && auth->cb != cb)
-			continue;
-
-		if (user_data && auth->user_data != user_data)
-			continue;
-
-		priv->auths = g_slist_remove(priv->auths, auth);
-		g_free(auth);
-	}
-
-	if (g_slist_length(priv->auths) == 0) {
-		if (priv->auth_idle_id > 0) {
-			g_source_remove(priv->auth_idle_id);
-			priv->auth_idle_id = 0;
-		} else {
-			btd_cancel_authorization(priv->auth_id);
-			priv->auth_id = 0;
-		}
-	}
-
-	return 0;
-}
-
-void audio_device_set_authorized(struct audio_device *dev, gboolean auth)
-{
-	struct dev_priv *priv = dev->priv;
-
-	priv->authorized = auth;
-}
diff --git a/audio/device.h b/audio/device.h
index 75f1da9..49c6829 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -48,6 +48,7 @@ struct audio_device {
 	struct target *target;
 
 	guint hs_preauth_id;
+	int hs_service_auth_id;
 
 	struct dev_priv *priv;
 };
@@ -61,14 +62,3 @@ void audio_device_unregister(struct audio_device *device);
 
 gboolean audio_device_is_active(struct audio_device *dev,
 						const char *interface);
-
-typedef void (*authorization_cb) (DBusError *derr, void *user_data);
-
-int audio_device_cancel_authorization(struct audio_device *dev,
-					authorization_cb cb, void *user_data);
-
-int audio_device_request_authorization(struct audio_device *dev,
-					const char *uuid, authorization_cb cb,
-					void *user_data);
-
-void audio_device_set_authorized(struct audio_device *dev, gboolean auth);
diff --git a/audio/manager.c b/audio/manager.c
index 5c81957..0222d67 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -328,7 +328,7 @@ static gboolean hs_preauth_cb(GIOChannel *chan, GIOCondition cond,
 
 	DBG("Headset disconnected during authorization");
 
-	audio_device_cancel_authorization(device, headset_auth_cb, device);
+	btd_cancel_authorization(device->hs_service_auth_id);
 
 	headset_set_state(device, HEADSET_STATE_DISCONNECTED);
 
@@ -343,7 +343,7 @@ static void ag_confirm(GIOChannel *chan, gpointer data)
 	struct audio_device *device;
 	gboolean hfp_active;
 	bdaddr_t src, dst;
-	int perr;
+	int auth_id;
 	GError *err = NULL;
 	uint8_t ch;
 
@@ -398,10 +398,11 @@ static void ag_confirm(GIOChannel *chan, gpointer data)
 
 	headset_set_state(device, HEADSET_STATE_CONNECTING);
 
-	perr = audio_device_request_authorization(device, server_uuid,
-						headset_auth_cb, device);
-	if (perr < 0) {
-		DBG("Authorization denied: %s", strerror(-perr));
+	auth_id = btd_request_authorization(&device->src, &device->dst,
+						server_uuid, headset_auth_cb,
+						device);
+	if (auth_id < 0) {
+		DBG("Authorization denied: %s", strerror(-auth_id));
 		headset_set_state(device, HEADSET_STATE_DISCONNECTED);
 		return;
 	}
@@ -480,8 +481,9 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 		goto drop;
 	}
 
-	perr = audio_device_request_authorization(device, server_uuid,
-						gateway_auth_cb, device);
+	perr = btd_request_authorization(&device->src, &device->dst,
+						server_uuid, gateway_auth_cb,
+						device);
 	if (perr < 0) {
 		DBG("Authorization denied: %s", strerror(-perr));
 		gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
-- 
1.7.7.6

