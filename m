Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA5CC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 05:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiFWFBA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 01:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiFWFAd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jun 2022 01:00:33 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19435496B9
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 21:45:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s185so12295696pgs.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 21:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/9qFyabmBcibChahYmaud4vPnIfjnmUdYUKhUTjcTys=;
        b=B4iQFshue5+ocH1qvrbcRq/LTKcTziF7ORkG1R/P+gI1Vo0E43UAVQymwggvHC7ghN
         0jwy5eSOaQUCfNM09AQQ2xjFIZ+Snh2f8XWS3VRSV3rE35QXt83ag5Vzvs/6CHcFwqv6
         HoY1oP71HaWZCYRYl/vm1hZcowC5MBSCkrQGOYZO46CPMksKO2Lynbs9yCKcoGXLXPX7
         9mIBUFGqYIdrswy5z0fWnvEfxL2pR6ZzsXBcQ4qObjOBpBoHDA1fZAG6qbb3zW4lgM7L
         XqMxTpxJgqREhNH8mAOvaw6aGsXXqHVYYJc1ojq3/ocBquHmuXtscKCzNEyp8QZBqvLO
         Is8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/9qFyabmBcibChahYmaud4vPnIfjnmUdYUKhUTjcTys=;
        b=VHIajiyO2zjELAsZWo9hAWqH6ZnDCmU7NVBr0K/onBKEDzbA6U2HNdpTyFgUU98XW6
         J7byS2xTJg8BFp3EkCN+HvedUuq2aXiZqyLmn7tOe0pik2SNOtO2A2neXsMlMLWroji+
         VdL4QLwU8Scoqtt1Hiovt2wX2kxpN+j9Guig/RrNS4Z8odWIrqZqH/YjiiPdldokIlgL
         TxBAyrtApg5+0++6GXmWPU0O69ayhneZrXXsJdePPadwrSGc4NkYhEINFdTViOGGqo4g
         WSYGtZAXUW0ZJRgnvbU91p/aaPqKRJ5eIii+tvei35rqeRs8wYWAwdp7Wm87MbAXp+cF
         ORLA==
X-Gm-Message-State: AJIora8m6ykDjP0Ck/QeSlMgevBN9gGYf+dY8edHpMAa1hmaINuVMyrl
        MYtSPcA3TYE36WcyY+eqZpDTXzPrVzI=
X-Google-Smtp-Source: AGRyM1vZjmG/kZ/frQFQ0A0N44HhdJ9EZrFHbfa8ukAnLK+kKZoaVvND+HZEr4TItivjkDUfudNQpA==
X-Received: by 2002:a63:8c47:0:b0:40d:2d4:e3a2 with SMTP id q7-20020a638c47000000b0040d02d4e3a2mr6183819pgn.2.1655959521355;
        Wed, 22 Jun 2022 21:45:21 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:29c0:aef5:a13f:9fde])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902e94300b00168adae4eb2sm13646213pll.262.2022.06.22.21.45.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 21:45:21 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] mgmt-tester: Fix null dereference issue reported by scan-build
Date:   Wed, 22 Jun 2022 21:45:20 -0700
Message-Id: <20220623044520.458626-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the null dereference reported by the scan-build.

tools/mgmt-tester.c:12025:28: warning: Access to field 'cap_len' results
in a dereference of a null pointer (loaded from variable 'rp')
[core.NullDereference]

        if (sizeof(rp->cap_len) + rp->cap_len != length) {
                                  ^~~~~~~~~~~
---
 tools/mgmt-tester.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index f45a6c015..6018327f1 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -12020,12 +12020,14 @@ static void read_50_controller_cap_complete(uint8_t status, uint16_t length,
 		tester_warn("Failed to read advertising features: %s (0x%02x)",
 						mgmt_errstr(status), status);
 		tester_test_failed();
+		return;
 	}
 
 	if (sizeof(rp->cap_len) + rp->cap_len != length) {
 		tester_warn("Controller capabilities malformed, size %zu != %u",
 				sizeof(rp->cap_len) + rp->cap_len, length);
 		tester_test_failed();
+		return;
 	}
 
 	while (offset < rp->cap_len) {
-- 
2.34.1

