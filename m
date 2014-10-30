Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/att: Fix another memory leak
Date: Thu, 30 Oct 2014 17:36:33 +0200
Message-Id: <1414683393-26703-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414683393-26703-1-git-send-email-luiz.dentz@gmail.com>
References: <1414683393-26703-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Before resetting destroy callback to NULL it needs to be called so the
user_data can be properly freed:

104 (40 direct, 64 indirect) bytes in 1 blocks are definitely lost in loss record 47 of 55
   at 0x4C291D4: calloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x408359: bt_gatt_exchange_mtu (gatt-helpers.c:479)
   by 0x405345: bt_gatt_client_new (gatt-client.c:1196)
   by 0x401A4B: test_client (test-gatt.c:198)
   by 0x4E9E5E0: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9EB1A: g_test_run_suite (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x40162E: main (test-gatt.c:265)
---
 src/shared/att.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 715c968..e2a50be 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1083,13 +1083,21 @@ bool bt_att_cancel_all(struct bt_att *att)
 	if (att->pending_req) {
 		/* Don't cancel the pending request; remove it's handlers */
 		att->pending_req->callback = NULL;
-		att->pending_req->destroy = NULL;
+		/* Destroy the user_data since it is no longer useful */
+		if (att->pending_req->destroy) {
+			att->pending_req->destroy(att->pending_req->user_data);
+			att->pending_req->destroy = NULL;
+		}
 	}
 
 	if (att->pending_ind) {
 		/* Don't cancel the pending indication; remove it's handlers */
 		att->pending_ind->callback = NULL;
-		att->pending_ind->destroy = NULL;
+		/* Destroy the user_data since it is no longer useful */
+		if (att->pending_ind->destroy) {
+			att->pending_ind->destroy(att->pending_ind->user_data);
+			att->pending_ind->destroy = NULL;
+		}
 	}
 
 	return true;
-- 
1.9.3

