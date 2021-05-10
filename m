Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148BFC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 19:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1C0610A7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 19:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhEJTw7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 May 2021 15:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhEJTw7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 May 2021 15:52:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9072C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 12:51:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m190so14134979pga.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bc5lxIfBtVlnPSEib6h7Hdx3730QWweHnTFAIhWB/bw=;
        b=PooZ7MEdi5ynjnzcFppX2fhAy7HrgdwNQ/ffNkNJ6xwg8/pw555ETo6phsoLwu4d8/
         y4hy+ejZr48bNvDVW8N1Da+E39yysBfIjITR1AeRSkSNnNYm5tvTsgLBlBNnyRZqEmhc
         9rOsCNa6V7whn1CO+EVaC8FmY2/dk4b3YFke88LYw2X6W41rC/VtL/+33CeidnnIK3j8
         xaLx+SCdWxV2ksC9lgLw2obrbAn8K/Y6FfgWpJIymChJjJ+NB0DhQrYsdPCv93KQMb8Y
         X0E04ikYTc//2VZaFm1A+NYcS8l+FbLZgqBtkWpb0VM04wngPh60Thjp+wkdnoj3Zzmu
         rXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bc5lxIfBtVlnPSEib6h7Hdx3730QWweHnTFAIhWB/bw=;
        b=CrSPBJxGUrVPtekrJ4gH1y8KduiHIhY79VAkl3S9wfGK9T7wz5uSHNNEIXiMMZLyjm
         euRISvK908RatWbz17iOT8XG1wU8jznqC44dYNzMphUf9wIIkpVK0wH5BPyJjnt5sxWf
         NkTxvlQLpd5gNAIiVveav+UlXCqO8SiFrsSh/FPi8xu/8luKfodGOcpi/zcVUj2883dv
         nsZHzQQ5uwjvdPHJwdvQM/vmbZDP2S1Ve0Sd492Jwm9+GKwe1LS/veq+TuI4QUITUjL8
         Kdf3yGG+dtlF9N6klfm2+KWS3PALVzkDbzPA7m++ChHGNTgXXkQJrFIN7awSG8JQVJFH
         rDQg==
X-Gm-Message-State: AOAM531YUgEsZiBOPuaTtTxyILb6B9CPRSTQ/fgClFh/bwu1HWzazB/a
        bb/ZLZGYGJCwseomdTUnKxZ2IVh7T2i9gg==
X-Google-Smtp-Source: ABdhPJxtbdd9ZAiNIb8GrenpOidqd30ahUFYuoEHlha+fu5NV/UYsA8muNGcktW/fT8V7o12JEVLJg==
X-Received: by 2002:a62:6d05:0:b029:250:d196:1fc8 with SMTP id i5-20020a626d050000b0290250d1961fc8mr26729953pfc.21.1620676313141;
        Mon, 10 May 2021 12:51:53 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id l18sm238161pjq.33.2021.05.10.12.51.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 12:51:52 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: DO NOT MERGE - Test only
Date:   Mon, 10 May 2021 12:51:51 -0700
Message-Id: <20210510195151.1424906-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch is to trigger the CI test only and do not merge this.
---
 README | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/README b/README
index 669ac7c32292..0d2f61272c43 100644
--- a/README
+++ b/README
@@ -1,3 +1,6 @@
+This change is to trigger the CI test only.
+Do not merge this change.
+
 Linux kernel
 ============
 
-- 
2.26.3

