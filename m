Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 13/16] audio: Use manager_get_device to get device object
Date: Wed, 12 Dec 2012 11:28:05 +0100
Message-ID: <1355308088-9080-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

manager_get_device is a simple wrapper for manager_find_device
and can be used instead making manager API simpler.

manager_find_device{s} are  no longer used outside of manager.c and
can be made static.
---
 profiles/audio/a2dp.c    |   5 +-
 profiles/audio/manager.c | 132 +++++++++++++++++++++++------------------------
 profiles/audio/manager.h |  12 -----
 3 files changed, 68 insertions(+), 81 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index f8e0f19..c812d45 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -127,9 +127,8 @@ static struct audio_device *a2dp_get_dev(struct avdtp *session)
 	struct btd_adapter *adapter = avdtp_get_adapter(session);
 	struct btd_device *device = avdtp_get_device(session);
 
-	return manager_find_device(NULL, adapter_get_address(adapter),
-					device_get_address(device), NULL,
-					FALSE);
+	return manager_get_device(adapter_get_address(adapter),
+					device_get_address(device), FALSE);
 }
 
 static struct a2dp_setup *setup_new(struct avdtp *session)
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index b2e4841..b3d4a68 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -105,6 +105,72 @@ static struct audio_device *get_audio_dev(struct btd_device *device)
 					device_get_address(device), TRUE);
 }
 
+static GSList *manager_find_devices(const char *path,
+					const bdaddr_t *src,
+					const bdaddr_t *dst,
+					const char *interface,
+					gboolean connected)
+{
+	GSList *result = NULL;
+	GSList *l;
+
+	for (l = devices; l != NULL; l = l->next) {
+		struct audio_device *dev = l->data;
+		const bdaddr_t *dev_src;
+		const bdaddr_t *dev_dst;
+
+		dev_src = adapter_get_address(device_get_adapter(dev->btd_dev));
+		dev_dst = device_get_address(dev->btd_dev);
+
+		if ((path && (strcmp(path, "")) &&
+				strcmp(device_get_path(dev->btd_dev), path)))
+			continue;
+
+		if ((src && bacmp(src, BDADDR_ANY)) && bacmp(dev_src, src))
+			continue;
+
+		if ((dst && bacmp(dst, BDADDR_ANY)) && bacmp(dev_dst, dst))
+			continue;
+
+		if (interface && !strcmp(AUDIO_SINK_INTERFACE, interface)
+				&& !dev->sink)
+			continue;
+
+		if (interface && !strcmp(AUDIO_SOURCE_INTERFACE, interface)
+				&& !dev->source)
+			continue;
+
+		if (interface && !strcmp(AUDIO_CONTROL_INTERFACE, interface)
+				&& !dev->control)
+			continue;
+
+		if (connected && !audio_device_is_active(dev, interface))
+			continue;
+
+		result = g_slist_append(result, dev);
+	}
+
+	return result;
+}
+
+static struct audio_device *manager_find_device(const char *path,
+					const bdaddr_t *src,
+					const bdaddr_t *dst,
+					const char *interface,
+					gboolean connected)
+{
+	struct audio_device *result;
+	GSList *l;
+
+	l = manager_find_devices(path, src, dst, interface, connected);
+	if (l == NULL)
+		return NULL;
+
+	result = l->data;
+	g_slist_free(l);
+	return result;
+}
+
 static void audio_remove(struct btd_profile *p, struct btd_device *device)
 {
 	struct audio_device *dev;
@@ -578,72 +644,6 @@ void audio_manager_exit(void)
 	btd_unregister_adapter_driver(&media_driver);
 }
 
-GSList *manager_find_devices(const char *path,
-					const bdaddr_t *src,
-					const bdaddr_t *dst,
-					const char *interface,
-					gboolean connected)
-{
-	GSList *result = NULL;
-	GSList *l;
-
-	for (l = devices; l != NULL; l = l->next) {
-		struct audio_device *dev = l->data;
-		const bdaddr_t *dev_src;
-		const bdaddr_t *dev_dst;
-
-		dev_src = adapter_get_address(device_get_adapter(dev->btd_dev));
-		dev_dst = device_get_address(dev->btd_dev);
-
-		if ((path && (strcmp(path, "")) &&
-				strcmp(device_get_path(dev->btd_dev), path)))
-			continue;
-
-		if ((src && bacmp(src, BDADDR_ANY)) && bacmp(dev_src, src))
-			continue;
-
-		if ((dst && bacmp(dst, BDADDR_ANY)) && bacmp(dev_dst, dst))
-			continue;
-
-		if (interface && !strcmp(AUDIO_SINK_INTERFACE, interface)
-				&& !dev->sink)
-			continue;
-
-		if (interface && !strcmp(AUDIO_SOURCE_INTERFACE, interface)
-				&& !dev->source)
-			continue;
-
-		if (interface && !strcmp(AUDIO_CONTROL_INTERFACE, interface)
-				&& !dev->control)
-			continue;
-
-		if (connected && !audio_device_is_active(dev, interface))
-			continue;
-
-		result = g_slist_append(result, dev);
-	}
-
-	return result;
-}
-
-struct audio_device *manager_find_device(const char *path,
-					const bdaddr_t *src,
-					const bdaddr_t *dst,
-					const char *interface,
-					gboolean connected)
-{
-	struct audio_device *result;
-	GSList *l;
-
-	l = manager_find_devices(path, src, dst, interface, connected);
-	if (l == NULL)
-		return NULL;
-
-	result = l->data;
-	g_slist_free(l);
-	return result;
-}
-
 struct audio_device *manager_get_device(const bdaddr_t *src,
 					const bdaddr_t *dst,
 					gboolean create)
diff --git a/profiles/audio/manager.h b/profiles/audio/manager.h
index 75c1308..f352a67 100644
--- a/profiles/audio/manager.h
+++ b/profiles/audio/manager.h
@@ -37,18 +37,6 @@ void audio_source_disconnected(struct btd_device *dev, int err);
 int audio_manager_init(GKeyFile *config);
 void audio_manager_exit(void);
 
-struct audio_device *manager_find_device(const char *path,
-					const bdaddr_t *src,
-					const bdaddr_t *dst,
-					const char *interface,
-					gboolean connected);
-
-GSList *manager_find_devices(const char *path,
-					const bdaddr_t *src,
-					const bdaddr_t *dst,
-					const char *interface,
-					gboolean connected);
-
 struct audio_device *manager_get_device(const bdaddr_t *src,
 					const bdaddr_t *dst,
 					gboolean create);
-- 
1.8.0

