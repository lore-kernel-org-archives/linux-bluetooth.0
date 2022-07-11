Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D255CCA47B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jul 2022 22:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiGKWyJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 18:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiGKWyG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 18:54:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D8520BE6
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 15:54:05 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id o10-20020a655bca000000b00412787983b3so2421452pgr.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xO5JXzhK4rbeGShdnQqpfrChMKSlSVvQkkYlcCCKloo=;
        b=BJEO8MzGCt1wyxahAkRH58z+Yiwxd370rA4VM2qq/BOYsJihcr6nmMaUjluDHGAQvK
         lTmbfgE7Q4zmdaqw6tpq26n2tl1Euf3W7KvSPIRxKTCqscSitr6LxB0KJ98tQ1r8jyHa
         XYrjgZMPGRtlIn4/SNmqxFYyv2b3DQ+F1KDwLRts7hSn812s1VTKwp5yzKcWtNWZJPhc
         dvJJ/4KU90dHojr9IklHLspi2wEvRiXs6vKMU5T7dM+tIFiGUkeiiimbfU4voo2U7VDJ
         1b+ak6WLGS7MAXzRYqDkLgcNfNBgtYhYCBIrQwcHHJKlm2ZtSczahTkCYinx6A8UT7S5
         oNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xO5JXzhK4rbeGShdnQqpfrChMKSlSVvQkkYlcCCKloo=;
        b=sroG0B69r5iwWWHQP6hoZD1tgF5hvS+R5FyQ/a44DWHNyqUDAE4rSHEzvM2evVbHBV
         d8Y2rAwjgZmlJcy9K6FYG2Kkp1SlatrzE6OMtKrF3oxaZpVjZ5baC0kWw270KTHp0x9m
         h/+/8UiKZ9wAsXnAqRhTAywwd8yqGjgR5oz2Eo+JWwVscwj2MI+pVKW2npDf7uSW9t3G
         art3wv/5F+L6mnTvzCHW8NVrrgvTfmtuy+BK0+Z25SlvlZzMCL53FQqSwA94a6VRwiPl
         pXl4BhM7tENw7jNDM3lfRqYcWw6EI3zpqyNdY3llzk5WQX/cEF+SXK1ybQPsbOOFX7JJ
         YeAQ==
X-Gm-Message-State: AJIora/e094lDCgtRN6Q7baCy3FUpQ5sa8md1sD8h+XMDbd41OlX1WkQ
        mr+1wGR4qkCc5a965J16hCL70OYYNFpG8L6MbpxAB4dRnHMH1GLALxCS/d1ub630+wo1YjpTGIE
        wwLXkkk5gZGkatoxHpNepYxkMNr0MlJCaPaFPgY7ShMKEZiJhucXUO5tBRQ1vJcfS6pJaSPOhxK
        93
X-Google-Smtp-Source: AGRyM1t4bx/aPiPA15cYX46mj8Q7o/j/YNHlxQl2lRmEGgP4/CGevjmd51dXWiVMj9rt3JzYg7uvCgH7426P
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:a12:b0:527:dba9:c416 with SMTP id
 p18-20020a056a000a1200b00527dba9c416mr20575252pfh.33.1657580044634; Mon, 11
 Jul 2022 15:54:04 -0700 (PDT)
Date:   Mon, 11 Jul 2022 15:53:58 -0700
Message-Id: <20220711225359.996974-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [kernel PATCH v1 0/1] This patch fixes a previous patch which did not
 remove setting
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

scanning_paused to false after resuming. So after setting the value,
the function to update scan will always quit.
Also need to set the value first before updating passive scan.

BUG=b:236868580,b:236340454
TEST=verified suspend is fixed in volteer with LE mouse
TEST=bluetooth_AdapterSRHealth.sr_peer_wake_le_hid
TEST=bluetooth_AdapterCLHealth.cl_adapter_pairing_suspend_resume_test


Changes in v1:
- Fix updating passive scan after suspend resume

Zhengping Jiang (1):
  Bluetooth: hci_sync: Fix resuming passive scan after suspend resume

 net/bluetooth/hci_sync.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.37.0.144.g8ac04bfd2-goog

