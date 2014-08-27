Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] gobex: Abort if there is no request to cancel
Date: Wed, 27 Aug 2014 19:04:50 +0300
Message-Id: <1409155490-25653-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
References: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there is no request to cancel send an abort since otherwise the remote
may hang waiting.
---
 gobex/gobex-transfer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 4e1a6c0..6720129 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -653,8 +653,13 @@ gboolean g_obex_cancel_transfer(guint id, GObexFunc complete_func,
 	transfer->complete_func = complete_func;
 	transfer->user_data = user_data;
 
-	if (transfer->req_id == 0)
-		goto done;
+	if (!transfer->req_id) {
+		transfer->req_id = g_obex_abort(transfer->obex,
+						transfer_abort_response,
+						transfer, NULL);
+		if (transfer->req_id)
+			return TRUE;
+	}
 
 	ret = g_obex_cancel_req(transfer->obex, transfer->req_id, FALSE);
 	if (ret)
-- 
1.9.3

