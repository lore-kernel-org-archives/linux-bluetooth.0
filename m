Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB928C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 08:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiGAIGS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbiGAIGR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 04:06:17 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5867A6F363
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 01:06:14 -0700 (PDT)
X-QQ-mid: bizesmtp69t1656662767tg2kcxec
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 01 Jul 2022 16:06:03 +0800 (CST)
X-QQ-SSF: 01400000002000C0E000000A0000000
X-QQ-FEAT: ipjz9r0KCw679klCCjhGuqwXbUlOuoWtyS5cKp2x6rVZRMM6W1hUH5JdNLZzh
        KS7hoL70ErThptRVFEi5uQL4IQGxEXqgfL4EnaI/azl4Hb49MVZfCFd18lf1/U2G+QqY8y3
        /XQmIG9vsZHCCJI0E/tOAVUbt/kRt032FVL/fnVhefDg/N6wvY96nQ2XcTtun47O314oU2T
        Qf2nll6Cswph5BkW6757uzntoW3PtGItP9zp6f/MW8AvjY99T5v3/CeKFpl3cZk1VhkjFuz
        mUIh7+t78/taIZMe+75tm9iTzMyQI5D8m8Zart7+Jb3YjqtG/NjhB0aCvANzn5mK5PfI/SA
        qApjDAwbEasqEzutQOneYWKvs//Tw==
X-QQ-GoodBg: 1
From:   Youwan Wang <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Youwan Wang <wangyouwan@uniontech.com>
Subject: [PATCH] obexd: fix crashed after cancel the on-going transfer
Date:   Fri,  1 Jul 2022 16:06:01 +0800
Message-Id: <20220701080601.3010-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is a use after released.transfer->req_id different
obex->pending_req->id,See the following log,
The packages is removd in cancel_complete func
are not the same package in req_timeout func,
but transfer pointer is released.

log:
g_obex_cancel_req()
transfer->req_id 23 id 22 obex->pending_req(0x55b642c3e100)

g_obex_cancel_req()
match->data (0x55b642c344a0)

g_obex_ref() ref 4

cancel_complete()
pending req timeout 176 id 22 obex(0x55b642c3e100)

transfer_response()
obex 0x55b642c36480 transfer(0x55b642c3d000)

g_obex_drop_tx_queue()

g_obex_unref() obex 0x55b642c36480
g_obex_unref() ref 3

transfer_free()
obex 0x55b642c36480 transfer 0x55b642c3d000

g_obex_unref() obex 0x55b642c36480
g_obex_unref() ref 2

pending_pkt_free()
timeout_id 0 pending_pkt (0x55b642c344a0)

step:
[obex]# connect 28:33:34:1E:96:98
Attempting to connect to 28:33:34:1E:96:98
[NEW] Session /org/bluez/obex/client/session2 [default]
[NEW] ObjectPush /org/bluez/obex/client/session2
Connection successful
[28:33:34:1E:96:98]# send /home/uos/Desktop/systemd.zip
Attempting to send /home/uos/Desktop/systemd.zip
[NEW] Transfer /org/bluez/obex/client/session2/transfer2
Transfer /org/bluez/obex/client/session2/transfer2
        Status: queued
        Name: systemd.zip
        Size: 33466053
        Filename: /home/uos/Desktop/systemd.zip
        Session: /org/bluez/obex/client/session2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
[CHG] Transfer /org/bluez/obex/client/session2/transfer2
er2 33:34:1E:96:98]# cancel /org/bluez/obex/client/sessi
Attempting to cancel transfer /org/bluez/obex/client/s
Cancel successful

valgrind trace:
==11431== Invalid read of size 4
==11431==    at 0x12B442: transfer_response ()
==11431==    by 0x127764: req_timeout ()
==11431==    by 0x49B8922: ??? ( )
==11431==    by 0x49B7E97: g_main_context_dispatch ()
==11431==    by 0x49B8287: ??? (in )
==11431==    by 0x49B8581: g_main_loop_run ()
==11431==    by 0x121834: main (main.c:322)
==11431==  Address 0x7344fa0 is 16 bytes inside a block of size
==11431==    at 0x48369AB: free ()
==11431==    by 0x12B459: transfer_response ()
==11431==    by 0x127B3D: cancel_complete ()
==11431==    by 0x49B7E97: g_main_context_dispatch ()
==11431==    by 0x49B8287: ??? ()
==11431==    by 0x49B8581: g_main_loop_run ()
==11431==    by 0x121834: main (main.c:322)
==11431==  Block was alloc'd at
==11431==    at 0x4837B65: calloc ()
==11431==    by 0x49BD9D8: g_malloc0 ()
==11431==    by 0x12AB89: transfer_new ()
==11431==    by 0x12B732: g_obex_put_req_pkt ()
==11431==    by 0x12B732: g_obex_put_req_pkt ()
==11431==    by 0x146982: transfer_start_put ()
==11431==    by 0x146982: obc_transfer_start ()
==11431==    by 0x13C5A7: session_process_transfer ()
==11431==    by 0x13D248: session_process_queue ()
==11431==    by 0x13D248: session_process_queue ()
==11431==    by 0x13D2AF: session_process ()
==11431==    by 0x49B7E97: g_main_context_dispatch ()
==11431==    by 0x49B8287: ??? (i)
==11431==    by 0x49B8581: g_main_loop_run ()
==11431==    by 0x121834: main ()
==11431==
==11431== (action on error) vgdb me ...
---
 gobex/gobex-transfer.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index c94d018b2..a7d6c103a 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -83,15 +83,20 @@ static struct transfer *find_transfer(guint id)
 
 static void transfer_complete(struct transfer *transfer, GError *err)
 {
-	guint id = transfer->id;
+	guint id;
 
-	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
+	if (!g_slist_find(transfers, transfer))
+		return;
+
+	transfer->req_id = 0;
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
 
 	if (err) {
 		/* No further tx must be performed */
 		g_obex_drop_tx_queue(transfer->obex);
 	}
 
+	id = transfer->id;
 	transfer->complete_func(transfer->obex, err, transfer->user_data);
 	/* Check if the complete_func removed the transfer */
 	if (find_transfer(id) == NULL)
@@ -106,9 +111,6 @@ static void transfer_abort_response(GObex *obex, GError *err, GObexPacket *rsp,
 	struct transfer *transfer = user_data;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
-
-	transfer->req_id = 0;
-
 	/* Intentionally override error */
 	err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
 						"Operation was aborted");
@@ -184,12 +186,6 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 	struct transfer *transfer = user_data;
 	GObexPacket *req;
 	gboolean rspcode, final;
-	guint id;
-
-	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
-
-	id = transfer->req_id;
-	transfer->req_id = 0;
 
 	if (err != NULL) {
 		transfer_complete(transfer, err);
@@ -203,6 +199,9 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 		goto failed;
 	}
 
+	if (!g_slist_find(transfers, transfer))
+		return;
+
 	if (transfer->opcode == G_OBEX_OP_GET) {
 		handle_get_body(transfer, rsp, &err);
 		if (err != NULL)
@@ -222,8 +221,6 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 		req = g_obex_packet_new(transfer->opcode, TRUE,
 							G_OBEX_HDR_INVALID);
 	} else {
-		/* Keep id since request still outstanting */
-		transfer->req_id = id;
 		return;
 	}
 
-- 
2.20.1



