Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D119C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jul 2022 12:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbiGGMoN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Jul 2022 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiGGMoM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Jul 2022 08:44:12 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF271C929
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jul 2022 05:44:06 -0700 (PDT)
X-QQ-mid: bizesmtp82t1657197840tefcpo29
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 07 Jul 2022 20:43:52 +0800 (CST)
X-QQ-SSF: 01400000002000C0E000B00A0000000
X-QQ-FEAT: +bXiSo2NuBcnT2nofmzHmYOl9JmAe5tdF14H68PcvU6eSCp7PVKwR0rlVOpeY
        O4oe7q9Tr3qvGxm8l5kTAFETVl28frTaN2MsOG28KxtbqwPjbi4Iv58ZNzXXwjsHCOTXS4a
        5PA8Ovlw1thNST7sdXwZwVlzyr+mloAo2Cv20TY63J0bu0COb7CAUA7iMdZEg4XUrmBpMGW
        npdk8DVY9ZS6dxRnHC8Xib/3ffA/DIxiDGq9d3TgV4L9oABgDsco5ExWXdZvFblnvQOuJkx
        zI4i0SdEX/kxGXleYSw69oKuXxP+CNYYMv6HlrmWwPUnAZcHw/ka1j5ISpNmy8TMrGnTi5/
        79yjP7QtDdLugmTSpBLSqdXAtse0GuALhh/N//LdY2mK8FfLqX4x5lWcj1m6g==
X-QQ-GoodBg: 2
From:   Youwan Wang <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Youwan Wang <wangyouwan@uniontech.com>
Subject: [PATCH] obexd: fix small probability problem
Date:   Thu,  7 Jul 2022 20:43:48 +0800
Message-Id: <20220707124348.25184-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Need to consider the case where err is not released
---
 gobex/gobex.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index e9b89cead..bc4d52551 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1140,8 +1140,12 @@ static void handle_response(GObex *obex, GError *err, GObexPacket *rsp)
 		p->rsp_func(obex, err, rsp, p->rsp_data);
 
 		/* Check if user callback removed the request */
-		if (!final_rsp && p != obex->pending_req)
+		if (!final_rsp && p != obex->pending_req) {
+			if (p->cancelled)
+				g_error_free(err);
+
 			return;
+		}
 	}
 
 	if (p->cancelled)
-- 
2.20.1



