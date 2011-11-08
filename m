Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/2] gobex: fix checking connection id for ABORT
Date: Tue,  8 Nov 2011 14:58:00 +0200
Message-Id: <1320757081-22620-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

OBEX spec state that it is optional to send a Connection Id header in an
OBEX ABORT operation.

Reported by Hendrik Sattler <post@hendrik-sattler.de>
---
 gobex/gobex.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 86e1c4a..b0f3716 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -705,9 +705,16 @@ static void handle_request(GObex *obex, GObexPacket *req)
 
 	op = g_obex_packet_get_operation(req, NULL);
 
-	if (op == G_OBEX_OP_CONNECT)
+	switch (op) {
+	case G_OBEX_OP_CONNECT:
 		parse_connect_data(obex, req);
-	else if (check_connid(obex, req) == FALSE) {
+		break;
+	case G_OBEX_OP_ABORT:
+		break;
+	default:
+		if (check_connid(obex, req))
+			break;
+
 		g_obex_debug(G_OBEX_DEBUG_ERROR, "Invalid Connection ID");
 		g_obex_send_rsp(obex, G_OBEX_RSP_SERVICE_UNAVAILABLE, NULL,
 							G_OBEX_HDR_INVALID);
-- 
1.7.6.4

