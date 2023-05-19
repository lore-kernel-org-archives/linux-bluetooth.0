Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA566C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 May 2023 23:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjESXbJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 May 2023 19:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjESXbH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 May 2023 19:31:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6F1E5D;
        Fri, 19 May 2023 16:30:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d2981e3abso1600945b3a.1;
        Fri, 19 May 2023 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684539059; x=1687131059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbkE4lFs3MjTSqGjLlORxHU2UXZyNUzXu0UGRUNEtpU=;
        b=g0ZQKuiT1TNc5fYsAOR7g43ipYNMSZubKLUriSON89qtsHKgpmK1icCXLH/8xM6aaf
         fjHX0w4wrqRiuYDGUH1E/ti40MUegKCUgC/f6WyKLyqvOUgeVgJDgw/An65vE3be7Ll0
         jAq6QIoLQfjpWR7th7R5ypG/kAUuC4790T9EikAX5Da1UG6qzE51er9M3baqejVvvJXg
         gWfjXy8aSnNG+40xvAGIrMzEchX+v8i9iInHf8tCR/FYVrZAye5eEPI+D1vMhEVLlNML
         DA0/joBZLYAj9L8XbxKXUyLHZJxHbf7TKLMeK5pCLGYAN+Ok0GnMq6oPr+otHGd2bVxt
         WBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684539059; x=1687131059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbkE4lFs3MjTSqGjLlORxHU2UXZyNUzXu0UGRUNEtpU=;
        b=RA05c3vIxdbAq0ydS5B0mFs9P2UrzWMouP4Iwwp8uTCXdxGtTFjHMXh0itiVkQUP3N
         lFZlf2NsmUiVx4wSnJegDWMG7XkGUU8mRetseFt5CggKcOiw3WxA/l53xdQCjB9BgS4T
         AK0H4sg0zkeSh5SK0Ki0Ub6WF4J7ZQmDOpPXXfzHp0mnLcrE9+kFjzj7JiE9wZgYT6TH
         3SQYSt9apxu+u6JoVGaF3HA4msNbRgo+2kswB2JI4F7oGO1MpQsr9pBFv4LcMozZXQsM
         lg27dVxfCi8JF4a/uX965Q/h7JwoVI5b+pr5qAsuWuqIr6jzqIptn6MH4qy+fsJGeXRB
         sMAw==
X-Gm-Message-State: AC+VfDxcJhdod+9YaM9bqFtJdiXAntoC5aoNrn4AD9jo4xQHPjPRl7CH
        ljUYePTvlvs9ODi8M94pUn0=
X-Google-Smtp-Source: ACHHUZ7e8nf3ogsTYNesoZLMmTh9dZBLBAzRiwdD8os8pGSsolKgCtVs54sJtpiH13mPob6HFDDrag==
X-Received: by 2002:a05:6a20:8e15:b0:103:e05f:c6d2 with SMTP id y21-20020a056a208e1500b00103e05fc6d2mr3866686pzj.1.1684539058528;
        Fri, 19 May 2023 16:30:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id k25-20020a63ff19000000b00530914c3bc1sm248348pgi.21.2023.05.19.16.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 16:30:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull-request: bluetooth 2023-05-19
Date:   Fri, 19 May 2023 16:30:56 -0700
Message-Id: <20230519233056.2024340-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following changes since commit 9025944fddfed5966c8f102f1fe921ab3aee2c12:

  net: fec: add dma_wmb to ensure correct descriptor values (2023-05-19 09:17:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-05-19

for you to fetch changes up to 6ce5169e05aa5360a49a574cc1490ceea6b651a6:

  Bluetooth: btnxpuart: Fix compiler warnings (2023-05-19 15:38:29 -0700)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix compiler warnings on btnxpuart
 - Fix potential double free on hci_conn_unlink
 - Fix UAF on hci_conn_hash_flush

----------------------------------------------------------------
Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix compiler warnings

Ruihan Li (4):
      Bluetooth: Fix potential double free caused by hci_conn_unlink
      Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
      Bluetooth: Fix UAF in hci_conn_hash_flush again
      Bluetooth: Unlink CISes when LE disconnects in hci_conn_del

 drivers/bluetooth/btnxpuart.c    |  6 ++--
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 77 +++++++++++++++++++++-------------------
 3 files changed, 45 insertions(+), 40 deletions(-)
