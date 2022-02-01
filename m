Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5FCC43219
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Feb 2022 20:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiBAUEA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiBAUD7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Feb 2022 15:03:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837D5C06173D
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Feb 2022 12:03:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s9so34116938wrb.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Feb 2022 12:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkSgioWMLTkoGqDIWLCMutKn9jLySdUQ1z5vlGZxV6U=;
        b=YpXqGIV2xajDvz/AyCf84Z84DIJMY5LWHcF7m1Wl+JNx9uLVn99PhIm02pgkxdNJci
         WQUhQlO5O5TL7tKJJtepsJDxS7TpCxfoW6UjSf7tiiCtlbcon42ptbIyMUEuy+J/BTqU
         U9mtJEm9935C9ygtdwfRa1JKqjOPxCyFYBs5EYb4uf8NHp03nuJC3DW7u55CYxJbbHle
         0YmaEQYu8rGxRJbhJtHJCk9VIpR1sRsnv7jTEggIbYpQkPdXRPQ7Vk1DFtuUuWwmUQN5
         uHSW+rpsKydP6AFn5Rk4HpL0wxv7P9rzbJ7OJvv2f1bHAzGsuCu6H1rHWYDY9mXZpz77
         ZnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkSgioWMLTkoGqDIWLCMutKn9jLySdUQ1z5vlGZxV6U=;
        b=buEbEgrEwOdqgxdyOPFjeNKGDrhsnX2kRIHTgusK49tEWax5+BR9ZtSUFSEgg1xR40
         kv72AkZvH3ONmBmm4qMbMwR4yLtmrJ6oheOPJUV1p46oarPHeDpcSXUjpIh0REoIbokj
         z32+Ag/bgkSE/TEgn6BajGRlXyEqIbatE/JZUmVzMwY6c0UYmXGNdhJH2QkU6szb1ckV
         6d0XJWra0sBR6emI8tcrTGIFbu7VJYWhquTW63V9FMjzaEzi3r9YvSTUJEJPxEdbAQpa
         i1kZF6TctuswlTnIPxetHS/4H0q5jWNLGxiYdTmm7y0J0Ygc4/V6esGRa59W00PZV/tU
         kpvg==
X-Gm-Message-State: AOAM530WLBzCqkhOwP+vCqJvh2WjRo1rwgxzrvBQSfeqcFkcfBzSUePX
        LVOJj2eiAtFClX1Dj1QQQ0h/NFKeECTstg==
X-Google-Smtp-Source: ABdhPJwBVoJ+wrFxx/APcr+nBCT9totWanxEoRnTZs35TqYnQamUL6C8DYh7A9BoM5v+B7XbfZgvvg==
X-Received: by 2002:adf:e6c9:: with SMTP id y9mr23944872wrm.389.1643745836719;
        Tue, 01 Feb 2022 12:03:56 -0800 (PST)
Received: from biernacki.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id m6sm3367280wmq.6.2022.02.01.12.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 12:03:56 -0800 (PST)
From:   Radoslaw Biernacki <rad@semihalf.com>
X-Google-Original-From: Radoslaw Biernacki <rad@semihalf.ocm>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        upstream@semihalf.com, Radoslaw Biernacki <rad@semihalf.com>,
        Angela Czubak <acz@semihalf.com>,
        Marek Maslanka <mm@semihalf.com>,
        Radoslaw Biernacki <rad@semihalf.ocm>
Subject: [PATCH v2 0/2] Bluetooth: Fix skb handling in net/bluetooth/mgmt.c
Date:   Tue,  1 Feb 2022 20:03:51 +0000
Message-Id: <20220201200353.1331443-1-rad@semihalf.ocm>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Here is second version of the fix for skb handling in net/bluetooth/mgmt.c
First patch is fixing the skb allocation which theoretically might push skb
tail beyond its end.
Second patch simplifies operations on eir while using skb.
Patches adds two helper functions to eir.h to align to the goal of
eliminating the necessity of intermediary buffers, which can be achieved
with additional changes done in this spirit.

v1->v2:
 - fix mgmt_device_connected()
 - add eir_skb_put_data() - function for skb handing with eir

Radoslaw Biernacki (2):
  Bluetooth: Fix skb allocation in mgmt_remote_name() &
    mgmt_device_connected()
  Bluetooth: Improve skb handling in mgmt_device_connected()

 net/bluetooth/eir.h  | 20 ++++++++++++++++++++
 net/bluetooth/mgmt.c | 43 ++++++++++++++++---------------------------
 2 files changed, 36 insertions(+), 27 deletions(-)

-- 
2.35.0.rc2.247.g8bbb082509-goog

