Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 7/9] audio: Don't use audio_device src and dst in manager_find_devices
Date: Wed, 5 Dec 2012 11:10:22 +0100
Message-ID: <1354702224-15895-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
References: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use addresses taken from btd_dev reference in audio_device to get
device source and destination.
---
 profiles/audio/manager.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 714489a..98ae694 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -673,15 +673,20 @@ GSList *manager_find_devices(const char *path,
 
 	for (l = devices; l != NULL; l = l->next) {
 		struct audio_device *dev = l->data;
+		const bdaddr_t *dev_src;
+		const bdaddr_t *dev_dst;
+
+		dev_src = adapter_get_address(device_get_adapter(dev->btd_dev));
+		dev_dst = device_get_address(dev->btd_dev);
 
 		if ((path && (strcmp(path, "")) &&
 				strcmp(device_get_path(dev->btd_dev), path)))
 			continue;
 
-		if ((src && bacmp(src, BDADDR_ANY)) && bacmp(&dev->src, src))
+		if ((src && bacmp(src, BDADDR_ANY)) && bacmp(dev_src, src))
 			continue;
 
-		if ((dst && bacmp(dst, BDADDR_ANY)) && bacmp(&dev->dst, dst))
+		if ((dst && bacmp(dst, BDADDR_ANY)) && bacmp(dev_dst, dst))
 			continue;
 
 		if (interface && !strcmp(AUDIO_SINK_INTERFACE, interface)
-- 
1.7.9.5

