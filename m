Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: nsathish41@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ 1/2] obexd/map: Do not send parent folder in dummy
Date: Fri,  9 Jun 2017 10:53:27 +0530
Message-Id: <1496985808-17492-1-git-send-email-nsathish41@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sathish Narasimman <sathish.narasimman@intel.com>

In messages-dummy it is not necessary to add parent folder in the
response to folder-lisintg. when tested with some carkit the present
method is not working when navigating to different folders. so removing
it.
---
 obexd/plugins/messages-dummy.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index 765f08d..33056e2 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -155,16 +155,6 @@ static void return_folder_listing(struct folder_listing_data *fld, GSList *list)
 	uint16_t num = 0;
 	uint16_t offs = 0;
 
-	/* XXX: This isn't really documented for MAP. I need to take a look how
-	 * other implementations choose to deal with parent folder.
-	 */
-	if (session->cwd[0] != 0 && fld->offset == 0) {
-		num++;
-		fld->callback(session, -EAGAIN, 0, "..", fld->user_data);
-	} else {
-		offs++;
-	}
-
 	for (cur = list; offs < fld->offset; offs++) {
 		cur = cur->next;
 		if (cur == NULL)
-- 
2.7.4

