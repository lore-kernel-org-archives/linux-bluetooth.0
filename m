Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14DEC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 19:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348368AbiFJTTx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 15:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347463AbiFJTTw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 15:19:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACCC23BE7
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 12:19:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fed274f3fbso1230567b3.17
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=M9u2uZrITY2ZmiHjCgQwdtv5Ky15VkyjtQ04bHL3Xio=;
        b=Jw3Ysj1F41dQlsGZWhUSX3Obz+Hib2iEiW0hh7Mijv3UwtrOyaCWrIIlSyAwUDSuos
         QtJuRKjf8bcVJGqnp/cfidbUkVLVhGWUPyepZYlwljByyeosI+xTQbv6S5qRsQE1kkjB
         4g6O3P1k53JC3+z8MSkBnQ+tMlk8IKnhgBqJjq9wIph9VR1oWmUmRqAapif8fhobzgtp
         NjALOtVVeS7QJBxHZoXGBg7u3jRXuCJbg8GnrMAcnCx1Ws4QiEAZ86bBc6y4iWbRftjK
         Hj8+vTVFtkfWGc1IAklfE0cn6e19Q/jTuGUyBhm5cY+ojFPvzxc7hI3RW6aDW66GvSD/
         MfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=M9u2uZrITY2ZmiHjCgQwdtv5Ky15VkyjtQ04bHL3Xio=;
        b=LPHOtcqh3eFjxEkF1ABG3tthjMkjhxBnqaeer1cbsr3LfB4OW/cXze/i+CGCFKjuU9
         dF7s/01lO3OJ7RCEPtJGxA/y4yiMFEwbE6qIz9LGp4YzMVcxRVzC+NKeAvCVVKZHZWoW
         8O7j3MhVTnHu6yi2VOVtgT53yv/N3mn8s7eX598iboxjcriZyqxXIGTK9ZoCHe5m/R1o
         HRkGXBntm9U79FbBgQ7Y4Gxhem6UepVqadPfFlZewDDYjPkAZxq6CkMK+G0T2GqJ+Ekd
         It2G7HOYiG6O0BeXcWCIrXJxoVz2PXrUAgaZ/LvnMiO/lSuFXQQih/lqctVeuyJ5zikm
         b3ZA==
X-Gm-Message-State: AOAM530bze2VDBgMrSS9k0L10xzxT/KPG7DNi1tr+GiMUnIh9ZLm52X3
        i+1bz3F6azovsZLHxsb0y6r7EkX361CuooQV0IYWBWcQA/R8yVhz1daI4BqFG3BpkQM5k9WH4LX
        kKRsAVP74BJEEBW8Hf8frhW6l3T7lKME5mDD6bed0jxpjE6FUGb7sPMcysjPOsbDNbccrZrB0K3
        GB
X-Google-Smtp-Source: ABdhPJz10BJgI6Y5N6hUkaEeF9P58vCfexIRfPBz3ftn2TOWtVsMcosQC2GyO1ymsmhprR40j0sGd0CvFxr0
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr50470972ywm.149.1654888789821; Fri, 10
 Jun 2022 12:19:49 -0700 (PDT)
Date:   Fri, 10 Jun 2022 12:19:33 -0700
Message-Id: <20220610191934.2723772-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [kernel PATCH v1 0/1] Fix refresh cached connection info
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        Brian Gix <brian.gix@intel.com>,
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


Get connection info will return error when using synchronous hci_sync
call to refresh the cached information when the data times out. This is
because the cmd->user_data was not set before the call, so it will fail
checking connection is still connected.

Changes in v1:
- Set connection data before calling hci_cmd_sync_queue

Zhengping Jiang (1):
  Bluetooth: mgmt: Fix refresh cached connection info

 net/bluetooth/mgmt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

