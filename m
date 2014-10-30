Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/att: Fix memory leak
Date: Thu, 30 Oct 2014 17:36:32 +0200
Message-Id: <1414683393-26703-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following backtrack when running test-gatt:

104 (40 direct, 64 indirect) bytes in 1 blocks are definitely lost in loss record 58 of 63
   at 0x4C291D4: calloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x405E59: bt_gatt_exchange_mtu (gatt-helpers.c:477)
   by 0x4082D5: bt_gatt_client_new (gatt-client.c:1196)
   by 0x4030AB: create_context.constprop.4 (test-gatt.c:230)
   by 0x4032A5: test_client (test-gatt.c:320)
   by 0x4E9E5E0: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9EB1A: g_test_run_suite (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x402A41: main (test-gatt.c:452)
---
 src/shared/att.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index c70d396..715c968 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -817,6 +817,12 @@ void bt_att_unref(struct bt_att *att)
 	bt_att_unregister_all(att);
 	bt_att_cancel_all(att);
 
+	if (att->pending_req)
+		destroy_att_send_op(att->pending_req);
+
+	if (att->pending_ind)
+		destroy_att_send_op(att->pending_ind);
+
 	io_destroy(att->io);
 	att->io = NULL;
 
-- 
1.9.3

