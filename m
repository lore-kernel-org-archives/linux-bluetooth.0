Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 07/10] audio: Add function to remove inactive devices
Date: Fri, 12 Jul 2013 12:54:40 +0200
Message-Id: <1373626483-2031-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

A plugin might create an instance of audio_device using the manager's
API and therefore a equivalent function is needed for removal. This
simple approach assumes that there will be no more than one plugin
adding/removing audio devices.
---
 profiles/audio/manager.c | 12 ++++++++++++
 profiles/audio/manager.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 7f02fbd..6b5d912 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -464,6 +464,18 @@ struct audio_device *manager_get_audio_device(struct btd_device *device,
 	return dev;
 }
 
+void manager_remove_audio_device(struct audio_device *dev)
+{
+	if (dev == NULL)
+		return;
+
+	if (dev->sink || dev->source || dev->control)
+		return;
+
+	devices = g_slist_remove(devices, dev);
+	audio_device_unregister(dev);
+}
+
 static void set_fast_connectable(struct btd_adapter *adapter,
 							gpointer user_data)
 {
diff --git a/profiles/audio/manager.h b/profiles/audio/manager.h
index b8d8ef7..8167a86 100644
--- a/profiles/audio/manager.h
+++ b/profiles/audio/manager.h
@@ -34,6 +34,7 @@ void audio_manager_exit(void);
 
 struct audio_device *manager_get_audio_device(struct btd_device *device,
 							gboolean create);
+void manager_remove_audio_device(struct audio_device *dev);
 
 /* TRUE to enable fast connectable and FALSE to disable fast connectable for all
  * audio adapters. */
-- 
1.8.1.4

