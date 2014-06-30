Return-Path: <cyrus@holtmann.org>
From: Artem Rakhov <arakhov@chromium.org>
To: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Cc: Artem Rakhov <arakhov@chromium.org>
Subject: [PATCH] sdp: Fix requests with invalid size
Date: Mon, 30 Jun 2014 12:58:46 -0700
Message-Id: <1404158326-12178-1-git-send-email-arakhov@chromium.org>
In-Reply-To: <1403929003-31639-1-git-send-email-arakhov@chromium.org>
References: <1403929003-31639-1-git-send-email-arakhov@chromium.org>
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
 src/sdpd-server.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index b411abe..015551d 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -176,7 +176,11 @@ static gboolean io_session_event(GIOChannel *chan, GIOCondition cond, gpointer d
 		return TRUE;
 
 	len = recv(sk, buf, size, 0);
-	if (len != size) {
+	/* Check here only that the received message is not empty.
+	 * Incorrect length of message should be processed later
+	 * inside handle_request() in order to produce ErrorResponse.
+	 */
+	if (len <= 0) {
 		sdp_svcdb_collect_all(sk);
 		free(buf);
 		return FALSE;
-- 
2.0.0.526.g5318336
