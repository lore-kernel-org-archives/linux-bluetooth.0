Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] shared/mgmt: Remove unnecessary code
Date: Thu,  4 Dec 2014 17:53:39 +0200
Message-Id: <1417708419-25772-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This flags were added because calling function like queue_foreach were
not safe as the callbacks may remove or destroy the queue before
returning but this has been fixed and it is now safe to do that.
---
 src/shared/mgmt.c | 89 +++++++------------------------------------------------
 1 file changed, 11 insertions(+), 78 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 5dae7a9..ec574c9 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -51,9 +51,6 @@ struct mgmt {
 	struct queue *notify_list;
 	unsigned int next_request_id;
 	unsigned int next_notify_id;
-	bool need_notify_cleanup;
-	bool in_notify;
-	bool destroyed;
 	void *buf;
 	uint16_t len;
 	mgmt_debug_func_t debug_callback;
@@ -76,7 +73,6 @@ struct mgmt_notify {
 	unsigned int id;
 	uint16_t event;
 	uint16_t index;
-	bool removed;
 	mgmt_notify_func_t callback;
 	mgmt_destroy_func_t destroy;
 	void *user_data;
@@ -135,22 +131,6 @@ static bool match_notify_index(const void *a, const void *b)
 	return notify->index == index;
 }
 
-static bool match_notify_removed(const void *a, const void *b)
-{
-	const struct mgmt_notify *notify = a;
-
-	return notify->removed;
-}
-
-static void mark_notify_removed(void *data , void *user_data)
-{
-	struct mgmt_notify *notify = data;
-	uint16_t index = PTR_TO_UINT(user_data);
-
-	if (notify->index == index || index == MGMT_INDEX_NONE)
-		notify->removed = true;
-}
-
 static void write_watch_destroy(void *user_data)
 {
 	struct mgmt *mgmt = user_data;
@@ -248,9 +228,6 @@ static void request_complete(struct mgmt *mgmt, uint8_t status,
 		destroy_request(request);
 	}
 
-	if (mgmt->destroyed)
-		return;
-
 	wakeup_writer(mgmt);
 }
 
@@ -266,9 +243,6 @@ static void notify_handler(void *data, void *user_data)
 	struct mgmt_notify *notify = data;
 	struct event_index *match = user_data;
 
-	if (notify->removed)
-		return;
-
 	if (notify->event != match->event)
 		return;
 
@@ -286,28 +260,7 @@ static void process_notify(struct mgmt *mgmt, uint16_t event, uint16_t index,
 	struct event_index match = { .event = event, .index = index,
 					.length = length, .param = param };
 
-	mgmt->in_notify = true;
-
 	queue_foreach(mgmt->notify_list, notify_handler, &match);
-
-	mgmt->in_notify = false;
-
-	if (mgmt->need_notify_cleanup) {
-		queue_remove_all(mgmt->notify_list, match_notify_removed,
-							NULL, destroy_notify);
-		mgmt->need_notify_cleanup = false;
-	}
-}
-
-static void read_watch_destroy(void *user_data)
-{
-	struct mgmt *mgmt = user_data;
-
-	if (mgmt->destroyed) {
-		queue_destroy(mgmt->notify_list, NULL);
-		queue_destroy(mgmt->pending_list, NULL);
-		free(mgmt);
-	}
 }
 
 static bool can_read_data(struct io *io, void *user_data)
@@ -337,6 +290,8 @@ static bool can_read_data(struct io *io, void *user_data)
 	if (bytes_read < length + MGMT_HDR_SIZE)
 		return true;
 
+	mgmt_ref(mgmt);
+
 	switch (event) {
 	case MGMT_EV_CMD_COMPLETE:
 		cc = mgmt->buf + MGMT_HDR_SIZE;
@@ -368,8 +323,7 @@ static bool can_read_data(struct io *io, void *user_data)
 		break;
 	}
 
-	if (mgmt->destroyed)
-		return false;
+	mgmt_unref(mgmt);
 
 	return true;
 }
@@ -440,8 +394,7 @@ struct mgmt *mgmt_new(int fd)
 		return NULL;
 	}
 
-	if (!io_set_read_handler(mgmt->io, can_read_data, mgmt,
-						read_watch_destroy)) {
+	if (!io_set_read_handler(mgmt->io, can_read_data, mgmt, NULL)) {
 		queue_destroy(mgmt->notify_list, NULL);
 		queue_destroy(mgmt->pending_list, NULL);
 		queue_destroy(mgmt->reply_queue, NULL);
@@ -531,14 +484,11 @@ void mgmt_unref(struct mgmt *mgmt)
 	free(mgmt->buf);
 	mgmt->buf = NULL;
 
-	if (!mgmt->in_notify) {
-		queue_destroy(mgmt->notify_list, NULL);
-		queue_destroy(mgmt->pending_list, NULL);
-		free(mgmt);
-		return;
-	}
+	queue_destroy(mgmt->notify_list, NULL);
+	queue_destroy(mgmt->pending_list, NULL);
+	free(mgmt);
 
-	mgmt->destroyed = true;
+	return;
 }
 
 bool mgmt_set_debug(struct mgmt *mgmt, mgmt_debug_func_t callback,
@@ -774,14 +724,7 @@ bool mgmt_unregister(struct mgmt *mgmt, unsigned int id)
 	if (!notify)
 		return false;
 
-	if (!mgmt->in_notify) {
-		destroy_notify(notify);
-		return true;
-	}
-
-	notify->removed = true;
-	mgmt->need_notify_cleanup = true;
-
+	destroy_notify(notify);
 	return true;
 }
 
@@ -790,12 +733,7 @@ bool mgmt_unregister_index(struct mgmt *mgmt, uint16_t index)
 	if (!mgmt)
 		return false;
 
-	if (mgmt->in_notify) {
-		queue_foreach(mgmt->notify_list, mark_notify_removed,
-							UINT_TO_PTR(index));
-		mgmt->need_notify_cleanup = true;
-	} else
-		queue_remove_all(mgmt->notify_list, match_notify_index,
+	queue_remove_all(mgmt->notify_list, match_notify_index,
 					UINT_TO_PTR(index), destroy_notify);
 
 	return true;
@@ -806,12 +744,7 @@ bool mgmt_unregister_all(struct mgmt *mgmt)
 	if (!mgmt)
 		return false;
 
-	if (mgmt->in_notify) {
-		queue_foreach(mgmt->notify_list, mark_notify_removed,
-						UINT_TO_PTR(MGMT_INDEX_NONE));
-		mgmt->need_notify_cleanup = true;
-	} else
-		queue_remove_all(mgmt->notify_list, NULL, NULL, destroy_notify);
+	queue_remove_all(mgmt->notify_list, NULL, NULL, destroy_notify);
 
 	return true;
 }
-- 
1.9.3

