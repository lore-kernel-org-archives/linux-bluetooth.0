Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A74C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6995A60FE6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhHQWt6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHQWt5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 18:49:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33317C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 15:49:24 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k19so231761pfc.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evc8LcD4TtrYEx4kHuvGKjEcl3Q5NYJf75iDzkjNm9w=;
        b=OkPu9zwo1h+X2E8KikDvBX6nZDPb82F7mZi9lw+l0Yv/tLASRBU06tp9TLyR5IyPtT
         l5ngoYDK+ozJpvfwk/YNMBMa9RXQCrnKAd7Vq9PBk11fOz2k2/9j8aFOrEo6I808pgrp
         MCgaFWHWjhT3vHR0DpWXpAisetV/y/WFyaXvvxZ+buOmRGjUec+r1fMZUtrPfYkd89aV
         kSbTGG9VBWP58cp+OIi8wc25JT8C0zdVRDTsdc/obzXzfXaGyMm068kJ6A4ea9TzlRwj
         jOG+FzzBArW97ATzC2XOIIYhMwjfSnPU83B/RBFpH+/n5h6TFPDYRP4MsbsCrKEjDt3T
         osPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evc8LcD4TtrYEx4kHuvGKjEcl3Q5NYJf75iDzkjNm9w=;
        b=JIyuMsIUniuhI2imrRjrkH49VDuj7RypDWuyi2oao6lYQc0N9vmJcQE8l17dI2HHDw
         /M70pfCQUanMcrWG5ITRlvVxzAze1UJezB7NPGuaL0qtFiqstkhjNSxlxcaaW6jnMrn/
         9RR6RbazAZgXSS3XaFO9TO5iU3QsMM3EkIawFD4XaEx3bU1X0I91LGmFSA2LsG6xIwmt
         9j6ls+IpNGmLhmh8YuvjazYQ9LpXF4sLgVl+OS0sRzxQHu0Urj0zqsemY2w+B4QJaul0
         pmO8RChw2MYENvUhiWh2ZBopcGgteUxAMCKj3rx213McIteOdSahZ3BRri864wzpNT2F
         pBhA==
X-Gm-Message-State: AOAM5323PQvAnvFkJEKHzJerp/OqqGhPe3iE0ui78nXHyNn9MoizzrI9
        W3fVeEJwMAYle6QMjRUK0fKXKw/g2UU=
X-Google-Smtp-Source: ABdhPJyXoo2t//J9LGN+ccVmLB6VoXxfqZCuxWH05xSsNqke+AYpi+SGFJRiw94NVDfj9yzLiHp17w==
X-Received: by 2002:a65:6454:: with SMTP id s20mr5617644pgv.18.1629240563550;
        Tue, 17 Aug 2021 15:49:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:9d2d:9805:b76a:427e])
        by smtp.gmail.com with ESMTPSA id x42sm3637823pfh.205.2021.08.17.15.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:49:23 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [DNM PATCH] Bluetooth: Build: Test patch - Do Not Merge
Date:   Tue, 17 Aug 2021 15:49:15 -0700
Message-Id: <20210817224915.413362-1-hj.tedd.an@gmail.com>
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

