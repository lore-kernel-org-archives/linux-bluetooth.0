Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/4] Merge phonebook_data and cache_data
Date: Fri, 31 Dec 2010 09:44:59 +0200
Message-Id: <1293781502-2709-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1293781502-2709-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1293781502-2709-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

phonebook_data and cache_data are merged in phonebook-tracker.c.
Single structure is used in successive patches to keep reference
to pending DBus call.
---
 plugins/phonebook-tracker.c |   32 +++++++++++++-------------------
 1 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index b7acead..cc4b49f 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -941,14 +941,8 @@ struct phonebook_data {
 	gboolean vcardentry;
 	const struct apparam_field *params;
 	GSList *contacts;
-};
-
-struct cache_data {
 	phonebook_cache_ready_cb ready_cb;
 	phonebook_entry_cb entry_cb;
-	void *user_data;
-	GString *listing;
-	int index;
 };
 
 struct phonebook_index {
@@ -1706,7 +1700,7 @@ fail:
 
 static void add_to_cache(char **reply, int num_fields, void *user_data)
 {
-	struct cache_data *cache = user_data;
+	struct phonebook_data *data = user_data;
 	char *formatted;
 	int i;
 
@@ -1732,11 +1726,11 @@ static void add_to_cache(char **reply, int num_fields, void *user_data)
 
 	/* The owner vCard must have the 0 handle */
 	if (strcmp(reply[0], TRACKER_DEFAULT_CONTACT_ME) == 0)
-		cache->entry_cb(reply[0], 0, formatted, "",
-						reply[6], cache->user_data);
+		data->entry_cb(reply[0], 0, formatted, "",
+						reply[6], data->user_data);
 	else
-		cache->entry_cb(reply[0], PHONEBOOK_INVALID_HANDLE, formatted,
-					"", reply[6], cache->user_data);
+		data->entry_cb(reply[0], PHONEBOOK_INVALID_HANDLE, formatted,
+					"", reply[6], data->user_data);
 
 	g_free(formatted);
 
@@ -1744,10 +1738,10 @@ static void add_to_cache(char **reply, int num_fields, void *user_data)
 
 done:
 	if (num_fields <= 0)
-		cache->ready_cb(cache->user_data);
+		data->ready_cb(data->user_data);
 
 	/*
-	 * cache is freed in query_free_data after call is unreffed.
+	 * data is freed in query_free_data after call is unreffed.
 	 * It is accessible by pointer from data (pending) associated to call.
 	 * Useful in cases when call was terminated.
 	 */
@@ -1919,7 +1913,7 @@ void *phonebook_get_entry(const char *folder, const char *id,
 void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 		phonebook_cache_ready_cb ready_cb, void *user_data, int *err)
 {
-	struct cache_data *cache;
+	struct phonebook_data *data;
 	const char *query;
 
 	DBG("name %s", name);
@@ -1931,10 +1925,10 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 		return NULL;
 	}
 
-	cache = g_new0(struct cache_data, 1);
-	cache->entry_cb = entry_cb;
-	cache->ready_cb = ready_cb;
-	cache->user_data = user_data;
+	data = g_new0(struct phonebook_data, 1);
+	data->entry_cb = entry_cb;
+	data->ready_cb = ready_cb;
+	data->user_data = user_data;
 
-	return query_tracker(query, 7, add_to_cache, cache, g_free, err);
+	return query_tracker(query, 7, add_to_cache, data, g_free, err);
 }
-- 
1.7.0.4

