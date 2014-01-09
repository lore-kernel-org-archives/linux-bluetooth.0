Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] shared: Fix memory leaks in mgmt_unref
Date: Thu,  9 Jan 2014 15:17:10 +0100
Message-Id: <1389277030-2131-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Destroy notify and pending lists on freeing mgmt. Those two lists
cannot be destroyed in same place as reply and request queues due
to being used in can_read_data().

Fix following valgrind reports:

24 bytes in 1 blocks are definitely lost in loss record 70 of 212
   at 0x4C2C494: calloc (in /usr/lib/valgrind/
       vgpreload_memcheck-amd64-linux.so)
   by 0x46B5E2: queue_new (queue.c:46)
   by 0x46C3CA: mgmt_new (mgmt.c:407)
   by 0x46C4B5: mgmt_new_default (mgmt.c:466)
   by 0x45FB45: adapter_init (adapter.c:6237)
   by 0x40A4F1: main (main.c:534)

24 bytes in 1 blocks are definitely lost in loss record 71 of 212
   at 0x4C2C494: calloc (in /usr/lib/
       valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x46B5E2: queue_new (queue.c:46)
   by 0x46C3D8: mgmt_new (mgmt.c:417)
   by 0x46C4B5: mgmt_new_default (mgmt.c:466)
   by 0x45FB45: adapter_init (adapter.c:6237)
   by 0x40A4F1: main (main.c:534)
---
 src/shared/mgmt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 2a2c2a3..b663d3a 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -291,8 +291,11 @@ static void read_watch_destroy(void *user_data)
 {
 	struct mgmt *mgmt = user_data;
 
-	if (mgmt->destroyed)
+	if (mgmt->destroyed) {
+		queue_destroy(mgmt->notify_list, NULL);
+		queue_destroy(mgmt->pending_list, NULL);
 		free(mgmt);
+	}
 }
 
 static bool can_read_data(struct io *io, void *user_data)
@@ -514,6 +517,8 @@ void mgmt_unref(struct mgmt *mgmt)
 	mgmt->buf = NULL;
 
 	if (!mgmt->in_notify) {
+		queue_destroy(mgmt->notify_list, NULL);
+		queue_destroy(mgmt->pending_list, NULL);
 		free(mgmt);
 		return;
 	}
-- 
1.8.3.2

