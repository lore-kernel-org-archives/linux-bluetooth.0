Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Fix no sink SEP if source interface not registered
Date: Wed, 16 Feb 2011 20:46:12 +0200
Message-Id: <1297881972-31557-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A2DP sink endpoint shall not be created when using media API, if audio
source D-Bus interface is not registered.

Such fixes bluetoothd crash when SDP record is registered and remote
device tries to connect and stream to A2DP sink which is not initialized.
Dereferencing of NULL happens in source_new_stream since device->source
was not created.
---
 audio/media.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 9cfbe0e..03e1a96 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -43,6 +43,7 @@
 #include "a2dp.h"
 #include "headset.h"
 #include "manager.h"
+#include "source.h"
 
 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
@@ -188,6 +189,7 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 						int size)
 {
 	struct media_endpoint *endpoint;
+	struct audio_device *dev;
 
 	endpoint = g_new0(struct media_endpoint, 1);
 	endpoint->sender = g_strdup(sender);
@@ -210,6 +212,11 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 		if (endpoint->sep == NULL)
 			goto failed;
 	} else if (strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
+		dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
+						AUDIO_SOURCE_INTERFACE, FALSE);
+		if (!dev)
+			goto failed;
+
 		endpoint->sep = a2dp_add_sep(&adapter->src,
 						AVDTP_SEP_TYPE_SINK, codec,
 						delay_reporting, endpoint);
@@ -217,8 +224,6 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 			goto failed;
 	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
 					g_strcmp0(uuid, HSP_AG_UUID) == 0) {
-		struct audio_device *dev;
-
 		endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
 								endpoint);
 		dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
-- 
1.7.1

