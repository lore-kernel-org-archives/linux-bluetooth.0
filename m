Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED1DC04FCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 18:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjITSN5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 14:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjITSNy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 14:13:54 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B7CF;
        Wed, 20 Sep 2023 11:13:48 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79f292f0ac2so20751339f.1;
        Wed, 20 Sep 2023 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695233627; x=1695838427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1XbdgEmcO0SlJnN1RyDOHAwbdBCKSNfqwQQgVkoyPY=;
        b=jkIZORlLeh8yvR1utpc3Qm7nQ9KbsbwWMiVC3qlPm0GGHVJt163HIQn2HONt4RFXwm
         YNsguBMzxSdOL9w52DQk1dxkB5HhgDH5bsCwrhMD/YviNmZ8wSwYpD/B3Z61V+b2AuI1
         uHAEnVsDCZwCbLWzsZVtahFUpVr62ZD0SwHIkmb84lXtSv89Am4piEpcIaN+t8ZhjvdD
         3JFfMU6zb8vhmdhcgy/yk9S4CYD9AJgzSsroVaa9lcYiBijioMTkgtpoX+wWMYikwQp6
         cay0Cpx8CtjqNWYhgOWuxqMo2QyrCCh13JIA9rR+fPcJJ5ywZG2FVk57Hm+e9itJpCbT
         YNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233627; x=1695838427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1XbdgEmcO0SlJnN1RyDOHAwbdBCKSNfqwQQgVkoyPY=;
        b=f8U3/D1ve+tMYv46UmpdvkbJJpfPZwjvd5HyZbs1IOZblHr1c1NyW2V5gOLGd++IG7
         +LE04ecDZuroyEXCn9u/irHMkwMrBYHYWpVLHP/kIGc9IlG+xJ4dpNN7y04dnxrx1Su/
         JU1eRn2FqCtGZ1qPuIklfh8SgyXN5zblqpIbaRc6lhau4iQ7t/cUXupD1ic5ywIy26hp
         EzpKld56T0CGw2WbRQFhs5v2xeqOQEwOrmtXn3yuTLUJ31BdiRuDjCCHQQVAaOWWrJMM
         VKKP0qNwizDYh3obpLvqezDguIWqokKW2KoxuBJuOXa74DOSKFdREzd/krn5DZ7KkrTX
         O4VQ==
X-Gm-Message-State: AOJu0Yz4O7p+zfgtfbFBVckLeRCGGu0XRJ/MpohpTgaLb+PBcEGS7HAJ
        CdAP+z1r7ruAcK43sR4MV5ameSkXbKA=
X-Google-Smtp-Source: AGHT+IHDueg5FZ+O66xfqhMtsY1d+Q7M4m63UVoB1ydRhuv7OUWNR5dW8FNQHzELxcUDZJnf+kP5Zw==
X-Received: by 2002:a92:c54a:0:b0:34f:963e:4484 with SMTP id a10-20020a92c54a000000b0034f963e4484mr5701905ilj.12.1695233627243;
        Wed, 20 Sep 2023 11:13:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id q23-20020a02c8d7000000b0043a0d66a80csm738720jao.24.2023.09.20.11.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 11:13:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull-request: bluetooth 2023-09-20
Date:   Wed, 20 Sep 2023 11:13:44 -0700
Message-ID: <20230920181344.571274-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following changes since commit 4a0f07d71b0483cc08c03cefa7c85749e187c214:

  net/handshake: Fix memory leak in __sock_create() and sock_alloc_file() (2023-09-20 11:54:49 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-09-20

for you to fetch changes up to b938790e70540bf4f2e653dcd74b232494d06c8f:

  Bluetooth: hci_codec: Fix leaking content of local_codecs (2023-09-20 11:03:11 -0700)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
 - Fix handling of listen for ISO unicast
 - Fix build warnings
 - Fix leaking content of local_codecs
 - Add shutdown function for QCA6174
 - Delete unused hci_req_prepare_suspend() declaration
 - Fix hci_link_tx_to RCU lock usage
 - Avoid redundant authentication

----------------------------------------------------------------
Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
      Bluetooth: ISO: Fix handling of listen for unicast
      Bluetooth: hci_core: Fix build warnings
      Bluetooth: hci_codec: Fix leaking content of local_codecs

Rocky Liao (1):
      Bluetooth: btusb: add shutdown function for QCA6174

Yao Xiao (1):
      Bluetooth: Delete unused hci_req_prepare_suspend() declaration

Ying Hsu (2):
      Bluetooth: Fix hci_link_tx_to RCU lock usage
      Bluetooth: Avoid redundant authentication

 drivers/bluetooth/btusb.c        |  1 +
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 63 ++++++++++++++++++++++------------------
 net/bluetooth/hci_core.c         | 14 +++++++--
 net/bluetooth/hci_event.c        |  1 +
 net/bluetooth/hci_request.h      |  2 --
 net/bluetooth/hci_sync.c         | 14 ++++-----
 net/bluetooth/iso.c              |  9 ++++--
 8 files changed, 60 insertions(+), 46 deletions(-)
