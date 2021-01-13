Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8651C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516C22339D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbhAMJ0d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbhAMJ0d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 04:26:33 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7C0C061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:25:53 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id c1so876792pjo.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=0rHTOkpzm5V1/jxGrAGt51exUDtofeZfYZnONSZz490=;
        b=qXqmxk6JTkvOHV4ywRjOGVg2FggX1Ryo83cCojEDBI9jkmdzYEIgthiZ1vI4knxpcJ
         +vZVvC5sLQSaauSG503p37J0/qrL7LN5jUELUBuBeXW1AdqqeDab4VBTVA5oW0JZKOD3
         0egpSS3nhKaKWZebeiF30VhA65VbMviq4zoIu7O/XylFVCe4O3zZXaSU16b7Hy1jixtM
         6pNinLdrFbJXJAvVUGmRYzLx7FrHGGY2dSJ7MLDV2N9pxDEstOhc92erhnJXfqMP+5NT
         2c8bZO1m2rP624br/n1+/TITuVIxdDnB4w8Pk9ztKFHhforL2q/N/7jlx171zoQqF+7q
         ARxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=0rHTOkpzm5V1/jxGrAGt51exUDtofeZfYZnONSZz490=;
        b=gNt3ZLu8qf+kuqUr2xMv2rdgXFLV4sJhiHA61p4MrQ8I1RwOG094psa0it+gyPyIL0
         zD1lJcXUYoKuP8EpTJSPovR24ezdPc9l5dnhxWJmhAQLHOuEoZx/LXCEIHnuTcM9Agam
         te6rRn4zg1DYATBbPpubsUBAelJ8Zv4isP9dHvgh2bKI2hRk0JOuR79OUNYXl8rmS4iZ
         Cj8+4gJ0c2mA1cz3DlRxmK/M81DTEwCzPEHb5ZIeUyZA9bI0Dkp3SIzrskGopbnDOx6B
         6l7MxRr7AjNgBCTcS0J5bSOqUPhGXoeq5jxb9Tv2OPBfi7K7lZKgtdHWUbq4v4rC2TdD
         S7zA==
X-Gm-Message-State: AOAM531gcIVKfcsRyTIokpydZZAcEGHwYmXBaXovaNvB98lnzoH2hHci
        t3PeB7XYefi+jbGHmXRlbf6FFQoteF7J0BtJPxM49tLOzkYWNrIo8+urUPM4cIALHvbO7nK7DPn
        BxbQVGqNPG4xOyWWa2gxG/8V0nEHpB+0zSXcgLUMPxNxY3qxGGqsJRgbmxw9/wHw6PdssM2M+3F
        2S
X-Google-Smtp-Source: ABdhPJy0rJuTH4y3dIpKYEGkq72R6orIi7U+FUHjCIcvNY/DzBYXGVGx9oeUXh0Fs5fr6ktxQ/RQSRmPCimi
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90a:8b94:: with SMTP id
 z20mr1074320pjn.1.1610529952067; Wed, 13 Jan 2021 01:25:52 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:25:30 +0800
Message-Id: <20210113092534.2771034-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH v1 0/5] Support advertising monitor add pattern with
 RSSI opcode
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Hi linux-bluetooth,

This series of patches adds a new MGMT command for adding a monitor
with RSSI parameter. Changes are focused on passing parameters to
the kernel via btmgmt and bluetoothctl.

PTAL and thanks for your feedback!
Archie


Archie Pusaka (5):
  lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode.
  src/adv_monitor: add monitor with rssi support for mgmt
  btmgmt: advmon add rssi support
  bluetoothctl: advmon rssi support for mgmt
  monitor: Decode add advmon with RSSI parameter

 client/adv_monitor.c |  90 ++++++++++++------------
 client/adv_monitor.h |   1 +
 client/main.c        |  29 ++++----
 lib/mgmt.h           |  15 ++++
 monitor/packet.c     |  43 ++++++++++--
 src/adv_monitor.c    | 143 +++++++++++++++++++++++++++++---------
 tools/btmgmt.c       | 160 ++++++++++++++++++++++++++++++++++++-------
 7 files changed, 357 insertions(+), 124 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

