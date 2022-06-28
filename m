Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF60C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jun 2022 06:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbiF1GBe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jun 2022 02:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiF1GBd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jun 2022 02:01:33 -0400
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6A2C67E
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 23:01:32 -0700 (PDT)
X-QQ-mid: bizesmtp83t1656396081t4lphc6c
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 28 Jun 2022 14:01:12 +0800 (CST)
X-QQ-SSF: 01400000002000C0E000B00A0000000
X-QQ-FEAT: dpyQmELDBxGupUERX8pQO9/xf/4P/e8Ryc6vLIaZk4fgtdRqbZht1YPNK/Ag6
        /LH+JIGS1OXHGjnXEQ0pJgcGJEUSTnDWm1FqhfnG4aFJJO0WR6pBPYSF55iRDDjq9bemB6U
        kitV9cL+RJml9px74oENEPoYI0U+RiJtWn990zqvofc6StimgDnclAJncTtj60JvCzQgE/3
        mR8RPWzjW/VpzknzTJ3kVOdOUPa7wEni2VWyghkD5MLmSuY4AFsu7CAr5W0evm1TW1hLIIx
        am7F1cViy+2wwiXjwkzMbBXxuQaHG4/r0pMmbXwynjT4Si/aiJemZPOcKg/LlPh1WWD449D
        R8Y/xuD
X-QQ-GoodBg: 2
From:   Youwan Wang <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Youwan Wang <wangyouwan@uniontech.com>
Subject: [PATCH] obexd: Fix obex pointer is not null judgment
Date:   Tue, 28 Jun 2022 14:01:07 +0800
Message-Id: <20220628060107.26070-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Judge that the obex pointer is not null
before OBEX release
---
 gobex/gobex-transfer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index c94d018b2..626a08e38 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -64,7 +64,8 @@ static void transfer_free(struct transfer *transfer)
 		g_obex_remove_request_function(transfer->obex,
 							transfer->abort_id);
 
-	g_obex_unref(transfer->obex);
+    if (transfer->obex)
+		g_obex_unref(transfer->obex);
 	g_free(transfer);
 }
 
-- 
2.20.1



