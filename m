Return-Path: <cyrus@holtmann.org>
From: Damjan Cvetko <Damjan.Cvetko@monotek.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Auto reconnect heartrate LE device
Date: Fri, 18 Jan 2013 12:06:38 +0000
Message-ID: <CEE0DF8E7B2727428D202DA3F3FBC4DD8C7440F0@PULWAR.mtk.lan>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

Talked to jhe on IRC regarding this some days ago. I have a Polar heart rate monitor, and with the latest code it work well enough. However when the device goes out of range, it is disconnected from bluetoothd and does not reconnect when coming back into range:

bluetoothd[2898]: src/adapter.c:dev_disconnected() Device 00:22:D0:00:00:64 disconnected, reason 0
...
bluetoothd[2898]: src/device.c:attrib_disconnected_cb() Automatic connection disabled

I wanted to add auto reconnection, and this 1 line fix is what I came up with. It works in most cases, but sometimes bluetoothd fals into a loop.

...
"src/adapter.c:adapter_set_discovering() hci0 restarting discovery: disc_sessions 2"
"src/adapter.c:start_discovery_complete() Busy (0x0a)"
"src/adapter.c:adapter_set_discovering() hci0 restarting discovery: disc_sessions 2"
...

Still looking into that part, could also be unrelated. Here is the patch.

Best,
Damjan
---
Set auto connect for heartrate device.

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 5c56d3f..1788d4f 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -801,6 +801,8 @@ static int heartrate_device_register(struct btd_device *device,
        hr->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
                                                attio_disconnected_cb, hr);

+       device_set_auto_connect(device, TRUE);
+
        return 0;
 }

