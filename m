Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 5/5 v2] Add proper finishing/canceling requests
Date: Tue,  5 Jul 2011 22:53:22 +0200
Message-Id: <1309899202-23849-5-git-send-email-bulislaw@linux.com>
In-Reply-To: <1309899202-23849-1-git-send-email-bulislaw@linux.com>
References: <1309899202-23849-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/phonebook-ebook.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 181585a..b51d34d 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -517,9 +517,17 @@ done:
 void phonebook_req_finalize(void *request)
 {
 	struct query_context *data = request;
+	GSList *ebook = ebooks;
 
 	DBG("");
 
+	while (ebook != NULL) {
+		if (e_book_cancel(ebook->data, NULL) == TRUE)
+			data->queued_calls--;
+
+		ebook = ebook->next;
+	}
+
 	if (data != NULL && data->queued_calls == 0)
 		free_query_context(data);
 }
-- 
1.7.5.3

