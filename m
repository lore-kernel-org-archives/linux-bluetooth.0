Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAD3CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Oct 2023 03:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJNDNm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Oct 2023 23:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjJNDNk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Oct 2023 23:13:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3953D6;
        Fri, 13 Oct 2023 20:13:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9b95943beso23275735ad.1;
        Fri, 13 Oct 2023 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697253218; x=1697858018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ofkxnOmb7cqwZjJ5IHHNe3UaCC4MdflRYJIUEycODA=;
        b=mf7Qb1rHN3nW1AKtxfAABJMYYARGGKnK2nYwmzPNCUEmUcTElE2+D9Xl8I2M3W4PqA
         frknuMs8bGgBiiC8FwlyhiNbX+lKYQ70BvNG2aM3kfXJXMf/q09/RxHJBQ1Vc+yL4VS0
         uDpzhtwZlbXHWR/kIhsbJQYly37eahFNwEmpkHABmEXANR6w4a2q06VimecGYxQVCQdr
         uOZZ2mG2qM7apdnrQQG1yC2jhk7YD1KGw97HCfe9n3UMA43DzNivQy4e+nMTsBihSmqz
         1GNsL3wI7zaDmjiNRDBbOQ/T+k4BuzCNFdFexkV/rMf9tBJK1DLVIA/LrKbiEmGJE6/I
         wYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697253218; x=1697858018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ofkxnOmb7cqwZjJ5IHHNe3UaCC4MdflRYJIUEycODA=;
        b=Czf2WXVgdYQAFLt3X6pbTjyrTTa2Tn2Jyfv6BqnMr6DDmtQPj1RHPJNrkOSn1+TrNY
         MpyI5VBJqICEVj1mq5cWWJLnVxgLoyJLJy8bG3j6LOQF+A33iG1qj8h7wqVEKIQUSMWJ
         YrgPRsuzlEg3w7dedfhWmmcczeJiE8Op+5eUye9Iw/q8gkCbxgaQ9vG30fTnYjP9nX/n
         qBpa90PxkNKooS/XvclRPNP6amKF3QBJUWT8r3XxWYycWT7ZjaqhjkCYYygcPUP2XS6P
         oBgRdgaA3zzFv5H++OSFRZChLU1YjcX2YMpfSdq2vXZ9Qbvz9wGa44hdznLdWkCUgdgc
         G3/g==
X-Gm-Message-State: AOJu0YxDVrIlZFl+HY4Bi4V2rctlB3Z/CVxAh53/IehRCXMb+Ivx2vAC
        luJUR7e6+kCfreAk8h5JJsy2mIgbs5ey68a4csM=
X-Google-Smtp-Source: AGHT+IGzfPvW7n4zXQ/L7W7VDl+z9apG5TzXSlGDcTK6w8h/OWl5IvZCS14HavnGhFdm853zAIu4Tw==
X-Received: by 2002:a17:902:cec7:b0:1c9:9144:5740 with SMTP id d7-20020a170902cec700b001c991445740mr18656762plg.2.1697253218003;
        Fri, 13 Oct 2023 20:13:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b001c55e13bf39sm4632078plk.275.2023.10.13.20.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 20:13:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull-request: bluetooth 2023-10-13
Date:   Fri, 13 Oct 2023 20:13:36 -0700
Message-ID: <20231014031336.1664558-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following changes since commit a950a5921db450c74212327f69950ff03419483a:

  net/smc: Fix pos miscalculation in statistics (2023-10-11 10:36:35 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-10-13

for you to fetch changes up to cb3871b1cd135a6662b732fbc6b3db4afcdb4a64:

  Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name (2023-10-13 20:06:33 -0700)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix race when opening vhci device
 - Avoid memcmp() out of bounds warning
 - Correctly bounds check and pad HCI_MON_NEW_INDEX name
 - Fix using memcmp when comparing keys
 - Ignore error return for hci_devcd_register() in btrtl
 - Always check if connection is alive before deleting
 - Fix a refcnt underflow problem for hci_conn

----------------------------------------------------------------
Arkadiusz Bokowy (1):
      Bluetooth: vhci: Fix race when opening vhci device

Arnd Bergmann (1):
      Bluetooth: avoid memcmp() out of bounds warning

Edward AD (1):
      Bluetooth: hci_sock: fix slab oob read in create_monitor_event

Iulia Tanasescu (1):
      Bluetooth: ISO: Fix invalid context error

Kees Cook (1):
      Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name

Lee, Chun-Yi (2):
      Bluetooth: hci_event: Ignore NULL link key
      Bluetooth: Reject connection with the device which has same BD_ADDR

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix using memcmp when comparing keys
      Bluetooth: hci_event: Fix coding style

Max Chou (1):
      Bluetooth: btrtl: Ignore error return for hci_devcd_register()

Pauli Virtanen (1):
      Bluetooth: hci_sync: always check if connection is alive before deleting

Ziyang Xuan (1):
      Bluetooth: Fix a refcnt underflow problem for hci_conn

 drivers/bluetooth/btrtl.c       | 10 +++-------
 drivers/bluetooth/hci_vhci.c    |  3 +++
 include/net/bluetooth/hci_mon.h |  2 +-
 net/bluetooth/hci_conn.c        |  9 +++++++++
 net/bluetooth/hci_event.c       | 48 +++++++++++++++++++++++++++++++++++++++---------
 net/bluetooth/hci_sock.c        |  3 ++-
 net/bluetooth/hci_sync.c        | 26 ++++++++++++--------------
 7 files changed, 69 insertions(+), 32 deletions(-)
