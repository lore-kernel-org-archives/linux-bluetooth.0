Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio: Fix attempting to create a device on driver .remove
Date: Tue, 25 Sep 2012 13:54:59 +0300
Message-Id: <1348570499-7442-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

audio_remove calls get_audio_dev which may attempt to create the device
if it doesn't exist.
---
 audio/manager.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index fbfe00f..6d7ac55 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -668,9 +668,12 @@ static struct audio_device *get_audio_dev(struct btd_device *device)
 static void audio_remove(struct btd_device *device)
 {
 	struct audio_device *dev;
+	const char *path;
 
-	dev = get_audio_dev(device);
-	if (!dev)
+	path = device_get_path(device);
+
+	dev = manager_find_device(path, NULL, NULL, NULL, FALSE);
+	if (dev == NULL)
 		return;
 
 	devices = g_slist_remove(devices, dev);
-- 
1.7.11.4

