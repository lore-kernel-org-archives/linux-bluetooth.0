Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/4] android/hal: Fix sending not initialised data
Date: Fri, 16 May 2014 13:00:40 +0200
Message-Id: <1400238042-16015-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1400238042-16015-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400238042-16015-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As we always send whole gatt_response_t struct through IPC,
but copy only cmd->len bytes, the rest should be initilised to 0.

This fixes the following issue:
==30585== Syscall param socketcall.sendmsg(msg.msg_iov[i]) points
to uninitialised byte(s)
==30585==    at 0x534133D: ??? (syscall-template.S:82)
==30585==    by 0x7756336: hal_ipc_cmd (hal-ipc.c:359)
==30585==    by 0x77546DF: send_response.part.0 (hal-gatt.c:1247)
==30585==    by 0x408119: gatts_send_response_p (if-gatt.c:1777)
==30585==    by 0x40219F: process_line (haltest.c:293)
==30585==    by 0x402552: terminal_action_enter (terminal.c:666)
==30585==    by 0x403184: terminal_process_char (terminal.c:781)
==30585==    by 0x401B90: stdin_handler (haltest.c:308)
==30585==    by 0x402261: poll_dispatch_loop (pollhandler.c:60)
==30585==    by 0x401870: main (haltest.c:441)
==30585==  Address 0x7fefff2a3 is on thread 1's stack
---
 android/hal-gatt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index e1faccb..93dc066 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1231,6 +1231,8 @@ static bt_status_t send_response(int conn_id, int trans_id, int status,
 	struct hal_cmd_gatt_server_send_response *cmd = (void *) buf;
 	size_t cmd_len = sizeof(*cmd) + sizeof(*response);
 
+	memset(buf, 0 , IPC_MTU);
+
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-- 
1.9.3

