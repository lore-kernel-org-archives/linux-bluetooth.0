Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd] Fix proper data escaping for vCard listing
Date: Thu, 21 Jul 2011 15:55:07 +0200
Message-Id: <1311256507-10744-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Up until now it was possible to inject some XML or just broke returned
vCard listing by preparing contact with some special characters.
---
 plugins/pbap.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 5455cce..82963af 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -469,9 +469,12 @@ static int generate_response(void *user_data)
 	pbap->obj->buffer = g_string_new(VCARD_LISTING_BEGIN);
 	for (; l && max; l = l->next, max--) {
 		const struct cache_entry *entry = l->data;
+		char *escaped_name = g_markup_escape_text(entry->name, -1);
 
 		g_string_append_printf(pbap->obj->buffer,
-			VCARD_LISTING_ELEMENT, entry->handle, entry->name);
+			VCARD_LISTING_ELEMENT, entry->handle, escaped_name);
+
+		g_free(escaped_name);
 	}
 
 	pbap->obj->buffer = g_string_append(pbap->obj->buffer,
-- 
1.7.4.1

