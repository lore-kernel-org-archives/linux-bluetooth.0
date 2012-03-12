Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 3/3] audio: add partial unloading to audio driver
Date: Mon, 12 Mar 2012 16:56:39 +0100
Message-Id: <1331567799-1247-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331567799-1247-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331567799-1247-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This solves the issue fully unloading the driver when one of the
supported profiles is not found in the reverse discovery process.

This can be easily reproduced when both Headset and Gateway are enabled.
When a new phone is paired, the incoming connection can be handled by
the gateway server, which assumes the remote device is a HFP headset,
and installs the HFP_HS_UUID. Once the reverse discovery information is
available, this uuid must be removed, but not the whole driver.
---
 audio/manager.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index ab97314..ad32446 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -799,6 +799,49 @@ static int audio_probe(struct btd_device *device, GSList *uuids)
 	return 0;
 }
 
+static int device_part_count(struct audio_device *dev)
+{
+	int count = 0;
+
+	count += dev->headset ? 1 : 0;
+	count += dev->gateway ? 1 : 0;
+	count += dev->sink ? 1 : 0;
+	count += dev->source ? 1 : 0;
+	count += dev->control ? 1 : 0;
+	count += dev->target ? 1 : 0;
+
+	return count;
+}
+
+static int audio_partial_remove(struct btd_device *device, const char *uuid)
+{
+	struct audio_device *dev;
+	const char *path;
+	int part_count;
+
+	path = device_get_path(device);
+
+	DBG("%s: remove uuid %s", path, uuid);
+
+	dev = manager_find_device(path, NULL, NULL, NULL, FALSE);
+	if (!dev)
+		return 0;
+
+	part_count = device_part_count(dev);
+
+	if ((dev->headset != NULL) && !g_strcmp0(uuid, HSP_HS_UUID)) {
+		headset_unregister(dev);
+		return part_count - 1;
+	}
+
+	if ((dev->gateway != NULL) && !g_strcmp0(uuid, HFP_AG_UUID)) {
+		gateway_unregister(dev);
+		return part_count - 1;
+	}
+
+	return part_count;
+}
+
 static void audio_remove(struct btd_device *device)
 {
 	struct audio_device *dev;
@@ -813,7 +856,6 @@ static void audio_remove(struct btd_device *device)
 	devices = g_slist_remove(devices, dev);
 
 	audio_device_unregister(dev);
-
 }
 
 static struct audio_adapter *audio_adapter_ref(struct audio_adapter *adp)
@@ -1115,6 +1157,7 @@ static struct btd_device_driver audio_driver = {
 			ADVANCED_AUDIO_UUID, A2DP_SOURCE_UUID, A2DP_SINK_UUID,
 			AVRCP_TARGET_UUID, AVRCP_REMOTE_UUID),
 	.probe	= audio_probe,
+	.partial_remove	= audio_partial_remove,
 	.remove	= audio_remove,
 };
 
-- 
1.7.7.6

