Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 2/4] media: Add boolean playing field to transport
Date: Thu, 26 Jul 2012 12:13:27 +0200
Message-Id: <1343297609-30225-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1343297609-30225-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1343297609-30225-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This flag represents whether the transport is actually streaming, which
is mapped trivially after the state changes in gateway, headset and A2DP
sink or sources.
---
 audio/media.c     |   29 ++++++++++++++++++++++++++---
 audio/transport.c |    7 +++++++
 audio/transport.h |    2 ++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 505a490..8eee149 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -494,12 +494,12 @@ static void headset_state_changed(struct audio_device *dev,
 	switch (new_state) {
 	case HEADSET_STATE_DISCONNECTED:
 		transport = find_device_transport(endpoint, dev);
-
 		if (transport != NULL) {
 			DBG("Clear endpoint %p", endpoint);
+			media_transport_set_playing(transport, FALSE);
 			clear_configuration(endpoint, transport);
 		}
-		break;
+		return;
 	case HEADSET_STATE_CONNECTING:
 		set_configuration(endpoint, dev, NULL, 0, headset_setconf_cb,
 								dev, NULL);
@@ -511,6 +511,12 @@ static void headset_state_changed(struct audio_device *dev,
 	case HEADSET_STATE_PLAYING:
 		break;
 	}
+
+	transport = find_device_transport(endpoint, dev);
+	if (new_state == HEADSET_STATE_PLAYING)
+		media_transport_set_playing(transport, TRUE);
+	else
+		media_transport_set_playing(transport, FALSE);
 }
 
 static const char *get_name(struct a2dp_sep *sep, void *user_data)
@@ -660,9 +666,10 @@ static void gateway_state_changed(struct audio_device *dev,
 		transport = find_device_transport(endpoint, dev);
 		if (transport != NULL) {
 			DBG("Clear endpoint %p", endpoint);
+			media_transport_set_playing(transport, FALSE);
 			clear_configuration(endpoint, transport);
 		}
-		break;
+		return;
 	case GATEWAY_STATE_CONNECTING:
 		set_configuration(endpoint, dev, NULL, 0,
 					gateway_setconf_cb, dev, NULL);
@@ -672,6 +679,12 @@ static void gateway_state_changed(struct audio_device *dev,
 	case GATEWAY_STATE_PLAYING:
 		break;
 	}
+
+	transport = find_device_transport(endpoint, dev);
+	if (new_state == GATEWAY_STATE_PLAYING)
+		media_transport_set_playing(transport, TRUE);
+	else
+		media_transport_set_playing(transport, FALSE);
 }
 
 static void a2dp_source_state_changed(struct audio_device *dev,
@@ -687,6 +700,11 @@ static void a2dp_source_state_changed(struct audio_device *dev,
 	transport = find_device_transport(endpoint, dev);
 	if (transport == NULL)
 		return;
+
+	if (new_state == SOURCE_STATE_PLAYING)
+		media_transport_set_playing(transport, TRUE);
+	else
+		media_transport_set_playing(transport, FALSE);
 }
 
 static gboolean endpoint_init_a2dp_source(struct media_endpoint *endpoint,
@@ -719,6 +737,11 @@ static void a2dp_sink_state_changed(struct audio_device *dev,
 	transport = find_device_transport(endpoint, dev);
 	if (transport == NULL)
 		return;
+
+	if (new_state == SINK_STATE_PLAYING)
+		media_transport_set_playing(transport, TRUE);
+	else
+		media_transport_set_playing(transport, FALSE);
 }
 
 static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
diff --git a/audio/transport.c b/audio/transport.c
index 832ad2a..f988d48 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -86,6 +86,7 @@ struct media_transport {
 	uint16_t		omtu;		/* Transport output mtu */
 	gboolean		read_lock;
 	gboolean		write_lock;
+	gboolean		playing;
 	gboolean		in_use;
 	guint			(*resume) (struct media_transport *transport,
 					struct media_owner *owner);
@@ -898,6 +899,12 @@ static void get_properties_gateway(struct media_transport *transport,
 	/* None */
 }
 
+void media_transport_set_playing(struct media_transport *transport,
+							gboolean playing)
+{
+	transport->playing = playing;
+}
+
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter)
 {
diff --git a/audio/transport.h b/audio/transport.h
index d20c327..78323b2 100644
--- a/audio/transport.h
+++ b/audio/transport.h
@@ -37,5 +37,7 @@ void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
 void media_transport_update_volume(struct media_transport *transport,
 								uint8_t volume);
+void media_transport_set_playing(struct media_transport *transport,
+							gboolean playing);
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter);
-- 
1.7.7.6

