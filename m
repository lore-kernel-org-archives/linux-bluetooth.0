Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A503C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Jan 2022 03:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiAHD4h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 22:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiAHD4e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 22:56:34 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F2C061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jan 2022 19:56:34 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s1so7436358pga.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jan 2022 19:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evc8LcD4TtrYEx4kHuvGKjEcl3Q5NYJf75iDzkjNm9w=;
        b=TpP8H8H8hYjr9fGjpYSUw1GgrFkH9y6Tw330ZgMNEIPE2f9PVa6kXRP/vzmMrrZBAt
         SUJs/kCZu0vfL17gdU/8gUsO1Onzx2QV24qYdVQAShEblJozmV7hhOz+2dLBwWm8pnA2
         MRbBhWee0c7qZUArIHdlfCULKIZY7sospHD97PWELleY5XqCWtr1sIH50V/jxCs0qGWu
         zjj3GnGj1yQiF2PIgbtrl0tXECwCzc/meigFRThrY2E92O/QJsazcfF/6xh7sZmugG5c
         EQCV6tt0ChRQQODach1o1tbSZuONNdohaoEcWz1mIgKalxeKkU53ITEtrDLTvtoEe7B0
         axzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evc8LcD4TtrYEx4kHuvGKjEcl3Q5NYJf75iDzkjNm9w=;
        b=zIcK4hhTZqkbRH+P9+4UxgDQlmEUHW+RqQZZc+HwRdTXcgE8QAuIT+UCkb+DePOgbP
         BP2ea12+X6G1FbNVH0ueD8AVTfM6kN6rBvqCzQQXWpEiW07/Q+pkLxoWpmd0ED9UTYk1
         V+Xn66/Va/80BWLfw3QTaPNNtlp9p2BnajKBVZaTsOw6lwSyr3sCB2La0XxC29j2tqpa
         1V7+zDhGCdSP4ba3RYHsw6sTjp+2P9o9Xmktc6JtrdtPhAMS2g+oI6BkypllLbCbIrL8
         fdf8jCUndLOr8wVS1XfHb1gCM1z+dUIs/wZSWEC17RvOHk1h/tFYAHmX41o7H9PqAV5H
         AA/A==
X-Gm-Message-State: AOAM532rZr1NjzE4IiowyxYL8SyPunJexjNoOYhOB7oH1gRc6mIPi/ap
        nxTxDegPDheBnctq8XHP5LW/S0EJ4c0=
X-Google-Smtp-Source: ABdhPJxO+txsunm++oerAINLnoDtZ4GCYKk0BZXgY2Pvz+XaSRLHWBn41xdqA062D+N8AdkkWEHA6w==
X-Received: by 2002:a62:b503:0:b0:4bc:1f47:3b26 with SMTP id y3-20020a62b503000000b004bc1f473b26mr47013079pfe.9.1641614194053;
        Fri, 07 Jan 2022 19:56:34 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:f5b3:233e:73cd:8e1d])
        by smtp.gmail.com with ESMTPSA id y4sm373995pjg.43.2022.01.07.19.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 19:56:33 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH DNM] Bluetooth: Build: Test patch - Do Not Merge
Date:   Fri,  7 Jan 2022 19:56:30 -0800
Message-Id: <20220108035630.273898-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Do Not Merge this path.
This is a test patch to trigger the CI test.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 669ac7c32292..514f2d6a9de9 100644
--- a/README
+++ b/README
@@ -1,3 +1,5 @@
+
+
 Linux kernel
 ============
 
-- 
2.25.1

