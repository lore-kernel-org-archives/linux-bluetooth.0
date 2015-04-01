Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix invalid read on TP/GAW/CL/BV-05-C
Date: Wed,  1 Apr 2015 15:04:40 +0300
Message-Id: <1427889880-9976-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes TP/GAW/CL/BV-05-C which destroy bt_gatt_client instance on
the called producing the following bracktrace:

   at 0x445C7C: start_next_long_write.isra.2 (gatt-client.c:2393)
   by 0x4462A8: execute_write_cb (gatt-client.c:2429)
   by 0x44099B: handle_rsp (att.c:640)
   by 0x44099B: can_read_data (att.c:813)
   by 0x44E4BA: watch_callback (io-glib.c:170)
   by 0x4E7E7FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EB97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EEC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x43E791: tester_run (tester.c:831)
   by 0x43A685: main (test-gatt.c:3935)
 Address 0x5b12fd8 is 104 bytes inside a block of size 208 free'd
   at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x446820: bt_gatt_client_unref (gatt-client.c:1694)
   by 0x43AB7C: destroy_context (test-gatt.c:342)
   by 0x43AB7C: context_quit (test-gatt.c:370)
   by 0x43AD0F: test_long_write_cb (test-gatt.c:1029)
   by 0x446290: execute_write_cb (gatt-client.c:2426)
   by 0x44099B: handle_rsp (att.c:640)
   by 0x44099B: can_read_data (att.c:813)
   by 0x44E4BA: watch_callback (io-glib.c:170)
   by 0x4E7E7FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EB97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EEC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x43E791: tester_run (tester.c:831)
   by 0x43A685: main (test-gatt.c:3935)
---
 src/shared/gatt-client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 056f812..df994d7 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2422,11 +2422,15 @@ static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	} else if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
 		success = false;
 
+	bt_gatt_client_ref(op->client);
+
 	if (op->callback)
 		op->callback(success, op->reliable_error, att_ecode,
 								op->user_data);
 
 	start_next_long_write(op->client);
+
+	bt_gatt_client_unref(op->client);
 }
 
 static void complete_write_long_op(struct request *req, bool success,
-- 
2.1.0

