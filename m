Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05E2C4167B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Dec 2022 00:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiLZAsJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Dec 2022 19:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiLZAsI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Dec 2022 19:48:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D5A2DEC
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Dec 2022 16:48:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 19so2609221plo.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Dec 2022 16:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lj8DB/E+MHVa2rvROd3IiNY7hG0tWW3VWvMIGA+blE=;
        b=loV0JfQtwwKGiVY8FLwQpZrV/pmUDSjkof8fzg6VsmoiJYfO4A8tMTZs4GIB/GCWVB
         aud3qUbhlVskV5+yCnYVy0o/IXDgiTzKu3pUoQsqaxPjT7Q8tzZ6mUM1hyNSutrpm5xB
         DYMyGte2+LTm/ZzO9hvfXAx7ctOewO4SAmRjqpTa86r2dJMTU3aazJ9oMWZ/LXUhNQXE
         1eZiNgB3O+X9SCnyF/wT22V9lJTw0yZjt2bW12j2BwZEbDCRmEsuThTTrUHjwqU/hvnI
         LGC5nvjn1CN/6XEp+RLQjoyGfYmz2bBE2yZzYvC+PzChLLfAwMMmbDnOmBdLCC0oV2rC
         1r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lj8DB/E+MHVa2rvROd3IiNY7hG0tWW3VWvMIGA+blE=;
        b=3NmxMORFx53Er9FuzGf0WHcQ6COwWDdlBq318gUzAIRZsAmBM/NjLYInyRCxZhd1Ao
         plNzXl+dTpnmudEH9duxeDIpuI1MmEpX9UlnlmJrLeS63/6nthNa0T6xuC+mWh1AmHot
         +MiFE/58kVE53aN7pnR5kpK8Gjs757CfuOq3ieFoPf+fksXmmxlt3W1dzO2+W2gch5/a
         6/aquJGaYkLIdAJUOVZ8GFoZ3BT/0Pu7ZESa4n1h83y63eoceHgaoLUzCK9DDNN8Nh/C
         S1flfIgzTSI1taEMbD6amm6ml+DCL4WETK68F94GbxZk4pWe111BQ7UrJg9a7XSq68gg
         6NxQ==
X-Gm-Message-State: AFqh2koy3xKsk96Vfr7lGJP/g2kqNYDjNw9zxoGd7DNTT1mDhtyA5zW3
        XPAWY57pazlOl+3vh5xjUOTNvtXRsNoHlQ==
X-Google-Smtp-Source: AMrXdXsZe5bLD3iSJYNzwxkTzjhdqrY5L+oc/ul0SS6aVbWyyaFWmJbA5/xLJNn9CY5yJc4w4uRZBQ==
X-Received: by 2002:a05:6a20:c1a9:b0:a3:9598:e5c5 with SMTP id bg41-20020a056a20c1a900b000a39598e5c5mr40400009pzb.35.1672015686582;
        Sun, 25 Dec 2022 16:48:06 -0800 (PST)
Received: from fedora.hsd1.or.comcast.net ([2601:1c0:5e81:6f50::f30b])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a688800b002135e8074b1sm7751926pjd.55.2022.12.25.16.48.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 16:48:06 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [DNM BlueZ PATCH] doc: test patch - DO NOT MERGE
Date:   Sun, 25 Dec 2022 16:48:04 -0800
Message-Id: <20221226004804.107211-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This is the test patch and do not merge.
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 7de7045a8..a03cd4d73 100644
--- a/README
+++ b/README
@@ -1,6 +1,8 @@
 BlueZ - Bluetooth protocol stack for Linux
 ******************************************
 
+INSERT NEW LNIE FOR TESTING. DO NOT MERGE
+
 Copyright (C) 2000-2001  Qualcomm Incorporated
 Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
 Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
-- 
2.38.1

