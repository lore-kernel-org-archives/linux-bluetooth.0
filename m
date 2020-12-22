Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA0FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 10:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD3D23120
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 10:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgLVK1R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 05:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgLVK1R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 05:27:17 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAF6C061793
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 02:26:37 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 193so6581049pfz.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 02:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=U9P6jkfR67W5Mq4J4StMzWSoQePGQvi7vF88iWcn2P8=;
        b=LgLBqZuLvicbXKRAdSYrD0pHrTww3JGoBUHEkDy3s/YQfLOyf0C7OrAn/p/Wi2TElW
         cFU01wsB6isHULefqNgkHqN8sSvSebLd5HN4yhbr2bOQqWBurOGoVrao/to20mTmqwdZ
         HKIMdLVy1G5dSfcn+59vsdKbOeMr+IwmV0+1mBE0WUAO4me5vH/DDBU5TxLrQw5WrYUK
         yhjbI2gj75CiEaSpiR+AOpaQaxX69/kq/Kjk9T/SHoCR90DmN5g/vjZHKhuYyNvwjBGC
         a+xP/muGq9ZpV4HSUq3NU+huw7iPC4PYib4cLrdcfhptxC/ImKMgRXeVibcnhzB2AM59
         3uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=U9P6jkfR67W5Mq4J4StMzWSoQePGQvi7vF88iWcn2P8=;
        b=E+YaeIQBA667ypoPt3VNlOUZ5ezjKd/pJ6RkkBga/Hg/sWeFu0dNk1SCiuNpnFvwkB
         sfRmlgp5cPthKdu/VgsRdewqQb3YxzukcymfC+GGhx9xKWIcfAj/j7OnCqsQFh9JboNO
         rjvde/Ll5Ot6p00oe3fb6tLFh+7A2zt/ry+TZQXusrukOqwbalNs1AKoxis1W3yQTrGE
         zOwjCcOaFjYrUAJ5vWcct2d+l0CCyhkA5x49N1D6N+uPgRtoNKlfiRHbon8iAdC6PxCl
         9eMqmf2YGmC4L+8Dxn1H5yrCColnSecNremswunmZ9SZBUcSTSJ1fLR/+erWA+W5zUWd
         g6Hg==
X-Gm-Message-State: AOAM532GuXMbVyreU6YjE/2ah9hOS4Uuug0I3Eq8Eu1ajeXQqnN7mcCv
        tUpKUkvsYahlDC+H+0U2R6KVyI1FBBtjq0CYa+kvWEZzBEeD8mdmeUiPyEeqhWidUJt14MnsHUm
        QqiHuwOwn7HuZsBXgz+8xX5quGHO61zq0Noc3GjG0vVx8UTLnOp2fGeK69C0WJAuDHc3icbUdLv
        A0
X-Google-Smtp-Source: ABdhPJy7uduksdf09VPgXMpChD9zXyzc4W8bOf9iyb4bZEsllLq7KiVffzIIM6sxqqSM5yiLr/HHQB7ySWrf
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([172.30.210.44])
 (user=apusaka job=sendgmr) by 2002:a17:90a:1706:: with SMTP id
 z6mr3085829pjd.0.1608632795973; Tue, 22 Dec 2020 02:26:35 -0800 (PST)
Date:   Tue, 22 Dec 2020 18:26:24 +0800
Message-Id: <20201222102629.1335742-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v5 0/5] MSFT offloading support for advertisement monitor
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>


Hi linux-bluetooth,

This series of patches manages the hardware offloading part of MSFT
extension API. The full documentation can be accessed by this link:
https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/microsoft-defined-bluetooth-hci-commands-and-events

Only four of the HCI commands are planned to be implemented:
HCI_VS_MSFT_Read_Supported_Features (implemented in previous patch),
HCI_VS_MSFT_LE_Monitor_Advertisement,
HCI_VS_MSFT_LE_Cancel_Monitor_Advertisement, and
HCI_VS_MSFT_LE_Set_Advertisement_Filter_Enable.
These are the commands which would be used for advertisement monitor
feature. Only if the controller supports the MSFT extension would
these commands be sent. Otherwise, software-based monitoring would be
performed in the user space instead.

Thanks in advance for your feedback!

Archie

Changes in v5:
* Discard struct flags on msft_data and use it's members directly

Changes in v4:
* Change the logic of merging add_adv_patterns_monitor with rssi
* Aligning variable declaration on mgmt.h
* Replacing the usage of BT_DBG with bt_dev_dbg

Changes in v3:
* Flips the order of rssi and pattern_count on mgmt struct
* Fix return type of msft_remove_monitor

Changes in v2:
* Add a new opcode instead of modifying an existing one
* Also implement the new MGMT opcode and merge the functionality with
  the old one.

Archie Pusaka (5):
  Bluetooth: advmon offload MSFT add rssi support
  Bluetooth: advmon offload MSFT add monitor
  Bluetooth: advmon offload MSFT remove monitor
  Bluetooth: advmon offload MSFT handle controller reset
  Bluetooth: advmon offload MSFT handle filter enablement

 include/net/bluetooth/hci_core.h |  34 ++-
 include/net/bluetooth/mgmt.h     |  16 ++
 net/bluetooth/hci_core.c         | 174 +++++++++---
 net/bluetooth/mgmt.c             | 391 +++++++++++++++++++-------
 net/bluetooth/msft.c             | 453 ++++++++++++++++++++++++++++++-
 net/bluetooth/msft.h             |  27 ++
 6 files changed, 963 insertions(+), 132 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

