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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16186C4708F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 08:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C10610A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 08:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhEaIj6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 May 2021 04:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhEaIj4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 May 2021 04:39:56 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3476DC061760
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 May 2021 01:38:17 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 6-20020a05621420a6b0290214b9d4b6c3so8467857qvd.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 May 2021 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tjbMdWg4PO8/eooobp10b8z1ZpbzFZFdpuK8M8h0fLo=;
        b=tDvDLZe5WhMR+9XN/fr/hQFwABYjIvNU2JvatJfqPzN09JN5eP5aMIpPZaEeJZUxZY
         iLgzoLZyhlaX1/9fSyOy/Y/IGjWO7AKtEUHMU8Ws5NDka2dncaU9hI20X/nOxaDWnXKV
         sKMKz51/ZuKer9sdM44wJWpTx7JBx6/Cm0GHRTSUY4VDDtQQ4GY5azSu4nZ16QZI4r5a
         YDifmvyjaBsxo93NaVvDnLcd+wlVfR/Wm/5wyb7bW6YCERNi9x5xVkpecboEJqnJSzzc
         u8ugRJNiUCcDoMn2h/zDs57lrS8JkgZhTQzGud5zBjzcJ44xPj5OcjR068vsXi8KToE3
         cPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tjbMdWg4PO8/eooobp10b8z1ZpbzFZFdpuK8M8h0fLo=;
        b=DDD+YHIYBkFueSN5hYGJ7uNvxAsWspfifFW+BlniHtrQwdhTZdt6R0GPp6/mLKu/kK
         XqLUR+T7Kt03pWTzw+rGW0VF+yizv0OTxSVLKRfTdw8oSEqM+HR+KR/cTjWC1p4KtZqx
         7l2+5mSu6A57h6GCQOB0NsADZSalaiD30M5/LgbpMZGR8CMvtSe3Nh2f2mdt2r9zx0wi
         9w6LFk8SUxFiCg+rxjpQJ/0PkvsPBTRKBfP/OKyvC/Ky8GOcxo7WIR2LYyEZsdGQwHGY
         nObdMekk25Fa1Lqi4pPGEMegckMQTYYvzf4tarNdK5zLjR8+fviOR0aAc44UkBupy753
         yyWQ==
X-Gm-Message-State: AOAM532XDEZOMzDhUEk5cXVOraK1hyxCprVtED3Q4H8Rc3rPh+hygNHf
        pwRV53osm7t703NnQGYSx/k/nej7eqFBB5v+7zmtytecvBsh40ShyEFoniElDp4S7Kr7QBFRu2K
        KGBLBPhoJYK0dx1QLHp7DxOnVp9wTbHjdqTB26aGSzjpHwfhcGuDQ+7wwAb/JseldLVa3ps07L6
        gp
X-Google-Smtp-Source: ABdhPJyZcRoSDWVH/ygFRbiMzdMkaOGR+gYo0Zl1J7DcUhFoU2h2bta9jDlzmoiu76s2GQUJ+4RIKL/jyly9
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:a6d1:a727:b17d:154e])
 (user=apusaka job=sendgmr) by 2002:a05:6214:246a:: with SMTP id
 im10mr15568895qvb.2.1622450296211; Mon, 31 May 2021 01:38:16 -0700 (PDT)
Date:   Mon, 31 May 2021 16:37:19 +0800
Message-Id: <20210531083726.1949001-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 0/8] Bluetooth: use inclusive language
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "=?UTF-8?q?Ole=20Bj=C3=B8rn=20Midtb=C3=B8?=" <omidtbo@cisco.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Hi linux-bluetooth maintainers,

This series contains inclusive language patches, to promote usage of
central, peripheral, reject list, and accept list. I tried to divide
the change to several smaller patches to ease downstreamers to make
gradual change.

There are still some occurences in debugfs in which the
original less inclusive terms is still left as-is since it is a
file name, and I afraid replacing them will cause instability to
other systems depending on that file name.

Changes in v2:
* Add details in commit message
* SMP: Use initiator/responder instead of central/peripheral
* reject/accept list: Was actually two patches, squashed together
* Drop patches in L2CAP, RFCOMM, and debugfs

Archie Pusaka (8):
  Bluetooth: use inclusive language in HCI role
  Bluetooth: use inclusive language in hci_core.h
  Bluetooth: use inclusive language to describe CPB
  Bluetooth: use inclusive language in HCI LE features
  Bluetooth: use inclusive language when tracking connections
  Bluetooth: use inclusive language in SMP
  Bluetooth: use inclusive language when filtering devices
  Bluetooth: use inclusive language in comments

 include/net/bluetooth/hci.h      |  98 +++++++++++++-------------
 include/net/bluetooth/hci_core.h |  22 +++---
 include/net/bluetooth/mgmt.h     |   2 +-
 net/bluetooth/amp.c              |   2 +-
 net/bluetooth/hci_conn.c         |  32 ++++-----
 net/bluetooth/hci_core.c         |  46 ++++++-------
 net/bluetooth/hci_debugfs.c      |   8 +--
 net/bluetooth/hci_event.c        | 114 +++++++++++++++----------------
 net/bluetooth/hci_request.c      | 106 ++++++++++++++--------------
 net/bluetooth/hci_sock.c         |  12 ++--
 net/bluetooth/hidp/core.c        |   2 +-
 net/bluetooth/l2cap_core.c       |  16 ++---
 net/bluetooth/mgmt.c             |  36 +++++-----
 net/bluetooth/smp.c              |  86 +++++++++++------------
 net/bluetooth/smp.h              |   6 +-
 15 files changed, 297 insertions(+), 291 deletions(-)

-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

