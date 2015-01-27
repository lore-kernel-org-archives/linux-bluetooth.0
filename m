Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1] core: device: Fix bugs in device_browse_gatt
Date: Tue, 27 Jan 2015 11:59:06 -0800
Message-Id: <1422388746-23627-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes two issues in GATT service browsing:

1. There was a bug in gatt_client_ready_cb that broke GAttrib-based
profiles by not creating gatt_primary structures if no browse request
exists at the time.

2. In device_browse_gatt, a response to "Pair" wasn't always being sent
since the code didn't assign the DBusMessage pointer to the browse_req.

Change-Id: I9d2b24db19be9c55b971504750a1061df6366e84
---
 src/device.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/device.c b/src/device.c
index 2a5a883..814489a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3836,9 +3836,9 @@ done:
 	attio_cleanup(device);
 }
 
-static void register_gatt_services(struct browse_req *req)
+static void register_gatt_services(struct btd_device *device)
 {
-	struct btd_device *device = req->device;
+	struct browse_req *req = device->browse;
 	GSList *services = NULL;
 
 	if (!bt_gatt_client_is_ready(device->client))
@@ -3852,7 +3852,9 @@ static void register_gatt_services(struct browse_req *req)
 
 	btd_device_set_temporary(device, FALSE);
 
-	update_gatt_uuids(req, device->primaries, services);
+	if (req)
+		update_gatt_uuids(req, device->primaries, services);
+
 	g_slist_free_full(device->primaries, g_free);
 	device->primaries = NULL;
 
@@ -3886,8 +3888,7 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 
 	DBG("MTU: %u", device->att_mtu);
 
-	if (device->browse)
-		register_gatt_services(device->browse);
+	register_gatt_services(device);
 
 	device_accept_gatt_profiles(device);
 
@@ -4200,10 +4201,9 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
 		if (!device->le_state.svc_resolved)
 			return 0;
 
-		/*
-		 * Services have already been discovered, so signal this browse
-		 * request as resolved.
-		 */
+		if (msg)
+			req->msg = dbus_message_ref(msg);
+
 		device_svc_resolved(device, device->bdaddr_type, 0);
 		return 0;
 	}
-- 
2.2.0.rc0.207.ga3a616c

