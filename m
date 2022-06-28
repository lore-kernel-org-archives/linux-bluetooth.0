Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CD2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jun 2022 07:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbiF1Hnw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jun 2022 03:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiF1Hnr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jun 2022 03:43:47 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383892601
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jun 2022 00:43:43 -0700 (PDT)
X-QQ-mid: bizesmtp77t1656402215tshiqbco
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 28 Jun 2022 15:43:28 +0800 (CST)
X-QQ-SSF: 01400000002000C0E000000A0000000
X-QQ-FEAT: FXvDfBZI5O6MeuR0nlm6sKaBk/Nj2cL396wwFXmdFpKkzHVbRXt61u9z7lpF/
        ixFlw/b5k376T4h/BOs/CH7WnryzNyagidRy4rJ9GQgDZmCu939yPqSk44MGXfQEL/zKB7n
        a5sULvXHbsjBuKDtIHeSnYo1gVKSC7tig6lXS16Im9sqTvJs2x19Crjqah1pva74CpgKOMM
        1E8doy18Db9NHpTDI0kfnz7eAV/T6hvqiYAnkcGs1xBOvED37BichhSweXxGQa3TiMkJ5J1
        p6Qa/e3+LOGBY/Xo2V926dTONnZGWy+lPvkV1Id9d7zhvz5D1KbdHIajnSkxzw17XaIqXVk
        PhMh8NUI9sRaujD6wXqyLuBmUxj0w==
X-QQ-GoodBg: 1
From:   Youwan Wang <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Youwan Wang <wangyouwan@uniontech.com>
Subject: [PATCH] obexd: Fix obex pointer is not null judgment
Date:   Tue, 28 Jun 2022 15:43:25 +0800
Message-Id: <20220628074325.17105-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Judge that the obex pointer is not null before
OBEX release
---
 gobex/gobex-transfer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index c94d018b2..77cbeefcf 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -63,8 +63,9 @@ static void transfer_free(struct transfer *transfer)
 	if (transfer->abort_id > 0)
 		g_obex_remove_request_function(transfer->obex,
 							transfer->abort_id);
+	if (transfer->obex)
+		g_obex_unref(transfer->obex);
 
-	g_obex_unref(transfer->obex);
 	g_free(transfer);
 }
 
-- 
2.20.1



