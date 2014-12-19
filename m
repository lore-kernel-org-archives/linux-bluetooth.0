Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] src/att: Fix usage of memory after it is freed.
Date: Fri, 19 Dec 2014 19:31:28 +0530
Message-id: <1418997688-16691-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

warning: Use of memory after it is freed
	respond_not_supported(att, opcode);
	^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 src/shared/att.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 4be0652..a98909e 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -692,14 +692,14 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 
 	queue_foreach(att->notify_list, notify_handler, &data);
 
-	bt_att_unref(att);
-
 	/*
 	 * If this was a request and no handler was registered for it, respond
 	 * with "Not Supported"
 	 */
 	if (!data.handler_found && get_op_type(opcode) == ATT_OP_TYPE_REQ)
 		respond_not_supported(att, opcode);
+
+	bt_att_unref(att);
 }
 
 static bool can_read_data(struct io *io, void *user_data)
-- 
1.9.1

