Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3FAC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 13:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243805AbiFNNQN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244132AbiFNNQM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 09:16:12 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5354F381A3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 06:16:10 -0700 (PDT)
X-QQ-mid: bizesmtp69t1655212556tp9f1ec5
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 14 Jun 2022 21:15:51 +0800 (CST)
X-QQ-SSF: 01400000002000C0D000000A0000000
X-QQ-FEAT: wpAWin5TxhugTPsp85FyeoqPR9MJGDpEWdvW91+U/rzuYmhEfHjomxsqpOZ4h
        ox0ci0pt4JZey6UlmmGF2TMX+rliSn0gAgT/jIDLjX4KajF14UFWHwDaEzIZkQ28PHQ0Xfx
        k2N3ugn4X7Q+e6LodrpRa556sQxURfSNqm/dLtUo/VI7wlnF5hzZmLxexeP4dXLLCK66HJe
        zt1Ez42hVStzyE75eQve/z1edZGwjfIYnHkY1AWwe11t0pHLdpI8Ag6NL9s9ozeXStHz7Op
        QJvZwx2aqXuZicNMDGjfKJ9Mkrlk7rQttUHgwhnp4k9bGrPlfqq2LyYsLBJr8ShzCXAAGjp
        xI/gWXkUvyItOivzJOw4rZ/2F2TnQ==
X-QQ-GoodBg: 1
From:   wangyouwan <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     wangyouwan <wangyouwan@uniontech.com>
Subject: [PATCH] obexd: Fix transfer has been free in transfer_abort_response
Date:   Tue, 14 Jun 2022 21:15:49 +0800
Message-Id: <20220614131549.22054-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Breakpoint 7, transfer_new (obex=0x5555555f5b50, opcode=2 '\002',
complete_func=0x555555590c40 <xfer_complete>, user_data=0x5555555f7000)
at gobex/gobex-transfer.c:254
254     gobex/gobex-transfer.c:
(gdb) c
Continuing.

Breakpoint 3, transfer_complete (transfer=0x5555555f5f40,
err=0x5555555f6d60) at gobex/gobex-transfer.c:99
99      in gobex/gobex-transfer.c
(gdb) c
Continuing.

Breakpoint 4, xfer_complete (obex=0x5555555f5b50, err=0x5555555f6d60,
user_data=0x5555555f7000)
at obexd/client/transfer.c:659
659     obexd/client/transfer.c:
(gdb) n
661     in obexd/client/transfer.c
(gdb) n
663     in obexd/client/transfer.c
(gdb) p callback->func
$17 = (transfer_callback_t) 0x5555555885e0 <transfer_complete>
(gdb) c
Continuing.

Breakpoint 3, transfer_complete (transfer=0x5555555f7000, err=0x5555555f6d60,
user_data=0x5555555f48d0) at obexd/client/session.c:964
964     obexd/client/session.c:
(gdb) c
Continuing.

Breakpoint 5, transfer_free (transfer=0x5555555f5f40) at
gobex/gobex-transfer.c:61
61      gobex/gobex-transfer.c:
(gdb) n
63      in gobex/gobex-transfer.c
(gdb) p transfer->id
$18 = 1
(gdb) c
Continuing.

Breakpoint 2, transfer_abort_response (obex=0x5555555f5b50, err=0x0,
rsp=0x5555555f0810, user_data=0x5555555f5f40) at gobex/gobex-transfer.c:116
116     in gobex/gobex-transfer.c
(gdb) n
118     in gobex/gobex-transfer.c
(gdb) p transfer->id
$19 = 1432314080
(gdb) c
Continuing.

Breakpoint 3, transfer_complete (transfer=0x5555555f5f40, err=0x5555555f6f00)
at gobex/gobex-transfer.c:99
99      in gobex/gobex-transfer.c
(gdb) c
Continuing.

Breakpoint 4, xfer_complete (obex=0x5555555f5b50, err=0x5555555f6f00,
user_data=0x5555555f7000)
at obexd/client/transfer.c:659
659     obexd/client/transfer.c:
(gdb) n
661     in obexd/client/transfer.c
(gdb) p callback->func
$20 = (transfer_callback_t) 0x5555555f6420
(gdb) n
663     in obexd/client/transfer.c
(gdb) n
668     in obexd/client/transfer.c
(gdb) n
671     in obexd/client/transfer.c
(gdb) n
672     in obexd/client/transfer.c
(gdb) n
676     in obexd/client/transfer.c
(gdb) n
679     in obexd/client/transfer.c
(gdb) n
680     in obexd/client/transfer.c
(gdb) n
0x00005555555f6420 in ?? ()
(gdb) n
Cannot find bounds of current function
(gdb) c
Continuing.

Program received signal SIGSEGV, Segmentation fault.
0x00005555555f6420 in ?? ()
(gdb)
---
 gobex/gobex-transfer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index c94d018b2..48b1f6962 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -92,7 +92,9 @@ static void transfer_complete(struct transfer *transfer, GError *err)
 		g_obex_drop_tx_queue(transfer->obex);
 	}
 
-	transfer->complete_func(transfer->obex, err, transfer->user_data);
+	if (find_transfer(id) != NULL)
+		transfer->complete_func(transfer->obex, err, transfer->user_data);
+
 	/* Check if the complete_func removed the transfer */
 	if (find_transfer(id) == NULL)
 		return;
-- 
2.20.1



