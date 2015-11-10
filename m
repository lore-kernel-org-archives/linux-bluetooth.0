Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/mgmt: Fix crash when removing index
Date: Tue, 10 Nov 2015 11:32:38 +0200
Message-Id: <1447147958-23378-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Because queue entries are no longer protected by a reference it is
necessary to return the use of in_notify flag, etc, otherwise the
following crash can happen when removing an index:

Invalid read of size 8
   at 0x41AD6F: queue_foreach (queue.c:219)
   by 0x41CA6C: process_notify (mgmt.c:280)
   by 0x41CA6C: can_read_data (mgmt.c:338)
   by 0x422DCA: watch_callback (io-glib.c:170)
   by 0x4E7EA89: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4400.1)
   by 0x4E7EE1F: ??? (in /usr/lib64/libglib-2.0.so.0.4400.1)
   by 0x4E7F141: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4400.1)
   by 0x422A31: tester_run (tester.c:830)
   by 0x403013: main (l2cap-tester.c:1489)
 Address 0x5754b38 is 8 bytes inside a block of size 16 free'd
   at 0x4C29D6A: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x41AFCF: queue_remove_if (queue.c:302)
   by 0x41B0BA: queue_remove_all (queue.c:331)
   by 0x41C6A2: mgmt_unregister_index (mgmt.c:737)
   by 0x405033: index_removed_callback (l2cap-tester.c:162)
   by 0x41B751: notify_handler (mgmt.c:270)
   by 0x41AD83: queue_foreach (queue.c:220)
   by 0x41CA6C: process_notify (mgmt.c:280)
   by 0x41CA6C: can_read_data (mgmt.c:338)
   by 0x422DCA: watch_callback (io-glib.c:170)
   by 0x4E7EA89: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4400.1)
   by 0x4E7EE1F: ??? (in /usr/lib64/libglib-2.0.so.0.4400.1)
   by 0x4E7F141: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4400.1)
---
 src/shared/mgmt.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 5e03a51..277e361 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -51,6 +51,8 @@ struct mgmt {
 	struct queue *notify_list;
 	unsigned int next_request_id;
 	unsigned int next_notify_id;
+	bool need_notify_cleanup;
+	bool in_notify;
 	void *buf;
 	uint16_t len;
 	mgmt_debug_func_t debug_callback;
@@ -73,6 +75,7 @@ struct mgmt_notify {
 	unsigned int id;
 	uint16_t event;
 	uint16_t index;
+	bool removed;
 	mgmt_notify_func_t callback;
 	mgmt_destroy_func_t destroy;
 	void *user_data;
@@ -131,6 +134,22 @@ static bool match_notify_index(const void *a, const void *b)
 	return notify->index == index;
 }
 
+static bool match_notify_removed(const void *a, const void *b)
+{
+	const struct mgmt_notify *notify = a;
+
+	return notify->removed;
+}
+
+static void mark_notify_removed(void *data , void *user_data)
+{
+	struct mgmt_notify *notify = data;
+	uint16_t index = PTR_TO_UINT(user_data);
+
+	if (notify->index == index || index == MGMT_INDEX_NONE)
+		notify->removed = true;
+}
+
 static void write_watch_destroy(void *user_data)
 {
 	struct mgmt *mgmt = user_data;
@@ -260,6 +279,9 @@ static void notify_handler(void *data, void *user_data)
 	struct mgmt_notify *notify = data;
 	struct event_index *match = user_data;
 
+	if (notify->removed)
+		return;
+
 	if (notify->event != match->event)
 		return;
 
@@ -277,7 +299,17 @@ static void process_notify(struct mgmt *mgmt, uint16_t event, uint16_t index,
 	struct event_index match = { .event = event, .index = index,
 					.length = length, .param = param };
 
+	mgmt->in_notify = true;
+
 	queue_foreach(mgmt->notify_list, notify_handler, &match);
+
+	mgmt->in_notify = false;
+
+	if (mgmt->need_notify_cleanup) {
+		queue_remove_all(mgmt->notify_list, match_notify_removed,
+							NULL, destroy_notify);
+		mgmt->need_notify_cleanup = false;
+	}
 }
 
 static bool can_read_data(struct io *io, void *user_data)
@@ -465,11 +497,12 @@ void mgmt_unref(struct mgmt *mgmt)
 	free(mgmt->buf);
 	mgmt->buf = NULL;
 
-	queue_destroy(mgmt->notify_list, NULL);
-	queue_destroy(mgmt->pending_list, NULL);
-	free(mgmt);
-
-	return;
+	if (!mgmt->in_notify) {
+		queue_destroy(mgmt->notify_list, NULL);
+		queue_destroy(mgmt->pending_list, NULL);
+		free(mgmt);
+		return;
+	}
 }
 
 bool mgmt_set_debug(struct mgmt *mgmt, mgmt_debug_func_t callback,
@@ -725,7 +758,14 @@ bool mgmt_unregister(struct mgmt *mgmt, unsigned int id)
 	if (!notify)
 		return false;
 
-	destroy_notify(notify);
+	if (!mgmt->in_notify) {
+		destroy_notify(notify);
+		return true;
+	}
+
+	notify->removed = true;
+	mgmt->need_notify_cleanup = true;
+
 	return true;
 }
 
@@ -734,7 +774,12 @@ bool mgmt_unregister_index(struct mgmt *mgmt, uint16_t index)
 	if (!mgmt)
 		return false;
 
-	queue_remove_all(mgmt->notify_list, match_notify_index,
+	if (mgmt->in_notify) {
+		queue_foreach(mgmt->notify_list, mark_notify_removed,
+							UINT_TO_PTR(index));
+		mgmt->need_notify_cleanup = true;
+	} else
+		queue_remove_all(mgmt->notify_list, match_notify_index,
 					UINT_TO_PTR(index), destroy_notify);
 
 	return true;
@@ -745,7 +790,12 @@ bool mgmt_unregister_all(struct mgmt *mgmt)
 	if (!mgmt)
 		return false;
 
-	queue_remove_all(mgmt->notify_list, NULL, NULL, destroy_notify);
+	if (mgmt->in_notify) {
+		queue_foreach(mgmt->notify_list, mark_notify_removed,
+						UINT_TO_PTR(MGMT_INDEX_NONE));
+		mgmt->need_notify_cleanup = true;
+	} else
+		queue_remove_all(mgmt->notify_list, NULL, NULL, destroy_notify);
 
 	return true;
 }
-- 
2.4.3

