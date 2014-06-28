Return-Path: <cyrus@holtmann.org>
From: Artem Rakhov <arakhov@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Artem Rakhov <arakhov@chromium.org>
Subject: [PATCH] sdp: Fix requests with invalid size
Date: Fri, 27 Jun 2014 21:16:43 -0700
Message-Id: <1403929003-31639-1-git-send-email-arakhov@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes processing of SDP requests which have wrong PDU size in header.

Every SDP request consists of two parts: header and data.
Header always contains 3 values: request code (identifies it's type),
transaction ID (in order to match response with request), and data's size.

According to Bluetooth specification, when the data's size is wrong,
SDP server should return SDP_ErrorResponse with "Invalid PDU Size" parameter.
But now the server doesn't respond at all, and corresponding socket on
client's side crashes.

The patch actually reverts commit 388761cdc8f8a1293bb0b1a5bd576b5fb41616ca,
because the size of request should be checked inside handle_request() function
in order to be able to respond with SDP_ErrorResponse, instead of stopping
the connection.
---
 src/sdpd-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index b411abe..230e467 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -176,7 +176,7 @@ static gboolean io_session_event(GIOChannel *chan, GIOCondition cond, gpointer d
 		return TRUE;
 
 	len = recv(sk, buf, size, 0);
-	if (len != size) {
+	if (len <= 0) {
 		sdp_svcdb_collect_all(sk);
 		free(buf);
 		return FALSE;
-- 
2.0.0.526.g5318336

