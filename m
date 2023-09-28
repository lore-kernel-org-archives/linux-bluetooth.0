Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AE1E7F153
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 19:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjI1TNz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1TNy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 15:13:54 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07EA194
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 12:13:52 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3512b425662so34914925ab.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695928431; x=1696533231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfcLBxqQve7MJ6XzHEZsc4t3QqnDlrmUCOhNfNdtDcY=;
        b=EM0sMXU8Yb4c2IFz29U23xyMb6eh4PXwxssC0SU7eyCM8OuRryaJ5DauUQ1rfq7TV1
         e0zZm/1MN6G3NxVhtOoI2v9jfZezaFDKEz/9XV56VP/nRpz+Q2kz750T2ygFR2NDLWNI
         WHszKeoPKEy3wvkQnWoQf7/VTALpym7EwuxLcxMKWV6jBp5j1lLzYU+rniYknGWwHmN/
         qVQ99k64zEF3nCbBxIBcj2QTo8774VoT9Xs4SE8MnXAv65crZP4EaRxvEIQgOxeavhBy
         kp2uUAoQi4PEl4mcbZ6RC5MMPRS5N0f1MRgGMZzITbPf43abVJdhv5A92Mgycms/gLlT
         848A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695928431; x=1696533231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfcLBxqQve7MJ6XzHEZsc4t3QqnDlrmUCOhNfNdtDcY=;
        b=YzIr8X5bTtgyMz4DcJ7zMnweaqzoueQK+nmAFeWeX00Uvzr8+tlS0iatI2Ow9JM2G0
         dQaJ8IZTxhl3QSZ8/aTqVbiWGf8KyrwpVLD/PstCVlq9jDAZiIGw9xLDiAU3jDcyS2Tb
         REhuWEpkK+TYmcY7rGqbraJtr+SWcZiTvqgB+7D+GEVK9FSWRyypX8iAPPE/KdNhTWT2
         KojMjyqj9RbI6aJLguBF2B/4G7hXkn1WtYaz6ZSiBPWVfTas70/UArMuaPlyebJZEBSm
         8jBX7qOvD3dcavbjDVw1vB0NGsb03bRHLA/U1uUObUlCDTKSCYTnyFD03yJr2zuvyzhx
         mJJA==
X-Gm-Message-State: AOJu0Yzz1LMtgxo7nCvemgHYtBYhVdXVdVNOHwEe3bIUqQs/gSg3h2rO
        CCqISb+7uwnS7w3f1VNEyazidvWfPJY43pAT
X-Google-Smtp-Source: AGHT+IEOdG2cqrARnf5+Z+R2a9YzT0b6LbGPBVv6q1KZhUI/8nHyTuBWn6igjuF3qegx8dzF9YxZMw==
X-Received: by 2002:a05:6e02:152f:b0:34d:ee49:5114 with SMTP id i15-20020a056e02152f00b0034dee495114mr2064680ilu.23.1695928431469;
        Thu, 28 Sep 2023 12:13:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id w16-20020a637b10000000b0057c44503835sm11643370pgc.65.2023.09.28.12.13.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 12:13:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/csip: Remove bt_csip_add_db
Date:   Thu, 28 Sep 2023 12:13:47 -0700
Message-ID: <20230928191347.2086937-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928191347.2086937-1-luiz.dentz@gmail.com>
References: <20230928191347.2086937-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_csip_add_db is unused since csip plugin does use bt_csip_new to
properly create the attributes for CSIS.
---
 src/shared/csip.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/shared/csip.c b/src/shared/csip.c
index 7e90a3c97614..04a8d542b390 100644
--- a/src/shared/csip.c
+++ b/src/shared/csip.c
@@ -389,11 +389,6 @@ static struct bt_csip_db *csip_get_db(struct gatt_db *db)
 	return csip_db_new(db);
 }
 
-void bt_csip_add_db(struct gatt_db *db)
-{
-	csip_db_new(db);
-}
-
 bool bt_csip_set_debug(struct bt_csip *csip, bt_csip_debug_func_t func,
 			void *user_data, bt_csip_destroy_func_t destroy)
 {
-- 
2.41.0

