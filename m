Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 3/6] gobex: Fix use after free
Date: Fri,  1 Aug 2014 11:44:36 +0300
Message-Id: <1406882679-28568-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406882679-28568-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZJSfWa8r8Ab-Dp3cmSwcxQc_7t7W0Cb2EALobM4RQnLkw@mail.gmail.com>
 <1406882679-28568-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 gobex/gobex-transfer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 6dc7d9f..efae72b 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -406,6 +406,7 @@ static void transfer_put_req(GObex *obex, GObexPacket *req, gpointer user_data)
 	if (!g_obex_send(obex, rsp, &err)) {
 		transfer_complete(transfer, err);
 		g_error_free(err);
+		return;
 	}
 
 done:
-- 
1.9.1

