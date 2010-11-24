Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 6/6] Code clean-up: lines longer 80 symbols removed
Date: Wed, 24 Nov 2010 17:07:16 +0200
Message-Id: <1290611236-25656-7-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1290611236-25656-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1290611236-25656-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/pbap.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index e0df444..9d166d9 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -263,8 +263,8 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 	if (!pbap->obj->buffer)
 		pbap->obj->buffer = g_string_new_len(buffer, bufsize);
 	else
-		pbap->obj->buffer = g_string_append_len(pbap->obj->buffer, buffer,
-								bufsize);
+		pbap->obj->buffer = g_string_append_len(pbap->obj->buffer,
+							buffer, bufsize);
 
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
@@ -423,11 +423,12 @@ static void cache_ready_notify(void *user_data)
 	for (; l && max; l = l->next, max--) {
 		const struct cache_entry *entry = l->data;
 
-		g_string_append_printf(pbap->obj->buffer, VCARD_LISTING_ELEMENT,
-						entry->handle, entry->name);
+		g_string_append_printf(pbap->obj->buffer,
+			VCARD_LISTING_ELEMENT, entry->handle, entry->name);
 	}
 
-	pbap->obj->buffer = g_string_append(pbap->obj->buffer, VCARD_LISTING_END);
+	pbap->obj->buffer = g_string_append(pbap->obj->buffer,
+							VCARD_LISTING_END);
 
 	g_slist_free(sorted);
 
-- 
1.7.0.4

