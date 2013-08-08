Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client/transfer: Add proper message to errors
Date: Thu,  8 Aug 2013 16:49:09 +0300
Message-Id: <1375969749-2097-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1375969749-2097-1-git-send-email-luiz.dentz@gmail.com>
References: <1375969749-2097-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This improve the error message when a transfer fails by using
g_obex_strerror to decode the response code to a human readable string.
---
 obexd/client/transfer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 4b1def3..2e8f7c7 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -596,8 +596,8 @@ static void get_xfer_progress_first(GObex *obex, GError *err, GObexPacket *rsp,
 
 	rspcode = g_obex_packet_get_operation(rsp, &final);
 	if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
-		err = g_error_new(OBC_TRANSFER_ERROR, rspcode,
-					"Transfer failed (0x%02x)", rspcode);
+		err = g_error_new(OBC_TRANSFER_ERROR, rspcode, "%s",
+						g_obex_strerror(rspcode));
 		xfer_complete(obex, err, transfer);
 		g_error_free(err);
 		return;
-- 
1.8.3.1

