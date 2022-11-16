Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69D8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 05:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiKPFZS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 00:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKPFZQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 00:25:16 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24371DF1F
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 21:25:15 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id g62so16447830pfb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 21:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6C7MWbDUBRf3F3qd/wUt5HcoXx9Wz8/ODwxCKgQzyc=;
        b=a3g1Sc9WO1E4wz/nmnFEFKiNqqU4lVFrcHFaAGyQBDR6YTHiwbHHyl9cXmBEKQwgHz
         8PyMX9z6Xdhw6WuabILZ25JJHxB1ycYN5rLGEcxxRljqB70tId2DOcuHJ2Ry3U8vpjVc
         Pl/ot1Up70c2gFeLzDxWbN1TgE2y7ycrO0kOIpLQqGFFRqkHxfwei2QtN91fKXBrZ24p
         1ZfXjiPl7xmRcODAV+By0VlB86aH/+d3GyAu/B6asGOof8ZcGhHaN/rteLz2RFgiMe3C
         ktoq/mB+S8py9FKFVlm0klwObXApJ92bPMwtuZHSWXbYR67Ca28hjX+nvN1qFvW1hqb4
         m5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6C7MWbDUBRf3F3qd/wUt5HcoXx9Wz8/ODwxCKgQzyc=;
        b=awHLFI40c1M4fTp4y4r47nPcuH5SrgSjClYsmKKzvr7KeXBONftzNJBxBf2fNvdn93
         e/89m65DKe+C8kFFiqP0pBvvi3yqGTnTbstaov+pM9bY2p3DjQrnj2oOKP8MTZ4C5JdX
         7fQACpQjDTQQekgxHQclzdcQ2sdK7/YNCd7fy0TMKoMAeNxJ9gwO/a24fCRKLE+tNkQK
         nF+VcW7Ogszmw/MgP0ZiKvJcqpqLWCMfg2EnPCZFMOQeq+zS5dwiLc33jmgSZa0rQ4lD
         jnZTGBky/SjswOZEWb0JXe9+GWU1TNKIl3dSrMAD9EY1mq0mawAbsdgYWxlBaQp11R4+
         1m6g==
X-Gm-Message-State: ANoB5pliBiJd2i47rG4bVhv5K8wiuSxCWvcCWikapLvHgMChIunlhfYm
        SJI7ATLuHgcESIBF6i+yTCwAJ2iOKuc=
X-Google-Smtp-Source: AA0mqf6xo4Ke+tM2wVA7m5GkgzTvfXv/FIlZMrqP+feCOyANBes0DAGhyVhODE+E2fxym/d1JF4ZWw==
X-Received: by 2002:a62:824a:0:b0:56d:93d8:d81a with SMTP id w71-20020a62824a000000b0056d93d8d81amr21818208pfd.14.1668576314902;
        Tue, 15 Nov 2022 21:25:14 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a80:cc40:e20a:cac0:723c:9cb4])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b001869581f7ecsm10884697pli.116.2022.11.15.21.25.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:25:14 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3] doc: test patch - DO NOT MERGE
Date:   Tue, 15 Nov 2022 21:25:13 -0800
Message-Id: <20221116052513.57081-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
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
index 7de7045a8..4bbbeddc4 100644
--- a/README
+++ b/README
@@ -5,6 +5,8 @@ Copyright (C) 2000-2001  Qualcomm Incorporated
 Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
 Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
 
+IGNORE THIS PATCH AND DO NOT MERGE
+
 
 Compilation and installation
 ============================
-- 
2.34.1

