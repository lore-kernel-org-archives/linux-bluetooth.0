Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A15C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jul 2022 06:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiGHG0Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jul 2022 02:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiGHG0O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jul 2022 02:26:14 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF8D31344
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jul 2022 23:26:11 -0700 (PDT)
X-QQ-mid: bizesmtp77t1657261560teupx0up
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 08 Jul 2022 14:25:51 +0800 (CST)
X-QQ-SSF: 01400000002000C0E000B00A0000000
X-QQ-FEAT: HHPuPN/BfjX/PPSZVb4UP2q4RU9Nu4uW5g4AKSPAx2iI4EFoC/OrwbxIBgDxV
        RHLSifeUcJ8pzO/FEjG5gm4iiNlxRax0uW5wbVC33P2X9ygcLBcR2xwrCqSaGvDoDFvDRkr
        lYrCq2qbus0UUtN/QgEpXf08FWRdw0xqezso6/tRvuuy99N8+FD3mrll5N0bK8ic8Gg3qcx
        qA0n90AaboUeL1eAXjucYn2XkMonCXgrflSij1coro9fJDAMC+l4IAzjXABurzSMOEQeeUZ
        vR5yh70tY41/JLadeBPNlVCQxIIgubsAaxjcpeDfWn01z6Ewo+3dQ7oA8sA8ZuwJbSDAZY3
        GtskeJQ2bw2SEG/Sq+9muu6zPw/JmMk+0vt0RXknlk1P17gJCw=
X-QQ-GoodBg: 2
From:   Youwan Wang <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Youwan Wang <wangyouwan@uniontech.com>
Subject: [PATCH] obexd: fix crashed after cancel the on-going transfer
Date:   Fri,  8 Jul 2022 14:25:48 +0800
Message-Id: <20220708062548.31167-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Pointer is reused after release.
After the transfer pointer is released,
remove the response function in pending_pkg
to avoid the 'p->rsp_func' is reused

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
 gobex/gobex-transfer.c | 2 ++
 gobex/gobex.c          | 6 ++++++
 gobex/gobex.h          | 1 +
 3 files changed, 9 insertions(+)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index c94d018b2..38c23785c 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -64,6 +64,8 @@ static void transfer_free(struct transfer *transfer)
 		g_obex_remove_request_function(transfer->obex,
 							transfer->abort_id);
 
+	g_obex_remove_responsefunc(transfer->obex);
+
 	g_obex_unref(transfer->obex);
 	g_free(transfer);
 }
diff --git a/gobex/gobex.c b/gobex/gobex.c
index bc4d52551..54ce484f2 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -533,6 +533,12 @@ void g_obex_drop_tx_queue(GObex *obex)
 		pending_pkt_free(p);
 }
 
+void g_obex_remove_responsefunc(GObex *obex)
+{
+	if (obex->pending_req)
+		obex->pending_req->rsp_func = NULL;
+}
+
 static gboolean g_obex_send_internal(GObex *obex, struct pending_pkt *p,
 								GError **err)
 {
diff --git a/gobex/gobex.h b/gobex/gobex.h
index f16e4426c..1f7ae513a 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -51,6 +51,7 @@ void g_obex_suspend(GObex *obex);
 void g_obex_resume(GObex *obex);
 gboolean g_obex_srm_active(GObex *obex);
 void g_obex_drop_tx_queue(GObex *obex);
+void g_obex_remove_responsefunc(GObex *obex);
 
 GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
 						gssize rx_mtu, gssize tx_mtu);
-- 
2.20.1



