Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8991C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 09:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE13220678
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 09:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="AnGBs3RI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfK0JnE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:43:04 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:37711 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfK0JnE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 04:43:04 -0500
Received: by mail-lj1-f170.google.com with SMTP id d5so23704448ljl.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 01:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P8Y1NxRRkMxAJnXXlCV+1zEg0UlTutPnZ6U8sPOQhNU=;
        b=AnGBs3RIV8OIGOZc26al8ya0zXOsFSeHhb5yheeq+ImWTMIJKPoYR3zXTAcQNtQ4T0
         lTtqzY4sd1BXpOkOGRCu5EbSl9gonUGg+BXu111Qx1fdCFKyyT1gjuvdLAiOT2AsvAGJ
         8raf/1wYFed3RpsFkCc9GcMYzFgvlnIZKBh1G2P6Lh07WejP0c8I9AZ3IZGM+1Cs+CZh
         i9l1jW6oG6ptalUoh3u3s6UXMSuo7qc2Qz+VisHICcxQj4HOy82K2y04gU8nFE7p+uly
         ahng6aG+s/6OUBgr5gO0vtgjBzqHMHy4SHRS7ig45YMGYgVxNzx9mP8nNDU4MtldjLWL
         u1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8Y1NxRRkMxAJnXXlCV+1zEg0UlTutPnZ6U8sPOQhNU=;
        b=aWRoX7euSN3WIRYzxhTijr/9x4F9BnPUpFBh0uK4qaUK6dgdZcQWNfEQjtyGAbcwCL
         Z0woULDHMgbB8+a/oAxJu/eyVhe+DAMYpdNXmhLJ/DlclNPGA4I8V9u3qlnLUL/eZEEB
         CoMYlxPD5Rshafhh4is/QlvgG8WutPCawzON9CfJJ8Lf0Zds9KExMa6eh5eqJgHgo+Cx
         XUdrPg24MNgK8I4Xjxe44K/GnuiBfroEN0VtcggkFj6x2J7O/2B3GHf41noPsa5P5EUi
         lDKqp4+SugVqEslYpLSiux3RklDya2ZHfwlwjE7nwC/JZKV5Oz5LqYsH5HXC3KxSOSS9
         Vc0w==
X-Gm-Message-State: APjAAAX/zqmpmT3P0GiUofOeP9+0M92CIOHbgQPO3T3ehTGSQcoD3kEx
        +N3M2+1RIMbvkpquvzIo0QawgjzqZnU=
X-Google-Smtp-Source: APXvYqxwUM/n/dQZVeahf5y52a3551vAg2B4CnTEbu8Q6YoaHUTv6RnX8U3U1jeBxIfd/wON4kMXYw==
X-Received: by 2002:a2e:8714:: with SMTP id m20mr18312616lji.131.1574847781835;
        Wed, 27 Nov 2019 01:43:01 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id t143sm2220860lff.2.2019.11.27.01.43.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 01:43:01 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] AUTHORS: Fix typo in Inga's surname
Date:   Wed, 27 Nov 2019 10:42:53 +0100
Message-Id: <20191127094254.4037-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191127094254.4037-1-michal.lowas-rzechonek@silvair.com>
References: <20191127094254.4037-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 AUTHORS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/AUTHORS b/AUTHORS
index db44ccf80..25d2e8d4e 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -100,5 +100,5 @@ Bharat Panda <bharat.panda@samsung.com>
 Marie Janssen <jamuraa@chromium.org>
 Jaganath Kanakkassery <jaganath.k@samsung.com>
 Michał Narajowski <michal.narajowski@codecoup.pl>
-Inga Stotlnad <inga.stotland@intel.com>
+Inga Stotland <inga.stotland@intel.com>
 Alain Michaud <alainm@chromium.org>
-- 
2.19.1

