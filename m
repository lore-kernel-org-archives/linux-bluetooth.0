Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7231CC433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5158D2070E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plKj0A5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgGQTPV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgGQTPV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 15:15:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D38C0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:15:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id md7so6852863pjb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ATkHjHvmlTIlEcbg7ocsMTKN2/DIf8EdCBGX5pPpsu0=;
        b=plKj0A5+0+pIQ5vMicUPmk9ttxFrwTUGYF8Xu/pS1rQl5/Og4uvrMV4/pUyatNu/Rm
         w9++F9MlP4p48IqyQqDmFZS590VNPq97qfr39iwycqZEFEI0uAvRBOMjLqy+nE9mfJ4P
         a80Nw/3OA1L2J8DZwNnbq+JbC807pZfCt06ljRP7xo33S9BSO4Zyze9pNdUBtoGSRUuC
         ooNn5aQq2V3Qv8KmzB9OVA/Vcs2IkP/AtdhhBV/Q0Y6wHVk1vhBPo/W8SBhPuWrUUFOV
         Q5SR1tksMlKdZXEJQs7HGAgwCWO+yPEna1o5LHJJMXueYMhxDDO+u4ZP0ebNSDlMrqAo
         taLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATkHjHvmlTIlEcbg7ocsMTKN2/DIf8EdCBGX5pPpsu0=;
        b=SPRZUQWElscndWwOSiOBfal+AoYUez2UcywOrRJ3onjYceVF6Ue4BllhZOpHqM+TDr
         Y4AH3GtVa2FAi5RCPynVoHLfcf0P/P+s9dB47Zc4f263TGRf1OdiExgAUXt8XnpLBsr4
         6bme2a/7gQDKhTHRZhEFtKZQ1NmNbhJMCCkNQtyup2EFRIsny5nULDuFCArDQ75HFpzt
         EVRvu/N1flYVSs9FX0sn/KJGWwG+7I6DnTrGsXAMmTsbyVbVAMg/uAQcY6pYfq68U5Ft
         h6BCDQz3Epe5D5MJIxX9nCN2xHyvvctYOluAt1XnBcz5IPx5kpllyOBv6jrkmEr0n8wG
         deAQ==
X-Gm-Message-State: AOAM532dl0mcT4Ajdn8/NE/7bxsMy5EB8GNzRN9YSTyf2VCNshRgdrbx
        53pNLeLxUhMFoTkeOSI9bNR+Uj2EWn4=
X-Google-Smtp-Source: ABdhPJyw49NmFaXrDTbQS4uSKs61ZibUHgBozKcj+P/SioV7SyLcuo36bh7yxaTEioXdaj5xl0c+Sw==
X-Received: by 2002:a17:90a:c28f:: with SMTP id f15mr11555127pjt.72.1595013320253;
        Fri, 17 Jul 2020 12:15:20 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p9sm6488334pgc.77.2020.07.17.12.15.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:15:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] shared/gatt-client: Don't remove active services
Date:   Fri, 17 Jul 2020 12:15:14 -0700
Message-Id: <20200717191515.220621-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717191515.220621-1-luiz.dentz@gmail.com>
References: <20200717191515.220621-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If discovery was aborted (i.e due to a disconnect) check if pending
services were active so only staled services which were not completed
fetched are removed.
---
 src/shared/gatt-client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index e21aca1f0..409a3ee57 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -412,6 +412,10 @@ static void discovery_op_complete(struct discovery_op *op, bool success,
 		struct gatt_db_attribute *attr = svc->data;
 		uint16_t start, end;
 
+		/* Leave active services if operation was aborted */
+		if ((!success && err == 0) && gatt_db_service_get_active(attr))
+			continue;
+
 		gatt_db_attribute_get_service_data(attr, &start, &end,
 							NULL, NULL);
 
-- 
2.26.2

