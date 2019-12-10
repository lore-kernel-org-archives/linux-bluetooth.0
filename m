Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAB0C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 16:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA80207FF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 16:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="NGJsTWxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLJQZ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:25:57 -0500
Received: from dougal.metanate.com ([90.155.101.14]:45524 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbfLJQZ5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 11:25:57 -0500
X-Greylist: delayed 944 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 11:25:57 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HlOSO/UsxIjuS4crUqWfNT2KKKKFuiJ3RaYVWIrUG50=; b=NGJsTWxFOYR1PXj9Zjf28RMU40
        0XwPgNnebnD1pFQT6uzfGbGg0VRKDf600XipJ2PHSgVmd553rkp3jchxqZ3YraCheYP/tg+zAbuEz
        96g1c5QRNZ4kDBDVZJJ3s2Npk2nVIm0TgM6YICgfZAfqAhZ4N6VgJViEprheITMxUM89i5JI0TWJu
        OYY+PUnr9/rspXEnRZoZAY8jG6Da7pW1FYwki1c4Z4NlS8Mgs4B9+PkMtAnGTEdpNMgW0s+coxTAC
        Tu5f3gGGpgU5s+esCrDj90J+DIE9SL5lDI4+BBZKdowY/lV3taNDHAcUYUYXzIJvkBmhv5Bkh627o
        vQkZKwgw==;
Received: from johnkeeping.plus.com ([81.174.171.191] helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <john@metanate.com>)
        id 1iei5S-0005eE-BG; Tue, 10 Dec 2019 16:10:11 +0000
From:   John Keeping <john@metanate.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     John Keeping <john@metanate.com>
Subject: [PATCH sbc] sbc: Fix visibility of sbc_reinit_a2dp()
Date:   Tue, 10 Dec 2019 16:09:54 +0000
Message-Id: <20191210160954.2154412-1-john@metanate.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

sbc_reinit_a2dp() is missing the SBC_EXPORT attribute so it's not
visibile to be used by consumers of the shared object.
---
 sbc/sbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 7f1efaa..edbe332 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1191,7 +1191,7 @@ SBC_EXPORT int sbc_init_a2dp(sbc_t *sbc, unsigned long flags,
 	return 0;
 }
 
-int sbc_reinit_a2dp(sbc_t *sbc, unsigned long flags,
+SBC_EXPORT int sbc_reinit_a2dp(sbc_t *sbc, unsigned long flags,
 					const void *conf, size_t conf_len)
 {
 	int err;
-- 
2.24.0

