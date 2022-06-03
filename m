Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B12C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 21:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbiFCV0u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346661AbiFCV0t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 17:26:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3432A7
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 14:26:47 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p130so2557076iod.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jun 2022 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mnufs1BjSjdmozj6JABcVVrpVW6MAUqL07hbBNcOciU=;
        b=UHxFjtdBWGl+XyZQJgo1tVG54QqU8Gjiqvd290y46RDAS3li60l3aWxhyMA2D1sX47
         RV2fm36ADUpn95DDrz1d1IrxqNsODEnZ0l+qmhmUuMYjIgkZHX6imPCKGpmdiM6FN6Eg
         k77oLKWRkip4M5wFWrqidCS0IpoDSkMDk/RBogmTbz/KTFdNW7sHLVJ00ZSE+IdlxP2S
         x6Z842kLxuUfhO26BsYVxIYD9ryjpCAnl8MBl4WI5ZcWOpYmA7Xas90yCycKJlWg3VwK
         5SaY3AlhrR6Iy9CXWfShHLEXDHAvfKEZoCODymr/atAF4SvpAMljfXCM2reOGK33uvnK
         SMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mnufs1BjSjdmozj6JABcVVrpVW6MAUqL07hbBNcOciU=;
        b=UFw5cb/n7JTPERDM50A9lNnvEkc68ceZgasrMjBPhYhnlnoqulu+snCRmEugZ70Nir
         PkGb5ym810nUpgM9PxnoLmWta6elnJxBdKhC/5sXWdJIi2ryX8ypwXNhb92Ud8qwjtej
         VoMuz4GB5wMR6tRLh+BewW1xmNPxTDBwAIl6+ZYTN23YTtC3WmIx8gfqgfsxEk3W7jeH
         w5RxcGuXPlkfC0VIfyVmk7iVf5FbTxjeML1aE2nBL82vjUAuKak4Z6JDUhFcd4M/drNE
         /dbMM4DkCSy7583y7/0GL8Iz+6QTKsKNJZIAMK8c1ubxN3+i/HVfr7ZSDouZdqNAAtZW
         SDqA==
X-Gm-Message-State: AOAM530iYsbo/iurh7tSmImzCzKnzaR0XBQJVh32NJ+71iarYLUkT7+J
        tXe5iZHyFlRgRfcBS+0d4u8HeiNrvB4=
X-Google-Smtp-Source: ABdhPJwfADS1hhq0efjk6Mic85gp10D4GrjcKVx9E0Btj5sVqYlIiA2KvYpNBDSFC4UtAMGesPg6bw==
X-Received: by 2002:a05:6638:300b:b0:317:a127:53ac with SMTP id r11-20020a056638300b00b00317a12753acmr6380841jak.77.1654291606751;
        Fri, 03 Jun 2022 14:26:46 -0700 (PDT)
Received: from localhost.localdomain (c-68-47-51-143.hsd1.mn.comcast.net. [68.47.51.143])
        by smtp.gmail.com with ESMTPSA id t17-20020a92c0d1000000b002d3da8e4af5sm2981806ilf.23.2022.06.03.14.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 14:26:46 -0700 (PDT)
From:   Michael Brudevold <puffy.taco@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Brudevold <michael.brudevold@veranexsolutions.com>
Subject: [PATCH] doc/coding-style: Update URL to kernel coding style
Date:   Fri,  3 Jun 2022 16:26:04 -0500
Message-Id: <20220603212604.13758-1-puffy.taco@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michael Brudevold <michael.brudevold@veranexsolutions.com>

---
 doc/coding-style.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index f0bf880e3..e73158840 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -7,14 +7,14 @@ some level of consistency among developers so that code can be easily
 understood and maintained.
 
 First of all, BlueZ coding style must follow every rule for Linux kernel
-(http://www.kernel.org/doc/Documentation/CodingStyle). There also exists a tool
-named checkpatch.pl to help you check the compliance with it. Just type
-"checkpatch.pl --no-tree patch_name" to check your patch. In theory, you need
-to clean up all the warnings and errors except this one: "ERROR: Missing
-Signed-off-by: line(s)". BlueZ does not used Signed-Off lines, so including
-them is actually an error.  In certain circumstances one can ignore the 80
-character per line limit.  This is generally only allowed if the alternative
-would make the code even less readable.
+(https://www.kernel.org/doc/Documentation/process/coding-style.rst). There also
+exists a tool named checkpatch.pl to help you check the compliance with it.
+Just type "checkpatch.pl --no-tree patch_name" to check your patch. In theory,
+you need to clean up all the warnings and errors except this one: "ERROR:
+Missing Signed-off-by: line(s)". BlueZ does not used Signed-Off lines, so
+including them is actually an error.  In certain circumstances one can ignore
+the 80 character per line limit.  This is generally only allowed if the
+alternative would make the code even less readable.
 
 Besides the kernel coding style above, BlueZ has special flavors for its own.
 Some of them are mandatory (marked as 'M'), while some others are optional
-- 
2.25.1

