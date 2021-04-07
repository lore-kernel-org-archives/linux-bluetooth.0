Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6892C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 22:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764676117A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 22:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhDGWeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhDGWeE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 18:34:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F9C061760
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 15:33:54 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h25so14139552pgm.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Apr 2021 15:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fafjcnBq2URM0Yjq6oNkQGwvUKtRbkBdR7ZQ9xqwnLI=;
        b=P7gvirZPj4+k7uUeuRVLQH39fjM7G5d+ltYQK+aQStMMnlCKcvvg0TPNund33LoZO3
         t744kXiq5kbNC94LdveHl7vhjGDopv3UGo4pMDCjku3uf066RxrGaLTt0zfL0DiVQaSG
         3yLFHjbMrSRgkCdAJMFuJg4/wxl8SUZbJzqvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fafjcnBq2URM0Yjq6oNkQGwvUKtRbkBdR7ZQ9xqwnLI=;
        b=KUS/FoHIS1Ucfz73MBovNWvay2DEGAN+Cqi5AajcAoDuD4F+Gc9J3xC+1XhB/+ZIom
         KBOlr1iMPePLLUAPouM/y6/tCEDAbE6f0p30e912AorgudIYomshdo0loBqNaOwgtBBd
         phZen+B1uLYUKq4a4WceU719fgXCsNRvDpx0rNaLRHT3mCjr+XgcupGD1wJmZp2ib2sx
         65x1oCjEPl3Ovn6qRb9XeURgueUxVgUZCEB5WOHknh6ag0SyCQedl2T6HLpu+LZ8gxJd
         j1XiJysLCEPMtaJAsHLNYe7iCeFxIkIsnpheOHGbewljXYll6qAfaznPvbfid0RPcECk
         sfAw==
X-Gm-Message-State: AOAM531PB4wPaFshR0ELvwf3o1w1QiWCYbkRLPPdxo0iAtikHPqZQfZ2
        XUYmZ7RjTCoe9F4FZYXXiCLLAJ0WM+wptQ==
X-Google-Smtp-Source: ABdhPJzaBtj9cUOJX4Bjek17YLk/LC3EYcOFMN8zFtfdtq1klyGXjy5Y/QGRLJTARmZmIN4LGPghIA==
X-Received: by 2002:a63:be0f:: with SMTP id l15mr5302966pgf.39.1617834833438;
        Wed, 07 Apr 2021 15:33:53 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:c572:df03:d9fe:57c5])
        by smtp.gmail.com with ESMTPSA id kx11sm6072674pjb.21.2021.04.07.15.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 15:33:53 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH BlueZ] input/hog-lib: do not silently ignore missing connection in read_char()
Date:   Wed,  7 Apr 2021 15:33:47 -0700
Message-Id: <20210407223347.28669-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Dmitry Torokhov <dtor@chromium.org>

Currently we silently ignore missing connection (attrib) in read_char(),
but not in the other GATT interfaces (such as write_char, discover_desc,
etc). The code should avoid calling read_char() when there is no active
connection instead, and logging errors will help us trace the offenders.

---
 profiles/input/hog-lib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 6ac14e401..6605538cf 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -181,10 +181,6 @@ static void read_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
 	struct gatt_request *req;
 	unsigned int id;
 
-	/* Ignore if not connected */
-	if (!attrib)
-		return;
-
 	req = create_request(hog, user_data);
 	if (!req)
 		return;
-- 
2.31.0

