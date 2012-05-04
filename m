Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 5/6] media: Create multiple transports if needed
Date: Fri,  4 May 2012 15:14:39 +0200
Message-Id: <1336137280-6692-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336137280-6692-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336137280-6692-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

During endpoint registration one than one device might be connected.
Thus all matching devices should have one transport each.
---
 audio/media.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 88b994f..9c7a103 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -688,30 +688,44 @@ static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
 
 static gboolean endpoint_init_ag(struct media_endpoint *endpoint, int *err)
 {
-	struct audio_device *dev;
+	GSList *list;
+	GSList *l;
 
 	endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
 								endpoint);
-	dev = manager_find_device(NULL, &endpoint->adapter->src, BDADDR_ANY,
+	list = manager_find_devices(NULL, &endpoint->adapter->src, BDADDR_ANY,
 						AUDIO_HEADSET_INTERFACE, TRUE);
-	if (dev)
+
+	for (l = list; l != NULL; l = l->next) {
+		struct audio_device *dev = l->data;
+
 		set_configuration(endpoint, dev, NULL, 0,
 						headset_setconf_cb, dev, NULL);
+	}
+
+	g_slist_free(list);
 
 	return TRUE;
 }
 
 static gboolean endpoint_init_hs(struct media_endpoint *endpoint, int *err)
 {
-	struct audio_device *dev;
+	GSList *list;
+	GSList *l;
 
 	endpoint->ag_watch = gateway_add_state_cb(gateway_state_changed,
 								endpoint);
-	dev = manager_find_device(NULL, &endpoint->adapter->src, BDADDR_ANY,
+	list = manager_find_devices(NULL, &endpoint->adapter->src, BDADDR_ANY,
 						AUDIO_GATEWAY_INTERFACE, TRUE);
-	if (dev)
+
+	for (l = list; l != NULL; l = l->next) {
+		struct audio_device *dev = l->data;
+
 		set_configuration(endpoint, dev, NULL, 0,
 						gateway_setconf_cb, dev, NULL);
+	}
+
+	g_slist_free(list);
 
 	return TRUE;
 }
-- 
1.7.7.6

