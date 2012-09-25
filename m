Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0] audio: Fix crash if gateway closed before reply
Date: Tue, 25 Sep 2012 11:30:29 +0200
Message-Id: <1348565429-3045-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The audio gateway can be closed (dev->gateway == NULL) before the reply
from the agent has been received, resulting in the following crash as
reproduced while removing (unpairing) a device:

bluetoothd[2219]: src/mgmt.c:mgmt_unpair_device() index 0 addr 38:16:D1:C5:D1:A2
bluetoothd[2219]: audio/gateway.c:path_unregister() Unregistered interface org.bluez.HandsfreeGateway on path /org/bluez/2219/hci0/dev_38_16_D1_C5_D1_A2
bluetoothd[2219]: audio/media.c:gateway_state_changed()
bluetoothd[2219]: audio/media.c:gateway_state_changed() Clear endpoint 0x555555820640
bluetoothd[2219]: audio/source.c:path_unregister() Unregistered interface org.bluez.AudioSource on path /org/bluez/2219/hci0/dev_38_16_D1_C5_D1_A2
bluetoothd[2219]: src/device.c:btd_device_unref() 0x555555833e70: ref=1
bluetoothd[2219]: src/adapter.c:adapter_get_device() 38:16:D1:C5:D1:A2
bluetoothd[2219]: src/adapter.c:adapter_create_device() 38:16:D1:C5:D1:A2
bluetoothd[2219]: src/device.c:device_create() Creating device /org/bluez/2219/hci0/dev_38_16_D1_C5_D1_A2
bluetoothd[2219]: src/device.c:device_free() 0x55555581f9c0
bluetoothd[2219]: Unable to get btd_device object for 38:16:D1:C5:D1:A2
bluetoothd[2219]: src/device.c:btd_device_unref() 0x555555833e70: ref=0
bluetoothd[2219]: src/device.c:device_free() 0x555555833e70
bluetoothd[2219]: src/mgmt.c:mgmt_event() cond 1
bluetoothd[2219]: src/mgmt.c:mgmt_event() Received 16 bytes from management socket
bluetoothd[2219]: src/mgmt.c:mgmt_cmd_complete()
bluetoothd[2219]: src/mgmt.c:mgmt_cmd_complete() unpair_device complete

Program received signal SIGSEGV, Segmentation fault.
0x000055555556fa26 in newconnection_reply (call=<optimized out>, data=0x555555824dd0) at audio/gateway.c:285
285		if (!dev->gateway->rfcomm) {
---
 audio/gateway.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 45b25a1..6990573 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -282,6 +282,11 @@ static void newconnection_reply(DBusPendingCall *call, void *data)
 	DBusMessage *reply = dbus_pending_call_steal_reply(call);
 	DBusError derr;
 
+	if (gw == NULL) {
+		DBG("Gateway closed before agent reply");
+		goto done;
+	}
+
 	if (!dev->gateway->rfcomm) {
 		DBG("RFCOMM disconnected from server before agent reply");
 		goto done;
-- 
1.7.7.6

