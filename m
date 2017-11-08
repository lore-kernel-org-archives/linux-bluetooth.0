Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] device: Fix possible runtime warning
Date: Wed,  8 Nov 2017 12:24:59 +0100
Message-Id: <20171108112459.9811-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This g_source_remove() doesn't have its argument check for validity
which can lead to a runtime warning.

bluetoothd[14785]: GLib: g_source_remove: assertion 'tag > 0' failed
bluetoothd[14785]: ++++++++ backtrace ++++++++
bluetoothd[14785]: #1  g_logv+0x25d (/usr/lib64/libglib-2.0.so.0.5400.1) [0x50d5a7d]
bluetoothd[14785]: #2  g_log+0x8f (/usr/lib64/libglib-2.0.so.0.5400.1) [0x50d5bef]
bluetoothd[14785]: #3  g_source_remove+0x24 (/usr/lib64/libglib-2.0.so.0.5400.1) [0x50cd884]
bluetoothd[14785]: #4  device_remove+0xfb (src/device.c:4054) [0x4756cb]
bluetoothd[14785]: #5  adapter_remove+0x4a (src/adapter.c:5485) [0x45e0ea]
bluetoothd[14785]: #6  adapter_cleanup+0x2b (src/adapter.c:8681) [0x466abb]
bluetoothd[14785]: #7  main+0x867 (src/main.c:784) [0x40bdc7]
bluetoothd[14785]: #8  __libc_start_main+0xe7 (../csu/libc-start.c:340) [0x5d12187]
bluetoothd[14785]: #9  _start+0x2a (/home/hadess/Projects/jhbuild/bluez/src/bluetoothd) [0x40c5ca]
bluetoothd[14785]: +++++++++++++++++++++++++++
---
 src/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index f01c8a137..e8409caf9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4050,7 +4050,8 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	device->pending = NULL;
 
 	if (btd_device_is_connected(device)) {
-		g_source_remove(device->disconn_timer);
+		if (device->disconn_timer > 0)
+			g_source_remove(device->disconn_timer);
 		disconnect_all(device);
 	}
 
-- 
2.14.3

