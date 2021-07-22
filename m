Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF90BC63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07916023B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhGVHDF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:03:05 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:52841 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHDE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 03:03:04 -0400
Received: by mail-pj1-f46.google.com with SMTP id bt15so5002921pjb.2;
        Thu, 22 Jul 2021 00:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tmgFh+laGR1ETgWPH1UC2DgtrT+7uoldLT+DjSVRjRE=;
        b=SIsjSrxwhubea2fOxKm34d4aF8SDSzE+z29IJt5l8Sb+QvDpKzvuAEfaGALML6PiZB
         k6G7h+xuY81UUdpQPErOjXp7XYXr6Zs6FPzeok0NyvMEyZ9gMIkjaOgkYr+V0IZCAJCb
         bnGftsCdRziJEtWmSOwIOdEIzyH2dngLlauS06l7uXKdHDGzUFNs+3oFa8U/CI6UEZLU
         +Ls1vsMdH9WFAfUqhuw0MHjm+Ytzrrd10YlAuowGXA9q9iuu06acukhp80aFRsV5vtjg
         TMkhMzxddgEuZrHSTsdNc5gQcVxhcOP09kgMHXiGb8GZbqeHjJyXWKE9VYZVh9q1AXtp
         QwJQ==
X-Gm-Message-State: AOAM531UKa2JAC8RNERBNuTAkk8xC0MYDoRHC1q39SJFAq3PAG/0XkIX
        GJPTngMlZCEF5s1EEBy5URs=
X-Google-Smtp-Source: ABdhPJwZPZZpLlQlQRGfvL38mhDENathno6jCcOWC1WWxig35i+OquRj+UjbawtzWTAoxjRMhPGp+Q==
X-Received: by 2002:a17:90a:5e0c:: with SMTP id w12mr20979155pjf.45.1626939819862;
        Thu, 22 Jul 2021 00:43:39 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id v27sm30346344pfi.166.2021.07.22.00.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 00:43:39 -0700 (PDT)
From:   You-Sheng Yang <vicamo.yang@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, chris.lu@mediatek.com,
        will-cy.lee@mediatek.com, rex-bc.chen@mediatek.com,
        "mark-yw . chen" <mark-yw.chen@mediatek.com>,
        Andy Chi <andy.chi@canonical.com>
Subject: [PATCH 0/2] Add two additional vendors for Mediatek MT7921
Date:   Thu, 22 Jul 2021 15:43:36 +0800
Message-Id: <20210722074338.760456-1-vicamo.yang@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

* Bus 001 Device 004: ID 0489:e0c8 Foxconn / Hon Hai Wireless_Device
* Bus 002 Device 003: ID 13d3:3567 IMC Networks

Andy Chi (1):
  Bluetooth: btusb: Add Mediatek MT7921 support for IMC Network

You-Sheng Yang (1):
  Bluetooth: btusb: Add Mediatek MT7921 support for Foxconn

 drivers/bluetooth/btusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.31.1

