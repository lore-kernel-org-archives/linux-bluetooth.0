Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 07/10] gobex: Fix use after free
Date: Mon, 11 Aug 2014 10:50:42 +0300
Message-Id: <1407743445-1329-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Refactor function transfer_get_req_first() to avoid use after free.
---
 gobex/gobex-transfer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index efae72b..d7707f9 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -553,7 +553,8 @@ static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 	return ret;
 }
 
-static void transfer_get_req_first(struct transfer *transfer, GObexPacket *rsp)
+static gboolean transfer_get_req_first(struct transfer *transfer,
+							GObexPacket *rsp)
 {
 	GError *err = NULL;
 
@@ -564,7 +565,10 @@ static void transfer_get_req_first(struct transfer *transfer, GObexPacket *rsp)
 	if (!g_obex_send(transfer->obex, rsp, &err)) {
 		transfer_complete(transfer, err);
 		g_error_free(err);
+		return FALSE;
 	}
+
+	return TRUE;
 }
 
 static void transfer_get_req(GObex *obex, GObexPacket *req, gpointer user_data)
@@ -596,7 +600,8 @@ guint g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
 	transfer = transfer_new(obex, G_OBEX_OP_GET, complete_func, user_data);
 	transfer->data_producer = data_func;
 
-	transfer_get_req_first(transfer, rsp);
+	if (!transfer_get_req_first(transfer, rsp))
+		return 0;
 
 	if (!g_slist_find(transfers, transfer))
 		return 0;
-- 
1.9.1

