Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 1/2] device: don't auto-connect on disc-cb attio callback registration
Date: Thu,  8 Mar 2012 15:44:38 +0200
Message-Id: <1331214279-27521-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a device is already connected, don't auto-connect if we register
a disconnect-only attio callback. This will obviously fail.
---
 src/device.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index dfc8e59..b339ac1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2942,10 +2942,15 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 	attio->dcfunc = dcfunc;
 	attio->user_data = user_data;
 
-	if (device->attrib && cfunc) {
-		device->attios_offline = g_slist_append(device->attios_offline,
-									attio);
-		g_idle_add(notify_attios, device);
+	if (device->attrib) {
+		if (cfunc) {
+			device->attios_offline =
+				g_slist_append(device->attios_offline, attio);
+
+			g_idle_add(notify_attios, device);
+		} else {
+			device->attios = g_slist_append(device->attios, attio);
+		}
 	} else {
 		device->auto_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
 						att_connect, device,
-- 
1.7.5.4

