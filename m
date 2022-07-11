Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF5C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jul 2022 22:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiGKWyO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 18:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGKWyK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 18:54:10 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D354120BE6
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 15:54:09 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l16-20020a170903121000b0016a64bbe81cso4582817plh.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SItnm/IkJcdwp0iXSBIwTqsq+YY1BjGHQ8L1VFRxAqo=;
        b=EITTvvBVGD2adiXlxvGMYGNkrPZe/Hie029nwOuGAOGKEAMuB0C9q4sNfPryZAL+cz
         J1ehc1aN7IYgeszqsScPQYiVyh4xJywBfz4cVdtY7tspDkd0IxOWVbrgAQ//jFMfIjqA
         mayJ4aDJIOfd3+HVpJGxTsKQYl2HBumjl0hVDlKXGHMZCeps5gG2O5LnEGtiKPu8sWZh
         Oz8H7/D5bfxIfATw3oKBBaBU6hRYWsoHIzUx6huwHG3D40S1D5rWungahbXXFKGvTp57
         MZY47qPU6mNA5rf+6FKwJ6QI5kdFiUD3JZWPjoKql2Xh/aSDWBC7xOdqv/0oIQNevwix
         uJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SItnm/IkJcdwp0iXSBIwTqsq+YY1BjGHQ8L1VFRxAqo=;
        b=EouhrX89UPCxfEU8lnrDLmXlzjCobEK1F7qfR91xK3/TAXcaqt//1J1KqPUjqdBDkP
         hS+4itb4wCvshSedNG5mhRBt0PRmz/9Z9+U+2b4qBJUkLnCko5YpzetvO1aB3SvF2rBw
         IfBdsYXHZD0/k1w08nBNr1L8SSvcH4ZHa5LHsXOVHH2490osQkrTScX6nZ1Th+oL4syl
         mAZQ2m1mBUeBUwHPYOZux/mHOjep+0Pvgog6qblvHC1AOcILaakp4NzTknR0r8zVJxnK
         NJui1+FgeA6XI9Z08MJ6YNRlTK923sSmw2K+7xksxDVvfdDpsvdtD7oBgxegFGVpWkcM
         SpSg==
X-Gm-Message-State: AJIora+o/5X5oAY3BG0cor5jd2P/wGHj9MK0kMCND39ZZmPi3EOarv/3
        k3Muo/Dpm9IqgjLx6gotvEhH0kEpcKG/dHlXvJ9n8PbA+SLjsTlXJwMICUo91VhFWjHAZWWf5Cp
        zyc/8dI4YqSNet0MXHPV5ZCDUpIlgyJabQwz0wrcSo3+nm1yCpwjEXR7dKDjEttU7PWD0/R5ltf
        WE
X-Google-Smtp-Source: AGRyM1uF13RA1km3iIVwCPFaNB+odNZwEAdbG65k/DijM2D87aURLOjcpj6bXGNTIHcbzdeCKcZrd1bn/ajq
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90b:504:b0:1e6:a0a4:c823 with SMTP id
 r4-20020a17090b050400b001e6a0a4c823mr753524pjz.190.1657580049162; Mon, 11 Jul
 2022 15:54:09 -0700 (PDT)
Date:   Mon, 11 Jul 2022 15:53:59 -0700
In-Reply-To: <20220711225359.996974-1-jiangzp@google.com>
Message-Id: <20220711155349.kernel.v1.1.Ia489394ab4176efa5a39ce8d08bb4c4b7bee23b9@changeid>
Mime-Version: 1.0
References: <20220711225359.996974-1-jiangzp@google.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [kernel PATCH v1 1/1] Bluetooth: hci_sync: Fix resuming passive scan
 after suspend resume
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
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

After resuming, remove setting scanning_paused to false, because it is
checked and set to false in hci_resume_scan_sync. Also move setting
the value to false before updating passive scan, because the value is
used when resuming passive scan.

Fixes: 3b42055388c30 (Bluetooth: hci_sync: Fix attempting to suspend with
unfiltered passive scan)

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v1:
- Fix updating passive scan after suspend resume

 net/bluetooth/hci_sync.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7cb3100518799..212b0cdb25f5e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5063,13 +5063,13 @@ static int hci_resume_scan_sync(struct hci_dev *hdev)
 	if (!hdev->scanning_paused)
 		return 0;
 
+	hdev->scanning_paused = false;
+
 	hci_update_scan_sync(hdev);
 
 	/* Reset passive scanning to normal */
 	hci_update_passive_scan_sync(hdev);
 
-	hdev->scanning_paused = false;
-
 	return 0;
 }
 
@@ -5088,7 +5088,6 @@ int hci_resume_sync(struct hci_dev *hdev)
 		return 0;
 
 	hdev->suspended = false;
-	hdev->scanning_paused = false;
 
 	/* Restore event mask */
 	hci_set_event_mask_sync(hdev);
-- 
2.37.0.144.g8ac04bfd2-goog

