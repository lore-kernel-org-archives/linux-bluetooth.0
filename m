Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v4 5/5] audio: Drop audio-specific authorization mechanism
Date: Fri, 28 Sep 2012 18:32:25 +0200
Message-Id: <1348849945-5762-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1348849945-5762-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1348849945-5762-1-git-send-email-mikel.astiz.oss@gmail.com>
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
 audio/avctp.c   |  27 ++++------
 audio/avdtp.c   |  23 ++++++---
 audio/device.c  | 149 --------------------------------------------------------
 audio/device.h  |  12 +----
 audio/manager.c |  28 ++++++-----
 5 files changed, 43 insertions(+), 196 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 6fd5491..b7b3083 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -143,6 +143,7 @@ struct avctp {
 	GIOChannel *browsing_io;
 	guint control_io_id;
 	guint browsing_io_id;
+	guint auth_id;
 
 	uint16_t control_mtu;
 	uint16_t browsing_mtu;
@@ -360,13 +361,9 @@ static void avctp_disconnected(struct avctp *session)
 		g_source_remove(session->control_io_id);
 		session->control_io_id = 0;
 
-		if (session->state == AVCTP_STATE_CONNECTING) {
-			struct audio_device *dev;
-
-			dev = manager_get_device(&session->server->src,
-							&session->dst, FALSE);
-			audio_device_cancel_authorization(dev, auth_cb,
-								session);
+		if (session->auth_id != 0) {
+			btd_cancel_authorization(session->auth_id);
+			session->auth_id = 0;
 		}
 	}
 
@@ -409,15 +406,7 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
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
@@ -769,6 +758,8 @@ static void auth_cb(DBusError *derr, void *user_data)
 	struct avctp *session = user_data;
 	GError *err = NULL;
 
+	session->auth_id = 0;
+
 	if (session->control_io_id) {
 		g_source_remove(session->control_io_id);
 		session->control_io_id = 0;
@@ -854,8 +845,10 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	avctp_set_state(session, AVCTP_STATE_CONNECTING);
 	session->control_io = g_io_channel_ref(chan);
 
-	if (audio_device_request_authorization(dev, AVRCP_TARGET_UUID,
-						auth_cb, session) < 0)
+	session->auth_id = btd_request_authorization(&dev->src, &dev->dst,
+							AVRCP_TARGET_UUID,
+							auth_cb, session);
+	if (session->auth_id == 0)
 		goto drop;
 
 	session->control_io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP |
diff --git a/audio/avdtp.c b/audio/avdtp.c
index d44c504..8836ca1 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -400,6 +400,8 @@ struct avdtp {
 	/* True if the entire device is being disconnected */
 	gboolean device_disconnect;
 
+	guint auth_id;
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
+	if (session->auth_id == 0)
+		return 0;
 
-	return audio_device_cancel_authorization(dev, auth_cb, session);
+	err = btd_cancel_authorization(session->auth_id);
+	if (err < 0)
+		return err;
+
+	session->auth_id = 0;
+
+	return 0;
 }
 
 static void connection_lost(struct avdtp *session, int err)
@@ -2507,7 +2514,6 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	struct audio_device *dev;
 	char address[18];
 	bdaddr_t src, dst;
-	int perr;
 	GError *err = NULL;
 
 	bt_io_get(chan, &err,
@@ -2566,9 +2572,10 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	session->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					(GIOFunc) session_cb, session);
 
-	perr = audio_device_request_authorization(dev, ADVANCED_AUDIO_UUID,
+	session->auth_id = btd_request_authorization(&dev->src, &dev->dst,
+							ADVANCED_AUDIO_UUID,
 							auth_cb, session);
-	if (perr < 0) {
+	if (session->auth_id == 0) {
 		avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
 		avdtp_unref(session);
 		goto drop;
diff --git a/audio/device.c b/audio/device.c
index c6ae96a..175e3c0 100644
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
-	guint auth_id;
 
 	DBusMessage *conn_req;
 	DBusMessage *dc_req;
@@ -94,8 +87,6 @@ struct dev_priv {
 	guint dc_id;
 
 	gboolean disconnecting;
-	gboolean authorized;
-	guint auth_idle_id;
 };
 
 static unsigned int sink_callback_id = 0;
@@ -110,8 +101,6 @@ static void device_free(struct audio_device *dev)
 	btd_device_unref(dev->btd_dev);
 
 	if (priv) {
-		if (priv->auths)
-			audio_device_cancel_authorization(dev, NULL, NULL);
 		if (priv->control_timer)
 			g_source_remove(priv->control_timer);
 		if (priv->avdtp_timer)
@@ -238,8 +227,6 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 		return;
 
 	if (new_state == AUDIO_STATE_DISCONNECTED) {
-		priv->authorized = FALSE;
-
 		if (priv->dc_id) {
 			device_remove_disconnect_watch(dev->btd_dev,
 							priv->dc_id);
@@ -732,139 +719,3 @@ void audio_device_unregister(struct audio_device *device)
 
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
-	priv->auth_id = btd_request_authorization(&dev->src, &dev->dst, uuid,
-								auth_cb, dev);
-	if (priv->auth_id != 0)
-		return 0;
-
-	priv->auths = g_slist_remove(priv->auths, auth);
-	g_free(auth);
-
-	return -EPERM;
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
index f9b868f..2b92528 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -47,6 +47,7 @@ struct audio_device {
 	struct target *target;
 
 	guint hs_preauth_id;
+	guint hs_auth_id;
 
 	struct dev_priv *priv;
 };
@@ -59,14 +60,3 @@ void audio_device_unregister(struct audio_device *device);
 
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
index 70be01b..dbc98d5 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -300,6 +300,8 @@ static void headset_auth_cb(DBusError *derr, void *user_data)
 	GError *err = NULL;
 	GIOChannel *io;
 
+	device->hs_auth_id = 0;
+
 	if (device->hs_preauth_id) {
 		g_source_remove(device->hs_preauth_id);
 		device->hs_preauth_id = 0;
@@ -328,7 +330,8 @@ static gboolean hs_preauth_cb(GIOChannel *chan, GIOCondition cond,
 
 	DBG("Headset disconnected during authorization");
 
-	audio_device_cancel_authorization(device, headset_auth_cb, device);
+	btd_cancel_authorization(device->hs_auth_id);
+	device->hs_auth_id = 0;
 
 	headset_set_state(device, HEADSET_STATE_DISCONNECTED);
 
@@ -343,7 +346,6 @@ static void ag_confirm(GIOChannel *chan, gpointer data)
 	struct audio_device *device;
 	gboolean hfp_active;
 	bdaddr_t src, dst;
-	int perr;
 	GError *err = NULL;
 	uint8_t ch;
 
@@ -398,10 +400,13 @@ static void ag_confirm(GIOChannel *chan, gpointer data)
 
 	headset_set_state(device, HEADSET_STATE_CONNECTING);
 
-	perr = audio_device_request_authorization(device, server_uuid,
-						headset_auth_cb, device);
-	if (perr < 0) {
-		DBG("Authorization denied: %s", strerror(-perr));
+	device->hs_auth_id = btd_request_authorization(&device->src,
+							&device->dst,
+							server_uuid,
+							headset_auth_cb,
+							device);
+	if (device->hs_auth_id == 0) {
+		DBG("Authorization denied");
 		headset_set_state(device, HEADSET_STATE_DISCONNECTED);
 		return;
 	}
@@ -443,7 +448,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 	uint8_t ch;
 	const char *server_uuid, *remote_uuid;
 	struct audio_device *device;
-	int perr;
+	guint auth_id;
 
 	bt_io_get(chan, &err,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
@@ -480,10 +485,11 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 		goto drop;
 	}
 
-	perr = audio_device_request_authorization(device, server_uuid,
-						gateway_auth_cb, device);
-	if (perr < 0) {
-		DBG("Authorization denied: %s", strerror(-perr));
+	auth_id = btd_request_authorization(&device->src, &device->dst,
+						server_uuid, gateway_auth_cb,
+						device);
+	if (auth_id == 0) {
+		DBG("Authorization denied");
 		gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
 	}
 
-- 
1.7.11.4

