Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] Fix compiler warning
Date: Mon, 18 Jul 2011 13:29:06 +0200
Message-Id: <1310988546-8187-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gobex/gobex.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 93be21f..173912f 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -643,8 +643,8 @@ static void handle_request(GObex *obex, GObexPacket *req)
 
 	op = g_obex_packet_get_operation(req, NULL);
 
-	match = g_slist_find_custom(obex->req_handlers, GUINT_TO_POINTER(op),
-							req_handler_cmpop);
+	match = g_slist_find_custom(obex->req_handlers,
+			GUINT_TO_POINTER((guint)op), req_handler_cmpop);
 	if (match) {
 		struct req_handler *handler = match->data;
 		handler->func(obex, req, handler->user_data);
-- 
1.7.4.1

