Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93809C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 11:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbiFNLtg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 07:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbiFNLtf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 07:49:35 -0400
X-Greylist: delayed 87941 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 04:49:29 PDT
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF8340FF
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 04:49:29 -0700 (PDT)
X-QQ-mid: bizesmtp71t1655207363tl1pkr59
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 14 Jun 2022 19:49:17 +0800 (CST)
X-QQ-SSF: 01400000002000C0D000B00A0000000
X-QQ-FEAT: T/61Y8rdSIt9rUqv+Wg5aQQSsWs3GtE7InD7BiTZ8lpXwGhbMijkggiTNwDBV
        7vj4nVj1asYSHYe+ScjHM0y3fuMClxOI0kYLwR3MS9RD8hV1EL5/+hVT5wsmAQSFl28raP4
        1wYomWveEksQCu/neZHyXoPWEOTJmC+A91rgdbfY53Ra1WwJp/eoGDiTWFP58prw+ZlXen5
        u6G11q4pink5pSf7ZhSVM048BYCesZ+c3BaK80jzzzvqpSUPMemljfpdkvEH0YOHT8rpBWp
        1oGLRyIUffV1ogN2ftYx8URCUT+PqVOmIzkhDY6IzzKfQBoBuJrltqYbrMw7Dp2gWnGs9t5
        0Hw9b3F
X-QQ-GoodBg: 2
From:   wangyouwan <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     wangyouwan <wangyouwan@uniontech.com>
Subject: [PATCH] obexd: Fix transfer has been free during transfer_abort_response func
Date:   Tue, 14 Jun 2022 19:49:14 +0800
Message-Id: <20220614114914.30497-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
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

Breakpoint 3, transfer_complete (transfer=0x5555555f5f40, err=0x5555555f6d60)
at gobex/gobex-transfer.c:99
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

Breakpoint 5, transfer_free (transfer=0x5555555f5f40) at gobex/gobex-transfer.c:61
61      gobex/gobex-transfer.c:
(gdb) n
63      in gobex/gobex-transfer.c
(gdb) p transfer->id
$18 = 1
(gdb) c
Continuing.

Breakpoint 2, transfer_abort_response (obex=0x5555555f5b50, err=0x0, rsp=0x5555555f0810,
user_data=0x5555555f5f40) at gobex/gobex-transfer.c:116
116     in gobex/gobex-transfer.c
(gdb) n
118     in gobex/gobex-transfer.c
(gdb) p transfer->id
$19 = 1432314080
(gdb) c
Continuing.

Breakpoint 3, transfer_complete (transfer=0x5555555f5f40, err=0x5555555f6f00) at gobex/gobex-transfer.c:99
99      in gobex/gobex-transfer.c
(gdb) c
Continuing.

Breakpoint 4, xfer_complete (obex=0x5555555f5b50, err=0x5555555f6f00, user_data=0x5555555f7000)
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



