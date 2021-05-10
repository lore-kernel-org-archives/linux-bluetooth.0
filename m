Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDD2C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 19:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0054613B6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 19:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhEJTlC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 May 2021 15:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhEJTlC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 May 2021 15:41:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CDBC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 12:39:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so10679606pjd.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QF1X3NIy67heKgSIBYv+j0GhDC+6bYE3LccyFvUs09M=;
        b=Uhqe5zbme8deeidVCDGgduijbtSmyNQAXzd4lw5LFB+erR1RBnyt02p3jRd4jtijiD
         xhRNdn90nK9LaiTGaawEslZgjE0BcUl/hKRMD269a6D4kEOqZxTqQJ73YsfReWRtPg84
         DkzUPvX9nOa2d3PgmVZ3/uOA4YZaK9GK5+nzAf5z5MBCgRmsPzuoX2a5SrrabmsSzdhb
         AaSrhlV1eM3qdqxMKtla3HUbTtsmJ4K8n0cyKTf4VSznx3y6SnPWJADqprNM/iRYZUPv
         LjQ3vHIif0eCNkB2JE9wKEFMeOr/2H8gHKw/O0VtgyAB/xd9YM2489sLfdkIceoq9MxS
         JZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QF1X3NIy67heKgSIBYv+j0GhDC+6bYE3LccyFvUs09M=;
        b=tosP4HmPfbiM2KX3cfufmXKk4ho8We8Ugw4pFRaNsOJF2Yqs6SpmsX0JpOt7bgTqkH
         IbNiTiaD/Epm40d5rnrc1b1Xt4BAhmXOXnjuGkxgXUC9u69T0HIixFrQFwYrFnkRmdSu
         OwcCc4zCmrcQhb1xIEW8UNaz8J73rXLtsrHN6MhokxpEz7SFhgK9ZuZMQIzs9eowb9wl
         NfAysdFi08LtG1fVJ3qmES5FnkHF+4Mr/smdeI45ZUH2lXrP+BfDq/JFp3EsPMUMw8eT
         Bf5f+bFFC64MonZyU10MePCTAdojswX9yNND6AJTirydTqBlIsThe5OYRwJJcWaI4GYB
         Jp3Q==
X-Gm-Message-State: AOAM5316IkEOmIgpHBMrhSstTctZJ11ouQjcKZN9L6w2olrsu345fIzj
        GBomzFQfOuHVI/CzS2Qe8N7Jaj9/PNnAEw==
X-Google-Smtp-Source: ABdhPJyvdIu8UHDYDBfVAjLHeUCPV0kezLtEuOsrp9uTxKM7o6kW17LLj8wVoY7s0lV7waYh18p3UA==
X-Received: by 2002:a17:90a:d24b:: with SMTP id o11mr876416pjw.140.1620675596354;
        Mon, 10 May 2021 12:39:56 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id d13sm1896746pfn.136.2021.05.10.12.39.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 12:39:55 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] DO NOT MERGE - Test only
Date:   Mon, 10 May 2021 12:39:55 -0700
Message-Id: <20210510193955.1387490-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch is to trigger the CI test only and do not merge this.
---
 README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README b/README
index 3dc226ff1..2b34e11e9 100644
--- a/README
+++ b/README
@@ -1,3 +1,7 @@
+This change is to trigger the CI test only.
+Do not merge this change.
+
+
 BlueZ - Bluetooth protocol stack for Linux
 ******************************************
 
-- 
2.26.3

