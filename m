Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A412CCA47F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 13:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376327AbiFMNYz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 09:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377052AbiFMNYO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 09:24:14 -0400
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8A56B7EB
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 04:23:56 -0700 (PDT)
X-QQ-mid: bizesmtp87t1655119399trh68o5p
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 13 Jun 2022 19:22:47 +0800 (CST)
X-QQ-SSF: 00400000002000C0D000B00A0000000
X-QQ-FEAT: 8nRPapzIrE2CE+SmV7HzIOTRIYAAjjVJutUwegxmRc2aIU9K4oPj7AhQOv5aT
        NQDwV6RPlkHMLkJ1jJNd3T2rx67KQzAA2pXD+OCkdjQZgSgy4MFhHYTvQchvoOhxNXt8EeI
        ChXhwOa1MeI4QjblPxdhRoyomMx+Vj+I13F+LXjajzBITBO6R9A8J9lMR1XYcpiiyX4T5FI
        adJ30u1CI0TY3eiwe4Uuy65txBBvKJNdRwvbeHbaadf1WUpSHXXBHorsIXkKe9sKHMSl7dl
        0a5m6MsCqhV9Cw/qT536jffoUKZ+bieGD+abOgA/14jOZSa/CTEZLhZSkbTg9YWxCAF+sQ1
        G8SIB1K
X-QQ-GoodBg: 2
From:   wangyouwan <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     wangyouwan <wangyouwan@uniontech.com>
Subject: [PATCH] obexd: Fix callback->func =! NULL in the xfer_complete() func
Date:   Mon, 13 Jun 2022 19:22:42 +0800
Message-Id: <20220613112242.9407-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

xfer_complete (obex=0x557d242c8cf0, err=0x557d242ca470,
user_data=0x557d242ca300) at obexd/client/transfer.c:659
659     obexd/client/transfer.c: 没有那个文件或目录.
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



