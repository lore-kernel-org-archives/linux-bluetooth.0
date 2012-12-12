Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 15/16] audio: Simplify manager_find_device
Date: Wed, 12 Dec 2012 11:28:07 +0100
Message-ID: <1355308088-9080-16-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that audio_device and other audio structures holds references to
btd_device and not addresses or paths there is no need for complex
find function.
---
 profiles/audio/manager.c | 70 +++++-------------------------------------------
 1 file changed, 6 insertions(+), 64 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index adc4e77..9ab1be2 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -102,80 +102,25 @@ static struct audio_device *get_audio_dev(struct btd_device *device)
 	return manager_get_audio_device(device, TRUE);
 }
 
-static GSList *manager_find_devices(const char *path,
-					const bdaddr_t *src,
-					const bdaddr_t *dst,
-					const char *interface,
-					gboolean connected)
+static struct audio_device *manager_find_device(struct btd_device *device)
 {
-	GSList *result = NULL;
 	GSList *l;
 
 	for (l = devices; l != NULL; l = l->next) {
 		struct audio_device *dev = l->data;
-		const bdaddr_t *dev_src;
-		const bdaddr_t *dev_dst;
 
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
+		if (dev->btd_dev == device)
+			return dev;
 	}
 
-	return result;
-}
-
-static struct audio_device *manager_find_device(const char *path,
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
+	return NULL;
 }
 
 static void audio_remove(struct btd_profile *p, struct btd_device *device)
 {
 	struct audio_device *dev;
-	const char *path;
-
-	path = device_get_path(device);
 
-	dev = manager_find_device(path, NULL, NULL, NULL, FALSE);
+	dev = manager_find_device(device);
 	if (dev == NULL)
 		return;
 
@@ -645,11 +590,8 @@ struct audio_device *manager_get_audio_device(struct btd_device *device,
 							gboolean create)
 {
 	struct audio_device *dev;
-	struct btd_adapter *adapter = device_get_adapter(device);
 
-	dev = manager_find_device(NULL, adapter_get_address(adapter),
-					device_get_address(device), NULL,
-					FALSE);
+	dev = manager_find_device(device);
 	if (dev)
 		return dev;
 
-- 
1.8.0

