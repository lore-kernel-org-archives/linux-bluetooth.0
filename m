Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] device: Fix segmentation fault removing devices
Date: Tue, 31 Jan 2012 16:59:05 +0100
Message-Id: <1328025545-14320-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is an unbalanced control regarding to the GATT channel and its
attachid, we have to to update the attach id value by setting it to
zero whenever we detach a GATT channel.
---
 src/device.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index c19acd4..9f749b7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1734,6 +1734,7 @@ static void attrib_disconnected(gpointer user_data)
 	attrib_channel_detach(device->attrib, device->attachid);
 	g_attrib_unref(device->attrib);
 	device->attrib = NULL;
+	device->attachid = 0;
 
 	if (device->auto_connect == FALSE)
 		return;
@@ -1781,6 +1782,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 	if (device->attios == NULL && device->attios_offline == NULL) {
 		attrib_channel_detach(device->attrib, device->attachid);
+		device->attachid = 0;
 		g_attrib_unref(device->attrib);
 		device->attrib = NULL;
 	} else
@@ -2854,7 +2856,7 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 	if (device->attios != NULL || device->attios_offline != NULL)
 		return TRUE;
 
-	if (device->attachid) {
+	if (device->attachid > 0) {
 		attrib_channel_detach(device->attrib, device->attachid);
 		device->attachid = 0;
 	}
-- 
1.7.9

