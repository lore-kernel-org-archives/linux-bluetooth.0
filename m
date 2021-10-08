Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110B1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF2060F9E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbhJHTi1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhJHTi1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 15:38:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B413C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Oct 2021 12:36:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g184so4050252pgc.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Oct 2021 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tb8KnJ3skiflfLlObqVQY/XrKpSYGl1Yg0t7YexW514=;
        b=TcjUi+lovGvlow/R/ZF85WDOODVEn3ApxdYgOHReMhqDw+x8v1u8C62mhvw8ykzTET
         cW1LMjE5IbpI9xIQENWh3MwwSbeQ2JE3W3fyNf9DCpe6ABO3EkxNq7Js4QubKJcGYZ69
         zYufI410ur8Fr0BTWcvpigUUMw4mLV8ELv+lI/7CQfkSpz1vHl53mvd6LLVbSPCkvQap
         NTgLjEwngKvqC0pBtcGoBE9eU9CFmOfKKL80ubwyGk3OcZ2fDEeNTJ+ZOzgk55v/fDAc
         AbV4vuqpEfR1Q5eYCZqid/neF+R/AXIUOawcxUKURvgZaJJgyFWyo/Juz5kdZsddCEIg
         YiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tb8KnJ3skiflfLlObqVQY/XrKpSYGl1Yg0t7YexW514=;
        b=hWuL2cF10zT9w9LTrRRfQgET3cYCGBrnWZSCEKnZqfut8vQeFbUaX7pR62LT3BOgmQ
         ZLJGldoLiK3SGgs4lFAj1lD601DW061cjLD3cwwmK3FjSo1Xcr49hFDs2K7J8I1PQNW4
         kBboHQGCvaRa0mDGF8iTLekmMxGygMB828zuGYhcP5OAvAswyU0d4YhVjI6CALM0GA7a
         x1zNJBmJKM2uWghfzkV+xS8Op1WtvUD7AigDPguexQZAchPcPfbc5O+3WunomsQBed92
         5a27jNLNv21zgFePIMg4pRZ8VYe3rvUc7kxF8GkgQ3LxtUDL6xBnpG58ooL7rEmaeTsd
         V93g==
X-Gm-Message-State: AOAM532Ot3b/66jhPzEQhAtuNWY61zXOhaGJ/58SJHegz0fcAWbWdeIf
        2ghB8yjuw3b7mey/gG2u3Lf9hE7ZH7f89w==
X-Google-Smtp-Source: ABdhPJycEoi38+fSjrVtTPjp5G5y67NYC7ruPKEDPH5jydOoL4cXDb8QSGFWttBStshLgmmlLTn5NA==
X-Received: by 2002:a63:5b1d:: with SMTP id p29mr6202350pgb.301.1633721790801;
        Fri, 08 Oct 2021 12:36:30 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:3e91:8dc3:f28b:c60b])
        by smtp.gmail.com with ESMTPSA id g23sm137616pfu.71.2021.10.08.12.36.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:36:29 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 1/3] doc/tester-config: Enable Runtime Debugging Feature
Date:   Fri,  8 Oct 2021 12:36:26 -0700
Message-Id: <20211008193628.39347-1-hj.tedd.an@gmail.com>
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

