Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH bluez] sdptool: fix recursive search
Date: Mon, 18 Mar 2013 18:41:02 +0100
Message-Id: <1363628462-3421-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

When doing recursive SDP searches, we must not overwrite our own values
after we retrieved them from SDP. Otherwise, the UUID test will always we
false.
---
 tools/sdptool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 458d005..0a949f2 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -3812,9 +3812,10 @@ static int do_search(bdaddr_t *bdaddr, struct search_context *context)
 			break;
 		}
 
+		/* Set the subcontext for browsing the sub tree */
+		memcpy(&sub_context, context, sizeof(struct search_context));
+
 		if (sdp_get_group_id(rec, &sub_context.group) != -1) {
-			/* Set the subcontext for browsing the sub tree */
-			memcpy(&sub_context, context, sizeof(struct search_context));
 			/* Browse the next level down if not done */
 			if (sub_context.group.value.uuid16 != context->group.value.uuid16)
 				do_search(bdaddr, &sub_context);
-- 
1.8.2
