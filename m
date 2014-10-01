Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] shared/gatt-client: Fix crash on bt_gatt_client_unref
Date: Wed,  1 Oct 2014 14:38:14 +0300
Message-Id: <1412163494-20283-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412163494-20283-1-git-send-email-luiz.dentz@gmail.com>
References: <1412163494-20283-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Calling gatt_client_clear_services after notify_list is destroyed cause
the following backtrace:

Invalid read of size 8
   at 0x404CC9: queue_remove_all (queue.c:312)
   by 0x401FC6: gatt_client_remove_all_notify_in_range (gatt-client.c:350)
   by 0x403170: bt_gatt_client_free (gatt-client.c:357)
   by 0x401A93: test_client (test-gatt.c:224)
   by 0x4E9E5E0: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9EB1A: g_test_run_suite (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4015EE: main (test-gatt.c:259)
 Address 0x5752718 is 8 bytes inside a block of size 32 free'd
   at 0x4C28577: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x40315E: bt_gatt_client_free (gatt-client.c:1233)
   by 0x401A93: test_client (test-gatt.c:224)
   by 0x4E9E5E0: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9EB1A: g_test_run_suite (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4015EE: main (test-gatt.c:259)
---
 src/shared/gatt-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index d884185..832b09b 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1228,12 +1228,12 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 		bt_att_unref(client->att);
 	}
 
+	gatt_client_clear_services(client);
+
 	queue_destroy(client->svc_chngd_queue, free);
 	queue_destroy(client->long_write_queue, long_write_op_unref);
 	queue_destroy(client->notify_list, notify_data_unref);
 
-	gatt_client_clear_services(client);
-
 	free(client);
 }
 
-- 
1.9.3

