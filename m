Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v4 2/3] MAP/dummy: Code for returning folder listing
Date: Wed, 14 Mar 2012 14:29:50 +0100
Message-Id: <1331731791-26685-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1331731791-26685-1-git-send-email-lkslawek@gmail.com>
References: <1331731791-26685-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
v4: Rename local variables: n -> num, o -> offs
    Change pre- to post-increments
 plugins/messages-dummy.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index cfb24e2..6b06e58 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -119,6 +119,28 @@ static ssize_t get_subdirs(struct folder_listing_data *fld, GSList **list)
 static void return_folder_listing(struct folder_listing_data *fld, GSList *list)
 {
 	struct session *session = fld->session;
+	GSList *cur;
+	uint16_t num = 0;
+	uint16_t offs = 0;
+
+	/* XXX: This isn't really documented for MAP. I need to take a look how
+	 * other implementations choose to deal with parent folder.
+	 */
+	if (session->cwd[0] != 0 && fld->offset == 0) {
+		num++;
+		fld->callback(session, -EAGAIN, 0, "..", fld->user_data);
+	} else {
+		offs++;
+	}
+
+	for (cur = list; offs < fld->offset; offs++) {
+		cur = cur->next;
+		if (cur == NULL)
+			break;
+	}
+
+	for (; cur != NULL && num < fld->max; cur = cur->next, num++)
+		fld->callback(session, -EAGAIN, 0, cur->data, fld->user_data);
 
 	fld->callback(session, 0, 0, NULL, fld->user_data);
 }
-- 
1.7.4.1

