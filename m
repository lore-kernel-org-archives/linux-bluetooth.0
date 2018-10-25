Return-Path: <SRS0=5QOG=NF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E429CECDE46
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 00:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED4320831
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 00:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gSqHil6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED4320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJYIwG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:52:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46695 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYIwG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Oct 2018 04:52:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id bb7-v6so2986991plb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Oct 2018 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kvGDsk1E536QwTcSPrMfemgdruUKz0tl3b/ApdZ+kw=;
        b=gSqHil6lAdBtIa51yQx0MdJF0R3JP1wauwlrvbkda0sZzTI0+jdGkis1zs1qJ7nFWW
         uWRElPCaMISugL8EjuvaUiuoGK6XgZ2NcDJxEUGJ9KwV8ekzXl1VTM0VOOfzSw/XLNKo
         5/0CB5wHSlmTr6dMcyyhEfaXx7/BmdMWNP/Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kvGDsk1E536QwTcSPrMfemgdruUKz0tl3b/ApdZ+kw=;
        b=cAwzViJq2Qz7dJPO9BAY/WmIdIqlq+V4Nw/Ysw2hkB47pPO5aSAEjqxDVwEJnQBqRw
         E0DG+P9lafxU+ZQxGl3c6Va/uV0tBduZ0/VK9xj7ZpFUwVF693z3dnnZFfyUzoFEZkI5
         kP3UOvO/5IndSadJx9Jmmi/7/7nQV/dj+2ZB42W6oSL/mG2/EEoFUn9SWVvmLXMyCxkd
         jQ61qdAZ9V6vCqobF06Nx1NVFIkFhS8k+B1KavC5Fhoxd2P0XmvTwZhCL3e2Ku7+hO+v
         x5lx1Agt16hVLkze5ZGnzzdFehJmcteAd9B+NXB82WTYGy/HBKMhJNJO1Ky5gSx0Neai
         n7UA==
X-Gm-Message-State: AGRZ1gIS4aNDv6Xp2B6ZvaC+N8Q1ytAdBIalEk55pclqvdMxyc3pPNbD
        czhBwFAKJVY/LOd6C6aAoGN3QA==
X-Google-Smtp-Source: AJdET5eYeQelNGqXEkR6MNf4EAt9P4T491yr9/imxNMvso6tacw2AUQkGP0ltg07/flZCmQbadyKWQ==
X-Received: by 2002:a17:902:32a4:: with SMTP id z33-v6mr4443182plb.85.1540426910161;
        Wed, 24 Oct 2018 17:21:50 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id w2-v6sm8410181pfk.140.2018.10.24.17.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:21:49 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/2] Add quirk for reading BD_ADDR from fwnode property
Date:   Wed, 24 Oct 2018 17:21:32 -0700
Message-Id: <20181025002134.256791-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
on the Bluetooth chip itself. One way to configure the address is
through the device tree (patched in by the bootloader). The btqcomsmd
driver is an example, it can read the address from the DT property
'local-bd-address'. It is also planned to extend the hci_qca driver
to support setting the BD address through the DT.

To avoid redundant open-coded reading of 'local-bd-address' and error
handling this series adds the quirk HCI_QUIRK_USE_BDADDR_PROPERTY to
retrieve the BD address of a device from the DT and adapts the
btqcomsmd driver to use this quirk.

Matthias Kaehlcke (2):
  Bluetooth: Add quirk for reading BD_ADDR from fwnode property
  Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY

 drivers/bluetooth/btqcomsmd.c | 28 +++--------------------
 include/net/bluetooth/hci.h   | 12 ++++++++++
 net/bluetooth/hci_core.c      | 42 +++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c          |  6 +++--
 4 files changed, 61 insertions(+), 27 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog

