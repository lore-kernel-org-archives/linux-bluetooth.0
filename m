Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] core/device: Store services after pairing.
Date: Wed,  9 Sep 2015 09:42:04 -0700
Message-Id: <1441816924-3585-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Service caching works only for paired devices. Right now caching is
triggered only right after discovery finishes. That means that if you
connect to new device, then pair during this connection, your services
won't be cached until reconnect. This will require full service discovery
which is slow.
This patch fixes that by trying to cache services right after successful
pairing.
---
 src/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/device.c b/src/device.c
index 8184508..d31620e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5315,6 +5315,11 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
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
2.1.4

