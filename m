Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 4/4] Code clean-up: unused and unnecessary code removed
Date: Fri, 31 Dec 2010 09:45:02 +0200
Message-Id: <1293781502-2709-5-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1293781502-2709-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1293781502-2709-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

destroy function is not used anymore and therefore removed pending_reply.
obj->request = NULL is removed from vobject_close as unnecessary.
---
 plugins/pbap.c              |    4 +---
 plugins/phonebook-tracker.c |   18 +++++-------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index aa3e4dd..b351764 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -829,10 +829,8 @@ static int vobject_close(void *object)
 	if (obj->aparams)
 		g_byte_array_free(obj->aparams, TRUE);
 
-	if (obj->request) {
+	if (obj->request)
 		phonebook_req_finalize(obj->request);
-		obj->request = NULL;
-	}
 
 	g_free(obj);
 
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index a6a2e47..a5cd8a7 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -961,7 +961,6 @@ struct pending_reply {
 	reply_list_foreach_t callback;
 	void *user_data;
 	int num_fields;
-	GDestroyNotify destroy;
 };
 
 struct contact_data {
@@ -1158,15 +1157,11 @@ static void query_free_data(void *user_data)
 	if (!pending)
 		return;
 
-	if (pending->destroy)
-		pending->destroy(pending->user_data);
-
 	g_free(pending);
 }
 
 static DBusPendingCall *query_tracker(const char *query, int num_fields,
-				reply_list_foreach_t callback, void *user_data,
-				GDestroyNotify destroy, int *err)
+		reply_list_foreach_t callback, void *user_data, int *err)
 {
 	struct pending_reply *pending;
 	DBusPendingCall *call;
@@ -1195,7 +1190,6 @@ static DBusPendingCall *query_tracker(const char *query, int num_fields,
 	pending->callback = callback;
 	pending->user_data = user_data;
 	pending->num_fields = num_fields;
-	pending->destroy = destroy;
 
 	dbus_pending_call_set_notify(call, query_reply, pending,
 							query_free_data);
@@ -1938,8 +1932,7 @@ done:
 	}
 
 	dbus_pending_call_unref(data->call);
-	data->call = query_tracker(query, col_amount, pull_cb, data, NULL,
-								&err);
+	data->call = query_tracker(query, col_amount, pull_cb, data, &err);
 	if (err < 0)
 		data->cb(NULL, 0, err, 0, data->user_data);
 }
@@ -1978,8 +1971,7 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	data->params = params;
 	data->user_data = user_data;
 	data->cb = cb;
-	data->call = query_tracker(query, col_amount, pull_cb, data, NULL,
-									err);
+	data->call = query_tracker(query, col_amount, pull_cb, data, err);
 
 	return data;
 }
@@ -2008,7 +2000,7 @@ void *phonebook_get_entry(const char *folder, const char *id,
 								id, id, id);
 
 	data->call = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts,
-							data, NULL, err);
+								data, err);
 
 	g_free(query);
 
@@ -2034,7 +2026,7 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	data->entry_cb = entry_cb;
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
-	data->call = query_tracker(query, 7, add_to_cache, data, NULL, err);
+	data->call = query_tracker(query, 7, add_to_cache, data, err);
 
 	return data;
 }
-- 
1.7.0.4

