Return-Path: <SRS0=Cegh=7M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEC0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 May 2020 08:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3510207D5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 May 2020 08:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G/GWKKak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgE3Ivt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 May 2020 04:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgE3Ivs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 May 2020 04:51:48 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5C5C03E969
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2020 01:51:48 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id v11so4857089ilh.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2020 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2JYXx1mPmf36Y1KcnMuU9nUJEbc+gfpMtGGz0p9DGE0=;
        b=G/GWKKakm7gffN+DL5lOymQvJmv9+ZqY7oeHkHLJsbP3XRwktvBTRZSA1wXCWi6fEq
         z/rx/B4PLvO+r3bfVE1PMbLM0AyBOXcf+CZaNIBmAX1x+jIWib6X61rzsI/b+UklyEfr
         owhUfK8HnzgUFEdiCXP14FU2epJcW5Mmw+3HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2JYXx1mPmf36Y1KcnMuU9nUJEbc+gfpMtGGz0p9DGE0=;
        b=pUGuDjPa6Y58vZUufjFMbYh8uykmXDzdtB9Nc+U8dlyi2Mpw61wOzrKYLdvQSr/BaY
         roMmvClHLlJDLUDMf+zLBE7Svvznb33v/uF05usduUtqmH03FmqvO2/oue9GJx9eO9s4
         RhDwnKcROXpppMmLvwd/tD/Q8BVmFZ6JJYqux47RXNeDa5vJegV0LpDpDds3VhhHh3yc
         /gnAptssnP/pvfvPc0+0Z4sDRoMPbmqRYrbHOh2w/5b3vn2R1+IzOBKLKEzzK8KhPtJo
         AQjaNtEWDK1j95OPxrjHR0PGNWYkjEMvAT3y9Cfz88s1sQaCxuim8SGeM1W9UBZwqYsU
         H82g==
X-Gm-Message-State: AOAM5306FDy8BLZi3Be+7dHioM3d5lcWoFViZWA4Xt+yyJLeac4yBgwn
        /4zUT0kpRQCZCLsPHXLpSgZkMnUotffiyg==
X-Google-Smtp-Source: ABdhPJzLqknMgz6wuQ7KGgHGc6IwQM148fNQRGVlfH3Bvl7N4gIP426g7l/Tbrv2UCKOSExN/6NvSQ==
X-Received: by 2002:a92:894e:: with SMTP id n75mr11514496ild.271.1590828706868;
        Sat, 30 May 2020 01:51:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id z3sm4920321ior.45.2020.05.30.01.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 01:51:46 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] a2dp: Fix ref counting bug of setup_unref
Date:   Sat, 30 May 2020 01:51:18 -0700
Message-Id: <20200530085118.10703-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In a2dp_reconfig, setup is ref-counted by cb_data. However, in the fail
label setup is unref-ed but cb_data is not cleared. This may cause
double unref in the future if cb_data gets executed. Instead, we should
do setup_cb_free to clear cb_data and unref setup.
---
 profiles/audio/a2dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 0d877b132..1b92352cf 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1719,7 +1719,7 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 	return 0;
 
 fail:
-	setup_unref(setup);
+	setup_cb_free(cb_data);
 	return err;
 }
 
-- 
2.17.1

