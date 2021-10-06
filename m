Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C070C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8A061090
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 20:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhJFUOz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJFUOy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 16:14:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B56C061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 13:13:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b22so2447535pls.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tb8KnJ3skiflfLlObqVQY/XrKpSYGl1Yg0t7YexW514=;
        b=UNv7c6/HjOmwW4hboyu4sR/NwfgPIdedZmCbF3t4ASiNeKseoaUWnus+UEO6cpOHyy
         C+QMC8bbqvKSQtaLi4dmwRu3VfZJbtin9RW/okmpQwyPRLi8DMt2dD1soBKZjQ56UAhF
         QV/iSSpjJL2jWEI4J9eJYlS1SrQztsE7LnIaah//hFFNmSRSIKa5A47mpbUe/z+iClLv
         Yed0Nvev6MS83MVyV6SImvsjgXdUCkAEcC1TwbdBmq4mSUPWA7FBNuyK+1GKPOn7ORDY
         XRcsI6iiNPKrJrFLXMG2xnSWiZNwyDtOM5M8LQVbPruGC1ZGZLjnHSLIYG96SFLNAQ7p
         jEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tb8KnJ3skiflfLlObqVQY/XrKpSYGl1Yg0t7YexW514=;
        b=MldhVi/YPTNHTKLvQ+9KtQn2DpLQZLvgDtH284S6jeu/dbOYaFIWnFAQ4fWD9URXGl
         IiYjfNjGVU+cN+03x2FRs4O921m8UWzh8NF7CkdZG4tPWeSfNR22UC9IYPJ+Dvfm1v6u
         Y0GwQ8frd3hPWn1pScH3SjvUbFIYIrOXpd1okTj8954lKzCcQCKvTzjL3t2GZ/Gbv0c0
         wDywmsT72BxESoQk5P38bfRFKVi9OGmPfAp2rPkFvDmSbDDvm8LL5sFrJ00TbQ9yoX4V
         0PvRaEnBsZXk5hB9HpEixsNhf2WpG5UjgTncz427e68TH0T+widwaqtn7YG29Tp96A16
         x5dg==
X-Gm-Message-State: AOAM531lOwnS3CJy4nAydywzGMoJs1Bk8PNc+29mfUyFqNLQef2UY/3W
        0vxokvmnLUQp+s3JFnpHr2/6kUUSdgTV0w==
X-Google-Smtp-Source: ABdhPJztyK1QRUhflyMA9WOeq/3+KGWqb3VLjyVtGOY2gNLjjG1+EKgBS9/Z6mPJz8MFLwsaTl5TzQ==
X-Received: by 2002:a17:902:9a49:b0:13a:430d:7e8b with SMTP id x9-20020a1709029a4900b0013a430d7e8bmr12995091plv.50.1633551181546;
        Wed, 06 Oct 2021 13:13:01 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:8e4c:2d64:6206:9120])
        by smtp.gmail.com with ESMTPSA id b10sm16202006pfl.200.2021.10.06.13.13.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:13:00 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/3] doc/tester-config: Enable Runtime Debugging Feature
Date:   Wed,  6 Oct 2021 13:12:58 -0700
Message-Id: <20211006201300.186055-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds CONFIG_BT_FEATURE_DEBUG=y in tester config to enable the
runtime debug option.
---
 doc/tester.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/tester.config b/doc/tester.config
index 892fd5eb3..011475661 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -32,6 +32,7 @@ CONFIG_BT_LE=y
 CONFIG_BT_HS=y
 CONFIG_BT_MSFTEXT=y
 CONFIG_BT_AOSPEXT=y
+CONFIG_BT_FEATURE_DEBUG=y
 
 CONFIG_BT_HCIVHCI=y
 
-- 
2.25.1

