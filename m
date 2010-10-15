Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not responding Not Found for filtered vcard-listing
Date: Fri, 15 Oct 2010 12:45:59 +0300
Message-Id: <1287135959-6605-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

In this case entries may be found but it still may not match the filter
criteria.
---
 plugins/pbap.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 13742da..11cb678 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -398,12 +398,6 @@ static void cache_ready_notify(void *user_data)
 		goto done;
 	}
 
-	if (pbap->cache.entries == NULL) {
-		pbap->cache.valid = TRUE;
-		obex_object_set_io_flags(pbap, G_IO_ERR, -ENOENT);
-		return;
-	}
-
 	/*
 	 * Don't free the sorted list content: this list contains
 	 * only the reference for the "real" cache entry.
@@ -412,6 +406,12 @@ static void cache_ready_notify(void *user_data)
 			pbap->params->searchattrib,
 			(const char *) pbap->params->searchval);
 
+	if (sorted == NULL) {
+		pbap->cache.valid = TRUE;
+		obex_object_set_io_flags(pbap, G_IO_ERR, -ENOENT);
+		return;
+	}
+
 	/* Computing offset considering first entry of the phonebook */
 	l = g_slist_nth(sorted, pbap->params->liststartoffset);
 
-- 
1.7.1

