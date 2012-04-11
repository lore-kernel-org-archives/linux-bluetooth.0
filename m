Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 5/7] media: Create multiple transports if needed
Date: Wed, 11 Apr 2012 08:57:16 +0200
Message-Id: <1334127438-27617-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

During endpoint registration one than one device might be connected.
Thus all matching devices should have one transport each.
---
 audio/media.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 23c3217..3324103 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -713,26 +713,42 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 			goto failed;
 	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
 					strcasecmp(uuid, HSP_AG_UUID) == 0) {
-		struct audio_device *dev;
+		GSList *list;
+		GSList *l;
 
 		endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
 								endpoint);
-		dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
-						AUDIO_HEADSET_INTERFACE, TRUE);
-		if (dev)
+		list = manager_find_devices(NULL, &adapter->src, BDADDR_ANY,
+						AUDIO_HEADSET_INTERFACE, TRUE,
+						0);
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
-						AUDIO_GATEWAY_INTERFACE, TRUE);
-		if (dev)
+		list = manager_find_devices(NULL, &adapter->src, BDADDR_ANY,
+						AUDIO_GATEWAY_INTERFACE, TRUE,
+						0);
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

