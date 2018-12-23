Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A588C43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED2621783
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elcJSiuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeLWKkr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:40:47 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:34257 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbeLWKkq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 05:40:46 -0500
Received: by mail-wm1-f42.google.com with SMTP id y185so17366763wmd.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Dec 2018 02:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=xtD2DUjNztFwrRyaeTLqscsn08U3I+wnbB3+cnxc/Nw=;
        b=elcJSiuz8y+KniOioP9RTj3OL+u0617SVGSFiVCFNq4nqjd0ZlbFYK+e08mbIZgK+T
         k7SdWu2hSkp3O+JRKfpkTe2b1ZClTevDtKl/oQlt2PXxMDvR0gh6WJumw8rZ1DDXns7Z
         pdjfUc+KWFoefdnE5a6wzCqBDymYSIIkDnxD7rtoUV/hyQmniJfkkEW9WU4QHyVbZRyf
         oXUFg2fssYEArlEgt852IOmSIUfQAINCmacMTEWC/4C4J+bLdsw3r2hfgXJoZYCCslY2
         5CY2oVpuoNs3cMvilJN5xuEbAzfjnDyWB2M1XtqCQzFwr2aKQ0hqERTKKVIl6zuyPWwS
         0IJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=xtD2DUjNztFwrRyaeTLqscsn08U3I+wnbB3+cnxc/Nw=;
        b=SguiI9tNjuWmlb5iszHw3GTQSuOJecgl01kaGsmYwKfjCpwlUgg3JgnnDHvTZAjVV3
         tZQGt1qbfd5J79ZmKUvbGw7zTAjbOLv/lFsY4Zp1hBBYzBYqMkd0D9rS1JyQN6Qfv8+8
         JLs46KsRBlNtKOe4nwx5VXu42ly28b0mWOiDjE5FIklM+jzSvZ1l5aipnz21X1f8pq3j
         lnIfQiYHaz+gXm1/EDUq1JXBPEN4o9QnanaWvD4gZnd7ISAaUVHAEALUo6tgt4Ub1WWc
         LCHFyqcz2h782+BAEqxQwF2tqLSuXzuDyl3qnr4sm7yjKOTpCIPwKtVjKwEBTnfjrVfg
         jjJQ==
X-Gm-Message-State: AA+aEWZTE5ONFztcZgkrm+GG7e4EzMMD0LXNEs5qt4pSRNGcenxtvXgZ
        70OWK8TGlXAc8nK/jTpZ8a8t+c3Osus=
X-Google-Smtp-Source: AFSGD/VVBfHOy+QhMSs+GEsvwTvbf5T3eTzYVeZmUJYx/adcmFqlmYsjJ6ogm2HbQQDufMhsHC1cZg==
X-Received: by 2002:a1c:47:: with SMTP id 68mr8501052wma.89.1545561644385;
        Sun, 23 Dec 2018 02:40:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id d4sm12168616wmb.25.2018.12.23.02.40.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 02:40:43 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/10] avinfo: Show Vendor Specific Data
Date:   Sun, 23 Dec 2018 11:40:13 +0100
Message-Id: <20181223104021.18620-3-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181223104021.18620-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
 <20181223104021.18620-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/avinfo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index 3f6cdbc0e..b79446825 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -228,7 +228,12 @@ static void print_vendor(a2dp_vendor_codec_t *vendor, uint8_t size)
 
 	printf("\n\t\tVendor ID 0x%08x", vendor_id);
 
-	printf("\n\t\tVendor Specific Codec ID 0x%04x\n", codec_id);
+	printf("\n\t\tVendor Specific Codec ID 0x%04x", codec_id);
+
+	printf("\n\t\tVendor Specific Data:");
+	for (i = 6; i < size; ++i)
+		printf(" 0x%.02x", ((unsigned char *)vendor)[i]);
+	printf("\n");
 
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
 		print_aptx((void *) vendor, size);
-- 
2.11.0

