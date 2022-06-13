Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FAFCCA483
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 14:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380558AbiFMOB0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 10:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380580AbiFMN7H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 09:59:07 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1A88CB3B
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 04:37:48 -0700 (PDT)
X-QQ-mid: bizesmtp71t1655120243t64ph5p5
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 13 Jun 2022 19:37:19 +0800 (CST)
X-QQ-SSF: 01400000002000C0D000000A0000000
X-QQ-FEAT: ZHWZeLXy+8eClACgNhm8bHQa+2IVq2ogrW+ASiRZsqDdEMufljUNbTf7czw5t
        XmefJOiRD6P6fGL1pqQHtcwGsqELBcXaC8+YZ42lj1QCFTQnEIO6kAQ/O7tmhdy1WjlKISo
        FeSLm9NAuHOp4tDgPnzXBdKfQDv4C3UpW4DfHS/CSFGQVpI6cQHp2Mfr02cfnrsYyMhCAOa
        Gp3sbAz99bSa5n/8OhRmJQ15LRn4jNUdcXUnORPBTE1+9GWJeLFKbO1a8XCuGHm5SSkTTG5
        klx7uFvNDXP+QCbiyjqln0JwV42b8BifYZ9AQiHuPUeoYnpUayaqurZakwFNmXjk54VyhTU
        fXPJH+kjTW52nNKwkI=
X-QQ-GoodBg: 1
From:   wangyouwan <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     wangyouwan <wangyouwan@uniontech.com>
Subject: [PATCH] obexd: Fix callback->func =! NULL in the xfer_complete() func
Date:   Mon, 13 Jun 2022 19:37:13 +0800
Message-Id: <20220613113713.13681-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

xfer_complete (obex=0x557d242c8cf0, err=0x557d242ca470,
user_data=0x557d242ca300) at obexd/client/transfer.c:659
659     obexd/client/transfer.c:
(gdb) n
661     in obexd/client/transfer.c
(gdb) n
663     in obexd/client/transfer.c
(gdb) p callback->func
$1 = (transfer_callback_t) 0x0
(gdb) n
668     in obexd/client/transfer.c
(gdb) n
671     in obexd/client/transfer.c
(gdb) n
672     in obexd/client/transfer.c
(gdb) n
676     in obexd/client/transfer.c
(gdb) n
677     in obexd/client/transfer.c
(gdb) n
0x0000000000000000 in ?? ()
(gdb) s
Cannot find bounds of current function
(gdb) c
Continuing.

Program received signal SIGSEGV, Segmentation fault.
---
 obexd/client/transfer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index dccce03b4..a7a85a0c0 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -666,7 +666,10 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 	else
 		transfer_set_status(transfer, TRANSFER_STATUS_COMPLETE);
 
-	if (callback)
+	if (callback == NULL)
+		return;
+
+	if (callback->func)
 		callback->func(transfer, err, callback->data);
 }
 
-- 
2.20.1



