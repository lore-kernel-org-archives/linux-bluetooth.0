Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/6] gobex: Fix use after free
Date: Fri,  1 Aug 2014 11:44:34 +0300
Message-Id: <1406882679-28568-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <CABBYNZJSfWa8r8Ab-Dp3cmSwcxQc_7t7W0Cb2EALobM4RQnLkw@mail.gmail.com>
References: <CABBYNZJSfWa8r8Ab-Dp3cmSwcxQc_7t7W0Cb2EALobM4RQnLkw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

transfer_complete() frees transfer pointer.
---
 gobex/gobex-transfer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 8498177..6dc7d9f 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -378,6 +378,7 @@ static void transfer_put_req_first(struct transfer *transfer, GObexPacket *req,
 	if (!g_obex_send(transfer->obex, rsp, &err)) {
 		transfer_complete(transfer, err);
 		g_error_free(err);
+		return;
 	}
 
 	if (rspcode != G_OBEX_RSP_CONTINUE)
-- 
1.9.1

