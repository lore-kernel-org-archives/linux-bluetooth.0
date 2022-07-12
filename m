Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1356CCA47B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jul 2022 00:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiGLAFh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 20:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiGLAFg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 20:05:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7DDF2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 17:05:36 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g67-20020a636b46000000b0040e64eee874so2497808pgc.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7pRcKQvplvk+c/6T4qCwYQ+E8JeXHTzT5CjY5ICtDRU=;
        b=LJ92TWKPK1Ti9qon9DuojYRugnPUDYH3RJ75V7CRHCiGzLOh4zAfnKonocmcq9NHdd
         7A8itnb4LohQCdVahBk5dRc5D04R8Uaxyhu0fKl3VsuceZdM2sBHZQPMd0lnOQYv4t5T
         nBOxajZX7F5ytj0UYRgVDzQkDb8OOv2G3AMQUM+l6Oqu4GU0nfqn2wJXq3mSWBtoOvUP
         ISFqxsz+kZubmDA6VEqiih3wLZaa4X3ctfLIPEU78Mq6m1bzDbAX1rrDew/ECep9B4iG
         ezTShUe+Tr+X3MtV8cwe6mRC1HoYN1LqQK7gGiSpeSAWWWAERaYjRsa1BddPvMZTpSZH
         9B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7pRcKQvplvk+c/6T4qCwYQ+E8JeXHTzT5CjY5ICtDRU=;
        b=aFf2Soe7i2ig+fBgomWA9MWJPj2rNM8kU4ORY71AfZnkm+KPmVVwYutDfxdkkKvmFj
         gWR4vvb3l3InoIwJdBja7JYUmf4E1RrZRqrzzuAQM5cn/XV+zpnE2K9p4HIKvAaEGiso
         SFJiODGWeEgNcPl1M1fLcFmhoh+436bCbZn6Li7jdZhMcD6/j5pyXV3OGgg6dFcT+TkG
         Rfk2qOCz3wn/Rc+KOR+Y+JG3uCCdWdaYzcqks9PJWx++btOoTj4OEVAw8JcyM0JSobN6
         Ha6RFAEW9HRNbKPrbg1a5NXEmC8Kn5iNoNS+lyY2NJOfSeF6bfa8XVhnEMgslO+4gfCz
         Rolg==
X-Gm-Message-State: AJIora+zeJqVeZLCOrNSnHHYi/askhRNWco3Aik3ylamspd7ndlvf8oI
        /OlYY9yZdSQSDtFC7qh5fA36UDJ/xYHkh2mmNq+Lo5ncCRObp+G3do+F2M1rticLCyFFeRl4LpW
        7MAMegdpz2Fiy8BsfUKUVW/wI7El9N1f8qFrzlYWwOuvc4Nu3ki1qJJasKMu/w1QNITQnWv3xqN
        eJ
X-Google-Smtp-Source: AGRyM1u3ET1rSKHzcNdt9tvyqZM1qA7VGjsU2pvLjXXUiHEEaE3+zyqxN5YrkcEB3vn36nQWHAts+qDbNBEN
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:1312:b0:528:2ed8:7e35 with SMTP
 id j18-20020a056a00131200b005282ed87e35mr20569454pfu.13.1657584335470; Mon,
 11 Jul 2022 17:05:35 -0700 (PDT)
Date:   Mon, 11 Jul 2022 17:05:29 -0700
Message-Id: <20220712000530.2531197-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [kernel PATCH v2 0/1] Bluetooth: hci_sync: Fix resuming scan after
 suspend resume
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


This patch fixes a previous patch which did not remove setting
scanning_paused to false after resuming. So after setting the value,
the function to update scan will always quit.
Also need to set the value first before updating passive scan.

BUG=b:236868580,b:236340454
TEST=verified suspend is fixed in volteer with LE mouse
TEST=bluetooth_AdapterSRHealth.sr_peer_wake_le_hid
TEST=bluetooth_AdapterCLHealth.cl_adapter_pairing_suspend_resume_test


Changes in v2:
- Reduce title length

Changes in v1:
- Fix updating passive scan after suspend resume

Zhengping Jiang (1):
  Bluetooth: hci_sync: Fix resuming scan after suspend resume

 net/bluetooth/hci_sync.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.37.0.144.g8ac04bfd2-goog

