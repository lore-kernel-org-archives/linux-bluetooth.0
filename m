Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 5/5] Fix freeing buffer before transfer is complete
Date: Wed, 13 Jul 2011 22:10:10 +0000
Message-Id: <1310595010-1033-5-git-send-email-bulislaw@linux.com>
In-Reply-To: <1310595010-1033-1-git-send-email-bulislaw@linux.com>
References: <1310595010-1033-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

phonebook_req_finalize is called before actual transport taking place,
so buffers kept in user_data may cause invalid reads in valgrind and
prevent transport being completed.
---
 plugins/phonebook-ebook.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 06ae1ec..4a14eca 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -208,9 +208,15 @@ done:
 	DBG("collected %d vcards", count);
 
 	data->queued_calls--;
-	if (data->queued_calls == 0)
-		data->contacts_cb(data->buf->str, data->buf->len, data->count,
+	if (data->queued_calls == 0) {
+		GString *buf = data->buf;
+		data->buf = NULL;
+
+		data->contacts_cb(buf->str, buf->len, data->count,
 						0, TRUE, data->user_data);
+
+		g_string_free(buf, TRUE);
+	}
 }
 
 static void ebook_entry_cb(EBook *book, const GError *gerr,
-- 
1.7.5.3

