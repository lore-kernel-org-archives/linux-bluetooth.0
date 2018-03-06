Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] device: Fix missing Paired property change on non-bonded device
Date: Tue,  6 Mar 2018 15:15:14 +0100
Message-Id: <20180306141514.7413-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If device is paired but not bonded than Paired property should be
also updated when device is disconnected.
---
 src/device.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 8af77dbc8..7c7196ca1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2735,10 +2735,19 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 		dbus_message_unref(msg);
 	}
 
-	if (state->paired && !state->bonded)
+	if (state->paired && !state->bonded) {
 		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
 								bdaddr_type);
 
+		state->paired = false;
+
+		/* report change only if both bearers are unpaired */
+		if (!device->bredr_state.paired && !device->le_state.paired)
+			g_dbus_emit_property_changed(dbus_conn, device->path,
+							DEVICE_INTERFACE,
+							"Paired");
+	}
+
 	if (device->bredr_state.connected || device->le_state.connected)
 		return;
 
-- 
2.14.3

