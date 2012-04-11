Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 3/7] audio: Add multiple device search to manager
Date: Wed, 11 Apr 2012 08:57:14 +0200
Message-Id: <1334127438-27617-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This method is useful to search or than one device fulfulling certain
criteria.
---
 audio/manager.c |   33 +++++++++++++++++++++++++++++----
 audio/manager.h |    7 +++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 170ed23..b17e349 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -1300,17 +1300,23 @@ void audio_manager_exit(void)
 	btd_unregister_device_driver(&audio_driver);
 }
 
-struct audio_device *manager_find_device(const char *path,
+GSList *manager_find_devices(const char *path,
 					const bdaddr_t *src,
 					const bdaddr_t *dst,
 					const char *interface,
-					gboolean connected)
+					gboolean connected,
+					size_t max_count)
 {
+	GSList *result = NULL;
+	size_t result_size = 0;
 	GSList *l;
 
 	for (l = devices; l != NULL; l = l->next) {
 		struct audio_device *dev = l->data;
 
+		if ((max_count > 0) && (result_size == max_count))
+			break;
+
 		if ((path && (strcmp(path, "")) && strcmp(dev->path, path)))
 			continue;
 
@@ -1343,10 +1349,29 @@ struct audio_device *manager_find_device(const char *path,
 		if (connected && !audio_device_is_active(dev, interface))
 			continue;
 
-		return dev;
+		result = g_slist_append(result, dev);
+		result_size++;
 	}
 
-	return NULL;
+	return result;
+}
+
+struct audio_device *manager_find_device(const char *path,
+					const bdaddr_t *src,
+					const bdaddr_t *dst,
+					const char *interface,
+					gboolean connected)
+{
+	struct audio_device *result;
+	GSList *l;
+
+	l = manager_find_devices(path, src, dst, interface, connected, 1);
+	if (l == NULL)
+		return NULL;
+
+	result = l->data;
+	g_slist_free(l);
+	return result;
 }
 
 struct audio_device *manager_get_device(const bdaddr_t *src,
diff --git a/audio/manager.h b/audio/manager.h
index cfc646c..57bcc18 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -46,6 +46,13 @@ struct audio_device *manager_find_device(const char *path,
 					const char *interface,
 					gboolean connected);
 
+GSList *manager_find_devices(const char *path,
+					const bdaddr_t *src,
+					const bdaddr_t *dst,
+					const char *interface,
+					gboolean connected,
+					size_t max_count);
+
 struct audio_device *manager_get_device(const bdaddr_t *src,
 					const bdaddr_t *dst,
 					gboolean create);
-- 
1.7.7.6

