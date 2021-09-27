Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F353C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 22:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626D0610A2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 22:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbhI0WOs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbhI0WOr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 18:14:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325B0C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 15:13:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so251584pjc.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 15:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDky0jDvpTYuvBBjS2HANsAEHB+mwbbY05aD2BHjenI=;
        b=EwH1zM//cft/MW2rpNbyHJmXvS3UgHf8gA9wYMJNi90TMNtlJ9GC6YAdZll9yrm4NB
         0yHQN1SUk0hIDPvel+3YYXKVASTjpemTD8aB3D61auvQv0o4XBnUX1B7qjwgxzskTNKy
         9kJ1ukzU8CMAzZ1Vq9o7Jpl5Wpil/7rdFWjOLLtK1RmeCZBdfMdgV6zpmyFDm4zR3GG7
         7HUsch5Dwf93PcZCeP1LVLgdEHvyaKlXOn+7mYXcKTSCuLrlyPQlq/TPY1Xyp8D/58Gx
         roc5VRPW8vKdecPzHktYx/0yWBJ4B4Q/1+t+AWi9xAuaHiqy3ItZqvlpS5e7YH8KFsW6
         LpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDky0jDvpTYuvBBjS2HANsAEHB+mwbbY05aD2BHjenI=;
        b=FfSi4/eOPbDpnSuE6YVs1t/HYpb2Huj1wF8NNdsWwNb+wfjt/+IHNdDc4U1QzZ+oH7
         V6G6LF2dqswrpk/HNKwR8Aa54LN57ZGfeJJhm0+5rApC5KrfvTHkdhGv29MSFoBk5feP
         ya1qovu7pF2WG8QdPLgadM5njKKcsVVL7d/9KND7HB/pYDu+X4We7cyenQXFlL5gY+r9
         +lekNLT2pLmztUxQcCTzWAiMEt283vbhtjDeU7H2uizDQVUn6uDaRckOXsENgrlWOol+
         uNu1c2vtTJ6/kugl4+eEqIo0c+Rp3EIvMb+OTvGOQJOASDN5f6T3mW+Z0hja6hGAXYXa
         mmnA==
X-Gm-Message-State: AOAM531XCjn3je4FnPlb86Ch6nXOc8KEpqDRMXWYpjNhgLtf3oEsrnPt
        fPi3u9LdPe53fvYyq3dSDfR0s3+nzNw=
X-Google-Smtp-Source: ABdhPJy/1miZYMSZblBUmMw0z8w73cf4+rC3FcjxgWbYAcRSQU1jm5tgJrv4ohxkqVFUU/Tfu+UEwA==
X-Received: by 2002:a17:90a:4091:: with SMTP id l17mr313540pjg.138.1632780788563;
        Mon, 27 Sep 2021 15:13:08 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:76e3:83a2:7b9:4806])
        by smtp.gmail.com with ESMTPSA id d137sm19089497pfd.72.2021.09.27.15.13.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:13:08 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] doc/tester-config: Enable Microsoft Extension
Date:   Mon, 27 Sep 2021 15:13:07 -0700
Message-Id: <20210927221307.211767-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds Microsoft Extension in tester config.
---
 doc/tester.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/tester.config b/doc/tester.config
index 850fb6a38..1f912cfc8 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -30,6 +30,7 @@ CONFIG_BT_BNEP=y
 CONFIG_BT_HIDP=y
 CONFIG_BT_LE=y
 CONFIG_BT_HS=y
+CONFIG_BT_MSFTEXT=y
 
 CONFIG_BT_HCIVHCI=y
 
-- 
2.25.1

