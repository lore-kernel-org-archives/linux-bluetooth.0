Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android: Fix sending uninitialised data
Date: Mon, 26 May 2014 09:32:43 +0200
Message-Id: <1401089563-9932-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401089563-9932-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401089563-9932-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the following:

==25759== Syscall param socketcall.sendmsg(msg.msg_iov[i]) points to
uninitialised byte(s)
==25759==    at 0x521C570: __sendmsg_nocancel (syscall-template.S:82)
==25759==    by 0x41688F: ipc_send (ipc.c:366)
==25759==    by 0x40ECF8: send_ssp_request (bluetooth.c:1028)
==25759==    by 0x4110A6: user_confirm_request_callback
(bluetooth.c:1055)
==25759==    by 0x4094FE: queue_foreach (queue.c:186)
==25759==    by 0x409FCF: can_read_data (mgmt.c:287)
==25759==    by 0x408E4C: read_callback (io-glib.c:168)
==25759==    by 0x4E79D12: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
==25759==    by 0x4E7A05F: ??? (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
==25759==    by 0x4E7A459: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
==25759==    by 0x40454D: main (main.c:538)
==25759==  Address 0x7ff00085d is on thread 1's stack
==25759==  Uninitialised value was created by a stack allocation
==25759==    at 0x40EC77: send_ssp_request (bluetooth.c:1018)
---
 android/bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 93b9cd7..85409a3 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1018,6 +1018,8 @@ static void send_ssp_request(struct device *dev, uint8_t variant,
 {
 	struct hal_ev_ssp_request ev;
 
+	memset(&ev, 0, sizeof(ev));
+
 	bdaddr2android(&dev->bdaddr, ev.bdaddr);
 	memcpy(ev.name, dev->name, strlen(dev->name));
 	ev.class_of_dev = dev->class;
-- 
1.9.3

