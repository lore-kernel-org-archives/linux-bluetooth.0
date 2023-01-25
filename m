Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6478FC54E94
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Jan 2023 21:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjAYVMj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Jan 2023 16:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjAYVM0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Jan 2023 16:12:26 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B65E54209
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 13:12:15 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id e11-20020a17090a77cb00b0022925dd66d3so1634010pjs.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 13:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V7hcBGquDXE1ItKYAPtHX4Q2dU+QIoSg4FK+T/D54PA=;
        b=L3NS8SHVeGfpP8K/JnRDmG6rwnuTD7bUQPX9vwPg3CHqHUok3RLjFxC0zFNpqDnaeh
         Hx93o78ZU46ooMSpQw6aRrqirTJde4WdlhK4xSLWkZNygnuWtZpcF98c/y/1QUvGfyZJ
         FqsqDPg0g+TI3Lw0tnqtvMnoXN+uMo0PNhg++KqF8iThWlGYxvVHP7lsfsgp9g5TgSee
         X1abd54KYFSDbLmoglzJSriOoi7uC4RZlxo6NJCVHpj0lB8fKFZ7YExlWS5Zw4sJroSJ
         uUtTpP1jcy1TC2tsAruW+WUDLrjO+nXEaFFQmHBtofDQhyYgAUHMhtg7kb4FKjbREwOn
         Etcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7hcBGquDXE1ItKYAPtHX4Q2dU+QIoSg4FK+T/D54PA=;
        b=ek3PP5NIdxswoAB06kOGxXM44o37goKJ81U31kSXq6eZ9IkBSaVASN6/O0WX15TMHJ
         PKjmjHa582rlT+X+gOfsJ8TAtGUQi9AN0UP9Q0ibkasSHSPN8De8JR2lI1d7pUuJ3763
         i6dCc0kxAPrBVR3GG+A2Omdw3rCzXHt+uWaJ+BikYiieb/JFYUUXpD6+9VYr9OOnyk91
         fyPysQ0tN47PII0M65h9sK8HP+9J8dDLLmrnUwiZOgRwswvUZ4AGpw14nDBp1aswpt5j
         pAtK5ovFu4Cq2iQmZMJGQREeGpnjkkgfSErkPiprgzR/ms6XBpTAyIJyPMK70iUkf1BB
         n6tg==
X-Gm-Message-State: AFqh2krJJdZ0p4fK3yKwvKTmtGA5hMp4mQsPlu78wJNtkO9YXbQ8/hFo
        kMdPlaRFCw9p4CBv9bWK+c62gN++EyLcwCykol8V2hLSFzHiNndKrUuGG/tlXkQ/ornj1o/5Mip
        C79Qc9qFY4hCgU0yrQYx57AtfY9HNCXsJjjLE1LeMq87nOgDjZk4en++1I/iM2OMzMuEuvFM8rE
        Lo
X-Google-Smtp-Source: AMrXdXurpipw0Ob2XUbpzap2fmXipRkyZte6Rsax47X//HKaWpT1QbUHEQGrvK5nz9rePsp4XryFA7XgyMhb
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:e83:b0:56b:9ce2:891f with SMTP id
 bo3-20020a056a000e8300b0056b9ce2891fmr3438596pfb.43.1674681134438; Wed, 25
 Jan 2023 13:12:14 -0800 (PST)
Date:   Wed, 25 Jan 2023 13:12:09 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125211210.552679-1-jiangzp@google.com>
Subject: [kernel PATCH v1 0/1] Reason to disable adv during power off without clearing
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


This change was made to keep the same behavior as before the hci_sync
rework. When the adapter is powered off, the advertisement will be
disabled, instead of being cleared. As a result, when the adapter is powered
on, the advertisement can be re-enabled. There is no need to re-register
the same advertisement.

However, if the adv is not cleared and the user requested to remove the
adv when the adapter is off, it will trigger GPIO reset, so we will not
send the HCI command in this case.

Changes in v1:
- Mark the advertisement as disabled instead of clearing it.
- Remove the advertisement without sending HCI command if the adapter is off.

Archie Pusaka (1):
  Bluetooth: Don't send HCI commands to remove adv if adapter is off

 net/bluetooth/hci_sync.c | 57 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

-- 
2.39.1.456.gfc5497dd1b-goog

