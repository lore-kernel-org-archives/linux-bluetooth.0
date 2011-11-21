Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd] client: Fix app params memory management
Date: Mon, 21 Nov 2011 15:44:47 +0100
Message-Id: <1321886687-10662-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/transfer.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index b6994d1..b314926 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -356,6 +356,12 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 	if (hdr) {
 		g_obex_header_get_bytes(hdr, &buf, &len);
 		if (len != 0) {
+			if (transfer->params == NULL)
+				transfer->params =
+					g_new0(struct obc_transfer_params, 1);
+			else if (transfer->params->data != NULL)
+				g_free(transfer->params->data);
+
 			transfer->params->data = g_memdup(buf, len);
 			transfer->params->size = len;
 		}
-- 
1.7.4.1

