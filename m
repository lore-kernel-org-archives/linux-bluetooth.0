Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] avrcp: Fix wrong pointer check
Date: Fri, 31 Jan 2014 10:33:42 +0200
Message-Id: <1391157222-24504-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

There is wrong assumption that handler might be NULL while it is a
pointer to a struct table so check instead for struct members. This
fixes accessing wrong memory.
---
 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index df88138..5030ce1 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1673,7 +1673,7 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 			break;
 	}
 
-	if (!handler || handler->code != *code) {
+	if (!handler->code || handler->code != *code) {
 		pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
 		goto err_metadata;
 	}
@@ -1737,7 +1737,7 @@ static size_t handle_browsing_pdu(struct avctp *conn,
 			break;
 	}
 
-	if (handler == NULL || handler->func == NULL)
+	if (!handler->func)
 		return avrcp_browsing_general_reject(operands);
 
 	session->transaction = transaction;
-- 
1.8.3.2

