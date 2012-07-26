Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 1/4] media: Watch A2DP sink-source state changes
Date: Thu, 26 Jul 2012 12:13:26 +0200
Message-Id: <1343297609-30225-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1343297609-30225-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1343297609-30225-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add watches to know about the state changes affecting the A2DP sinks
and sources. The callback functions are just skeletons to be used in
following patches.
---
 audio/media.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index ea6d582..505a490 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -48,6 +48,8 @@
 #include "avrcp.h"
 #include "headset.h"
 #include "gateway.h"
+#include "sink.h"
+#include "source.h"
 #include "manager.h"
 
 #define MEDIA_INTERFACE "org.bluez.Media"
@@ -83,6 +85,8 @@ struct media_endpoint {
 	size_t			size;		/* Endpoint capabilities size */
 	guint			hs_watch;
 	guint			ag_watch;
+	guint			sink_watch;
+	guint			source_watch;
 	guint			watch;
 	GSList			*requests;
 	struct media_adapter	*adapter;
@@ -157,6 +161,12 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
 	if (endpoint->ag_watch)
 		gateway_remove_state_cb(endpoint->ag_watch);
 
+	if (endpoint->sink_watch)
+		sink_remove_state_cb(endpoint->sink_watch);
+
+	if (endpoint->source_watch)
+		source_remove_state_cb(endpoint->source_watch);
+
 	media_endpoint_cancel_all(endpoint);
 
 	g_slist_free_full(endpoint->transports,
@@ -664,6 +674,21 @@ static void gateway_state_changed(struct audio_device *dev,
 	}
 }
 
+static void a2dp_source_state_changed(struct audio_device *dev,
+					source_state_t old_state,
+					source_state_t new_state,
+					void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+	struct media_transport *transport;
+
+	DBG("");
+
+	transport = find_device_transport(endpoint, dev);
+	if (transport == NULL)
+		return;
+}
+
 static gboolean endpoint_init_a2dp_source(struct media_endpoint *endpoint,
 						gboolean delay_reporting,
 						int *err)
@@ -675,9 +700,27 @@ static gboolean endpoint_init_a2dp_source(struct media_endpoint *endpoint,
 	if (endpoint->sep == NULL)
 		return FALSE;
 
+	endpoint->source_watch = source_add_state_cb(a2dp_source_state_changed,
+								endpoint);
+
 	return TRUE;
 }
 
+static void a2dp_sink_state_changed(struct audio_device *dev,
+					sink_state_t old_state,
+					sink_state_t new_state,
+					void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+	struct media_transport *transport;
+
+	DBG("");
+
+	transport = find_device_transport(endpoint, dev);
+	if (transport == NULL)
+		return;
+}
+
 static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
 						gboolean delay_reporting,
 						int *err)
@@ -689,6 +732,9 @@ static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
 	if (endpoint->sep == NULL)
 		return FALSE;
 
+	endpoint->sink_watch = sink_add_state_cb(a2dp_sink_state_changed,
+								endpoint);
+
 	return TRUE;
 }
 
-- 
1.7.7.6

