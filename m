Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/2] core: device: Fix bug in device_browse_gatt
Date: Fri, 16 Jan 2015 19:26:30 -0800
Message-Id: <1421465191-1494-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1421465191-1494-1-git-send-email-armansito@chromium.org>
References: <1421465191-1494-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes two issues in GATT service browsing:

1. There was a bug in gatt_client_ready_cb that broke GAttrib-based
profiles by not creating gatt_primary structures if no browse request
exists at the time.

2. In device_browse_gatt, a response to "Pair" wasn't always being sent
since the code didn't assign the DBusMessage pointer to the browse_req.
---
 src/device.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index 9c6e1c5..d2b2947 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3839,9 +3839,9 @@ static void send_le_browse_response(struct browse_req *req)
 	g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
 }
 
-static void register_gatt_services(struct browse_req *req)
+static void register_gatt_services(struct btd_device *device)
 {
-	struct btd_device *device = req->device;
+	struct browse_req *req = device->browse;
 	GSList *services = NULL;
 
 	if (!bt_gatt_client_is_ready(device->client))
@@ -3855,7 +3855,9 @@ static void register_gatt_services(struct browse_req *req)
 
 	btd_device_set_temporary(device, FALSE);
 
-	update_gatt_uuids(req, device->primaries, services);
+	if (req)
+		update_gatt_uuids(req, device->primaries, services);
+
 	g_slist_free_full(device->primaries, g_free);
 	device->primaries = NULL;
 
@@ -3867,7 +3869,8 @@ static void register_gatt_services(struct browse_req *req)
 
 	store_services(device);
 
-	browse_request_free(req);
+	if (req)
+		browse_request_free(req);
 }
 
 static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
@@ -3894,8 +3897,7 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 
 	DBG("MTU: %u", device->att_mtu);
 
-	if (device->browse)
-		register_gatt_services(device->browse);
+	register_gatt_services(device);
 
 	device_accept_gatt_profiles(device);
 
@@ -4183,10 +4185,9 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
 		if (!device->le_state.svc_resolved)
 			goto done;
 
-		/*
-		 * Services have already been discovered, so signal this browse
-		 * request as resolved.
-		 */
+		if (msg)
+			req->msg = dbus_message_ref(msg);
+
 		device_svc_resolved(device, device->bdaddr_type, 0);
 		device->browse = NULL;
 		browse_request_free(req);
-- 
2.2.0.rc0.207.ga3a616c

