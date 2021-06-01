Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC4EC47080
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 20:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C9A613C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 20:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhFAUvE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 16:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbhFAUvD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 16:51:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1797FC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jun 2021 13:49:21 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f22so500489pfn.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jun 2021 13:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdJNU0zP86fQfsZY8fo8y9YbQomtTm+qfzfDCYZeLvc=;
        b=ufn8noxdawMKqHal66p+ZcdLa4+RQQ6yIxc+YL1YBJE0t9/4zg+G2GUlkwQwoFXrtR
         OZwOWuTjPBY3xyev7hOhAOflidF/5YPYF8qosWbCwGF+meIxZlSWxqEDdiCVL208IrGB
         lGEh2e04VyjzvJiRxMnv2II79yR2eAHGo5vUYZwL2RObAdcJRy4k/VGP8lV9/cgbZ/Vl
         1UKGrZiEuGUkOokIyJiWDnejb1lR7/AtgMGQZKBKxNnreTuZ14OhIxl+vXq+/cT8AB0p
         D+EV+UX5Lv4Lo0ieX2UiF8GekHiX1FgEl8HI4Fdtr/l2osTVw6xXiHj1Xoe6vxBsNz7R
         O7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdJNU0zP86fQfsZY8fo8y9YbQomtTm+qfzfDCYZeLvc=;
        b=MzkiYybrrb/HenKAMhjR0b5pdJJwF3A8+4IkYk6oO78mvqWWNi97/sbQyDQGFPuYwl
         DfZllCQnnnzrvS/SWePpSbUWM15saZFxte+RCxzxdG7fyr9P18w3c8TcYdLcoSjt4ab6
         bRxXHP5jYvwvzQ4qicSpguJomkooaqFDlLfVEkEtdtvEp18cz1rwPPMCao8oaRNyTo43
         J//0H1rBEXh9isFVIxf0+011CgfumnWCQkiTbSfEiEvqIsmTOLepKso8MOT0ULC11sjz
         tpyTbJ9cL45YBdBMUmMQ2n6xwNscXZUDz6xWXg62L12D2rgNKOJbriG0r0NRO3eLdUP7
         Kc5Q==
X-Gm-Message-State: AOAM530nrBjwhB3c9PygPzQkVbYWEakOkYyqWES0Xy1ys4bSfghfInNG
        OB46YSCjNLO3+HY4R8wH0lQZZEMovdo=
X-Google-Smtp-Source: ABdhPJz3dorF4i6yy58FC3kiQXYfoSCBVKAYBfuvNnXH4msvLUgZ+9v/djsOIxDxYpUP5dOzWJBxXQ==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr29229956pgf.216.1622580560462;
        Tue, 01 Jun 2021 13:49:20 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id t20sm11435396pjs.11.2021.06.01.13.49.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:49:20 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH V2 1/3] emulator/btdev: Enable LE Privacy feature
Date:   Tue,  1 Jun 2021 13:49:16 -0700
Message-Id: <20210601204918.903327-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch enables LE Privacy to support LL Privacy feature.
---
 emulator/btdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 692fabd71..13abad577 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5415,6 +5415,7 @@ static void set_bredrle_features(struct btdev *btdev)
 		btdev->features[4] |= 0x80;	/* 3 slot EDR ACL packets */
 		btdev->features[5] |= 0x01;	/* 5 slot EDR ACL packets */
 
+		btdev->le_features[0] |= 0x40;	/* LE PRIVACY */
 		btdev->le_features[1] |= 0x01;	/* LE 2M PHY */
 		btdev->le_features[1] |= 0x08;	/* LE Coded PHY */
 		btdev->le_features[1] |= 0x10;  /* LE EXT ADV */
-- 
2.26.3

