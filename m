Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 3/3 v4] Code clean-up: long, empty lines, indentation
Date: Thu,  9 Dec 2010 12:05:19 +0200
Message-Id: <1291889119-23915-4-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1291889119-23915-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1291889119-23915-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lines longer 80 symbols and empty lines removed. Indentation in
generate_response function corrected.
---
 plugins/pbap.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 820e35c..3ebfbe8 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -273,8 +273,8 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 	if (!pbap->obj->buffer)
 		pbap->obj->buffer = g_string_new_len(buffer, bufsize);
 	else
-		pbap->obj->buffer = g_string_append_len(pbap->obj->buffer, buffer,
-								bufsize);
+		pbap->obj->buffer = g_string_append_len(pbap->obj->buffer,
+							buffer,	bufsize);
 
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
@@ -418,9 +418,8 @@ static int generate_response(void *user_data)
 	 * only the reference for the "real" cache entry.
 	 */
 	sorted = sort_entries(pbap->cache.entries, pbap->params->order,
-			pbap->params->searchattrib,
-			(const char *) pbap->params->searchval);
-
+				pbap->params->searchattrib,
+				(const char *) pbap->params->searchval);
 	if (sorted == NULL)
 		return -ENOENT;
 
@@ -431,12 +430,12 @@ static int generate_response(void *user_data)
 	for (; l && max; l = l->next, max--) {
 		const struct cache_entry *entry = l->data;
 
-		g_string_append_printf(pbap->obj->buffer, VCARD_LISTING_ELEMENT,
-						entry->handle, entry->name);
+		g_string_append_printf(pbap->obj->buffer,
+			VCARD_LISTING_ELEMENT, entry->handle, entry->name);
 	}
 
-	pbap->obj->buffer = g_string_append(pbap->obj->buffer, VCARD_LISTING_END);
-
+	pbap->obj->buffer = g_string_append(pbap->obj->buffer,
+							VCARD_LISTING_END);
 	g_slist_free(sorted);
 
 	return 0;
-- 
1.7.0.4

