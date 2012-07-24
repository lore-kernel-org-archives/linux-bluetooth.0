Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 2/4] media: Add boolean playing field to transport
Date: Tue, 24 Jul 2012 17:52:28 +0200
Message-Id: <1343145150-6427-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1343145150-6427-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1343145150-6427-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This flag represents whether the transport is actually streaming, which
is mapped trivially after the state changes in gateway, headset and A2DP
sink or sources.
---
 audio/media.c     |   26 ++++++++++++++++++++++++--
 audio/transport.c |    7 +++++++
 audio/transport.h |    2 ++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 1a54f4a..d12445f 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -494,21 +494,26 @@ static void headset_state_changed(struct audio_device *dev,
 	switch (new_state) {
 	case HEADSET_STATE_DISCONNECTED:
 		transport = find_device_transport(endpoint, dev);
-
 		if (transport != NULL) {
 			DBG("Clear endpoint %p", endpoint);
+			media_transport_set_playing(transport, FALSE);
 			clear_configuration(endpoint, transport);
 		}
 		break;
 	case HEADSET_STATE_CONNECTING:
 		set_configuration(endpoint, dev, NULL, 0, headset_setconf_cb,
 								dev, NULL);
+		transport = find_device_transport(endpoint, dev);
+		media_transport_set_playing(transport, FALSE);
 		break;
 	case HEADSET_STATE_CONNECTED:
-		break;
 	case HEADSET_STATE_PLAY_IN_PROGRESS:
+		transport = find_device_transport(endpoint, dev);
+		media_transport_set_playing(transport, FALSE);
 		break;
 	case HEADSET_STATE_PLAYING:
+		transport = find_device_transport(endpoint, dev);
+		media_transport_set_playing(transport, TRUE);
 		break;
 	}
 }
@@ -660,16 +665,23 @@ static void gateway_state_changed(struct audio_device *dev,
 		transport = find_device_transport(endpoint, dev);
 		if (transport != NULL) {
 			DBG("Clear endpoint %p", endpoint);
+			media_transport_set_playing(transport, FALSE);
 			clear_configuration(endpoint, transport);
 		}
 		break;
 	case GATEWAY_STATE_CONNECTING:
 		set_configuration(endpoint, dev, NULL, 0,
 					gateway_setconf_cb, dev, NULL);
+		transport = find_device_transport(endpoint, dev);
+		media_transport_set_playing(transport, FALSE);
 		break;
 	case GATEWAY_STATE_CONNECTED:
+		transport = find_device_transport(endpoint, dev);
+		media_transport_set_playing(transport, FALSE);
 		break;
 	case GATEWAY_STATE_PLAYING:
+		transport = find_device_transport(endpoint, dev);
+		media_transport_set_playing(transport, TRUE);
 		break;
 	}
 }
@@ -687,6 +699,11 @@ static void a2dp_source_state_changed(struct audio_device *dev,
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
@@ -719,6 +736,11 @@ static void a2dp_sink_state_changed(struct audio_device *dev,
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

