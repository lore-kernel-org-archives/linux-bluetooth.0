Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] input: Fix emitting a signal for a non-existant interface
Date: Fri, 30 Nov 2012 20:37:05 -0300
Message-Id: <1354318625-15066-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the 'org.bluez.Input' interface was removed, this should have been
removed as well, now it is causing a segmentation fault.
---
 profiles/input/device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 2871cc3..421af64 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -503,9 +503,6 @@ static int input_device_connected(struct input_device *idev)
 	if (err < 0)
 		return err;
 
-	g_dbus_emit_property_changed(idev->conn, idev->path,
-					INPUT_DEVICE_INTERFACE, "Connected");
-
 	idev->dc_id = device_add_disconnect_watch(idev->device, disconnect_cb,
 							idev, NULL);
 
-- 
1.8.0

