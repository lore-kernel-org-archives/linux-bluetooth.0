Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E26CDB465
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Oct 2023 00:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjJQAWI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 20:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJQAWH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 20:22:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541D092
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 17:22:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b2018a11efso3360915b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 17:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697502126; x=1698106926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4wgzh3mOCP7wlv+sWzfFSITlUpuF8QS9eF0cltOs2U=;
        b=CllBKMHNnxfo2zQ07XCKk2OZniU3ivDD8Qb8YPb5O9v4hMdFh1dCjRQFdGusJR4ovZ
         JbUAvVYOdEzCnnux9q4hADLETjE4wddkSrbsk5LNBvQRjojeZYfM/cK1OeSS+PR2vmD3
         aev9XxG1F2sLycZswjClMjkE02tqJp54r+Icvqq+1rJg+z9mdcdulGPgoaCJorgMWQEj
         zkIhtJMT6ryj0nq4bh1YIWoMU0jiVAD+n/ENzJ24sdhbyZDWi3+9BKQZWiyE1hMsRqW7
         BjyTJuv0OgY1b9n7YBRGmp7guSXNFDHG5P5kdu5U3xqf2Al3IQFAG0EF4729gQDTLw21
         dTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697502126; x=1698106926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4wgzh3mOCP7wlv+sWzfFSITlUpuF8QS9eF0cltOs2U=;
        b=BXQbY1sXkIu5dNRwLGTNEmLijncZED7hjSrifVjNbDVM26n7Zk2kugE/qbRZT2LRnA
         CRGmNsjbYhIjbf/UZg5fWitl71T23JWgpe+c/yYqPObCP3sFKGR52EyyQexBnRtaKyOk
         WFeeRXKf1lu6xCGys+vrjE9mCZW8I4qwyLrr3R691yVIVNXA6kmPiAzYiVNQWpTLLuAx
         g0lW+qklhg1vrOfrRfoBAeLYePzt+NsbyeGjfky1ebQzzvJ7Ymjh+talevXBLksaZFNE
         Wjejtqg7UXUKX+xSnqA+rrYMkMXJwhafaIi3RmF6zITl3GoWgvZhGHU0zKHmQojHGY4b
         TyFg==
X-Gm-Message-State: AOJu0YwvuUHPfEDjn1Yi8cLRbPaaNZvWPMTqsRU1JcEnXdsMDextZQpT
        5u/qKXt6+l/GxMpAr62gQCn/ew6YMIizGQ==
X-Google-Smtp-Source: AGHT+IEQPUOqZzuKIRrQGxpiV+1Tu76QPBVcgBFx2yOmNrUG1yKimUKIjkRiKJjj8xPOznyNnpkRuQ==
X-Received: by 2002:a05:6a21:35c8:b0:16b:c22c:f99c with SMTP id ba8-20020a056a2135c800b0016bc22cf99cmr510392pzc.32.1697502125625;
        Mon, 16 Oct 2023 17:22:05 -0700 (PDT)
Received: from fedora.. ([2601:601:a480:c78:c3f1:c438:9351:a6f1])
        by smtp.googlemail.com with ESMTPSA id i10-20020a17090a2a0a00b0027cf8869ee7sm32481pjd.0.2023.10.16.17.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 17:22:05 -0700 (PDT)
From:   Inga Stotland <inga.stotland@gmail.com>
To:     brian.gix@gmail.com, luiz.von.dentz@intel.com,
        linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@gmail.com>
Subject: [PATCH BlueZ v2] mesh: Fix check for active scan when using generic IO
Date:   Mon, 16 Oct 2023 17:21:23 -0700
Message-ID: <20231017002123.43533-1-inga.stotland@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modifies the check for an active scan in generic IO:
the bug has been introduced during earlier code refactoring.

Fixes: https://github.com/bluez/bluez/issues/625
---
 mesh/mesh-io-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 00932ade7..13a863b48 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -781,7 +781,7 @@ static bool recv_register(struct mesh_io *io, const uint8_t *filter,
 	bool already_scanning;
 	bool active = false;
 
-	already_scanning = !l_queue_isempty(io->rx_regs);
+	already_scanning = l_queue_length(io->rx_regs) > 1;
 
 	/* Look for any AD types requiring Active Scanning */
 	if (l_queue_find(io->rx_regs, find_active, NULL))
-- 
2.41.0

