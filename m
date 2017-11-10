Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] device: Fix possible run-time warning
Date: Fri, 10 Nov 2017 06:23:29 +0100
Message-Id: <20171110052329.477-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a reconnect timeout has previously run for a device, setting a new
one will throw a warning as the timeout id is not reset when the timeout
is cancelled from within its callback.

bluetoothd[7731]: GLib: Source ID 526 was not found when attempting to remove it
bluetoothd[7731]: ++++++++ backtrace ++++++++
bluetoothd[7731]: #1  g_logv+0x25d (/usr/lib64/libglib-2.0.so.0.5400.1) [0x50d5a7d]
bluetoothd[7731]: #2  g_log+0x8f (/usr/lib64/libglib-2.0.so.0.5400.1) [0x50d5bef]
bluetoothd[7731]: #3  g_source_remove+0x7c (/usr/lib64/libglib-2.0.so.0.5400.1) [0x50cd8dc]
bluetoothd[7731]: #4  intr_watch_cb+0x1b5 (profiles/input/device.c:1217) [0x42f465]
bluetoothd[7731]: #5  g_main_context_dispatch+0x157 (/usr/lib64/libglib-2.0.so.0.5400.1) [0x50cebb7]
bluetoothd[7731]: #6  g_main_context_iterate.isra.25+0x200 (/usr/lib64/libglib-2.0.so.0.5400.1) [0x50cef60]
bluetoothd[7731]: #7  g_main_loop_run+0xc2 (/usr/lib64/libglib-2.0.so.0.5400.1) [0x50cf272]
bluetoothd[7731]: #8  main+0x839 (src/main.c:772) [0x40bd69]
bluetoothd[7731]: #9  __libc_start_main+0xe7 (../csu/libc-start.c:340) [0x5d12187]
bluetoothd[7731]: #10 _start+0x2a (/home/hadess/Projects/jhbuild/bluez/src/bluetoothd) [0x40c59a]
bluetoothd[7731]: +++++++++++++++++++++++++++
---
 profiles/input/device.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index a494ea2e3..d66c41ab0 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1163,23 +1163,27 @@ static gboolean input_device_auto_reconnect(gpointer user_data)
 	 */
 	if (device_is_temporary(idev->device) ||
 					btd_device_is_connected(idev->device))
-		return FALSE;
+		goto bail;
 
 	/* Only attempt an auto-reconnect for at most 3 minutes (6 * 30s). */
 	if (idev->reconnect_attempt >= 6)
-		return FALSE;
+		goto bail;
 
 	/* Check if the profile is already connected. */
 	if (idev->ctrl_io)
-		return FALSE;
+		goto bail;
 
 	if (is_connected(idev))
-		return FALSE;
+		goto bail;
 
 	idev->reconnect_attempt++;
 	dev_connect(idev);
 
 	return TRUE;
+
+bail:
+	idev->reconnect_timer = 0;
+	return FALSE;
 }
 
 static const char * const _reconnect_mode_str[] = {
-- 
2.14.3

