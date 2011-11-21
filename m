Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 1/2] client: Fix memory leak connected to params
Date: Mon, 21 Nov 2011 11:36:56 +0100
Message-Id: <1321871817-8498-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

obc_transfer_params (created in obc_session_get) are reused to store
params received in the response. But actual parameter data were not
freed before g_memdup in get_buf_xfer_progress.
---
 client/transfer.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index b6994d1..e072a42 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -356,6 +356,9 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 	if (hdr) {
 		g_obex_header_get_bytes(hdr, &buf, &len);
 		if (len != 0) {
+			if (transfer->params->data != NULL)
+				g_free(transfer->params->data);
+
 			transfer->params->data = g_memdup(buf, len);
 			transfer->params->size = len;
 		}
-- 
1.7.4.1

