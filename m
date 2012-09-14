Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v4 5/9] media: Watch interface state changes in transport
Date: Fri, 14 Sep 2012 14:03:12 +0200
Message-Id: <1347624196-11281-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Install watches to keep track whether the audio is streaming or not.
This should be relevant if the transport needs to reflect this state.
---
 audio/transport.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 103 insertions(+), 0 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 410601f..639c87f 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -45,6 +45,8 @@
 #include "a2dp.h"
 #include "headset.h"
 #include "gateway.h"
+#include "sink.h"
+#include "source.h"
 #include "avrcp.h"
 
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport"
@@ -101,6 +103,10 @@ struct media_transport {
 	uint16_t		omtu;		/* Transport output mtu */
 	transport_lock_t	lock;
 	transport_state_t	state;
+	guint			hs_watch;
+	guint			ag_watch;
+	guint			source_watch;
+	guint			sink_watch;
 	guint			(*resume) (struct media_transport *transport,
 					struct media_owner *owner);
 	guint			(*suspend) (struct media_transport *transport,
@@ -173,6 +179,18 @@ void media_transport_destroy(struct media_transport *transport)
 {
 	char *path;
 
+	if (transport->hs_watch)
+		headset_remove_state_cb(transport->hs_watch);
+
+	if (transport->ag_watch)
+		gateway_remove_state_cb(transport->ag_watch);
+
+	if (transport->sink_watch)
+		sink_remove_state_cb(transport->sink_watch);
+
+	if (transport->source_watch)
+		source_remove_state_cb(transport->source_watch);
+
 	path = g_strdup(transport->path);
 	g_dbus_unregister_interface(transport->conn, path,
 						MEDIA_TRANSPORT_INTERFACE);
@@ -1083,6 +1101,76 @@ static void headset_nrec_changed(struct audio_device *dev, gboolean nrec,
 				DBUS_TYPE_BOOLEAN, &nrec);
 }
 
+static void transport_update_playing(struct media_transport *transport,
+							gboolean playing)
+{
+	DBG("%s Playing=%d", transport->path, playing);
+}
+
+static void headset_state_changed(struct audio_device *dev,
+						headset_state_t old_state,
+						headset_state_t new_state,
+						void *user_data)
+{
+	struct media_transport *transport = user_data;
+
+	if (dev != transport->device)
+		return;
+
+	if (new_state == HEADSET_STATE_PLAYING)
+		transport_update_playing(transport, TRUE);
+	else
+		transport_update_playing(transport, FALSE);
+}
+
+static void gateway_state_changed(struct audio_device *dev,
+						gateway_state_t old_state,
+						gateway_state_t new_state,
+						void *user_data)
+{
+	struct media_transport *transport = user_data;
+
+	if (dev != transport->device)
+		return;
+
+	if (new_state == GATEWAY_STATE_PLAYING)
+		transport_update_playing(transport, TRUE);
+	else
+		transport_update_playing(transport, FALSE);
+}
+
+static void sink_state_changed(struct audio_device *dev,
+						sink_state_t old_state,
+						sink_state_t new_state,
+						void *user_data)
+{
+	struct media_transport *transport = user_data;
+
+	if (dev != transport->device)
+		return;
+
+	if (new_state == SINK_STATE_PLAYING)
+		transport_update_playing(transport, TRUE);
+	else
+		transport_update_playing(transport, FALSE);
+}
+
+static void source_state_changed(struct audio_device *dev,
+						source_state_t old_state,
+						source_state_t new_state,
+						void *user_data)
+{
+	struct media_transport *transport = user_data;
+
+	if (dev != transport->device)
+		return;
+
+	if (new_state == SOURCE_STATE_PLAYING)
+		transport_update_playing(transport, TRUE);
+	else
+		transport_update_playing(transport, FALSE);
+}
+
 struct media_transport *media_transport_create(DBusConnection *conn,
 						struct media_endpoint *endpoint,
 						struct audio_device *device,
@@ -1118,6 +1206,15 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 		transport->set_property = set_property_a2dp;
 		transport->data = a2dp;
 		transport->destroy = destroy_a2dp;
+
+		if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0)
+			transport->sink_watch = sink_add_state_cb(
+							sink_state_changed,
+							transport);
+		else
+			transport->source_watch = source_add_state_cb(
+							source_state_changed,
+							transport);
 	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
 			strcasecmp(uuid, HSP_AG_UUID) == 0) {
 		struct headset_transport *headset;
@@ -1135,6 +1232,9 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 		transport->set_property = set_property_headset;
 		transport->data = headset;
 		transport->destroy = destroy_headset;
+		transport->hs_watch = headset_add_state_cb(
+							headset_state_changed,
+							transport);
 	} else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
 			strcasecmp(uuid, HSP_HS_UUID) == 0) {
 		transport->resume = resume_gateway;
@@ -1142,6 +1242,9 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 		transport->cancel = cancel_gateway;
 		transport->get_properties = get_properties_gateway;
 		transport->set_property = set_property_gateway;
+		transport->ag_watch = gateway_add_state_cb(
+							gateway_state_changed,
+							transport);
 	} else
 		goto fail;
 
-- 
1.7.7.6

