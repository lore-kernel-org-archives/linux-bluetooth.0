Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 4/5] MAP/dummy: Code for returning folder listing
Date: Tue,  6 Mar 2012 18:42:27 +0100
Message-Id: <1331055748-14212-4-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1331055748-14212-1-git-send-email-lkslawek@gmail.com>
References: <1331055748-14212-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-dummy.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index daa7ae4..b98bedc 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -117,6 +117,28 @@ static ssize_t get_subdirs(struct folder_listing_data *fld, GSList **list)
 static void return_folder_listing(struct folder_listing_data *fld, GSList *list)
 {
 	struct session *session = fld->session;
+	GSList *cur;
+	uint16_t n = 0;
+	uint16_t o = 0;
+
+	/* XXX: This isn't really documented for MAP. I need to take a look how
+	 * other implementations choose to deal with parent folder.
+	 */
+	if (session->cwd[0] != 0 && fld->offset == 0) {
+		++n;
+		fld->callback(session, -EAGAIN, 0, "..", fld->user_data);
+	} else {
+		++o;
+	}
+
+	for (cur = list; o < fld->offset; ++o) {
+		cur = cur->next;
+		if (cur == NULL)
+			break;
+	}
+
+	for (; cur != NULL && n < fld->max; cur = cur->next, ++n)
+		fld->callback(session, -EAGAIN, 0, cur->data, fld->user_data);
 
 	fld->callback(session, 0, 0, NULL, fld->user_data);
 }
-- 
1.7.5.1

