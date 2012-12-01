Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 1/2] input: Fix emitting a signal for a non-existant interface
Date: Fri, 30 Nov 2012 21:36:56 -0300
Message-Id: <1354322217-11219-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the 'org.bluez.Input' interface was removed, this should have been
removed as well, now it is causing a segmentation fault.
---
 profiles/input/device.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 2871cc3..7538297 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -160,9 +160,6 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	if ((cond & (G_IO_HUP | G_IO_ERR)) && idev->ctrl_watch)
 		g_io_channel_shutdown(chan, TRUE, NULL);
 
-	g_dbus_emit_property_changed(idev->conn, idev->path,
-					INPUT_DEVICE_INTERFACE, "Connected");
-
 	device_remove_disconnect_watch(idev->device, idev->dc_id);
 	idev->dc_id = 0;
 
@@ -503,9 +500,6 @@ static int input_device_connected(struct input_device *idev)
 	if (err < 0)
 		return err;
 
-	g_dbus_emit_property_changed(idev->conn, idev->path,
-					INPUT_DEVICE_INTERFACE, "Connected");
-
 	idev->dc_id = device_add_disconnect_watch(idev->device, disconnect_cb,
 							idev, NULL);
 
-- 
1.8.0

