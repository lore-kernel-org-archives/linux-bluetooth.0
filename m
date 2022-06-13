Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A94C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 21:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiFMVnn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352283AbiFMVnf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 17:43:35 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC766398
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 14:43:32 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id n6-20020a654886000000b003fda8768883so3939335pgs.14
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 14:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=M9u2uZrITY2ZmiHjCgQwdtv5Ky15VkyjtQ04bHL3Xio=;
        b=NnxOPuFpNs5MnMcovgUqGxaZmAXo2RDglY8A41g2hQyQzsPDlOWea/WR9ctTMqtneP
         RmEPy8aIlzarloEypEpgbhWmddMCO4MzzX2IbOfqv2K2klXDV5lc42DWISlmencWQltz
         LqhhEOJ9bfVLARa37Ov3eGxijku/MwfleKPMwRSHyjTPAI89Uvt3/S9VJ/hvxi62H6Qx
         1KiIKvr31LPhV0XEpYIg6yxRHDBoLfDivJyPtt/YEv3vR6WBXMOE3StYmHwOauMLwGW6
         HEMqf4EAvlGqqaB6y52VA8KaE+a4L4igEBKwo//t5WFd6FT75eyDyTk1hK/XX1BC6L30
         m65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=M9u2uZrITY2ZmiHjCgQwdtv5Ky15VkyjtQ04bHL3Xio=;
        b=hOXVUFJZT1m6MBk87S4tgqP9LWVwmI7Smt0/+EP3eRR/oqSWZRkmCqjtJ/e5w5hDhn
         ani9U2h2dWkatn7YtXEmAgO7RjYCrOFTdYdPoX3w4+zcT6w/M4GvkQEhjiF6hwfP6HUb
         60J/UvK5sTkQ+XRgubkykXTfx2v+2bg6x3+7Vwd53iUin9db3jiu6w5svN/lBh7kPN/A
         ZxnEz+cSCOJmbvj2LvGU/GS/z5+c17/DaoY25AqEmgfdV5K4bIoXnk7xOdY239yxmE7L
         jV0fqxBE2Il1PsLx9cn5xxfYbPyFn2c+jPtJ4wHH//hj/xTyDOk4gbydJiAJshtqc3YI
         ZVvQ==
X-Gm-Message-State: AJIora/NT8X5Oja7CZWVZs2i/lvBM9KJDFc+EBzSOR1/l/JC3lMpTLnC
        nsoy5dxHpBJ8SaVoH1y90ktyKuVjXLKIvT2gylcVUlieo/Po6Qr3YN8QN7icTLjr8EFs8WJnGLt
        jjG0HXIdD+9vY4tyrnvuebxkRVOZiJ4I2zyrY9U3i0AzmLGg+0CmzFAP1pJcsoZBpjuhnd6NXxD
        Km
X-Google-Smtp-Source: AGRyM1t/zJRywM18OCZjxBcOmaA2MiocqnI4Hdgc1dAqJTjLs8xD5UHnaNoj5POcyXAHy86FND9u5aItmXQA
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90a:178f:b0:1e3:3ba:c185 with SMTP id
 q15-20020a17090a178f00b001e303bac185mr47670pja.1.1655156611283; Mon, 13 Jun
 2022 14:43:31 -0700 (PDT)
Date:   Mon, 13 Jun 2022 14:43:26 -0700
Message-Id: <20220613214327.15866-1-jiangzp@google.com>
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

