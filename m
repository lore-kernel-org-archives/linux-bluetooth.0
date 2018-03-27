Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix checking for paired flag instead of bonded
Date: Tue, 27 Mar 2018 18:38:20 +0300
Message-Id: <20180327153820.25606-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device state should remain valid for devices that are bonded/stored not
only paired.
---
 src/gatt-database.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 2c2526f74..5e2390b34 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -324,7 +324,7 @@ static void att_disconnected(int err, void *user_data)
 	if (!device)
 		goto remove;
 
-	if (device_is_paired(device, state->bdaddr_type))
+	if (device_is_bonded(device, state->bdaddr_type))
 		return;
 
 remove:
@@ -1125,7 +1125,7 @@ static void send_notification_to_device(void *data, void *user_data)
 
 	server = btd_device_get_gatt_server(device);
 	if (!server) {
-		if (!device_is_paired(device, device_state->bdaddr_type))
+		if (!device_is_bonded(device, device_state->bdaddr_type))
 			goto remove;
 		state_set_pending(device_state, notify);
 		return;
-- 
2.14.3

