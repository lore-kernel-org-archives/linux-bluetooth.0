Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48660C4707F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 00:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2157F61429
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 00:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhEZAaP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 20:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhEZAaN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 20:30:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12096C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 17:28:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a7so8547802plh.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 17:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=euYDffDVdPB8dCWXzN8m02siNpTk3Tq5U77xttu5VWo=;
        b=igEQtdHjq2x68jL52jr58nvxbjzFhqLMNft8FrxcSFrlm8qUXDNTcfxIq1OsiIwEzu
         8U7S7OXsJv4iM8CdnWtJCDTKMoFv2UJDgn+MC9jCbMwoZ7/wulHWBJXndIGOxtjFdXdj
         Ex0UAfKQDoplXZFg7BdaVHJfVhWIaKfyW9qlWJUMmk7cPwqEtkByZtEbkUtEYpkX/Evi
         5rfKpQk7hdJIZO4L+/Ibh3vHhBNEBHZT9dt5tAISh1i82kKTg1fvvrXtaCteoHSqArow
         fPYxrGJQuRtbaXeOxaGqTrjEzGIh9+Ks0Rs63zNvbIu4b3J/wnUo8FxKbrsxoHLZEsGK
         S4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=euYDffDVdPB8dCWXzN8m02siNpTk3Tq5U77xttu5VWo=;
        b=DX/9oZR6ZywlUjfXP8VhNNi3vFhFDuXwRqcZUHETn/RxHM1lBorCw7//ezDU4Jt4Ct
         jdbvRJbXXTF4yuAzywYoOKfxVtBf+BUwF7u0Icdtvp8hgWfq/dlXc3507L6p2m77TMmT
         I8sw22l84yphPWtgesV5DIk2OlyFc0ECzI5BwVPTxxbeXGBTvxeNcq3DBQVcSZJ1wzMM
         0fFKfi8d8lFjKAh+LAnlKtWQok9lBdmmBSDv/4SX1lI2/LNrxzu/rW1MbCQntVv9rOtk
         BCPJOm66tRBnBje9JjwJpiKzqSuixhqkA0W65LKhuqsGR2ZusGJgSkL/4ZqWoiSDIn/6
         KWYw==
X-Gm-Message-State: AOAM530hQBeyKXx0AM7i0Vi6orX19wstYWgN+nD/p7shpvdYRr+U7MHw
        P3w9lVToMcVQ2HmnhttEQ+OmItjZZ4fAKQ==
X-Google-Smtp-Source: ABdhPJwQJxobsM04ZZt7fTD2A+zZEFarc9WDSAmpDevlAzrYm2ITSccyTscziMIPgM9pLdjIPtRTSA==
X-Received: by 2002:a17:90a:8b12:: with SMTP id y18mr32322546pjn.153.1621988920268;
        Tue, 25 May 2021 17:28:40 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id n1sm1845486pjv.40.2021.05.25.17.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 17:28:39 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] Bluetooth: Fix get device flags command returns garbage parameter
Date:   Tue, 25 May 2021 17:28:16 -0700
Message-Id: <20210526002816.413660-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch memset the response parameter so it doesn't return the garbage
value when the Get Device Flags command fails.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 net/bluetooth/mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b44e19c69c44..91d36c3bf23e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4061,6 +4061,8 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	memset(&rp, 0, sizeof(rp));
+
 	if (cp->addr.type == BDADDR_BREDR) {
 		br_params = hci_bdaddr_list_lookup_with_flags(&hdev->whitelist,
 							      &cp->addr.bdaddr,
-- 
2.26.3

