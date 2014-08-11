Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 06/10] gobex: Fix use after free
Date: Mon, 11 Aug 2014 10:50:41 +0300
Message-Id: <1407743445-1329-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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

