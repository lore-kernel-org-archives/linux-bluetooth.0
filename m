Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v1 4/5] media: Create multiple transports if needed
Date: Fri, 27 Apr 2012 12:59:46 +0200
Message-Id: <1335524387-22831-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1335524387-22831-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335524387-22831-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

During endpoint registration one than one device might be connected.
Thus all matching devices should have one transport each.
---
 audio/media.c |   43 ++++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 23c3217..5cbf4a2 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -589,27 +589,14 @@ static void clear_config(struct a2dp_sep *sep, void *user_data)
 	clear_endpoint(endpoint);
 }
 
-static struct media_transport *get_unique_transport(
-					struct media_endpoint *endpoint)
-{
-	if (endpoint->transports == NULL)
-		return NULL;
-
-	if (endpoint->transports->next != NULL)
-		return NULL;
-
-	return endpoint->transports->data;
-}
-
 static void set_delay(struct a2dp_sep *sep, uint16_t delay, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
-	struct media_transport *transport = get_unique_transport(endpoint);
 
-	if (transport == NULL)
+	if (endpoint->transports == NULL)
 		return;
 
-	media_transport_update_delay(transport, delay);
+	media_transport_update_delay(endpoint->transports->data, delay);
 }
 
 static struct a2dp_endpoint a2dp_endpoint = {
@@ -713,26 +700,40 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 			goto failed;
 	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
 					strcasecmp(uuid, HSP_AG_UUID) == 0) {
-		struct audio_device *dev;
+		GSList *list;
+		GSList *l;
 
 		endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
 								endpoint);
-		dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
+		list = manager_find_devices(NULL, &adapter->src, BDADDR_ANY,
 						AUDIO_HEADSET_INTERFACE, TRUE);
-		if (dev)
+
+		for (l = list; l != NULL; l = l->next) {
+			struct audio_device *dev = l->data;
+
 			set_configuration(endpoint, dev, NULL, 0,
 						headset_setconf_cb, dev, NULL);
+		}
+
+		g_slist_free(list);
 	} else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
 					strcasecmp(uuid, HSP_HS_UUID) == 0) {
-		struct audio_device *dev;
+		GSList *list;
+		GSList *l;
 
 		endpoint->ag_watch = gateway_add_state_cb(gateway_state_changed,
 								endpoint);
-		dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
+		list = manager_find_devices(NULL, &adapter->src, BDADDR_ANY,
 						AUDIO_GATEWAY_INTERFACE, TRUE);
-		if (dev)
+
+		for (l = list; l != NULL; l = l->next) {
+			struct audio_device *dev = l->data;
+
 			set_configuration(endpoint, dev, NULL, 0,
 						gateway_setconf_cb, dev, NULL);
+		}
+
+		g_slist_free(list);
 	} else {
 		if (err)
 			*err = -EINVAL;
-- 
1.7.7.6

