Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] input: Fix crash when receiving event from uHID
Date: Mon, 18 Aug 2014 11:14:20 +0300
Message-Id: <1408349660-31890-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

uHID device is created only once so it is possible that the kernel send
events when there is no connection causing the following crash:

Invalid read of size 4
   at 0x4EBC650: g_io_channel_unix_get_fd (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x42C56A: hidp_send_message (device.c:160)
   by 0x46EF1C: queue_foreach (queue.c:206)
   by 0x42E3B0: uhid_read_handler (uhid.c:98)
   by 0x46E82C: read_callback (io-glib.c:168)
   by 0x4E7A2A5: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E7A627: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E7AA39: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x40A972: main (main.c:607)
 Address 0x70 is not stack'd, malloc'd or (recently) free'd
---
 profiles/input/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6b5a290..cfa5e23 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -149,6 +149,11 @@ static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
 	ssize_t len;
 	uint8_t msg[size + 1];
 
+	if (!chan) {
+		error("BT socket not connected");
+		return false;
+	}
+
 	if (data == NULL)
 		size = 0;
 
-- 
1.9.3

