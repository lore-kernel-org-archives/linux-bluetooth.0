Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2] core/device: Store services when they change or after pairing.
Date: Mon, 14 Sep 2015 09:16:27 -0700
Message-Id: <1442247387-3263-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Service caching works only for paired devices. Right now caching is
triggered only right after discovery finishes. That means that if already
paired device sends service changed notofication, cache won't be updated.
Also if you connect to new device, and then pair during this connection,
your services won't be cached until reconnect. This will require full
service discovery which is slow.
This patch fixes that by trying to cache services every time services
changed, and right after successful pairing.
---
 src/device.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8184508..e155d08 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2202,10 +2202,8 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t bdaddr_type,
 	if (!dev->temporary)
 		store_device_info(dev);
 
-	if (bdaddr_type != BDADDR_BREDR && err == 0) {
+	if (bdaddr_type != BDADDR_BREDR && err == 0)
 		store_services(dev);
-		store_gatt_db(dev);
-	}
 
 	if (!req)
 		return;
@@ -3313,6 +3311,9 @@ static gboolean gatt_services_changed(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
+	if (device->bdaddr_type != BDADDR_BREDR)
+		store_gatt_db(device);
+
 	g_dbus_emit_property_changed(dbus_conn, device->path, DEVICE_INTERFACE,
 								"GattServices");
 
@@ -5315,6 +5316,11 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 	 * request
 	 */
 	if (state->svc_resolved && bonding) {
+		/* Attept to store services for this device failed because it
+		 * was not paired. Now that we're paired retry. */
+		if (device->bdaddr_type != BDADDR_BREDR)
+			store_gatt_db(device);
+
 		g_dbus_send_reply(dbus_conn, bonding->msg, DBUS_TYPE_INVALID);
 		bonding_request_free(bonding);
 		return;
-- 
2.5.0

