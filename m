Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 6/7] Add state change callback to audio interface
Date: Fri, 12 Aug 2011 17:27:56 +0200
Message-Id: <1313162877-14945-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/device.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index f61ef0f..abf8da4 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -78,6 +78,7 @@ struct dev_priv {
 	audio_state_t state;
 
 	headset_state_t hs_state;
+	gateway_state_t ag_state;
 	sink_state_t sink_state;
 	avctp_state_t avctp_state;
 	GSList *auths;
@@ -99,6 +100,7 @@ static unsigned int sink_callback_id = 0;
 static unsigned int avctp_callback_id = 0;
 static unsigned int avdtp_callback_id = 0;
 static unsigned int headset_callback_id = 0;
+static unsigned int gateway_callback_id = 0;
 
 static void device_free(struct audio_device *dev)
 {
@@ -510,6 +512,48 @@ static void device_headset_cb(struct audio_device *dev,
 	}
 }
 
+static void device_gateway_cb(struct audio_device *dev,
+				gateway_state_t old_state,
+				gateway_state_t new_state,
+				void *user_data)
+{
+	struct dev_priv *priv = dev->priv;
+
+	if (!dev->gateway)
+		return;
+
+	priv->ag_state = new_state;
+
+	switch (new_state) {
+	case GATEWAY_STATE_DISCONNECTED:
+		if (priv->sink_state != SINK_STATE_DISCONNECTED && dev->sink &&
+				(priv->dc_req || priv->disconnecting)) {
+			sink_shutdown(dev->sink);
+			break;
+		}
+		if (priv->sink_state == SINK_STATE_DISCONNECTED)
+			device_set_state(dev, AUDIO_STATE_DISCONNECTED);
+		else if (old_state == GATEWAY_STATE_CONNECTING &&
+				(priv->sink_state == SINK_STATE_CONNECTED ||
+				priv->sink_state == SINK_STATE_PLAYING))
+			device_set_state(dev, AUDIO_STATE_CONNECTED);
+		break;
+	case GATEWAY_STATE_CONNECTING:
+		if (priv->sink_state == SINK_STATE_DISCONNECTED)
+			device_set_state(dev, AUDIO_STATE_CONNECTING);
+		break;
+	case GATEWAY_STATE_CONNECTED:
+		if (old_state == GATEWAY_STATE_CONNECTED)
+			break;
+		if (priv->sink_state == SINK_STATE_DISCONNECTED ||
+				priv->sink_state == SINK_STATE_CONNECTING)
+			device_set_state(dev, AUDIO_STATE_CONNECTED);
+		break;
+	case GATEWAY_STATE_PLAYING:
+		break;
+	}
+}
+
 static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -666,6 +710,9 @@ struct audio_device *audio_device_register(DBusConnection *conn,
 	if (headset_callback_id == 0)
 		headset_callback_id = headset_add_state_cb(device_headset_cb,
 									NULL);
+	if (gateway_callback_id == 0)
+		gateway_callback_id = gateway_add_state_cb(device_gateway_cb,
+									NULL);
 
 	return dev;
 }
@@ -705,6 +752,9 @@ void audio_device_unregister(struct audio_device *device)
 	if (headset_callback_id != 0)
 		headset_remove_state_cb(headset_callback_id);
 
+	if (gateway_callback_id != 0)
+		gateway_remove_state_cb(gateway_callback_id);
+
 	if (device->hs_preauth_id) {
 		g_source_remove(device->hs_preauth_id);
 		device->hs_preauth_id = 0;
-- 
1.7.1

