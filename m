Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Configure HFP/HSP endpoints if headset interface is already connected
Date: Tue, 21 Dec 2010 17:43:15 +0200
Message-Id: <1292946195-25355-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

HFP/HSP can be connected when registering an endpoint which is different
than on a2dp where the sep cannot be configured already since it wasn't
available before.
---
 audio/media.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index b28bb33..97a60a1 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -42,6 +42,7 @@
 #include "transport.h"
 #include "a2dp.h"
 #include "headset.h"
+#include "manager.h"
 
 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
@@ -200,10 +201,18 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 		if (endpoint->sep == NULL)
 			goto failed;
 	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
-					g_strcmp0(uuid, HSP_AG_UUID) == 0)
+					g_strcmp0(uuid, HSP_AG_UUID) == 0) {
+		struct audio_device *dev;
+
 		endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
 								endpoint);
-	else
+		dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
+						AUDIO_HEADSET_INTERFACE, TRUE);
+		if (dev)
+			media_endpoint_set_configuration(endpoint, dev, NULL,
+							0, headset_setconf_cb,
+							dev);
+	} else
 		goto failed;
 
 	endpoint->watch = g_dbus_add_disconnect_watch(adapter->conn, sender,
-- 
1.7.1

