Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ] Fix enable fast connectable when connection allowed
Date: Fri, 11 Nov 2011 11:11:50 +0200
Message-Id: <1321002710-19712-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/manager.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 6d294b6..befd887 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -1387,9 +1387,9 @@ gboolean manager_allow_headset_connection(struct audio_device *device)
 		if (dev == device)
 			continue;
 
-		if (bacmp(&dev->src, &device->src))
-			continue;
-
+		if (device)
+			if (bacmp(&dev->src, &device->src))
+				continue;
 		if (!hs)
 			continue;
 
@@ -1407,6 +1407,13 @@ void manager_set_fast_connectable(gboolean enable)
 {
 	GSList *l;
 
+	if (enable) {
+		if (!manager_allow_headset_connection(NULL)) {
+			DBG("Refusing enabling fast connectable");
+			return;
+		}
+	}
+
 	for (l = adapters; l != NULL; l = l->next) {
 		struct audio_adapter *adapter = l->data;
 
-- 
1.7.4.1

